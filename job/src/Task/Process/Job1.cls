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
<sequence xend='200' yend='2450' >
<assign property="response.StartTime" value="$ZDATETIME($H,3)" action="set" xpos='200' ypos='250' disabled="true">
<annotation><![CDATA[タイムスタンプをメッセージに記録]]></annotation>
</assign>
<assign property="context.SessionId" value="request.%Id()" action="set" xpos='200' ypos='350' disabled="true">
<annotation><![CDATA[ターゲットに送るRESTに、ユニークID(プライマリメッセージのID)を付与することで、トラッキングを用意にすることを想定。]]></annotation>
</assign>
<code xpos='200' ypos='450' >
<annotation><![CDATA[Customコードの例。無効化してある上記のassignと同等の機能をコードで実現したもの。]]></annotation>
<![CDATA[ Do context.OnStart(request,response)]]>
</code>
<scope xpos='200' ypos='550' xend='200' yend='2250' >
<call name='task1' target='CallTask' async='0' xpos='200' ypos='650' >
<annotation><![CDATA[NewClass1@Target1,同期
]]></annotation>
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
<if condition='context.LastTaskStatus="OK"' xpos='200' ypos='750' xend='200' yend='1000' >
<annotation><![CDATA[タスクは正常終了したか？]]></annotation>
<false>
<throw fault='"TaskFault"' xpos='335' ypos='900' >
<annotation><![CDATA[例外を送出]]></annotation>
</throw>
</false>
</if>
<call name='task2' target='CallTask' async='0' xpos='200' ypos='1100' >
<annotation><![CDATA[NewClass2@Target2,同期
]]></annotation>
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
<if condition='context.LastTaskStatus="OK"' xpos='200' ypos='1200' xend='200' yend='1450' >
<false>
<throw fault='"TaskFault"' xpos='335' ypos='1350' />
</false>
</if>
<call name='task3' target='CallTask' async='0' xpos='200' ypos='1550' >
<annotation><![CDATA[NewClass3@Target2,同期+遅延]]></annotation>
<request type='Task.Request.CallTask' >
<assign property="callrequest.SessionId" value="context.SessionId" action="set" />
<assign property="callrequest.Target" value="&quot;Target2&quot;" action="set" />
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
<if condition='context.LastTaskStatus="OK"' xpos='200' ypos='1650' xend='200' yend='1900' >
<false>
<throw fault='"TaskFault"' xpos='335' ypos='1800' />
</false>
</if>
<assign property="response.JobStatus" value="&quot;OK&quot;" action="set" xpos='200' ypos='2000' >
<annotation><![CDATA[ジョブの実行結果をOKに設定]]></annotation>
</assign>
<faulthandlers>
<catchall xpos='200' ypos='2100' xend='200' yend='550' >
<annotation><![CDATA[例外をキャッチする箇所。ジョブの実行結果をNGに設定している。]]></annotation>
<trace value='"%LastError "_$System.Status.GetErrorCodes(..%Context.%LastError)_" : "_$System.Status.GetOneStatusText(..%Context.%LastError)' xpos='200' ypos='250' />
<assign property="response.JobStatus" value="&quot;NG&quot;" action="set" xpos='200' ypos='350' />
<assign property="response.JobErrorMessage" value="$System.Status.GetErrorCodes(..%Context.%LastError)_&quot;:&quot;_$System.Status.GetOneStatusText(..%Context.%LastError)" action="set" xpos='200' ypos='450' />
</catchall>
</faulthandlers>
</scope>
<assign property="response.EndTime" value="$ZDATETIME($H,3)" action="set" xpos='200' ypos='2350' >
<annotation><![CDATA[タイムスタンプをメッセージに記録]]></annotation>
</assign>
</sequence>
</process>
}

}
