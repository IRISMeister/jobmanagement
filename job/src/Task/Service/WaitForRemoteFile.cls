Class Task.Service.WaitForRemoteFile Extends Ens.BusinessService [ Language = objectscript ]
{

Property CopyFolderName As %Library.String(MAXLEN = 200);

Parameter SETTINGS = "CopyFolderName:Basic:directorySelector";

Parameter ADAPTER = "EnsLib.FTP.InboundAdapter";

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
	;FTPの場合、File.InboundAdapterと異なりFilenameプロパティが無い
	Set filename=pInput.Attributes("FTPDir")_pInput.Attributes("Filename")

	Set targethost=..Adapter.FTPServer ; Get config FTPServer name such as "task1", "task2". 
	Set stmt=##class(%SQL.Statement).%New()
	Set rs=stmt.%ExecDirect(,"SELECT FileName,Token FROM Task_Data.WaitFile where TargetHostName=? and FileName=?",targethost,filename)
	If rs.%Next() {
		#; pInput : %Library.FileCharacterStream
		#; EnsLib.FTP.InboundAdapterは処理済みファイルを削除/移動するが、SendDeferredResponse()を使用する場合
		#; そのタイミングを制御できないのでコピーを作成して、コピーを処理に回す。
		Set copyfilename=..CopyFolderName_pInput.Attributes("Filename")
		Set fs=##class(%Library.FileBinaryStream).%New()
		Set fs.Filename=copyfilename
		Do fs.CopyFrom(pInput)
		Set tSC=fs.%Save()

		$$$LOGINFO("targethost:"_targethost_" filename:"_filename_" token:"_rs.token_" Copy:"_copyfilename)

		Set pResponse=##class(Task.Response.WaitFile).%New()
		Set pResponse.FileName=copyfilename
		Set pResponse.TaskStatus="OK"
		Set tSC=..SendDeferredResponse(rs.token,pResponse)
	}
	Else {
		$$$LOGINFO("targethost:"_targethost_" filename:"_filename_" found but no BP is waiting for it. Ignored")
	}

	Return $$$OK
}

}
