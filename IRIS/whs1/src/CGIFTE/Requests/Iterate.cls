Class CGIFTE.Requests.Iterate Extends Ens.Request
{

Property CurrentTime As %TimeStamp;

Property EmployeeString As %String(MAXLEN = "");

Property NumberOfWeeks As %Integer;

Storage Default
{
<Data name="IterateDefaultData">
<Subscript>"Iterate"</Subscript>
<Value name="1">
<Value>CurrentTime</Value>
</Value>
<Value name="2">
<Value>EmployeeString</Value>
</Value>
<Value name="3">
<Value>NumberOfWeeks</Value>
</Value>
</Data>
<DefaultData>IterateDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
