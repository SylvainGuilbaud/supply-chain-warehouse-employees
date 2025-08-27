/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used to capture master data of a product. A product can be the final product
/// made and sold by a company, it can also be a part used to make the final product. One can use product
/// type attributes to differential different type of products (such as final products vs parts/items).
Class SC.Data.Product Extends SC.Core.Data.Product
{

Storage Default
{
<Data name="ProductDefaultData">
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
<Value>dataSource</Value>
</Value>
<Value name="5">
<Value>sourceProductId</Value>
</Value>
<Value name="6">
<Value>productClass</Value>
</Value>
<Value name="7">
<Value>productCategory</Value>
</Value>
<Value name="8">
<Value>productBrand</Value>
</Value>
<Value name="9">
<Value>productFamily</Value>
</Value>
<Value name="10">
<Value>productSegment</Value>
</Value>
<Value name="11">
<Value>productNumber</Value>
</Value>
<Value name="12">
<Value>name</Value>
</Value>
<Value name="13">
<Value>description</Value>
</Value>
<Value name="14">
<Value>type</Value>
</Value>
<Value name="15">
<Value>status</Value>
</Value>
<Value name="16">
<Value>gtin</Value>
</Value>
<Value name="17">
<Value>defaultUom</Value>
</Value>
<Value name="18">
<Value>shelfLife</Value>
</Value>
<Value name="19">
<Value>shelfLifeUom</Value>
</Value>
<Value name="20">
<Value>agingThreshold</Value>
</Value>
<Value name="21">
<Value>agingThresholdUom</Value>
</Value>
<Value name="22">
<Value>defaultLeadTime</Value>
</Value>
<Value name="23">
<Value>leadTimeUom</Value>
</Value>
<Value name="24">
<Value>defaultGoodReceiptProcessingTime</Value>
</Value>
<Value name="25">
<Value>goodReceiptProcessingTimeUom</Value>
</Value>
<Value name="26">
<Value>costControl</Value>
</Value>
<Value name="27">
<Value>standardCost</Value>
</Value>
<Value name="28">
<Value>movingAverageCost</Value>
</Value>
<Value name="29">
<Value>costCurrency</Value>
</Value>
<Value name="30">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.ProductD</DataLocation>
<DefaultData>ProductDefaultData</DefaultData>
<ExtentSize>3</ExtentSize>
<IdLocation>^SC.Data.ProductD</IdLocation>
<IndexLocation>^SC.Data.ProductI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="agingThreshold">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="agingThresholdUom">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="costControl">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="costCurrency">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="dataSource">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="defaultGoodReceiptProcessingTime">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="defaultLeadTime">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="defaultUom">
<AverageFieldSize>7</AverageFieldSize>
<OutlierSelectivity>.999999:"hours"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="description">
<AverageFieldSize>62.67</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="goodReceiptProcessingTimeUom">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="gtin">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="lastUpdatedTime">
<AverageFieldSize>25</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="leadTimeUom">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="movingAverageCost">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="name">
<AverageFieldSize>22</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="productBrand">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="productCategory">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="productClass">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="productFamily">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="productNumber">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="productSegment">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="recordCreatedTime">
<AverageFieldSize>25</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="shelfLife">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="shelfLifeUom">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="sourceProductId">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="standardCost">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="status">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="type">
<AverageFieldSize>7</AverageFieldSize>
<OutlierSelectivity>.999999:"LABOR"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="uid">
<AverageFieldSize>17</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="uidIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^SC.Data.ProductS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
