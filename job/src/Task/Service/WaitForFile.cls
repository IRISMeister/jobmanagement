Class Task.Service.WaitForFile Extends Ens.BusinessService [ Language = objectscript ]
{

Parameter ADAPTER = "Ens.InboundAdapter";

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{

	Set stmt=##class(%SQL.Statement).%New()
	Set rs=stmt.%ExecDirect(,"SELECT FileName,Token FROM Task_Data.WaitFile")
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

}
