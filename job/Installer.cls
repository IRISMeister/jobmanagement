Class MyApps.Installer
{

XData setup [ XMLNamespace = INSTALLER ]
{
<Manifest>

<User Username="appuser" PasswordVar="appuserpwd" Roles="" Namespace="" Routine="" ExpirationDate="" Enabled="1" Comment="appilication user"/>
  <Namespace Name="${Namespace}" Create="yes" Ensemble="1">
    <Configuration>
      <Database Name="${Namespace}" Dir="${DBDIR}${Namespace}" Create="yes" Resource="%DB_${Namespace}"/>
    </Configuration>
    <CSPApplication Url="/csp/${Namespace}" Directory="${CSPDIR}${Namespace}" GroupById="%ISCMgtPortal" Resource=""/>
    <CSPApplication Url="/csp/${Namespace}/api" Directory="${CSPDIR}${Namespace}" Resource=""/>
    <Import File="${SRCDIR}" Flags="ck" Recurse="true"/>
	<Production Name="Task.Production1" AutoStart="1">
	</Production>
  </Namespace>
</Manifest>
}

ClassMethod setupMethod(ByRef pVars, pLogLevel As %Integer = 3, pInstaller As %Installer.Installer, pLogger As %Installer.AbstractLogger) As %Status [ CodeMode = objectgenerator, Internal ]
{
  Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "setup")
}

ClassMethod setup(Namespace As %String, srcdir As %String) As %Status
{
  Set tSC='$$$OK
  Try {
    Set webapp="/csp/"_Namespace
    Set webapi="/csp/"_Namespace_"/api"

    Set tVars("Namespace")=Namespace
    Set tVars("appuserpwd")="sys"
    Set tVars("SRCDIR")=srcdir
    Set tSC=..setupMethod(.tVars)
    $$$ThrowOnError(tSC)

    New $NAMESPACE
    Set $NAMESPACE="%SYS"

    Set tSC=##class(Security.Users).UnExpireUserPasswords("*")

	  #; /csp/testをAnalytics有効に。(Workflow portal使用のため)
    Set tSC = ##Class(Security.Applications).Get(webapp,.props)
    Set props("DeepSeeEnabled")=1
    Set tSC = ##Class(Security.Applications).Modify(webapp,.props)

    Set tSC = ##Class(Security.Applications).Get(webapi,.props)
    $$$ThrowOnError(tSC)
    Set props("DispatchClass")="Task.REST.Dispatcher"
    Set props("Resource")=""
	  Set props("AutheEnabled")=32
	  Set props("IsNameSpaceDefault")=0
    Set props("MatchRoles")=":%All"
    Set props("NameSpace")=Namespace
    Kill props("Type")
    Set tSC = ##Class(Security.Applications).Modify(webapi,.props)
    $$$ThrowOnError(tSC)

    Set $NAMESPACE=Namespace

    #; Workflow User 追加
    Set username="_SYSTEM"
    Set tSC=##class(EnsLib.Workflow.UserDefinition).CreateUser(username,"Workflow User "_username)
    $$$ThrowOnError(tSC)

    #; Workflow Role 追加
    Set tSC=##class(EnsLib.Workflow.RoleDefinition).CreateRole("Operator")
    $$$ThrowOnError(tSC)

    #; Workflow Role に Userを追加
    Set tSC=##class(EnsLib.Workflow.RoleDefinition).AddUserToRole("Operator",username,,"Workflow Role "_username)
    $$$ThrowOnError(tSC)

    #; Credentialを追加/変更
    Set tSC=##class(Ens.Config.Credentials).SetCredential("default","_SYSTEM","SYS",1)
    Set tSC=##class(Ens.Config.Credentials).SetCredential("sftp","foo","pass",1)
    $$$ThrowOnError(tSC)
          
    #;IRISタスクを追加
    Set task = ##class(%SYS.Task).%New()
    Set task.Name = "Job1"
    Set task.Description = "Call Job1"
    Set task.NameSpace = "JOB"
    Set task.TaskClass = "SysTask.Job1"
    Set task.Settings = $lb("JobName","Job1","P1","abc")
    Set task.TimePeriod = 0
    Set task.DailyFrequency = 1
    Set task.DailyFrequencyTime = 0
    Set task.DailyIncrement = 5
    Set task.SuspendOnError=1
    Set task.RunAsUser = "SuperUser"
    Set task.RescheduleOnStart = 1
    Set task.TimePeriodEvery = 1
    Set task.Type=2
    Set task.StartDate = +$H
    Set tSC = task.%Save()	
    $$$ThrowOnError(tSC)

  } Catch(e) {
	  Set tSC=e.AsStatus()
  }
  Return tSC
}

}
