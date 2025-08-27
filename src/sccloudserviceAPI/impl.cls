/*
Copyright (c) 2025 by InterSystems Corporation.
Boston, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// API for InterSystems IRIS supply chain cloud services<br/>
/// Business logic class defined by OpenAPI in sccloudserviceAPI.spec<br/>
/// Updated Aug 26, 2025 14:25:13
Class sccloudserviceAPI.impl Extends %REST.Impl [ ProcedureBlock ]
{

/// If ExposeServerExceptions is true, then details of internal errors will be exposed.
Parameter ExposeServerExceptions = 1;

/// name of the application in our license 
Parameter AppName = "ISC.SupplyChain";

/// name of the application in our license 
Parameter ServiceName = "T&T_MacroPoint";

/// Registers track and trace service to IRIS for SC<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod RegisterTrackAndTrace(body As %DynamicObject) As %DynamicObject
{
    try {
        tstart
        // Validation check to see if the license is valid
        set message = ""
        if ($$$ISERR(..validateInputForTnTRegistratonHelper(body, .message))) {
            trollback 1
            do ..%SetStatusCode("400")
            return {
                "Status":"Failed",
                "Message": (message)
            }
        }
        if '(##class(utils.LicenseCheck).IsAppLicensed() && 
            ##class(utils.LicenseCheck).CheckSupplyChainLicense() && 
            ##class(utils.LicenseCheck).CheckServiceLicense(..#ServiceName)
            ){
            trollback 1
            do ..%SetStatusCode("400")
            return {
                "Status":"Failed",
                "Message": "Invalid License"
            }
        }


        // Get the IRIS key file
        set installDir = $system.Util.InstallDirectory()
        set keyFilePath = installDir_"mgr/iris.key"

        set stream=##class(%Stream.FileCharacter).%New()
        set sc=stream.LinkToFile(keyFilePath)
        set keyString = ""
        while 'stream.AtEnd {
            set line=stream.Read()
            set keyString = keyString_line
        }


        // create SHA 256 hash of the key file
        set licenseDigest = $system.Encryption.SHA3Hash(256, keyString)
        set shaHash = ##class(%xsd.hexBinary).LogicalToXSD(licenseDigest)

        set irisTntDigest = body.%Get("IRIS_Key_Digest", ,"string")

        // compare the hash value with the one sent by T&T-
        if ($ZCONVERT(shaHash, "L") '= irisTntDigest) {
            do ..%SetStatusCode("400")
            return {
                "Status":"Failed",
                "Message": "Invalid License"
            }
        }

        set listString = $LISTFROMSTRING(keyString, $CHAR(10))
        set ptr = 0
        WHILE $LISTNEXT(listString, ptr, attr) {
            set temp = $LISTFROMSTRING(attr, "=")
            if ($LISTLENGTH(temp) = 2){
            set map($ZSTRIP($LISTGET(temp,1), "<>", " ")) = $ZSTRIP($LISTGET(temp,2), "<>", " ")
            }
        }

        set myquery = "update sc_core_data_internal.cloudservice set active = 0 where name = 'T&T_MacroPoint' and active = 1"
        set tStatement = ##class(%SQL.Statement).%New()
        set qStatus = tStatement.%Prepare(myquery)
        if qStatus'= 1 {
            trollback 1
            do ..%SetStatusCode("500")
            return {
                "Status":"Error",
                "Message": ("Server error: "_$System.Status.DisplayError(qStatus))
            }
        }
        set rset = tStatement.%Execute()
        if rset.%SQLCODE < 0 {
            trollback 1
            do ..%SetStatusCode("500")
            return {
                "Status": "Error", 
                "Message": ("Something went wrong ")
            } 
        }

        set authorization = ##class(%REST.Impl).%GetHeader("authorization")
        set authList = $LISTFROMSTRING(authorization, " ")
        set credentials = $LISTGET(authList,2)
        set credentials = $System.Encryption.Base64Decode(credentials)
        set credList = $LISTFROMSTRING(credentials, ":")
        set username = $LISTGET(credList,1)
        set password = $LISTGET(credList,2)
        set currentNamespace = $NAMESPACE

        new $Namespace
        set $Namespace = "%SYS"

        set exisitingAesKeys = ##class(%SYSTEM.Encryption).ListEncryptionKeys()
        set aesKeysList = $LISTFROMSTRING(exisitingAesKeys, ",")
        if ($LISTLENGTH(aesKeysList) = 0){
            set aesKey = ##class(%SYSTEM.Encryption).CreateEncryptionKey("T&T_API_KEY", username, password, 32, .keyStatus)
            if keyStatus'= 1 {
                trollback 1
                do ..%SetStatusCode("500")
                    return {"Status": "Error", 
                            "Message": ("Something went wrong in creating encryption key"_keyStatus)} 
            }

            set keyActivationStatus = ##class(%SYSTEM.Encryption).ActivateEncryptionKey("T&T_API_KEY", username, password)
            if keyActivationStatus'= 1 {
                trollback 1
                do ..%SetStatusCode("500")
                    return {"Status": "Error", 
                            "Message": ("Something went wrong")} 
            }
        } else {
            set aesKey = $LISTGET(aesKeysList,1)
        }


        new $Namespace
        set $Namespace = currentNamespace

        set tntAPIPasswordEncoded = body.%Get("T&T_API_Password", ,"string")
        set tntAPIPassword = $system.Encryption.Base64Decode(tntAPIPasswordEncoded)
        set text = $ZCONVERT(tntAPIPassword,"O","UTF8")
        set text = $SYSTEM.Encryption.AESCBCManagedKeyEncrypt(text,aesKey)
        set encryptedTntAPIPassword = $SYSTEM.Encryption.Base64Encode(text)
        
        set cloudService = ##class(SC.Core.Data.Internal.CloudService).%New()
        set cloudService.uid = $SYSTEM.Util.CreateGUID()
        set cloudService.name = "T&T_MacroPoint"
        set cloudService.url = body.%Get("T&T_Macropoint_URL", ,"string")
        set cloudService.active = 1
        set cloudService.contactEmail = body.%Get("T&T_Contact_Email", ,"string")
        set cloudService.serviceType = "TrackingService"
        set cloudService.apiUsername = body.%Get("T&T_API_Username", ,"string")
        set cloudService.apiPassword = encryptedTntAPIPassword
        set cloudService.versionNumber = body.%Get("T&T_Version_Number", ,"string")
        set cloudService.validTo = $ZDATEH(map("ExpirationDate"), 1)
        set st = cloudService.%Save()

        if $$$ISOK(st) {
            tcommit
            do ..%SetStatusCode("201")
            do cloudService.%JSONExportToString(.objRes)
            return objRes
        }
        else {
            trollback 1
            if $SYSTEM.Status.GetErrorCodes(st) = "5808" {
                do ..%SetStatusCode("400")
                return {"Status": "Error", 
                        "Message": ("Failed to save object CloudService as given UID already exists ")}    
            }
            elseif $SYSTEM.Status.GetErrorCodes(st) = "5659" {
                do ..%SetStatusCode("400")
                return {"Status": "Error", 
                        "Message": ("Failed to save object CloudService, bad JSON body in request")}    
            } 
            elseif $SYSTEM.Status.GetErrorCodes(st) = "8612" {
                do ..%SetStatusCode("500")
                return {"Status": "Error", 
                        "Message": ("Failed to save object CloudService, Supply Chain application not licensed.")}    
            }
            else {
                do ..%SetStatusCode("500")
                return {"Status": "Error", 
                        "Message": ("Failed to save object CloudService due to: "
                        _$System.Status.GetErrorText(st))}     
            }       
        }
    }
    catch e {
        trollback 1
        do ..%SetStatusCode("500")
        return {"Status": "Error",
                "Message": ("Server error: "_e.DisplayString())}
    }
}

ClassMethod validateInputForTnTRegistratonHelper(body As %DynamicObject, message As %String) As %Status
{
    set missing = ""
    set tntAPIPassword = body.%Get("T&T_API_Password")
    if ($LENGTH(tntAPIPassword) = 0) {
        set missing = missing _" T&T_API_Password"
    }
    set url = body.%Get("T&T_Macropoint_URL")
    if ($LENGTH(url) = 0) {
        set missing = missing _" T&T_Macropoint_URL"
    }
    set contactEmail = body.%Get("T&T_Contact_Email")
    if ($LENGTH(contactEmail) = 0) {
        set missing = missing _" T&T_Contact_Email"
    }
    set apiUsername = body.%Get("T&T_API_Username")
    if ($LENGTH(apiUsername) = 0) {
        set missing = missing _" T&T_API_Username"
    }
    set versionNumber = body.%Get("T&T_Version_Number")
    if ($LENGTH(versionNumber) = 0) {
        set missing = missing _" T&T_Version_Number"
    }
    set irisKey = body.%Get("IRIS_Key_Digest")
    if ($LENGTH(irisKey) = 0) {
        set missing = missing _" IRIS_Key_Digest"
    }


    set ret = $$$OK

    if ($LENGTH(missing) '= 0) {
        set ret = $$$ERROR($$$GeneralError,"Bad Request")
        set message = "The following properties are missing:"_missing
    }

    return ret
}

}
