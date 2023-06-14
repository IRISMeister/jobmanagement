Class DeadLock.BS.DeferRes Extends Ens.BusinessService
{

Method OnProcessInput(pInput As Ens.StringRequest, Output pOutput As %RegisteredObject) As %Status
{
	Set pResponse=##class(Ens.Response).%New()
	Set tSC=..SendDeferredResponse(pInput.StringValue,pResponse)
	Return tSC
}

}
