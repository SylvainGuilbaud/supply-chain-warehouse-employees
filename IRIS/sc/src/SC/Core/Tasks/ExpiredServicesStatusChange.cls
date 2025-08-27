/*
Copyright (c) 2024 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Tasks.ExpiredServicesStatusChange Extends %SYS.Task.Definition
{

Parameter TaskName = "ExpiredServicesStatusChange";

Method OnTask() As %Status
{
    set myquery = "update sc_core_data_internal.cloudservice set active = 0 where validTo < Now()"
    set tStatement = ##class(%SQL.Statement).%New()
    set qStatus = tStatement.%Prepare(myquery)
    if qStatus'= 1 {write "%Prepare failed:" do $System.Status.DisplayError(qStatus) Quit:qStatus}
    set rset = tStatement.%Execute()
    if rset.%SQLCODE < 0 return $$$ERROR($$$SQLCode,rset.SQLCODE,rset.%Message)
    set retValue = $$$OK
    return retValue
}

}
