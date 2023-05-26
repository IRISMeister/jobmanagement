/// 
Class DeadLock.BP.Main2 Extends Ens.BusinessProcessBPL [ ClassType = persistent, ProcedureBlock ]
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<sequence xend='200' yend='550' >
<trace value='$JOB' xpos='200' ypos='250' />
<call name='Sync' target='Sub' async='0' xpos='200' ypos='350' >
<request type='Ens.Request' />
<response type='Ens.Response' />
</call>
<trace value='$JOB' xpos='200' ypos='450' />
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
