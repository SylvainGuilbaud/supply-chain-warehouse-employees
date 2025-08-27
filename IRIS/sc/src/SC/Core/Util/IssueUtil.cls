/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Util.IssueUtil
{

/// Run issue analysis for a given issue. If an additional processName parameter is provided,
/// run that process instead of the default process defined in the issue object. 
ClassMethod runIssueAnalysis(issueId As %String, processName As %String = "") As %Status
{
    if issueId = "" { return $$$ERROR("No issueId specified") }
    set issue = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("Issue", issueId)
    // set issue = ##class(SC.Core.Data.Internal.Issue).%OpenId(issueId)
    if issue = "" { return $$$ERROR("Invalid issueId ["_issueId_"] specified") }

    set targetProcess = processName
    if processName = "" {
        // Use process defined in the issue if none is provided in the method argument
        set targetProcess = issue.processName
    }

    if targetProcess = "" { return $$$ERROR("No process defined in the issue.") }
    
    if issue.status = issue.#STATUSWORKFLOW {
        // The current issue status is waiting for workflow response, Clean up the workflow first:
        do ##class(SC.Core.API.KPI.IssueApiImpl).terminateWorkflow(issue)
    }


    // Start to invoke the service to run the analysis
    set st = $$$OK
    SET service = ##class(Ens.Director).CreateBusinessService("SC.Core.BP.Service.SingleIssueBS",.tService)
    set tRequest = ##class(SC.Core.BP.Message.IssueAnalysisRequest).%New()
    set tRequest.issueId = issueId
    set tRequest.targetProcess = targetProcess
    set st = tService.ProcessInput(tRequest)

    return st
}

ClassMethod completeIssueWorkflow(issue As SC.Data.Issue, optionNumber As %String) As %Status
{
    set st = $$$OK
    set taskId = ##class(SC.Core.Util.IssueUtil).getWorkflowId(issue)
    Set task = ##class(EnsLib.Workflow.TaskResponse).%OpenId(taskId)
    Set st = ##class(EnsLib.Workflow.Engine).CompleteTask(task, optionNumber)

    return st
}

/// construct JSON for all issues related to an object. Return "" if no issue associated with the object
ClassMethod constructJsonForObjectIssue(objName As %String, uid As %String) As %DynamicArray
{
    Set ret = ""
    set issues = ..getIssuesForObject(objName, uid)
    if (issues '= "") && (issues.Count() > 0 ) {
        set ret = []
        for i=1:1:issues.Count() {
            set iss = issues.GetAt(i)
            set json = ..convertIssueToJson(iss)
            do ret.%Push(json)
        }
    }
    Return ret
}

/// Returns issues associated with an object instance
ClassMethod getIssuesForObject(objName As %String, uid As %String) As %ListOfObjects
{
    Set ret = ""
    if (objName '= "") && (uid'="") {
        set ret = ##class(%ListOfObjects).%New()
        set tablename = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName("Issue")
        set sql="select ID from "_tablename_" where impactedObjectType = ? and impactedObjectId = ? "
        set rs = ##class(%SQL.Statement).%ExecDirect(,sql, objName, uid)
        if rs.%SQLCODE < 0 {
            $$$ThrowStatus($$$ERROR($$$SQLCode,rs.SQLCODE,rs.%Message))
        }
        if ( rs.%SQLCODE = 0 ) {
            while ( rs.%Next() '= 0 ) {
                set iid = rs.%Get("ID")
                set issue =  ##class(SC.Data.Issue).%OpenId(iid)
                do ret.Insert(issue)
            }
        }
    }
    Return ret
}

/// render an issue object to JSON, without analysis data
ClassMethod convertIssueToJson(issue As SC.Core.Data.Internal.Issue) As %DynamicObject
{
    Set ret = ""
    if issue '= "" {
        do issue.%JSONExportToString(.jsonString)
        set rawIssue = ##class(%DynamicAbstractObject).%FromJSON(.jsonString)
        set ret = {"ID": (issue.%Id())}
        set i = rawIssue.%GetIterator()
        while i.%GetNext(.key, .value) {
            do ret.%Set(key, value)
        }
    }
    Return ret
}

// Get the workflow id given an issueID

ClassMethod getWorkflowId(issue As SC.Data.Issue) As %Integer
{
    set analysis = issue.getLatestAnalysis()
    set workflowId = analysis.workflowId
    return workflowId
}

}
