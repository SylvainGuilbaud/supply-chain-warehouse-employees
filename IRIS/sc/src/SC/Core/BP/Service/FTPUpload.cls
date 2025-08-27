Class SC.Core.BP.Service.FTPUpload Extends Ens.BusinessService
{

Parameter ADAPTER = "Ens.InboundAdapter";

Parameter SETTINGS = "FileName";

Property FileName As %String;

Method OnProcessInput(pInput As Ens.InboundAdapter, Output pOutput As %RegisteredObject) As %Status
{
        Try{

            set stream = ##class(%Stream.FileCharacter).%New()
            set sc = stream.LinkToFile(..FileName)
            throw:$$$ISERR(sc) ##class(%Exception.StatusException).CreateFromStatus(sc)

            set data = ##class(Ens.StreamContainer).%New(stream)
            set data.OriginalFilename = ..FileName
            set sc =  ..SendRequestSync("Bulk Upload FTP Upload", data)
            throw:$$$ISERR(sc) ##class(%Exception.StatusException).CreateFromStatus(sc)
            set status = ##class(%File).Delete(..FileName)
            set baseName = ##class(SC.Core.Util.BulkUploadProductionUtil).GetBasename(..FileName)

            set sql = "INSERT OR UPDATE SC_Core_Data_Internal.BulkUploadFiles (uidDetails, status) "_
                       "VALUES ('"_$PIECE(baseName, ".", 1)_"-upload', 'success')"
    
    
            set tStatement = ##class(%SQL.Statement).%New()
            set qStatus = tStatement.%Prepare(sql)
            if qStatus'=1 {
                set sc = qStatus
            }
            set rset = tStatement.%Execute()
            if rset.%SQLCODE<0{
                set sc = rset
            }

            
        }Catch ex {
            set sc = ex.AsStatus()
            set baseName = ##class(SC.Core.Util.BulkUploadProductionUtil).GetBasename(..FileName)

            set sql = "INSERT OR UPDATE SC_Core_Data_Internal.BulkUploadFiles (uidDetails, status) "_
                       "VALUES ('"_$PIECE(baseName, ".", 1)_"-upload', 'failed')"
    

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
        set sc = ##class(Ens.Director).GetProductionStatus(.prodName, .prodState)
        if prodState '= 1{
            return $$$ERROR($$$GeneralError,"No active production is found")
        }

        set exists = ##class(Ens.Config.Item).NameExists(prodName, "Bulk Upload FTP Upload Helper", .itemId)
        if exists '= 1{
            return $$$ERROR($$$GeneralError,"Item does not exists")

        }
        set helper =  ##class(Ens.Config.Item).%OpenId(itemId)

        do helper.EnabledSet(0)
        do helper.Settings.Clear()
        set stat = helper.%Save()

        if $$$ISERR(stat){
            set sc = stat
        }

        Quit sc
}

}
