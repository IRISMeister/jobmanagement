Class Misc.BS.DirectFlow Extends Ens.BusinessService
{

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
	Set tSC = ..SendRequestSync("Flow", pInput, .pOutput)
	Return tSC
	Return $$$OK
}

}
