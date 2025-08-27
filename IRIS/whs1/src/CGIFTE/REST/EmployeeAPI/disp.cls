Class CGIFTE.REST.EmployeeAPI.disp Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

// basic CORS handling

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <!-- Warehouse employees -->
  <Route Url="/employees" Method="GET"  Call="GetWarehouseStaff"/>
  <Route Url="/employees" Method="POST" Call="UpdateWarehouseStaff"/>
</Routes>
}

ClassMethod GetWarehouseStaff() As %Status
{
    Try {

        Set obj = {}
        Set obj.general  = ^employee("Storage,Pick,Prepare")
        Set obj.quality  = ^employee("Control")
        Set obj.forklift = ^employee("Receive,Load")

        Do ..%JSONStatus(200, obj)
        return $$$OK
    } Catch ex {
        Do ..%JSONStatus(500, {"ok":0,"error":"Failed to read staff"})
        return $$$OK
    }
}

ClassMethod UpdateWarehouseStaff() As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        Set req = %request.Content.Read()
        set req = {}.%FromJSON(req)
        Set t = req.type
    Set val = req.value

    If t = "general" {
        Set ^employee("Storage,Pick,Prepare") = val
    } ElseIf t = "quality" {
        Set ^employee("Control") = val
    } ElseIf t = "forklift" {
        Set ^employee("Receive,Load") = val
    } Else {
         DO ..%JSONStatus(400, {"ok":0,"error":"Invalid type"})
    }} Catch (ex) {
        Do ..%JSONStatus(500, {"ok":0,"error":"Failed to read staff"})
        return $$$OK
    }
    

    // Return the updated counts (HTTP 200)
    Quit ..GetWarehouseStaff()
}

ClassMethod %JSONStatus(code As %Integer = 200, obj As %DynamicAbstractObject) As %Status
{
    Do ##class(%REST.Impl).%SetStatusCode(code)
    Set %response.ContentType = "application/json; charset=utf-8"
    // keep CORS header (defense-in-depth in case OnPreDispatch wasn’t hit)
    If $IsObject(obj) {
        Do obj.%ToJSON()
    } Else {
        // in case someone passed a raw string
        Write obj
    }
    Quit $$$OK
}

}
