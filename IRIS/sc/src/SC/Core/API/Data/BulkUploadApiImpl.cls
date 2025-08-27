/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.API.Data.BulkUploadApiImpl Extends SC.Core.API.Data.DataApiBase
{

/// Name of the object handled by this class
Parameter OBJECTNAME = "BulkUpload";

/// Default sorting attribute
Parameter DEFAULTSORTING = "ID";

/// Maximum size of upload file in megabytes
Parameter FILESIZE = 50;

/// Return contents of a file
ClassMethod ReturnFile(uploadId As %String) As %Stream.TmpCharacter
{
     // Get details from bulk upload table
    set sql = "SELECT receivedTime, status, fileName "_
                "FROM SC_Core_Data_Internal.BulkUpload WHERE uid = '"_uploadId_"'"
    
    
    set tStatement = ##class(%SQL.Statement).%New()
    set qStatus = tStatement.%Prepare(sql)
    if $$$ISERR(qStatus) {
        do ..%SetStatusCode("500")
        return "Improper sql statement "_sql
    }
    set rset = tStatement.%Execute()
    if rset.%SQLCODE<0{
        do ..%SetStatusCode("500")
        return "Unable to process sql request"
    }
    do rset.%Next()
    if rset.%Get("receivedTime") = ""{
         do ..%SetStatusCode("400")
         return "Not a valid input id" 
    }

    // Extract the details from the upload
    set receivedTime = rset.%Get("receivedTime")
    set status = rset.%Get("status")
    set fileName = rset.%Get("fileName")
    set folder = ""
    if status = "complete"{
        set folder = "complete"
    }
    elseif status = "failed"{
        set folder = "failed"
    }else{
        set folder = "processing"
    }

    // get path to file and link to it
    set filePath = ..GeneratePath(fileName, receivedTime, folder, "content")
    set str = ##class(%Stream.FileCharacter).%New()
    set status =  str.LinkToFile(filePath)

    if $$$ISERR(status){
        do ..%SetStatusCode("400")
        return "Unable to fetch file. Please ensure it is not outside of the configured archive time period. "_filePath 
    }

    do ..%SetStatusCode("200")
    return str
}

/// Get return all errors for a given upload by row
ClassMethod GetRowErrors(body As %DynamicObject) As %DynamicObject
{
    do %response.TimeoutSet(600)
    
    // Verify proper fields are provided
    set uploadId = body.%Get("uploadId")
    set fileType = $ZCONVERT(body.%Get("fileType"), "l")
    set connectionInfo = body.%Get("connectionInfo")
    if (fileType = "cloudservice") || (fileType = "FTP"){
        if connectionInfo = ""{
            do ..%SetStatusCode("400")
            return {"uploadId": (uploadId),
                    "Message": ("Connection info was not provided for cloud or FTP file.")} 
        }

    }

    // Get message and line from table
    set sql = "SELECT errorMessage, lineNumber, lineDetails "_
                "FROM SC_Core_Data_Internal.BulkUploadErrors WHERE uid = '"_uploadId_"'"

    set tStatement = ##class(%SQL.Statement).%New()
    set qStatus = tStatement.%Prepare(sql)
    if qStatus'=1 {
        do ..%SetStatusCode("500")
        return {"uploadId": (uploadId),
                "Message": ("Improper sql statement "_sql)} 
    }
    
    set rset = tStatement.%Execute()
    if rset.%SQLCODE<0{
        do ..%SetStatusCode("500")
        return {"uploadId": (uploadId),
                "Message": ("Unable to process sql request")} 
    }

    set errorFile = ##class(%Stream.FileCharacter).%New()
    set stat = errorFile.FilenameSet(uploadId_"-errors.csv")
    // Iterate through all errors and append to csv
    while rset.%Next(){
        Set rowNum = rset.%Get("lineNumber")
        Set errorMessage = rset.%Get("errorMessage")
        set lineDetails = rset.%Get("lineDetails")
        do errorFile.WriteLine(rowNum_","_errorMessage_","_lineDetails)

    }
    if errorFile.SizeGet() = 0{
        do ..%SetStatusCode("200")
        Return {"uploadId": (uploadId),
                "Message": ("No errors found for given id")}
    }
    set sc = errorFile.%Save()

    if fileType = "attached"{
        // return JSON
        do ..%SetStatusCode("200")
        return errorFile
    }
    #; elseif fileType="ftp"{
    #;     set url = connectionInfo.%Get("url")
    #;     set keyValue = connectionInfo.%Get("keyValue")
    #;     set userName = connectionInfo.%Get("userName")
    #;     set password = connectionInfo.%Get("password")
    #;     set filePath = connectionInfo.%Get("filePath")
        
    #;     set status = ..UploadFTPFile(url, userName, password, errorFile.Filename, uploadId, filePath)
    #;     if $$$ISERR(status){
    #;         do ..%SetStatusCode("400")
    #;         return {"uploadId": (uploadId),
    #;                 "Message": ("Unable to store file on ftp server")}
    #;     }
    #;     do ..%SetStatusCode("200")
    #;     return {"uploadId": (uploadId),
    #;             "Message": ("File "_uploadId_"-errors.csv is stored on ftp")}
    #; }
    elseif fileType = "cloudservice"{
        set storageProvider = connectionInfo.%Get("storageProvider")
        set userName = connectionInfo.%Get("userName")
        set password = connectionInfo.%Get("password")
        set region = connectionInfo.%Get("region")
        set bucketName = connectionInfo.%Get("bucketName")
        set email = connectionInfo.%Get("email")
        set clientId = connectionInfo.%Get("clientId")
        set sessionToken = connectionInfo.%Get("sessionToken")
        
        set awsStatus = ..CreateAWSCredentialsFile(uploadId, userName, password, region, bucketName, sessionToken)
        if $$$ISERR(awsStatus){
            do ..%SetStatusCode("400")
            return {"uploadId": (uploadId),
            "Message": ("Failed to save AWS credentials to a file.")}
        }
        
        
        #; set stat = ..UploadCloudFile(userName, password, uploadId, errorFile.Filename, storageProvider, bucketName, region, email, clientId, sessionToken)
        set stat = ..UploadCloudFileAWS(uploadId, region, bucketName, ##class(SC.Core.Util.BulkUploadProductionUtil).GetBasename(errorFile.Filename), errorFile.Filename)
        if $$$ISERR(stat){
            do ..%SetStatusCode("500")
            return {"uploadId": (uploadId),
            "Message": ("Error storing file on cloud storage")}
        }
        do ..%SetStatusCode("200")
        return {"uploadId": (uploadId),
                "Message": ("File "_uploadId_"-errors.csv is stored on cloud")}
    }

    else{
        do ..%SetStatusCode("400")
        return "File return type not yet supported"
    }
}

/// Get return all upload ids and requests
ClassMethod GetUploadIds() As %DynamicObject
{
    // Get message and line from table
    set sql = "SELECT TOP 20 BulkUpload.uid, BulkUpload.receivedTime, Request.jsonInput, BulkUpload.Status "_
                "FROM SC_Core_Data_Internal.BulkUpload AS BulkUpload "_
                "INNER JOIN SC_Core_Data_Internal.BulkUploadRequests As Request ON BulkUpload.uid = Request.uid"


    set classInfo = ##class(SC.Core.Util.ClassInfo).%New("SC.Core.Data.Internal.BulkUpload")
    set where = ..GetWhereClause(classInfo, "")
    
    set:where'="" sql = sql_" WHERE "_where

    set sql  = sql_" ORDER BY BulkUpload.receivedTime DESC"

    set tStatement = ##class(%SQL.Statement).%New()
    set qStatus = tStatement.%Prepare(sql)
    if qStatus'=1 {
        do ..%SetStatusCode("500")
        return {"Message": ("Improper sql statement "_sql)} 
    }
    
    set rset = tStatement.%Execute()
    if rset.%SQLCODE<0{
        do ..%SetStatusCode("500")
        return {"Message": ("Unable to process sql request")} 
    }

    // create new JSON for the response
    set jsonResult = ##class(%DynamicObject).%New()
    set jsonResult.uids = []

    // Iterate through all inputs and append to JSON
    while rset.%Next(){
        Set uid = rset.%Get("uid")
        Set receivedTime = rset.%Get("receivedTime")
        set status = rset.%Get("status")
        set jsonInput = ##class(%DynamicObject).%FromJSON(rset.%Get("jsonInput"))

        set jsonResult.uids = jsonResult.uids.%Push({"UID":(uid), "ReceivedTime":(receivedTime), "Status":(status), "Request":(jsonInput)})
    }

    do ..%SetStatusCode("200")
    return jsonResult
}

