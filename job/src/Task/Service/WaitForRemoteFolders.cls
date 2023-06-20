Class Task.Service.WaitForRemoteFolders Extends Ens.BusinessService [ Language = objectscript ]
{

Property CopyFolderName As %Library.String(MAXLEN = 200);

Parameter SETTINGS = "CopyFolderName:Basic:directorySelector";

Parameter ADAPTER = "EnsLib.FTP.InboundAdapter";

Method OnProcessInput(pInput As %Stream.Object, Output pOutput As %RegisteredObject) As %Status
{

	Set tSC='$$$OK
	Try {
		Set OriginalFilePath=..Adapter.FilePath
		Set targethost=..Adapter.FTPServer ; Get config FTPServer name such as "task1", "task2". 

		; 先頭の1行をREADしてフォルダ名を得る
		Set pInput.LineTerminator=$C(10)
		Set folder=pInput.ReadLine()

		;フォルダ名とホスト名をキーとして対象となるTokenを得る。
		Set stmt=##class(%SQL.Statement).%New()
		Set rs=stmt.%ExecDirect(,"SELECT Token FROM Task_Data.WaitFolder where TargetHostName=? and FolderName=?",targethost,folder)
		If rs.%Next() {

			Set token=rs.token
			$$$LOGINFO("targethost:["_targethost_"] folder:["_folder_"] token:["_token_"]")

			Set pResponse=##class(Task.Response.WaitFolder).%New()
			Set pResponse.Folder=folder
			Set pResponse.TaskStatus="OK"

			; folder下のファイル一覧を取得
			Set rs2=##class(%ResultSet).%New("EnsLib.FTP.InboundAdapter:DeepList")
			Set tSC=rs2.Execute(..Adapter,folder,"*",0,"FileListSSH") 
			While(rs2.%Next()) {
				; SFTPサーバ上のフルパスファイル名を取得
				Set filename=rs2.Get("Name")
				$$$LOGINFO(filename)

				; ファイル名のみを取得
				Set file=##class(%File).GetFilename(filename)
				; ローカルに作成するコピーのファイル名を作成
				Set copyfilename=..CopyFolderName_file
				Set tSC=pResponse.Files.Insert(copyfilename)
				$$$ThrowOnError(tSC)

				; SFTP経由でfolder下にあるファイルを取得し、ローカルのcopyfilenameにコピーする。
				Set stream=##class(%Stream.FileBinary).%New()
				Do stream.LinkToFile(copyfilename)
				Set tSC=..Adapter.retrieveFile(file,stream,folder,0)
				$$$LOGINFO(tSC)
				Set tSC=stream.%Save()
				$$$LOGINFO(tSC)

				; 取得したSFTP上のファイルを削除する
				Set tSC=..Adapter.delete(file,folder)

			}
			Set tSC=..SendDeferredResponse(token,pResponse)
		}
		Else {
			$$$LOGINFO("No match."_" targethost:["_targethost_"] folder:["_folder_"] SQLCODE:"_rs.%SQLCODE)
			Set tSC=$$$OK
		}
	}
	Catch ex {
		Set tSC=ex.AsStatus()
	}
	Return tSC
}

}
