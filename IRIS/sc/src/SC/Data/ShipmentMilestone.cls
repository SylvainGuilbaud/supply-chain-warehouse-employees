/*
Copyright (c) 2024 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// ShipmentMilestone object can be used to store any kind of milestones regarding shipments
/// like shipment arrived, shipment left destinantion, in between stops milestones, etc.
Class SC.Data.ShipmentMilestone Extends SC.Core.Data.ShipmentMilestone
{

Storage Default
{
<Data name="ShipmentMilestoneDefaultData">
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
<Value>stopId</Value>
</Value>
<Value name="5">
<Value>milestone</Value>
</Value>
<Value name="6">
<Value>estimatedTime</Value>
</Value>
<Value name="7">
<Value>estimatedTimeLocal</Value>
</Value>
<Value name="8">
<Value>distanceToStop</Value>
</Value>
<Value name="9">
<Value>distanceToStopUnit</Value>
</Value>
<Value name="10">
<Value>lastUpdatedTimeUTC</Value>
</Value>
<Value name="11">
<Value>lastUpdatedTimeLocal</Value>
</Value>
<Value name="12">
<Value>unLocode</Value>
</Value>
<Value name="13">
<Value>stopType</Value>
</Value>
<Value name="14">
<Value>statusCode</Value>
</Value>
<Value name="15">
<Value>updatedBy</Value>
</Value>
<Value name="16">
<Value>shipmentId</Value>
</Value>
<Value name="17">
<Value>shipmentType</Value>
</Value>
<Value name="18">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.ShipmentMilestoneD</DataLocation>
<DefaultData>ShipmentMilestoneDefaultData</DefaultData>
<IdLocation>^SC.Data.ShipmentMilestoneD</IdLocation>
<IndexLocation>^SC.Data.ShipmentMilestoneI</IndexLocation>
<StreamLocation>^SC.Data.ShipmentMilestoneS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
