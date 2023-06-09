/// 
Class Task.Data.WaitFolder Extends %Persistent [ ClassType = persistent, DdlAllowed, Final, Owner = {_SYSTEM}, ProcedureBlock, SqlRowIdPrivate ]
{

Property FolderName As %Library.String(MAXLEN = 200) [ SqlColumnNumber = 2 ];

Property Token As %Library.String(MAXLEN = 50) [ SqlColumnNumber = 3 ];

Property TargetHostName As %String;

/// DDL Primary Key Specification
Index WAITFOLDERPKEY1 On (FolderName, TargetHostName) [ PrimaryKey, SqlName = WAITFOLDER_PKEY1, Type = index, Unique ];

Storage Default
{
<Data name="WaitFolderDefaultData">
<Value name="1">
<Value>FolderName</Value>
</Value>
<Value name="2">
<Value>Token</Value>
</Value>
<Value name="3">
<Value>TargetHostName</Value>
</Value>
</Data>
<DataLocation>^Task.Data.WaitFolderD</DataLocation>
<DefaultData>WaitFolderDefaultData</DefaultData>
<IdLocation>^Task.Data.WaitFolderD</IdLocation>
<IndexLocation>^Task.Data.WaitFolderI</IndexLocation>
<StreamLocation>^Task.Data.WaitFolderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
