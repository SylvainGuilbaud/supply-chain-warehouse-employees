/*
Copyright (c) 2024 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.ServiceSLAImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "ServiceSLA";

/// Default sorting attribute
Parameter DEFAULTSORTING = "serviceId";

ClassMethod GetServiceSLAs() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetServiceSLAById(serviceSLAId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, serviceSLAId)
}

ClassMethod CreateServiceSLA(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteServiceSLA(serviceSLAId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, serviceSLAId)
}

ClassMethod UpdateServiceSLA(serviceSLAId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, serviceSLAId, body)
}

}
