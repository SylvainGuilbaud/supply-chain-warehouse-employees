Class CGIFTE.Persistent.WorkOrder Extends %Persistent
{

Property OrderId As %String [ InitialExpression = {$system.Util.CreateGUID()} ];

Property TaskType As %String;

Property TaskTime As %Integer;

Property TimePlaced As %TimeStamp;

Property TimePickedUp As %TimeStamp;

Property TimeDone As %TimeStamp;

Property EmployeeId As %String;

Property Done As %Boolean;

Property Changed As %Boolean [ InitialExpression = 1 ];

ForeignKey EmployeeIdKey(EmployeeId) References CGIFTE.Persistent.Employee(IndexOnEmployeeId) [ OnDelete = cascade ];

Index OrderIDX On OrderId [ PrimaryKey ];

Index IndexOnDone On Done;

Index IndexOnChanged On Changed;

Storage Default
{
<Data name="WorkOrderDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>OrderId</Value>
</Value>
<Value name="3">
<Value>TaskType</Value>
</Value>
<Value name="4">
<Value>TaskTime</Value>
</Value>
<Value name="5">
<Value>TimePlaced</Value>
</Value>
<Value name="6">
<Value>TimePickedUp</Value>
</Value>
<Value name="7">
<Value>TimeDone</Value>
</Value>
<Value name="8">
<Value>EmployeeId</Value>
</Value>
<Value name="9">
<Value>Done</Value>
</Value>
<Value name="10">
<Value>Changed</Value>
</Value>
</Data>
<DataLocation>^CGIFTE.Persistent.WorkOrderD</DataLocation>
<DefaultData>WorkOrderDefaultData</DefaultData>
<IdLocation>^CGIFTE.Persistent.WorkOrderD</IdLocation>
<IndexLocation>^CGIFTE.Persistent.WorkOrderI</IndexLocation>
<StreamLocation>^CGIFTE.Persistent.WorkOrderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
