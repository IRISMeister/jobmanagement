Class Task.Service.WaitForFile Extends Ens.BusinessService [ Language = objectscript ]
{

Property CopyFolderName As %Library.String(MAXLEN = 200);

Parameter SETTINGS = "CopyFolderName:Basic:directorySelector";

Parameter ADAPTER = "EnsLib.File.InboundAdapter";

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
	Set filename=pInput.Filename ; full path name
	Set stmt=##class(%SQL.Statement).%New()
	#; $localは自身のローカルディスクを意味する仮のホスト名
	Set rs=stmt.%ExecDirect(,"SELECT FileName,Token FROM Task_Data.WaitFile where TargetHostName='$local' and FileName=?",filename)
	If rs.%Next() {
		#; pInput : %Library.FileCharacterStream
		#; EnsLib.File.InboundAdapterは、OnProcessInput()正常完了後に、処理済みファイルを削除/移動する。
		#; SendDeferredResponse()を使用する場合、そのタイミングを制御できないのでコピーを作成して、コピーを処理に回す。
		Set copyfilename=..CopyFolderName_##class(%File).GetFilename(filename)
		Set fs=##class(%Library.FileBinaryStream).%New()
		Set fs.Filename=copyfilename
		Do fs.CopyFrom(pInput)
		Set tSC=fs.%Save()

		$$$LOGINFO("filename:"_filename_" token:"_rs.token_" Copy:"_copyfilename)

		Set pResponse=##class(Task.Response.WaitFile).%New()
		Set pResponse.FileName=copyfilename
		Set pResponse.TaskStatus="OK"
		Set tSC=..SendDeferredResponse(rs.token,pResponse)
	}
	Else {
		$$$LOGINFO("filename:"_filename_" found but no BP is waiting for it. Ignored")
	}

	Return $$$OK
}

/*
//Fileアダプタ無しの実装。
// こちらのほうが実装が容易(処理したファイルが削除・移動されないのでコピー作成も不要)だが、SFTPでの処理方法と乖離する。
//(ファイルの場所をテーブルから取得するので、ローカルの任意の場所を監視できるがSFTP上のファイルには使えない)
Parameter ADAPTER = "Ens.InboundAdapter";
Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
	Set stmt=##class(%SQL.Statement).%New()
	Set rs=stmt.%ExecDirect(,"SELECT FileName,Token FROM Task_Data.WaitFile where TargetHostName='$local'")
	While(rs.%Next()) {
		Set filename=rs.FileName
		$$$TRACE(filename)
		If ##class(%File).Exists(filename) {

			$$$LOGINFO("filename:"_filename_" token:"_rs.token)

			Set pResponse=##class(Task.Response.WaitFile).%New()
			Set pResponse.FileName=filename
			Set pResponse.TaskStatus="OK"

			Set tSC=..SendDeferredResponse(rs.token,pResponse)

		}
	}
	Return $$$OK
}
*/
}
