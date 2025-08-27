/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.Internal.BulkUploadErrors Extends SC.Core.Data.TimeStampedData
{

/// upload ID
Property uid As %String(MAXLEN = 256);

/// line number of the error
Property lineNumber As %String(MAXLEN = 128);

/// error message
Property errorMessage As %String(MAXLEN = 128);

/// line contents
Property lineDetails As %String(MAXLEN = "");

Storage Default
{
<Data name="BulkUploadErrorsDefaultData">
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
<Value>errorMessage</Value>
</Value>
<Value name="5">
<Value>lineDetails</Value>
</Value>
<Value name="6">
<Value>lineNumber</Value>
</Value>
<Value name="7">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Core.Da5DF8.BulkUploadE1324D</DataLocation>
<DefaultData>BulkUploadErrorsDefaultData</DefaultData>
<IdLocation>^SC.Core.Da5DF8.BulkUploadE1324D</IdLocation>
<IndexLocation>^SC.Core.Da5DF8.BulkUploadE1324I</IndexLocation>
<StreamLocation>^SC.Core.Da5DF8.BulkUploadE1324S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
