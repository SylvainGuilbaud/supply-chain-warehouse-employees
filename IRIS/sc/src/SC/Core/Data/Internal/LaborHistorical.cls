Class SC.Core.Data.Internal.LaborHistorical Extends SC.Core.Data.Plan
{

// for cube sync

Parameter DSTIME = "AUTO";

Property supplyQuantity As %Numeric;

Property demandQuantity As %Numeric;

ClassMethod populateHistorical(currentTime, locationId) As %Status
{
    set sql = "INSERT INTO SC_Core_Data_Internal.LaborHistorical (uid, locationId, productId, startDate, quantity, supplyQuantity, demandQuantity) " _
        "SELECT " _
        "'DEF' _ COALESCE(demand.locationId, supply.locationId) _ COALESCE(demand.productId, supply.productId)_ ? AS uid, " _
        "COALESCE(demand.locationId, supply.locationId) As locationId, " _
        "COALESCE(demand.productId, supply.productId) As productId,  " _
        "? AS startDate, " _
        "supply.quantity - demand.quantity As quantity, " _
        "supply.quantity, " _
        "demand.quantity " _
        "FROM " _
        "(SELECT  " _
        "uid, locationId, productId, quantity, quantityUom, startDate, timeFrameDays " _
        "FROM SC_Data.DemandPlan " _
        "WHERE locationId = ? AND startDate = ? AND planType = 'historical') demand " _
        "INNER JOIN " _
        "(SELECT " _
        "uid, locationId, productId, quantity, quantityUom, startDate, timeFrameDays  " _
        "FROM SC_Data.SupplyPlan " _
        "WHERE locationId = ? AND startDate = ? AND planType = 'historical') supply " _
        "ON demand.locationId = supply.locationId AND demand.productId = supply.productId"
    set statement = ##class(%SQL.Statement).%New()
    set st = statement.%Prepare(sql)
    set ^test = st
    if $$$ISERR(st) {write "%Prepare failed:" do $System.Status.DisplayError(st) Quit:st}
    set rs = statement.%Execute(currentTime, currentTime, locationId, currentTime, locationId, currentTime)
    if rs.%SQLCODE < 0 {
        return $$$ERROR($$$SQLCode,rs.SQLCODE,rs.%Message)
    }
    
    return $$$OK
}

Storage Default
{
<Data name="LaborHistoricalDefaultData">
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
<Value>demandQuantity</Value>
</Value>
<Value name="6">
<Value>productId</Value>
</Value>
<Value name="7">
<Value>planCycle</Value>
</Value>
<Value name="8">
<Value>planType</Value>
</Value>
<Value name="9">
<Value>startDate</Value>
</Value>
<Value name="10">
<Value>timeFrameDays</Value>
</Value>
<Value name="11">
<Value>validFromDate</Value>
</Value>
<Value name="12">
<Value>validToDate</Value>
</Value>
<Value name="13">
<Value>quantity</Value>
</Value>
<Value name="14">
<Value>quantityUom</Value>
</Value>
<Value name="15">
<Value>dataSource</Value>
</Value>
<Value name="16">
<Value>supplyQuantity</Value>
</Value>
<Value name="17">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Core.Da5DF8.LaborHistorAA58D</DataLocation>
<DefaultData>LaborHistoricalDefaultData</DefaultData>
<ExtentSize>6</ExtentSize>
<IdLocation>^SC.Core.Da5DF8.LaborHistorAA58D</IdLocation>
<IndexLocation>^SC.Core.Da5DF8.LaborHistorAA58I</IndexLocation>
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
<Property name="demandQuantity">
<AverageFieldSize>4.83</AverageFieldSize>
<Selectivity>16.6667%</Selectivity>
</Property>
<Property name="lastUpdatedTime">
<AverageFieldSize>25</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="locationId">
<AverageFieldSize>14</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
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
<AverageFieldSize>5</AverageFieldSize>
<Selectivity>16.6667%</Selectivity>
</Property>
<Property name="quantityUom">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="recordCreatedTime">
<AverageFieldSize>25</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="startDate">
<AverageFieldSize>21</AverageFieldSize>
<OutlierSelectivity>.999999:"2022-12-30 17:00:00"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="supplyQuantity">
<AverageFieldSize>3.33</AverageFieldSize>
<Selectivity>25.0000%</Selectivity>
</Property>
<Property name="timeFrameDays">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="uid">
<AverageFieldSize>51</AverageFieldSize>
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
<StreamLocation>^SC.Core.Da5DF8.LaborHistorAA58S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
