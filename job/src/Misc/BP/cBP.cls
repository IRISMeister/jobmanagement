/// 
Class Misc.BP.cBP Extends Ens.BusinessProcessBPL [ ClassType = persistent, ProcedureBlock ]
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<sequence xend='200' yend='650' >
<call name='call' target='Wait10Secs' async='0' xpos='200' ypos='350' >
<request type='Ens.Request' />
<response type='Ens.Response' />
</call>
<code xpos='200' ypos='450' >
<annotation><![CDATA[なにか10秒ほどかかる処理]]></annotation>
<![CDATA[ h 10]]>
</code>
</sequence>
</process>
}

}
