Class CGIFTE.Persistent.Sales Extends (%Persistent, %XML.Adaptor)
{

Property ReceiptId As %String(MAXLEN = 10);

Property CustomerId As %String(MAXLEN = 10);

Property SalesDate As %TimeStamp;

Property StoreId As %String;

Property Total As %Integer;

Index IndexOnReceiptId On ReceiptId [ Unique ];

Index IndexOnSalesDate On SalesDate;

Index IndexOnStoreId On StoreId;

Storage Default
{
<Data name="SalesDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>ReceiptId</Value>
</Value>
<Value name="3">
<Value>CustomerId</Value>
</Value>
<Value name="4">
<Value>SalesDate</Value>
</Value>
<Value name="5">
<Value>StoreId</Value>
</Value>
<Value name="6">
<Value>Total</Value>
</Value>
</Data>
<DataLocation>^CGIFTE.Persistent.SalesD</DataLocation>
<DefaultData>SalesDefaultData</DefaultData>
<IdLocation>^CGIFTE.Persistent.SalesD</IdLocation>
<IndexLocation>^CGIFTE.Persistent.SalesI</IndexLocation>
<StreamLocation>^CGIFTE.Persistent.SalesS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
