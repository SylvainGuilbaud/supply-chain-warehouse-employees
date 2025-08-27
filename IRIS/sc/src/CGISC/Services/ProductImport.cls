Class CGISC.Services.ProductImport Extends Ens.BusinessService
{

Parameter ADAPTER = "EnsLib.SQL.InboundAdapter";

Property Adapter As EnsLib.SQL.InboundAdapter;

Method OnProcessInput(pInput As %SQL.StatementResult, Output pOutput As %RegisteredObject) As %Status
{
        set tStatus = $$$OK
        Set product = ##class(SC.Data.Product).%New()
        set product.uid = pInput.Get("ProductId")
        set product.productFamily = pInput.Get("ProductFamilly")
        set product.type = "PHYSICALPRODUCT"
        set product.dataSource = pInput.Get("SupplierId")
        set product.productBrand = pInput.Get("SupplierName")
        set product.standardCost = pInput.Get("Price")
        set product.costCurrency = "euro"

        set tStatus = product.%Save()
        return tStatus
}

}
