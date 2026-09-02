Class Misc.OP.WaitSecs Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Method Wait(pRequest As Ens.StringRequest, Output pResponse As Ens.Response) As %Status
{
	Set wait=pRequest.StringValue
	$$$LOGINFO("Waiting for "_wait_" seconds")
	h wait
	Set pResponse=##class(Ens.Response).%New()

	Return $$$OK
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="Ens.Request"> 
		<Method>Wait</Method>
	</MapItem>
</MapItems>
}

}
