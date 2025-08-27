Class CGIFTE.Persistent.Products Extends %Persistent
{

Property ProductId As %String(MAXLEN = 10);

Property ProductFamilly As %String(MAXLEN = 10);

Property SupplierName As %String(MAXLEN = 100);

Property SupplierId As %Integer;

Property Price As %Float;

Property Changed As %Boolean [ InitialExpression = 1 ];

Storage Default
{
<Data name="ProductsDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>ProductId</Value>
</Value>
<Value name="3">
<Value>ProductFamilly</Value>
</Value>
<Value name="4">
<Value>SupplierName</Value>
</Value>
<Value name="5">
<Value>SupplierId</Value>
</Value>
<Value name="6">
<Value>Price</Value>
</Value>
<Value name="7">
<Value>Changed</Value>
</Value>
</Data>
<DataLocation>^CGIFTE.Persistent.ProductsD</DataLocation>
<DefaultData>ProductsDefaultData</DefaultData>
<IdLocation>^CGIFTE.Persistent.ProductsD</IdLocation>
<IndexLocation>^CGIFTE.Persistent.ProductsI</IndexLocation>
<StreamLocation>^CGIFTE.Persistent.ProductsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
