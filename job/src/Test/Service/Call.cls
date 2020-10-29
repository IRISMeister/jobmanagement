Class Test.Service.Call Extends Ens.BusinessService
{

Method OnProcessInput(pInput As Task.Request.CallTask, Output pOutput As %RegisteredObject) As %Status
{
	Set tSC = ..SendRequestSync(pInput.Target, pInput, .pOutput)
	Quit $$$OK
}

}
