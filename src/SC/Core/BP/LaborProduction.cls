Class SC.Core.BP.LaborProduction Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="SC.Core.BP.LaborProduction" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="SC.Core.BP.Service.SingleIssueBS" Category="" ClassName="SC.Core.BP.Service.SingleIssueBS" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="UnderstaffingProcess" Category="" ClassName="SC.Core.BP.Process.UnderstaffingProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Workflow Operation" Category="" ClassName="EnsLib.Background.Workflow.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="ForecastCSVImportWHS1" Category="" ClassName="CGISC.Services.ForecastCSVImportWHS1" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="DeleteFromServer">0</Setting>
    <Setting Target="Adapter" Name="FileAccessTimeout">5</Setting>
    <Setting Target="Adapter" Name="SemaphoreSpec">*.csv=*.ok</Setting>
  </Item>
  <Item Name="ForecastCSVImportWHS2" Category="" ClassName="CGISC.Services.ForecastCSVImportWHS2" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="DeleteFromServer">0</Setting>
    <Setting Target="Adapter" Name="FileAccessTimeout">5</Setting>
    <Setting Target="Adapter" Name="SemaphoreSpec">*.csv=*.ok</Setting>
  </Item>
  <Item Name="CreateDemandPlan" Category="" ClassName="CGISC.Processes.CreateDemandPlan" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="CreateSupplyPlan" Category="" ClassName="CGISC.Processes.CreatesupplyPlan" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="WorkOrderSQLImportWHS1" Category="" ClassName="CGISC.Services.WorkOrderSQLServiceWHS1" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="DSN">WHS1DNS</Setting>
    <Setting Target="Adapter" Name="DeleteQuery">UPDATE CGIFTE_Persistent.WorkOrder SET Changed = 0 WHERE ID = ?</Setting>
    <Setting Target="Adapter" Name="Query">SELECT ID,
    OrderId, 
    TaskType, 
    TaskTime, 
    TimePlaced, 
    TimePickedUp, 
    TimeDone, 
    EmployeeId, 
    Done, 
    Changed
FROM 
    CGIFTE_Persistent.WorkOrder
WHERE 
    Changed = 1</Setting>
    <Setting Target="Adapter" Name="JGService">JG</Setting>
  </Item>
  <Item Name="WorkOrderSQLImportWHS2" Category="" ClassName="CGISC.Services.WorkOrderSQLServiceWHS2" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="DSN">WHS2DNS</Setting>
    <Setting Target="Adapter" Name="DeleteQuery">UPDATE CGIFTE_Persistent.WorkOrder SET Changed = 0 WHERE ID = ?</Setting>
    <Setting Target="Adapter" Name="Query">SELECT ID,
    OrderId, 
    TaskType, 
    TaskTime, 
    TimePlaced, 
    TimePickedUp, 
    TimeDone, 
    EmployeeId, 
    Done, 
    Changed
FROM 
    CGIFTE_Persistent.WorkOrder
WHERE 
    Changed = 1</Setting>
    <Setting Target="Adapter" Name="JGService">JG</Setting>
  </Item>
  <Item Name="CreateMfgOrder" Category="" ClassName="CGISC.Processes.CreateMfgOrder" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="ProductAPI" Category="" ClassName="CGISC.Services.ProductImport" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="DSN">WHS1DNS</Setting>
    <Setting Target="Adapter" Name="DeleteQuery">UPDATE CGIFTE_Persistent.Products SET Changed = 0 WHERE ID = ?</Setting>
    <Setting Target="Adapter" Name="Query">SELECT * FROM CGIFTE_Persistent.Products WHERE Changed = 1</Setting>
    <Setting Target="Adapter" Name="JGService">JG</Setting>
  </Item>
  <Item Name="SalesImportWHS1" Category="" ClassName="CGIFTE.Services.SalesImportWHS1" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="DSN">WHS1DNS</Setting>
    <Setting Target="Adapter" Name="DeleteQuery">UPDATE CGIFTE_Persistent.SalesData SET Processed = 0 WHERE ID = ?</Setting>
    <Setting Target="Adapter" Name="Query">SELECT * FROM CGIFTE_Persistent.SalesData WHERE Processed = 1</Setting>
    <Setting Target="Adapter" Name="JGService">JG</Setting>
  </Item>
  <Item Name="SalesImportWHS1" Category="" ClassName="CGIFTE.Services.SalesImportWHS2" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="DSN">WHS2DNS</Setting>
    <Setting Target="Adapter" Name="DeleteQuery">UPDATE CGIFTE_Persistent.SalesData SET Processed = 0 WHERE ID = ?</Setting>
    <Setting Target="Adapter" Name="Query">SELECT * FROM CGIFTE_Persistent.SalesData WHERE Processed = 1</Setting>
    <Setting Target="Adapter" Name="JGService">JG</Setting>
  </Item>
  <Item Name="Bulk Upload Queue Uploads" Category="" ClassName="SC.Core.BP.Service.QueueUploads" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Bulk Upload Process Job" Category="" ClassName="SC.Core.BP.Process.ProcessJob" PoolSize="2" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="JG" Category="" ClassName="EnsLib.JavaGateway.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
