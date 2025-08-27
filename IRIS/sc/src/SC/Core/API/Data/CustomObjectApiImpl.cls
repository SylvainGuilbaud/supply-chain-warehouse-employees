Class SC.Core.API.Data.CustomObjectApiImpl Extends (SC.Core.API.Data.DataApiBase, SC.Core.API.ApiBaseImpl, SC.Core.API.Data.ObjectApiImpl)
{

/// RegEx to check the object's name
Parameter OBJECTREGEX = "[A-Z][A-Za-z0-9]{1,31}";

/// RegEx to check the property's name
Parameter PROPERTYREGEX = "[a-z][A-Za-z0-9]{1,31}";

/// Method Description:
/// This is a end-point fucntion of create custom object by POST API
/// Input: "Body" from API
/// Output: Result of custom obejct generation
/// Returns: Error message if it exited
ClassMethod CreateCustomDataObject(block As %DynamicObject) As %DynamicObject [ Requires = "SC_Data_Model_API:Write" ]
{
    /*
        Marco logic for this fucntion

        1. Get the class/Custom Object name from block/body
        2. Handle Error checking case 
            a. objectName(class name) required
            b. attributes required
            c. objectName can not be null
        3. "while loop" to iterate attributes array
            a. Error handling for each attributes
            c. Isvalid(value) checking
        4. Insert valid properties to the new custom object
        5. Save and Compile the new custom object 
        6. Calling updataJSON to generate JSON document for the new custom Object 
        7. return responds*/

    set objectName = block.objectName
    $$$AddAllRoleTemporary
        set newCustomObj = ##class(%Dictionary.ClassDefinition).%New("SC.Data."_objectName)
        set newCustomObj.Super = "SC.Core.Data.CustomObjectBase"
        set newCustomObj.Description = block.description
        
        if '(block.%IsDefined("objectName")) || '(block.%IsDefined("attributes")) || (block.objectName = ""){
            do ..%SetStatusCode("500")
            return {
                "status":"Failed",
                "message": "Invalid input"
            }
        }

        /// Check the naming of the object and its properties
        set regexMsg = ..RegularExpressionAndReservedWordChecking(block, .regexStatus)

        if ( $$$ISERR(regexStatus) ) {
            do ..%SetStatusCode("500")
            return regexMsg
        }
    try{
        set iter = block.attributes.%GetIterator()
        while iter.%GetNext(.idx,.val){
            /* Error Checking 
                1. Property %IsDefinided checking 
                2. Property value is valid checking
            */
            if '(val.%IsDefined("name")){
                do ..%SetStatusCode("500")
                return {
                    "status":"Failed",
                    "message": ("Invalid attribute definition found for custom object ["_objectName_"]: property [name] must be defined.")
                }
            }
            if '(val.%IsDefined("dataType")){
                do ..%SetStatusCode("500")
                return {
                    "status":"Failed",
                    "message":  ("Invalid attribute definition found for custom object ["_objectName_"]: property [dataType] must be defined.")
                }
            }
            if '(val.%IsDefined("required")){
                do ..%SetStatusCode("500")
                return {
                    "status":"Failed",
                    "message": ("Invalid attribute definition found for custom object ["_objectName_"]: property [required] must be defined.")
                }
            }
            if (val.name = ""){
                do ..%SetStatusCode("500")
                return {
                    "status":"Failed",
                    "message":("Invalid attribute definition found for custom object ["_objectName_"]: property [name] can not be value null.")
                }
            }
            if (val.dataType = ""){
                do ..%SetStatusCode("500")
                return {
                    "status":"Failed",
                    "message": ("Invalid attribute definition found for custom object ["_objectName_"]: property [dataType] can not be value null.")
                }
            }
            if ((val.required '= 1)&&((val.required '= 0)) = 1){
                do ..%SetStatusCode("500")
                return {
                    "status":"Failed",
                    "message": ("Invalid attribute definition found for custom object ["_objectName_"]: property [required] can only be 1 or 0 [denotes True/False].")
                }
            }
            if (val.dataType = "string") || (val.dataType = "String"){
                if '(val.%IsDefined("maxLength")){
                    do ..%SetStatusCode("500")
                    return {
                        "status":"Failed",
                        "message": ("Invalid attribute definition found for custom object ["_objectName_"]: property [maxLength] is required if the dataType is string.")
                    }
                }
            } 

            /*
                Property's attributies and constraint set up
                    1. If the p.type is string, set the max len constraint for this p.attr
            */

            set property = ##class(%Dictionary.PropertyDefinition).%New("MyClass:"_val.name)
            set property.Type = "%"_val.dataType
            set property.Required = val.required
            if (val.%IsDefined("maxLength")) && ((val.dataType = "string")|| (val.dataType = "String")){
                ///set max len for current round property
                set maxlen = val.maxLength
                if maxlen > 0 {
                    set params = property.Parameters
                    do params.SetAt(maxlen, "MAXLEN")
                }else{
                    do ..%SetStatusCode("500")
                    return {
                        "status":"Failed",
                        "message": ("Invalid attribute definition found for custom object ["_objectName_"]: property [maxLength] is required if the dataType is string.")
                    }
                }
            }
            if val.%IsDefined("description") {
                set property.Description = $zstrip(val.description, "*C")
            }
            /// Insert the new property to the new obj 
            do newCustomObj.Properties.Insert(property)
        }
        ///Save and compile the custom object 
        set customObjSaveStatus = newCustomObj.%Save()
        if $$$ISERR(customObjSaveStatus){
            if ($SYSTEM.Status.GetErrorCodes(customObjSaveStatus) = "5805") || ($SYSTEM.Status.GetErrorCodes(customObjSaveStatus) = "5092")  {
                do ..%SetStatusCode("400")
                return {
                    "status": "Failed",
                    ///"Message" :($SYSTEM.Status.GetErrorText(customObjSaveStatus))
                    "Message" : ("Failed to create object "_objectName_" as the object already exists.")
                }
            }
            else {
                do ..%SetStatusCode("500")
                return {
                    "status": "Failed",
                    ///"Message" :($SYSTEM.Status.GetErrorText(customObjSaveStatus))
                    "Message" : ("Failed to save the object "_objectName_", system error message is "_($SYSTEM.Status.GetErrorText(customObjSaveStatus)))
                }
            }

        }        
    
        set copStatus = $SYSTEM.OBJ.Compile("SC.Data."_objectName,"ck-d")
        if $$$ISERR(copStatus){
            return {}
            do ..%SetStatusCode("500")
            return {
                "status": "Failed",
                ///"Message" :($SYSTEM.Status.GetErrorText(copStatus))
                "Message" : ("Failed to compile the object "_objectName_", system error message is "_($SYSTEM.Status.GetErrorText(copStatus)))
            }
        }
        /// Update the JSON To latest version 
        set refreshApiResult = ..RefreshCustomDataObjectApi(.updateSt)
        if $$$ISERR(updateSt){
            return refreshApiResult
        }
    }catch(ex){
        do ..%SetStatusCode("500")
        return {
            "status": "Failed",
            "Message" :("Failed to generate custom object "_objectName)
        }
    }

    /// Return Successed at the end
    return refreshApiResult
}