/// Return the status and other details of an upload
ClassMethod GetUploadStatus(uploadId As %String) As %DynamicObject
{
    // Get details from bulk upload table
    set sql = "SELECT receivedTime, status, finishedTime, targetObject, uploadType, errorMessage, "_
                "fileName, totalRecords, recordsCreated, recordsUpdated, failedRecords, recordCreatedTime "_
                "FROM SC_Core_Data_Internal.BulkUpload WHERE uid = '"_uploadId_"'"
    
    
    set tStatement = ##class(%SQL.Statement).%New()
    set qStatus = tStatement.%Prepare(sql)
    if qStatus'=1 {
        do ..%SetStatusCode("500")
        return {"uploadId": (uploadId),
                "Message": ("Improper sql statement "_sql)} 
    }
    set rset = tStatement.%Execute()
    if rset.%SQLCODE<0{
        do ..%SetStatusCode("500")
        return {"uploadId": (uploadId),
                "Message": ("Unable to process sql request")} 
    }

    // Ensure provided id exists
    do rset.%Next()
    if rset.%Get("recordCreatedTime") = ""{
         do ..%SetStatusCode("400")
         return {"uploadId": (uploadId),
                 "Message": ("Not a valid input id")}  
    }

    // Extract the details from the upload
    set receivedTime = rset.%Get("receivedTime")
    set status = rset.%Get("status")
    set finishedTime = rset.%Get("finishedTime")
    set targetObject = rset.%Get("targetObject")
    set uploadType = rset.%Get("uploadType")
    set fileName = rset.%Get("fileName")
    set totalRecords = rset.%Get("totalRecords")
    set recordsCreated = rset.%Get("recordsCreated")
    set recordsUpdated = rset.%Get("recordsUpdated")
    set failedRecords = rset.%Get("failedRecords")
    set errorMessage = rset.%Get("errorMessage")
    

    // Get details from bulk upload table
    set sql = "SELECT recordCreatedTime, jsonInput "_
                "FROM SC_Core_Data_Internal.BulkUploadRequests WHERE uid = '"_uploadId_"'"
    
    
    set tStatement = ##class(%SQL.Statement).%New()
    set qStatus = tStatement.%Prepare(sql)
    if qStatus'=1 {
        do ..%SetStatusCode("500")
        return {"uploadId": (uploadId),
                "Message": ("Improper sql statement "_sql)} 
    }
    set rset = tStatement.%Execute()
    if rset.%SQLCODE<0{
        do ..%SetStatusCode("500")
        return {"uploadId": (uploadId),
                "Message": ("Unable to process sql request")} 
    }

    // Ensure provided id exists
    do rset.%Next()
    if rset.%Get("recordCreatedTime") = ""{
         do ..%SetStatusCode("400")
         return {"uploadId": (uploadId),
                 "Message": ("Not a valid input id")}  
    }

    // Extract the details from the upload
    set message = ##class(%DynamicObject).%FromJSON(rset.%Get("jsonInput"))

    // Return in a JSON
    do ..%SetStatusCode("200")
    return {"uploadId": (uploadId),
            "receivedTime": (receivedTime),
            "status": (status),
            "errorMessage": (errorMessage),
            "finishedTime": (finishedTime),
            "uploadDetails": {
                "targetObject": (targetObject),
                "uploadType": (uploadType),
                "fileName": (fileName),
                "totalRecords": (totalRecords),
                "recordsCreated": (recordsCreated),
                "recordsUpdated": (recordsUpdated),
                "failedRecords": (failedRecords)
            },
            "uploadRequestSent": (message)
        }
}

