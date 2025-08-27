/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.IssueApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "Issue";

/// Default sorting attribute
Parameter DEFAULTSORTING = "-recordCreatedTime";

ClassMethod GetIssues() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetIssueById(issueId As %String) As %DynamicObject
{
    // return ..ObjectGetByUid(..#OBJECTNAME, issueId)
    try { 
        set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(..#OBJECTNAME)
        set exists = $CLASSMETHOD(classname,"uidIndexExists", issueId)
        if exists = 0 {
		    do ..%SetStatusCode("404")
		    return {"Status": "Failed", 
                    "Message": ("No "_..#OBJECTNAME_" with uid ["_issueId_"] was found.")}            
        }
        set issue = $CLASSMETHOD(classname,"uidIndexOpen", issueId)
        do issue.%JSONExportToString(.jsonString)
        set rawIssue = ##class(%DynamicAbstractObject).%FromJSON(.jsonString)
        set retObj = {"ID": (issue.%Id())}
        set i = rawIssue.%GetIterator()
        while i.%GetNext(.key, .value) {
            do retObj.%Set(key, value)
        }
        set ana = issue.getLatestAnalysis()
        if ana '= "" {
            do ana.%JSONExportToString(.anaString)
            set anaObj =  ##class(%DynamicAbstractObject).%FromJSON(.anaString)
            do retObj.%Set("latestAnalysis", anaObj)
        }
        return retObj
	} catch (ex) {
		do ..%SetStatusCode("500")
		return {"Status": "Error", 
                "Message": ("Failed to retrieve issue with uid ["_issueId_"]. ")}
	}
}

ClassMethod CreateIssue(body As %DynamicObject) As %DynamicObject
{
    // Verify the object exists
    try{
        set objectName = body.%Get("impactedObjectType")
        set uid = body.%Get("impactedObjectId")

        set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(objectName)
        set exists = $CLASSMETHOD(classname,"uidIndexExists", uid)
        if exists = 0 {
            do ..%SetStatusCode("404")
            return {"Status": "Failed", 
                    "Message": ("No "_objectName_" with uid ["_uid_"] was found.")}            
        }
    }
    catch{
        do ..%SetStatusCode("404")
        return {"Status": "Failed", 
                "Message": ("Unable to find "_objectName_" with uid ["_uid_"]")}    
    }
    set message = ""
    // Verify process exists 
    set processName = body.%Get("processName")
    if processName '= ""{
        if '##class(Ens.Director).IsItemEnabled(processName){
            set message = "Specified business process, "_processName_" is not active in the running production."
        }
    }

    set output =  ..ObjectCreate(..#OBJECTNAME, body)
    if message '=""{
        if $IsObject(output){
            do output.%Set("Warning", message)
        }
        else{
            set outputJson = ##class(%DynamicObject).%FromJSON(output)
            do outputJson.%Set("Warning", message)
            set output = outputJson.%ToJSON()
        }
    }
    return output
}

ClassMethod DeleteIssue(issueId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, issueId)
}

ClassMethod UpdateIssue(issueId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, issueId, body)
}

}
