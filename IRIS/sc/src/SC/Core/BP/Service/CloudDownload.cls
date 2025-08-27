Class SC.Core.BP.Service.CloudDownload Extends Ens.BusinessService
{

/// ADAPTER for inbound connection
Parameter ADAPTER = "EnsLib.CloudStorage.InboundAdapter";

/// Settings
Parameter SETTINGS = "TargetConfigNames,OutputFilename";

Property TargetConfigNames As Ens.DataType.ConfigName;

Property OutputFilename As %String;

Method OnProcessInput(pInput As EnsLib.CloudStorage.InboundInput, Output pOutput As %RegisteredObject) As %Status
{
        Set sc = $$$OK
        set sc = ##class(Ens.Director).GetProductionStatus(.prodName, .prodState)
        set prodState = 0
        while prodState = $$$eProductionStateUnknown{
            set sc = ##class(Ens.Director).GetProductionStatus(.prodName, .prodState)
            if (prodState = $$$eProductionStateStopped) || (prodState = $$$eProductionStateSuspended){
                return $$$ERROR($$$GeneralError,"No active production is found")
            }
        }

        set exists = ##class(Ens.Config.Item).NameExists(prodName, "Bulk Upload Cloud Service Download", .itemId)
        if exists '= 1{
            return $$$ERROR($$$GeneralError,"Item does not exists")

        }
        set item =  ##class(Ens.Config.Item).%OpenId(itemId)

        do item.EnabledSet(0)
        do item.Settings.Clear()
        set sc = item.%Save()
        
        Try{
            set tStream = ##class(Ens.StreamContainer).%New()

            set fileName = ##class(SC.Core.Util.BulkUploadProductionUtil).GetBasename(pInput.Name)

            set tStream.OutputFilename = ..OutputFilename
            set sc = tStream.StreamSet(pInput.Content)
            throw:$$$ISERR(sc) ##class(%Exception.StatusException).CreateFromStatus(sc)

            set sc = ..SendRequestSync(..TargetConfigNames, tStream)
            throw:$$$ISERR(sc) ##class(%Exception.StatusException).CreateFromStatus(sc)

            $$$LOGINFO("Retreived and dispatched "_pInput.Name)
        }
        Catch ex{
            set sc = ex.AsStatus()
            set sql = "INSERT OR UPDATE SC_Core_Data_Internal.BulkUploadFiles (uidDetails, status) "_
                       "VALUES ('"_$PIECE(..OutputFilename, ".", 1)_"-download', 'failed')"
    
    
            set tStatement = ##class(%SQL.Statement).%New()
            set qStatus = tStatement.%Prepare(sql)
            if qStatus'=1 {
                set sc = qStatus
            }
            set rset = tStatement.%Execute()
            if rset.%SQLCODE<0{
                set sc = rset
            }
        }


        Return sc
}

}
