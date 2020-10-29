Class Task.WS.CallTaskResponse Extends (%RegisteredObject, %XML.Adaptor)
{

Property SessionId As %String;

Property HostName As %String;

Property TaskName As %String;

Property TaskStatus As %String;

Property TaskErrorMessage As %String(MAXLEN = 2000);

Property R1 As %String;

Property R2 As %String;

Property R3 As %String;

Property StartTime As %TimeStamp;

Property EndTime As %TimeStamp;

Property GlobalReferences As %Numeric(SCALE = 0);

Property LinesExecuted As %Numeric(SCALE = 0);

}
