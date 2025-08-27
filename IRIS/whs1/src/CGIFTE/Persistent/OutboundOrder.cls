Class CGIFTE.Persistent.OutboundOrder Extends %Persistent
{

Property OutboundOrderId As %String(MAXLEN = "") [ InitialExpression = {$system.Util.CreateGUID()} ];

Property StoreOrderId As %String(MAXLEN = "");

ForeignKey StoreOrderIdKey(StoreOrderId) References CGIFTE.Persistent.StoreOrder(IndexOnStoreOrderId) [ OnDelete = cascade ];

Property ItemsInOrder As %Integer;

Property StartTime As %TimeStamp;

Property Processed As %Boolean;

Index IndexOnOutboundOrderId On OutboundOrderId [ PrimaryKey ];

Index IndexOnProcessed On Processed;

Storage Default
{
<Data name="OutboundOrderDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>OutboundOrderId</Value>
</Value>
<Value name="3">
<Value>StoreOrderId</Value>
</Value>
<Value name="4">
<Value>ItemsInOrder</Value>
</Value>
<Value name="5">
<Value>StartTime</Value>
</Value>
<Value name="6">
<Value>Processed</Value>
</Value>
</Data>
<DataLocation>^CGIFTE.PersiEA5B.OutboundOrderD</DataLocation>
<DefaultData>OutboundOrderDefaultData</DefaultData>
<IdLocation>^CGIFTE.PersiEA5B.OutboundOrderD</IdLocation>
<IndexLocation>^CGIFTE.PersiEA5B.OutboundOrderI</IndexLocation>
<StreamLocation>^CGIFTE.PersiEA5B.OutboundOrderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