/// Method Description:
/// The method refresh the datamodelAPI.spec and remvoe expired object path from paths
/// Input: $ref status to catch nested error if it exists
/// Output: Result of the refresh operation
/// Returns: Error message if it exited, Or Successful responds 
ClassMethod RefreshCustomDataObjectApi(ByRef refStatus As %Status) As %DynamicObject [ Requires = "SC_Data_Model_API:Read" ]
{
    /* Marco logic of this function
    1. check if new Custom Object/Objects has been created
    2. if new custom objct has been detected:
        {
            a. remove the all current custon object from path
            b. remove all related definitions
        }
        else{
            return message to indicate there is no update
        }

    3. Create the latest JSON doc accroding to the current custom objects detected from server

    4. Write the lastest JSOM back to datamodel.spec

    5. return prompts indicate the responds status of the update request 
    */


    ///return ..GetDefaultClasses()
    ///return ..RefreshDataModelApiSpec()
    set refStatus = $$$OK
    set st = ..RefreshDataModelApiSpec()
    if $$$ISERR(st){
        set refStatus = st
        return st
    }
    set AllCustomObject = ..GetAllcustomObjectName()
    if $LISTLENGTH(AllCustomObject) = 0 {
        set refStatus = $System.Status.Error(83,"Error")
        return {
            "Status":"Success",
            "Message": "No custom data object detected, no API change was made."
        }
    }else{     

        /// check for AllCustomObjects name regex and restricted
        for i = 1:1:$LISTLENGTH(AllCustomObject){
            /// from custom object name get the dynamic object containing object name and its attributes
            set block = ..GetCustomObjectAttributes($LISTGET(AllCustomObject,i), .getObjectAttributesStatus)
            if $$$ISERR(getObjectAttributesStatus){
                do ..%SetStatusCode("500")
                set refStatus = $System.Status.Error(83,"Error")
                return block
            }
            /// Check the naming of the object and its properties
            set regexMsg = ..RegularExpressionAndReservedWordChecking(block, .regexStatus)

            if ( $$$ISERR(regexStatus) ) {
                do ..%SetStatusCode("500")
                return regexMsg
            }
        }

        /// Remove the expired custom obj from JSON DOC
        set remove = ..RefreshDataModelApiSpec()
        
        if $$$ISERR(remove){
            set refStatus = $System.Status.Error(83,"Error")
            do ..%SetStatusCode("500")
            return {
                "Status":"Failed",
                "Message": "Failed to remove expired custom object docs from JSON."
            }
        }
        /// Get the latest JSON doc according to the current custom object's dir list(server not local)
        set updatedJSONObject = ..ReadXDataBlockAndGenerateNewJSON(AllCustomObject,.updateStatus)
    }

    /// Testing JSON Modifications, if "de-comments" the "return" below, postman should be able to see the latest version JSON
    if $$$ISERR(updateStatus){
        do ..%SetStatusCode("500")
        set refStatus = $System.Status.Error(83,"Error")
        return updatedJSONObject
    }
    ///return updatedJSONObject
    
    $$$AddAllRoleTemporary
    set xdata = ##class(%Dictionary.XDataDefinition).IDKEYOpen("datamodelAPI.spec", "OpenAPI",.xdataOpenStatus)
    if $$$ISERR(xdataOpenStatus){
        do ..%SetStatusCode("500")
        set refStatus = $System.Status.Error(83,"Error")
        return {
            "Status":"Failed",
            "Message" : "Failed to write Xdata block to dispatch class"
        }
    }
    /// write to xdata
    try
    {
        do xdata.Data.Write(updatedJSONObject.%ToJSON())
        set saveStatus = xdata.%Save()
        if $$$ISERR(saveStatus){
            do ..%SetStatusCode("500")
            set refStatus = $System.Status.Error(83,"Error")
            return {
                "Status":"Failed",
                "Message" : "Failed to save Xdata block to dispatch class"
            }
        }

        ///Compile the Spec. Xdata Block
        set compileStatus = $SYSTEM.OBJ.Compile("datamodelAPI.spec","ck-d")
        if $$$ISERR(compileStatus) {
            do ..%SetStatusCode("500")
            set refStatus = $System.Status.Error(83,"Error")
            return {
                "Status":"Failed",
                "Message" : "Failed to compile datamodelAPI.spec class"
            }
        }

        ///Compile the Impl. Mehtod 
        set compileStatusImpl = $SYSTEM.OBJ.Compile("datamodelAPI.impl","ck-d")
        if $$$ISERR(compileStatusImpl) {
            do ..%SetStatusCode("500")
            set refStatus = $System.Status.Error(83,"Error")
            return {
                "Status":"Failed",
                "Message" : "Failed to compile impl class"
            }
        }
    }catch(ex){
        set refStatus = $System.Status.Error(83,"Error")
        do ..%SetStatusCode("500")
        return {"Errormessage": "Server error"}
    }

    /// Handle the responds message
    set ret = {
        "status":"Success",
        "message": "Successfully updated custom object API"
    }
    try {
        set retKey = "Custom Objects:"
        set retValue = []
        for i = 1:1:$LISTLENGTH(AllCustomObject){
            ///do retValue.%Push($LISTGET(AllCustomObject,i))
            set resTempValue = {}
            do resTempValue.%Set("className","SC.Data."_$LISTGET(AllCustomObject,i))
            do resTempValue.%Set("objName",$LISTGET(AllCustomObject,i))
            do resTempValue.%Set("APIPath",$ZCONVERT($LISTGET(AllCustomObject,i)_"s","L"))
            do retValue.%Push(resTempValue)
        }
        do ret.%Set(retKey, retValue)
    }catch(ex) {
        do ..%SetStatusCode("500")
        set refStatus = $System.Status.Error(83,"Error")
        return {"Errormessage": "Server error"}
    }
    return ret
}

