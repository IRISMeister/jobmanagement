Class Task.Service.FileWatcher Extends Ens.BusinessService [ Language = objectscript ]
{

Parameter ADAPTER = "EnsLib.File.InboundAdapter";

Method OnProcessInput(pInput As %Stream.Object, Output pOutput As %RegisteredObject) As %Status
{
	$$$TRACE(pInput)
	return $$$OK
}

}
