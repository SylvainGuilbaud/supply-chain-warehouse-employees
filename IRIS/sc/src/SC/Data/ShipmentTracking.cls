/*
Copyright (c) 2024 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// ShipmentTracking object is used to store shipment tracking information
/// like ETA, shipment status and messages from tracking service provider, latest location, etc.
Class SC.Data.ShipmentTracking Extends SC.Core.Data.ShipmentTracking
{

Storage Default
{
<Data name="ShipmentTrackingDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>recordCreatedTime</Value>
</Value>
<Value name="3">
<Value>lastUpdatedTime</Value>
</Value>
<Value name="4">
<Value>shipmentId</Value>
</Value>
<Value name="5">
<Value>shipmentType</Value>
</Value>
<Value name="6">
<Value>latestLocationId</Value>
</Value>
<Value name="7">
<Value>trackingServiceProvider</Value>
</Value>
<Value name="8">
<Value>trackingServiceOrderId</Value>
</Value>
<Value name="9">
<Value>trackingServiceRequestId</Value>
</Value>
<Value name="10">
<Value>trackingServiceStatus</Value>
</Value>
<Value name="11">
<Value>trackingServiceLastUpdatedTimeUTC</Value>
</Value>
<Value name="12">
<Value>trackingServiceLastUpdatedTimeLocal</Value>
</Value>
<Value name="13">
<Value>trackingServiceShipmentStatus</Value>
</Value>
<Value name="14">
<Value>trackingServiceShipmentMessage</Value>
</Value>
<Value name="15">
<Value>etaDateTimeUTC</Value>
</Value>
<Value name="16">
<Value>etaDateTimeLocalTime</Value>
</Value>
<Value name="17">
<Value>unLocode</Value>
</Value>
<Value name="18">
<Value>uncertainty</Value>
</Value>
<Value name="19">
<Value>datasource</Value>
</Value>
<Value name="20">
<Value>locator</Value>
</Value>
<Value name="21">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.ShipmentTrackingD</DataLocation>
<DefaultData>ShipmentTrackingDefaultData</DefaultData>
<IdLocation>^SC.Data.ShipmentTrackingD</IdLocation>
<IndexLocation>^SC.Data.ShipmentTrackingI</IndexLocation>
<StreamLocation>^SC.Data.ShipmentTrackingS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
