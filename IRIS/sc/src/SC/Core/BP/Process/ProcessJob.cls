Class SC.Core.BP.Process.ProcessJob Extends Ens.BusinessProcess
{

/// Initiate a bulk upload of a given file
Method OnRequest(request As SC.Core.BP.Message.SendUploadId, Output response As %Library.Persistent) As %Status
{
        set tStatus = $$$OK

        try{
            // extract relevant fields
            set uploadId = request.UploadId
            set sql = "SELECT attributeList, dateTimeList, defaultTimezone, defaultValueList, "_
                      "delimiter, delimiterList, fileAddr, fileType, formatList, hasHeaderRow, "_
                      "idList, indexList, mappingType, mappingTypeList, receivedTime, tableName, "_
                      "transformationList, uid, uidAutoGeneration, uploadType "_
                      "FROM SC_Core_Data_Internal.BulkUploadDetails WHERE uid = '"_uploadId_"'"


            set tStatement = ##class(%SQL.Statement).%New()

            set tStatus = tStatement.%Prepare(sql)
            throw:$$$ISERR(tStatus) ##class(%Exception.StatusException).CreateFromStatus(tStatus)

            set rset = tStatement.%Execute()
            if rset.%SQLCODE<0{
                set tStatus = $$$ERROR($$$SQLCode,rset.SQLCODE,rset.%Message)
                throw:$$$ISERR(tStatus) ##class(%Exception.StatusException).CreateFromStatus(tStatus)
            }
            do rset.%Next()

            if rset.%Get("uploadType") = ""{
                do ##Class(SC.Core.API.Data.BulkUploadApiImpl).SaveFailedEntry(uploadId, , "Upload id not found "_uploadId)
                return $SYSTEM.Status.Error($$$GeneralError,"Upload id not found")
            }
            // Load the data
            $$$ThrowOnError(##Class(SC.Core.BP.Process.ProcessJobHelper).LoadData(rset.%Get("fileType"), rset.%Get("tableName"), rset.%Get("uploadType"), rset.%Get("mappingType"), rset.%Get("attributeList"), rset.%Get("idList"), rset.%Get("fileAddr"), rset.%Get("uid"), rset.%Get("formatList"), rset.%Get("dateTimeList"), rset.%Get("receivedTime"), rset.%Get("defaultTimezone"), rset.%Get("delimiter"), rset.%Get("hasHeaderRow"), rset.%Get("mappingTypeList"), rset.%Get("defaultValueList"), rset.%Get("delimiterList"), rset.%Get("transformationList"), rset.%Get("indexList"), rset.%Get("uidAutoGeneration")))
            set sql = "DELETE FROM SC_Core_Data_Internal.BulkUploadDetails WHERE uid = '"_uploadId_"'"

            set tStatement = ##class(%SQL.Statement).%New()

            set tStatus = tStatement.%Prepare(sql)
            throw:$$$ISERR(tStatus) ##class(%Exception.StatusException).CreateFromStatus(tStatus)


            set rset = tStatement.%Execute()
            if rset.%SQLCODE<0{
                set tStatus = $$$ERROR($$$SQLCode,rset.SQLCODE,rset.%Message)
                throw:$$$ISERR(tStatus) ##class(%Exception.StatusException).CreateFromStatus(tStatus)

            }
            
        }
        catch ex{
            do ##Class(SC.Core.API.Data.BulkUploadApiImpl).SaveFailedEntry(uploadId, , "An exception occured after data was updated")
        }
        return tStatus
}

/// Handle a 'Response'
Method OnResponse(request As Ens.Request, ByRef response As Ens.Response, callrequest As Ens.Request, callresponse As Ens.Response) As %Status
{
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
