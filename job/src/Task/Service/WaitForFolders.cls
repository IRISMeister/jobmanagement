Class Task.Service.WaitForFolders Extends Ens.BusinessService [ Language = objectscript ]
{

Parameter ADAPTER = "EnsLib.File.InboundAdapter";

Method OnProcessInput(pInput As %Stream.Object, Output pOutput As %RegisteredObject) As %Status
{

	Set tSC='$$$OK
	Try {
		Set folder=pInput.ReadLine()
		&SQL(SELECT TOKEN into :token FROM Task_Data.WaitFolder WHERE TargetHostName='$local' and FolderName=:folder)
		$$$LOGINFO("folder:"_folder_" token:"_token)

		Set pResponse=##class(Task.Response.WaitFolder).%New()
		Set pResponse.Folder=folder
		Set pResponse.TaskStatus="OK"

		; SendDeferredResponse()はSendではあるが、応答の送信なので、これにより再開するBPの完了を待つ(Syncする)ことは出来ない。
		; このBSが完了するとトリガファイルが削除されてしまう(ソースシステムからの次回の送信が始まる可能性が出てくる)ので
		; OnProcessInput()完了前に、処理対象のファイル群を確定し、応答メッセージに含める。
		Set stmt=##class(%SQL.Statement).%New()
		Set tSC=stmt.%PrepareClassQuery("%Library.File","FileSet")
		Set rs=stmt.%Execute(folder)
		While(rs.%Next()) {
			Set filename=rs.%CurrentResult.Name
			Set tSC=pResponse.Files.Insert(filename)
			$$$ThrowOnError(tSC)
		}

		Set tSC=..SendDeferredResponse(token,pResponse)
	}
	Catch ex {
		Set tSC=ex.AsStatus()
	}
	Return tSC
}

}
