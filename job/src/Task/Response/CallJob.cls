Class Task.Response.CallJob Extends Ens.Response
{

Property JobStatus As %String;

Property JobErrorMessage As %String(MAXLEN = 2000);

Property StartTime As %TimeStamp;

Property EndTime As %TimeStamp;

Storage Default
{
<Data name="CallJobDefaultData">
<Subscript>"CallJob"</Subscript>
<Value name="1">
<Value>JobStatus</Value>
</Value>
<Value name="2">
<Value>JobErrorMessage</Value>
</Value>
<Value name="3">
<Value>StartTime</Value>
</Value>
<Value name="4">
<Value>EndTime</Value>
</Value>
</Data>
<DefaultData>CallJobDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