/// Initiate a bulk upload
ClassMethod UploadData(file As %File, body As %String) As %DynamicObject
{
    do %response.TimeoutSet(600)

    set uploadId = $System.Util.CreateGUID()
    // Record time request is recieved
    set receivedTime = $ZDATETIME($ZTIMESTAMP, 3, 1, 3)

    // create encription of password (if provided)
    set bodyEncrypt = ##class(%DynamicObject).%FromJSON(body)
    set body = ##class(%DynamicObject).%FromJSON(body)
    set fileDetails = bodyEncrypt.%Get("file")
    if fileDetails '= ""{
        set connectionInfo = fileDetails.%Get("connectionInfo")

        if connectionInfo '= ""{
            set password = connectionInfo.%Get("password")
            set pass = $REPLACE(##class(%SYSTEM.Encryption).SHAHash(224, password), "'", ";")
            do connectionInfo.%Set("password", pass)

            do fileDetails.%Set("connectionInfo", connectionInfo)

            do bodyEncrypt.%Set("file", fileDetails)
        }
    }
    set bodyEncrypt = bodyEncrypt.%ToJSON()

    // Add upload to the table
    set sql = "INSERT INTO SC_Core_Data_Internal.BulkUploadRequests "_
                "(uid, jsonInput) VALUES ('"_uploadId_"', '"_bodyEncrypt_"')"

    set tStatement = ##class(%SQL.Statement).%New()

    set qStatus = tStatement.%Prepare(sql)
    if qStatus'=1 {
        do ..%SetStatusCode("500")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Failed to save JSON")
    }

    set rset = tStatement.%Execute()
    if rset.%SQLCODE<0{
        do ..%SetStatusCode("500")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Failed to save JSON")
    }
    

    // Get object name
    // using the object name get the attributes from ClassInfo.cls
    set targetObject = body.%Get("targetObject")
    if targetObject = ""{
        do ..%SetStatusCode("400")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Target object not provided")    
    }

    set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName(targetObject)
    set classAttributes = ##class(SC.Core.API.Data.ObjectApiImpl).GetObjectAttributes(classname)
    set classInfo = ##class(SC.Core.Util.ClassInfo).%New(classname)

    // Verify classname exists
    if $$$ISERR(classAttributes){
        do ..%SetStatusCode("400")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Invalid classname provided")
    }

    // Extract details from body
    set uploadType = $ZCONVERT(body.%Get("uploadType"), "l")
    if uploadType = ""{
        do ..%SetStatusCode("400")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Upload type not provided")    
    }

    if (uploadType '= "insert") && (uploadType '= "update") && (uploadType '= "upsert"){
        do ..%SetStatusCode("400")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Upload type not supported")    
    }


    // extract details from body and validate
    set mappings = body.%Get("mapping")
    set fileDetails = body.%Get("file")
    set uidAutoGeneration = "false"
    set uidAutoGeneration = $ZCONVERT(body.%Get("uidAutoGeneration"), "l")
    if (uidAutoGeneration = "true") && (uploadType = "update"){
        do ..%SetStatusCode("400")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Uid cannot be auto generated for updates")
    } 

    set priority = $ZCONVERT(body.%Get("priority"), "l")
    if priority = "high"{
        set priority = 1
    }
    elseif priority = "medium"{
        set priority = 2
    }
    elseif priority = "low"{
        set priority = 3
    }
    else{
        do ..%SetStatusCode("400")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Invalid priority provided")
    }
    

    set delimiter = ","
    set defaultTimezone = "+00:00"
    set hasHeaderRow = "false"

    set csvSpec = fileDetails.%Get("csvSpec")

    set temp = csvSpec.%Get("delimiter")
    set:temp'="" delimiter = temp
    set temp = csvSpec.%Get("defaultTimezone")

    set:temp'="" defaultTimezone = temp
    if '(defaultTimezone?1(1"+",1"-")2N1":"2N){
        do ..%SetStatusCode("400")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Invalid timezone provided")
    }

    set temp = $ZCONVERT(csvSpec.%Get("hasHeaderRow"), "l")
    set:temp'="" hasHeaderRow = temp


    // Get the mappings 
    set status = ..GenerateMapping(uploadId, receivedTime, mappings, classAttributes, classInfo, uidAutoGeneration, .attributeList, .csvIdList, 
                                    .formatList, .dateTimeList, .mappingType, .mappingTypeList, .defaultValueList, .delimiterList, .transformationList, .indexList)
    if status '= $$$OK{
        return status
    }

    if (mappingType = "Strings") && (hasHeaderRow = "false"){
        do ..%SetStatusCode("400")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Mapping by header when do header is present")

    } 

    // Extract file details
    set fileSource = $ZCONVERT(fileDetails.%Get("fileSource"), "l")
    set fileName = fileDetails.%Get("fileName")
    set fileType = $ZCONVERT(fileDetails.%Get("fileType"), "l")
    set fileAddr = fileName_"."_fileType

    set path = ..GeneratePath(fileAddr, receivedTime, "processing")
    // Get the file from provided source
    if fileSource = "attached"{

        set fileSave = ##class(%Stream.FileCharacter).%New()
        set stat = fileSave.FilenameSet(path)
        set stat = fileSave.CopyFrom(file)
        set stat = fileSave.%Save()
    }
    elseif fileSource="cloudservice"{
        set connectionInfo = fileDetails.%Get("connectionInfo")
        set storageProvider = connectionInfo.%Get("storageProvider")
        set userName = connectionInfo.%Get("userName")
        set password = connectionInfo.%Get("password")
        set region = connectionInfo.%Get("region")
        set bucketName = connectionInfo.%Get("bucketName")
        set email = connectionInfo.%Get("email")
        set clientId = connectionInfo.%Get("clientId")
        set sessionToken = connectionInfo.%Get("sessionToken")

        set awsStatus = ..CreateAWSCredentialsFile(uploadId, userName, password, region, bucketName, sessionToken)

        if $$$ISERR(awsStatus){
            do ..%SetStatusCode("400")
            return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Failed to save AWS credentials to a file")
        }

        #; set stat = ..GetCloudFile(userName, password, path, uploadId, fileAddr, storageProvider, bucketName, region, email, clientId, sessionToken)
        set stat = ..GetCloudFileAWS(uploadId, region, bucketName, fileAddr, path)

        if $$$ISERR(stat){
            do ..%SetStatusCode(400)
            set errorMessage = $System.Status.GetErrorText(stat)
            return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Failed to get cloud file. Please check credentials and java gateway. If the gateway is out of memory, either wait to retry or restart the java server. "_errorMessage)
        }

    }   
    #; elseif fileSource = "ftp"{
    #;     set connectionInfo = fileDetails.%Get("connectionInfo")

    #;     set url = connectionInfo.%Get("url")
    #;     set userName = connectionInfo.%Get("userName")
    #;     set password = connectionInfo.%Get("password")

    #;     set stat = ..GetFTPFile(url, userName, password, path, uploadId, fileAddr)

    #;     if $$$ISERR(stat){
    #;         do ..%SetStatusCode("400")
    #;         return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Failed to access ftp file")

    #;     }
    #; }
    else{
        do ..%SetStatusCode("400")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Upload type not supported")
    }

    set status = ..ValidateFile(fileType, uploadId, receivedTime, fileSource, path)

    if status '=$$$OK{
        return status
    }

    // Add upload to the table
    set sql = "INSERT INTO SC_Core_Data_Internal.BulkUpload "_
                "(uid, uploadType, status, receivedTime, targetObject, fileName, priority) "_
                "VALUES ('"_uploadId_"', '"_uploadType_"', 'Received1', '"_receivedTime_"', '"_$REPLACE(classname, ".", "_",,1)_"', '"_fileAddr_"', '"_priority_"')"

    set tStatement = ##class(%SQL.Statement).%New()

    set qStatus = tStatement.%Prepare(sql)
    if qStatus'=1 {
        do ..%SetStatusCode("500")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Failed to save upload details")
    }

    set rset = tStatement.%Execute()
    if rset.%SQLCODE<0{
        do ..%SetStatusCode("500")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Failed to save upload details")
    }

    // Add upload to the details table
    set sql = "INSERT INTO SC_Core_Data_Internal.BulkUploadDetails "_
                "(attributeList, dateTimeList, defaultTimezone, defaultValueList, delimiter, "_
                "delimiterList, fileAddr, fileType, formatList, hasHeaderRow, idList, indexList, "_
                "mappingType, mappingTypeList, receivedTime, tableName, transformationList, uid, uidAutoGeneration, uploadType) "_
                "VALUES ('"_attributeList_"', '"_dateTimeList_"', '"_defaultTimezone_"', '"_defaultValueList_"', '"_delimiter_"', '"_
                delimiterList_"', '"_path_"', '"_fileType_"', '"_formatList_"', '"_hasHeaderRow_"', '"_csvIdList_"', '"_indexList_"', '"_
                mappingType_"', '"_mappingTypeList_"', '"_receivedTime_"', '"_$REPLACE(classname, ".", "_",,1)_"', '"_transformationList_"', '"_uploadId_"', '"_uidAutoGeneration_"', '"_uploadType_"')"


    set tStatement = ##class(%SQL.Statement).%New()

    set qStatus = tStatement.%Prepare(sql)
    if qStatus'=1 {
        do ..%SetStatusCode("500")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Failed to save loading details "_sql)
    }

    set rset = tStatement.%Execute()
    if rset.%SQLCODE<0{
        do ..%SetStatusCode("500")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Failed to save loading details "_sql)
    }

    set sql = "UPDATE SC_Core_Data_Internal.BulkUpload SET status = 'Received' WHERE uid = '"_uploadId_"'"

    set qStatus = tStatement.%Prepare(sql)
    if qStatus'=1 {
        do ..%SetStatusCode("500")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Failed to update upload status "_sql)
    }

    set rset = tStatement.%Execute()
    if rset.%SQLCODE<0{
        do ..%SetStatusCode("500")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Failed to update upload status "_sql)
    }
    
    // return success status
    do ..%SetStatusCode("200")
    return ..ReturnErrorText(uploadId, receivedTime, "Succeeded")
}

/// Ensure a Java Server is created and is large enough
ClassMethod GenerateJavaServer()
{
    Try
    {
        new $Namespace
        set $Namespace="%SYS"
        
        set serverExists = $system.external.serverExists("%Java Server")
        if (serverExists){
            do $system.external.stopServer("%Java Server")
            set def = {}
            set def.Name = "%Java Server"
            set def.Type = "Java"
            set def.Port = 53274
            set def.JVMArgs = "-Xmx1024m -Xms128m"
            set srv = $system.external.modifyServer(def)

        } 
        else{
            set def = {}
            set def.Name = "%Java Server"
            set def.Type = "Java"
            set def.Port = 53274
            set def.JVMarguments = "-Xmx1024m -Xms128m"
            set srv = $system.external.createServer(def)
        }
    }
    Catch (exception) 
    {
        set sc = exception.AsStatus()
        $$$ThrowOnError(sc)
    }
}

// /// Create credentials file for cloud storage

// ClassMethod GenerateCredentialsFile(type As %String, ByRef storageProvider As %String, userName As %String, password As %String, email As %String, clientId As %String, sessionToken As %String)

// {

//     set sc = $$$OK

//     set credentialsFile = ##class(%Stream.FileCharacter).%New()

//     set sc = credentialsFile.FilenameSet(##class(%SYS.System).TempDirectory()_"/credentials-"_type_".txt")

//     if $$$ISERR(sc){

//         return sc

//     }

//     if storageProvider = "Amazon S3"{

//         do credentialsFile.WriteLine("[default]")

//         do credentialsFile.WriteLine("aws_access_key_id = "_userName)

//         do credentialsFile.WriteLine("aws_secret_access_key = "_password)

//         do:sessionToken'="" credentialsFile.WriteLine("aws_session_token="_sessionToken)

//         set storageProvider = 0

//     }

//     elseif storageProvider = "Azure Blob"{

