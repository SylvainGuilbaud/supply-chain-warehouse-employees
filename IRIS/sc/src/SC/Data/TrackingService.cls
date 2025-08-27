/*
Copyright (c) 2024 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// TrackingService object is used to store tracking service provider information
/// like tracking service provider name, all the configurable parameters and 
/// paramters based on the contract from tracking service provider
Class SC.Data.TrackingService Extends SC.Core.Data.TrackingService
{

Storage Default
{
<Data name="TrackingServiceDefaultData">
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
<Value>serviceProviderId</Value>
</Value>
<Value name="5">
<Value>stopSequencingRequired</Value>
</Value>
<Value name="6">
<Value>maximumAllowableDrivingHoursPerDay</Value>
</Value>
<Value name="7">
<Value>trackingServiceProvider</Value>
</Value>
<Value name="8">
<Value>startDate</Value>
</Value>
<Value name="9">
<Value>endDate</Value>
</Value>
<Value name="10">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.TrackingServiceD</DataLocation>
<DefaultData>TrackingServiceDefaultData</DefaultData>
<IdLocation>^SC.Data.TrackingServiceD</IdLocation>
<IndexLocation>^SC.Data.TrackingServiceI</IndexLocation>
<StreamLocation>^SC.Data.TrackingServiceS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
