/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.Internal.BulkUploadRequests Extends SC.Core.Data.TimeStampedData
{

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey, Unique ];

/// target object
Property jsonInput As %String(MAXLEN = "");

Storage Default
{
<Data name="BulkUploadRequestsDefaultData">
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
<Value>jsonInput</Value>
</Value>
<Value name="5">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Core.Da5DF8.BulkUploadR8647D</DataLocation>
<DefaultData>BulkUploadRequestsDefaultData</DefaultData>
<IdLocation>^SC.Core.Da5DF8.BulkUploadR8647D</IdLocation>
<IndexLocation>^SC.Core.Da5DF8.BulkUploadR8647I</IndexLocation>
<StreamLocation>^SC.Core.Da5DF8.BulkUploadR8647S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
