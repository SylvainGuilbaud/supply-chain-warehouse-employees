/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.Internal.BulkUploadDetails Extends SC.Core.Data.TimeStampedData
{

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey, Unique ];

Property fileType As %String(MAXLEN = 128);

Property tableName As %String(MAXLEN = 128);

Property uploadType As %String(MAXLEN = 128);

Property mappingType As %String(MAXLEN = 128);

Property attributeList As %String(MAXLEN = "");

Property idList As %String(MAXLEN = "");

Property fileAddr As %String(MAXLEN = "");

Property formatList As %String(MAXLEN = "");

Property dateTimeList As %String(MAXLEN = "");

Property receivedTime As %DateTime;

Property defaultTimezone As %String(MAXLEN = "");

Property delimiter As %String(MAXLEN = 128);

Property hasHeaderRow As %String(MAXLEN = 128);

Property mappingTypeList As %String(MAXLEN = "");

Property defaultValueList As %String(MAXLEN = "");

Property delimiterList As %String(MAXLEN = "");

Property transformationList As %String(MAXLEN = "");

Property indexList As %String(MAXLEN = "");

Property uidAutoGeneration As %String(MAXLEN = 128);

Storage Default
{
<Data name="BulkUploadDetailsDefaultData">
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
<Value>fileType</Value>
</Value>
<Value name="5">
<Value>tableName</Value>
</Value>
<Value name="6">
<Value>uploadType</Value>
</Value>
<Value name="7">
<Value>mappingType</Value>
</Value>
<Value name="8">
<Value>attributeList</Value>
</Value>
<Value name="9">
<Value>idList</Value>
</Value>
<Value name="10">
<Value>fileAddr</Value>
</Value>
<Value name="11">
<Value>formatList</Value>
</Value>
<Value name="12">
<Value>dateTimeList</Value>
</Value>
<Value name="13">
<Value>receivedTime</Value>
</Value>
<Value name="14">
<Value>defaultTimezone</Value>
</Value>
<Value name="15">
<Value>delimiter</Value>
</Value>
<Value name="16">
<Value>hasHeaderRow</Value>
</Value>
<Value name="17">
<Value>mappingTypeList</Value>
</Value>
<Value name="18">
<Value>defaultValueList</Value>
</Value>
<Value name="19">
<Value>delimiterList</Value>
</Value>
<Value name="20">
<Value>transformationList</Value>
</Value>
<Value name="21">
<Value>indexList</Value>
</Value>
<Value name="22">
<Value>uidAutoGeneration</Value>
</Value>
<Value name="23">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Core.Da5DF8.BulkUploadDC6B3D</DataLocation>
<DefaultData>BulkUploadDetailsDefaultData</DefaultData>
<IdLocation>^SC.Core.Da5DF8.BulkUploadDC6B3D</IdLocation>
<IndexLocation>^SC.Core.Da5DF8.BulkUploadDC6B3I</IndexLocation>
<StreamLocation>^SC.Core.Da5DF8.BulkUploadDC6B3S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
