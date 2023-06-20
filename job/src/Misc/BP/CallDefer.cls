/// 
Class Misc.BP.CallDefer Extends Ens.BusinessProcessBPL [ ClassType = persistent, DependsOn = Misc.Context.Custom, ProcedureBlock ]
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' contextsuperclass='Misc.Context.Custom' height='2000' width='2000' >
<sequence xend='200' yend='550' >
<code xpos='200' ypos='250' >
<![CDATA[ Do context.OnStart()]]>
</code>
<call name='Sync' target='Defer' async='0' xpos='200' ypos='350' >
<request type='Ens.Request' />
<response type='Ens.Response' />
</call>
</sequence>
</process>
}

}
