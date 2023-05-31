/// job2からコールされることを想定。
Class Task.Process.Job2a Extends Ens.BusinessProcessBPL [ ClassType = persistent, DependsOn = Task.Context.Custom, ProcedureBlock ]
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Task.Request.CallJob' response='Task.Response.CallJob' contextsuperclass='Task.Context.Custom' height='2700' width='2000' >
<sequence xend='200' yend='1350' >
<code xpos='200' ypos='250' >
<![CDATA[ Do context.OnStart(request,response)]]>
</code>
<scope xpos='200' ypos='350' xend='200' yend='1150' >
<call name='task1' target='cCallTask' async='0' xpos='200' ypos='450' >
<annotation><![CDATA[SlowTask@Target1_REST,同期]]></annotation>
<request type='Task.Request.CallTask' >
<assign property="callrequest.SessionId" value="context.SessionId" action="set" />
<assign property="callrequest.Target" value="&quot;Target1_REST&quot;" action="set" />
<assign property="callrequest.TaskName" value="&quot;MyTask.SlowTask&quot;" action="set" />
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
<false>
<throw fault='"TaskFault"' xpos='335' ypos='700' />
</false>
</if>
<assign property="response.JobStatus" value="&quot;OK&quot;" action="set" xpos='200' ypos='900' />
<faulthandlers>
<catchall xpos='200' ypos='1000' xend='200' yend='450' >
<trace value='"Error Catched"' xpos='200' ypos='250' />
<assign property="response.JobStatus" value="&quot;NG&quot;" action="set" xpos='200' ypos='350' />
</catchall>
</faulthandlers>
</scope>
<assign property="response.EndTime" value="$ZDATETIME($H,3)" action="set" xpos='200' ypos='1250' />
</sequence>
</process>
}

}
