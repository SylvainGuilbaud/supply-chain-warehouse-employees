/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.Internal.BulkUpload Extends SC.Core.Data.TimeStampedData
{

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey, Unique ];

/// target object
Property targetObject As %String(MAXLEN = 128);

/// upload type
Property uploadType As %String(VALUELIST = " update insert upsert");

/// status
Property status As %String(MAXLEN = 128);

/// fileName
Property fileName As %String(MAXLEN = 1024);

/// total records
Property totalRecords As %Numeric;

/// records created
Property recordsCreated As %Numeric;

/// records updated
Property recordsUpdated As %Numeric;

/// failed records
Property failedRecords As %Numeric;

/// Time the records start processing
Property startTime As %DateTime;

/// Time the record last updated
Property finishedTime As %DateTime;

/// Received time
Property receivedTime As %DateTime;

/// Error if record failed
Property errorMessage As %String(MAXLEN = "");

/// Execution priority
Property priority As %String(DISPLAYLIST = " high medium low", VALUELIST = " 1 2 3");

Storage Default
{
<Data name="BulkUploadDefaultData">
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
<Value>targetObject</Value>
</Value>
<Value name="5">
<Value>uploadType</Value>
</Value>
<Value name="6">
<Value>status</Value>
</Value>
<Value name="7">
<Value>fileName</Value>
</Value>
<Value name="8">
<Value>totalRecords</Value>
</Value>
<Value name="9">
<Value>recordsCreated</Value>
</Value>
<Value name="10">
<Value>recordsUpdated</Value>
</Value>
<Value name="11">
<Value>failedRecords</Value>
</Value>
<Value name="12">
<Value>startTime</Value>
</Value>
<Value name="13">
<Value>finishedTime</Value>
</Value>
<Value name="14">
<Value>receivedTime</Value>
</Value>
<Value name="15">
<Value>errorMessage</Value>
</Value>
<Value name="16">
<Value>priority</Value>
</Value>
<Value name="17">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Core.Data.In5DF8.BulkUploadD</DataLocation>
<DefaultData>BulkUploadDefaultData</DefaultData>
<IdLocation>^SC.Core.Data.In5DF8.BulkUploadD</IdLocation>
<IndexLocation>^SC.Core.Data.In5DF8.BulkUploadI</IndexLocation>
<StreamLocation>^SC.Core.Data.In5DF8.BulkUploadS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
