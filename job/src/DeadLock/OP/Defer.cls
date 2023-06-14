Class DeadLock.OP.Defer Extends Ens.BusinessOperation
{

Parameter INVOCATION = "InProc";

Method Exec(pRequest As Ens.Request, Output pResponse As Ens.Response) As %Status
{

	Set token="" Do ..DeferResponse(.token)
	Set ^token($INCREMENT(^token))=token
	Set pResponse=##class(Ens.Response).%New()

	Return $$$OK
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="Ens.Request"> 
		<Method>Exec</Method>
	</MapItem>
</MapItems>
}

}
