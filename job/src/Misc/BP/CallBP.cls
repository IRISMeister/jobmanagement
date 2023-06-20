/// 
Class Misc.BP.CallBP Extends Ens.BusinessProcessBPL [ ClassType = persistent, ProcedureBlock ]
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<sequence xend='200' yend='950' >
<trace value='"main seq start"' xpos='200' ypos='250' />
<trace value='"Call seq#1 start"' xpos='200' ypos='350' />
<call name='call1' target='cBP' async='1' xpos='200' ypos='450' >
<annotation><![CDATA[cBPコール]]></annotation>
<request type='Ens.Request' />
<response type='Ens.Response' />
</call>
<trace value='"Call seq#2 start"' xpos='200' ypos='550' />
<call name='call2' target='cBP' async='1' xpos='200' ypos='650' >
<annotation><![CDATA[cBPコール]]></annotation>
<request type='Ens.Request' />
<response type='Ens.Response' />
</call>
<sync calls='call1,call2' type='all' xpos='200' ypos='750' >
<annotation><![CDATA[call1, call2完了待ち]]></annotation>
</sync>
<trace value='"main seq end"' xpos='200' ypos='850' />
</sequence>
</process>
}

}
