Class Task.REST.Dispatcher Extends %CSP.REST
{

Parameter CONVERTINPUTSTREAM = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/TaskComplete" Method="POST" Call="TaskComplete"/>
<Route Url="/Test/:session" Method="POST" Call="Test"/>
</Routes>
}

ClassMethod TaskComplete() As %Status
{
	Set tSC=##class(Ens.Director).CreateBusinessService("TaskComplete",.tService)
	Set tSC = tService.ProcessInput(,.output)
	Return tSC
}

ClassMethod Test(SessionId As %String) As %Status
{
	Set ^Test=SessionId_"/"_$ZDATETIME($H)
	Return $$$OK
}

}
