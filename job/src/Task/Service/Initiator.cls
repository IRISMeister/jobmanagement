Class Task.Service.Initiator Extends Ens.BusinessService
{

Parameter SETTINGS = "CallBP:Basic";

Method OnProcessInput(pInput As Task.Request.CallJob, Output pOutput As %RegisteredObject) As %Status
{
	Set pTargetDispatchName=pInput.JobName
	Set tSC = ..SendRequestSync(pTargetDispatchName, pInput, .pOutput)
	Return tSC
	Return $$$OK
}

}