//         do credentialsFile.WriteLine("DefaultEndpointsProtocol=https")

//         do credentialsFile.WriteLine("AccountName="_userName)

//         do credentialsFile.WriteLine("AccountKey="_password)

//         do credentialsFile.WriteLine("EndpointSuffix=core.windows.net")

//         set storageProvider = 1

//     }

//     #; elseif storageProvider = "Google Cloud Storage"{

//     #;     do credentialsFile.WriteLine("{")

//     #;     do credentialsFile.WriteLine("""type"": ""service_account"",")

//     #;     do credentialsFile.WriteLine("""project_id"": ""PROJECT_ID"",")

//     #;     do credentialsFile.WriteLine("""private_key_id"": """_userName_""",")

//     #;     do credentialsFile.WriteLine("""private_key"": ""-----BEGIN PRIVATE KEY-----\n"_password_"\n-----END PRIVATE KEY-----\n"",")

//     #;     do credentialsFile.WriteLine("""client_email"": """_email_""",")

//     #;     do credentialsFile.WriteLine("""client_id"": """_clientId_""",")

//     #;     do credentialsFile.WriteLine("""auth_uri"": ""https://accounts.google.com/o/oauth2/auth"",")

//     #;     do credentialsFile.WriteLine("""token_uri"": ""https://accounts.google.com/o/oauth2/token"",")

//     #;     do credentialsFile.WriteLine("""auth_provider_x509_cert_url"": ""https://www.googleapis.com/oauth2/v1/certs"",")

//     #;     do credentialsFile.WriteLine("""client_x509_cert_url"": ""https://www.googleapis.com/robot/v1/metadata/x509/"_email_"""")

//     #;     do credentialsFile.WriteLine("}")

//     #;     set storageProvider = 2

//     #; }

//     else{

//         set sc = $$$ERROR($$$GeneralError,"Invalid storage provider")

//         return sc

//     }

//     set sc = credentialsFile.%Save()

//     if $$$ISERR(sc){

//         return sc

//     }

//     return sc

// }

/// Helper method to change a setting in a production item
ClassMethod ConfigureSetting(name As %String, target As %String, value As %String)
{
    set setting = ##class(Ens.Config.Setting).%New()
    set setting.Name = name
    set setting.Target = target
    set setting.Value = value
    return setting
}

// /// Determine if another upload or download is in progress and stall until it is complete

// /// Stop stalling when timeout may be reached and exit with error

// ClassMethod GetUpdateCloudFTPStatus(uidDetails As %String, errorMessage As %String, Output count As %Numeric)

// {

//     set sc = $$$OK

//     // the current status of an upload/download

//     set sql = "Select status FROM SC_Core_Data_Internal.BulkUploadFiles WHERE uidDetails = '"_uidDetails_"'"

//     set tStatement = ##class(%SQL.Statement).%New()

//     set qStatus = tStatement.%Prepare(sql)

//     if qStatus'=1 {

//         return qStatus

//     }

//     set rset = tStatement.%Execute()

//     if rset.%SQLCODE<0{

//         set sc = $$$ERROR($$$SQLCode,rset.SQLCODE,rset.%Message)

//         return sc

//     }

//     do rset.%Next()

//     set status = rset.%Get("status")

//     set count = 0

//     // If an upload/download is in progress, continue to check if it changes until timeout is reached

//     while status ="in use"{

//         hang 1

//         set count = count + 1

//         set rset = tStatement.%Execute()

//         do rset.%Next()

//         set status = rset.%Get("status")

//         if count > 300{

//             return $$$ERROR($$$GeneralError,errorMessage)

//         }

//     }

//     /// Change the status to in use for the current upload/download

//     set sql = "INSERT OR UPDATE SC_Core_Data_Internal.BulkUploadFiles (uidDetails, status) VALUES ('"_uidDetails_"', 'in use')"

//     set tStatement = ##class(%SQL.Statement).%New()

//     set qStatus = tStatement.%Prepare(sql)

//     if qStatus'=1 {

//         do ..UpdateCloudFTPStatus("open",uidDetails)

//         return qStatus

//     }

//     set rset = tStatement.%Execute()

//     if rset.%SQLCODE<0{

//         do ..UpdateCloudFTPStatus("open", uidDetails)

//         set sc = $$$ERROR($$$SQLCode,rset.SQLCODE,rset.%Message)

//         return sc

//     }

//     return sc

// }

// /// Change the status of a cloud or ftp file upload

// /// Can also change the status of variables stored in this table that are used as locks

// ClassMethod UpdateCloudFTPStatus(status As %String, uidDetails As %String) As %Status

// {

//     set sc = $$$OK

//     set sql = "UPDATE SC_Core_Data_Internal.BulkUploadFiles (status) VALUES ('"_status_"') WHERE uidDetails = '"_uidDetails_"'"

//     set tStatement = ##class(%SQL.Statement).%New()

//     set qStatus = tStatement.%Prepare(sql)

//     if qStatus'=1 {

//         return qStatus

//     }

//     set rset = tStatement.%Execute()

//     if rset.%SQLCODE<0{

//         set sc = $$$ERROR($$$SQLCode,rset.SQLCODE,rset.%Message)

//         return sc

//     }

// }

// /// Begin intiating the process of uploading an FTP file by changing production item settings and enabling the business service

// ClassMethod UploadFTPFile(url As %String, userName As %String, password As %String, fileName As %String, uploadId As %String, fileAddr As %String) As %Status

// {

//     set sc = $$$OK

//     // Check if upload is in progress

//     set sc = ..GetUpdateCloudFTPStatus("UploadFTPFileStatus", "Failed to upload FTP file. Another upload in progress", .count)

//     if $$$ISERR(sc){

//         return sc

//     }

//     set sc = ##class(Ens.Config.Credentials).SetCredential(uploadId, userName, password, 1)

//     if $$$ISERR(sc){

//         do ..UpdateCloudFTPStatus("open", "UploadFTPFileStatus")

//         return sc

//     }

//     // Change the settings for the ftp upload business operation

//     set sc = ##class(Ens.Director).GetProductionStatus(.prodName, .prodState)

//     if prodState '= 1{

//         do ..UpdateCloudFTPStatus("open", "UploadFTPFileStatus")

//         return $$$ERROR($$$GeneralError,"No active production is found")

//     }

//     set exists = ##class(Ens.Config.Item).NameExists(prodName, "Bulk Upload FTP Upload", .itemId)

//     if exists '= 1{

//         do ..UpdateCloudFTPStatus("open", "UploadFTPFileStatus")

//         return $$$ERROR($$$GeneralError,"Item does not exists")

//     }

//     set item =  ##class(Ens.Config.Item).%OpenId(itemId)

//     do item.Settings.Clear()

//     set setting = ..ConfigureSetting("Credentials", "Adapter", uploadId)

//     do item.Settings.Insert(setting)

//     set setting = ..ConfigureSetting("FilePath", "Adapter", fileAddr)

//     do item.Settings.Insert(setting)

//     set baseName = ##class(SC.Core.Util.BulkUploadProductionUtil).GetBasename(fileName)

//     set setting = ..ConfigureSetting("Filename", "Host", baseName)

//     do item.Settings.Insert(setting)

//     set setting = ..ConfigureSetting("FTPServer", "Adapter", url)

//     do item.Settings.Insert(setting)

//     do item.EnabledSet(1)

//     set sc = item.%Save()

//     if $$$ISERR(sc){

//         do ..UpdateCloudFTPStatus("open", "UploadFTPFileStatus")

//         return sc

//     }

//     set sc = ##class(Ens.Director).UpdateProduction(5, 1)

//     if $$$ISERR(sc){

//         do ..UpdateCloudFTPStatus("open", "UploadFTPFileStatus")

//         return sc

//     }

//     // Change the settings for the ftp upload business service and enable

//     set exists = ##class(Ens.Config.Item).NameExists(prodName, "Bulk Upload FTP Upload Helper", .itemId)

//     if exists '= 1{

//         do ..UpdateCloudFTPStatus("open", "UploadFTPFileStatus")

//         return $$$ERROR($$$GeneralError,"Item does not exists")

