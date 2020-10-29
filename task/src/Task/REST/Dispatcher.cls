Class Task.REST.Dispatcher Extends %CSP.REST
{

Parameter CONVERTINPUTSTREAM = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/RunTask" Method="POST" Call="RunTask"/>
<Route Url="/Test/:session" Method="POST" Call="Test"/>
</Routes>
}

ClassMethod RunTask() As %Status
{
	Set %response.ContentType="application/json"
	Set %response.CharSet=%request.CharSet

	Set req={}.%FromJSON(%request.Content)

	#;エージェント側での処理をJOB実行するか、自分(CSP実行プロセス)で実行するか。
	#; todo: sync実行するなら、deferせずに直で応答を返すべき。
	If req.Deferred=0 {
		Return $classmethod(req.Taskname,"Exec",req.SessionId,req.Token,req.P1,req.P2,req.P3,req.P4,req.P5)
	}
	Job $classmethod(req.Taskname,"Exec",req.SessionId,req.Token,req.P1,req.P2,req.P3,req.P4,req.P5)
	Return $$$OK
}

ClassMethod Test(SessionId As %String) As %Status
{
	Set ^Test=SessionId_"/"_$ZDATETIME($H)
	Return $$$OK
}

}
