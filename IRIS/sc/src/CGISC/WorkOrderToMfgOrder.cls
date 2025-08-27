Class CGISC.WorkOrderToMfgOrder Extends Ens.DataTransformDTL [ DependsOn = (CGISC.Requests.WorkOrderRequest, SC.Data.MfgOrder) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='CGISC.Requests.WorkOrderRequest' targetClass='SC.Data.MfgOrder' create='new' language='objectscript' >
<assign value='source.OrderId' property='target.uid' action='set' />
<if condition='$FIND("Storage,Pick,Prepare",source.TaskType) &apos;= 0' >
<true>
<assign value='"laborproduct-03"' property='target.productId' action='set' />
</true>
<false>
<if condition='$FIND("Receive,Load",source.TaskType) &apos;= 0' >
<true>
<assign value='"laborproduct-01"' property='target.productId' action='set' />
</true>
<false>
<assign value='"laborproduct-02"' property='target.productId' action='set' />
</false>
</if>
</false>
</if>
<assign value='source.Warehouse' property='target.workLocationId' action='set' />
<assign value='source.TaskType' property='target.workDescription' action='set' />
<assign value='source.EmployeeId' property='target.notes' action='set' />
<assign value='source.TaskTime' property='target.quantity' action='set' />
<assign value='"seconds"' property='target.unitOfMeasure' action='set' />
<assign value='source.TimePlaced' property='target.plannedStartDate' action='set' />
<assign value='source.TimePickedUp' property='target.actualStartDate' action='set' />
<assign value='source.TimeDone' property='target.actualEndDate' action='set' />
</transform>
}

}
