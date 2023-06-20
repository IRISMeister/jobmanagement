Class Misc.BS.DeferReq Extends Ens.BusinessService
{

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
	Set tSC = ..SendRequestAsync("CallDefer", pInput)
	Return tSC
	Return $$$OK
}

}
