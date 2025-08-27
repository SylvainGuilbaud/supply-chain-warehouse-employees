Class CGIFTE.Requests.Simulate Extends Ens.Request
{

Property CurrentTime As %TimeStamp;

Property EmployeeString As %String(MAXLEN = "");

Storage Default
{
<Data name="SimulateDefaultData">
<Subscript>"Simulate"</Subscript>
<Value name="1">
<Value>CurrentTime</Value>
</Value>
<Value name="2">
<Value>EmployeeList</Value>
</Value>
<Value name="3">
<Value>EmployeeString</Value>
</Value>
</Data>
<DefaultData>SimulateDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