/// Method Description:
/// The function read the current JSON from datamodelAPI.spec and insert new path value if any new
/// custom object exited
/// Input: 1. custom object list. 2 $ref status to catch nested error if it exites
/// Output: error message if any
/// Returns: Latest version of JSON for datamodelAPI.spec
ClassMethod ReadXDataBlockAndGenerateNewJSON(customObjectNamelist As %ListOfDataTypes, ByRef jsonStatus As %Status) As %DynamicObject [ Requires = "SC_Data_Model_API:Read" ]
{
    set jsonStatus = $$$OK
    $$$AddAllRoleTemporary
    /// Read the XData Block from customAPI.spec.cls
    set pathValue = {}
    Set xdataID="datamodelAPI.spec||OpenAPI"
    Set compiledXdata=##class(%Dictionary.CompiledXData).%OpenId(xdataID,,.st)
    if $$$ISOK(st){
        Set tStream=compiledXdata.Data
        If '$IsObject(tStream) {
            Set tSC=%objlasterror 
            Quit
        }
        Set dynObjectFromSpec = {}.%FromJSON(tStream)
    } else {
        set jsonStatus =  $System.Status.Error(83,"Error from Read Xdata Block Data From Current impl.cls")
        return {
            "Status":"Failed",
            "Message": "Failed to read Xdata Block from spec.cls"
        }
    }        
    try{
        /// Insert Updated JSON
        for i = 1 : 1: $LISTLENGTH(customObjectNamelist){
            set customObjectName = $LISTGET(customObjectNamelist,i)

            /// Generate JSON For /CustomObjectName
            set key = "/"_$ZCONVERT(customObjectName_"s","L")
            set value = ..GenerateJSON(customObjectName)

            /// Generate JSON For /CustomObjectName/instance's Uid 
            set keyWithId = "/"_$ZCONVERT(customObjectName_"s","L")_"/{uid}"
            set valueWithId = ..GenerateJSONWithUid(customObjectName)
            ///write $LISTGET(customObjectNamelist,i),!

            /// Update Path and write it to original Spec.cls
            do pathValue.%Set(key, value)
            do pathValue.%Set(keyWithId,valueWithId)
            do dynObjectFromSpec.paths.%Set(key, value)
            do dynObjectFromSpec.paths.%Set(keyWithId,valueWithId)

            ///Update Definition and write it back to original Spec.cls
            set defiKey = customObjectName
            set defiValue = ..GetDefinitionByObjectName(customObjectName,.defiStatus)
            if $$$ISERR(defiStatus){
                set jsonStatus =  defiStatus
                return defiValue
            }
            do dynObjectFromSpec.definitions.%Set(defiKey,defiValue)

            ///insert Method (For the section without parameter)
            do ..InsertGetMethodForCustomObject("Get"_customObjectName_"s", customObjectName)
            do ..InsertPostMethodForCustomObject("Create"_customObjectName, customObjectName)

            ///Insert Mehtod (for the section within parameter)
            do ..InsertGetWithUIDMethodForCustomObject("Get"_customObjectName_"ById", customObjectName)
            do ..InsertPutWithUIDMethodForCustomObject("Update"_customObjectName, customObjectName)
            do ..InsertDeleteWithUIDMethodForCustomObject("Delete"_customObjectName, customObjectName)

        }
    }catch(ex){
        set errRet = {}
        set jsonStatus =  $System.Status.Error(83,"Error from write new Xdata Block Data to Current impl.cls")
        do errRet.%Set("Status","Failed")
        set errMsgValue = "Failed to insert method for custom object "_customObjectName
        do errRet.%Set("Message", errMsgValue)
        return errRet
    }
    return dynObjectFromSpec
}

/// Method Description:
/// One of helper fucntion and the purpose of this fucntion is to get all current alived custom object from server.
/// Input: N/A
/// Output: Result of get custom obejct, error message or successful message 
/// Returns: Custom object list
ClassMethod GetAllcustomObjectName() As %Library.ListOfDataTypes [ Requires = "SC_Data_Model_API:Read" ]
{
    $$$AddAllRoleTemporary
    set temp = ##class(%ListOfDataTypes).%New()
    set rs = ##class(%SQL.Statement).%ExecDirect(,"select %DLIST($piece(name, '.', 3)) as classes from %dictionary.classdefinition where super = 'SC.Core.Data.CustomObjectBase'")
    if rs.%SQLCODE = 0 {
        do rs.%Next()
    }else{
        if (rs.%SQLCODE = 100) { 
            do ..%SetStatusCode("404")
        } else {
            do ..%SetStatusCode("500")
        }
        set sc = $$$ERROR($$$SQLCode,rs.SQLCODE,rs.%Message)
        do $SYSTEM.Status.DisplayError(sc)
        $$$ThrowStatus(sc)
    }
    return rs.classes
}

/// Method Description:
/// Helper fucntion, generate JSON for the given object
/// Input: object name
/// Output: Error message if exists 
/// Returns: JSON Doc for the given object name
ClassMethod GenerateJSON(obejctClassName As %String) As %DynamicObject [ Requires = "SC_Data_Model_API:Use" ]
{
    
    /// Generate path value JSON 

    /* Generate the get all JSON*/
    try{
    set pathReturnValue = 
    {
        "get":
        {
            "description" : "Retruns instances details of the given user-defined object",
            "operationId" : "",
            "produces" :["application/json"],
            "x-ISC_RequiredResource":["SC_Data_Model_API:Read"],
            "parameters" : [],
            "responses" : {
                "200": {
                    "description": "Details about a custome object by name",
                    "schema": {
                        "type": "array",
                        "items": {
                            "$ref": ""
                        }
                    }
                },
                "403": {
                    "description": "Unauthorized"
                },
                "500": {
                    "description": "Server error"
                }
            }
        },
        "post":
        {
            "description": "Add a new instance of the given object",
            "operationId": "",
            "x-ISC_RequiredResource":["SC_Data_Model_API:Read"],
            "produces":[
                "application/json"
            ],
            "parameters" :[],
            "responses" : {
                "200": {
                    "description": "Details of the created product",
                    "schema": {
                        "$ref": ""
                    }
                },
                "400" :{
                    "description": "Invalid message body"
                },
                "403": {
                    "description": "Unauthorized"
                },
                "500": {
                    "description": "Server error"
                }
            }
        }
    }

    /// Set up the operation Id for GET and POST
    set methodNameGet = "Get"_obejctClassName_"s"
    set pathReturnValue.get.operationId = methodNameGet

    set methodNamePost = "Create"_obejctClassName
    set pathReturnValue.post.operationId = methodNamePost

    ///Set up parameters IN body for POST
    set parameterInBodyValue = ..GenerateParameterInBodyValueJSON(obejctClassName)
    do pathReturnValue.post.parameters.%Push(parameterInBodyValue)

    ///Fill "$ref" section for GET && POST
    set dynamicRefValue = "#/definitions/"_obejctClassName
    set pathReturnValue.get.responses."200".schema.items."$ref" = dynamicRefValue
    set pathReturnValue.post.responses."200".schema."$ref" = dynamicRefValue

    }catch(ex){
        do ..%SetStatusCode("500")
        return {"errormessage": "Generate JSON Error"}
    }
    return pathReturnValue
}

/// Method Description:
/// Helper fucntion, generate JSON for the given object with uid 
/// Input: object name
/// Output: Error message if exists 
/// Returns: JSON Doc for the given object name with uid
ClassMethod GenerateJSONWithUid(objectClassName As %String) As %DynamicObject [ Requires = "SC_Data_Model_API:Use" ]
{
    set pathReturnValue = {
        "get" : {
            "description": "",
            "operationId": "",
            "x-ISC_RequiredResource":["SC_Data_Model_API:Read"],
            "produces": [
                "application/json"
            ],
            "parameters": [],
            "responses": {
                "200": {
                    "description": "",
                    "schema": {
                        "$ref": ""
                    }
                },
                "403": {
                    "description": "Unauthorized"
                },
                "404": {
                    "description": "Instance not found"
                },
                "500": {
                    "description": "Server internal error"
                }
            }
        },
        "put" : {
            "description": "",
            "operationId": "",
            "x-ISC_RequiredResource":["SC_Data_Model_API:Write"],
            "produces": [
                "application/json"
            ],
            "parameters": [],
            "responses": {
                "200": {
                    "description": "",
                    "schema": {
                        "$ref": ""
                    }
                },
                "400": {
                    "description": "Invalid message body"
                },
                "403": {
                    "description": "Unauthorized"
                },
                "404": {
                    "description": "Instance not found"
                },
                "500": {
                    "description": "Server error"
                }
            }
        },
        "delete" : {
            "description": "",
            "operationId": "",
            "x-ISC_RequiredResource":["SC_Data_Model_API:Write"],
            "produces": [
                "application/json"
            ],
            "parameters": [],
            "responses": {
                "200": {
                    "description": "Success"
                },
                "403": {
                    "description": "Unauthorized"
                },
                "404": {
                    "description": "Instance not found"
                },
                "500": {
                    "description": "Server error"
                }
            }
        }
    }

    /// Update description 
    set pathReturnValue.get.description = "Returns details about a particular "_objectClassName
    set pathReturnValue.get.responses."200".description = "Details about a "_objectClassName_" by ID"

    set pathReturnValue.put.description = "Update one "_objectClassName
    set pathReturnValue.put.responses."200".description = "Details about a "_objectClassName

    set pathReturnValue.delete.description = "Delete an existing "_objectClassName


    /// Set up Operation ID For GET, POST, and Delete
    set methodNameGet = "Get"_objectClassName_"ById"
    set pathReturnValue.get.operationId = methodNameGet

    set methodNamePut = "Update"_objectClassName
    set pathReturnValue.put.operationId = methodNamePut

    set methodNameDelete = "Delete"_objectClassName
    set pathReturnValue.delete.operationId = methodNameDelete


    /// Set up responses $ref values
    set dynamicRefValue = "#/definitions/"_objectClassName
    set pathReturnValue.get.responses."200".schema."$ref" = dynamicRefValue
    set pathReturnValue.put.responses."200".schema."$ref" = dynamicRefValue

    ///Set up Parameter values
    set inPathParameter = ..GenerateParameterInPathValueJSON(objectClassName)
    set inBodyParameter = ..GenerateParameterInBodyValueJSON(objectClassName)
    do pathReturnValue.get.parameters.%Push(inPathParameter)
    do pathReturnValue.put.parameters.%Push(inPathParameter)
    do pathReturnValue.put.parameters.%Push(inBodyParameter)
    do pathReturnValue.delete.parameters.%Push(inPathParameter)

    /// With Id path set up done
    return pathReturnValue
}

