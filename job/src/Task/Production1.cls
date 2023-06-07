Class Task.Production1 Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="Task.Production1" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>5</ActorPoolSize>
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
  <Item Name="Direct" Category="" ClassName="Task.Service.Direct" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="cCallTask" Category="" ClassName="Task.Process.cCallTask" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="cWaitFile" Category="" ClassName="Task.Process.cWaitFile" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="cWaitFolder" Category="" ClassName="Task.Process.cWaitFolder" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
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
  <Item Name="Job2b" Category="job" ClassName="Task.Process.Job2b" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Job2" Category="job" ClassName="Task.Process.Job2" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Job3" Category="job" ClassName="Task.Process.Job3" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Job4" Category="job" ClassName="Task.Process.Job4" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="job5waitfile" Category="job" ClassName="Task.Process.job5waitfile" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="job6waitfolders" Category="job" ClassName="Task.Process.job6waitfolders" PoolSize="0" Enabled="true" Foreground="false" Comment="BP内で指定した全フォルダに何某かのファイル(群)が投入されるまで、処理を保留する。" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Task1_REST" Category="" ClassName="Task.Operation.GeneralRest" PoolSize="2" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="Credentials">default</Setting>
    <Setting Target="Adapter" Name="HTTPPort">52773</Setting>
    <Setting Target="Adapter" Name="HTTPServer">task1</Setting>
    <Setting Target="Adapter" Name="URL">/csp/task/api/RunTask</Setting>
    <Setting Target="Host" Name="AlertOnError">1</Setting>
    <Setting Target="Host" Name="AlertGroups">TaskGroup</Setting>
  </Item>
  <Item Name="TaskComplete" Category="" ClassName="Task.Service.TaskCompleteRest" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Task2_REST" Category="" ClassName="Task.Operation.GeneralRest" PoolSize="2" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="Credentials">default</Setting>
    <Setting Target="Adapter" Name="HTTPPort">52773</Setting>
    <Setting Target="Adapter" Name="HTTPServer">task2</Setting>
    <Setting Target="Adapter" Name="URL">/csp/task/api/RunTask</Setting>
    <Setting Target="Adapter" Name="RegistryID"></Setting>
    <Setting Target="Host" Name="AlertOnError">1</Setting>
    <Setting Target="Host" Name="AlertGroups">TaskGroup</Setting>
  </Item>
  <Item Name="SFTP" Category="" ClassName="EnsLib.FTP.PassthroughOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="Credentials">sftp</Setting>
    <Setting Target="Adapter" Name="FTPServer">sftp</Setting>
    <Setting Target="Adapter" Name="FTPPort"></Setting>
    <Setting Target="Adapter" Name="Protocol">SFTP</Setting>
    <Setting Target="Adapter" Name="FilePath">/upload</Setting>
    <Setting Target="Host" Name="AlertOnError">1</Setting>
    <Setting Target="Host" Name="AlertGroups">FileGroup</Setting>
    <Setting Target="Host" Name="Filename">%f</Setting>
  </Item>
  <Item Name="Task1_SFTP" Category="" ClassName="EnsLib.FTP.PassthroughOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="Credentials">task_sftp</Setting>
    <Setting Target="Adapter" Name="FTPServer">task1</Setting>
    <Setting Target="Adapter" Name="FTPPort"></Setting>
    <Setting Target="Adapter" Name="Protocol">SFTP</Setting>
    <Setting Target="Adapter" Name="FilePath">/irisowner/incoming/in/</Setting>
    <Setting Target="Host" Name="AlertOnError">1</Setting>
    <Setting Target="Host" Name="AlertGroups">FileGroup</Setting>
    <Setting Target="Host" Name="Filename">%f</Setting>
  </Item>
  <Item Name="Task2_SFTP" Category="" ClassName="EnsLib.FTP.PassthroughOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="Credentials">task_sftp</Setting>
    <Setting Target="Adapter" Name="FTPServer">task2</Setting>
    <Setting Target="Adapter" Name="FTPPort"></Setting>
    <Setting Target="Adapter" Name="Protocol">SFTP</Setting>
    <Setting Target="Adapter" Name="FilePath">/irisowner/incoming/in/</Setting>
    <Setting Target="Host" Name="AlertOnError">1</Setting>
    <Setting Target="Host" Name="AlertGroups">FileGroup</Setting>
    <Setting Target="Host" Name="Filename">%f</Setting>
  </Item>
  <Item Name="EnsLib.EMail.AlertOperation" Category="" ClassName="EnsLib.EMail.AlertOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Defer" Category="" ClassName="Task.Operation.Defer" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="WaitForFolders" Category="" ClassName="Task.Service.WaitForFolders" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/home/irisowner/incoming/common</Setting>
    <Setting Target="Adapter" Name="SubdirectoryLevels">1</Setting>
    <Setting Target="Adapter" Name="ArchivePath">/home/irisowner/incoming/common-arc/</Setting>
  </Item>
  <Item Name="WaitForFile" Category="" ClassName="Task.Service.WaitForFile" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Archive" Category="" ClassName="Task.Operation.Archive" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
