Class CGIFTE.Persistent.EmployeeAvailabilityLog Extends %Persistent
{

Property EmployeeId As %String;

Property CurrentTime As %TimeStamp;

Storage Default
{
<Data name="EmployeeAvailabilityLogDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>EmployeeId</Value>
</Value>
<Value name="3">
<Value>CurrentTime</Value>
</Value>
</Data>
<DataLocation>^CGIFTE.PerEA5B.EmployeeAva412FD</DataLocation>
<DefaultData>EmployeeAvailabilityLogDefaultData</DefaultData>
<IdLocation>^CGIFTE.PerEA5B.EmployeeAva412FD</IdLocation>
<IndexLocation>^CGIFTE.PerEA5B.EmployeeAva412FI</IndexLocation>
<StreamLocation>^CGIFTE.PerEA5B.EmployeeAva412FS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