/// Method Description:
/// Helper function of readXdata block, get the definition of the given class.
/// Input: object name, $ref status to catch nested error if exsits
/// Output: Error if any
/// Returns: class definition of the given object
ClassMethod GetDefinitionByObjectName(objectClassName As %String, ByRef defiStatus As %Status) As %DynamicObject [ Requires = "SC_Data_Model_API:Read" ]
{
    set defiStatus = $$$OK
    set defiValue = 
    {
        "type": "object",
        "required": [],
        "properties":""
    }
    try {
        /// Handle the property name section
        set className = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(objectClassName)
        set propertyValue = ..GetClassAttributesAndType(className,.defiValue,.attributeStatus)
        if $$$ISERR(attributeStatus){
            set defiStatus = attributeStatus
            return propertyValue
        }
        set defiValue.properties = propertyValue

    }catch(ex){
        set errRet = {}
        set defiStatus = $System.Status.Error(83,"Error from generates JSON For object definitions")
        do errRet.%Set("Status", "Failed")
        set errValue = "Failed to get definition of the custom object "_objectClassName
        do errRet.%Set("Message",errValue)
        return errRet
    }
    return defiValue
}

/// Method Description:
/// Helper function of GetDefinitionByObjectName, get all attributes and intert it back to definition as values
/// Input: class name, $ref status, definition value obejct passing by reference
/// Output: Error message if exists 
/// Returns: Error message if exists
ClassMethod GetClassAttributesAndType(className As %String, ByRef defiValue As %DynamicObject, ByRef status As %Status) As %DynamicObject [ Requires = "SC_Data_Model_API:Read" ]
{
    $$$AddAllRoleTemporary
    set status = $$$OK
    set ret = {}
    set count = 1
    set hashMap = {"string": "string", "integer":"integer", "boolean":"boolean","numeric":"number","datetime":"OK", "date": "OK"}
    /// 1 Handle the diffrent cases of attributes
    set sql="select name, type, required, sqlFieldName from %Dictionary.CompiledProperty " _ 
            " where storable = 1 and parent=? order by SequenceNumber"
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql, className)
    if rs.%SQLCODE < 0 {
        ///$$$ThrowStatus($$$ERROR($$$SQLCode,rs.SQLCODE,rs.%Message))
        set status = $System.Status.Error(83,"SQL Error from get attributes of custom object "_className)
        set err = {}
        do err.%Set("Staus", "Failed")
        set errMsgValue = "Failed to get attributes of custom object "_className_" by SQL Query"
        do err.%Set("Message",errMsgValue)
        return err
    }
    if ( rs.%SQLCODE = 0 ) {
        while ( rs.%Next() '= 0 ) {
            set tempAttr = $ZCONVERT($PIECE(rs.type,".",2),"L")
            if hashMap.%IsDefined(tempAttr){
                try{
                        if rs.required = 1 {
                            do defiValue.required.%Push(rs.name)
                        }
                        set tempContainer = {}
                        set attr = rs.name
                        set attrType = ""
                        if (tempAttr = "datetime") || (tempAttr = "date"){
                            do tempContainer.%Set("type", "string")
                            do tempContainer.%Set("format", "date-time")
                            do ret.%Set(attr,tempContainer)
                        }else{
                            set attrType = hashMap.%Get(tempAttr)
                            do tempContainer.%Set("type",attrType)
                            do ret.%Set(attr,tempContainer)
                        }
                    }catch(ex){
                        set errRet = {}
                        set status = $System.Status.Error(83,"Faild to assign a value/type to a defined property")
                        do errRet.%Set("Status", "Failed")
                        set errMsgValue = "Faild to assign the value/type of custom object "_className_" to a defined property"
                        do errRet.%Set("Message",errMsgValue)
                        return errRet
                    }
            }else{
                set errRet = {}
                set status = $System.Status.Error(83,"Existing properties type that is not supported by swagger 2.0")
                do errRet.%Set("Status","Failed")
                set definedBefore = ..IsDefinedAPI(className)
                if (definedBefore) {
                    set errMsgValue = "In custom data object "_className_", property "_rs.name_" has a value type "_rs.type_" not supported for auto-generated APIs.The Current API of "_className_" stay no changes"
                }else{
                    set errMsgValue  = "In custom data object "_className_", property "_rs.name_" has a value type "_rs.type_" not supported for auto-generated APIs.Failed to create the new custom object APIs"
                }
                do errRet.%Set("Message",errMsgValue)
                return errRet
      
            }
        }
    }
    return ret
}

/// Method Description:
/// To generate JSON when parameter in BODY for the given object.
/// Input: class name 
/// Output: Error message if exists 
/// Returns: The parameter value of the given object
ClassMethod GenerateParameterInBodyValueJSON(objectClassName As %String) As %DynamicObject [ Requires = "SC_Data_Model_API:Use" ]
{
    set parameterValue = {}
    try {
        set key = "$ref"
        set value = "#/definitions/"_objectClassName
        set ref = {}
        do ref.%Set(key,value)
        do parameterValue.%Set("in", "body")
        do parameterValue.%Set("name", "body")
        do parameterValue.%Set("required", 1, "boolean")
        do parameterValue.%Set("schema", ref)
    }catch(ex){
        do ..%SetStatusCode("500")
        return {"errormessage": "Generate parameters JSON Error"}
    }
    return parameterValue
}

