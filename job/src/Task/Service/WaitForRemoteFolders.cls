Class Task.Service.WaitForRemoteFolders Extends Ens.BusinessService [ Language = objectscript ]
{

Parameter ADAPTER = "EnsLib.FTP.InboundAdapter";

Method OnProcessInput(pInput As %Stream.Object, Output pOutput As %RegisteredObject) As %Status
{

	Set tSC='$$$OK
	Try {
		Set folder=pInput.ReadLine()
		&SQL(SELECT TOKEN into :token FROM Task_Data.WaitFolder WHERE FolderName=:folder)
		$$$LOGINFO("folder:"_folder_" token:"_token)

		Set pResponse=##class(Task.Response.WaitFolder).%New()
		Set pResponse.Folder=folder
		Set pResponse.TaskStatus="OK"

		; SendDeferredResponse()はSendではあるが、応答の送信なので、これにより再開するBPの完了を待つ(Syncする)ことは出来ない。
		; このBSが完了するとトリガファイルが削除されてしまう(ソースシステムからの次回の送信が始まる可能性が出てくる)ので
		; OnProcessInput()完了前に、処理対象のファイル群を確定し、応答メッセージに含める。
		Set stmt=##class(%SQL.Statement).%New()
		Set tSC=stmt.%PrepareClassQuery("EnsLib.FTP.Common","FileList")
		Set rs=stmt.%Execute(..Adapter,folder)
		While(rs.%Next()) {
			Set filename=rs.%CurrentResult.Name
			Do pResponse.Files.Insert(filename)
			$$$LOGINFO(filename)
		}

		Set tSC=..SendDeferredResponse(token,pResponse)
	}
	Catch ex {
		Set tSC=ex.AsStatus()
	}
	Return tSC
}

}
