Class CGIFTE.Persistent.PrepareOrder Extends CGIFTE.Persistent.WorkOrder
{

Property OutboundOrderId As %String;

ForeignKey OutboundOrderIdKey(OutboundOrderId) References CGIFTE.Persistent.OutboundOrder(IndexOnOutboundOrderId) [ OnDelete = cascade ];

Storage Default
{
<Data name="PrepareOrderDefaultData">
<Subscript>"PrepareOrder"</Subscript>
<Value name="1">
<Value>OutboundOrderId</Value>
</Value>
</Data>
<DefaultData>PrepareOrderDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
