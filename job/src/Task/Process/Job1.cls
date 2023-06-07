/// 
Class Task.Process.Job1 Extends Ens.BusinessProcessBPL [ ClassType = persistent, DependsOn = Task.Context.Custom, ProcedureBlock ]
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Task.Request.CallJob' response='Task.Response.CallJob' contextsuperclass='Task.Context.Custom' height='2700' width='2000' >
<sequence xend='200' yend='2250' >
<code xpos='200' ypos='250' >
<annotation><![CDATA[初期化]]></annotation>
<![CDATA[ Do context.OnStart(request,response)]]>
</code>
<scope xpos='200' ypos='350' xend='200' yend='2050' >
<call name='task1' target='cCallTask' async='0' xpos='200' ypos='450' >
<annotation><![CDATA[NewClass1@Task1_REST,同期
]]></annotation>
<request type='Task.Request.CallTask' >
<assign property="callrequest.SessionId" value="context.SessionId" action="set" />
<assign property="callrequest.Target" value="&quot;Task1_REST&quot;" action="set" />
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
<call name='task2' target='cCallTask' async='0' xpos='200' ypos='900' >
<annotation><![CDATA[NewClass2@Task2_REST,同期
]]></annotation>
<request type='Task.Request.CallTask' >
<assign property="callrequest.SessionId" value="context.SessionId" action="set" />
<assign property="callrequest.Target" value="&quot;Task1_REST&quot;" action="set" />
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
<if condition='context.LastTaskStatus="OK"' xpos='200' ypos='1000' xend='200' yend='1250' >
<false>
<throw fault='"TaskFault"' xpos='335' ypos='1150' />
</false>
</if>
<call name='task3' target='cCallTask' async='0' xpos='200' ypos='1350' >
<annotation><![CDATA[NewClass3@Task2_REST,同期+遅延]]></annotation>
<request type='Task.Request.CallTask' >
<assign property="callrequest.SessionId" value="context.SessionId" action="set" />
<assign property="callrequest.Target" value="&quot;Task2_REST&quot;" action="set" />
<assign property="callrequest.TaskName" value="&quot;MyTask.NewClass3&quot;" action="set" />
<assign property="callrequest.P1" value="request.P1" action="set" />
<assign property="callrequest.P2" value="request.P2" action="set" />
<assign property="callrequest.P3" value="request.P3" action="set" />
<assign property="callrequest.P4" value="request.P4" action="set" />
<assign property="callrequest.P5" value="request.P5" action="set" />
<assign property="callrequest.Deferred" value="1" action="set" />
</request>
<response type='Task.Response.CallTaskStatus' >
<assign property="context.LastTaskStatus" value="callresponse.TaskStatus" action="set" />
<assign property="context.LastTaskName" value="callresponse.TaskName" action="set" />
<assign property="context.R1" value="callresponse.R1" action="set" />
<assign property="context.R2" value="callresponse.R2" action="set" />
<assign property="context.R3" value="callresponse.R3" action="set" />
</response>
</call>
<if condition='context.LastTaskStatus="OK"' xpos='200' ypos='1450' xend='200' yend='1700' >
<false>
<throw fault='"TaskFault"' xpos='335' ypos='1600' />
</false>
</if>
<assign property="response.JobStatus" value="&quot;OK&quot;" action="set" xpos='200' ypos='1800' >
<annotation><![CDATA[ジョブの実行結果をOKに設定]]></annotation>
</assign>
<faulthandlers>
<catchall xpos='200' ypos='1900' xend='200' yend='550' >
<annotation><![CDATA[例外をキャッチする箇所。ジョブの実行結果をNGに設定している。]]></annotation>
<trace value='"%LastError "_$System.Status.GetErrorCodes(..%Context.%LastError)_" : "_$System.Status.GetOneStatusText(..%Context.%LastError)' xpos='200' ypos='250' />
<assign property="response.JobStatus" value="&quot;NG&quot;" action="set" xpos='200' ypos='350' />
<assign property="response.JobErrorMessage" value="$System.Status.GetErrorCodes(..%Context.%LastError)_&quot;:&quot;_$System.Status.GetOneStatusText(..%Context.%LastError)" action="set" xpos='200' ypos='450' />
</catchall>
</faulthandlers>
</scope>
<assign property="response.EndTime" value="$ZDATETIME($H,3)" action="set" xpos='200' ypos='2150' >
<annotation><![CDATA[タイムスタンプをメッセージに記録]]></annotation>
</assign>
</sequence>
</process>
}

}
