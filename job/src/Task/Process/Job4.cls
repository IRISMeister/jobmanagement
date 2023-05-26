/// 
Class Task.Process.Job4 Extends Ens.BusinessProcessBPL [ ClassType = persistent, DependsOn = Task.Context.Custom, ProcedureBlock ]
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Task.Request.CallJob' response='Task.Response.CallJob' contextsuperclass='Task.Context.Custom' height='2700' width='2000' >
<context>
<property name='wfTaskResponse' type='EnsLib.Workflow.TaskResponse' instantiate='0' />
</context>
<sequence xend='200' yend='1900' >
<code xpos='200' ypos='250' >
<![CDATA[ Do context.OnStart(request,response)]]>
</code>
<scope xpos='200' ypos='350' xend='200' yend='1700' >
<call name='task1' target='CallTask' async='0' xpos='200' ypos='450' >
<annotation><![CDATA[NewClass1@Target1,同期]]></annotation>
<request type='Task.Request.CallTask' >
<assign property="callrequest.SessionId" value="context.SessionId" action="set" />
<assign property="callrequest.Target" value="&quot;Target1&quot;" action="set" />
<assign property="callrequest.TaskName" value="&quot;MyTask.NewClass1&quot;" action="set" />
<assign property="callrequest.P1" value="request.P1" action="set" />
<assign property="callrequest.P2" value="request.P2" action="set" />
<assign property="callrequest.P3" value="request.P3" action="set" />
<assign property="callrequest.P4" value="request.P4" action="set" />
<assign property="callrequest.P5" value="request.P5" action="set" />
</request>
<response type='Task.Response.CallTaskStatus' >
<assign property="context.LastTaskStatus" value="callresponse.TaskStatus" action="set" />
<assign property="context.LastTaskName" value="callresponse.TaskName" action="set" />
<assign property="context.R1" value="callresponse.R1" action="set" />
<assign property="context.R2" value="callresponse.R2" action="set" />
<assign property="context.R3" value="callresponse.R3" action="set" />
</response>
</call>
<if condition='context.LastTaskStatus="OK"' xpos='200' ypos='550' xend='200' yend='800' >
<annotation><![CDATA[タスクは正常終了したか？]]></annotation>
<false>
<throw fault='"TaskFault"' xpos='335' ypos='700' >
<annotation><![CDATA[例外を送出]]></annotation>
</throw>
</false>
</if>
<sequence xpos='200' ypos='900' xend='200' yend='450' >
<annotation><![CDATA[処理保留及び保留解除のためのシーケンス]]></annotation>
<call name='WF Ask Operator' target='Operator' async='1' xpos='200' ypos='250' >
<request type='EnsLib.Workflow.TaskRequest' >
<assign property="callrequest.%Actions" value="&quot;保留解除&quot;" action="set" />
<assign property="callrequest.%Subject" value="&quot;タスクは保留中です。&quot;" action="set" />
<assign property="callrequest.%FormFields" value="&quot;Comment&quot;" action="set" />
<assign property="callrequest.%FormTemplate" value="&quot;WFFormTemplate.csp&quot;" action="set" />
</request>
<response type='EnsLib.Workflow.TaskResponse' >
<assign property="context.wfTaskResponse" value="callresponse" action="set" />
</response>
</call>
<sync name='sync' calls='WF Ask Operator' type='all' xpos='200' ypos='350' />
</sequence>
<call name='task2' target='CallTask' async='0' xpos='200' ypos='1000' >
<annotation><![CDATA[NewClass2@Target1,同期]]></annotation>
<request type='Task.Request.CallTask' >
<assign property="callrequest.SessionId" value="context.SessionId" action="set" />
<assign property="callrequest.Target" value="&quot;Target1&quot;" action="set" />
<assign property="callrequest.TaskName" value="&quot;MyTask.NewClass2&quot;" action="set" />
<assign property="callrequest.P1" value="request.P1" action="set" />
<assign property="callrequest.P2" value="request.P2" action="set" />
<assign property="callrequest.P3" value="request.P3" action="set" />
<assign property="callrequest.P4" value="request.P4" action="set" />
<assign property="callrequest.P5" value="request.P5" action="set" />
</request>
<response type='Task.Response.CallTaskStatus' >
<assign property="context.LastTaskStatus" value="callresponse.TaskStatus" action="set" />
<assign property="context.LastTaskName" value="callresponse.TaskName" action="set" />
<assign property="context.R1" value="callresponse.R1" action="set" />
<assign property="context.R2" value="callresponse.R2" action="set" />
<assign property="context.R3" value="callresponse.R3" action="set" />
</response>
</call>
<if condition='context.LastTaskStatus="OK"' xpos='200' ypos='1100' xend='200' yend='1350' >
<false>
<throw fault='"TaskFault"' xpos='335' ypos='1250' />
</false>
</if>
<assign property="response.JobStatus" value="&quot;OK&quot;" action="set" xpos='200' ypos='1450' >
<annotation><![CDATA[ジョブの実行結果をOKに設定]]></annotation>
</assign>
<faulthandlers>
<catchall xpos='200' ypos='1550' xend='200' yend='550' >
<annotation><![CDATA[例外をキャッチする箇所。ジョブの実行結果をNGに設定している。]]></annotation>
<trace value='"%LastError "_$System.Status.GetErrorCodes(..%Context.%LastError)_" : "_$System.Status.GetOneStatusText(..%Context.%LastError)' xpos='200' ypos='250' />
<assign property="response.JobStatus" value="&quot;NG&quot;" action="set" xpos='200' ypos='350' />
<assign property="response.JobErrorMessage" value="$System.Status.GetErrorCodes(..%Context.%LastError)_&quot;:&quot;_$System.Status.GetOneStatusText(..%Context.%LastError)" action="set" xpos='200' ypos='450' />
</catchall>
</faulthandlers>
</scope>
<assign property="response.EndTime" value="$ZDATETIME($H,3)" action="set" xpos='200' ypos='1800' >
<annotation><![CDATA[タイムスタンプをメッセージに記録]]></annotation>
</assign>
</sequence>
</process>
}

}
