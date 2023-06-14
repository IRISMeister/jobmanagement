/// Wait Folders
Class Task.Process.job6Files Extends Ens.BusinessProcessBPL [ ClassType = persistent, DependsOn = Task.Context.Custom, ProcedureBlock ]
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Task.Request.CallJob' response='Task.Response.CallJob' contextsuperclass='Task.Context.Custom' height='2000' width='2000' layout='manual' >
<sequence xpos='200' ypos='150' xend='200' yend='1300' >
<code xpos='200' ypos='250' >
<annotation><![CDATA[初期化]]></annotation>
<![CDATA[ Do context.OnStart(request,response)]]>
</code>
<scope xpos='200' ypos='350' xend='200' yend='1100' >
<call name='call1' target='cWaitFile' async='1' xpos='200' ypos='450' >
<annotation><![CDATA[指定されたファイルを待つ]]></annotation>
<request type='Task.Request.WaitFile' >
<assign property="callrequest.FileName" value="&quot;/home/sftp_user1/incoming/in/100.res.txt&quot;" action="set" />
<assign property="callrequest.TargetHostName" value="&quot;$local&quot;" action="set" />
</request>
<response type='Task.Response.WaitFile' >
<assign property="context.TaskStatus" value="callresponse.TaskStatus" action="set" />
<assign property="context.TaskErrorMessage" value="callresponse.TaskErrorMessage" action="set" />
<assign property="context.FileName" value="callresponse.FileName" action="set" />
</response>
</call>
<call name='call2' target='cWaitFile' async='1' xpos='200' ypos='550' >
<annotation><![CDATA[指定されたファイルを待つ]]></annotation>
<request type='Task.Request.WaitFile' >
<assign property="callrequest.FileName" value="&quot;/home/sftp_user1/incoming/in/200.res.txt&quot;" action="set" />
<assign property="callrequest.TargetHostName" value="&quot;$local&quot;" action="set" />
</request>
<response type='Task.Response.WaitFile' >
<assign property="context.TaskStatus" value="callresponse.TaskStatus" action="set" />
<assign property="context.TaskErrorMessage" value="callresponse.TaskErrorMessage" action="set" />
<assign property="context.FileName" value="callresponse.FileName" action="set" />
</response>
</call>
<call name='task1' target='cCallTask' async='0' xpos='200' ypos='650' >
<annotation><![CDATA[タスク実行(ファイルの作成を指示)]]></annotation>
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
<sync calls='call1,call2' type='all' xpos='200' ypos='750' >
<annotation><![CDATA[ファイル受信待ち]]></annotation>
</sync>
<foreach property='syncresponses' key='context.iterator' xpos='200' ypos='850' xend='200' yend='600' >
<annotation><![CDATA[エラーの有無確認]]></annotation>
<if condition='syncresponses.GetAt(context.iterator).TaskStatus="OK"' xpos='200' ypos='250' xend='200' yend='500' >
<false>
<throw fault='"JobFault:"_syncresponses.GetAt(context.iterator).TaskErrorMessage' xpos='335' ypos='400' />
</false>
</if>
</foreach>
<faulthandlers>
<catchall xpos='200' ypos='950' xend='200' yend='700' >
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
<assign property="response.EndTime" value="$ZDATETIME($H,3)" action="set" xpos='200' ypos='1200' />
</sequence>
</process>
}

}
