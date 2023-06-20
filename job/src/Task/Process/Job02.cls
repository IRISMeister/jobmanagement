/// job02a,job02bを並列実行し、双方が正常終了した場合に、task1を起動する。
Class Task.Process.job02 Extends Ens.BusinessProcessBPL [ ClassType = persistent, DependsOn = Task.Context.Custom, ProcedureBlock ]
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Task.Request.CallJob' response='Task.Response.CallJob' contextsuperclass='Task.Context.Custom' height='2700' width='2000' >
<sequence xend='200' yend='1950' >
<code xpos='200' ypos='250' >
<![CDATA[ Do context.OnStart(request,response)]]>
</code>
<scope xpos='200' ypos='350' xend='200' yend='1750' >
<call name='job02a' target='job02a' async='1' xpos='200' ypos='450' >
<annotation><![CDATA[job02a,非同期]]></annotation>
<request type='Task.Request.CallJob' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='Task.Response.CallJob' />
</call>
<assign property="context.DelayParameter" value="&quot;PT5S&quot;" action="set" xpos='200' ypos='550' >
<annotation><![CDATA[job02bの呼び出しを実施する時間までの待ち時間をコンテキストに設定。実用にはなにがしかのロジック呼び出しを伴うと想定。]]></annotation>
</assign>
<delay until='context.DelayParameter' xpos='200' ypos='650' >
<annotation><![CDATA[待ち実行。実際には、Contextクラスにメソッドを定義して、そこから取得するほうが実用的。]]></annotation>
</delay>
<call name='job02b' target='job02b' async='1' xpos='200' ypos='750' >
<annotation><![CDATA[job02b,非同期]]></annotation>
<request type='Task.Request.CallJob' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='Task.Response.CallJob' />
</call>
<sync calls='job02a,job02b' type='all' xpos='200' ypos='850' >
<annotation><![CDATA[全てのJobの完了を待つ]]></annotation>
</sync>
<foreach property='syncresponses' key='context.iterator' xpos='200' ypos='950' xend='200' yend='600' >
<annotation><![CDATA[全てのJob呼び出し結果をテストする。正常終了出ない場合は、例外を送出。]]></annotation>
<if condition='syncresponses.GetAt(context.iterator).JobStatus="OK"' xpos='200' ypos='250' xend='200' yend='500' >
<false>
<throw fault='"JobFault"' xpos='335' ypos='400' />
</false>
</if>
</foreach>
<call name='task1' target='cCallTask' async='0' xpos='200' ypos='1050' >
<annotation><![CDATA[NewClass1@Task1_REST,同期]]></annotation>
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
<if condition='context.LastTaskStatus="OK"' xpos='200' ypos='1150' xend='200' yend='1400' >
<false>
<throw fault='"TaskFault"' xpos='335' ypos='1300' />
</false>
</if>
<assign property="response.JobStatus" value="&quot;OK&quot;" action="set" xpos='200' ypos='1500' />
<faulthandlers>
<catchall xpos='200' ypos='1600' xend='200' yend='550' >
<trace value='"%LastError "_$System.Status.GetErrorCodes(..%Context.%LastError)_" : "_$System.Status.GetOneStatusText(..%Context.%LastError)' xpos='200' ypos='250' />
<assign property="response.JobStatus" value="&quot;NG&quot;" action="set" xpos='200' ypos='350' />
<assign property="response.JobErrorMessage" value="$System.Status.GetErrorCodes(..%Context.%LastError)_&quot;:&quot;_$System.Status.GetOneStatusText(..%Context.%LastError)" action="set" xpos='200' ypos='450' />
</catchall>
</faulthandlers>
</scope>
<assign property="response.EndTime" value="$ZDATETIME($H,3)" action="set" xpos='200' ypos='1850' />
</sequence>
</process>
}

}
