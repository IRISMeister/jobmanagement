Class Task.Operation.Defer Extends Ens.BusinessOperation
{

Parameter INVOCATION = "InProc";

Method ExecWaitFolder(pRequest As Task.Request.WaitFolder, Output pResponse As Ens.Response) As %Status
{
	Set token="" Do ..DeferResponse(.token)

	#; (複数)フォルダ待ち
	&SQL(INSERT INTO Task_Data.WaitFolder (FolderName, Token) VALUES (:pRequest.FolderName, :token))
	If SQLCODE'=0 {
		// 監視フォルダの重複登録は許可しない
		$$$LOGINFO("SQLCODE:"_SQLCODE)
	}

	Return $$$OK
}

Method ExecWaitFile(pRequest As Task.Request.WaitFile, Output pResponse As Ens.Response) As %Status
{
	Set token="" Do ..DeferResponse(.token)
	&SQL(INSERT INTO Task_Data.WaitFile (FileName, Token) VALUES (:pRequest.FileName, :token))
	If SQLCODE'=0 {
		// 監視フォルダの重複登録は許可しない
		$$$LOGINFO("SQLCODE:"_SQLCODE)
	}
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
