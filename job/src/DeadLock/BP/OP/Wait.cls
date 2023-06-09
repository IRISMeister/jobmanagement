Class DeadLock.OP.Wait Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Method Wait(pRequest As Ens.Request, Output pResponse As Ens.Response) As %Status
{

	Set pResponse=##class(Ens.Response).%New()
	h 10000

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
