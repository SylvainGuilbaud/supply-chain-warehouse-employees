Class CGIFTE.Responses.Simulate Extends Ens.Response
{

Property CurrentTime As %TimeStamp;

Property Status As %String(MAXLEN = 100);

Storage Default
{
<Data name="SimulateDefaultData">
<Subscript>"Simulate"</Subscript>
<Value name="1">
<Value>CurrentTime</Value>
</Value>
<Value name="2">
<Value>Status</Value>
</Value>
</Data>
<DefaultData>SimulateDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
