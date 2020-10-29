/// エージェント機能を提供するWebService
Class Task.WS.Main Extends %SOAP.WebService [ ProcedureBlock ]
{

/// ウェブサービスの名前.
Parameter SERVICENAME = "Main";

/// TODO: これを実際のSOAPネームスペースに変更します。
/// ウェブサービス用のSOAPネームスペース
Parameter NAMESPACE = "http://tempuri.org";

/// 参照されているクラスのネームスペースは WSDL に使用されます。
Parameter USECLASSNAMESPACES = 1;

/// TODO: 引数および実装を追加します。
/// Test
Method RunTask(SessionId As %String, Taskname As %String, Token As %String, Deferred As %Boolean, P1 As %String, P2 As %String, P3 As %String, P4 As %String, P5 As %String) As %Status [ WebMethod ]
{
	#;エージェント側での処理をJOB実行するか、自分(CSP実行プロセス)で実行するか。
	If Deferred=0 {
		Return $classmethod(Taskname,"Exec",SessionId,Token,P1,P2,P3,P4,P5)
	}
	Job $classmethod(Taskname,"Exec",SessionId,Token,P1,P2,P3,P4,P5)
	Return $$$OK
}

}
