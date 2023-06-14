Class DeadLock.BS.DeferReq Extends Ens.BusinessService
{

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
	Set tSC = ..SendRequestAsync("Defer", pInput)
	Return tSC
	Return $$$OK
}

}
