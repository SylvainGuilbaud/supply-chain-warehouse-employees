Class CGIFTE.Persistent.Employee Extends %Persistent
{

Property EmployeeId As %String;

Property BusyUntil As %TimeStamp;

Property Available As %Boolean;

Property TaskType As %String;

Index IndexOnEmployeeId On EmployeeId [ PrimaryKey ];

Index IndexOnBusyUntil On BusyUntil;

Index IndexOnAvailable On Available;

Index IndexOnTaskType On TaskType;

Storage Default
{
<Data name="EmployeeDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>EmployeeId</Value>
</Value>
<Value name="3">
<Value>BusyUntil</Value>
</Value>
<Value name="4">
<Value>Available</Value>
</Value>
<Value name="5">
<Value>TaskType</Value>
</Value>
</Data>
<DataLocation>^CGIFTE.Persistent.EmployeeD</DataLocation>
<DefaultData>EmployeeDefaultData</DefaultData>
<IdLocation>^CGIFTE.Persistent.EmployeeD</IdLocation>
<IndexLocation>^CGIFTE.Persistent.EmployeeI</IndexLocation>
<StreamLocation>^CGIFTE.Persistent.EmployeeS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
