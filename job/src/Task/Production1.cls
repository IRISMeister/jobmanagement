Class Task.Production1 Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="Task.Production1" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
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
  <Item Name="cCallTask" Category="" ClassName="Task.Process.cCallTask" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="cWaitFile" Category="" ClassName="Task.Process.cWaitFile" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="cWaitFolder" Category="" ClassName="Task.Process.cWaitFolder" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
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
  <Item Name="job01" Category="job" ClassName="Task.Process.job01" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="job02a" Category="job" ClassName="Task.Process.job02a" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="job02b" Category="job" ClassName="Task.Process.job02b" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="job02" Category="job" ClassName="Task.Process.job02" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="job03" Category="job" ClassName="Task.Process.job03" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="job04" Category="job" ClassName="Task.Process.job04" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="job05File" Category="job" ClassName="Task.Process.job05File" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="job06Files" Category="job" ClassName="Task.Process.job06Files" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="job07Folders" Category="job" ClassName="Task.Process.job07Folders" PoolSize="0" Enabled="true" Foreground="false" Comment="BP内で指定した全フォルダに何某かのファイル(群)が投入されるまで、処理を保留する。" LogTraceEvents="false" Schedule="">
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
    <Setting Target="Adapter" Name="FileSpec">*.sem</Setting>
  </Item>
  <Item Name="WaitForFile" Category="" ClassName="Task.Service.WaitForFile" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/home/sftp_user1/incoming/in/</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.txt</Setting>
    <Setting Target="Host" Name="CopyFolderName">/home/sftp_user1/incoming/arc/</Setting>
  </Item>
  <Item Name="Archive" Category="" ClassName="Task.Operation.Archive" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Task1_WaitForFile" Category="" ClassName="Task.Service.WaitForRemoteFile" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Credentials">task_sftp</Setting>
    <Setting Target="Adapter" Name="FTPServer">task1</Setting>
    <Setting Target="Adapter" Name="Protocol">SFTP</Setting>
    <Setting Target="Adapter" Name="FilePath">/home/irisowner/outgoing/</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.txt</Setting>
    <Setting Target="Host" Name="CopyFolderName">/home/irisowner/outgoing/</Setting>
  </Item>
  <Item Name="Task2_WaitForFile" Category="" ClassName="Task.Service.WaitForRemoteFile" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Credentials">task_sftp</Setting>
    <Setting Target="Adapter" Name="FTPServer">task2</Setting>
    <Setting Target="Adapter" Name="Protocol">SFTP</Setting>
    <Setting Target="Adapter" Name="FilePath">/home/irisowner/outgoing/</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.txt</Setting>
    <Setting Target="Host" Name="CopyFolderName">/home/irisowner/outgoing/</Setting>
  </Item>
  <Item Name="job08RemoteFile" Category="" ClassName="Task.Process.job08RemoteFile" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="job09RemoteFiles" Category="" ClassName="Task.Process.job09RemoteFiles" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Task1_WaitForFolders" Category="" ClassName="Task.Service.WaitForRemoteFolders" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Credentials">task_sftp</Setting>
    <Setting Target="Adapter" Name="FTPServer">task1</Setting>
    <Setting Target="Adapter" Name="Protocol">SFTP</Setting>
    <Setting Target="Adapter" Name="FilePath">/home/irisowner/outgoing/</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.sem</Setting>
    <Setting Target="Host" Name="CopyFolderName">/home/irisowner/outgoing/task1/</Setting>
  </Item>
  <Item Name="Task2_WaitForFolders" Category="" ClassName="Task.Service.WaitForRemoteFolders" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Credentials">task_sftp</Setting>
    <Setting Target="Adapter" Name="FTPServer">task2</Setting>
    <Setting Target="Adapter" Name="Protocol">SFTP</Setting>
    <Setting Target="Adapter" Name="FilePath">/home/irisowner/outgoing/</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.sem</Setting>
    <Setting Target="Host" Name="CopyFolderName">/home/irisowner/outgoing/task2/</Setting>
  </Item>
  <Item Name="job10RemoteFolders" Category="" ClassName="Task.Process.job10RemoteFolders" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
