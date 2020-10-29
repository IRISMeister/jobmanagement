/// 現在未使用
Class Task.Operation.JobGeneral Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Method Exec(pRequest As Task.Request.CallTask, Output pResponse As Task.Response.CallTask) As %Status
{
	Set pResponse=##class(Task.Response.CallTask).%New()
	Set pResponse.TaskStatus="NG"
	Try {
		Set taskname=pRequest.TaskName ; such as "MyTask.NewClass1"
		Set pResponse.TaskName=taskname

	#if 1
		#;JOB. リモートは引数なしのルーチンしか呼べない。終了まで待つ必要がある。
		#;以下、JOBの例
		
	 	Job $classmethod(taskname,"Job",1)
		Set childjob=$ZCHILD
		Set s=##class(%SYSTEM.Semaphore).%New()
		Set tSts=s.Open(taskname)
		Set to=10
		Set tSts=s.Decrement(1,to)
	#endif	
	
		Set pResponse.TaskStatus="OK"
	}
	Catch e {
		Set pResponse.TaskStatus="NG"
		#;ここの内容がワークフローのユーザポータルに表示される全てなので、適切な情報を与える事。
		If +%objlasterror=0 {Set errorText=##class(%Status).LogicalToOdbc(%objlasterror)}
		Else {Set errorText=e.DisplayString()}
		Set TaskErrorMessage="ホスト名:"_##class(%SYSTEM.INetInfo).LocalHostName()_" タスク名:"_taskname_" コンフィグ名:"_..%ConfigName_" ("_..%SessionId_") エラー情報:"_errorText
		Set pResponse.TaskErrorMessage=TaskErrorMessage
		
		#;アラートを送信
		Set alert=##class(Ens.AlertRequest).%New()
		Set alert.SourceConfigName=..%ConfigName
		Set alert.AlertText=errorText
		Set tSts=..SendAlert(alert)
	}

	Quit $$$OK
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
