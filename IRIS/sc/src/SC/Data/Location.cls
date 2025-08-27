/*
Copyright (c) 2022-2024 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// Location object can be used to store any kind of addresses, such as those for
/// supplier, customers, ship-to, ship-from, manufacturing plant, warehouses, etc. 
/// It can also be used to save any geo location with coordinates without an address.
Class SC.Data.Location Extends SC.Core.Data.Location
{

Storage Default
{
<Data name="LocationDefaultData">
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
<Value>type</Value>
</Value>
<Value name="6">
<Value>status</Value>
</Value>
<Value name="7">
<Value>street</Value>
</Value>
<Value name="8">
<Value>city</Value>
</Value>
<Value name="9">
<Value>stateProvince</Value>
</Value>
<Value name="10">
<Value>stateProvinceIso2</Value>
</Value>
<Value name="11">
<Value>country</Value>
</Value>
<Value name="12">
<Value>countryIso2</Value>
</Value>
<Value name="13">
<Value>countryIso3</Value>
</Value>
<Value name="14">
<Value>countryPhoneCode</Value>
</Value>
<Value name="15">
<Value>postalCode</Value>
</Value>
<Value name="16">
<Value>coordinates</Value>
</Value>
<Value name="17">
<Value>latitude</Value>
</Value>
<Value name="18">
<Value>longitude</Value>
</Value>
<Value name="19">
<Value>gln</Value>
</Value>
<Value name="20">
<Value>currencyIso3</Value>
</Value>
<Value name="21">
<Value>region</Value>
</Value>
<Value name="22">
<Value>subregion</Value>
</Value>
<Value name="23">
<Value>uid</Value>
</Value>
<Value name="24">
<Value>street2</Value>
</Value>
<Value name="25">
<Value>neighborhood</Value>
</Value>
</Data>
<DataLocation>^SC.Data.LocationD</DataLocation>
<DefaultData>LocationDefaultData</DefaultData>
<ExtentSize>1</ExtentSize>
<IdLocation>^SC.Data.LocationD</IdLocation>
<IndexLocation>^SC.Data.LocationI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="city">
<AverageFieldSize>7</AverageFieldSize>
<OutlierSelectivity>.999999:"Paris"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="coordinates">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="country">
<AverageFieldSize>8</AverageFieldSize>
<OutlierSelectivity>.999999:"France"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="countryIso2">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="countryIso3">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="countryPhoneCode">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="currencyIso3">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="gln">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="lastUpdatedTime">
<AverageFieldSize>25</AverageFieldSize>
<OutlierSelectivity>.999999:"2025-03-14 07:20:38.494"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="latitude">
<AverageFieldSize>11</AverageFieldSize>
<OutlierSelectivity>.999999:48.856697</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="longitude">
<AverageFieldSize>10</AverageFieldSize>
<OutlierSelectivity>.999999:2.351462</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="name">
<AverageFieldSize>20</AverageFieldSize>
<OutlierSelectivity>.999999:"Pompéa warehouse 1"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="neighborhood">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="postalCode">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="recordCreatedTime">
<AverageFieldSize>25</AverageFieldSize>
<OutlierSelectivity>.999999:"2025-03-14 07:20:38.494"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="region">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="stateProvince">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="stateProvinceIso2">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="status">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="street">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="street2">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="subregion">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="type">
<AverageFieldSize>11</AverageFieldSize>
<OutlierSelectivity>.999999:"WAREHOUSE"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="uid">
<AverageFieldSize>14</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="uidIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^SC.Data.LocationS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
