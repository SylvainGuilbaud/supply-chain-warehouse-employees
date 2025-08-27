/// 
Class CGIFTE.Services.SalesAPI Extends Ens.BusinessService
{

/// See <a href="https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=EGDV_busservice#EGDV_busservice_onprocessinput">the documentation</a>
/// for tips on how to implement this method.
Method OnProcessInput(pInput As %RegisteredObject, pOutput As %RegisteredObject) As %Status
{
  // Check if WebSale
  set pRequest = ##class(CGIFTE.Requests.ProcessSale).%New()
  set pInput = ##class(%DynamicAbstractObject).%FromJSON(pInput)
  if pInput '= {}
  {
    set sale = ##class(CGIFTE.Persistent.Sales).%New()
    set sale.ReceiptId = pInput.ReceiptId
    set sale.CustomerId = pInput.CustomerId
    set sale.SalesDate = pInput.SalesDate
    set sale.StoreId = pInput.StoreId
    set sale.Total = pInput.Total
    do sale.%Save()
    set pRequest.Sale = sale
    set tSc = ..SendRequestSync("ProcessSale", pRequest, .pResponse, -1)
  }
  return tSc
}

}
