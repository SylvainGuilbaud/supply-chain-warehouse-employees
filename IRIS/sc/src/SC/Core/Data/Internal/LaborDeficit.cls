Class SC.Core.Data.Internal.LaborDeficit Extends SC.Core.Data.Plan
{

// for cube sync

Parameter DSTIME = "AUTO";

Property supplyQuantity As %Numeric;

Property demandQuantity As %Numeric;

ClassMethod DeleteByLocationId(locationId As %String) As %Status
{
    #dim st As %Status
    #dim tRS As %SQL.StatementResult

    // Create a dynamic SQL delete query
    Set tSQL = "DELETE FROM SC_Core_Data_Internal.LaborDeficit WHERE locationId = ?"

    Set tStatement = ##class(%SQL.Statement).%New()
    Set st = tStatement.%Prepare(tSQL)
    If $$$ISERR(st) {
        Do $System.Status.DisplayError(st)
        Return st
    }

    Set tRS = tStatement.%Execute(locationId)
    If tRS.%SQLCODE < 0 {
        Return $$$ERROR($$$SQLCode, tRS.%SQLCODE, tRS.%Message)
    }

    Quit $$$OK
}

ClassMethod populateDeficit(currentTime, locationId) As %Status
{
    for i=0:1:11 {
        set sql = "INSERT INTO SC_Core_Data_Internal.LaborDeficit (uid, locationId, productId, startDate, quantity, supplyQuantity, demandQuantity) " _
            "SELECT " _
            "'DEF' _ COALESCE(demand.locationId, supply.locationId) _ COALESCE(demand.productId, supply.productId)_ ? AS uid, " _
            "COALESCE(demand.locationId, supply.locationId) As locationId, " _
            "COALESCE(demand.productId, supply.productId) As productId,  " _
            "DATEADD('week', ?, ?) AS startDate, " _
            "supply.quantity - demand.quantity As quantity, " _
            "supply.quantity, " _
            "demand.quantity " _
            "FROM " _
            "(SELECT  " _
            "uid, locationId, productId, quantity, quantityUom, startDate, timeFrameDays " _
            "FROM SC_Data.DemandPlan " _
            "WHERE locationId = ? AND timeFrameDays = 7 AND DATEDIFF('week', ?, startDate) = ? AND validFromDate = ? AND planType = 'forecast') demand " _
            "INNER JOIN " _
            "(SELECT " _
            "uid, locationId, productId, quantity, quantityUom, startDate, timeFrameDays  " _
            "FROM SC_Data.SupplyPlan " _
            "WHERE locationID = ? AND timeFrameDays = 7 AND DATEDIFF('week', ?, startDate) = ? AND validFromDate = ? AND planType = 'forecast') supply " _
            "ON demand.locationId = supply.locationId AND demand.productId = supply.productId"
        set statement = ##class(%SQL.Statement).%New()
        set st = statement.%Prepare(sql)
        if $$$ISERR(st) {write "%Prepare failed:" do $System.Status.DisplayError(st) Quit:st}
        set rs = statement.%Execute(i, i, currentTime, locationId, currentTime, i, currentTime,locationId, currentTime, i, currentTime)
        if rs.%SQLCODE < 0 {
            return $$$ERROR($$$SQLCode,rs.SQLCODE,rs.%Message)
        }
    }
    return $$$OK
}

Storage Default
{
<Data name="LaborDeficitDefaultData">
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
<Value>locationId</Value>
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
<Value>deamndQuantity</Value>
</Value>
<Value name="18">
<Value>demandQuantity</Value>
</Value>
</Data>
<DataLocation>^SC.Core.Data5DF8.LaborDeficitD</DataLocation>
<DefaultData>LaborDeficitDefaultData</DefaultData>
<ExtentSize>9</ExtentSize>
<IdLocation>^SC.Core.Data5DF8.LaborDeficitD</IdLocation>
<IndexLocation>^SC.Core.Data5DF8.LaborDeficitI</IndexLocation>
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
<Selectivity>14.2857%</Selectivity>
</Property>
<Property name="locationId">
<AverageFieldSize>8</AverageFieldSize>
<OutlierSelectivity>.999999:"WARE01"</OutlierSelectivity>
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
<AverageFieldSize>9</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="quantity">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="quantityUom">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="recordCreatedTime">
<AverageFieldSize>25</AverageFieldSize>
<Selectivity>14.2857%</Selectivity>
</Property>
<Property name="startDate">
<AverageFieldSize>21</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="timeFrameDays">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="uid">
<AverageFieldSize>23.67</AverageFieldSize>
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
<StreamLocation>^SC.Core.Data5DF8.LaborDeficitS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
