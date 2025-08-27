Class CGIFTE.Persistent.ReceiveOrder Extends CGIFTE.Persistent.WorkOrder
{

Property ASNId As %String;

ForeignKey ASNIdKey(ASNId) References CGIFTE.Persistent.ASN(IndexOnASNId) [ OnDelete = cascade ];

Storage Default
{
<Data name="ReceiveOrderDefaultData">
<Subscript>"ReceiveOrder"</Subscript>
<Value name="1">
<Value>ASNId</Value>
</Value>
</Data>
<DefaultData>ReceiveOrderDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
