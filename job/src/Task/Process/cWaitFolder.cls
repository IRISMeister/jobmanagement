/// BPのテンプレート
Class Task.Process.cWaitFolder Extends Ens.BusinessProcessBPL [ ClassType = persistent, ProcedureBlock ]
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Task.Request.WaitFolder' response='Task.Response.WaitFolder' height='2700' width='2000' >
<context>
<property name='TaskStatus' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='TaskErrorMessage' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='2000' />
</parameters>
</property>
</context>
<sequence xend='200' yend='700' >
<call name='waitfolder' target='Defer' async='0' xpos='200' ypos='250' >
<request type='Task.Request.WaitFolder' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='Task.Response.WaitFolder' >
<assign property="response" value="callresponse" action="set" />
<assign property="context.TaskStatus" value="callresponse.TaskStatus" action="set" />
<assign property="context.TaskErrorMessage" value="callresponse.TaskErrorMessage" action="set" />
</response>
</call>
<if condition='context.TaskStatus="OK"' xpos='200' ypos='350' xend='200' yend='600' >
<annotation><![CDATA[オペレーションでエラーが発生した場合、応答がDeferredではない場合がある。]]></annotation>
<true>
<sql xpos='335' ypos='500' >
<annotation><![CDATA[成功時のみ削除]]></annotation>
<![CDATA[DELETE FROM Task_Data.WaitFolder WHERE FolderName = :request.FolderName]]>
</sql>
</true>
</if>
</sequence>
</process>
}

}
