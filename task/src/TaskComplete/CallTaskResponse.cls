/// 次から作成されました: http://localhost:52773/csp/JOB/Task.Service.TaskComplete.cls?WSDL=1&IRISUserName=SuperUser
Class TaskComplete.CallTaskResponse Extends (%Persistent, %XML.Adaptor) [ ProcedureBlock ]
{

Parameter XMLNAME = "CallTaskResponse";

Parameter XMLSEQUENCE = 1;

Property SessionId As %String(MAXLEN = "", XMLNAME = "SessionId");

Property HostName As %String(MAXLEN = "", XMLNAME = "HostName");

Property TaskName As %String(MAXLEN = "", XMLNAME = "TaskName");

Property TaskStatus As %String(MAXLEN = "", XMLNAME = "TaskStatus");

Property TaskErrorMessage As %String(MAXLEN = 2000, XMLNAME = "TaskErrorMessage");

Property R1 As %String(MAXLEN = "", XMLNAME = "R1");

Property R2 As %String(MAXLEN = "", XMLNAME = "R2");

Property R3 As %String(MAXLEN = "", XMLNAME = "R3");

Property StartTime As %TimeStamp(XMLNAME = "StartTime");

Property EndTime As %TimeStamp(XMLNAME = "EndTime");

Property GlobalReferences As %Numeric(XMLNAME = "GlobalReferences");

Property LinesExecuted As %Numeric(XMLNAME = "LinesExecuted");

Storage Default
{
<Data name="CallTaskResponseDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>SessionId</Value>
</Value>
<Value name="3">
<Value>HostName</Value>
</Value>
<Value name="4">
<Value>TaskName</Value>
</Value>
<Value name="5">
<Value>TaskStatus</Value>
</Value>
<Value name="6">
<Value>TaskErrorMessage</Value>
</Value>
<Value name="7">
<Value>R1</Value>
</Value>
<Value name="8">
<Value>R2</Value>
</Value>
<Value name="9">
<Value>R3</Value>
</Value>
<Value name="10">
<Value>StartTime</Value>
</Value>
<Value name="11">
<Value>EndTime</Value>
</Value>
<Value name="12">
<Value>GlobalReferences</Value>
</Value>
<Value name="13">
<Value>LinesExecuted</Value>
</Value>
</Data>
<DataLocation>^TaskComplete.CallTaskResponseD</DataLocation>
<DefaultData>CallTaskResponseDefaultData</DefaultData>
<IdLocation>^TaskComplete.CallTaskResponseD</IdLocation>
<IndexLocation>^TaskComplete.CallTaskResponseI</IndexLocation>
<StreamLocation>^TaskComplete.CallTaskResponseS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
