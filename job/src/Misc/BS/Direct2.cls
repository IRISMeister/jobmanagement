Class Misc.BS.Direct2 Extends Ens.BusinessService
{

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
	Set tSC = ..SendRequestSync("Main2", pInput, .pOutput)
	Return tSC
	Return $$$OK
}

}
