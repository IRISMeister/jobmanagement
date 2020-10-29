Class MyTask.SuperClass Extends %RegisteredObject
{

ClassMethod Exec(SessionId As %String, Token As %String, P1 As %String = "", P2 As %String = "", P3 As %String = "", P4 As %String = "", P5 As %String = "") As %Status
{
	Set preLinesExecuted=$SYSTEM.Process.LinesExecuted()
	Set preGlobalReferences=$SYSTEM.Process.GlobalReferences()

	Set me=$classmethod($classname(),"%New")
	Set response=##class(TaskComplete.CallTaskResponse).%New()

	Try {
		Set response.SessionId=SessionId
		Set response.HostName=##class(%SYSTEM.INetInfo).LocalHostName()
		Set response.StartTime=$ZDATETIME($H,3)
		Set response.TaskName=$classname()
		Set response.TaskStatus="NG"
		Set tSC=me.Task(SessionId,P1,P2,P3,P4,P5,.R1,.R2,.R3)
		$$$ThrowOnError(tSC)
		Set response.TaskStatus="OK"
		Set response.R1=R1
		Set response.R2=R2
		Set response.R3=R3
	}
	Catch e {
		#;ここの内容がアラート管理画面やワークフローのユーザポータルに表示される全てなので、適切な情報を与える事。
		Set response.TaskStatus="NG"
		Set errorText=e.DisplayString()
		Set response.TaskErrorMessage="ホスト名:"_##class(%SYSTEM.INetInfo).LocalHostName()_" クラス名:"_$classname()_" エラー情報:"_errorText
	}
	Set response.EndTime=$ZDATETIME($H,3)
	Set response.LinesExecuted=$SYSTEM.Process.LinesExecuted()-preLinesExecuted
	Set response.GlobalReferences=$SYSTEM.Process.GlobalReferences()-preGlobalReferences
	
	#;遅延応答であれば
	If (Token'="") {
		;Set tSC=me.SendResponse(Token,response) ; via WebService
		Set tSC=me.SendResponseRest(Token,response)  ; via REST Service
	}
	Else {
		Set resp={}
		Set tSC=me.CreateResponse("",resp, response) 
		Do resp.%ToJSON()
	}
	Return $$$OK
}

/*
Method SendResponse(token, response) As %Status
{
	Try {
		Set wsc=##class(WSClient.TaskCompleteSoap).%New()
		Set user="_SYSTEM"
		Set pwd="SYS" 
		Set utoken=##class(%SOAP.Security.UsernameToken).Create(user,pwd)
		Do wsc.SecurityOut.AddSecurityElement(utoken)
		Set wsc.Timeout=660
		
		Set tSts=wsc.ReceiveDeferedResponse(token,response)
		If $$$ISERR(tSts) throw ##class(%Exception.StatusException).CreateFromStatus(tSts)
	}
	Catch e {
		If +%objlasterror=0 {Set errorText=##class(%Status).LogicalToOdbc(%objlasterror)}
		Else {Set errorText=e.DisplayString()}
		Set TaskErrorMessage="ホスト名:"_##class(%SYSTEM.INetInfo).LocalHostName()_" クラス名:"_$classname()_" エラー情報:"_errorText
		Set ^err($INCREMENT(err))=TaskErrorMessage
	}

	Return $$$OK
}
*/
Method SendResponseRest(token, response) As %Status
{
	Try {
		Set httpreq=##class(%Net.HttpRequest).%New()
		#; 以下の、連携基盤のエンドポイントは、パラメータテーブル等からの取得が望ましい。
		Set httpreq.Server="job"
		Set httpreq.Port=52773
		Set httpreq.Username="_SYSTEM"
		Set httpreq.Password="SYS"
		Set httpreq.ContentType="application/json; charset=UTF-8"
		Set url="/csp/job/api/TaskComplete"
		
		Set resp={}
		Set tSC=..CreateResponse(token,resp, response) 
		
		do httpreq.EntityBody.Write(resp.%ToJSON())
		Set tSC=httpreq.Post(url)
		If $$$ISERR(tSC) throw ##class(%Exception.StatusException).CreateFromStatus(tSC)
	}
	Catch e {
		If +%objlasterror=0 {Set errorText=##class(%Status).LogicalToOdbc(%objlasterror)}
		Else {Set errorText=e.DisplayString()}
		Set TaskErrorMessage="ホスト名:"_##class(%SYSTEM.INetInfo).LocalHostName()_" クラス名:"_$classname()_" エラー情報:"_errorText
		Set ^err($INCREMENT(err))=TaskErrorMessage
	}

	Return $$$OK
}

Method CreateResponse(token, resp, response) As %Status
{
	Set resp.Token=token
	Set resp.TaskName=response.TaskName
	Set resp.TaskStatus=response.TaskStatus
	Set resp.TaskErrorMessage=response.TaskErrorMessage
	Set resp.R1=response.R1
	Set resp.R2=response.R2
	Set resp.R3=response.R3
	Set resp.HostName=response.HostName
	Set resp.StartTime=response.StartTime
	Set resp.EndTime=response.EndTime
	Set resp.GlobalReferences=response.GlobalReferences
	Set resp.LinesExecuted=response.LinesExecuted
	Set resp.SessionId=response.SessionId

	Return $$$OK
}

Method Task(SessionId As %String = "", P1 As %String = "", P2 As %String = "", P3 As %String = "", P4 As %String = "", P5 As %String = "", ByRef R1 As %String = "", ByRef R2 As %String = "", ByRef R3 As %String = "") As %Status
{
	Set ^MyTask($INCREMENT(^MyTask))=$LISTBUILD($ZDATETIME($H),$classname(),SessionId,P1,P2,P3,P4,P5)
	Set R1="OK",R2=$ZDATETIME($H),R3="OK"

	Return $$$OK
}

}
