/*
Copyright (c) 2022-2023 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Tasks.TaskScheduler
{

ClassMethod createDefaultTasks(namespace As %String) As %Status
{
                
    set st = ..createDailyTask(namespace)
    if $$$ISERR(st) $$$ThrowOnError(st)   
    set st = ..createMasterTask(namespace)
    if $$$ISERR(st) $$$ThrowOnError(st)
    return st
}

ClassMethod removeDefaultTasks(namespace As %String) As %Status
{

    &sql(DELETE FROM %SYS.Task WHERE NameSpace=:namespace AND Name='MasterTask')
    IF SQLCODE<0 {$$$ThrowOnError($$$ERROR($$$SQLCode,SQLCODE,$g(%msg)))}
    &sql(DELETE FROM %SYS.Task WHERE NameSpace=:namespace AND Name='SCDailyTask')
    IF SQLCODE<0 {$$$ThrowOnError($$$ERROR($$$SQLCode,SQLCODE,$g(%msg)))}
    return $$$OK
}

ClassMethod createMasterTask(namespace As %String) As %Status
{
        &sql(SELECT ID INTO :taskId FROM %SYS.Task WHERE NameSpace=:namespace AND Name='MasterTask')
        // this is run at installation, just simply write the error to STDOUT for debugging.
        IF SQLCODE<0 {WRITE "SQLCODE error ",SQLCODE," ",%msg  QUIT}
        
        IF SQLCODE=100 {set task = ##class(%SYS.Task).%New()}
        ELSE {set task = ##class(%SYS.Task).%OpenId(taskId)}
        // Don't update if the user has suspended the MasterTask
        if (task.Suspended '= 2) {

                // Run The master task every 1 minutes
                WRITE "Reset MasterTask"
                set task.Name = "MasterTask"
                set task.DailyFrequency = 1
                set task.DailyFrequencyTime = 0
                set task.DailyIncrement = 1
                set task.StartDate = $PIECE($HOROLOG,",",1)
                set task.Description = "Master schedule for SC tasks to run in sequence"
                set task.NameSpace = namespace
                set task.TaskClass = "SC.Tasks.MasterTask"
                set task.TimePeriod = 0
                return task.%Save()
        }
        write "Warning: Master Task suspended"
        return $$$OK
}

ClassMethod createDailyTask(namespace As %String) As %Status
{
        &sql(SELECT ID INTO :taskId FROM %SYS.Task WHERE NameSpace=:namespace AND Name='SCDailyTask')
        // this is run at installation, just simply write the error to STDOUT for debugging.
        IF SQLCODE<0 {WRITE "SQLCODE error ",SQLCODE," ",%msg  QUIT}
        
        IF SQLCODE=100 {set task = ##class(%SYS.Task).%New()}
        ELSE {set task = ##class(%SYS.Task).%OpenId(taskId)}
        // Don't update if the user has suspended the SCDailyTask
        if (task.Suspended '= 2) {

                // Run The SC Daily tast once a day at midnight
                WRITE "Reset SCDailyTask"
                set task.Name = "SCDailyTask"
                set task.DailyFrequency = 0
                set task.Description = "Daily rebuild of cubes for SC"
                set task.NameSpace = namespace
                set task.TaskClass = "SC.Tasks.DailyTask"
                set task.TimePeriod = 0
                set task.TimePeriodEvery = 1
                set task.DailyStartTime = 0 // midnight
                return task.%Save()
        }
        write "Warning: Daily Task suspended"
        return $$$OK
}

ClassMethod initialRunDefaultTasks() As %Status
{
        set st = ##class(SC.Tasks.DailyTask).%New().OnTask()
        if $$$ISERR(st) $$$ThrowOnError(st)
        return st
}

}