//     }

//     set helper =  ##class(Ens.Config.Item).%OpenId(itemId)

//     do helper.EnabledSet(1)

//     do helper.Settings.Clear()

//     set setting = ..ConfigureSetting("FileName", "Host", fileName)

//     do helper.Settings.Insert(setting)

//     set setting = ..ConfigureSetting("CallInterval", "Adapter", "120")

//     do helper.Settings.Insert(setting)

//     set sc = helper.%Save()

//     if $$$ISERR(sc){

//         do ..UpdateCloudFTPStatus("open", "UploadFTPFileStatus")

//         return sc

//     }

//     set sc = ##class(Ens.Director).UpdateProduction(5, 1)

//     if $$$ISERR(sc){

//         do ..UpdateCloudFTPStatus("open", "UploadFTPFileStatus")

//         return sc

//     }

//     // disable the helper 

//     do helper.EnabledSet(0)

//     set sc = helper.%Save()

//     if $$$ISERR(sc){

//         do ..UpdateCloudFTPStatus("open", "UploadCloudFileStatus")

//         return sc

//     }

//     // Get the file upload status

//     set baseName = ##class(SC.Core.Util.BulkUploadProductionUtil).GetBasename(fileName)

//     set sql = "SELECT status FROM SC_Core_Data_Internal.BulkUploadFiles WHERE uidDetails = '"_$PIECE(baseName, ".", 1)_"-upload'"

//     set tStatement = ##class(%SQL.Statement).%New()

//     set qStatus = tStatement.%Prepare(sql)

//     if qStatus'=1 {

//         return qStatus

//     }

//     set rset = tStatement.%Execute()

//     if rset.%SQLCODE<0{

//         set sc = $$$ERROR($$$SQLCode,rset.SQLCODE,rset.%Message)

//         return sc

//     }

//     // continue checking status until timeout is reached or file is received

//     do rset.%Next()

//     set status = rset.%Get("status")

//     while status = ""{

//         hang 1

//         set count = count + 1

//         if count > 550{

//             break

//         }

//         set rset = tStatement.%Execute()

//         do rset.%Next()

//         set status = rset.%Get("status")

//     }

//     set sc = ##class(Ens.Director).UpdateProduction(5, 1)

//     if status'="success"{

//         set sc = $$$ERROR($$$GeneralError,"Failed to upload FTP File")

//     }

//     set baseName = ##class(SC.Core.Util.BulkUploadProductionUtil).GetBasename(fileName)

//     set sql = "DELETE FROM SC_Core_Data_Internal.BulkUploadFiles WHERE uidDetails = '"_$PIECE(baseName, ".", 1)_"-upload'"

//     set tStatement = ##class(%SQL.Statement).%New()

//     set qStatus = tStatement.%Prepare(sql)

//     if qStatus'=1 {

//     }

//     set rsetDelete = tStatement.%Execute()

//     do ..UpdateCloudFTPStatus("open", "UploadFTPFileStatus")

//     return sc

// }

// /// Initiate the process of uploading a cloud file

// ClassMethod UploadCloudFile(userName As %String, password As %String, uploadId As %String, fileName As %String, storageProvider As %String, bucketName As %String, storageRegion As %String, email As %String, clientId As %String, sessionToken As %String) As %Status

// {

//     set sc = $$$OK

//     set sc = ..GetUpdateCloudFTPStatus("UploadCloudFileStatus", "Failed to upload Cloud File, another upload in progress", .count)

//     if $$$ISERR(sc){

//         return sc

//     }

//     set prodState = 0

//     while (prodState '= 1) && (count < 60){

//         set count = count + 1

//         hang 1

//         set sc = ##class(Ens.Director).GetProductionStatus(.prodName, .prodState)

//     }

//     // Update the settings for the cloud service upload business operation

//     if prodState '= 1{

//         do ..UpdateCloudFTPStatus("open", "UploadCloudFileStatus")

//         return $$$ERROR($$$GeneralError,"No active production is found")

//     }

//     set exists = ##class(Ens.Config.Item).NameExists(prodName, "Bulk Upload Cloud Service Upload", .itemId)

//     if exists '= 1{

//         do ..UpdateCloudFTPStatus("open", "UploadCloudFileStatus")

//         return $$$ERROR($$$GeneralError,"Item does not exists")

//     }

//     set item =  ##class(Ens.Config.Item).%OpenId(itemId)

//     do item.Settings.Clear()

//     set sc = ..GenerateCredentialsFile("upload", .storageProvider, userName, password, email, clientId, sessionToken)

//     if $$$ISERR(sc){

//         do ..UpdateCloudFTPStatus("open", "UploadCloudFileStatus")

//         return sc

//     }

//     set setting = ..ConfigureSetting("ProviderCredentialsFile", "Adapter",##class(%SYS.System).TempDirectory()_"/credentials-upload.txt")

//     do item.Settings.Insert(setting)

//     set setting = ..ConfigureSetting("BucketName", "Host", bucketName)

//     do item.Settings.Insert(setting)

//     set setting = ..ConfigureSetting("StorageProvider", "Adapter", storageProvider)

//     do item.Settings.Insert(setting)

//     set setting = ..ConfigureSetting("StorageRegion", "Adapter", storageRegion)

//     do item.Settings.Insert(setting)        

//     set sc = item.%Save()

//     if $$$ISERR(sc){

//         do ..UpdateCloudFTPStatus("open", "UploadCloudFileStatus")

//         return sc

//     }

//     // change the settings for the cloud upload helper business service and enable

//     set exists = ##class(Ens.Config.Item).NameExists(prodName, "Bulk Upload Cloud Upload Helper", .itemId)

//     if exists '= 1{

//         do ..UpdateCloudFTPStatus("open", "UploadCloudFileStatus")

//         return $$$ERROR($$$GeneralError,"Item does not exists")

//     }

//     set helper =  ##class(Ens.Config.Item).%OpenId(itemId)

//     do helper.EnabledSet(1)

//     do helper.Settings.Clear()

//     set setting = ..ConfigureSetting("FileName", "Host", fileName)

//     do helper.Settings.Insert(setting)

//     set setting = ..ConfigureSetting("CallInterval", "Adapter", "400")

//     do helper.Settings.Insert(setting)

//     set sc = helper.%Save()

//     if $$$ISERR(sc){

//         do ..UpdateCloudFTPStatus("open", "UploadCloudFileStatus")

//         return sc

//     }

//     set sc = ##class(Ens.Director).UpdateProduction(5, 1)

//     if $$$ISERR(sc){

//         do ..UpdateCloudFTPStatus("open", "UploadCloudFileStatus")

//         return sc

//     }

//     do helper.EnabledSet(0)

//     set sc = helper.%Save()

//     if $$$ISERR(sc){

//         do ..UpdateCloudFTPStatus("open", "UploadCloudFileStatus")

//         return sc

//     }

//     // Get the status of the current upload

//     set baseName = ##class(SC.Core.Util.BulkUploadProductionUtil).GetBasename(fileName)

//     set sql = "SELECT status FROM SC_Core_Data_Internal.BulkUploadFiles WHERE uidDetails = '"_$PIECE(baseName, ".", 1)_"-upload'"

//     set tStatement = ##class(%SQL.Statement).%New()

//     set qStatus = tStatement.%Prepare(sql)

//     if qStatus'=1 {

//         do ..UpdateCloudFTPStatus("open", "UploadCloudFileStatus")

//         return qStatus

//     }

//     set rset = tStatement.%Execute()

//     if rset.%SQLCODE<0{

//         do ..UpdateCloudFTPStatus("open", "UploadCloudFileStatus")

//         set sc = $$$ERROR($$$SQLCode,rset.SQLCODE,rset.%Message)

//         return sc

//     }

//     // Continue to check the status until it is complete or a timeout is reached

//     do rset.%Next()

//     set status = rset.%Get("status")

//     while status = ""{

//         hang 1

//         set count = count + 1

//         if count > 550{

//             break

//         }

//         set rset = tStatement.%Execute()

//         do rset.%Next()

//         set status = rset.%Get("status")

