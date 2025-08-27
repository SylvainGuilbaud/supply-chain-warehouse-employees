Class CGIFTE.Persistent.PickOrder Extends CGIFTE.Persistent.WorkOrder
{

Property ReceiptId As %String;

ForeignKey ReceiptIdKey(ReceiptId) References CGIFTE.Persistent.Sales(IndexOnReceiptId) [ OnDelete = cascade ];

Index IndexOnReceiptId On ReceiptId;

Storage Default
{
<Data name="PickOrderDefaultData">
<Subscript>"PickOrder"</Subscript>
<Value name="1">
<Value>ReceiptId</Value>
</Value>
</Data>
<DefaultData>PickOrderDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
