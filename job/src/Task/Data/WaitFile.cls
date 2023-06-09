/// 
Class Task.Data.WaitFile Extends %Persistent [ ClassType = persistent, DdlAllowed, Final, Owner = {_SYSTEM}, ProcedureBlock, SqlRowIdPrivate ]
{

Property FileName As %Library.String(MAXLEN = 200) [ SqlColumnNumber = 2 ];

Property Token As %Library.String(MAXLEN = 50) [ SqlColumnNumber = 3 ];

Property TargetHostName As %String;

/// DDL Primary Key Specification
Index WAITFILEPKEY1 On (FileName, TargetHostName) [ PrimaryKey, SqlName = WAITFILE_PKEY1, Type = index, Unique ];

Storage Default
{
<Data name="WaitFileDefaultData">
<Value name="1">
<Value>FileName</Value>
</Value>
<Value name="2">
<Value>Token</Value>
</Value>
<Value name="3">
<Value>TargetHostName</Value>
</Value>
</Data>
<DataLocation>^Task.Data.WaitFileD</DataLocation>
<DefaultData>WaitFileDefaultData</DefaultData>
<IdLocation>^Task.Data.WaitFileD</IdLocation>
<IndexLocation>^Task.Data.WaitFileI</IndexLocation>
<StreamLocation>^Task.Data.WaitFileS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
