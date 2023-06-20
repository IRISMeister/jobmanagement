/// 
Class Misc.BP.Flow Extends Ens.BusinessProcessBPL [ ClassType = persistent, ProcedureBlock ]
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<sequence xend='200' yend='1100' >
<trace value='"main seq start"' xpos='200' ypos='250' />
<flow xpos='200' ypos='350' xend='200' yend='900' >
<sequence >
<trace value='"sub seq#1 start"' xpos='200' ypos='500' />
<call name='call1' target='Wait10Secs' async='0' xpos='200' ypos='600' >
<annotation><![CDATA[OP呼び出し]]></annotation>
<request type='Ens.Request' />
<response type='Ens.Response' />
</call>
<code xpos='200' ypos='700' >
<annotation><![CDATA[10秒かかる処理]]></annotation>
<![CDATA[ h 10]]>
</code>
<trace value='"sub seq#1 end"' xpos='200' ypos='800' />
</sequence>
<sequence >
<trace value='"sub seq#2 start"' xpos='470' ypos='500' />
<call name='call2' target='Wait10Secs' async='0' xpos='470' ypos='600' >
<annotation><![CDATA[OP呼び出し]]></annotation>
<request type='Ens.Request' />
<response type='Ens.Response' />
</call>
<code xpos='470' ypos='700' >
<annotation><![CDATA[10秒かかる処理]]></annotation>
<![CDATA[ h 10]]>
</code>
<trace value='"sub seq#2 end"' xpos='470' ypos='800' />
</sequence>
</flow>
<trace value='"main seq end"' xpos='200' ypos='1000' />
</sequence>
</process>
}

}
