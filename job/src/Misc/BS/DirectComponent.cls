Class Misc.BS.DirectComponent Extends Ens.BusinessService
{

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
	Set tSC = ..SendRequestSync("CallBP", pInput, .pOutput)
	Return tSC
	Return $$$OK
}

}