/// Method Description:
/// To generate JSON when parameter in path for the given object.
/// Input: class name 
/// Output: Error message if exists 
/// Returns: The parameter value of the given object
ClassMethod GenerateParameterInPathValueJSON(objectClassName As %String) As %DynamicObject [ Requires = "SC_Data_Model_API:Read" ]
{
    set parameterValue = {}
    try {

        do parameterValue.%Set("in", "path")
        do parameterValue.%Set("name", "uid")
        do parameterValue.%Set("type","string")
        do parameterValue.%Set("required", 1, "boolean")
        set descriptionValue = "Unique ID of the "_objectClassName
        do parameterValue.%Set("description",descriptionValue)
    }catch(ex){
        do ..%SetStatusCode("500")
        return {"errormessage": "Generate In path parameters Error"}
    }
    return parameterValue
}

/// Method Description:
/// Modify the datamodelAPI.impl class and insert Get method for the given object 
/// Input: Method name, object name 
/// Output: Stauts of the insertion
/// Returns: Error message if it exited
ClassMethod InsertGetMethodForCustomObject(methodName As %String, objectName As %String) As %Status [ Requires = "SC_Data_Model_API:Write" ]
{
    $$$AddAllRoleTemporary
    set ret = $$$OK
    set classDefinition = ##class(%Dictionary.ClassDefinition).%OpenId("datamodelAPI.impl",,.openTargetClassStatus)
    if $$$ISERR(openTargetClassStatus) {return openTargetClassStatus}
    set methodDefinition = ##class(%Dictionary.MethodDefinition).%New("datamodelAPI.impl:"_methodName)

    set methodDefinition.ClassMethod = 1
    set methodDefinition.ReturnType ="%DynamicObject"
    ///set methodDefinition.FormalSpec = "name:%String="_objectName
    set methodDefinition.Description = "Return all instance of "_objectName
    set methodDefinition.CodeMode = "code"
    set codeContext = "    return ##class(SC.Core.API.Data.DataApiBase).ObjectGetAll("""_objectName_""",""uid"")"

    /// Write method to target class
    do methodDefinition.Implementation.Write(codeContext)

    /// Insert the new method to target class
    set statusInsert = classDefinition.Methods.Insert(methodDefinition)
    if $$$ISERR(statusInsert) {return statusInsert}

    /// Save the changes 
    set statusSave = classDefinition.%Save()
    if $$$ISERR(statusSave) {return statusSave}
    return ret
}

/// Method Description:
/// Modify the datamodelAPI.impl class and insert Post method for the given object 
/// Input: Method name, object name 
/// Output: Stauts of the insertion
/// Returns: Error message if it exited
ClassMethod InsertPostMethodForCustomObject(methodName As %String, objectName As %String) As %Status [ Requires = "SC_Data_Model_API:Write" ]
{
    $$$AddAllRoleTemporary
    set ret = $$$OK
    set classDefinition = ##class(%Dictionary.ClassDefinition).%OpenId("datamodelAPI.impl",,.openTargetClassStatus)
    if $$$ISERR(openTargetClassStatus) {return openTargetClassStatus}
    set methodDefinition = ##class(%Dictionary.MethodDefinition).%New("datamodelAPI.impl:"_methodName)

    set methodDefinition.ClassMethod = 1
    set methodDefinition.ReturnType ="%DynamicObject"
    set methodDefinition.FormalSpec = "body:%DynamicObject"
    set methodDefinition.Description = "Post a new instance of "_objectName
    set methodDefinition.CodeMode = "code"
    set codeContext = "    return ##class(SC.Core.API.Data.DataApiBase).ObjectCreate("""_objectName_""",body)"

    /// Write method to target class
    do methodDefinition.Implementation.Write(codeContext)

    /// Insert the new method to target class
    set statusInsert = classDefinition.Methods.Insert(methodDefinition)
    if $$$ISERR(statusInsert) {return statusInsert}

    /// Save the changes 
    set statusSave = classDefinition.%Save()
    if $$$ISERR(statusSave) {return statusSave}
    return ret
}

/// Method Description:
/// Modify the datamodelAPI.impl class and insert Get instance by uid method for the given object 
/// Input: Method name, object name 
/// Output: Stauts of the insertion
/// Returns: Error message if it exited
ClassMethod InsertGetWithUIDMethodForCustomObject(methodName As %String, objectName As %String) As %Status [ Requires = "SC_Data_Model_API:Write" ]
{
    $$$AddAllRoleTemporary
    set ret = $$$OK
    set classDefinition = ##class(%Dictionary.ClassDefinition).%OpenId("datamodelAPI.impl",,.openTargetClassStatus)
    if $$$ISERR(openTargetClassStatus) {return openTargetClassStatus}
    set methodDefinition = ##class(%Dictionary.MethodDefinition).%New("datamodelAPI.impl:"_methodName)

    set methodDefinition.ClassMethod = 1
    set methodDefinition.ReturnType ="%DynamicObject"
    set methodDefinition.FormalSpec = "uid:%String"
    set methodDefinition.Description = "Return all instance of "_objectName
    set methodDefinition.CodeMode = "code"
    set codeContext = "    return ##class(SC.Core.API.Data.DataApiBase).ObjectGetByUid("""_objectName_""",uid)"

    /// Write method to target class
    do methodDefinition.Implementation.Write(codeContext)

    /// Insert the new method to target class
    set statusInsert = classDefinition.Methods.Insert(methodDefinition)
    if $$$ISERR(statusInsert) {return statusInsert}

    /// Save the changes 
    set statusSave = classDefinition.%Save()
    if $$$ISERR(statusSave) {return statusSave}
    return ret
}

/// Method Description:
/// Modify the datamodelAPI.impl class and insert PUT with UID method for the given object 
/// Input: Method name, object name 
/// Output: Stauts of the insertion
/// Returns: Error message if it exited
ClassMethod InsertPutWithUIDMethodForCustomObject(methodName As %String, objectName As %String) As %Status [ Requires = "SC_Data_Model_API:Write" ]
{
    $$$AddAllRoleTemporary
    set ret = $$$OK
    set classDefinition = ##class(%Dictionary.ClassDefinition).%OpenId("datamodelAPI.impl",,.openTargetClassStatus)
    if $$$ISERR(openTargetClassStatus) {return openTargetClassStatus}
    set methodDefinition = ##class(%Dictionary.MethodDefinition).%New("datamodelAPI.impl:"_methodName)

    set methodDefinition.ClassMethod = 1
    set methodDefinition.ReturnType ="%DynamicObject"
    set methodDefinition.FormalSpec = "uid:%String, body:%DynamicObject"
    set methodDefinition.Description = "Update a new instance of "_objectName
    set methodDefinition.CodeMode = "code"
    set codeContext = "    return ##class(SC.Core.API.Data.DataApiBase).ObjectUpdate("""_objectName_""", uid, body)"

    /// Write method to target class
    do methodDefinition.Implementation.Write(codeContext)

    /// Insert the new method to target class
    set statusInsert = classDefinition.Methods.Insert(methodDefinition)
    if $$$ISERR(statusInsert) {return statusInsert}

    /// Save the changes 
    set statusSave = classDefinition.%Save()
    if $$$ISERR(statusSave) {return statusSave}
    return ret
}

/// Method Description:
/// Modify the datamodelAPI.impl class and insert Delete with UID method for the given object 
/// Input: Method name, object name 
/// Output: Stauts of the insertion
/// Returns: Error message if it exited
ClassMethod InsertDeleteWithUIDMethodForCustomObject(methodName As %String, objectName As %String) As %Status [ Requires = "SC_Data_Model_API:Write" ]
{
    $$$AddAllRoleTemporary
    set ret = $$$OK
    set classDefinition = ##class(%Dictionary.ClassDefinition).%OpenId("datamodelAPI.impl",,.openTargetClassStatus)
    if $$$ISERR(openTargetClassStatus) {return openTargetClassStatus}
    set methodDefinition = ##class(%Dictionary.MethodDefinition).%New("datamodelAPI.impl:"_methodName)

    set methodDefinition.ClassMethod = 1
    set methodDefinition.ReturnType ="%DynamicObject"
    set methodDefinition.FormalSpec = "uid:%String"
    set methodDefinition.Description = "Delete a instance of "_objectName
    set methodDefinition.CodeMode = "code"
    set codeContext = "    return ##class(SC.Core.API.Data.DataApiBase).ObjectDelete("""_objectName_""", uid)"

    /// Write method to target class
    do methodDefinition.Implementation.Write(codeContext)

    /// Insert the new method to target class
    set statusInsert = classDefinition.Methods.Insert(methodDefinition)
    if $$$ISERR(statusInsert) {return statusInsert}

    /// Save the changes 
    set statusSave = classDefinition.%Save()
    if $$$ISERR(statusSave) {return statusSave}
    return ret
}

/// Method Description:
/// Helper fucntion to verify if the given object is a custom object
/// Input: object Name
/// Output: 1 or 0 denotes true or false 
/// Returns: 1 if the given object is custom object, otherwise return 0
ClassMethod IsCustomObject(objectName As %String) As %Integer [ Requires = "SC_Data_Model_API:Read" ]
{
    /* 
        This is the method is used to check if the object is Custom Object
    */
    $$$AddAllRoleTemporary
    set sql = "select super from %dictionary.classdefinition where name = ?"
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql,("SC.Data."_objectName))
    if ( rs.%SQLCODE = 0 ) {
        do rs.%Next()
        if ($Find(rs.super, "SC.Core.Data.CustomObjectBase") '= 0) {
            return 1
        }
    }
    return 0
}

/// Method Description:
/// The fucntio checks if the API path of given object already exists
/// Input: Object Name 
/// Output: Boolean value to indicate if the API path already exists
/// Returns: true/false
ClassMethod IsDefinedAPI(objName As %String) As %Boolean [ Requires = "SC_Data_Model_API:Read" ]
{
    /*
        Marco logic:
        This is a helper function of "GetClassAttributesAndType"
        The purpose of this function is to check if the current JSON Xdata block already exists THE objName's API link
        We can use this fucntion to handle the different error scenarios
            a. In the current JSON, If the key "objName" isDefinied, return 1, otherwise, return 0
    */
    /// Open xdata block of spec file and transfer it to dynamic object 
    $$$AddAllRoleTemporary
    Set xdataID="datamodelAPI.spec||OpenAPI"
    Set compiledXdata=##class(%Dictionary.CompiledXData).%OpenId(xdataID,,.st)
    if $$$ISOK(st){
        Set tStream=compiledXdata.Data
        If '$IsObject(tStream) {
            Set tSC=%objlasterror 
            Quit
        }
        Set xdataObj = {}.%FromJSON(tStream)
    }else{
        set errorStatus =  $System.Status.Error(83,"Filed to read xdata block for IsDefinedAPI Function")
        return 0
    }

    /// Checking if key defined/already in the json
    set key = "/"_$ZCONVERT($PIECE(objName,".",3),"L")_"s"
    if (xdataObj.paths.%IsDefined(key)) || (xdataObj.paths.%IsDefined(key)_"/{uid}"){
        return 1
    }
    return 0
}

/// Method Description:
/// Delete the API Path of all classes that no longer exists on server.
/// Input: N/A
/// Output: N/A
/// Returns: Status denotes the result of the garbage disposal.
ClassMethod RefreshDataModelApiSpec() As %Status [ Requires = "SC_Data_Model_API:Write" ]
{
    /*
        Macro logic of this method
        1 Open the Xdata block from dataModel.spec
        2 Set a default object list, which were pre-defined (all non-custom object list)
        3 Detacting which objects are remaining
        4 Get the Current JSON Document
        5 Find the intersection of 2, 3, and 4. we have the expired path key to remove from current json doc
        6 Removing those expired custom object and return status

        Note: If the product need to add some pre-defined object (non-custom object), please add the path key to default list.
    */

    set ret = $$$OK
    set default = ..GetDefaultClasses(.st)
    /// ************* KEY **************
    /// In future, if you add some new class under SC.Core.Data, modified JSON mannuly, and did not follow the standard naming convention,
    /// You need to insert the new JSON Path to the dynamic object "default" format like below: (if you followed the standard naming convention to construct the JSON Path, you need do nothing)
    /// set newJSONpath = ""
    /// do default.%Set(newJSONpath,"defined")
    /// 1. copy the code above and assign the non-standard path naming to newJSONpath 
    /// 2. default update Done.


    if $$$ISERR(st){
        set ret = st
        return ret
    }

    $$$AddAllRoleTemporary
    Set xdataID="datamodelAPI.spec||OpenAPI"
    Set compiledXdata=##class(%Dictionary.CompiledXData).%OpenId(xdataID,,.st)
    if $$$ISOK(st){
        Set tStream=compiledXdata.Data
        If '$IsObject(tStream) {
            Set tSC=%objlasterror 
            Quit
        }
        set currentJSON = {}.%FromJSON(tStream)
    }else{
        set ret =  $System.Status.Error(83,"Error from Read Xdata Block Data From impl.cls when try to remove expired JSON")
        return ret
    }
    set iter = currentJSON.%GetIterator()
    set currPathList = {}
    set alivedCustomObject = {}
    try{
        while iter.%GetNext(.key,.value,){
            if key = "paths"{
                set valueIter = value.%GetIterator()
                while valueIter.%GetNext(.name,,){
                    set temp = $extract(name,2,)
                    set tempSize = $length(temp)
                    set final = $EXTRACT(temp,1,tempSize-1)
                    set final = $ZCONVERT(final,"W")
                    do currPathList.%Set(name,"defined")
                    if ..IsCustomObject(final) {
                        do alivedCustomObject.%Set(name, "OK")
                        do alivedCustomObject.%Set(name_"/{uid}", "OK")
                    }
                }
            }
        } 

        set it =currPathList.%GetIterator()
        while it.%GetNext(.pathKey,,){
            if ('default.%IsDefined(pathKey)) && ('alivedCustomObject.%IsDefined(pathKey)){
                do currentJSON.paths.%Remove(pathKey)
                set defiName =  $piece(pathKey,"/",2)
                set defiNameSize = $length(pathKey)
                set defiName = $ZCONVERT($EXTRACT(defiName,1, defiNameSize - 2 ), "W")
                if currentJSON.definitions.%IsDefined(defiName){
                    do currentJSON.definitions.%Remove(defiName)
                }
            }

        }
    }catch(ex){
        set ret =  $System.Status.Error(83,"Failed remove expired doc on JSON")
        return ret
    }
    /// Write the new JSON back
    set errRet = $System.Status.Error(83,"Failed wrire doc to JSON")
    try
    {
        set xdata = ##class(%Dictionary.XDataDefinition).IDKEYOpen("datamodelAPI.spec", "OpenAPI",.xdataOpenStatus)
        if $$$ISERR(xdataOpenStatus){
            do ..%SetStatusCode("500")
            return errRet
        }

        do xdata.Data.Write(currentJSON.%ToJSON())
        set saveStatus = xdata.%Save()
        if $$$ISERR(saveStatus){
            do ..%SetStatusCode("500")
            return errRet

        }

        ///Compile the Spec. Xdata Block
        set compileStatus = $SYSTEM.OBJ.Compile("datamodelAPI.spec","ck-d")
        if $$$ISERR(compileStatus) {
            do ..%SetStatusCode("500")
            return errRet

        }
    }catch(ex){
        do ..%SetStatusCode("500")
        return errRet
    }
    return $$$OK
}

/// Method Description:
/// Get the pre-defined object from SC.Core.Data
/// Input: $ref to catch nested error if it exists
/// Output: Pre-defined Classes 
/// Returns: Message of Get, Success / Failed 
ClassMethod GetDefaultClasses(ByRef status As %Status) As %DynamicObject [ Requires = "SC_Data_Model_API:Read" ]
{
    $$$AddAllRoleTemporary
    set status = $$$OK
    set ret = {}
    set sql = "select %DLIST($piece(ID, '.', 4)) as classes from %dictionary.classdefinition Where ID LIKE 'SC.Core.Data%'"
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql)
    if rs.%SQLCODE = 0 {
        do rs.%Next()
    }else{
        if (rs.%SQLCODE = 100) { 
            do ..%SetStatusCode("404")
        } else {
            do ..%SetStatusCode("500")
        }
        set status = $$$ERROR($$$SQLCode,rs.SQLCODE,rs.%Message)
        return {
            "Status" : "Failed",
            "Message" : ($SYSTEM.Status.DisplayError(status))
        }
        
    }
    
    /// Handle special cases in SPEC but not in  SC.Data
    try{
        do ret.%Set("/scexceptions","defined")
        do ret.%Set("/scexceptions/{exceptionId}","defined")
        do ret.%Set("/backend-version","defined")
        do ret.%Set("/objects/{objectName}","defined")
        do ret.%Set("/objects","defined")
        do ret.%Set("/attributes/{objectName}","defined")
        do ret.%Set("/issues","defined")
        do ret.%Set("/issues/{issueId}","defined")
        do ret.%Set("/bulkupload/{uploadId}","defined")
        do ret.%Set("/bulkupload/contents/{uploadId}","defined")
        do ret.%Set("/bulkupload/details/uploadIds","defined")
        do ret.%Set("/bulkupload/error","defined")
        do ret.%Set("/bulkupload","defined")
    }catch(ex){
        set status = $System.Status.Error(83,"Error to generate the default object list")
        do ..%SetStatusCode("500")
        return {
            "Status" : "Failed",
            "Message" : "Insertion Error when generate the default object list"
        }
    }
    /// Handle general cases in spec 

    for i = 1:1:$LISTLENGTH(rs.classes){
        set prefix = $LISTGET(rs.classes,i)
        set key = "/"_$ZCONVERT(prefix,"L")_"s"
        set value = "defined"
        /*
         Definiiton: 
            Standard naming convention is (Standard path structure) : 
                    ### "/ + lowercase class name + s/{lowercase class name _Id}" 
                    ### "/ + lowerecase class name"

         There 2 possible cases :
            1. Class is under the SC.Core.Data but not in JSON:
                ### Example: Internal, TimeStampedDatam,CustomObject...
            2. Class is under the SC.Core.Data and also in JSON:
                case a. This class used standard path naming convention.
                    ### Example: "/customers/{customerId}", "/locations/{locationId}"
                case b. This class not used standard path naming convention
                    ### Example: "/salesorders/{orderId}", "/billofmaterials"

        All Senaraios has been handled and please use "Standard naming convention " in future if you need to modify the SC.Data.Core
        in order to ensure the fucntion (delete expired custom object from JSON) works correctly.

        ### In the try block blow, the classes listed in if && condition, means those classes under the SC.Cord.Data but not a value
            of JSON'S path, which means we don't need those classes.
        ### if prefix cases means those used non-standard naming convention in JSON, we need to handle those cases.
        ### else: some classes used standard naming convension and we can add it to return value.

        */
        try{
            if ((prefix '= "Internal") 
            && (prefix '= "TimeStampedData") 
            && (prefix '= "CustomObjectBase")
            && (prefix '= "Order") 
            && (prefix '= "OrderLine") 
            && (prefix '= "Plan") 
            && (prefix '= "Shipment") 
            && (prefix '="ShipmentLine") 
            && (prefix '= "SCException")){
                if prefix = "SalesOrder" {
                    set subKey = "/salesorders/{orderId}"
                    set subVal = "defined"
                    do ret.%Set(subKey, subVal)
                    set subKey = "/"_$ZCONVERT(prefix,"L")_"s"
                    do ret.%Set(subKey, subVal)

                }elseif prefix = "SalesOrderLine"{
                    set subKey = "/salesorderlines/{lineId}"
                    set subVal = "defined"
                    do ret.%Set(subKey, subVal)
                    set subKey = "/"_$ZCONVERT(prefix,"L")_"s"
                    do ret.%Set(subKey, subVal)
                }elseif prefix = "BOM"{
                    set subKey = "/billofmaterials"
                    set subVal = "defined"
                    do ret.%Set(subKey, subVal)
                    set subKey = "/billofmaterials/{bomId}"
                    do ret.%Set(subKey, subVal)
                }elseif prefix = "DemandPlan" {
                    set subKey = "/demandplans/{planId}"
                    set subVal = "defined"
                    do ret.%Set(subKey, subVal)
                    set subKey = "/"_$ZCONVERT(prefix,"L")_"s"
                    do ret.%Set(subKey, subVal)
                }elseif prefix = "MfgOrder"{
                    set subKey = "/manufacturingorders/{orderId}"
                    set subVal = "defined"
                    do ret.%Set(subKey, subVal)
                    set subKey = "/manufacturingorders"
                    do ret.%Set(subKey, subVal)
                }elseif prefix = "ProductSupplier"{
                    set subKey = "/productsuppliers/{prodSuplId}"
                    set subVal = "defined"
                    do ret.%Set(subKey, subVal)
                    set subKey = "/"_$ZCONVERT(prefix,"L")_"s"
                    do ret.%Set(subKey, subVal)
                }elseif prefix = "SupplyPlan" {
                    set subkey = "/supplyplans/{planId}"
                    set subVal = "defined"
                    do ret.%Set(subkey, subVal)
                    set subKey = "/"_$ZCONVERT(prefix,"L")_"s"
                    do ret.%Set(subKey, subVal)            
                }elseif prefix = "ProductInventory"{
                    set subKey ="/productinventories/{inventoryId}"
                    set subVal ="defined"
                    do ret.%Set(subKey, subVal)
                    set subKey = "/productinventories"
                    do ret.%Set(subKey, subVal)
                }elseif prefix = "PurchaseOrder"{
                    set subKey ="/purchaseorders/{orderId}"
                    set subVal ="defined"
                    do ret.%Set(subKey, subVal)
                    set subKey = "/purchaseorders"
                    do ret.%Set(subKey, subVal)
                }elseif prefix ="PurchaseOrderLine" {
                    set subKey ="/purchaseorderlines/{lineId}"
                    set subVal ="defined"
                    do ret.%Set(subKey, subVal)
                    set subKey = "/purchaseorderlines"
                    do ret.%Set(subKey, subVal)
                }elseif prefix ="SalesShipment" {
                    set subKey ="/salesshipments/{shipmentId}"
                    set subVal ="defined"
                    do ret.%Set(subKey, subVal)
                    set subKey = "/salesshipments"
                    do ret.%Set(subKey, subVal)
                }elseif prefix = "SalesShipmentLine" {
                    set subKey ="/salesshipmentlines/{lineId}"
                    set subVal ="defined"
                    do ret.%Set(subKey, subVal)
                    set subKey = "/salesshipmentlines"
                    do ret.%Set(subKey, subVal)
                }elseif prefix = "SupplyShipment"{
                    set subKey ="/supplyshipments/{shipmentId}"
                    set subVal ="defined"
                    do ret.%Set(subKey, subVal)
                    set subKey = "/supplyshipments"
                    do ret.%Set(subKey, subVal)
                }elseif prefix = "SupplyShipmentLine"{
                    set subKey ="/supplyshipmentlines/{lineId}"
                    set subVal ="defined"
                    do ret.%Set(subKey, subVal)
                    set subKey = "/supplyshipmentlines"
                    do ret.%Set(subKey, subVal)
                }elseif prefix = "ProductionCapacity"{
                    set subKey ="/productioncapacities/{productionCapacityId}"
                    set subVal ="defined"
                    do ret.%Set(subKey, subVal)
                    set subKey = "/productioncapacities"
                    do ret.%Set(subKey, subVal)
                }elseif prefix = "ShippingCost"{
                    set subKey ="/shippingcosts/{shippingCostId}"
                    set subVal ="defined"
                    do ret.%Set(subKey, subVal)
                    set subKey = "/shippingcosts"
                    do ret.%Set(subKey, subVal)
                }elseif prefix = "RouteLeg"{
                    set subKey ="/routelegs/{routeLegId}"
                    set subVal ="defined"
                    do ret.%Set(subKey, subVal)
                    set subKey = "/routelegs"
                    do ret.%Set(subKey, subVal)
                }elseif prefix = "InventoryThreshold"{
                    set subKey ="/inventorythresholds/{inventoryThresholdId}"
                    set subVal ="defined"
                    do ret.%Set(subKey, subVal)
                    set subKey = "/inventorythresholds"
                    do ret.%Set(subKey, subVal)
                }elseif prefix = "LeadtimeVariant"{
                    set subKey ="/leadtimevariants/{leadtimeVariantId}"
                    set subVal ="defined"
                    do ret.%Set(subKey, subVal)
                    set subKey = "/leadtimevariants"
                    do ret.%Set(subKey, subVal)
                }else{
                    /// Here is the place to handl the standard naming case
                    /// format: "/" + lowercase class name + "s"+ "/" + "{lowercase class name + Id}" 
                    ///example: /locations and /locations/locationId
                    do ret.%Set(key,value)
                    set key = key_"/{"_$ZCONVERT(prefix,"L")_"Id}"
                    do ret.%Set(key,value)
                }
            }
        }catch (ex){
            set status = $System.Status.Error(83,"Error to generate the default object list")
            do ..%SetStatusCode("500")
            return {
                "Status" : "Failed",
                "Message" : "Insertion Error when generate the default object list"
            }
        }
    }
    return ret
}

/// Method Description:
/// Regular expression for the input name checking (object name and property name)
/// Input: body parameter from API
/// Output: Error message if exists 
/// Returns: status denotes whether the given object valid
ClassMethod RegularExpressionAndReservedWordChecking(block As %DynamicObject, ByRef status As %Status) As %DynamicObject [ Requires = "SC_Data_Model_API:Use" ]
{
    set status = $$$OK
    if (block.%IsDefined("objectName")) && (block.objectName '= ""){
        
        /// check to see if the object name is a restricted/reserved word
        set reservedWordStatus = ##class(SC.Core.Util.RestrictedWordCheckerUtil).CheckIfWordIsRestricted(block.objectName)
        if (reservedWordStatus) {
            set status = $System.Status.Error(83,"Error")
            return {
                "Status" : "Failed",
                "Message" : (block.objectName_" is a reserved word. Please use a different name.")
            }
        }

        /// check to see if the naming convention of object is proper 
        set isValidObjectName = $MATCH(block.objectName, ..#OBJECTREGEX)
        if 'isValidObjectName {
            set status = $System.Status.Error(83,"Error")
            return {
                "Status" : "Failed",
                "Message" : ("Invalid object name: "_block.objectName)
            }
        }
    }
    else {
        set status = $System.Status.Error(83,"Error")
        return {
            "Status" : "Failed",
            "Message" : "ObjectName needs to be defined and can not be an empty value"
        }
    }
    if block.%IsDefined("attributes"){
        set it = block.attributes.%GetIterator()
        while it.%GetNext(.idx,.val){
            if (val.%IsDefined("name")) && (val.name '= "") {

                /// check to see if the attribute name is a restricted/reserved word
                set reservedWordStatus = ##class(SC.Core.Util.RestrictedWordCheckerUtil).CheckIfWordIsRestricted(val.name)
                if (reservedWordStatus) {
                    set status = $System.Status.Error(83,"Error")
                    return {
                        "Status" : "Failed",
                        "Message" : (val.name_" is a reserved word. Please use a different name.")
                    }
                }

                /// check to see if the naming convention of attribute is proper 
                set isValidAttributeName = $MATCH(val.name, ..#PROPERTYREGEX)
                if 'isValidAttributeName {
                    set status = $System.Status.Error(83,"Error")
                    return {
                        "Status" : "Failed",
                        "Message" : ("Invalid name for attribute: "_val.name)
                    }
                }
            }else{
                set status = $System.Status.Error(83,"Error")
                return {
                    "Status" : "Failed",
                    "Message" : "Attribute name needs to be defined and can not be an empty value"
                }
            }
        }
    }

    return {"Success" :"Testing return value"}
}

/// This method takes in the custom object name and creates a dynamic object containing custom object name and names of all the attributes
/// Dynamic object returned syntax: {"objectName": "ABC", "attributes": [{"name": "attr1"}, {"name": "attr2"}]}
ClassMethod GetCustomObjectAttributes(objectName As %String, ByRef status As %Status) As %DynamicObject [ Requires = "SC_Data_Model_API:Read" ]
{
    $$$AddAllRoleTemporary
    set status = $$$OK
    set ret = {}
    do ret.%Set("objectName",objectName)
    set attributes = []
    set className = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(objectName)
    set sql="select name from %Dictionary.CompiledProperty where storable = 1 and parent=? order by SequenceNumber"
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql, className)
    if rs.%SQLCODE < 0 {
        set status = $System.Status.Error(83,"SQL Error from get object attributes of custom object "_className)
        set err = {}
        do err.%Set("Staus", "Failed")
        set errMsgValue = "Failed to get attributes of custom object "_className_" by SQL Query"
        do err.%Set("Message",errMsgValue)
        return err
    }
    if ( rs.%SQLCODE = 0 ) {
        while ( rs.%Next() '= 0 ) {
            set attributeName = rs.name 
            set obj = {}
            do obj.%Set("name",attributeName)
            do attributes.%Push(obj)
        }
    }
    do ret.%Set("attributes",attributes)
    return ret
}

}
