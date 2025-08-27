/// 
Class CGIFTE.Processes.ProcessForecast Extends Ens.BusinessProcess [ ClassType = persistent ]
{

/// See <a href="https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=EGDV_busproc#EGDV_busproc_onrequest">the documentation</a>
/// for tips on how to implement this method.
Method OnRequest(pRequest As Ens.StringRequest, Output pResponse As Ens.Response) As %Status
{
  
  return $$$OK
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
