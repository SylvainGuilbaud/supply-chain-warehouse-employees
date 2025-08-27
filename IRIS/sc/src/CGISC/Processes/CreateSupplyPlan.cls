/// 
Class CGISC.Processes.CreatesupplyPlan Extends Ens.BusinessProcess [ ClassType = persistent ]
{

/// See <a href="https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=EGDV_busproc#EGDV_busproc_onrequest">the documentation</a>
/// for tips on how to implement this method.
Method OnRequest(pRequest As CGISC.Requests.CreateSupplyRequest, Output pResponse As Ens.Response) As %Status
{
  
  set supplyPlan = ##class(SC.Data.SupplyPlan).%New()
  set supplyPlan.uid = $System.Util.CreateGUID()
  set supplyPlan.startDate = pRequest.Week
  set supplyPlan.timeFrameDays = 7
  set supplyPlan.locationId = pRequest.Warehouse
  set supplyPlan.productId = "laborproduct-01"
  set supplyPlan.quantity = pRequest.ForkliftTime
  set supplyPlan.quantityUom = "hours"
  set supplyPlan.validFromDate = pRequest.InitWeek
  set supplyPlan.validToDate = ##class(%SYSTEM.SQL.Functions).DATEADD("week", 1, pRequest.InitWeek)
  set supplyPlan.planType = pRequest.PlanType
  set sc = supplyPlan.%Save()
  set supplyPlan = ##class(SC.Data.SupplyPlan).%New()
  set supplyPlan.uid = $System.Util.CreateGUID()
  set supplyPlan.startDate = pRequest.Week
  set supplyPlan.timeFrameDays = 7
  set supplyPlan.locationId = pRequest.Warehouse
  set supplyPlan.productId = "laborproduct-02"
  set supplyPlan.quantity = pRequest.ControlTime
  set supplyPlan.quantityUom = "hours"
  set supplyPlan.validFromDate = pRequest.InitWeek
  set supplyPlan.validToDate = ##class(%SYSTEM.SQL.Functions).DATEADD("week", 1, pRequest.InitWeek)
  set supplyPlan.planType = pRequest.PlanType
  set sc = supplyPlan.%Save()
  set supplyPlan = ##class(SC.Data.SupplyPlan).%New()
  set supplyPlan.uid = $System.Util.CreateGUID()
  set supplyPlan.startDate = pRequest.Week
  set supplyPlan.timeFrameDays = 7
  set supplyPlan.locationId = pRequest.Warehouse
  set supplyPlan.productId = "laborproduct-03"
  set supplyPlan.quantity = pRequest.GATime
  set supplyPlan.quantityUom = "hours"
  set supplyPlan.validFromDate = pRequest.InitWeek
  set supplyPlan.validToDate = ##class(%SYSTEM.SQL.Functions).DATEADD("week", 1, pRequest.InitWeek)
  set supplyPlan.planType = pRequest.PlanType
  set sc = supplyPlan.%Save()
  return sc
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
