Class Task.Service.Timer Extends Ens.BusinessService [ Language = objectscript ]
{

Parameter ADAPTER = "Ens.InboundAdapter";

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
	Set tSC=$$$OK
	Try {
		#;処理に時間がかかる状況を作り出すデバッグ用の仕組み。
		L +^Task.Service.Timer
		If +$G(^Task.Service.Timer)>0 {
			Set halttime=^Task.Service.Timer
			Set ^Task.Service.Timer=0
		}
		Else {
			Set halttime=0
		}
		L -^Task.Service.Timer

		$$$LOGINFO("開始")
		
		Set input=##class(Task.Request.CallJob).%New()
		Set input.JobName="Job2"
		Set input.P1="abc"
		Set input.P2=halttime
		Set tSC = ..SendRequestSync(input.JobName, input, .output)

		$$$LOGINFO("終了")
	}
	catch e {
		Set tSC=e.AsStatus()
	}
	Return tSC
}

}
