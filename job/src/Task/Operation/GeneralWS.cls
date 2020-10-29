/// 現在未使用
Class Task.Operation.GeneralWS Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SOAP.OutboundAdapter";

Property Adapter As EnsLib.SOAP.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method Exec(pRequest As Task.Request.CallTask, Output pResponse As Task.Response.CallTask) As %Status
{
	Try {
		Do ..DeferResponse(.token)
		Set tSC=..Adapter.InvokeMethod("RunTask",.WSResult,pRequest.SessionId,pRequest.TaskName,token,pRequest.Deferred,pRequest.P1,pRequest.P2,pRequest.P3,pRequest.P4,pRequest.P5)
		$$$ThrowOnError(tSC)

	}
	Catch e {
		Set errorText=e.DisplayString()
		Set TaskErrorMessage="ホスト名:"_##class(%SYSTEM.INetInfo).LocalHostName()_" タスク名:"_pRequest.TaskName_" コンフィグ名:"_..%ConfigName_" ("_..%SessionId_") エラー情報:"_errorText
		
		#;アラートを送信
		Set alert=##class(Ens.AlertRequest).%New()
		Set alert.SourceConfigName=..%ConfigName
		Set alert.AlertText=TaskErrorMessage
		Set tSts=..SendAlert(alert)
		
		#;ここで想定される例外は、接続できなかった、応答が時間内(レスポンス・タイムアウト値)に返ってこなかった場合。
		#;エラー #6059: サーバ localhost:52773 のTCP/IPソケットを開くことができません (alert request ID=5)
		#;エラー #5922: 応答待ちがタイムアウトしました (alert request ID=25)
		
		#;ターゲットからのレスポンスメッセージ送信を待たない。
		Set ..DeferResponse=0

		#;エラー #5922の場合、エラーにしない。メッセージ再送信(リトライ)もさせない。
		#;応答時間内に返ってこなかった場合、それ以降にターゲットが応答を返す可能性はある。その場合、同メッセージは破棄される。
		#;TaskStatus="NG"を返却することで、ワークフローの処理に乗せる。
		If (e.Code=5922) {
			Set ..Retry=0
			Set pResponse=##class(Task.Response.CallTask).%New()
			Set pResponse.TaskStatus="NG"
			Set pResponse.R1="Catch"
		}
	}
	Return $$$OK
}

Method OnFailureTimeout(pRequest As %Library.Persistent, Output pResponse As %Library.Persistent, ByRef pSC As %Status) As %Boolean
{
	#;エラー #6059:の場合、再試行間隔/再試行タイムアウト値に従って、リトライを繰り返す。
	#;その再試行がタイムアウトした場合の処理。
	#;TaskStatus="NG"を返却することで、ワークフローの処理に乗せる。
	Set ..DeferResponse=0
	Set pResponse=##class(Task.Response.CallTask).%New()
	Set pResponse.TaskStatus="NG"
	Set pResponse.R1="OnFailureTimeout"
	Set pSC=$$$OK
	Return $$$OK
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="Task.Request.CallTask"> 
		<Method>Exec</Method>
	</MapItem>
</MapItems>
}

}
