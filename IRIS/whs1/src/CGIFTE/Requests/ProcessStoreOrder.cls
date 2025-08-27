Class CGIFTE.Requests.ProcessStoreOrder Extends Ens.Request
{

Property StoreOrder As CGIFTE.Persistent.StoreOrder;

Storage Default
{
<Data name="ProcessStoreOrderDefaultData">
<Subscript>"ProcessStoreOrder"</Subscript>
<Value name="1">
<Value>StoreOrder</Value>
</Value>
</Data>
<DefaultData>ProcessStoreOrderDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
