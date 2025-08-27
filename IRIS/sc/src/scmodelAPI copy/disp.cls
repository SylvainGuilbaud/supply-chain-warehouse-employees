/// API for InterSystems IRIS supply chain data model
/// Dispatch class defined by RESTSpec in scmodelAPI.spec
Class scmodelAPI.disp Extends %CSP.REST [ GeneratedBy = scmodelAPI.spec.cls, ProcedureBlock ]
{

Parameter HandleCorsRequest = 1;

/// The class containing the RESTSpec which generated this class
Parameter SpecificationClass = "scmodelAPI.spec";

/// Ignore any writes done directly by the REST method.
Parameter IgnoreWrites = 1;

/// Default the Content-Type for this application.
Parameter CONTENTTYPE = "application/json";

/// By default convert the input stream to Unicode
Parameter CONVERTINPUTSTREAM = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/objects/:objectName" Method="get" Call="GetObjectDefinitionByName" />
  <Route Url="/objects" Method="get" Call="GetObjects" />
  <Route Url="/objects" Method="post" Call="CreateCustomObject" />
  <Route Url="/attributes/:objectName" Method="post" Call="AddAttribute" />
  <Route Url="/updatecustomapi" Method="post" Call="UpdateApiJSON" />
</Routes>
}

ClassMethod GetObjectDefinitionByName(pobjectName As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_Model_API","Read") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(scmodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(scmodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(scmodelAPI.impl).GetObjectDefinitionByName(pobjectName)
        Do ##class(scmodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(scmodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scmodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scmodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetObjects() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_Model_API","Read") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(scmodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(scmodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(scmodelAPI.impl).GetObjects()
        Do ##class(scmodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(scmodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scmodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scmodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateCustomObject() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_Model_API","Write") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(scmodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(scmodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(scmodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(scmodelAPI.impl).CreateCustomObject(pbody)
        Do ##class(scmodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(scmodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scmodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scmodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod AddAttribute(pobjectName As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_Model_API","Write") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(scmodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(scmodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(scmodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(scmodelAPI.impl).AddAttribute(pobjectName,pbody)
        Do ##class(scmodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(scmodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scmodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scmodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateApiJSON() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_Model_API","Write") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(scmodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(scmodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(scmodelAPI.impl).UpdateApiJSON()
        Do ##class(scmodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(scmodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scmodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("scmodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

}
