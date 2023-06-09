Class Task.Request.WaitFolder Extends Ens.Request
{

Property TargetHostName As %String;

Property FolderName As %String;

Storage Default
{
<Data name="WaitFolderDefaultData">
<Subscript>"WaitFolder"</Subscript>
<Value name="1">
<Value>TargetHostName</Value>
</Value>
<Value name="2">
<Value>FolderName</Value>
</Value>
</Data>
<DefaultData>WaitFolderDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
