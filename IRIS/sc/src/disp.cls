/// API for InterSystems IRIS supply chain data model
/// Dispatch class defined by RESTSpec in datamodelAPI.spec
Class datamodelAPI.disp Extends %CSP.REST [ GeneratedBy = datamodelAPI.spec.cls, ProcedureBlock ]
{

Parameter HandleCorsRequest = 1;

/// The class containing the RESTSpec which generated this class
Parameter SpecificationClass = "datamodelAPI.spec";

/// Ignore any writes done directly by the REST method.
Parameter IgnoreWrites = 1;

/// Default the Content-Type for this application.
Parameter CONTENTTYPE = "application/json";

/// By default convert the input stream to Unicode
Parameter CONVERTINPUTSTREAM = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/backend-version" Method="get" Call="GetBackendVersion" />
  <Route Url="/objects/:objectName" Method="get" Call="GetObjectDefinitionByName" />
  <Route Url="/objects" Method="get" Call="GetObjects" />
  <Route Url="/attributes/:objectName" Method="post" Call="AddAttribute" />
  <Route Url="/customers/:customerId" Method="get" Call="GetCustomerById" />
  <Route Url="/customers/:customerId" Method="put" Call="UpdateCustomer" />
  <Route Url="/customers/:customerId" Method="delete" Call="DeleteCustomer" />
  <Route Url="/customers" Method="get" Call="GetCustomers" />
  <Route Url="/customers" Method="post" Call="CreateCustomer" />
  <Route Url="/locations/:locationId" Method="get" Call="GetLocationById" />
  <Route Url="/locations/:locationId" Method="put" Call="UpdateLocation" />
  <Route Url="/locations/:locationId" Method="delete" Call="DeleteLocation" />
  <Route Url="/locations" Method="get" Call="GetLocations" />
  <Route Url="/locations" Method="post" Call="CreateLocation" />
  <Route Url="/salesorders/:orderId" Method="get" Call="GetSalesOrderById" />
  <Route Url="/salesorders/:orderId" Method="put" Call="UpdateSalesOrder" />
  <Route Url="/salesorders/:orderId" Method="delete" Call="DeleteSalesOrder" />
  <Route Url="/salesorders" Method="get" Call="GetSalesOrders" />
  <Route Url="/salesorders" Method="post" Call="CreateSalesOrder" />
  <Route Url="/salesorderlines/:lineId" Method="get" Call="GetSalesOrderLineById" />
  <Route Url="/salesorderlines/:lineId" Method="put" Call="UpdateSalesOrderLine" />
  <Route Url="/salesorderlines/:lineId" Method="delete" Call="DeleteSalesOrderLine" />
  <Route Url="/salesorderlines" Method="get" Call="GetSalesOrderLines" />
  <Route Url="/salesorderlines" Method="post" Call="CreateSalesOrderLine" />
  <Route Url="/products/:productId" Method="get" Call="GetProductById" />
  <Route Url="/products/:productId" Method="put" Call="UpdateProduct" />
  <Route Url="/products/:productId" Method="delete" Call="DeleteProduct" />
  <Route Url="/products" Method="get" Call="GetProducts" />
  <Route Url="/products" Method="post" Call="CreateProduct" />
  <Route Url="/carriers/:carrierId" Method="get" Call="GetCarrierById" />
  <Route Url="/carriers/:carrierId" Method="put" Call="UpdateCarrier" />
  <Route Url="/carriers/:carrierId" Method="delete" Call="DeleteCarrier" />
  <Route Url="/carriers" Method="get" Call="GetCarriers" />
  <Route Url="/carriers" Method="post" Call="CreateCarrier" />
  <Route Url="/suppliers/:supplierId" Method="get" Call="GetSupplierById" />
  <Route Url="/suppliers/:supplierId" Method="put" Call="UpdateSupplier" />
  <Route Url="/suppliers/:supplierId" Method="delete" Call="DeleteSupplier" />
  <Route Url="/suppliers" Method="get" Call="GetSuppliers" />
  <Route Url="/suppliers" Method="post" Call="CreateSupplier" />
  <Route Url="/billofmaterials/:bomId" Method="get" Call="GetBOMById" />
  <Route Url="/billofmaterials/:bomId" Method="put" Call="UpdateBOM" />
  <Route Url="/billofmaterials/:bomId" Method="delete" Call="DeleteBOM" />
  <Route Url="/billofmaterials" Method="get" Call="GetBOMs" />
  <Route Url="/billofmaterials" Method="post" Call="CreateBOM" />
  <Route Url="/demandplans/:planId" Method="get" Call="GetDemandPlanById" />
  <Route Url="/demandplans/:planId" Method="put" Call="UpdateDemandPlan" />
  <Route Url="/demandplans/:planId" Method="delete" Call="DeleteDemandPlan" />
  <Route Url="/demandplans" Method="get" Call="GetDemandPlans" />
  <Route Url="/demandplans" Method="post" Call="CreateDemandPlan" />
  <Route Url="/scexceptions/:exceptionId" Method="get" Call="GetExceptionById" />
  <Route Url="/scexceptions/:exceptionId" Method="put" Call="UpdateException" />
  <Route Url="/scexceptions/:exceptionId" Method="delete" Call="DeleteException" />
  <Route Url="/scexceptions" Method="get" Call="GetExceptions" />
  <Route Url="/scexceptions" Method="post" Call="CreateException" />
  <Route Url="/inventorythresholds/:inventoryThresholdId" Method="get" Call="GetInventoryThresholdById" />
  <Route Url="/inventorythresholds/:inventoryThresholdId" Method="put" Call="UpdateInventoryThreshold" />
  <Route Url="/inventorythresholds/:inventoryThresholdId" Method="delete" Call="DeleteInventoryThreshold" />
  <Route Url="/inventorythresholds" Method="get" Call="GetInventoryThresholds" />
  <Route Url="/inventorythresholds" Method="post" Call="CreateInventoryThreshold" />
  <Route Url="/manufacturingorders/:orderId" Method="get" Call="GetMfgOrderById" />
  <Route Url="/manufacturingorders/:orderId" Method="put" Call="UpdateMfgOrder" />
  <Route Url="/manufacturingorders/:orderId" Method="delete" Call="DeleteMfgOrder" />
  <Route Url="/manufacturingorders" Method="get" Call="GetMfgOrders" />
  <Route Url="/manufacturingorders" Method="post" Call="CreateMfgOrder" />
  <Route Url="/labordeficits" Method="get" Call="GetLaborDeficits" />
  <Route Url="/leadtimevariants/:leadtimeVariantId" Method="get" Call="GetLeadtimeVariantById" />
  <Route Url="/leadtimevariants/:leadtimeVariantId" Method="put" Call="UpdateLeadtimeVariant" />
  <Route Url="/leadtimevariants/:leadtimeVariantId" Method="delete" Call="DeleteLeadtimeVariant" />
  <Route Url="/leadtimevariants" Method="get" Call="GetLeadtimeVariants" />
  <Route Url="/leadtimevariants" Method="post" Call="CreateLeadtimeVariant" />
  <Route Url="/milestones/:milestoneId" Method="get" Call="GetMilestoneById" />
  <Route Url="/milestones/:milestoneId" Method="put" Call="UpdateMilestone" />
  <Route Url="/milestones/:milestoneId" Method="delete" Call="DeleteMilestone" />
  <Route Url="/milestones" Method="get" Call="GetMilestones" />
  <Route Url="/milestones" Method="post" Call="CreateMilestone" />
  <Route Url="/productsuppliers/:prodSuplId" Method="get" Call="GetProductSupplierById" />
  <Route Url="/productsuppliers/:prodSuplId" Method="put" Call="UpdateProductSupplier" />
  <Route Url="/productsuppliers/:prodSuplId" Method="delete" Call="DeleteProductSupplier" />
  <Route Url="/productsuppliers" Method="get" Call="GetProductSuppliers" />
  <Route Url="/productsuppliers" Method="post" Call="CreateProductSupplier" />
  <Route Url="/slas/:slaId" Method="get" Call="GetSLAById" />
  <Route Url="/slas/:slaId" Method="put" Call="UpdateSLA" />
  <Route Url="/slas/:slaId" Method="delete" Call="DeleteSLA" />
  <Route Url="/slas" Method="get" Call="GetSLAs" />
  <Route Url="/slas" Method="post" Call="CreateSLA" />
  <Route Url="/supplyplans/:planId" Method="get" Call="GetSupplyPlanById" />
  <Route Url="/supplyplans/:planId" Method="put" Call="UpdateSupplyPlan" />
  <Route Url="/supplyplans/:planId" Method="delete" Call="DeleteSupplyPlan" />
  <Route Url="/supplyplans" Method="get" Call="GetSupplyPlans" />
  <Route Url="/supplyplans" Method="post" Call="CreateSupplyPlan" />
  <Route Url="/productinventories/:inventoryId" Method="get" Call="GetProductInventoryById" />
  <Route Url="/productinventories/:inventoryId" Method="put" Call="UpdateProductInventory" />
  <Route Url="/productinventories/:inventoryId" Method="delete" Call="DeleteProductInventory" />
  <Route Url="/productinventories" Method="get" Call="GetProductInventories" />
  <Route Url="/productinventories" Method="post" Call="CreateProductInventory" />
  <Route Url="/purchaseorders/:orderId" Method="get" Call="GetPurchaseOrderById" />
  <Route Url="/purchaseorders/:orderId" Method="put" Call="UpdatePurchaseOrder" />
  <Route Url="/purchaseorders/:orderId" Method="delete" Call="DeletePurchaseOrder" />
  <Route Url="/purchaseorders" Method="get" Call="GetPurchaseOrders" />
  <Route Url="/purchaseorders" Method="post" Call="CreatePurchaseOrder" />
  <Route Url="/purchaseorderlines/:lineId" Method="get" Call="GetPurchaseOrderLineById" />
  <Route Url="/purchaseorderlines/:lineId" Method="put" Call="UpdatePurchaseOrderLine" />
  <Route Url="/purchaseorderlines/:lineId" Method="delete" Call="DeletePurchaseOrderLine" />
  <Route Url="/purchaseorderlines" Method="get" Call="GetPurchaseOrderLines" />
  <Route Url="/purchaseorderlines" Method="post" Call="CreatePurchaseOrderLine" />
  <Route Url="/salesshipments/:shipmentId" Method="get" Call="GetSalesShipmentById" />
  <Route Url="/salesshipments/:shipmentId" Method="put" Call="UpdateSalesShipment" />
  <Route Url="/salesshipments/:shipmentId" Method="delete" Call="DeleteSalesShipment" />
  <Route Url="/salesshipments" Method="get" Call="GetSalesShipments" />
  <Route Url="/salesshipments" Method="post" Call="CreateSalesShipment" />
  <Route Url="/salesshipmentlines/:lineId" Method="get" Call="GetSalesShipmentLineById" />
  <Route Url="/salesshipmentlines/:lineId" Method="put" Call="UpdateSalesShipmentLine" />
  <Route Url="/salesshipmentlines/:lineId" Method="delete" Call="DeleteSalesShipmentLine" />
  <Route Url="/salesshipmentlines" Method="get" Call="GetSalesShipmentLines" />
  <Route Url="/salesshipmentlines" Method="post" Call="CreateSalesShipmentLine" />
  <Route Url="/supplyshipments/:shipmentId" Method="get" Call="GetSupplyShipmentById" />
  <Route Url="/supplyshipments/:shipmentId" Method="put" Call="UpdateSupplyShipment" />
  <Route Url="/supplyshipments/:shipmentId" Method="delete" Call="DeleteSupplyShipment" />
  <Route Url="/supplyshipments" Method="get" Call="GetSupplyShipments" />
  <Route Url="/supplyshipments" Method="post" Call="CreateSupplyShipment" />
  <Route Url="/supplyshipmentlines/:lineId" Method="get" Call="GetSupplyShipmentLineById" />
  <Route Url="/supplyshipmentlines/:lineId" Method="put" Call="UpdateSupplyShipmentLine" />
  <Route Url="/supplyshipmentlines/:lineId" Method="delete" Call="DeleteSupplyShipmentLine" />
  <Route Url="/supplyshipmentlines" Method="get" Call="GetSupplyShipmentLines" />
  <Route Url="/supplyshipmentlines" Method="post" Call="CreateSupplyShipmentLine" />
  <Route Url="/productioncapacities/:productionCapacityId" Method="get" Call="GetProductionCapacityById" />
  <Route Url="/productioncapacities/:productionCapacityId" Method="put" Call="UpdateProductionCapacity" />
  <Route Url="/productioncapacities/:productionCapacityId" Method="delete" Call="DeleteProductionCapacity" />
  <Route Url="/productioncapacities" Method="get" Call="GetProductionCapacities" />
  <Route Url="/productioncapacities" Method="post" Call="CreateProductionCapacity" />
  <Route Url="/shippingcosts/:shippingCostId" Method="get" Call="GetShippingCostById" />
  <Route Url="/shippingcosts/:shippingCostId" Method="put" Call="UpdateShippingCost" />
  <Route Url="/shippingcosts/:shippingCostId" Method="delete" Call="DeleteShippingCost" />
  <Route Url="/shippingcosts" Method="get" Call="GetShippingCosts" />
  <Route Url="/shippingcosts" Method="post" Call="CreateShippingCost" />
  <Route Url="/issues/:issueId" Method="get" Call="GetIssueById" />
  <Route Url="/issues/:issueId" Method="put" Call="UpdateIssue" />
  <Route Url="/issues/:issueId" Method="delete" Call="DeleteIssue" />
  <Route Url="/issues" Method="get" Call="GetIssues" />
  <Route Url="/issues" Method="post" Call="CreateIssue" />
  <Route Url="/routelegs/:routeLegId" Method="get" Call="GetRouteLegById" />
  <Route Url="/routelegs/:routeLegId" Method="put" Call="UpdateRouteLeg" />
  <Route Url="/routelegs/:routeLegId" Method="delete" Call="DeleteRouteLeg" />
  <Route Url="/routelegs" Method="get" Call="GetRouteLegs" />
  <Route Url="/routelegs" Method="post" Call="CreateRouteLeg" />
  <Route Url="/predictedinventories" Method="get" Call="GetPredictedInventories" />
  <Route Url="/bulkupload/:uploadId" Method="get" Call="GetUploadStatus" />
  <Route Url="/bulkupload/contents/:uploadId" Method="get" Call="ReturnFile" />
  <Route Url="/bulkupload/details/uploadIds" Method="get" Call="GetUploadIds" />
  <Route Url="/bulkupload/error" Method="post" Call="GetRowErrors" />
  <Route Url="/bulkupload" Method="post" Call="UploadData" />
  <Route Url="/shipmentmilestones/:shipmentMilestoneId" Method="get" Call="GetShipmentMilestoneById" />
  <Route Url="/shipmentmilestones/:shipmentMilestoneId" Method="put" Call="UpdateShipmentMilestone" />
  <Route Url="/shipmentmilestones/:shipmentMilestoneId" Method="delete" Call="DeleteShipmentMilestone" />
  <Route Url="/shipmentmilestones" Method="get" Call="GetShipmentMilestones" />
  <Route Url="/shipmentmilestones" Method="post" Call="CreateShipmentMilestone" />
  <Route Url="/shipmentstops/:shipmentStopId" Method="get" Call="GetShipmentStopById" />
  <Route Url="/shipmentstops/:shipmentStopId" Method="put" Call="UpdateShipmentStop" />
  <Route Url="/shipmentstops/:shipmentStopId" Method="delete" Call="DeleteShipmentStop" />
  <Route Url="/shipmentstops" Method="get" Call="GetShipmentStops" />
  <Route Url="/shipmentstops" Method="post" Call="CreateShipmentStop" />
  <Route Url="/shipmenttrackings/:shipmentTrackingId" Method="get" Call="GetShipmentTrackingById" />
  <Route Url="/shipmenttrackings/:shipmentTrackingId" Method="put" Call="UpdateShipmentTracking" />
  <Route Url="/shipmenttrackings/:shipmentTrackingId" Method="delete" Call="DeleteShipmentTracking" />
  <Route Url="/shipmenttrackings" Method="get" Call="GetShipmentTrackings" />
  <Route Url="/shipmenttrackings" Method="post" Call="CreateShipmentTracking" />
  <Route Url="/trackingservices/:trackingServiceId" Method="get" Call="GetTrackingServiceById" />
  <Route Url="/trackingservices/:trackingServiceId" Method="put" Call="UpdateTrackingService" />
  <Route Url="/trackingservices/:trackingServiceId" Method="delete" Call="DeleteTrackingService" />
  <Route Url="/trackingservices" Method="get" Call="GetTrackingServices" />
  <Route Url="/trackingservices" Method="post" Call="CreateTrackingService" />
  <Route Url="/serviceslas/:serviceSLAId" Method="get" Call="GetServiceSLAById" />
  <Route Url="/serviceslas/:serviceSLAId" Method="put" Call="UpdateServiceSLA" />
  <Route Url="/serviceslas/:serviceSLAId" Method="delete" Call="DeleteServiceSLA" />
  <Route Url="/serviceslas" Method="get" Call="GetServiceSLAs" />
  <Route Url="/serviceslas" Method="post" Call="CreateServiceSLA" />
</Routes>
}

