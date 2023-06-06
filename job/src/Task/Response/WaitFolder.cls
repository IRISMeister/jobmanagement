Class Task.Response.WaitFolder Extends Ens.Response
{

Property TaskStatus As %String;

Property TaskErrorMessage As %String(MAXLEN = 2000);

Property Folder As %String(MAXLEN = 2000);

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
<Value name="3">
<Value>TaskStatus</Value>
</Value>
<Value name="4">
<Value>TaskErrorMessage</Value>
</Value>
</Data>
<DefaultData>WaitFolderDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
