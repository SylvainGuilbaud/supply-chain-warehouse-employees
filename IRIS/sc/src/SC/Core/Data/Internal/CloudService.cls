/*
Copyright (c) 2024 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// CloudService object is used to store information regarding the cloud services
/// like name of the service, valid from and to, URL, and service limit
/// This has all the information regarding the cloud services that are active also the 
/// cloud services that were active in the past
Class SC.Core.Data.Internal.CloudService Extends (%Persistent, SC.Core.Data.TimeStampedData)
{

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// name
Property name As %String(MAXLEN = 256);

/// url
Property url As %String(MAXLEN = 256);

/// valid from
Property validFrom As %Date;

/// valid to
Property validTo As %Date;

/// active
Property active As %Integer;

/// service limit
Property serviceLimit As %Numeric;

/// contact Email
Property contactEmail As %String(MAXLEN = 256);

/// Type of the service
Property serviceType As %String(MAXLEN = 256);

/// Unit of Measure for the service limit
Property serviceLimitUOM As %String(MAXLEN = 256);

/// Username for API communication
Property apiUsername As %String(MAXLEN = 256);

/// Password for API communication
Property apiPassword As %String(MAXLEN = 256);

/// Version number of the cloud service 
Property versionNumber As %String(MAXLEN = 50);

Storage Default
{
<Data name="CloudServiceDefaultData">
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
<Value>name</Value>
</Value>
<Value name="5">
<Value>url</Value>
</Value>
<Value name="6">
<Value>validFrom</Value>
</Value>
<Value name="7">
<Value>validTo</Value>
</Value>
<Value name="8">
<Value>active</Value>
</Value>
<Value name="9">
<Value>serviceLimit</Value>
</Value>
<Value name="10">
<Value>contactEmail</Value>
</Value>
<Value name="11">
<Value>serviceType</Value>
</Value>
<Value name="12">
<Value>serviceLimitUOM</Value>
</Value>
<Value name="13">
<Value>apiUsername</Value>
</Value>
<Value name="14">
<Value>apiPassword</Value>
</Value>
<Value name="15">
<Value>versionNumber</Value>
</Value>
<Value name="16">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Core.Data5DF8.CloudServiceD</DataLocation>
<DefaultData>CloudServiceDefaultData</DefaultData>
<IdLocation>^SC.Core.Data5DF8.CloudServiceD</IdLocation>
<IndexLocation>^SC.Core.Data5DF8.CloudServiceI</IndexLocation>
<StreamLocation>^SC.Core.Data5DF8.CloudServiceS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
