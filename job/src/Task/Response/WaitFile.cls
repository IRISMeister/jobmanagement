Class Task.Response.WaitFile Extends Ens.Response
{

Property FileName As %String;

Storage Default
{
<Data name="WaitFolderDefaultData">
<Subscript>"WaitFolder"</Subscript>
<Value name="1">
<Value>Folder</Value>
</Value>
<Value name="2">
<Value>Files</Value>
</Value>
<Value name="3">
<Value>FileName</Value>
</Value>
</Data>
<DefaultData>WaitFolderDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
