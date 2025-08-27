Class CGISC.Requests.WorkOrderRequest Extends Ens.Request
{

Property OrderId As %String;

Property TaskType As %String;

Property TaskTime As %Integer;

Property TimePlaced As %TimeStamp;

Property TimePickedUp As %TimeStamp;

Property TimeDone As %TimeStamp;

Property EmployeeId As %String;

Property Done As %Boolean;

Property Warehouse As %String;

Storage Default
{
<Data name="WorkOrderRequestDefaultData">
<Subscript>"WorkOrderRequest"</Subscript>
<Value name="1">
<Value>OrderId</Value>
</Value>
<Value name="2">
<Value>TaskType</Value>
</Value>
<Value name="3">
<Value>TaskTime</Value>
</Value>
<Value name="4">
<Value>TimePlaced</Value>
</Value>
<Value name="5">
<Value>TimePickedUp</Value>
</Value>
<Value name="6">
<Value>TimeDone</Value>
</Value>
<Value name="7">
<Value>EmployeeId</Value>
</Value>
<Value name="8">
<Value>Done</Value>
</Value>
<Value name="9">
<Value>Warehouse</Value>
</Value>
</Data>
<DefaultData>WorkOrderRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
