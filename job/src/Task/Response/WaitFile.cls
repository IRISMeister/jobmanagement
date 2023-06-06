Class Task.Response.WaitFile Extends Ens.Response
{

Property TaskStatus As %String;

Property TaskErrorMessage As %String(MAXLEN = 2000);

Property FileName As %String(MAXLEN = 2000);

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
<Value name="4">
<Value>TaskStatus</Value>
</Value>
<Value name="5">
<Value>TaskErrorMessage</Value>
</Value>
</Data>
<DefaultData>WaitFolderDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
