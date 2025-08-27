Class CGIFTE.Persistent.InboundOrder Extends %Persistent
{

Property InboundOrderId As %String(MAXLEN = "") [ InitialExpression = {$system.Util.CreateGUID()} ];

Property SupplierId As %String;

Property Total As %Integer;

Property TimePlaced As %TimeStamp;

Index IndexOnInboundOrderId On InboundOrderId [ PrimaryKey ];

Storage Default
{
<Data name="InboundOrderDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>InboundOrderId</Value>
</Value>
<Value name="3">
<Value>SupplierId</Value>
</Value>
<Value name="4">
<Value>Total</Value>
</Value>
<Value name="5">
<Value>TimePlaced</Value>
</Value>
</Data>
<DataLocation>^CGIFTE.PersisEA5B.InboundOrderD</DataLocation>
<DefaultData>InboundOrderDefaultData</DefaultData>
<IdLocation>^CGIFTE.PersisEA5B.InboundOrderD</IdLocation>
<IndexLocation>^CGIFTE.PersisEA5B.InboundOrderI</IndexLocation>
<StreamLocation>^CGIFTE.PersisEA5B.InboundOrderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