//     }

//     set sc = ##class(Ens.Director).UpdateProduction(5, 1)

//     if status'="success"{

//         set sc = $$$ERROR($$$GeneralError,"Failed to upload Cloud File")

//     }

//     set baseName = ##class(SC.Core.Util.BulkUploadProductionUtil).GetBasename(fileName)

//     set sql = "DELETE FROM SC_Core_Data_Internal.BulkUploadFiles WHERE uidDetails = '"_$PIECE(baseName, ".", 1)_"-upload'"

//     set tStatement = ##class(%SQL.Statement).%New()

//     set qStatus = tStatement.%Prepare(sql)

//     if qStatus'=1 {

//     }

//     set rsetDelete = tStatement.%Execute()

//     do ..UpdateCloudFTPStatus("open", "UploadCloudFileStatus")

//     return sc

// }

// /// Initiate the download of a file from the ftp server

// /// This will cause the file to be removed from the server if successful

// ClassMethod GetFTPFile(url As %String, userName As %String, password As %String, path As %String, uploadId As %String, fileAddr As %String) As %Status

// {

//     set sc = $$$OK

//     Try{

//         set sc = ..GetUpdateCloudFTPStatus("GetFTPFileStatus", "Failed to upload Cloud File, another upload in progress", .count)

//         if $$$ISERR(sc){

//             return sc

//         }

//         set sc = ##class(Ens.Config.Credentials).SetCredential(uploadId, userName, password)

//         if $$$ISERR(sc){

//             do ..UpdateCloudFTPStatus("open", "GetFTPFileStatus")

//             return sc

//         }

//         set sc = ##class(Ens.Director).GetProductionStatus(.prodName, .prodState)

//         if prodState '= 1{

//             do ..UpdateCloudFTPStatus("open", "GetFTPFileStatus")

//             return $$$ERROR($$$GeneralError,"No active production is found")

//         }

//         // Change the settings for the ftp download business service

//         set exists = ##class(Ens.Config.Item).NameExists(prodName, "Bulk Upload FTP Download", .itemId)

//         if exists '= 1{

//             do ..UpdateCloudFTPStatus("open", "GetFTPFileStatus")

//             return $$$ERROR($$$GeneralError,"Item does not exists")

//         }

//         set item =  ##class(Ens.Config.Item).%OpenId(itemId)

//         do item.Settings.Clear()

//         set setting = ..ConfigureSetting("Credentials", "Adapter", uploadId)

//         do item.Settings.Insert(setting)

//         set setting = ..ConfigureSetting("FileSpec", "Adapter", fileAddr)

//         do item.Settings.Insert(setting)

//         set setting = ..ConfigureSetting("ArchivePath", "Adapter", ##class(%SYS.System).TempDirectory()_"/processing")

//         do item.Settings.Insert(setting)

//         set setting = ..ConfigureSetting("FTPServer", "Adapter", url)

//         do item.Settings.Insert(setting)

//         set setting = ..ConfigureSetting("DownloadName", "Host", path)

//         do item.Settings.Insert(setting)

//         set setting = ..ConfigureSetting("AppendTimestamp", "Adapter", 0)

//         do item.Settings.Insert(setting)

//         set setting = ..ConfigureSetting("UseFileStream", "Adapter", "1")

//         do item.Settings.Insert(setting)

//         do item.EnabledSet(1)

//         set sc = item.%Save()

//         if $$$ISERR(sc){

//             do ..UpdateCloudFTPStatus("open", "GetFTPFileStatus")

//             return sc

//         }

//         set sc = ##class(Ens.Director).UpdateProduction(5, 1)

//         if $$$ISERR(sc){

//             do ..UpdateCloudFTPStatus("open", "GetFTPFileStatus")

//             return sc

//         }

//         set item = ""

//         set sc = ..UpdateCloudFTPProduction(itemId, path, "GetFTPFileStatus", count, "download")

//         if $$$ISERR(sc){

//             do ..UpdateCloudFTPStatus("open", "GetFTPFileStatus")

//             return sc

//         }

//     }

//     Catch ex{

//         set item = ""

//         set sc = ..UpdateCloudFTPProduction(itemId, path, "GetFTPFileStatus", count, "download")

//         if $$$ISERR(sc){

//             do ..UpdateCloudFTPStatus("open", "GetFTPFileStatus")

//             return sc

//         }

//         set sc = $$$OK

//     }

//     do ##class(Ens.Director).UpdateProduction(5, 1)

//     return sc

// }

// /// Determine if a file has been downloaded and timeout if failed

// ClassMethod UpdateCloudFTPProduction(itemId As %String, path As %String, uidDetails As %String, count As %Numeric, type As %String) As %Status

// {

//     set sc = $$$OK

//     set item =  ##class(Ens.Config.Item).%OpenId(itemId)

//     // Check if the item is enabled, timeout if too long

//     while item.Enabled = 1{

//         hang 1

//         set count = count + 1

//         if count > 450{

//             do item.EnabledSet(0)

//             do item.Settings.Clear()

//             set stat = item.%Save()

//             if $$$ISERR(stat){

//                 set sc = stat

//             }

//             set sc = ##class(Ens.Director).UpdateProduction(5, 1)

//             set sc = $$$ERROR($$$GeneralError,"File not found")

//             return sc

//         }

//         set item = ""

//         set item =  ##class(Ens.Config.Item).%OpenId(itemId)

//     }

//     do ..UpdateCloudFTPStatus("open", uidDetails)

//     set sc = ##class(Ens.Director).UpdateProduction(5, 1)

//     if $$$ISERR(sc){

//         do ..UpdateCloudFTPStatus("open", uidDetails)

//         return sc

//     }

//     // Determine if the file was downloaded sucessfully

//     set sql = "SELECT status FROM SC_Core_Data_Internal.BulkUploadFiles WHERE uidDetails = '"_$PIECE(path, ".", 1)_"-"_type_"'"

//     set tStatement = ##class(%SQL.Statement).%New()

//     set qStatus = tStatement.%Prepare(sql)

//     if qStatus'=1 {

//         do ..UpdateCloudFTPStatus("open", uidDetails)

//         return qStatus

//     }

//     set rset = tStatement.%Execute()

//     if rset.%SQLCODE<0{

//         do ..UpdateCloudFTPStatus("open", uidDetails)

//         set sc = $$$ERROR($$$SQLCode,rset.SQLCODE,rset.%Message)

//         return sc

//     }

//     do rset.%Next()

//     set status = rset.%Get("status")

//     if status'="success"{

//         do ..UpdateCloudFTPStatus("open", uidDetails)

//         set sc = $$$ERROR($$$GeneralError,"Failed to process file")

//     }

//     do ##class(Ens.Director).UpdateProduction(5, 1)

//     return sc

// }

// /// Initiate the process of downloading a cloud file

// ClassMethod GetCloudFile(userName As %String, password As %String, path As %String, uploadId As %String, fileAddr As %String, storageProvider As %String, bucketName As %String, storageRegion As %String, email As %String, clientId As %String, sessionToken As %String) As %Status

// {

//     set sc = $$$OK

//     Try{

//         set sc = ..GetUpdateCloudFTPStatus("GetCloudFileStatus", "Failed to upload Cloud File, another upload in progress", .count)

//         if $$$ISERR(sc){

//             return sc

//         }

//         set prodState = 0

//         while (prodState '= 1) && (count < 180){

//             set count = count + 1

//             hang 1

//             set sc = ##class(Ens.Director).GetProductionStatus(.prodName, .prodState)

//         }

//         while (prodState = 0){

//             set sc = ##class(Ens.Director).GetProductionStatus(.prodName, .prodState)

//         }

//         if prodState '= 1{

//             do ..UpdateCloudFTPStatus("open", "GetCloudFileStatus")

//             return $$$ERROR($$$GeneralError,"No active production is found")

//         }

//         set exists = ##class(Ens.Config.Item).NameExists(prodName, "Bulk Upload Cloud Service Download", .itemId)

//         if exists '= 1{

//             do ..UpdateCloudFTPStatus("open", "GetCloudFileStatus")

