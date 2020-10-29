/// 
Class Task.Process.CallTask Extends Ens.BusinessProcessBPL [ ClassType = persistent, ProcedureBlock ]
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Task.Request.CallTask' response='Task.Response.CallTaskStatus' height='2850' width='2000' >
<context>
<property name='TaskName' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='TaskStatus' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='wfTaskResponse' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='TaskErrorMessage' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='2000' />
</parameters>
</property>
<property name='R1' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='R2' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='R3' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
</context>
<sequence xend='200' yend='2600' >
<trace value='"Comp.Task entered"' xpos='200' ypos='250' disabled="true"/>
<label name='start' xpos='200' ypos='350' />
<call name='task' target='@request.Target' async='0' timeout='60' xpos='200' ypos='450' >
<request type='Task.Request.CallTask' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='Task.Response.CallTask' >
<assign property="context.TaskStatus" value="callresponse.TaskStatus" action="set" />
<assign property="context.TaskErrorMessage" value="callresponse.TaskErrorMessage" action="set" />
<assign property="context.TaskName" value="request.TaskName" action="set" />
<assign property="context.R1" value="callresponse.R1" action="set" />
<assign property="context.R2" value="callresponse.R2" action="set" />
<assign property="context.R3" value="callresponse.R3" action="set" />
</response>
</call>
<if condition='context.TaskStatus="OK"' xpos='200' ypos='550' xend='200' yend='1900' >
<false>
<if condition='synctimedout=0' xpos='335' ypos='700' xend='335' yend='950' >
<annotation><![CDATA[Callのタイムアウトかどうかの判定]]></annotation>
<false>
<assign property="context.TaskErrorMessage" value="&quot;Callがタイムアウト&quot;" action="set" xpos='470' ypos='850' />
</false>
</if>
<alert value='context.TaskErrorMessage' xpos='335' ypos='1050' disabled="true">
<annotation><![CDATA[Alertはエラー発生源発行させるので無効化]]></annotation>
</alert>
<call name='WF Ask Operator' target='Operator' async='1' xpos='335' ypos='1150' >
<request type='EnsLib.Workflow.TaskRequest' >
<assign property="callrequest.%Actions" value="&quot;再実行,継続,中止&quot;" action="set" />
<assign property="callrequest.%Subject" value="&quot;ジョブでエラー発生。対処願います。&quot;" action="set" />
<assign property="callrequest.%Message" value="context.TaskErrorMessage" action="set" />
<assign property="callrequest.%FormFields" value="&quot;Comment&quot;" action="set" />
<assign property="callrequest.%FormTemplate" value="&quot;WFFormTemplate.csp&quot;" action="set" />
</request>
<response type='EnsLib.Workflow.TaskResponse' >
<assign property="context.wfTaskResponse" value="callresponse" action="set" />
</response>
</call>
<sync name='sync' calls='WF Ask Operator' type='all' xpos='335' ypos='1250' />
<trace value='context.wfTaskResponse.%Action' xpos='335' ypos='1350' />
<if condition='context.wfTaskResponse.%Action="中止"' xpos='335' ypos='1450' xend='335' yend='1800' >
<annotation><![CDATA[中止なら]]></annotation>
<true>
<assign property="context.TaskStatus" value="&quot;Abort&quot;" action="set" xpos='335' ypos='1600' />
</true>
<false>
<branch name='b1' condition='context.wfTaskResponse.%Action="再実行"' label='start' xpos='605' ypos='1600' >
<annotation><![CDATA[中止を実装可能か？]]></annotation>
</branch>
<assign property="context.TaskStatus" value="&quot;OK&quot;" action="set" xpos='605' ypos='1700' >
<annotation><![CDATA[Taskのステータスを"OK"に設定
]]></annotation>
</assign>
</false>
</if>
</false>
</if>
<assign property="response.TaskStatus" value="context.TaskStatus" action="set" xpos='200' ypos='2000' >
<annotation><![CDATA[Responseへの値設定]]></annotation>
</assign>
<assign property="response.TaskName" value="context.TaskName" action="set" xpos='200' ypos='2100' >
<annotation><![CDATA[Responseへの値設定]]></annotation>
</assign>
<assign property="response.R1" value="context.R1" action="set" xpos='200' ypos='2200' >
<annotation><![CDATA[Responseへの値設定]]></annotation>
</assign>
<assign property="response.R2" value="context.R2" action="set" xpos='200' ypos='2300' >
<annotation><![CDATA[Responseへの値設定]]></annotation>
</assign>
<assign property="response.R3" value="context.R3" action="set" xpos='200' ypos='2400' >
<annotation><![CDATA[Responseへの値設定]]></annotation>
</assign>
<label name='end' xpos='200' ypos='2500' >
<annotation><![CDATA[このあたりで正常終了したタスクの結果をどこかに登録したほうが良い？
Task.Response.CallTask,Task_WS.CallTaskResponseで代替は可能]]></annotation>
</label>
</sequence>
</process>
}

}
