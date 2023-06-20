/// Wait Folders
Class Task.Process.job08RemoteFile Extends Ens.BusinessProcessBPL [ ClassType = persistent, DependsOn = Task.Context.Custom, ProcedureBlock ]
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Task.Request.CallJob' response='Task.Response.CallJob' contextsuperclass='Task.Context.Custom' height='2000' width='2000' layout='manual' >
<sequence xpos='200' ypos='150' xend='200' yend='1250' >
<code xpos='200' ypos='250' >
<annotation><![CDATA[初期化]]></annotation>
<![CDATA[ Do context.OnStart(request,response)]]>
</code>
<scope xpos='200' ypos='350' xend='200' yend='1050' >
<call name='call1' target='cWaitFile' async='0' xpos='200' ypos='450' >
<annotation><![CDATA[指定されたファイルを待つ]]></annotation>
<request type='Task.Request.WaitFile' >
<assign property="callrequest.FileName" value="&quot;/home/irisowner/outgoing/100.res.txt&quot;" action="set" />
<assign property="callrequest.TargetHostName" value="&quot;task1&quot;" action="set" />
</request>
<response type='Task.Response.WaitFile' >
<assign property="context.TaskStatus" value="callresponse.TaskStatus" action="set" />
<assign property="context.TaskErrorMessage" value="callresponse.TaskErrorMessage" action="set" />
<assign property="context.FileName" value="callresponse.FileName" action="set" />
</response>
</call>
<if condition='context.TaskStatus="OK"' xpos='200' ypos='550' xend='200' yend='800' >
<true>
<code xpos='470' ypos='700' >
<annotation><![CDATA[得たファイルを処理する]]></annotation>
<![CDATA[ ;Do ##class(%File).Delete(context.FileName)]]>
</code>
</true>
<false>
<throw fault='"JobFault:"_context.TaskErrorMessage' xpos='200' ypos='700' />
</false>
</if>
<faulthandlers>
<catchall xpos='200' ypos='900' xend='200' yend='700' >
<assign property="response.JobStatus" value="&quot;NG&quot;" action="set" xpos='200' ypos='250' />
<if condition='synctimedout=0' xpos='200' ypos='350' xend='200' yend='600' >
<annotation><![CDATA[timeoutしたか？]]></annotation>
<true>
<assign property="response.JobErrorMessage" value="$System.Status.GetErrorCodes(..%Context.%LastError)_&quot;:&quot;_$System.Status.GetOneStatusText(..%Context.%LastError)" action="set" xpos='470' ypos='500' />
</true>
<false>
<assign property="response.JobErrorMessage" value="&quot;timeout&quot;" action="set" xpos='200' ypos='500' />
</false>
</if>
</catchall>
</faulthandlers>
</scope>
<assign property="response.EndTime" value="$ZDATETIME($H,3)" action="set" xpos='200' ypos='1150' />
</sequence>
</process>
}

}
