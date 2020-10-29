Class Task.Response.CallTaskStatus Extends Ens.Response
{

Property TaskName As %String;

Property TaskStatus As %String;

Property TaskErrorMessage As %String(MAXLEN = 2000);

Property R1 As %String;

Property R2 As %String;

Property R3 As %String;

Storage Default
{
<Data name="CallTaskStatusDefaultData">
<Subscript>"CallTaskStatus"</Subscript>
<Value name="1">
<Value>TaskName</Value>
</Value>
<Value name="2">
<Value>TaskStatus</Value>
</Value>
<Value name="3">
<Value>TaskErrorMessage</Value>
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
</Data>
<DefaultData>CallTaskStatusDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
