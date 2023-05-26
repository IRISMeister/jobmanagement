Class Task.Context.Custom Extends Ens.BP.Context
{

Property JobStatus As %String(MAXLEN = 50);

Property LastTaskName As %String(MAXLEN = 50);

Property LastTaskStatus As %String(MAXLEN = 50);

Property R1 As %String(MAXLEN = 50);

Property R2 As %String(MAXLEN = 50);

Property R3 As %String(MAXLEN = 50);

Property SessionId As %Library.Numeric(SCALE = 0);

Property iterator As %String(MAXLEN = 50);

Property DelayParameter As %String(MAXLEN = 50);

Method OnStart(request, response) As %Status
{
	Set response.StartTime=$ZDATETIME($H,3)
	Set $this.SessionId=request.%Id()
	Return $$$OK
}

Method CreateStreamContainer(path) As %Stream.FileCharacter
{
	Set st=##class(%Stream.FileCharacter).%New()
	Set st.Filename=path ;"/home/irisowner/incoming/in/a.txt"
	Set sc=##class(Ens.StreamContainer).%New(st)
	Set sc.OriginalFilename=path
	Return sc
}

Storage Default
{
<Data name="CustomDefaultData">
<Subscript>"Custom"</Subscript>
<Value name="1">
<Value>JobStatus</Value>
</Value>
<Value name="2">
<Value>LastTaskName</Value>
</Value>
<Value name="3">
<Value>LastTaskStatus</Value>
</Value>
<Value name="4">
<Value>R1</Value>
</Value>
<Value name="5">
<Value>R2</Value>
</Value>
<Value name="6">
<Value>R3</Value>
</Value>
<Value name="7">
<Value>SessionId</Value>
</Value>
<Value name="8">
<Value>iterator</Value>
</Value>
<Value name="9">
<Value>DelayParameter</Value>
</Value>
</Data>
<DefaultData>CustomDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
