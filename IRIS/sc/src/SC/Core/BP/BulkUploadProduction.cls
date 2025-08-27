Class SC.Core.BP.BulkUploadProduction Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="SC.Core.BP.BulkUploadProduction" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="Bulk Upload Process Job" Category="" ClassName="SC.Core.BP.Process.ProcessJob" PoolSize="2" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
  </Item>
  <Item Name="Bulk Upload Queue Uploads" Category="" ClassName="SC.Core.BP.Service.QueueUploads" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="CallInterval">30</Setting>
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
  </Item>
  <!-- <Item Name="Bulk Upload Save File" Category="" ClassName="SC.Core.BP.Operation.FileTransfer" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
  </Item>
  <Item Name="Bulk Upload Cloud Service Download" Category="" ClassName="SC.Core.BP.Service.CloudDownload" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
  </Item> -->
  <!-- <Item Name="Bulk Upload FTP Download" Category="" ClassName="SC.Core.BP.Service.FTPDownload" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
  </Item> -->
  <!-- <Item Name="Bulk Upload Cloud Service Upload" Category="" ClassName="EnsLib.CloudStorage.BusinessOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="ProviderCredentialsFile"></Setting>
    <Setting Target="Host" Name="BucketName"></Setting>
    <Setting Target="Adapter" Name="StorageProvider">0</Setting>
    <Setting Target="Adapter" Name="StorageRegion"></Setting>
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
  </Item> -->
  <!-- <Item Name="Bulk Upload FTP Upload" Category="" ClassName="EnsLib.FTP.PassthroughOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Credentials"></Setting>
    <Setting Target="Adapter" Name="FilePath"></Setting>
    <Setting Target="Host" Name="Filename"></Setting>
    <Setting Target="Adapter" Name="FTPServer"></Setting>
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
  </Item> -->
  <!-- <Item Name="Bulk Upload Cloud Upload Helper" Category="" ClassName="SC.Core.BP.Service.CloudUpload" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
  </Item> -->
  <!-- <Item Name="Bulk Upload FTP Upload Helper" Category="" ClassName="SC.Core.BP.Service.FTPUpload" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="FileName"></Setting>
    <Setting Target="Adapter" Name="CallInterval">120</Setting>
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
  </Item> -->
</Production>
}

}
