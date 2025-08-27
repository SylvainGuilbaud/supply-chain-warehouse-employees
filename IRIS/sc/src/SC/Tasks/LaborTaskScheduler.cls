Class SC.Tasks.LaborTaskScheduler Extends %RegisteredObject
{

ClassMethod createLaborTask(namespace As %String) As %Status
{
        &sql(SELECT ID INTO :taskId FROM %SYS.Task WHERE NameSpace=:namespace AND Name=:namespace_'_LaborMasterTask')
        // this is run at installation, just simply write the error to STDOUT for debugging.
        IF SQLCODE<0 {WRITE "SQLCODE error ",SQLCODE," ",%msg  QUIT}
        
        IF SQLCODE=100 {set task = ##class(%SYS.Task).%New()}
        ELSE {set task = ##class(%SYS.Task).%OpenId(taskId)}
        // Don't update if the user has suspended the SCDailyTask
        if (task.Suspended '= 2) {

                // Run The SC Daily tast once a day at midnight
                WRITE "Reset LaborMasterTask"
                set task.Name = namespace_"_LaborMasterTask"
                set task.DailyFrequency = 0
                set task.Description = "Daily rebuild of cubes for SC"
                set task.NameSpace = namespace
                set task.RunAsUser = "_SYSTEM"
                set task.TaskClass = "SC.Tasks.LaborMasterTask"
                set task.TimePeriod = 0
                set task.TimePeriodEvery = 1
                set task.DailyStartTime = 0 // midnight
                return task.%Save()
        }
        write "Warning: LaborDeficit Task suspended"
        return $$$OK
}

ClassMethod initialRun() As %Status
{
        return ##class(SC.Tasks.LaborMasterTask).%New().OnTask()
}

}
