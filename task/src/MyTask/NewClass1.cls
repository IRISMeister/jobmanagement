Class MyTask.NewClass1 Extends MyTask.SuperClass
{

Method Task(SessionId As %String = "", P1 As %String = "", P2 As %String = "", P3 As %String = "", P4 As %String = "", P5 As %String = "", ByRef R1 As %String = "", ByRef R2 As %String = "", ByRef R3 As %String = "") As %Status
{
	Set tSC=##super(SessionId, P1, P2, P3, P4, P5,.R1,.R2,.R3)
	#;実験用。P2値を処理にかかる時間(秒)として使用。
	If +P2>0 h P2

	Return $$$OK
}

}
