/// 
Class Task.Process.Job3 Extends Ens.BusinessProcessBPL [ ClassType = persistent, DependsOn = Task.Context.Custom, ProcedureBlock ]
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Task.Request.CallJob' response='Task.Response.CallJob' contextsuperclass='Task.Context.Custom' height='2700' width='2000' >
<sequence xend='200' yend='1750' >
<code xpos='200' ypos='250' >
<annotation><![CDATA[Customコードの例。無効化してある上記のassignと同等の機能をコードで実現したもの。]]></annotation>
<![CDATA[ Do context.OnStart(request,response)]]>
</code>
<scope xpos='200' ypos='350' xend='200' yend='1550' >
<call name='task1' target='CallTask' async='1' xpos='200' ypos='450' >
<annotation><![CDATA[タスクを非同期で実行。]]></annotation>
<request type='Task.Request.CallTask' >
<assign property="callrequest.SessionId" value="context.SessionId" action="set" />
<assign property="callrequest.Target" value="&quot;Target1&quot;" action="set" />
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
<call name='task2' target='CallTask' async='1' xpos='200' ypos='550' >
<annotation><![CDATA[タスクを非同期で実行。]]></annotation>
<request type='Task.Request.CallTask' >
<assign property="callrequest.SessionId" value="context.SessionId" action="set" />
<assign property="callrequest.Target" value="&quot;Target1&quot;" action="set" />
<assign property="callrequest.TaskName" value="&quot;MyTask.FastTask&quot;" action="set" />
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
<sync calls='task1,task2' type='all' xpos='200' ypos='650' >
<annotation><![CDATA[全てのタスクの完了を待つ]]></annotation>
</sync>
<foreach property='syncresponses' key='context.iterator' xpos='200' ypos='750' xend='200' yend='600' >
<annotation><![CDATA[全てのタスク呼び出し結果をテストする。正常終了出ない場合は、例外を送出。]]></annotation>
<if condition='syncresponses.GetAt(context.iterator).TaskStatus="OK"' xpos='200' ypos='250' xend='200' yend='500' >
<false>
<throw fault='"TaskFault"' xpos='335' ypos='400' />
</false>
</if>
</foreach>
<call name='task3' target='CallTask' async='0' xpos='200' ypos='850' >
<annotation><![CDATA[タスクを同期で実行。]]></annotation>
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
<if condition='context.LastTaskStatus="OK"' xpos='200' ypos='950' xend='200' yend='1200' >
<annotation><![CDATA[タスクは正常終了したか？]]></annotation>
<false>
<throw fault='"TaskFault"' xpos='335' ypos='1100' >
<annotation><![CDATA[例外を送出]]></annotation>
</throw>
</false>
</if>
<assign property="response.JobStatus" value="&quot;OK&quot;" action="set" xpos='200' ypos='1300' >
<annotation><![CDATA[ジョブの実行結果をOKに設定]]></annotation>
</assign>
<faulthandlers>
<catchall xpos='200' ypos='1400' xend='200' yend='450' >
<annotation><![CDATA[例外をキャッチする箇所。ジョブの実行結果をNGに設定している。]]></annotation>
<trace value='"%LastError "_$System.Status.GetErrorCodes(..%Context.%LastError)_" : "_$System.Status.GetOneStatusText(..%Context.%LastError)' xpos='200' ypos='250' />
<assign property="response.JobStatus" value="&quot;NG&quot;" action="set" xpos='200' ypos='350' />
<assign property="response.JobErrorMessage" value="$System.Status.GetErrorCodes(..%Context.%LastError)_&quot;:&quot;_$System.Status.GetOneStatusText(..%Context.%LastError)" action="set" xpos='200' ypos='450' />
</catchall>
</faulthandlers>
</scope>
<assign property="response.EndTime" value="$ZDATETIME($H,3)" action="set" xpos='200' ypos='1650' >
<annotation><![CDATA[タイムスタンプをメッセージに記録]]></annotation>
</assign>
</sequence>
</process>
}

}
