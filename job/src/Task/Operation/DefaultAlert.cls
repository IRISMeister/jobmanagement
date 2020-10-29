Class Task.Operation.DefaultAlert Extends Ens.Alerting.NotificationOperation
{

Parameter INVOCATION = "Queue";

Method OnMessage(pRequest As %Library.Persistent, Output pResponse As Ens.Response) As %Status
{
	Quit $$$OK
}

}
