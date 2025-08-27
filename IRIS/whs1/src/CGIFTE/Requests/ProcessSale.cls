Class CGIFTE.Requests.ProcessSale Extends Ens.Request
{

Property Sale As CGIFTE.Persistent.Sales;

Property ReceiptLine As list Of CGIFTE.Persistent.ReceiptLine;

Storage Default
{
<Data name="ProcessSaleDefaultData">
<Subscript>"ProcessSale"</Subscript>
<Value name="1">
<Value>Sale</Value>
</Value>
<Value name="2">
<Value>ReceiptLine</Value>
</Value>
</Data>
<DefaultData>ProcessSaleDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
