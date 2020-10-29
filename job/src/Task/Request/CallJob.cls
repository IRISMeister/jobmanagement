Class Task.Request.CallJob Extends Ens.Request
{

Property JobName As %String;

Property P1 As %String;

Property P2 As %String;

Property P3 As %String;

Property P4 As %String;

Property P5 As %String;

Storage Default
{
<Data name="CallJobDefaultData">
<Subscript>"CallJob"</Subscript>
<Value name="1">
<Value>JobName</Value>
</Value>
<Value name="2">
<Value>P1</Value>
</Value>
<Value name="3">
<Value>P2</Value>
</Value>
<Value name="4">
<Value>P3</Value>
</Value>
<Value name="5">
<Value>P4</Value>
</Value>
<Value name="6">
<Value>P5</Value>
</Value>
</Data>
<DefaultData>CallJobDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
