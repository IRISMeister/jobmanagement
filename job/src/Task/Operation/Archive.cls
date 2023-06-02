Class Task.Operation.Archive Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Method Exec(pRequest As Task.Request.CallTask, Output pResponse As Ens.Response) As %Status
{
	Set tSC='$$$OK

	Set builtins = ##class(%SYS.Python).Builtins()
	set pyfiles = builtins.list()
	Set pResponse=##class(Ens.Response).%New()
	Try {

		Kill files
		Set folderCount=pRequest.Files.Count()
		For i=1:1:folderCount {
			Set filename=pRequest.Files.GetAt(i)
			Set files($INCREMENT(files))=filename
			do pyfiles.append(filename)
		}

		#; zipファイル名は重複しないよう何か工夫すること
		Set arcfilename="/home/irisowner/files_"_$J_".zip"
		Do ..ArchiveFiles(pyfiles,arcfilename)

		#; BO/SFTPを使用してzipファイルを外部に送信
		Set pReq=##class(Task.Context.Custom).CreateStreamContainer(arcfilename)
		Set tSC=..SendRequestSync("SFTP",pReq,.pResp)
		$$$ThrowOnError(tSC)

		#; 処理(archive)済みファイルを削除する
		Set seq="" For { 
			Set seq=$O(files(seq)) Q:seq=""
			Set filename=files(seq)
			$$$LOGINFO("Deleteing "_filename)
			Set tRet=##class(%File).Delete(filename,.oserror)
			If tRet'=1 {
				Throw ##class(%SYSTEM.Status).Error(5001,"%File.Delete() エラー: O/S Error:"_$G(oserror))
			}
		}

	}
	Catch ex {
		Set tSC=ex.AsStatus()
	}

	Return tSC
}

Method ArchiveFiles(files, arhfile) [ Language = python ]
{
	# files(list形式)内の要素をファイル名とみなしてZIPに追加する。
	import zipfile
	with zipfile.ZipFile(arhfile, 'w') as myzip:
		for file in files:
			myzip.write(file)
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="Task.Request.ArchiveFiles"> 
		<Method>Exec</Method>
	</MapItem>
</MapItems>
}

}
