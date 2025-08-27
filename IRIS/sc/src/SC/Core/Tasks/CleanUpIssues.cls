/*
Copyright (c) 2025 by InterSystems Corporation.
Boston, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Tasks.CleanUpIssues Extends %SYS.Task.Definition
{

Parameter TaskName = "CleanUpIssues";

Method OnTask() As %Status
{
    // Change this query to select all that have status workflow
    set myquery = "select IssueAnalysis.ID as analysisId, IssueAnalysis.workflowId, IssueAnalysis.status, IssueAnalysis.issueId as issueId, TaskResponse.%action as action, TaskResponse.Id FROM SC_Core_Data_Internal.IssueAnalysis as IssueAnalysis inner join EnsLib_Workflow.TaskResponse as TaskResponse on IssueAnalysis.workflowId = TaskResponse.id WHERE not TaskResponse.%action is Null and IssueAnalysis.status = 'workflow'"
    set tStatement = ##class(%SQL.Statement).%New()
    set qStatus = tStatement.%Prepare(myquery)
    if qStatus'=1 {write "%Prepare failed:" do $System.Status.DisplayError(qStatus) Quit:qStatus}
    set rset = tStatement.%Execute()
    if rset.%SQLCODE < 0 return $$$ERROR($$$SQLCode,rset.SQLCODE,rset.%Message)
    set retValue = $$$OK
    while rset.%Next()
    {
        set issueId = rset.%Get("issueId")
        set analysisId = rset.%Get("analysisId")
        set action = rset.%Get("action")

        set issue = ##class(SC.Data.Issue).%OpenId(issueId)
        set analysis = ##class(SC.Core.Data.Internal.IssueAnalysis).%OpenId(analysisId)

        if action = "Cancelled" {
            set analysis.resolution = analysis.#RESOLUTIONNOACTION
            set analysis.status = analysis.#STATUSTERMINATED
            do analysis.%Save()
        }
        else{
            set issue.resolutionNote = "Issue closed through workflow ui with option "_action
            set issue.resolutionType = issue.#RESOLUTIONBPL
            set issue.status = issue.#STATUSCLOSED
            do issue.%Save()

            set analysis.resolution = analysis.#RESOLUTIONWORKFLOW
            set analysis.status = analysis.#STATUSCOMPLETED
            set analysis.actionTaken = action
            do analysis.%Save()
        }

    }

    return retValue
}

}
