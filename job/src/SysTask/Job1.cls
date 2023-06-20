Class SysTask.job01 Extends %SYS.Task.Definition
{

Property JobName As %String;

Property P1 As %String;

Method OnTask() As %Status
{
	Set seq=$INCREMENT(^SysTaskLog)
	Set ^SysTaskLog(seq,1)=$ZDATETIME($H)_"/"_"/"_..P1_"/"_$JOB
	Set tSC=$$$OK
	If ..JobName="" Return 'tSC

	Try {
		Set tSC = ##class(Ens.Director).CreateBusinessService("Direct",.tService)
		
		If ($IsObject(tService)) {
			Set input=##class(Task.Request.CallJob).%New()
			Set input.JobName=..JobName   //"job01"
			Set input.P1=..P1             //"abc"
			Set input.P2=$G(^SysTask.job01,0)
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
