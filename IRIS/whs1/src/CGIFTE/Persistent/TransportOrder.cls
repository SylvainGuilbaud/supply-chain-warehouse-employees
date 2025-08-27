Class CGIFTE.Persistent.LoadOrder Extends CGIFTE.Persistent.WorkOrder
{

Property OutboundOrderId As %String;

ForeignKey OutboundOrderIdKey(OutboundOrderId) References CGIFTE.Persistent.OutboundOrder(IndexOnOutboundOrderId) [ OnDelete = cascade ];

Storage Default
{
<Data name="LoadOrderDefaultData">
<Subscript>"LoadOrder"</Subscript>
<Value name="1">
<Value>OutboundOrderId</Value>
</Value>
</Data>
<DefaultData>LoadOrderDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
