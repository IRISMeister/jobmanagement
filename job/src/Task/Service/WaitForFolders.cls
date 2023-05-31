Class Task.Service.WaitForFolders Extends Ens.BusinessService [ Language = objectscript ]
{

Parameter ADAPTER = "EnsLib.File.InboundAdapter";

Method OnProcessInput(pInput As %Stream.Object, Output pOutput As %RegisteredObject) As %Status
{

	Set tSC='$$$OK
	Try {
		Set folder=pInput.ReadLine()
		&SQL(SELECT TOKEN into :token FROM Task_Data.WaitFolder WHERE FolderName=:folder)
		$$$LOGINFO("folder:"_folder_" token:"_token)

		Set pResponse=##class(Task.Response.WaitFolder).%New()
		Set pResponse.Folder=folder

		; このBSが完了するとトリガファイルが削除されてしまう(ソースシステムからの次回の送信が始まる可能性が出てくる)ので
		; OnProcessInput()完了前に、処理相対象のファイルを確定する。
		Set stmt=##class(%SQL.Statement).%New()
		Set tSC=stmt.%PrepareClassQuery("%Library.File","FileSet")
		Set rs=stmt.%Execute(folder)
		While(rs.%Next()) {
			Set filename=rs.%CurrentResult.Name
			Do pResponse.Files.Insert(filename)
		}

		Set tSC=..SendDeferredResponse(token,pResponse)
	}
	Catch ex {
		Set tSC=ex.AsStatus()
	}
	Return tSC
}

}
