/*
Copyright (c) 2024 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.ShipmentStopApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "ShipmentStop";

/// Default sorting attribute
Parameter DEFAULTSORTING = "shipmentId";

ClassMethod GetShipmentStops() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetShipmentStopById(shipmentStopId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, shipmentStopId)
}

ClassMethod CreateShipmentStop(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteShipmentStop(shipmentStopId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, shipmentStopId)
}

ClassMethod UpdateShipmentStop(shipmentStopId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, shipmentStopId, body)
}

}
