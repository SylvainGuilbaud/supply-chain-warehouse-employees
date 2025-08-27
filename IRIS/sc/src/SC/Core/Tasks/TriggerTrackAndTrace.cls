/*
Copyright (c) 2024 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Tasks.TriggerTrackAndTrace Extends %SYS.Task.Definition
{

Parameter TaskName = "TriggerTrackAndTrace";

Method OnTask() As %Status
{
    set myquery = "select * from sc_core_data_internal.cloudservice where serviceType = 'TrackingService' and active = 1"
    set tStatement = ##class(%SQL.Statement).%New()
    set qStatus = tStatement.%Prepare(myquery)
    if qStatus'= 1 {write "%Prepare failed:" do $System.Status.DisplayError(qStatus) Quit:qStatus}
    set rset = tStatement.%Execute()
    if rset.%SQLCODE < 0 return $$$ERROR($$$SQLCode,rset.SQLCODE,rset.%Message)
    set retValue = $$$OK
    while rset.%Next()
    {
        if (##class(utils.LicenseCheck).IsAppLicensed() && 
        ##class(utils.LicenseCheck).CheckSupplyChainLicense() && 
        ##class(utils.LicenseCheck).CheckServiceLicense(rset.name)
        ){
            set appName = rset.name
            if rset.name = "T&T_MacroPoint" {
                set appName = "MacroPoint"
            }


            set parser = ##class(%Net.URLParser).%New()
            set httpsFound = $FIND($ZCONVERT(rset.url, "L"), "https")
            do parser.Decompose(rset.url, .components)
            set request = ##class(%Net.HttpRequest).%New()
            set request.Server = components("host")
            set request.Port = components("port")
            set request.Username = rset.apiUsername
            if (httpsFound) {
                set request.Https = 1
                set request.SSLConfiguration = "ISC.FeatureTracker.SSL.Config"
            }
            set text=$SYSTEM.Encryption.Base64Decode(rset.apiPassword)
            set text=$SYSTEM.Encryption.AESCBCManagedKeyDecrypt(text)
            set apiPassword=$ZCONVERT(text,"I","UTF8")
            set request.Password = apiPassword
            set retValue = request.Get("/createTrackingRequests")
        }
    }
    return retValue
}

}
