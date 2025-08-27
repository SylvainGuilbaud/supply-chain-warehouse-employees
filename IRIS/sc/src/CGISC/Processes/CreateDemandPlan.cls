/// 
Class CGISC.Processes.CreateDemandPlan Extends Ens.BusinessProcess [ ClassType = persistent ]
{

/// See <a href="https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=EGDV_busproc#EGDV_busproc_onrequest">the documentation</a>
/// for tips on how to implement this method.
Method OnRequest(pRequest As CGISC.Requests.CreateDemandRequest, Output pResponse As Ens.Response) As %Status
{
  
  set demandPlan = ##class(SC.Data.DemandPlan).%New()
  set demandPlan.uid = $System.Util.CreateGUID()
  set demandPlan.startDate = pRequest.Week
  set demandPlan.timeFrameDays = 7
  set demandPlan.locationId = pRequest.Warehouse
  set demandPlan.productId = "laborproduct-01"
  set demandPlan.quantity = pRequest.ForkliftTime
  set demandPlan.quantityUom = "hours"
  set demandPlan.validFromDate = pRequest.InitWeek
  set demandPlan.validToDate = ##class(%SYSTEM.SQL.Functions).DATEADD("week", 1, pRequest.InitWeek)
  set demandPlan.planType = pRequest.PlanType
  set sc = demandPlan.%Save()
  set demandPlan = ##class(SC.Data.DemandPlan).%New()
  set demandPlan.uid = $System.Util.CreateGUID()
  set demandPlan.startDate = pRequest.Week
  set demandPlan.timeFrameDays = 7
  set demandPlan.locationId = pRequest.Warehouse
  set demandPlan.productId = "laborproduct-02"
  set demandPlan.quantity = pRequest.ControlTime
  set demandPlan.quantityUom = "hours"
  set demandPlan.validFromDate = pRequest.InitWeek
  set demandPlan.validToDate = ##class(%SYSTEM.SQL.Functions).DATEADD("week", 1, pRequest.InitWeek)
  set demandPlan.planType = pRequest.PlanType
  set sc = demandPlan.%Save()
  set demandPlan = ##class(SC.Data.DemandPlan).%New()
  set demandPlan.uid = $System.Util.CreateGUID()
  set demandPlan.startDate = pRequest.Week
  set demandPlan.timeFrameDays = 7
  set demandPlan.locationId = pRequest.Warehouse
  set demandPlan.productId = "laborproduct-03"
  set demandPlan.quantity = pRequest.GATime
  set demandPlan.quantityUom = "hours"
  set demandPlan.validFromDate = pRequest.InitWeek
  set demandPlan.validToDate = ##class(%SYSTEM.SQL.Functions).DATEADD("week", 1, pRequest.InitWeek)
  set demandPlan.planType = pRequest.PlanType
  set sc =  demandPlan.%Save()
  return sc
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
