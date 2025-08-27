Class CGISC.Util
{

ClassMethod Reset() As %Status
{
    &SQL(DELETE FROM SC_Data.MfgOrder)
    &SQL(DELETE FROM SC_Data.SupplyPlan)
    &SQL(DELETE FROM SC_Data.DemandPlan)
    &SQL(DELETE FROM SC_Core_Data_Internal.LaborHistorical)
    set ^runtask = 0

    return $$$OK
}

}
