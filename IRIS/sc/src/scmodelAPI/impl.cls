/*
Copyright (c) 2025 by InterSystems Corporation.
Boston, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// API for InterSystems IRIS supply chain data model<br/>
/// Business logic class defined by OpenAPI in scmodelAPI.spec<br/>
/// Updated Aug 20, 2025 11:06:11
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
    set output =  ##class(SC.Core.API.Data.CustomObjectApiImpl).RefreshCustomDataObjectApi(, .restCode)
    do ..%SetStatusCode(restCode)
    return output
}

/// Create a new custom object and generate related data access APIs<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateCustomObject(body As %DynamicObject) As %DynamicObject [ Requires = "SC_Data_Model_API:Write" ]
{
    return ##class(SC.Core.API.Data.CustomObjectApiImpl).CreateCustomDataObject(body)
}

}
