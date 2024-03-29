Class Task.Context.Custom Extends Ens.BP.Context
{

Property FileName As %String(MAXLEN = 2000);

Property TaskStatus As %String(MAXLEN = 50);

Property TaskErrorMessage As %String(MAXLEN = 2000);

Property JobStatus As %String(MAXLEN = 50);

Property LastTaskName As %String(MAXLEN = 50);

Property LastTaskStatus As %String(MAXLEN = 50);

Property R1 As %String(MAXLEN = 50);

Property R2 As %String(MAXLEN = 50);

Property R3 As %String(MAXLEN = 50);

Property SessionId As %Library.Numeric(SCALE = 0);

Property iterator As %String(MAXLEN = 50);

Property DelayParameter As %String(MAXLEN = 50);

Property Files As list Of %String;

Property TargetFiles As list Of %String;

Method OnStart(request, response) As %Status
{
	Set response.StartTime=$ZDATETIME($H,3)
	Set $this.SessionId=request.%Id()
	Return $$$OK
}

ClassMethod CreateStreamContainer(path) As %Stream.FileCharacter
{
	Set st=##class(%Stream.FileCharacter).%New()
	Set st.Filename=path
	Set sc=##class(Ens.StreamContainer).%New(st)
	Set sc.OriginalFilename=path
	Return sc
}

Method ProcessFiles() As %Status
{
	#; ..Filesは<assign ... action="append>で更新しているので、その構造はリストのリスト、つまり
	#; ..Files=$LB($LB("file1","file2","file3"),$LB("file1","file2"))
	#; そのままでは扱いにくいので、フラットなリスト構造に変換する。
	Set folderCount=..Files.Count()
	For i=1:1:folderCount {
		Set fileCount=..Files.GetAt(i).Count()
		For j=1:1:fileCount {
			Set filename=..Files.GetAt(i).GetAt(j)
			Do ..TargetFiles.Insert(filename)
		}
	}
	Return $$$OK
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
<Value name="10">
<Value>Files</Value>
</Value>
<Value name="11">
<Value>TargetFiles</Value>
</Value>
<Value name="12">
<Value>TaskStatus</Value>
</Value>
<Value name="13">
<Value>TaskErrorMessage</Value>
</Value>
<Value name="14">
<Value>FileName</Value>
</Value>
</Data>
<DefaultData>CustomDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
