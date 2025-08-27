Class CGIFTE.Persistent.StoreOrder Extends (%Persistent, , %XML.Adaptor)
{

Property StoreOrderId As %String(MAXLEN = "") [ InitialExpression = {$system.Util.CreateGUID()} ];

Property StoreId As %String;

Property Total As %Integer;

Property TimePlaced As %TimeStamp;

Index IndexOnStoreOrderId On StoreOrderId [ PrimaryKey ];

Storage Default
{
<Data name="StoreOrderDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>StoreOrderId</Value>
</Value>
<Value name="3">
<Value>StoreId</Value>
</Value>
<Value name="4">
<Value>Total</Value>
</Value>
<Value name="5">
<Value>TimePlaced</Value>
</Value>
</Data>
<DataLocation>^CGIFTE.Persistent.StoreOrderD</DataLocation>
<DefaultData>StoreOrderDefaultData</DefaultData>
<IdLocation>^CGIFTE.Persistent.StoreOrderD</IdLocation>
<IndexLocation>^CGIFTE.Persistent.StoreOrderI</IndexLocation>
<StreamLocation>^CGIFTE.Persistent.StoreOrderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