ClassMethod GetBackendVersion() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","USE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("text/plain")
        If '##class(%REST.Impl).%CheckAccepts("text/plain") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetBackendVersion()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetObjectDefinitionByName(pobjectName As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetObjectDefinitionByName(pobjectName)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetObjects() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetObjects()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod AddAttribute(pobjectName As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).AddAttribute(pobjectName,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetCustomerById(pcustomerId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetCustomerById(pcustomerId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateCustomer(pcustomerId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateCustomer(pcustomerId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteCustomer(pcustomerId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteCustomer(pcustomerId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetCustomers() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetCustomers()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateCustomer() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateCustomer(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetLocationById(plocationId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetLocationById(plocationId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateLocation(plocationId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateLocation(plocationId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteLocation(plocationId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteLocation(plocationId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetLocations() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetLocations()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateLocation() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateLocation(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetSalesOrderById(porderId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetSalesOrderById(porderId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateSalesOrder(porderId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateSalesOrder(porderId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteSalesOrder(porderId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteSalesOrder(porderId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetSalesOrders() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If $data(%request.Data("pageSize",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"pageSize")) Quit
        }
        If $data(%request.Data("pageSize",1)) {
            Set ppageSize=%request.Data("pageSize",1)
            If ($number(ppageSize,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"pageSize",ppageSize)) Quit
        }
        If $data(%request.Data("pageIndex",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"pageIndex")) Quit
        }
        If $data(%request.Data("pageIndex",1)) {
            Set ppageIndex=%request.Data("pageIndex",1)
            If ($number(ppageIndex,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"pageIndex",ppageIndex)) Quit
        }
        Set response=##class(datamodelAPI.impl).GetSalesOrders(.ppageSize,.ppageIndex)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateSalesOrder() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateSalesOrder(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetSalesOrderLineById(plineId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetSalesOrderLineById(plineId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateSalesOrderLine(plineId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateSalesOrderLine(plineId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteSalesOrderLine(plineId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteSalesOrderLine(plineId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetSalesOrderLines() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If $data(%request.Data("pageSize",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"pageSize")) Quit
        }
        If $data(%request.Data("pageSize",1)) {
            Set ppageSize=%request.Data("pageSize",1)
            If ($number(ppageSize,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"pageSize",ppageSize)) Quit
        }
        If $data(%request.Data("pageIndex",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"pageIndex")) Quit
        }
        If $data(%request.Data("pageIndex",1)) {
            Set ppageIndex=%request.Data("pageIndex",1)
            If ($number(ppageIndex,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"pageIndex",ppageIndex)) Quit
        }
        Set response=##class(datamodelAPI.impl).GetSalesOrderLines(.ppageSize,.ppageIndex)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateSalesOrderLine() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateSalesOrderLine(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetProductById(pproductId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetProductById(pproductId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateProduct(pproductId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateProduct(pproductId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteProduct(pproductId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteProduct(pproductId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetProducts() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetProducts()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateProduct() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateProduct(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetCarrierById(pcarrierId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetCarrierById(pcarrierId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateCarrier(pcarrierId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateCarrier(pcarrierId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteCarrier(pcarrierId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteCarrier(pcarrierId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetCarriers() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetCarriers()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateCarrier() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateCarrier(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetSupplierById(psupplierId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetSupplierById(psupplierId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateSupplier(psupplierId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateSupplier(psupplierId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteSupplier(psupplierId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteSupplier(psupplierId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetSuppliers() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetSuppliers()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateSupplier() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateSupplier(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetBOMById(pbomId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetBOMById(pbomId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateBOM(pbomId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateBOM(pbomId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteBOM(pbomId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteBOM(pbomId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetBOMs() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetBOMs()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateBOM() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateBOM(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetDemandPlanById(pplanId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetDemandPlanById(pplanId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateDemandPlan(pplanId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateDemandPlan(pplanId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteDemandPlan(pplanId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteDemandPlan(pplanId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetDemandPlans() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetDemandPlans()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateDemandPlan() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateDemandPlan(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetExceptionById(pexceptionId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetExceptionById(pexceptionId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateException(pexceptionId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateException(pexceptionId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteException(pexceptionId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteException(pexceptionId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetExceptions() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetExceptions()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateException() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateException(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetInventoryThresholdById(pinventoryThresholdId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetInventoryThresholdById(pinventoryThresholdId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateInventoryThreshold(pinventoryThresholdId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateInventoryThreshold(pinventoryThresholdId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteInventoryThreshold(pinventoryThresholdId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteInventoryThreshold(pinventoryThresholdId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetInventoryThresholds() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetInventoryThresholds()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateInventoryThreshold() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateInventoryThreshold(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetMfgOrderById(porderId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetMfgOrderById(porderId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateMfgOrder(porderId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateMfgOrder(porderId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteMfgOrder(porderId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteMfgOrder(porderId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetMfgOrders() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetMfgOrders()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateMfgOrder() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateMfgOrder(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetLaborDeficits() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetLaborDeficits()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetLeadtimeVariantById(pleadtimeVariantId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetLeadtimeVariantById(pleadtimeVariantId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateLeadtimeVariant(pleadtimeVariantId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateLeadtimeVariant(pleadtimeVariantId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteLeadtimeVariant(pleadtimeVariantId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteLeadtimeVariant(pleadtimeVariantId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetLeadtimeVariants() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetLeadtimeVariants()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateLeadtimeVariant() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateLeadtimeVariant(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetMilestoneById(pmilestoneId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetMilestoneById(pmilestoneId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateMilestone(pmilestoneId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateMilestone(pmilestoneId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteMilestone(pmilestoneId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteMilestone(pmilestoneId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetMilestones() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetMilestones()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateMilestone() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateMilestone(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetProductSupplierById(pprodSuplId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetProductSupplierById(pprodSuplId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateProductSupplier(pprodSuplId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateProductSupplier(pprodSuplId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteProductSupplier(pprodSuplId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteProductSupplier(pprodSuplId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetProductSuppliers() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetProductSuppliers()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateProductSupplier() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateProductSupplier(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetSLAById(pslaId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetSLAById(pslaId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateSLA(pslaId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateSLA(pslaId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteSLA(pslaId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteSLA(pslaId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetSLAs() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetSLAs()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateSLA() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateSLA(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetSupplyPlanById(pplanId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetSupplyPlanById(pplanId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateSupplyPlan(pplanId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateSupplyPlan(pplanId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteSupplyPlan(pplanId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteSupplyPlan(pplanId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetSupplyPlans() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetSupplyPlans()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateSupplyPlan() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateSupplyPlan(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetProductInventoryById(pinventoryId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetProductInventoryById(pinventoryId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateProductInventory(pinventoryId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateProductInventory(pinventoryId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteProductInventory(pinventoryId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteProductInventory(pinventoryId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetProductInventories() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetProductInventories()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateProductInventory() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateProductInventory(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetPurchaseOrderById(porderId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetPurchaseOrderById(porderId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdatePurchaseOrder(porderId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdatePurchaseOrder(porderId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeletePurchaseOrder(porderId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeletePurchaseOrder(porderId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetPurchaseOrders() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If $data(%request.Data("pageSize",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"pageSize")) Quit
        }
        If $data(%request.Data("pageSize",1)) {
            Set ppageSize=%request.Data("pageSize",1)
            If ($number(ppageSize,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"pageSize",ppageSize)) Quit
        }
        If $data(%request.Data("pageIndex",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"pageIndex")) Quit
        }
        If $data(%request.Data("pageIndex",1)) {
            Set ppageIndex=%request.Data("pageIndex",1)
            If ($number(ppageIndex,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"pageIndex",ppageIndex)) Quit
        }
        Set response=##class(datamodelAPI.impl).GetPurchaseOrders(.ppageSize,.ppageIndex)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreatePurchaseOrder() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreatePurchaseOrder(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetPurchaseOrderLineById(plineId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetPurchaseOrderLineById(plineId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdatePurchaseOrderLine(plineId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdatePurchaseOrderLine(plineId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeletePurchaseOrderLine(plineId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeletePurchaseOrderLine(plineId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetPurchaseOrderLines() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If $data(%request.Data("pageSize",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"pageSize")) Quit
        }
        If $data(%request.Data("pageSize",1)) {
            Set ppageSize=%request.Data("pageSize",1)
            If ($number(ppageSize,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"pageSize",ppageSize)) Quit
        }
        If $data(%request.Data("pageIndex",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"pageIndex")) Quit
        }
        If $data(%request.Data("pageIndex",1)) {
            Set ppageIndex=%request.Data("pageIndex",1)
            If ($number(ppageIndex,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"pageIndex",ppageIndex)) Quit
        }
        Set response=##class(datamodelAPI.impl).GetPurchaseOrderLines(.ppageSize,.ppageIndex)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreatePurchaseOrderLine() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreatePurchaseOrderLine(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetSalesShipmentById(pshipmentId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetSalesShipmentById(pshipmentId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateSalesShipment(pshipmentId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateSalesShipment(pshipmentId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteSalesShipment(pshipmentId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteSalesShipment(pshipmentId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetSalesShipments() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If $data(%request.Data("pageSize",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"pageSize")) Quit
        }
        If $data(%request.Data("pageSize",1)) {
            Set ppageSize=%request.Data("pageSize",1)
            If ($number(ppageSize,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"pageSize",ppageSize)) Quit
        }
        If $data(%request.Data("pageIndex",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"pageIndex")) Quit
        }
        If $data(%request.Data("pageIndex",1)) {
            Set ppageIndex=%request.Data("pageIndex",1)
            If ($number(ppageIndex,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"pageIndex",ppageIndex)) Quit
        }
        Set response=##class(datamodelAPI.impl).GetSalesShipments(.ppageSize,.ppageIndex)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateSalesShipment() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateSalesShipment(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetSalesShipmentLineById(plineId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetSalesShipmentLineById(plineId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateSalesShipmentLine(plineId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateSalesShipmentLine(plineId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteSalesShipmentLine(plineId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteSalesShipmentLine(plineId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetSalesShipmentLines() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If $data(%request.Data("pageSize",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"pageSize")) Quit
        }
        If $data(%request.Data("pageSize",1)) {
            Set ppageSize=%request.Data("pageSize",1)
            If ($number(ppageSize,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"pageSize",ppageSize)) Quit
        }
        If $data(%request.Data("pageIndex",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"pageIndex")) Quit
        }
        If $data(%request.Data("pageIndex",1)) {
            Set ppageIndex=%request.Data("pageIndex",1)
            If ($number(ppageIndex,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"pageIndex",ppageIndex)) Quit
        }
        Set response=##class(datamodelAPI.impl).GetSalesShipmentLines(.ppageSize,.ppageIndex)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateSalesShipmentLine() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateSalesShipmentLine(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetSupplyShipmentById(pshipmentId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetSupplyShipmentById(pshipmentId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateSupplyShipment(pshipmentId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateSupplyShipment(pshipmentId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteSupplyShipment(pshipmentId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteSupplyShipment(pshipmentId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetSupplyShipments() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If $data(%request.Data("pageSize",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"pageSize")) Quit
        }
        If $data(%request.Data("pageSize",1)) {
            Set ppageSize=%request.Data("pageSize",1)
            If ($number(ppageSize,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"pageSize",ppageSize)) Quit
        }
        If $data(%request.Data("pageIndex",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"pageIndex")) Quit
        }
        If $data(%request.Data("pageIndex",1)) {
            Set ppageIndex=%request.Data("pageIndex",1)
            If ($number(ppageIndex,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"pageIndex",ppageIndex)) Quit
        }
        Set response=##class(datamodelAPI.impl).GetSupplyShipments(.ppageSize,.ppageIndex)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateSupplyShipment() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateSupplyShipment(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetSupplyShipmentLineById(plineId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetSupplyShipmentLineById(plineId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateSupplyShipmentLine(plineId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateSupplyShipmentLine(plineId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteSupplyShipmentLine(plineId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteSupplyShipmentLine(plineId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetSupplyShipmentLines() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If $data(%request.Data("pageSize",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"pageSize")) Quit
        }
        If $data(%request.Data("pageSize",1)) {
            Set ppageSize=%request.Data("pageSize",1)
            If ($number(ppageSize,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"pageSize",ppageSize)) Quit
        }
        If $data(%request.Data("pageIndex",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"pageIndex")) Quit
        }
        If $data(%request.Data("pageIndex",1)) {
            Set ppageIndex=%request.Data("pageIndex",1)
            If ($number(ppageIndex,"I")="") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"pageIndex",ppageIndex)) Quit
        }
        Set response=##class(datamodelAPI.impl).GetSupplyShipmentLines(.ppageSize,.ppageIndex)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateSupplyShipmentLine() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateSupplyShipmentLine(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetProductionCapacityById(pproductionCapacityId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetProductionCapacityById(pproductionCapacityId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateProductionCapacity(pproductionCapacityId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateProductionCapacity(pproductionCapacityId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteProductionCapacity(pproductionCapacityId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteProductionCapacity(pproductionCapacityId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetProductionCapacities() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetProductionCapacities()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateProductionCapacity() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateProductionCapacity(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetShippingCostById(pshippingCostId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetShippingCostById(pshippingCostId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateShippingCost(pshippingCostId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateShippingCost(pshippingCostId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteShippingCost(pshippingCostId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteShippingCost(pshippingCostId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetShippingCosts() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetShippingCosts()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateShippingCost() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateShippingCost(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetIssueById(pissueId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetIssueById(pissueId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateIssue(pissueId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateIssue(pissueId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteIssue(pissueId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteIssue(pissueId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetIssues() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetIssues()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateIssue() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateIssue(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetRouteLegById(prouteLegId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetRouteLegById(prouteLegId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateRouteLeg(prouteLegId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateRouteLeg(prouteLegId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteRouteLeg(prouteLegId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteRouteLeg(prouteLegId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetRouteLegs() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetRouteLegs()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateRouteLeg() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateRouteLeg(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetPredictedInventories() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetPredictedInventories()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetUploadStatus(puploadId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetUploadStatus(puploadId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod ReturnFile(puploadId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("text/csv")
        If '##class(%REST.Impl).%CheckAccepts("text/csv") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).ReturnFile(puploadId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetUploadIds() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetUploadIds()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetRowErrors() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).GetRowErrors(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UploadData() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"multipart/form-data":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If $data(%request.MimeData("file",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"file")) Quit
        }
        If $data(%request.MimeData("file",1)) {
            Set pfile=%request.MimeData("file",1)
            Set stream=##class(%GlobalCharacterStream).%New()
            If $isobject(pfile) {
                Do pfile.Rewind()
                Set sc=stream.CopyFrom(pfile)
            } Else {
                Set sc=stream.Write(pfile)
            }
            If $$$ISERR(sc) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTInvalid,"file",pfile)) Quit
            Set pfile=stream
        }
        If '$data(%request.Data("body",1)) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        If $data(%request.Data("body",2)) {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTDuplicate,"body")) Quit
        }
        Set pbody=%request.Data("body",1)
        Set response=##class(datamodelAPI.impl).UploadData(.pfile,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetShipmentMilestoneById(pshipmentMilestoneId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetShipmentMilestoneById(pshipmentMilestoneId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateShipmentMilestone(pshipmentMilestoneId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateShipmentMilestone(pshipmentMilestoneId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteShipmentMilestone(pshipmentMilestoneId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteShipmentMilestone(pshipmentMilestoneId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetShipmentMilestones() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetShipmentMilestones()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateShipmentMilestone() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateShipmentMilestone(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetShipmentStopById(pshipmentStopId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetShipmentStopById(pshipmentStopId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateShipmentStop(pshipmentStopId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateShipmentStop(pshipmentStopId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteShipmentStop(pshipmentStopId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteShipmentStop(pshipmentStopId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetShipmentStops() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetShipmentStops()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateShipmentStop() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateShipmentStop(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetShipmentTrackingById(pshipmentTrackingId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetShipmentTrackingById(pshipmentTrackingId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateShipmentTracking(pshipmentTrackingId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateShipmentTracking(pshipmentTrackingId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteShipmentTracking(pshipmentTrackingId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteShipmentTracking(pshipmentTrackingId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetShipmentTrackings() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetShipmentTrackings()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateShipmentTracking() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateShipmentTracking(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetTrackingServiceById(ptrackingServiceId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetTrackingServiceById(ptrackingServiceId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateTrackingService(ptrackingServiceId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateTrackingService(ptrackingServiceId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteTrackingService(ptrackingServiceId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteTrackingService(ptrackingServiceId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetTrackingServices() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetTrackingServices()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateTrackingService() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateTrackingService(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetServiceSLAById(pserviceSLAId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetServiceSLAById(pserviceSLAId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod UpdateServiceSLA(pserviceSLAId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).UpdateServiceSLA(pserviceSLAId,pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod DeleteServiceSLA(pserviceSLAId As %String) As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).DeleteServiceSLA(pserviceSLAId)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod GetServiceSLAs() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","READ") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        Set response=##class(datamodelAPI.impl).GetServiceSLAs()
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

ClassMethod CreateServiceSLA() As %Status
{
    Try {
        Set authorized=0
        Do {
            If '$system.Security.Check("SC_Data_API","WRITE") Quit
            Set authorized=1
        } While 0
        If 'authorized {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP403FORBIDDEN,$$$ERROR($$$RESTResource))
            }
            Quit
        }
        If $case(%request.ContentType,"application/json":0,:1) {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType))
            }
            Quit
        }
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") {
            Try {
                Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            } Catch {
                Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts))
            }
            Quit
        }
        If '$isobject(%request.Content) || (%request.Content.Size=0) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP400BADREQUEST,$$$ERROR($$$RESTRequired,"body")) Quit
        Set pbody=##class(%DynamicAbstractObject).%FromJSON(%request.Content)
        Set response=##class(datamodelAPI.impl).CreateServiceSLA(pbody)
        Do ##class(datamodelAPI.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(datamodelAPI.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("datamodelAPI.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

}
