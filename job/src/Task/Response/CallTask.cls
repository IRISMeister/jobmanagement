Class Task.Response.CallTask Extends Ens.Response
{

Property SessionId As %String;

Property HostName As %String;

Property TaskName As %String;

Property TaskStatus As %String;

Property TaskErrorMessage As %String(MAXLEN = 2000);

Property R1 As %String;

Property R2 As %String;

Property R3 As %String;

Property StartTime As %TimeStamp;

Property EndTime As %TimeStamp;

Property GlobalReferences As %Numeric(SCALE = 0);

Property LinesExecuted As %Numeric(SCALE = 0);

Storage Default
{
<Data name="CallTaskDefaultData">
<Subscript>"CallTask"</Subscript>
<Value name="1">
<Value>SessionId</Value>
</Value>
<Value name="2">
<Value>HostName</Value>
</Value>
<Value name="3">
<Value>TaskName</Value>
</Value>
<Value name="4">
<Value>TaskStatus</Value>
</Value>
<Value name="5">
<Value>TaskErrorMessage</Value>
</Value>
<Value name="6">
<Value>R1</Value>
</Value>
<Value name="7">
<Value>R2</Value>
</Value>
<Value name="8">
<Value>R3</Value>
</Value>
<Value name="9">
<Value>StartTime</Value>
</Value>
<Value name="10">
<Value>EndTime</Value>
</Value>
<Value name="11">
<Value>GlobalReferences</Value>
</Value>
<Value name="12">
<Value>LinesExecuted</Value>
</Value>
</Data>
<DefaultData>CallTaskDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
