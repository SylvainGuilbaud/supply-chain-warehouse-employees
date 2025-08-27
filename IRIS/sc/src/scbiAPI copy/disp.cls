/// API for InterSystems IRIS supply chain analytics
/// Dispatch class defined by RESTSpec in scbiAPI.spec
Class scbiAPI.disp Extends %CSP.REST [ GeneratedBy = scbiAPI.spec.cls, ProcedureBlock ]
{

/// The class containing the RESTSpec which generated this class
Parameter SpecificationClass = "scbiAPI.spec";

/// Ignore any writes done directly by the REST method.
Parameter IgnoreWrites = 1;

/// Default the Content-Type for this application.
Parameter CONTENTTYPE = "application/json";

/// By default convert the input stream to Unicode
Parameter CONVERTINPUTSTREAM = 1;

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/kpi/definitions/:kpiName" Method="get" Call="GetKpiDefinition" />
  <Route Url="/kpi/definitions/:kpiName" Method="put" Call="UpdateKpiDefinition" />
  <Route Url="/kpi/definitions/:kpiName" Method="delete" Call="DeleteKpiDefinition" />
  <Route Url="/kpi/definitions" Method="get" Call="GetKpiDefinitions" />
  <Route Url="/kpi/definitions" Method="post" Call="CreateKpiDefinition" />
  <Route Url="/kpi/values/:kpiName" Method="get" Call="GetKpiValue" />
  <Route Url="/kpi/listings/:kpiName" Method="get" Call="GetKpiListing" />
  <Route Url="/kpiissues" Method="post" Call="UpdateKpiIssues" />
  <Route Url="/closeissue/:issueId" Method="post" Call="CloseIssue" />
  <Route Url="/completeissueworkflow/:issueId" Method="post" Call="CompleteWorkflow" />
  <Route Url="/runissueanalysis/:issueId" Method="post" Call="RunIssueAnalysis" />
</Routes>
}

ClassMethod GetKpiDefinition(pkpiName As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_BI_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(scbiAPI.impl).GetKpiDefinition(pkpiName)
        Do ##class(scbiAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateKpiDefinition(pkpiName As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_BI_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(scbiAPI.impl).UpdateKpiDefinition(pkpiName,pbody)
        Do ##class(scbiAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteKpiDefinition(pkpiName As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_BI_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(scbiAPI.impl).DeleteKpiDefinition(pkpiName)
        Do ##class(scbiAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetKpiDefinitions() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_BI_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(scbiAPI.impl).GetKpiDefinitions()
        Do ##class(scbiAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateKpiDefinition() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_BI_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(scbiAPI.impl).CreateKpiDefinition(pbody)
        Do ##class(scbiAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetKpiValue(pkpiName As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_BI_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(scbiAPI.impl).GetKpiValue(pkpiName)
        Do ##class(scbiAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetKpiListing(pkpiName As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_BI_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(scbiAPI.impl).GetKpiListing(pkpiName)
        Do ##class(scbiAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateKpiIssues() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_BI_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(scbiAPI.impl).UpdateKpiIssues(pbody)
        Do ##class(scbiAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CloseIssue(pissueId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_BI_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(scbiAPI.impl).CloseIssue(pissueId,pbody)
        Do ##class(scbiAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CompleteWorkflow(pissueId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_BI_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(scbiAPI.impl).CompleteWorkflow(pissueId,pbody)
        Do ##class(scbiAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod RunIssueAnalysis(pissueId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_BI_API","USE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If $isobject(%request.Content),%request.Content.Size>0 Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(scbiAPI.impl).RunIssueAnalysis(pissueId,.pbody)
        Do ##class(scbiAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(scbiAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scbiAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

}
