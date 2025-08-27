/// API for InterSystems IRIS supply chain data model<br/>
/// Business logic class defined by OpenAPI in scmodelAPI.spec<br/>
/// Updated Août 21, 2025 12:16:59
Class scmodelAPI.impl Extends %REST.Impl [ ProcedureBlock ]
{

/// If ExposeServerExceptions is true, then details of internal errors will be exposed.
Parameter ExposeServerExceptions = 1;

/// Returns the definition of the specified data objects<br/>
/// The method arguments hold values for:<br/>
///     objectName, object name<br/>
ClassMethod GetObjectDefinitionByName(objectName As %String) As %DynamicObject [ Requires = "SC_Data_Model_API:Read" ]
{
    return ##class(SC.Core.API.Data.ObjectApiImpl).GetObjectDefinitionByName(objectName)
}

/// Get the list of all objects defined in the system
ClassMethod GetObjects() As %DynamicObject [ Requires = "SC_Data_Model_API:Read" ]
{
    return ##class(SC.Core.API.Data.ObjectApiImpl).GetObjects()
}

/// Add a custom attribute to an object<br/>
/// The method arguments hold values for:<br/>
///     objectName, Object name<br/>
///     body<br/>
ClassMethod AddAttribute(objectName As %String, body As %DynamicObject) As %DynamicObject [ Requires = "SC_Data_Model_API:Write" ]
{
    return ##class(SC.Core.API.Data.ObjectApiImpl).AddAttribute(objectName, body)
}

/// Generate/Update Custom API for User-defined object
ClassMethod UpdateApiJSON() As %DynamicObject [ Requires = "SC_Data_Model_API:Write" ]
{
    return ##class(SC.Core.API.Data.CustomObjectApiImpl).RefreshCustomDataObjectApi()
}

/// Create a new custom object and generate related data access APIs<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateCustomObject(body As %DynamicObject) As %DynamicObject [ Requires = "SC_Data_Model_API:Write" ]
{
    //(Place business logic here)
    //Do ..%SetStatusCode(<HTTP_status_code>)
    //Do ..%SetHeader(<name>,<value>)
    //Quit (Place response here) ; response may be a string, stream or dynamic object
    return ##class(SC.Core.API.Data.CustomObjectApiImpl).CreateCustomDataObject(body)
}

}
