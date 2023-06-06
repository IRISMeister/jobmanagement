Class Task.Operation.Defer Extends Ens.BusinessOperation
{

Parameter INVOCATION = "InProc";

Method ExecWaitFolder(pRequest As Task.Request.WaitFolder, Output pResponse As Task.Response.WaitFolder) As %Status
{

	Set pResponse=##class(Task.Response.WaitFolder).%New()

	Set stmt=##class(%SQL.Statement).%New()
	Set rs=stmt.%ExecDirect(,"SELECT FolderName FROM Task_Data.WaitFolder WHERE FolderName=?",pRequest.FolderName)
	If rs.%Next() {
		#; フォルダ重複
		#; リトライしている間に解消する可能性はある。
		Set errorText="フォルダ重複 FolderName:"_pRequest.FolderName
		$$$LOGWARNING(errorText)
		Set ErrorMessage="コンフィグ名:"_..%ConfigName_" ("_..%SessionId_") エラー情報:"_errorText
		Set pResponse.TaskErrorMessage=ErrorMessage
		Set pResponse.TaskStatus="NG"
		Set pResponse.Folder=pRequest.FolderName

		#; OKを返さないと、呼び出し元のBPにレスポンスが伝わらない
		Return $$$OK
	}

	Set token="" Do ..DeferResponse(.token)
	#; フォルダ待ちのための登録
	Set rs=stmt.%ExecDirect(,"INSERT INTO Task_Data.WaitFolder (FolderName, Token) VALUES (?,?)",pRequest.FolderName, token)
	If rs.%SQLCODE'=0 {
		#; 予期せぬエラー発生。リトライで回復する見込みは薄い。
		Set errorText="SQLエラー SQLCODE:"_rs.%SQLCODE
		$$$LOGERROR(errorText)
		Set ErrorMessage="コンフィグ名:"_..%ConfigName_" ("_..%SessionId_") エラー情報:"_errorText
		Set pResponse.TaskErrorMessage=ErrorMessage
		Set pResponse.TaskStatus="NG"
		Set pResponse.Folder=pRequest.FolderName

		Return $$$OK
	}
	$$$LOGINFO("Token:"_token)
	Set pResponse.TaskStatus="OK"
	Return $$$OK
}

Method ExecWaitFile(pRequest As Task.Request.WaitFile, Output pResponse As Task.Response.WaitFile) As %Status
{
	Set pResponse=##class(Task.Response.WaitFile).%New()

	Set stmt=##class(%SQL.Statement).%New()
	Set rs=stmt.%ExecDirect(,"SELECT FileName FROM Task_Data.WaitFile WHERE FileName=?",pRequest.FileName)
	If rs.%Next() {
		#; フォルダ重複
		#; リトライしている間に解消する可能性はある。
		Set errorText="ファイル重複 FileName:"_pRequest.FileName
		$$$LOGWARNING(errorText)
		Set ErrorMessage="コンフィグ名:"_..%ConfigName_" ("_..%SessionId_") エラー情報:"_errorText
		Set pResponse.TaskErrorMessage=ErrorMessage
		Set pResponse.TaskStatus="NG"
		Set pResponse.FileName=pRequest.FileName

		#; OKを返さないと、呼び出し元のBPにレスポンスが伝わらない
		Return $$$OK
	}

	Set token="" Do ..DeferResponse(.token)
	#; フォルダ待ちのための登録
	Set rs=stmt.%ExecDirect(,"INSERT INTO Task_Data.WaitFile (FileName, Token) VALUES (?,?)",pRequest.FileName, token)
	If rs.%SQLCODE'=0 {
		#; 予期せぬエラー発生。リトライで回復する見込みは薄い。
		Set errorText="SQLエラー SQLCODE:"_rs.%SQLCODE
		$$$LOGERROR(errorText)
		Set ErrorMessage="コンフィグ名:"_..%ConfigName_" ("_..%SessionId_") エラー情報:"_errorText
		Set pResponse.TaskErrorMessage=ErrorMessage
		Set pResponse.TaskStatus="NG"
		Set pResponse.FileName=pRequest.FileName

		Return $$$OK
	}	
	$$$LOGINFO("Token:"_token)
	Set pResponse.TaskStatus="OK"
	Return $$$OK
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="Task.Request.WaitFolder"> 
		<Method>ExecWaitFolder</Method>
	</MapItem>
	<MapItem MessageType="Task.Request.WaitFile"> 
		<Method>ExecWaitFile</Method>
	</MapItem>
</MapItems>
}

}
