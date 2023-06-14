Class DeadLock.Context.Custom Extends Ens.BP.Context
{

Property p1 As %String;

Property p2 As %String;

Property p3 As %Integer;

Method OnStart() As %Status
{
	Set $this.p1="abc"_$R(100)
	Set $this.p2="xyz"_$R(100)
	Set $this.p3=$R(10000)
	Return $$$OK
}

Storage Default
{
<Data name="CustomDefaultData">
<Subscript>"Custom"</Subscript>
<Value name="1">
<Value>p1</Value>
</Value>
<Value name="2">
<Value>p2</Value>
</Value>
<Value name="3">
<Value>p3</Value>
</Value>
</Data>
<DefaultData>CustomDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
