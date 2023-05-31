Class Task.Response.WaitFolder Extends Ens.Response
{

Property Folder As %String;

Property Files As list Of %String;

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
</Data>
<DefaultData>WaitFolderDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
