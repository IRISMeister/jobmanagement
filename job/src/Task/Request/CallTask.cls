Class Task.Request.CallTask Extends Ens.Request
{

Property SessionId As %String;

Property TaskName As %String;

Property Target As %String;

Property P1 As %String;

Property P2 As %String;

Property P3 As %String;

Property P4 As %String;

Property P5 As %String;

/// エージェント側での処理をJOB実行するか、自分(CSP実行プロセス)で実行するかを制御するフラグ
Property Deferred As %Boolean [ InitialExpression = "0" ];

Storage Default
{
<Data name="CallTaskDefaultData">
<Subscript>"CallTask"</Subscript>
<Value name="1">
<Value>SessionId</Value>
</Value>
<Value name="2">
<Value>TaskName</Value>
</Value>
<Value name="3">
<Value>Target</Value>
</Value>
<Value name="4">
<Value>P1</Value>
</Value>
<Value name="5">
<Value>P2</Value>
</Value>
<Value name="6">
<Value>P3</Value>
</Value>
<Value name="7">
<Value>P4</Value>
</Value>
<Value name="8">
<Value>P5</Value>
</Value>
<Value name="9">
<Value>Deferred</Value>
</Value>
</Data>
<DefaultData>CallTaskDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
