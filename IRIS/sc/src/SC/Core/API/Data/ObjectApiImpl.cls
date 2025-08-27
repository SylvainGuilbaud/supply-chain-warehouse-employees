/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This class implements the APIs to get basic information of the supply chain data model,
/// such as listing all the supply chain objects in the model, or show the details of any
/// supply chain objects, or to add a custom attribute to an object.
Class SC.Core.API.Data.ObjectApiImpl Extends %REST.Impl [ ProcedureBlock ]
{

/// RegEx to check the attribute's name
Parameter ATTRIBUTEREGEX = "[a-z][A-Za-z0-9]{1,31}";

/// Returns the definition of a specified data object
ClassMethod GetObjectDefinitionByName(objectName As %String) As %DynamicObject [ Requires = "SC_Data_Model_API:Read" ]
{
    $$$AddAllRoleTemporary
    set className = "SC.Data."_objectName
    set c = ##class(%Dictionary.ClassDefinition).%OpenId(className,,.st)
    if $$$ISOK(st) {
        set resp = {}
        set resp.objectName = objectName
        set resp.className = className
        set resp.description = $zstrip(c.Description, "*C")
        // TODO: replace line return characters, and replace with single white space
        set attrs = ..GetClassProperties(className)
        set resp.attributes = attrs
        return resp
    }
    else {
        do ..%SetStatusCode("404")
        return {
            "status": "Failed",
            "Message": ("Object ["_objectName_"] not found.")
        }
    }
}

/// Get the list of all objects defined in the system
ClassMethod GetObjects() As %DynamicObject [ Requires = "SC_Data_Model_API:Read" ]
{
    $$$AddAllRoleTemporary
    set objArray = []
    set sql="select id, name, description, abstract, super, hidden, timecreated, timechanged " _ 
            " from %Dictionary.ClassDefinition where name like ?"
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql, "SC.Data.%")
    if ( rs.%SQLCODE = 0 ) {
        while ( rs.%Next() '= 0 ) {
            if ( rs.hidden < 1 ) {
                set o = {}
                set o.objectName = $piece(rs.name, ".Data.",2)
                set o.className = rs.name
                set o.description =  $zstrip(rs.description, "*C")
                /// New adding 51-57 to verify that the target classname is/isn't an cus obj
                set isCusObj = ##class(SC.Core.API.Data.CustomObjectApiImpl).IsCustomObject(o.objectName)
                if isCusObj = 1{
                    do o.%Set("isCustom",1,"boolean")
                }else{
                    do o.%Set("isCustom",0,"boolean")
                }
                do objArray.%Push(o)
            }
        }
    }
    else {
        if (rs.%SQLCODE = 100) { 
            do ..%SetStatusCode("404")
            
        } else {
            do ..%SetStatusCode("500")
        }
        return {
                "status": "Error",
                "errorCode": ("SQL["_rs.%SQLCODE),
                "errorMessage": (rs.%Message)
        } 
    }
    return objArray
}

/// Add a custom attribute to an object.
ClassMethod AddAttribute(objectName As %String, body As %DynamicObject) As %DynamicObject [ Requires = "SC_Data_Model_API:Write" ]
{
    $$$AddAllRoleTemporary
    set validDataTypes = $LISTFROMSTRING("String,Integer,Boolean,Numeric,DateTime,Date")
    set className = "SC.Data."_objectName
    set c = ##class(%Dictionary.ClassDefinition).%OpenId(className,,.st)
    if $$$ISOK(st) {
        set propName=body.name
        // check to see if the name of the attribute is correctly defined
        if (propName '= "") {

            /// check to see if the attribute name is a restricted/reserved word
            set reservedWordStatus = ##class(SC.Core.Util.RestrictedWordCheckerUtil).CheckIfWordIsRestricted(propName)
            if (reservedWordStatus) {
                do ..%SetStatusCode("400")
                return {
                    "Status" : "Error",
                    "Message" : (propName_" is a reserved word. Please use a different name.")
                }
            }
            
            /// check to see if the naming convention of attribute is proper
            set isValidAttributeName = $MATCH(propName, ..#ATTRIBUTEREGEX)
            if 'isValidAttributeName {
                do ..%SetStatusCode("400")
                return {
                    "Status" : "Error",
                    "Message" : ("Invalid name for attribute: "_propName)
                }
            }

            /// Added check to see if the property name already exists in the object
            set attributeList = ..GetObjectAttributes(className, .getObjectAttributesStatus)
            if $$$ISERR(getObjectAttributesStatus){
                do ..%SetStatusCode("500")
                return attributeList
            }
            /// iterate through all the existing property names to see if it matches with the new property name
            for i = 1:1:attributeList.Count(){
                set attrName = attributeList.GetAt(i)
                set attrNameLower = $ZCONVERT(attrName, "L")
                set propNameLower = $ZCONVERT(propName, "L")
                if (attrNameLower = propNameLower){
                    do ..%SetStatusCode("400")
                    return {
                        "Status" : "Error",
                        "Message" : (propName_" property already exists. Use a different property name")
                    }
                }
            }
        }else{
            do ..%SetStatusCode("400")
            return {
                "Status" : "Error",
                "Message" : "Attribute name needs to be defined and can not be an empty value"
            }
        }

        set dataType=body.dataType
        // Data validation for the type values    
        set dataType = $ZCONVERT($EXTRACT(dataType), "U")_$EXTRACT(dataType, 2, *)
        set location = $LISTFIND(validDataTypes, dataType)
        if location = 0{
            do ..%SetStatusCode("400")
            return {
                "status": "Error",
                "message": ("Invalid datatype provided "_dataType)
            }
        }

        set required=body.required
        set description = body.description
        set p = ##class(%Dictionary.PropertyDefinition).%New()
        set p.Name = propName
        set p.Description =  $zstrip(description, "*C")
        set p.Required = required
        set p.parent = c
        set p.Type = "%"_dataType
        // TODO: handle non primitive data types (objects) properly
        set p.SequenceNumber = ..GetMaxPropSequenceNumber(className) + 1
        set st = c.%Save()
        if $$$ISOK(st) && (dataType = "String") {
            // Set string attribute max length
            set maxlen = body.maxLength
            if maxlen '= 0 {
                set params = p.Parameters
                do params.SetAt(maxlen, "MAXLEN")
                set st = p.%Save()
            }
        }

        if $$$ISOK(st) {
            do $system.OBJ.Compile(className, "ck")
            write !,"Successfully added property [", propName, "] to class [", className, "]."
            return {
                "status": "Success",
                "message": ("Attribute ["_propName_"] was added to class ["_className_"] successfully")
            }  
        }
        else {
            do ..%SetStatusCode("500")
            return {
                "status": "Error",
                "message": ("Failed to save property ["_propName_"] to class ["_className_"].")
            }
        }
    }
    else {
        do ..%SetStatusCode("404")
        return {
            "status": "Error",
            "message": ("Object ["_objectName_"] does is not defined")
        }
    }
}

