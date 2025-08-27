Class SC.Core.Tasks.LaborDeficitTask Extends %SYS.Task.Definition
{

Parameter TaskName = "LaborDeficit";

Method OnTask() As %Status
{
    set st = ##class(SC.Data.Issue).%DeleteExtent()
    if $$$ISERR(st) return st
    set st = ##class(SC.Core.Data.Internal.LaborDeficit).populateDeficit()
    if $$$ISERR(st) return st
    set st = ##class(%DeepSee.Utils).%BuildCube("LaborDeficitCube",1,,,,,.tStats)
    if $$$ISERR(st) return st
    set kpiDef = ##class(SC.Core.API.KPI.KpiApiImpl).GetKpiDefinitionByName("Understaffing")
    set st = ##class(SC.Core.Util.KpiIssueUtil).updateIssuesForKpi(kpiDef, .totalCount, .newCount, .existCount, .closedCount)
    if $$$ISERR(st) return st
    set kpiDef = ##class(SC.Core.API.KPI.KpiApiImpl).GetKpiDefinitionByName("Overstaffing")
    set st = ##class(SC.Core.Util.KpiIssueUtil).updateIssuesForKpi(kpiDef, .totalCount, .newCount, .existCount, .closedCount)
    if $$$ISERR(st) return st
    return $$$OK
}

}
