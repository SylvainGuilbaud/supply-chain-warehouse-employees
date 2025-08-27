Class CGISC.Services.WorkOrderSQLServiceWHS1 Extends Ens.BusinessService
{

Parameter ADAPTER = "EnsLib.SQL.InboundAdapter";

Property Adapter As EnsLib.SQL.InboundAdapter;

Method OnProcessInput(pInput As %SQL.StatementResult, Output pOutput As %RegisteredObject) As %Status
{
        set tStatus = $$$OK
        Set tRequest = ##class(CGISC.Requests.WorkOrderRequest).%New()
        Set tRequest.OrderId = pInput.Get("OrderId")
        Set tRequest.TaskType = pInput.Get("TaskType")
        Set tRequest.TaskTime = pInput.Get("TaskTime")
        Set tRequest.TimePlaced = pInput.Get("TimePlaced")
        Set tRequest.TimePickedUp = pInput.Get("TimePickedUp")
        Set tRequest.TimeDone = pInput.Get("TimeDone")
        Set tRequest.EmployeeId = pInput.Get("EmployeeId")
        Set tRequest.Warehouse = "warehouse-01"
        Set tRequest.Done = pInput.Get("Done")

        // Send the request to a business process for mapping
        Set tStatus = ..SendRequestSync("CreateMfgOrder", tRequest, .pOutput)
        If $$$ISERR(tStatus) {
            return tStatus
        }
        return tStatus
}

}
