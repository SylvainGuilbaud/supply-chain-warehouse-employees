/*
Copyright (c) 2024 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// ShipmentStop object can be used to store information regarding shipment stops
/// like origin, destination of the shipment, in between stops. 
Class SC.Data.ShipmentStop Extends SC.Core.Data.ShipmentStop
{

Storage Default
{
<Data name="ShipmentStopDefaultData">
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
<Value>name</Value>
</Value>
<Value name="7">
<Value>stopType</Value>
</Value>
<Value name="8">
<Value>locationId</Value>
</Value>
<Value name="9">
<Value>earliestDateTime</Value>
</Value>
<Value name="10">
<Value>latestDateTime</Value>
</Value>
<Value name="11">
<Value>geofence</Value>
</Value>
<Value name="12">
<Value>geofenceUnit</Value>
</Value>
<Value name="13">
<Value>stopNumber</Value>
</Value>
<Value name="14">
<Value>notes</Value>
</Value>
<Value name="15">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.ShipmentStopD</DataLocation>
<DefaultData>ShipmentStopDefaultData</DefaultData>
<IdLocation>^SC.Data.ShipmentStopD</IdLocation>
<IndexLocation>^SC.Data.ShipmentStopI</IndexLocation>
<StreamLocation>^SC.Data.ShipmentStopS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