//             return $$$ERROR($$$GeneralError,"Item does not exists")

//         }

//         set item =  ##class(Ens.Config.Item).%OpenId(itemId)

//         do item.Settings.Clear()

//         // Create credential file and update settings for the cloud download business service

//         set sc = ..GenerateCredentialsFile("download", .storageProvider, userName, password, email, clientId, sessionToken)

//         if $$$ISERR(sc){

//             do ..UpdateCloudFTPStatus("open", "GetCloudFileStatus")

//             return sc

//         }

//         set setting = ..ConfigureSetting("ProviderCredentialsFile", "Adapter", ##class(%SYS.System).TempDirectory()_"/credentials-download.txt")

//         do item.Settings.Insert(setting)

//         set setting = ..ConfigureSetting("BucketName", "Adapter", bucketName)

//         do item.Settings.Insert(setting)

//         set setting = ..ConfigureSetting("BlobNamePattern", "Adapter", fileAddr)

//         do item.Settings.Insert(setting)

//         set setting = ..ConfigureSetting("StorageProvider", "Adapter", storageProvider)

//         do item.Settings.Insert(setting)

//         set setting = ..ConfigureSetting("StorageRegion", "Adapter", storageRegion)

//         do item.Settings.Insert(setting)

//         set setting = ..ConfigureSetting("OutputFilename", "Host", path)

//         do item.Settings.Insert(setting)

//         set setting = ..ConfigureSetting("TargetConfigNames", "Host", "Bulk Upload Save File")

//         do item.Settings.Insert(setting)

//         set setting = ..ConfigureSetting("DeleteAfterDownload", "Adapter", "0")

//         do item.Settings.Insert(setting)

//         do item.EnabledSet(1)

//         set sc = item.%Save()

//         if $$$ISERR(sc){

//             do ..UpdateCloudFTPStatus("open", "GetCloudFileStatus")

//             return sc

//         }

//         set sc = ##class(Ens.Director).UpdateProduction(5, 1)

//         if $$$ISERR(sc){

//             do ..UpdateCloudFTPStatus("open", "GetCloudFileStatus")

//             return sc

//         }

//         set item = ""

//         set sc = ..UpdateCloudFTPProduction(itemId, path, "GetCloudFileStatus", count, "download")

//         if $$$ISERR(sc){

//             do ..UpdateCloudFTPStatus("open", "GetCloudFileStatus")

//         }

//     }

//     Catch ex{

//         set item = ""

//         set sc = ..UpdateCloudFTPProduction(itemId, path, "GetCloudFileStatus", count, "download")

//         if $$$ISERR(sc){

//             do ..UpdateCloudFTPStatus("open", "GetCloudFileStatus")

//         }

//         set sc = ex.AsStatus()

//     }

//     do ##class(Ens.Director).UpdateProduction(5, 1)

//     return sc

// }

/// Add a failed entry into record table
ClassMethod SaveFailedEntry(uploadId As %String, receivedTime As %DateTime = "", errorMessage As %String) As %Status
{
    Set sc = $$$OK
    if receivedTime = ""{
        set sql = "INSERT OR UPDATE SC_Core_Data_Internal.BulkUpload "_
                    "(uid, status, errorMessage) "_
                    "VALUES ('"_uploadId_"', 'Failed', '"_errorMessage_"')"
    }else{ 
        set sql = "INSERT OR UPDATE SC_Core_Data_Internal.BulkUpload "_
                    "(uid, status, receivedTime, errorMessage) "_
                    "VALUES ('"_uploadId_"', 'Failed', '"_receivedTime_"', '"_errorMessage_"')"
    }
    set tStatement = ##class(%SQL.Statement).%New()

    set qStatus = tStatement.%Prepare(sql)
    if qStatus'=1 {
        do ..%SetStatusCode("500")
        return {"uploadId": (uploadId),
                "receivedTime": (receivedTime),
                "Status": ("failed"),
                "Message": ("Failed to save failed entry")}
    }

    set rset = tStatement.%Execute()
    if rset.%SQLCODE<0{
        do ..%SetStatusCode("500")
        return {"uploadId": (uploadId),
                "receivedTime": (receivedTime),
                "Status": ("failed"),
                "Message": ("Failed to save failure")} 
    }
    Return sc
}

/// Generate mappings 
ClassMethod GenerateMapping(uploadId As %String, receivedTime As %DateTime, mappings As %DynamicObject, classAttributes As %ListOfDataTypes, classInfo As SC.Core.Util.ClassInfo, uidAutoGeneration As %String, Output attributeList As %String, Output csvIdList As %String, Output formatList As %String, Output dateTimeList As %String, Output mappingType As %String, Output mappingTypeList As %String, Output defaultValueList As %String, Output delimiterList As %String, Output transformationList As %String, Output indexList As %String) As %Status
{
   
    Set sc = $$$OK

    set iter = mappings.%GetIterator()
    set mappingType = "Strings"
    set attributeList = ""
    set csvIdList = ""
    set formatList = ""
    set dateTimeList = ""
    set mappingTypeList = ""
    set defaultValueList = ""
    set delimiterList = ""
    set transformationList = ""
    set indexList = ""

    // iterate over the mappings
    set i = 0
    while iter.%GetNext(,.map){
        set i = i+1
        set attributeName = map.%Get("attributeName")
        set csvColumnIndex = map.%Get("csvColumnIndex")
        set csvColumnHeader = map.%Get("csvColumnHeader")
        set defaultValue = map.%Get("defaultValue")
        set typeOfMapping = $ZCONVERT(map.%Get("mappingType"), "l")
        set transformation = map.%Get("transformation")
        set csvColumns = map.%Get("csvColumns")
        set mapDelimiter = map.%Get("delimiter")

        set format = map.%Get("format")

        if typeOfMapping = "direct"{
            if transformation '=""{
                do ..%SetStatusCode("400")
                return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Transformation not valid for type direct")
            }
            if csvColumns '= ""{
                do ..%SetStatusCode("400")
                return ..ReturnErrorText(uploadId, receivedTime, "Failed", "csvColumns not valid for type direct")
            }
            if mapDelimiter '=""{
                do ..%SetStatusCode("400")
                return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Map delimiter not valid for type direct")
            }

        }
        elseif typeOfMapping = "transformation"{
            if format '= ""{
                do ..%SetStatusCode("400")
                return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Date format invalid for type transform")   
            } 
            if csvColumns '= ""{
                do ..%SetStatusCode("400")
                return ..ReturnErrorText(uploadId, receivedTime, "Failed", "csvColumns not valid for type transform")
            }
            if mapDelimiter '=""{
                do ..%SetStatusCode("400")
                return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Map delimiter not valid for type transform")
            }
            
           set transformation =  transformation.%ToJSON()

        }
        elseif typeOfMapping = "aggregation"{
            if format '= ""{
                do ..%SetStatusCode("400")
                return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Date format invalid for type aggregation")
            }
            if transformation '=""{
                do ..%SetStatusCode("400")
                return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Transformation not valid for type direct")
            }

            set csvColumns = $REPLACE(csvColumns, ",", ";")

        }
        else{
            do ..%SetStatusCode("400")
            return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Invalid mapping type provided")   
        }

        // Create lists of csv columns
        set csvId = ""
        if csvColumnHeader'=""{
            set csvId = csvColumnHeader
        }
        elseif csvColumnIndex'=""{
            set csvId = csvColumnIndex
            set mappingType = "Numbers"
        }
        else{
            if typeOfMapping '= "aggregation"{
                do ..%SetStatusCode("400")
                return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Invalid mapping information provided")   
            }
        }

        // if it is found in string or numerical attributes and not in attribute list
        set location = classAttributes.Find(attributeName)
        if location = ""{
            do ..%SetStatusCode("400")
            return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Attribute name not recognized or already mapped"_attributeName)
        }  

        do classAttributes.RemoveAt(location)
        
        // Verify attribute exists and is unique
        if $FIND(attributeList, attributeName)'=0{
            do ..%SetStatusCode("400")
            return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Invalid mapping information provided")
        }

        if attributeList '= ""{
            set attributeList = attributeList_", "
            set csvIdList = csvIdList_", "
            set formatList = formatList_", "
            set dateTimeList = dateTimeList_", "
            set mappingTypeList = mappingTypeList_", "
            set defaultValueList = defaultValueList_", "
            set delimiterList = delimiterList_", "
            set indexList = indexList_", "
            set transformationList = transformationList_", ["
        }
        if transformationList = ""{
            set transformationList = "["
        }

        set mappingTypeList = mappingTypeList_typeOfMapping
        set defaultValueList = defaultValueList_defaultValue
        set delimiterList = delimiterList_mapDelimiter
        set indexList = indexList_csvColumns
        set transformationList = transformationList_transformation_"]"



        if classInfo.isDateTimeAttribute(attributeName){
            set dateTimeList = dateTimeList_"1"
        }

        // Verify timezone and format info are only given to date time attributes
        if ('classInfo.isDateTimeAttribute(attributeName)) && (format '= ""){
            do ..%SetStatusCode("400")
            return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Time information provided to non date time object")
        }

        set formatList = formatList_format

        set attributeList = attributeList_attributeName
        set csvIdList = csvIdList_csvId
    }

    set attrCount = classAttributes.Count()
    if ($FIND(attributeList, "uid")=0) && (uidAutoGeneration = "true"){
        set attributeList = attributeList_", uid"
        set csvIdList = csvIdList_", "
        set formatList = formatList_", "
        set dateTimeList = dateTimeList_", "
        set mappingTypeList = mappingTypeList_", uid"
        set defaultValueList = defaultValueList_", "
        set delimiterList = delimiterList_", "
        set indexList = indexList_", "
        set transformationList = transformationList_", []"

        set location = classAttributes.Find("uid")
        do classAttributes.RemoveAt(location)
        set attrCount = classAttributes.Count()
    }

    // Ensure all required attributes are mapped
    if attrCount > 0{
        set missingList = ""

        For i = 1:1:attrCount {
            if '($FIND(classInfo.RequiredAttributesGet(), classAttributes.GetAt(i)) = 0){
                if missingList = ""{
                    set missingList = classAttributes.GetAt(i)
                }
                else{
                    set missingList = missingList_", "_classAttributes.GetAt(i)
                }
            }
        }
        if missingList '= ""{
            do ..%SetStatusCode("400")
            return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Incomplete mapping information provided. Missing: "_missingList)
        }
        

    }

    Return sc
}

