Class CGIFTE.Persistent.SalesData Extends %Persistent
{

Property ReceiptId As %String(MAXLEN = 10);

Property LineId As %String(MAXLEN = 10);

Property ProductId As %String(MAXLEN = 10);

Property CustomerId As %String(MAXLEN = 10);

Property SalesDate As %TimeStamp;

Property StoreId As %String;

Property Processed As %Boolean;

Index IndexOnReceiptId On ReceiptId;

Index IndexOnSalesDate On SalesDate;

Index IndexOnStoreId On StoreId;

Storage Default
{
<Data name="SalesDataDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>ReceiptId</Value>
</Value>
<Value name="3">
<Value>LineId</Value>
</Value>
<Value name="4">
<Value>ProductId</Value>
</Value>
<Value name="5">
<Value>CustomerId</Value>
</Value>
<Value name="6">
<Value>SalesDate</Value>
</Value>
<Value name="7">
<Value>StoreId</Value>
</Value>
<Value name="8">
<Value>Processed</Value>
</Value>
</Data>
<DataLocation>^CGIFTE.Persistent.SalesDataD</DataLocation>
<DefaultData>SalesDataDefaultData</DefaultData>
<IdLocation>^CGIFTE.Persistent.SalesDataD</IdLocation>
<IndexLocation>^CGIFTE.Persistent.SalesDataI</IndexLocation>
<StreamLocation>^CGIFTE.Persistent.SalesDataS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
