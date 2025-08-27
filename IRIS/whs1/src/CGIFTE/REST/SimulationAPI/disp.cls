Class CGIFTE.REST.SimulationAPI.disp Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/simulate" Method="POST" Call="TriggerSimulation"/>
</Routes>
}

ClassMethod TriggerSimulation() As %Status
{
  set ^testingAPI = $H
  try {

    set pRequest = ##class(Ens.Request).%New()
    set sc = ##class(EnsLib.Testing.Service).SendTestRequest("SimulateProcess",pRequest)
    zn "WHS2"
    set pRequest = ##class(Ens.Request).%New()
    set sc = ##class(EnsLib.Testing.Service).SendTestRequest("SimulateProcess",pRequest)
    Do ##class(%REST.Impl).%SetStatusCode("200")
    return {"errormessage": "Server error"}
  }
  Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("501")
        return {"errormessage": "Server error"}
   }
   Quit $$$OK
}

}
