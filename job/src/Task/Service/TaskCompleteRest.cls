Class Task.Service.TaskCompleteRest Extends Ens.BusinessService
{

Method OnProcessInput(pInput As %RegisteredObject, pOutput As %RegisteredObject) As %Status
{
	
	Set %response.ContentType="application/json"
	Set %response.CharSet=%request.CharSet
	Set response={}.%FromJSON(%request.Content)
	
	$$$TRACE("Token:"_response.Token_" R1:"_response.R1_" R2:"_response.R2_" R3:"_response.R3)
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

	Do ..SendDeferredResponse(response.Token,pResponse)
	Quit $$$OK
}

}