/// Ensure the file is valid
ClassMethod ValidateFile(fileType As %String, uploadId As %String, receivedTime As %DateTime, fileSource As %String, path As %String) As %Status
{
    Set sc = $$$OK
    if fileType '= "csv"{
        do ..%SetStatusCode("400")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "File type is not supported")    
    }

    if '##class(%File).Exists(path){
        do ..%SetStatusCode("500")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "File was not retrieved successfully "_path)    
    }

    set file = ##class(%File).%New(path)
    // verify file is small enough
    if file.Size > (1000000*..#FILESIZE){
        do ..%SetStatusCode("400")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "File exceeded the size limit "_(file.Size/1000000)_" "_..#FILESIZE) 
    }

    // ensure file can be opened
    set status = file.Open("R")

    if $$$ISERR(status){
        do ..%SetStatusCode("500")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "Failed to open the file")
    }

    set verify = ..VerifyEncoding(path)

    if verify = "false"{
        do ..%SetStatusCode("400")
        return ..ReturnErrorText(uploadId, receivedTime, "Failed", "File encoding not supported. UTF-8 required")
    }

    Return sc
}

/// Verify encoding
ClassMethod VerifyEncoding(fileAddr As %String) As %String [ Language = python ]
{
    import codecs
    try:
        codecs.open(fileAddr, encoding="utf-8", errors="strict").readlines()
        return "true"
    except UnicodeDecodeError:
        return "false"
}

/// Generate path to the source folder
ClassMethod GeneratePath(fileAddr As %String, receivedTime As %String, folder As %String, type = "") As %String
{
    // get location of temp folder
    
    set fileAddr = ##class(%File).NormalizeFilename(fileAddr)
    set tempPath = ##class(%SYS.System).TempDirectory()
    set path = tempPath_"/"_folder

    if '##class(%File).DirectoryExists(path){
        set dir = ##class(%File).CreateDirectory(path)
    }
    
    // extract file name and extension name from address
    set baseName = ##class(SC.Core.Util.BulkUploadProductionUtil).GetBasename(fileAddr)
    set extName = "."_$PIECE(baseName, ".", *)
    set fileName = $REPLACE(baseName, extName, "")

    if ((folder = "complete") || (folder = "failed")) && (type '= "content"){
        return ##class(%File).NormalizeFilename(path_"/"_baseName)
    }

    // format timestamp
    set time = $REPLACE(receivedTime, "-", "_")
    set time = $REPLACE(time, ":", "_")
    set time = $REPLACE(time, ".", "_")
    set time = $REPLACE(time, " ", "_")

    set path = path_"/"_fileName_"-"_time_extName
    set path = ##class(%File).NormalizeFilename(path)
    return path
}

/// Error return
ClassMethod ReturnErrorText(uploadId As %String, receivedTime As %String, status As %String, message = "") As %Status
{
    if message '= ""{
        set uploadStatus = ..SaveFailedEntry(uploadId, receivedTime, message)
        return {"uploadId": (uploadId),
                "receivedTime": (receivedTime),
                "Status": (status),
                "Message": (message)}
    }
    else{
        return {"uploadId": (uploadId),
                "receivedTime": (receivedTime),
                "Status": (status)
        }
    }
}

// Verify the AWS credentials and bucket are valid before trying to get the data

ClassMethod CreateAWSCredentialsFile(uploadId As %String, userName As %String, password As %String, region As %String, bucketName As %String, sessionToken As %String = "")
{
    set sc = $$$OK
    try{
        set credentialsFile = ##class(%Stream.FileCharacter).%New()

        set tempCredentialsPath = ##class(%SYS.System).TempDirectory()_"/"_uploadId_".txt"
        set sc = credentialsFile.FilenameSet(tempCredentialsPath)
        if $$$ISERR(sc){
            return sc
        }

        do credentialsFile.WriteLine("[default]")
        do credentialsFile.WriteLine("aws_access_key_id = "_userName)
        do credentialsFile.WriteLine("aws_secret_access_key = "_password)
        do:sessionToken'="" credentialsFile.WriteLine("aws_session_token="_sessionToken)
        set storageProvider = 0

        set sc = credentialsFile.%Save()
        if $$$ISERR(sc){
            return sc
        }
        return sc
    }
    catch ex{
        set sc = ##class(%File).Delete(tempCredentialsPath)
        return ex.AsStatus()
    }

    return sc
}

ClassMethod GetCloudFileAWS(uploadId As %String, region As %String, bucketName As %String, blobName As %String, outputFilePath As %String)
{
    try{
        set tempCredentialsPath = ##class(%SYS.System).TempDirectory()_"/"_uploadId_".txt"

        set sc = ##class(%Net.Cloud.Storage.Client).SingleDownloadBlobToFile(, 0, tempCredentialsPath, region,, bucketName, blobName, outputFilePath)

        if $$$ISERR(sc){
            do ##class(%File).Delete(tempCredentialsPath)
            return sc

        }
        set sc = ##class(%File).Delete(tempCredentialsPath)
    }
    Catch ex{
        set sc = ex.AsStatus()
    }
    return sc
}

ClassMethod UploadCloudFileAWS(uploadId As %String, region As %String, bucketName As %String, blobName As %String, localFilePath As %String)
{
    set tempCredentialsPath = ##class(%SYS.System).TempDirectory()_"/"_uploadId_".txt"

    set sc = ##class(%Net.Cloud.Storage.Client).SingleUploadBlobFromFile(, 0, tempCredentialsPath, region,, bucketName, blobName, localFilePath)
    if $$$ISERR(sc){
        do ##class(%File).Delete(tempCredentialsPath)
        return sc

    }
    set sc = ##class(%File).Delete(tempCredentialsPath)
    return sc
}

}
