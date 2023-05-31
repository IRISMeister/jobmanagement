/// BPのテンプレート
Class Task.Process.cWaitFolder Extends Ens.BusinessProcessBPL [ ClassType = persistent, ProcedureBlock ]
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Task.Request.WaitFolder' response='Task.Response.WaitFolder' height='2700' width='2000' >
<sequence xend='200' yend='800' >
<scope xpos='200' ypos='250' xend='200' yend='700' >
<call name='sendfile' target='Defer' async='0' xpos='200' ypos='350' >
<request type='Ens.Request' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='Ens.Response' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
<sql xpos='200' ypos='450' >
<![CDATA[DELETE FROM Task_Data.WaitFolder WHERE FolderName = :request.FolderName]]>
</sql>
<faulthandlers>
<catchall xpos='200' ypos='550' xend='200' yend='550' >
<annotation><![CDATA[例外をキャッチする箇所。ジョブの実行結果をNGに設定している。]]></annotation>
<trace value='"%LastError "_$System.Status.GetErrorCodes(..%Context.%LastError)_" : "_$System.Status.GetOneStatusText(..%Context.%LastError)' xpos='200' ypos='250' />
<assign property="response.JobStatus" value="&quot;NG&quot;" action="set" xpos='200' ypos='350' />
<assign property="response.JobErrorMessage" value="$System.Status.GetErrorCodes(..%Context.%LastError)_&quot;:&quot;_$System.Status.GetOneStatusText(..%Context.%LastError)" action="set" xpos='200' ypos='450' />
</catchall>
</faulthandlers>
</scope>
</sequence>
</process>
}

}
