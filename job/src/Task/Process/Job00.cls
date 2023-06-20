/// BPのテンプレート
Class Task.Process.Job00 Extends Ens.BusinessProcessBPL [ ClassType = persistent, DependsOn = Task.Context.Custom, ProcedureBlock ]
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Task.Request.CallJob' response='Task.Response.CallJob' contextsuperclass='Task.Context.Custom' height='2700' width='2000' >
<sequence xend='200' yend='900' >
<code xpos='200' ypos='250' >
<![CDATA[ Do context.OnStart(request,response)]]>
</code>
<scope xpos='200' ypos='350' xend='200' yend='700' >
<assign property="response.JobStatus" value="&quot;OK&quot;" action="set" xpos='200' ypos='450' >
<annotation><![CDATA[ジョブの実行結果をOKに設定]]></annotation>
</assign>
<faulthandlers>
<catchall xpos='200' ypos='550' xend='200' yend='550' >
<annotation><![CDATA[例外をキャッチする箇所。ジョブの実行結果をNGに設定している。]]></annotation>
<trace value='"%LastError "_$System.Status.GetErrorCodes(..%Context.%LastError)_" : "_$System.Status.GetOneStatusText(..%Context.%LastError)' xpos='200' ypos='250' />
<assign property="response.JobStatus" value="&quot;NG&quot;" action="set" xpos='200' ypos='350' />
<assign property="response.JobErrorMessage" value="$System.Status.GetErrorCodes(..%Context.%LastError)_&quot;:&quot;_$System.Status.GetOneStatusText(..%Context.%LastError)" action="set" xpos='200' ypos='450' />
</catchall>
</faulthandlers>
</scope>
<assign property="response.EndTime" value="$ZDATETIME($H,3)" action="set" xpos='200' ypos='800' >
<annotation><![CDATA[タイムスタンプをメッセージに記録]]></annotation>
</assign>
</sequence>
</process>
}

}
