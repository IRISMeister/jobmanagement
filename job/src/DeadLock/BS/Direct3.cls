Class DeadLock.BS.Direct3 Extends Ens.BusinessService
{

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
	Set tSC = ..SendRequestSync("Wait", pInput, .pOutput)
	Return tSC
	Return $$$OK
}

}
