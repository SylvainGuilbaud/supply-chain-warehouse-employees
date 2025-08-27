Class CGIFTE.Services.SalesImportWHS1 Extends Ens.BusinessService
{

Parameter ADAPTER = "EnsLib.SQL.InboundAdapter";

Property Adapter As EnsLib.SQL.InboundAdapter;

Method OnProcessInput(pInput As %SQL.StatementResult, Output pOutput As %RegisteredObject) As %Status
{
    #dim tSC As %Status = $$$OK
    #dim order As SC.Data.SalesOrder
    #dim orderLine As SC.Data.SalesOrderLine

    // Extract values
    Set receiptId  = pInput.Get("ReceiptId")
    Set lineId     = pInput.Get("LineId")
    Set productId  = pInput.Get("ProductId")
    Set customerId = pInput.Get("CustomerId")
    Set storeId    = pInput.Get("StoreId")

    //
    // Step 1: Get or create SalesOrder by ReceiptId
    //
    Set orderExists = ##class(SC.Core.Data.SalesOrder).uidIndexExists(receiptId)
    If orderExists = 0 {
        Set order = ##class(SC.Core.Data.SalesOrder).%New()
        Set order.uid                = receiptId
        Set order.customerId         = customerId
        Set order.salesRegion        = "warehouse-01" // or logic
        Set order.shipToLocationId   = storeId
        Set tSC = order.%Save()
        If $$$ISERR(tSC) Quit tSC
    }

    //
    // Step 2: Create a SalesOrderLine linked to that order
    //
    Set orderLine = ##class(SC.Core.Data.SalesOrderLine).%New()
    Set orderLine.uid              = receiptId _ "_" _ lineId
    Set orderLine.salesOrderId     = receiptId
    Set orderLine.productId        = productId
    Set orderLine.shipToLocationId = storeId

    Set tSC = orderLine.%Save()
    Quit tSC
}

}
