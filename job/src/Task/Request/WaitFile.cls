Class Task.Request.WaitFile Extends Ens.Request
{

Property FileName As %String;

Storage Default
{
<Data name="WaitFileDefaultData">
<Subscript>"WaitFile"</Subscript>
<Value name="1">
<Value>FileName</Value>
</Value>
</Data>
<DefaultData>WaitFileDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
