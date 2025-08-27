Class SC.Core.BP.Operation.FileTransfer Extends EnsLib.File.PassthroughOperation
{

/// Download the file to the provided filename and update status
Method OnMessage(pRequest As Ens.StreamContainer, Output pResonse As %Persistent) As %Status
{

        Quit:'$IsObject(pRequest.Stream) $$$ERROR($$$EnsErrGeneral, "No stream contained in StreamContainer request")
        Set sc = $$$OK
        Try{
            set file = ##class(%Stream.FileCharacter).%New()
            set filePath = ..Adapter.FilePath
            set file.Filename = pRequest.OutputFilename
            do file.CopyFromAndSave(pRequest.Stream)
            set sql = "INSERT OR UPDATE SC_Core_Data_Internal.BulkUploadFiles (uidDetails, status) "_
                       "VALUES ('"_$PIECE(pRequest.OutputFilename, ".", 1)_"-download', 'success')"
    
    
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
        Catch e{
            Set sc = e.AsStatus()
            set sql = "INSERT OR UPDATE SC_Core_Data_Internal.BulkUploadFiles (uidDetails, status) "_
                       "VALUES ('"_$PIECE(pRequest.OutputFilename, ".", 1)_"-download', 'failed')"
    
    
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
