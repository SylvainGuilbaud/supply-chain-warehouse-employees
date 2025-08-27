Class SC.Core.BP.Service.FTPDownload Extends Ens.BusinessService
{

Parameter ADAPTER = "EnsLib.FTP.InboundAdapter";

Parameter SETTINGS = "TargetConfigNames, DownloadName";

Property DownloadName As %String;

Property TargetConfigNames As Ens.DataType.ConfigName;

Method OnProcessInput(pInput As %Stream.Object, pOutput As %RegisteredObject) As %Status
{
    set sc = $$$OK

    set sql = "UPDATE SC_Core_Data_Internal.BulkUploadFiles (status) VALUES ('open') WHERE uidDetails = 'GetFTPFileStatus'"

    set tStatement = ##class(%SQL.Statement).%New()
    set qStatus = tStatement.%Prepare(sql)
    if qStatus'=1 {
        return qStatus
    }
    set rset = tStatement.%Execute()
    if rset.%SQLCODE<0{
        set sc = $$$ERROR($$$SQLCode,rset.SQLCODE,rset.%Message)
        return sc
    }
    
    Try{

        set sc = ##class(%File).Rename(pInput.Filename, ..DownloadName)
        throw:$$$ISERR(sc) ##class(%Exception.StatusException).CreateFromStatus(sc)

        set sql = "INSERT OR UPDATE SC_Core_Data_Internal.BulkUploadFiles (uidDetails, status) "_
                "VALUES ('"_$PIECE(..DownloadName, ".", 1)_"-download', 'success')"


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
    Catch ex{
        set sc = ex.AsStatus()
        set sql = "INSERT OR UPDATE SC_Core_Data_Internal.BulkUploadFiles (uidDetails, status) "_
                "VALUES ('"_$PIECE(..DownloadName, ".", 1)_"-download', 'failed')"


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
    set exists = ##class(Ens.Config.Item).NameExists(prodName, "Bulk Upload FTP Download", .itemId)
    if exists '= 1{
        return $$$ERROR($$$GeneralError,"Item does not exists")

    }
    set item =  ##class(Ens.Config.Item).%OpenId(itemId)
    do item.EnabledSet(0)
    do item.Settings.Clear()
    set sc = item.%Save()

    Quit sc
}

}
