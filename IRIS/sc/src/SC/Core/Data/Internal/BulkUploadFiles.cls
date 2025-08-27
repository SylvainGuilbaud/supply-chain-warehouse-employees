Class SC.Core.Data.Internal.BulkUploadFiles Extends (%Persistent, %JSON.Adaptor)
{

Property uidDetails As %String(MAXLEN = 256);

Index uidIndex On uidDetails [ PrimaryKey, Unique ];

Property status As %String(MAXLEN = 128);

Storage Default
{
<Data name="BulkUploadFilesDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>uidDetails</Value>
</Value>
<Value name="3">
<Value>status</Value>
</Value>
</Data>
<DataLocation>^SC.Core.Da5DF8.BulkUploadF26ACD</DataLocation>
<DefaultData>BulkUploadFilesDefaultData</DefaultData>
<IdLocation>^SC.Core.Da5DF8.BulkUploadF26ACD</IdLocation>
<IndexLocation>^SC.Core.Da5DF8.BulkUploadF26ACI</IndexLocation>
<StreamLocation>^SC.Core.Da5DF8.BulkUploadF26ACS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
