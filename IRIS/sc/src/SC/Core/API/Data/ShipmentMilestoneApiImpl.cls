/*
Copyright (c) 2024 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.ShipmentMilestoneApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "ShipmentMilestone";

/// Default sorting attribute
Parameter DEFAULTSORTING = "shipmentId";

ClassMethod GetShipmentMilestones() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetShipmentMilestoneById(shipmentMilestoneId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, shipmentMilestoneId)
}

ClassMethod CreateShipmentMilestone(body As %DynamicObject) As %DynamicObject
{
    return ..ObjectCreate(..#OBJECTNAME, body)
}

ClassMethod DeleteShipmentMilestone(shipmentMilestoneId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, shipmentMilestoneId)
}

ClassMethod UpdateShipmentMilestone(shipmentMilestoneId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, shipmentMilestoneId, body)
}

}
