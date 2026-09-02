Class Misc.OP.NoOp Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Method Wait(pRequest As Ens.Request, Output pResponse As Ens.Response) As %Status
{

	Set count=$INCREMENT(^NoOpcount)
	if (count#10=0) { 
		Set a=3/0
	}
	Set pResponse=##class(Ens.Response).%New()
	h 0.1
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
