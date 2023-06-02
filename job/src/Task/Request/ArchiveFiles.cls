Class Task.Request.ArchiveFiles Extends Ens.Request
{

Property Files As list Of %String;

Storage Default
{
<Data name="WaitFileDefaultData">
<Subscript>"WaitFile"</Subscript>
<Value name="1">
<Value>FileName</Value>
</Value>
<Value name="2">
<Value>Files</Value>
</Value>
</Data>
<DefaultData>WaitFileDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
