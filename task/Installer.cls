Class MyApps.Installer
{

XData setup [ XMLNamespace = INSTALLER ]
{
<Manifest>

<User Username="appuser" PasswordVar="appuserpwd" Roles="" Namespace="" Routine="" ExpirationDate="" Enabled="1" Comment="appilication user"/>
  <Namespace Name="${Namespace}" Create="yes" Ensemble="0">
    <Configuration>
      <Database Name="${Namespace}" Dir="${DBDIR}${Namespace}" Create="yes" Resource="%DB_${Namespace}"/>
    </Configuration>
    <CSPApplication Url="/csp/${Namespace}" Directory="${CSPDIR}${Namespace}" Resource=""/>
    <CSPApplication Url="/csp/${Namespace}/api" Directory="${CSPDIR}${Namespace}" Resource=""/>
    <Import File="${SRCDIR}" Flags="ck" Recurse="true"/>
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
    Set webapp="/csp/"_Namespace_"/api"

    Set tVars("Namespace")=Namespace
    Set tVars("appuserpwd")="sys"
    Set tVars("SRCDIR")=srcdir
    Set tSC=..setupMethod(.tVars)
    $$$ThrowOnError(tSC)

    New $NAMESPACE
    Set $NAMESPACE="%SYS"

    Set tSC=##class(Security.Users).UnExpireUserPasswords("*")

    Set tSC = ##Class(Security.Applications).Get(webapp,.props)
    $$$ThrowOnError(tSC)
    Set props("DispatchClass")="Task.REST.Dispatcher"
    Set props("Resource")=""
	  Set props("AutheEnabled")=32
	  Set props("IsNameSpaceDefault")=0
    Set props("MatchRoles")=":%All"
    Set props("NameSpace")=Namespace
    Kill props("Type")
    Set tSC = ##Class(Security.Applications).Modify(webapp,.props)
    $$$ThrowOnError(tSC)

    Set $NAMESPACE=Namespace

  } Catch(e) {
	  Set tSC=e.AsStatus()
  }
  Return tSC
}

}
