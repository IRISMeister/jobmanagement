Class MyTask.OSDir Extends MyTask.SuperClass
{

Method Task(SessionId As %String = "", P1 As %String = "", P2 As %String = "", P3 As %String = "", P4 As %String = "", P5 As %String = "", ByRef R1 As %String = "", ByRef R2 As %String = "", ByRef R3 As %String = "") As %Status
{
	#; Windows host
	Set zftSC=$ZF(-100,"/SHELL /STDOUT="_P2,"dir",P1)
	If (zftSC=-1) {
		Set R1="NG",R3=zftSC,R4=$ZCVT($SYSTEM.Process.OSError(),"I","SJIS")
	}
	Else {
		Set R1="OK"
	}
	Set R2=$ZDATETIME($H)

	Return $$$OK
}

}
