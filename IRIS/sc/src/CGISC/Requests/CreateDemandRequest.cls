Class CGISC.Requests.CreateDemandRequest Extends Ens.Request
{

Property GATime As %String;

Property ForkliftTime As %String;

Property ControlTime As %String;

Property Week As %TimeStamp;

Property InitWeek As %TimeStamp;

Property PlanType As %String;

Property Warehouse As %String;

Storage Default
{
<Data name="CreateDemandRequestDefaultData">
<Subscript>"CreateDemandRequest"</Subscript>
<Value name="1">
<Value>GATime</Value>
</Value>
<Value name="2">
<Value>ForkliftTime</Value>
</Value>
<Value name="3">
<Value>ControlTime</Value>
</Value>
<Value name="4">
<Value>Week</Value>
</Value>
<Value name="5">
<Value>InitWeek</Value>
</Value>
<Value name="6">
<Value>PlanType</Value>
</Value>
<Value name="7">
<Value>Warehouse</Value>
</Value>
</Data>
<DefaultData>CreateDemandRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
