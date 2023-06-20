Class Misc.BS.Direct1 Extends Ens.BusinessService
{

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
	Set tSC = ..SendRequestSync("Main", pInput, .pOutput)
	Return tSC
	Return $$$OK
}

}
