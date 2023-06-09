Class Task.Request.WaitFile Extends Ens.Request
{

Property TargetHostName As %String;

Property FileName As %String;

Storage Default
{
<Data name="WaitFileDefaultData">
<Subscript>"WaitFile"</Subscript>
<Value name="1">
<Value>TargetHostName</Value>
</Value>
<Value name="2">
<Value>FileName</Value>
</Value>
</Data>
<DefaultData>WaitFileDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
