Class Task.Operation.GeneralRest Extends EnsLib.REST.Operation
{

Parameter ADAPTER = "EnsLib.HTTP.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method Exec(pRequest As Task.Request.CallTask, Output pResponse As Task.Response.CallTask) As %Status
{
#;DEFINE TIMING
#ifdef TIMING
		Set pResponse=##class(Task.Response.CallTask).%New()
		Set pResponse.TaskStatus="OK"
		Set pResponse.R1="Debug"
		Return $$$OK
#endif

	Try {
		#; Targetでの実行を非同期にする場合はtokenを取得する。
		Set token="" If (pRequest.Deferred) { Do ..DeferResponse(.token) }

		Set request={}
		Set request.SessionId=pRequest.SessionId
		Set request.Taskname=pRequest.TaskName
		Set request.Deferred=pRequest.Deferred
		Set request.Token=token
		Set request.P1=pRequest.P1
		Set request.P2=pRequest.P2
		Set request.P3=pRequest.P3
		Set request.P4=pRequest.P4
		Set request.P5=pRequest.P5
		
		#; !!! Adapter.Postはhttpreq.Send()を実行する。
		#;(アダプタは何を実行しても最終的にはSendFormDataArrayがSend()を実行する)
		#; Send()はReset=1で実行されるので、仮にAdapterがコネクションを保持できても
		#; httpセッションの再利用はされない模様。→time_waitが発生。
		#; ContentType="application/json; charset=UTF-8"に設定するためにSendFormDataArray()を使用。
		#; Set tSC=..Adapter.Post(.tHttpResponse,,request.%ToJSON())
		Set httpreq=##class(%Net.HttpRequest).%New()
		Set httpreq.ContentType="application/json; charset=UTF-8"
		Set pData(1)=request.%ToJSON()
		Set tSC=..Adapter.SendFormDataArray(.tHttpResponse,"POST",httpreq,.pFormVarNames,.pData)

		$$$ThrowOnError(tSC)
		
		#;Targetでの実行が同期の場合、自分で応答を返す。
		If ('pRequest.Deferred) {
			#; HTTP Statusが成功であれば
			If (tHttpResponse.StatusCode)=200 {
				Set content=tHttpResponse.Data.Read(tHttpResponse.ContentLength)
				s response={}.%FromJSON(content)
				Set pResponse=##class(Task.Response.CallTask).%New()
				Set pResponse.TaskName=response.TaskName
				Set pResponse.TaskStatus=response.TaskStatus
				Set pResponse.TaskErrorMessage=response.TaskErrorMessage
				Set pResponse.R1=response.R1
				Set pResponse.R2=response.R2
				Set pResponse.R3=response.R3
				Set pResponse.HostName=response.HostName
				Set pResponse.StartTime=response.StartTime
				Set pResponse.EndTime=response.EndTime
				Set pResponse.GlobalReferences=response.GlobalReferences
				Set pResponse.LinesExecuted=response.LinesExecuted
				Set pResponse.SessionId=response.SessionId		
			}
			Else {
				#; todo:適切なエラーメッセージの検討
				$$$LOGERROR("HTTP Statusが異常。tHttpResponse.StatusCode):"_tHttpResponse.StatusCode)
				Throw 
			}
		}

	}
	Catch e {
		Set errorText=e.DisplayString()
		Set TaskErrorMessage="タスク名:"_pRequest.TaskName_" コンフィグ名:"_..%ConfigName_" ("_..%SessionId_") エラー情報:"_errorText
		
		#;アラートを送信
		Set alert=##class(Ens.AlertRequest).%New()
		Set alert.SourceConfigName=..%ConfigName
		Set alert.AlertText=TaskErrorMessage
		Set tSts=..SendAlert(alert)
		
		#;ここで想定される例外は、接続できなかった、応答が時間内(レスポンス・タイムアウト値)に返ってこなかった場合。
		#;エラー #6059: サーバ localhost:52773 のTCP/IPソケットを開くことができません (alert request ID=5)
		#;エラー #5922: 応答待ちがタイムアウトしました (alert request ID=25)
		#;エラー #6059の場合、何もしない。ビジネスホストのRetry設定に従って振舞う。
		
		#;ターゲットからのレスポンスメッセージ送信を待たない。
		Set ..DeferResponse=0
		
		#;HTTPレベルのエラーの場合、認証失敗等の事態を想定。
		#;エラー #5922の場合、エラーにしない。
		#;ターゲットの応答がResponseTimeoutより遅い場合に発生。
		#;メッセージ再送信(リトライ)もさせない。
		#;応答時間内に返ってこなかった場合、それ以降にターゲットが応答を返す可能性はある。その場合、同メッセージは破棄される。
		#;TaskStatus="NG"を返却することで、ワークフローの処理に乗せる。
		If (e.Code=5922)!(e.Code="<Ens>ErrHTTPStatus") {
			Set ..Retry=0
			Set pResponse=##class(Task.Response.CallTask).%New()
			Set pResponse.TaskStatus="NG"
			Set pResponse.TaskErrorMessage=TaskErrorMessage
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
