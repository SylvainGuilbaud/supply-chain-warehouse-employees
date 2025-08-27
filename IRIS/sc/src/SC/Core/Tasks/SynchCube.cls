/*
Copyright (c) 2022-2023 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Tasks.SynchCube Extends %SYS.Task.Definition
{

Parameter TaskName = "SynchOrderShipmentCube";

Method OnTask() As %Status
{
    set st0 = ##class(%DeepSee.Utils).%SynchronizeCube("SalesOrderCube",1,,,,,.tStats)
    set st1 = ##class(%DeepSee.Utils).%SynchronizeCube("SalesOrderLineCube",1,,,,,.tStats)
    set st2 = ##class(%DeepSee.Utils).%SynchronizeCube("SalesShipmentCube",1,,,,,.tStats)
    set st3 = ##class(%DeepSee.Utils).%SynchronizeCube("SupplyShipmentCube",1,,,,,.tStats)
    set st4 = ##class(%DeepSee.Utils).%SynchronizeCube("ProductInventoryCube",1,,,,,.tStats)
    set st5 = ##class(%DeepSee.Utils).%SynchronizeCube("ConsolidatedInventoryCube",1,,,,,.tStats)
    set st6 = ##class(%DeepSee.Utils).%SynchronizeCube("LaborDeficitCube",1,,,,,.tStats)

    if $$$ISERR(st0) Quit st0
    if $$$ISERR(st1) Quit st1
    if $$$ISERR(st2) Quit st2
    if $$$ISERR(st3) Quit st3
    if $$$ISERR(st4) Quit st4
    if $$$ISERR(st5) Quit st5
    if $$$ISERR(st6) Quit st6
    return $$$OK
}

}
