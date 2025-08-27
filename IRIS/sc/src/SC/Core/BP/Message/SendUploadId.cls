/// Send a message with the uploadId
Class SC.Core.BP.Message.SendUploadId Extends Ens.Request
{

Property UploadId As %String;

Storage Default
{
<Data name="SendUploadIdDefaultData">
<Subscript>"SendUploadId"</Subscript>
<Value name="1">
<Value>UploadId</Value>
</Value>
</Data>
<DefaultData>SendUploadIdDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
