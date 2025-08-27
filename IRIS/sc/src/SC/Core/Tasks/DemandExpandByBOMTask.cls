Class SC.Core.Tasks.DemandExpandByBOMTask Extends %SYS.Task.Definition
{

Parameter TaskName = "DemandExpandByBOM";

Method OnTask() As %Status
{
    set st = ..deleteExisting()
    if $$$ISERR(st) return st
    set st = ..populate()
    if $$$ISERR(st) return st
    return $$$OK
}

ClassMethod deleteExisting() As %Status
{
    set sql = "DELETE FROM SC_Data.DemandPlan WHERE planType = 'BOMgenerated'"
    set statement = ##class(%SQL.Statement).%New()
    set st = statement.%Prepare(sql)
    if $$$ISERR(st) {write "%Prepare failed:" do $System.Status.DisplayError(st) Quit:st}
    set rs = statement.%Execute()
    if rs.%SQLCODE < 0 return $$$ERROR($$$SQLCode,rs.SQLCODE,rs.%Message)
    return $$$OK
}

ClassMethod populate() As %Status
{
    set sql = "INSERT INTO SC_Data.DemandPlan (uid, productId, locationId, quantity, quantityUom, startDate, timeFrameDays, planType) SELECT SC_Data.DemandPlan.uid _ SC_Data.BOM.uid, itemId, locationId, SC_Data.DemandPlan.quantity * SC_Data.BOM.quantity, unitOfMeasure, startDate, timeFrameDays, 'BOMgenerated' FROM SC_Data.DemandPlan FULL OUTER JOIN SC_Data.BOM ON SC_Data.DemandPlan.productId=SC_Data.BOM.productId"
    set statement = ##class(%SQL.Statement).%New()
    set st = statement.%Prepare(sql)
    if $$$ISERR(st) {write "%Prepare failed:" do $System.Status.DisplayError(st) Quit:st}
    set rs = statement.%Execute()
    if rs.%SQLCODE < 0 return $$$ERROR($$$SQLCode,rs.SQLCODE,rs.%Message)
    return $$$OK
}

}
