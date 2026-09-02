Class Misc.BS.DirectFlowMany Extends Ens.BusinessService
{

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
	Set tSC = ..SendRequestSync("FlowMany", pInput, .pOutput)
	Return tSC
	Return $$$OK
}

}
