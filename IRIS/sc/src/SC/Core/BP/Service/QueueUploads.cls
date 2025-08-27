Class SC.Core.BP.Service.QueueUploads Extends Ens.BusinessService
{

Parameter ADAPTER = "Ens.InboundAdapter";

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
        set tStatus = $$$OK

        try{
            set sql = "SELECT ID, errorMessage, failedRecords, fileName, finishedTime, "_
                    "lastUpdatedTime, receivedTime, recordCreatedTime, recordsCreated, recordsUpdated, "_
                    "startTime, status, targetObject, totalRecords, uid, uploadType, priority "_
                    "FROM SC_Core_Data_Internal.BulkUpload WHERE status = 'received' ORDER BY priority, receivedTime"
            set tStatement = ##class(%SQL.Statement).%New()

            set tStatus = tStatement.%Prepare(sql)
            throw:$$$ISERR(tStatus) ##class(%Exception.StatusException).CreateFromStatus(tStatus)

            set rset = tStatement.%Execute()
            if rset.%SQLCODE<0{
                set tStatus = $$$ERROR($$$SQLCode,rset.SQLCODE,rset.%Message)
                throw:$$$ISERR(tStatus) ##class(%Exception.StatusException).CreateFromStatus(tStatus)

            }

            set sql = "SELECT COUNT(*) As QueueCount FROM SC_Core_data_Internal.BulkUpload WHERE status = 'in progress'"
            set tStatement = ##class(%SQL.Statement).%New()

            set tStatus = tStatement.%Prepare(sql)
            throw:$$$ISERR(tStatus) ##class(%Exception.StatusException).CreateFromStatus(tStatus)

            set rsetCount = tStatement.%Execute()
            if rsetCount.%SQLCODE<0{
                set tStatus = $$$ERROR($$$SQLCode,rsetCount.SQLCODE,rsetCount.%Message)
                throw:$$$ISERR(tStatus) ##class(%Exception.StatusException).CreateFromStatus(tStatus)

            }
            
            Do rsetCount.%Next()
            set queueCount = rsetCount.%Get("QueueCount")
            set prodState = 0
            while prodState = $$$eProductionStateUnknown{
                set sc = ##class(Ens.Director).GetProductionStatus(.prodName, .prodState)
                if (prodState = $$$eProductionStateStopped) || (prodState = $$$eProductionStateSuspended){
                    return $$$ERROR($$$GeneralError,"No active production is found")
                }
            }
            set exists = ##class(Ens.Config.Item).NameExists(prodName, "Bulk Upload Process Job", .itemId)
            if exists '= 1{
                return $$$ERROR($$$GeneralError,"Item does not exists")

            }
            set item =  ##class(Ens.Config.Item).%OpenId(itemId)
            set poolSize = item.PoolSizeGet()
            
            set uidOld = ""
            while queueCount < poolSize{
                do rset.%Next()
                if rset.%SQLCODE < 0{
                    return tStatus
                }
                set uid = rset.%Get("uid")
                if (uid = "") || (uidOld = uid){
                    return tStatus
                }

                set processRequest = ##class(SC.Core.BP.Message.SendUploadId).%New()
                set processRequest.UploadId = uid

                set tStatus =  ..SendRequestAsync("Bulk Upload Process Job", processRequest)

                set queueCount = queueCount + 1
                set uidOld = uid

            }
        }
        catch {
            return tStatus
        }
        return tStatus
}

}
