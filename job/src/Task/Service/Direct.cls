Class Task.Service.Direct Extends Ens.BusinessService
{

Method OnProcessInput(pInput As Task.Request.CallJob, Output pOutput As %RegisteredObject) As %Status
{
	Set pTargetDispatchName=pInput.JobName
	Set tSC = ..SendRequestSync(pTargetDispatchName, pInput, .pOutput)
	Return tSC
	Return $$$OK
}

}
