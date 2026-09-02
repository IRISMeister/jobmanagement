/// 
Class Misc.BP.cBPNoOp Extends Ens.BusinessProcessBPL [ ClassType = persistent, ProcedureBlock ]
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
<call name='call' target='NoOp' async='0' xpos='200' ypos='350' >
<request type='Ens.Request' />
<response type='Ens.Response' />
</call>
</sequence>
</process>
}

}
