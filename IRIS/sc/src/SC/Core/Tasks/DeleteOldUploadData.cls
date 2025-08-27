/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Tasks.DeleteOldUploadData Extends %SYS.Task.Definition
{

Parameter TaskName = "DeleteOldUploadData";

Property ArchiveDirectory As %String;

Property DaysToSave As %Integer [ InitialExpression = 30 ];

Method OnTask() As %Status
{
    Set status = ..PurgeFolder(..ArchiveDirectory, ..DaysToSave)
    Set status = ..DeleteOldErrors(..DaysToSave)
    Quit status
}

ClassMethod DeleteOldErrors(DaysToKeep As %Integer)
{
    set status = $$$OK
    set beforeDate = $ZDATETIME($ZTIMESTAMP-DaysToKeep_",0",3)
    set sql = "DELETE FROM SC_Core_Data_Internal.BulkUploadErrors WHERE lastUpdatedTime < '"_beforeDate_"'"
    set tStatement = ##class(%SQL.Statement).%New()
    set qStatus = tStatement.%Prepare(sql)
    if qStatus'=1 {
        return qStatus
    }
    
    set rset = tStatement.%Execute()
    if rset.%SQLCODE<0{
        return $$$ERROR($$$SQLCode,rset.SQLCODE,rset.%Message)
    }
    return status
}

ClassMethod PurgeFolder(ArchiveDirectory As %String, DaysToKeep As %Integer)
{
    set beforeDate = $ZDATETIME($ZTIMESTAMP-DaysToKeep_",0",3)

    set files = ##class(%File).FileSetFunc(ArchiveDirectory, , , 1)


    while files.%Next() {
        set path = files.%Get("Name")
        set file = ##class(SC.Core.Util.BulkUploadProductionUtil).GetBasename(path)
        set suffix = $PIECE(file, ".", *)
        set file = $REPLACE(file, "."_suffix, "")

        set datePart = $PIECE(file, "-", 2) 
        set fileDate = $REPLACE(datePart, "_", "-", , 2)
        set fileDate = $REPLACE(fileDate, "_", " ", , 1)
        set fileDate = $REPLACE(fileDate, "_", ":", , 2)
        set fileDate = $REPLACE(fileDate, "_", ".")


        if $ZDATEH(fileDate, 8) < $ZDATEH(beforeDate, 8){
            set path = ##class(%File).NormalizeFilename(path)
            do ##class(%SYS.System).WriteToConsoleLog("Deleted file "_path, 1)
            set status = ##class(%File).Delete(path)
        }
    }

    return $$$OK
}

}
