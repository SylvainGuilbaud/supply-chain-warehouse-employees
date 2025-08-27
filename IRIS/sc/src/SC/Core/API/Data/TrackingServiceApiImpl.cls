/*
Copyright (c) 2024 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.TrackingServiceApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "TrackingService";

/// Default sorting attribute
Parameter DEFAULTSORTING = "uid";

ClassMethod GetTrackingServices() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetTrackingServiceById(trackingServiceId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, trackingServiceId)
}

ClassMethod CreateTrackingService(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteTrackingService(trackingServiceId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, trackingServiceId)
}

ClassMethod UpdateTrackingService(trackingServiceId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, trackingServiceId, body)
}

}
