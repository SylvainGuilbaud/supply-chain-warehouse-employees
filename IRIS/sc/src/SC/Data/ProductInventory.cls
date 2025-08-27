/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used to capture product inventory at a specific location. For a given product 
/// at a given location, you can have multiple records, one for each lot or expiration date. The
/// total inventory for a given product at a location will be the sum of all related records.
Class SC.Data.ProductInventory Extends SC.Core.Data.ProductInventory
{

Storage Default
{
<Data name="ProductInventoryDefaultData">
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
<Value>uid</Value>
</Value>
<Value name="5">
<Value>siteLocationId</Value>
</Value>
<Value name="6">
<Value>productId</Value>
</Value>
<Value name="7">
<Value>locationNumber</Value>
</Value>
<Value name="8">
<Value>lotNumber</Value>
</Value>
<Value name="9">
<Value>quantity</Value>
</Value>
<Value name="10">
<Value>quantityUom</Value>
</Value>
<Value name="11">
<Value>storageDate</Value>
</Value>
<Value name="12">
<Value>expirationDate</Value>
</Value>
<Value name="13">
<Value>status</Value>
</Value>
<Value name="14">
<Value>inventoryType</Value>
</Value>
<Value name="15">
<Value>inventoryClass</Value>
</Value>
<Value name="16">
<Value>inventoryValue</Value>
</Value>
<Value name="17">
<Value>valueCurrency</Value>
</Value>
<Value name="18">
<Value>quantityReserved</Value>
</Value>
<Value name="19">
<Value>quantityReservedUom</Value>
</Value>
</Data>
<DataLocation>^SC.Data.ProductInventoryD</DataLocation>
<DefaultData>ProductInventoryDefaultData</DefaultData>
<IdLocation>^SC.Data.ProductInventoryD</IdLocation>
<IndexLocation>^SC.Data.ProductInventoryI</IndexLocation>
<StreamLocation>^SC.Data.ProductInventoryS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
