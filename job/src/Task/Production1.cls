Class Task.Production1 Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="Task.Production1" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>30</ActorPoolSize>
  <Setting Target="Adapter" Name="AlertNotificationManager">Ens.Alerting.NotificationManager</Setting>
  <Setting Target="Adapter" Name="AlertNotificationOperation">Task.Operation.DefaultAlert</Setting>
  <Setting Target="Adapter" Name="AlertNotificationRecipients">test@localhost.localdomain</Setting>
  <Item Name="GeneralWS" Category="" ClassName="Task.Operation.GeneralWS" PoolSize="5" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="AlertGroups">TaskGroup</Setting>
    <Setting Target="Host" Name="AlertOnError">0</Setting>
    <Setting Target="Adapter" Name="WebServiceClientClass">WSClient.MainSoap</Setting>
    <Setting Target="Adapter" Name="WebServiceURL">http://localhost:52773/csp/task/Task.WS.Main.cls</Setting>
    <Setting Target="Adapter" Name="SOAPCredentials">default</Setting>
    <Setting Target="Host" Name="ReplyCodeActions"></Setting>
  </Item>
  <Item Name="Initiator" Category="" ClassName="Task.Service.Initiator" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="CallTask" Category="" ClassName="Task.Process.CallTask" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Ens.Alert" Category="" ClassName="Ens.Alerting.AlertManager" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="CreateManagedAlertRule">Task.Rule.ManagedAlert</Setting>
    <Setting Target="Host" Name="AlertGroups"></Setting>
  </Item>
  <Item Name="Ens.Alerting.NotificationManager" Category="" ClassName="Ens.Alerting.NotificationManager" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="NotificationTransform">Task.Transform.NotifyManager</Setting>
  </Item>
  <Item Name="Operator" Category="" ClassName="EnsLib.Workflow.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="AutoCreateRole">1</Setting>
    <Setting Target="Host" Name="AlertOnError">1</Setting>
  </Item>
  <Item Name="Task.Operation.DefaultAlert" Category="" ClassName="Task.Operation.DefaultAlert" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="TaskCompleteWS" Category="" ClassName="Task.Service.TaskComplete" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="EnableStandardRequests">1</Setting>
  </Item>
  <Item Name="Job1" Category="job" ClassName="Task.Process.Job1" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Job2a" Category="job" ClassName="Task.Process.Job2a" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Job2b" Category="" ClassName="Task.Process.Job2b" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Job2" Category="" ClassName="Task.Process.Job2" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Job3" Category="" ClassName="Task.Process.Job3" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Target1" Category="" ClassName="Task.Operation.GeneralRest" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="Credentials">default</Setting>
    <Setting Target="Adapter" Name="HTTPPort">52773</Setting>
    <Setting Target="Adapter" Name="HTTPServer">task</Setting>
    <Setting Target="Adapter" Name="URL">/csp/task/api/RunTask</Setting>
    <Setting Target="Host" Name="AlertOnError">1</Setting>
    <Setting Target="Host" Name="AlertGroups">TaskGroup</Setting>
  </Item>
  <Item Name="TaskComplete" Category="" ClassName="Task.Service.TaskCompleteRest" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Target2" Category="" ClassName="Task.Operation.GeneralRest" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="Credentials">default</Setting>
    <Setting Target="Adapter" Name="HTTPPort">52773</Setting>
    <Setting Target="Adapter" Name="HTTPServer">task2</Setting>
    <Setting Target="Adapter" Name="URL">/csp/task/api/RunTask</Setting>
    <Setting Target="Adapter" Name="RegistryID"></Setting>
    <Setting Target="Host" Name="AlertOnError">1</Setting>
    <Setting Target="Host" Name="AlertGroups">TaskGroup</Setting>
  </Item>
  <Item Name="Test.Service.Call" Category="" ClassName="Test.Service.Call" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="FileWatcher" Category="" ClassName="Task.Service.FileWatcher" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/home/irisowner/filewatcher/in/</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.txt</Setting>
    <Setting Target="Adapter" Name="ArchivePath">/home/irisowner/filewatcher/arc/</Setting>
  </Item>
  <Item Name="EnsLib.File.PassthroughService" Category="" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">File</Setting>
    <Setting Target="Adapter" Name="ArchivePath">/home/irisowner/filewatcher/arc/</Setting>
    <Setting Target="Adapter" Name="FilePath">/home/irisowner/filewatcher/in/</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.txt</Setting>
  </Item>
  <Item Name="EnsLib.FTP.PassthroughOperation" Category="" ClassName="EnsLib.FTP.PassthroughOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="Credentials">centos7</Setting>
    <Setting Target="Adapter" Name="FTPServer">172.18.100.240</Setting>
    <Setting Target="Adapter" Name="FTPPort"></Setting>
    <Setting Target="Adapter" Name="Protocol">SFTP</Setting>
    <Setting Target="Adapter" Name="FilePath">/root</Setting>
    <Setting Target="Host" Name="AlertOnError">1</Setting>
    <Setting Target="Host" Name="AlertGroups">FileGroup</Setting>
  </Item>
  <Item Name="File" Category="" ClassName="Task.Process.File" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="EnsLib.EMail.AlertOperation" Category="" ClassName="EnsLib.EMail.AlertOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Timer" Category="" ClassName="Task.Service.Timer" PoolSize="1" Enabled="false" Foreground="false" Comment="定期的な時間間隔で起動するサービス" LogTraceEvents="false" Schedule="@test">
  </Item>
  <Item Name="Job4" Category="" ClassName="Task.Process.Job4" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
