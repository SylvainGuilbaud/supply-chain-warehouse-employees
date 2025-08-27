/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used for master data for suppliers. 
Class SC.Data.Supplier Extends SC.Core.Data.Supplier
{

Storage Default
{
<Data name="SupplierDefaultData">
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
<Value>name</Value>
</Value>
<Value name="5">
<Value>dataSource</Value>
</Value>
<Value name="6">
<Value>sourceId</Value>
</Value>
<Value name="7">
<Value>primaryLocationId</Value>
</Value>
<Value name="8">
<Value>primaryPhone</Value>
</Value>
<Value name="9">
<Value>primaryContact</Value>
</Value>
<Value name="10">
<Value>url</Value>
</Value>
<Value name="11">
<Value>type</Value>
</Value>
<Value name="12">
<Value>status</Value>
</Value>
<Value name="13">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.SupplierD</DataLocation>
<DefaultData>SupplierDefaultData</DefaultData>
<IdLocation>^SC.Data.SupplierD</IdLocation>
<IndexLocation>^SC.Data.SupplierI</IndexLocation>
<StreamLocation>^SC.Data.SupplierS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
