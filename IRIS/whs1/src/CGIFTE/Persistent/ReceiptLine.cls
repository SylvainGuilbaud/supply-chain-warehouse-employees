Class CGIFTE.Persistent.ReceiptLine Extends %Persistent
{

Property ReceiptId As %String;

ForeignKey ReceiptIdKey(ReceiptId) References CGIFTE.Persistent.Sales(IndexOnReceiptId) [ OnDelete = cascade ];

Property LineId As %String(MAXLEN = 10);

Property ProductId As %String(MAXLEN = 10);

Storage Default
{
<Data name="ReceiptLineDefaultData">
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
</Data>
<DataLocation>^CGIFTE.Persistent.ReceiptLineD</DataLocation>
<DefaultData>ReceiptLineDefaultData</DefaultData>
<IdLocation>^CGIFTE.Persistent.ReceiptLineD</IdLocation>
<IndexLocation>^CGIFTE.Persistent.ReceiptLineI</IndexLocation>
<StreamLocation>^CGIFTE.Persistent.ReceiptLineS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
