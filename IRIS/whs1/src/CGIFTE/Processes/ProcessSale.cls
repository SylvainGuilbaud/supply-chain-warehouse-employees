/// 
Class CGIFTE.Processes.ProcessSale Extends Ens.BusinessProcess [ ClassType = persistent ]
{

/// See <a href="https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=EGDV_busproc#EGDV_busproc_onrequest">the documentation</a>
/// for tips on how to implement this method.
Method OnRequest(pRequest As CGIFTE.Requests.ProcessSale, Output pResponse As Ens.Response) As %Status
{
  set receiptId = pRequest.Sale.ReceiptId
  set count = pRequest.ReceiptLine.Count()
  set currentTime = pRequest.Sale.SalesDate

  set task =  ##class(CGIFTE.Persistent.PickOrder).%New()
  set task.ReceiptId = receiptId
  set task.TaskType = "Pick"
  set task.TaskTime = ##class(CGIFTE.Util).GeneratePickTimeWeb(count)
  set task.TimePlaced = currentTime
  set task.Done = 0
  set sc = task.%Save()
  do $INCREMENT(^TaskGlobal("Pick"))
  return sc
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
