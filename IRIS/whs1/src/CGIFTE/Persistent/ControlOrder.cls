Class CGIFTE.Persistent.ControlOrder Extends CGIFTE.Persistent.WorkOrder
{

Property ASNId As %String;

ForeignKey ASNIdKey(ASNId) References CGIFTE.Persistent.ASN(IndexOnASNId) [ OnDelete = cascade ];

Storage Default
{
<Data name="ControlOrderDefaultData">
<Subscript>"ControlOrder"</Subscript>
<Value name="1">
<Value>ASNId</Value>
</Value>
</Data>
<DefaultData>ControlOrderDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
