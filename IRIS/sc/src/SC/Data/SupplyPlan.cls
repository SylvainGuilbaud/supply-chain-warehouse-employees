/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used for supply plans. 
Class SC.Data.SupplyPlan Extends SC.Core.Data.SupplyPlan
{

Storage Default
{
<Data name="SupplyPlanDefaultData">
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
<Value>locationId</Value>
</Value>
<Value name="5">
<Value>productId</Value>
</Value>
<Value name="6">
<Value>planCycle</Value>
</Value>
<Value name="7">
<Value>planType</Value>
</Value>
<Value name="8">
<Value>startDate</Value>
</Value>
<Value name="9">
<Value>timeFrameDays</Value>
</Value>
<Value name="10">
<Value>validFromDate</Value>
</Value>
<Value name="11">
<Value>validToDate</Value>
</Value>
<Value name="12">
<Value>quantity</Value>
</Value>
<Value name="13">
<Value>quantityUom</Value>
</Value>
<Value name="14">
<Value>dataSource</Value>
</Value>
<Value name="15">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.SupplyPlanD</DataLocation>
<DefaultData>SupplyPlanDefaultData</DefaultData>
<ExtentSize>12</ExtentSize>
<IdLocation>^SC.Data.SupplyPlanD</IdLocation>
<IndexLocation>^SC.Data.SupplyPlanI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="dataSource">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="lastUpdatedTime">
<AverageFieldSize>25</AverageFieldSize>
<Selectivity>25.0000%</Selectivity>
</Property>
<Property name="locationId">
<AverageFieldSize>14</AverageFieldSize>
<OutlierSelectivity>.999999:"warehouse-01"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="planCycle">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="planType">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="productId">
<AverageFieldSize>17</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="quantity">
<AverageFieldSize>3.67</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="quantityUom">
<AverageFieldSize>7</AverageFieldSize>
<OutlierSelectivity>.999999:"hours"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="recordCreatedTime">
<AverageFieldSize>25</AverageFieldSize>
<Selectivity>25.0000%</Selectivity>
</Property>
<Property name="startDate">
<AverageFieldSize>21</AverageFieldSize>
<Selectivity>25.0000%</Selectivity>
</Property>
<Property name="timeFrameDays">
<AverageFieldSize>3</AverageFieldSize>
<OutlierSelectivity>.999999:7</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="uid">
<AverageFieldSize>38</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="validFromDate">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="validToDate">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="locationIdIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="productIdIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="uidIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^SC.Data.SupplyPlanS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
