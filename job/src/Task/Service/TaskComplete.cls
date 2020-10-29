Class Task.Service.TaskComplete Extends EnsLib.SOAP.Service
{

/// ウェブサービスの名前.
Parameter SERVICENAME = "TaskComplete";

/// TODO: これを実際のSOAPネームスペースに変更します。
/// ウェブサービス用のSOAPネームスペース
Parameter NAMESPACE = "http://tempuri.org";

/// 参照されているクラスのネームスペースは WSDL に使用されます。
Parameter USECLASSNAMESPACES = 1;

/// TODO: 引数および実装を追加します。
/// Test
Method ReceiveDeferedResponse(token As %String, response As Task.WS.CallTaskResponse) As %Status [ WebMethod ]
{
	$$$TRACE("token:"_token_" R1:"_response.R1_" R2:"_response.R2_" R3:"_response.R3)
	Set pResponse=##class(Task.Response.CallTask).%New()
	Set pResponse.TaskName=response.TaskName
	Set pResponse.TaskStatus=response.TaskStatus
	Set pResponse.TaskErrorMessage=response.TaskErrorMessage
	Set pResponse.R1=response.R1
	Set pResponse.R2=response.R2
	Set pResponse.R3=response.R3
	Set pResponse.HostName=response.HostName
	Set pResponse.StartTime=response.StartTime
	Set pResponse.EndTime=response.EndTime
	Set pResponse.GlobalReferences=response.GlobalReferences
	Set pResponse.LinesExecuted=response.LinesExecuted
	Set pResponse.SessionId=response.SessionId

	Do ..SendDeferredResponse(token,pResponse)
	Quit $$$OK
}

}