/// Helper method to return JSON for all properties of a class
ClassMethod GetClassProperties(className As %String) As %DynamicObject [ Requires = "SC_Data_Model_API:Read" ]
{
    $$$AddAllRoleTemporary
    set resp = []
    set sql="select id1, name, required, collection, type, description, origin, sqlFieldName " _ 
            "from %Dictionary.CompiledProperty where storable = 1 and parent=? order by SequenceNumber"
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql, className)
    if ( rs.%SQLCODE = 0 ) {
        while ( rs.%Next() '= 0 ) {
            set p = {}
            set p.name = rs.name
            set p.description = rs.description
            // TODO: remove line return characters, and replace with single white space.
            set type = rs.type
            if ( $find(type, "%Library.") = 10 ) set type =  $piece(rs.Type, ".", 2)
            set p.dataType = type
            if (rs.collection '= "") {
                set p.dataType = "collection of " _ type
            }
            ///set p.required = rs.required
            do p.%Set("required",rs.required,"boolean")
            set id = rs.id1
            set prop = ##class(%Dictionary.CompiledProperty).%OpenId(id)
            set maxlen = prop.Parameters.GetAt("MAXLEN")
            if maxlen '= "" {
                set p.maxLength = maxlen
            }
            set scale = prop.Parameters.GetAt("SCALE")
            if scale '= "" {
                set p.scale = scale
            }
            if $find(rs.origin, "SC.Core.") = 9 {
                ///set p.isCustom = 0
                do p.%Set("isCustom",0,"boolean")
            }
            else {
                ///set p.isCustom = 1
                do p.%Set("isCustom",1,"boolean")
            }
            do resp.%Push(p)
        }
    }
    else {
        if (rs.%SQLCODE = 100) { 
            do ..%SetStatusCode("404")
        } else {
            do ..%SetStatusCode("500")
        }
        set sc = $$$ERROR($$$SQLCode,rs.SQLCODE,rs.%Message)
        do $SYSTEM.Status.DisplayError(sc)
        return {
                "status": "Error",
                "errorCode": ("SQL["_rs.%SQLCODE),
                "errorMessage": (rs.%Message)
        } 
    }
    return resp
}

/// Find the largest property sequence number of a given class
ClassMethod GetMaxPropSequenceNumber(className As %String) As %Integer [ Requires = "SC_Data_Model_API:Read" ]
{
    $$$AddAllRoleTemporary
    set resp = 0
    set sql="select max(SequenceNumber) as val from %Dictionary.CompiledProperty where parent=?"
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql, className)
    if ( rs.%SQLCODE = 0 ) {
        if ( rs.%Next() '= 0 ) {
            set resp = rs.val
        }
    }
    else {
        if (rs.%SQLCODE = 100) { 
            do ..%SetStatusCode("404")
        } else {
            do ..%SetStatusCode("500")
        }
        set sc = $$$ERROR($$$SQLCode,rs.SQLCODE,rs.%Message)
        do $SYSTEM.Status.DisplayError(sc)
        $$$ThrowStatus(sc)
    }
    return resp
}

/// This method takes in the object name e.g (SC.Data.SalesOrder) and returns list of names of all the attributes of that object
ClassMethod GetObjectAttributes(className As %String, ByRef status As %Status) As %DynamicObject [ Requires = "SC_Data_Model_API:Read" ]
{
    $$$AddAllRoleTemporary
    set status = $$$OK
    set sql="select name as attributes from %Dictionary.CompiledProperty where storable = 1 and parent=? order by SequenceNumber"
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql, className)
    if rs.%SQLCODE < 0 {
        set status = $System.Status.Error(83,"SQL Error from get object attributes of object "_className)
        set err = {}
        do err.%Set("Staus", "Failed")
        set errMsgValue = "Failed to get attributes of object "_className_" by SQL Query"
        do err.%Set("Message",errMsgValue)
        return err
    }
    set attributes=##class(%ListOfDataTypes).%New()
    if ( rs.%SQLCODE = 0 ) {
        while (rs.%Next()){
            do attributes.Insert(rs.attributes)
        }
    }
    return attributes
}

}
