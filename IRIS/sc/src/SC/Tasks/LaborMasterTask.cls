Class SC.Tasks.LaborMasterTask Extends %SYS.Task.Definition
{

Parameter TaskName = "LaborMaster";

Method OnTask() As %Status
{
    set st = ##class(SC.Core.Tasks.DemandExpandByBOMTask).%New().OnTask()
    if $$$ISERR(st) return st
    set st = ##class(SC.Core.Tasks.LaborDeficitTask).%New().OnTask()
    if $$$ISERR(st) return st
    return $$$OK
}

}
