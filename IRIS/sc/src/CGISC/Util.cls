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

ClassMethod FullReset() As %Status
{
    set sc1 = ##class(CGISC.Util).Reset()
    zn "WHS1"
    set sc2 = ##class(CGIFTE.Util).Reset()
    zn "WHS2" 
    set sc3 = ##class(CGIFTE.Util).Reset()
    zn "SC"
    return $$$OK
}

}
