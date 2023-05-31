/// Wait Folders
Class Task.Process.job5waitfile Extends Ens.BusinessProcessBPL [ ClassType = persistent, DependsOn = Task.Context.Custom, ProcedureBlock ]
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Task.Request.CallJob' response='Ens.Response' contextsuperclass='Task.Context.Custom' height='2000' width='2000' >
<sequence xend='200' yend='650' >
<call name='sendfile' target='Target1_SFTP' async='0' timeout='5' xpos='200' ypos='250' >
<annotation><![CDATA[ファイルを送信]]></annotation>
<request type='Ens.StreamContainer' >
<assign property="callrequest" value="context.CreateStreamContainer(&quot;/home/irisowner/outgoing/100.req.txt&quot;)" action="set" />
</request>
<response type='Ens.Response' />
</call>
<call name='call1' target='cWaitFile' async='1' xpos='200' ypos='350' >
<annotation><![CDATA[指定されたファイルを待つ]]></annotation>
<request type='Task.Request.WaitFile' >
<assign property="callrequest.FileName" value="&quot;/home/irisowner/incoming/in/100.res.txt&quot;" action="set" />
</request>
<response type='Task.Response.WaitFile' />
</call>
<sync calls='call1' type='all' xpos='200' ypos='450' />
<trace value='"BP処理再開"' xpos='200' ypos='550' />
</sequence>
</process>
}

}
