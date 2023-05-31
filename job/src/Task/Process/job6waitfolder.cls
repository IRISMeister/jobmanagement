/// Wait Folders
Class Task.Process.job6waitfolder Extends Ens.BusinessProcessBPL [ ClassType = persistent, DependsOn = Task.Context.Custom, ProcedureBlock ]
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Task.Request.CallJob' response='Ens.Response' contextsuperclass='Task.Context.Custom' height='2000' width='2000' >
<sequence xend='200' yend='950' >
<trace value='"test"' xpos='200' ypos='250' disabled="true"/>
<call name='call1' target='cWaitFolder' async='1' xpos='200' ypos='350' >
<annotation><![CDATA[wait for folder1]]></annotation>
<request type='Task.Request.WaitFolder' >
<assign property="callrequest.FolderName" value="&quot;/home/irisowner/incoming/folder1/&quot;" action="set" />
</request>
<response type='Task.Response.WaitFolder' />
</call>
<call name='call2' target='cWaitFolder' async='1' xpos='200' ypos='450' >
<annotation><![CDATA[wait for folder2]]></annotation>
<request type='Task.Request.WaitFolder' >
<assign property="callrequest.FolderName" value="&quot;/home/irisowner/incoming/folder2/&quot;" action="set" />
</request>
<response type='Task.Response.WaitFolder' />
</call>
<sync calls='call1,call2' type='all' xpos='200' ypos='550' />
<foreach property='syncresponses' key='context.iterator'>
<assign property="context.Files" value="syncresponses.GetAt(context.iterator).Files" action="append" />
</foreach>
<code xpos='200' ypos='850' >
<![CDATA[ Do context.ProcessFiles()]]>
</code>
</sequence>
</process>
}

}
