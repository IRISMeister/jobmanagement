Class User.Timing
{

ClassMethod Exec(SessionId As %String, Token As %String, P1 As %String = "", P2 As %String = "", P3 As %String = "", P4 As %String = "", P5 As %String = "") As %Status
{
	Set ^Timing($INCREMENT(^Timing))=$LISTBUILD($ZDATETIME($H),$classname(),SessionId,P1,P2,P3,P4,P5)
	;Set ^Timing=$G(^Timing)+1
	Return $$$OK
}

}
