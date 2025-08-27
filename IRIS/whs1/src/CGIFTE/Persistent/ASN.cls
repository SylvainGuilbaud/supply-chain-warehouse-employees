Class CGIFTE.Persistent.ASN Extends (%Persistent, , %XML.Adaptor)
{

Property ASNId As %String(MAXLEN = "") [ InitialExpression = {$system.Util.CreateGUID()} ];

Property InboundOrderId As %String;

ForeignKey InboundOrderIdKey(InboundOrderId) References CGIFTE.Persistent.InboundOrder(IndexOnInboundOrderId) [ OnDelete = cascade ];

Property ItemsInOrder As %Integer;

Property ArrivalTime As %TimeStamp;

Property Processed As %Boolean;

Index IndexOnASNId On ASNId [ PrimaryKey ];

Index IndexOnProcessed On Processed;

Storage Default
{
<Data name="ASNDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>ASNId</Value>
</Value>
<Value name="3">
<Value>SupplierId</Value>
</Value>
<Value name="4">
<Value>Total</Value>
</Value>
<Value name="5">
<Value>TimePlaced</Value>
</Value>
<Value name="6">
<Value>InboundOrderId</Value>
</Value>
<Value name="7">
<Value>ItemsInOrder</Value>
</Value>
<Value name="8">
<Value>ArrivalTime</Value>
</Value>
<Value name="9">
<Value>Processed</Value>
</Value>
</Data>
<DataLocation>^CGIFTE.Persistent.ASND</DataLocation>
<DefaultData>ASNDefaultData</DefaultData>
<IdLocation>^CGIFTE.Persistent.ASND</IdLocation>
<IndexLocation>^CGIFTE.Persistent.ASNI</IndexLocation>
<StreamLocation>^CGIFTE.Persistent.ASNS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
