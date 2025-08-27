/*
Copyright (c) 2023-2024 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Tasks.DailyTask Extends %SYS.Task.Definition
{

Parameter TaskName = "SCDailyTask";

Method OnTask() As %Status
{
        set st = ##class(SC.Core.Tasks.BuildCubes).%New().OnTask()
        if $$$ISERR(st) Quit st
        set st = ##class(SC.Core.Tasks.ExpiredServicesStatusChange).%New().OnTask()
        if $$$ISERR(st) Quit st
        set st = ##class(SC.Core.Tasks.DeleteOldUploadData).%New()
        set st.ArchiveDirectory = ##class(%SYS.System).TempDirectory()_"/"_"complete"
        set st = st.OnTask()
        if $$$ISERR(st) Quit st
        set st = ##class(SC.Core.Tasks.DeleteOldUploadData).%New()
        set st.ArchiveDirectory = ##class(%SYS.System).TempDirectory()_"/"_"failed"
        set st = st.OnTask()
        if $$$ISERR(st) Quit st

        return $$$OK
}

}
