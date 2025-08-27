/*
Copyright (c) 2024 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.ShipmentTrackingApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "ShipmentTracking";

/// Default sorting attribute
Parameter DEFAULTSORTING = "shipmentId";

Parameter SUPPLYSHIPMENTTYPE = "supply";

ClassMethod GetShipmentTrackings() As %DynamicObject
{
    return ..ObjectGetAll(..#OBJECTNAME, ..#DEFAULTSORTING)
}

ClassMethod GetShipmentTrackingById(shipmentTrackingId As %String) As %DynamicObject
{
    return ..ObjectGetByUid(..#OBJECTNAME, shipmentTrackingId)
}

ClassMethod CreateShipmentTracking(body As %DynamicObject) As %DynamicObject
{
    try {
        tstart
        set returnObj = ..ObjectCreate(..#OBJECTNAME, body)

        set shipmentId = body.%Get("shipmentId", ,"string")
        set shipmentType = body.%Get("shipmentType", ,"string")

        if (shipmentType = ..#SUPPLYSHIPMENTTYPE) {
            set sql = "update SC_Data.SupplyShipment set trackingStatus = 'Created', statusMessage = '' where uid = '"_shipmentId_"'"
        } else {
            set sql = "update SC_Data.SalesShipment set trackingStatus = 'Created', statusMessage = '' where uid = '"_shipmentId_"'"
        }
        set tStatement = ##class(%SQL.Statement).%New()
        set qStatus = tStatement.%Prepare(sql)
        if qStatus'=1 {
            do ..%SetStatusCode("500")
            return {"Message": ("Improper sql statement to update shipment object")} 
        }
        set rset = tStatement.%Execute()
        if rset.%SQLCODE<0 {
            do ..%SetStatusCode("500")
            return {"Message": ("Unable to update shipment object")} 
        }
        tcommit
        return returnObj
    }
    catch e {
        trollback 1
		set sc = e.AsStatus()
        return {"Message": ($System.Status.GetErrorText(sc))}
    }
}

ClassMethod DeleteShipmentTracking(shipmentTrackingId As %String) As %DynamicObject
{
    return ..ObjectDelete(..#OBJECTNAME, shipmentTrackingId)
}

ClassMethod UpdateShipmentTracking(shipmentTrackingId As %String, body As %DynamicObject) As %DynamicObject
{
    return ..ObjectUpdate(..#OBJECTNAME, shipmentTrackingId, body)
}

}
