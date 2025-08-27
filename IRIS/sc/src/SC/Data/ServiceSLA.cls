/*
Copyright (c) 2024 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// ServiceSLA object can be used to store any kind of information for different cloud services
/// values can be stored in key value pairs
Class SC.Data.ServiceSLA Extends SC.Core.Data.ServiceSLA
{

Storage Default
{
<Data name="ServiceSLADefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>recordCreatedTime</Value>
</Value>
<Value name="3">
<Value>lastUpdatedTime</Value>
</Value>
<Value name="4">
<Value>serviceId</Value>
</Value>
<Value name="5">
<Value>termName</Value>
</Value>
<Value name="6">
<Value>termValue</Value>
</Value>
<Value name="7">
<Value>termValueUOM</Value>
</Value>
<Value name="8">
<Value>serviceObject</Value>
</Value>
<Value name="9">
<Value>type</Value>
</Value>
<Value name="10">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.ServiceSLAD</DataLocation>
<DefaultData>ServiceSLADefaultData</DefaultData>
<IdLocation>^SC.Data.ServiceSLAD</IdLocation>
<IndexLocation>^SC.Data.ServiceSLAI</IndexLocation>
<StreamLocation>^SC.Data.ServiceSLAS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
