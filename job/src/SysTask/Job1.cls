Class SysTask.Job1 Extends %SYS.Task.Definition
{

Property JobName As %String;

Property P1 As %String;

Method OnTask() As %Status
{
	Set seq=$INCREMENT(^SysTaskLog)
	Set ^SysTaskLog(seq,1)=$ZDATETIME($H)_"/"_$JOB
	Set tSC=$$$OK
	If ..JobName="" Return 'tSC

	Try {
		Set tSC = ##class(Ens.Director).CreateBusinessService("Initiator",.tService)
		
		If ($IsObject(tService)) {
			Set input=##class(Task.Request.CallJob).%New()
			Set input.JobName=..JobName   //"Job1"
			Set input.P1=..P1             //"abc"
			Set input.P2=$G(^SysTask.Job1,5)
			Set tSC = tService.ProcessInput(input,.output)
			Set ^SysTaskLog(seq,2)=$ZDATETIME($H)_"/"_$JOB_"/"_tService.%SessionId
		}
	}
	catch e {
		Set tSC=e.AsStatus()
	}
	Return tSC
}

}
