Class CGIFTE.Persistent.StorageOrder Extends CGIFTE.Persistent.WorkOrder
{

Property ASNId As %String;

ForeignKey ASNIdKey(ASNId) References CGIFTE.Persistent.ASN(IndexOnASNId) [ OnDelete = cascade ];

Storage Default
{
<Data name="StorageOrderDefaultData">
<Subscript>"StorageOrder"</Subscript>
<Value name="1">
<Value>ASNId</Value>
</Value>
</Data>
<DefaultData>StorageOrderDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
