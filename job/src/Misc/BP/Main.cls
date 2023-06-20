/// 
Class Misc.BP.Main Extends Ens.BusinessProcessBPL [ ClassType = persistent, ProcedureBlock ]
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<sequence xend='200' yend='550' >
<trace value='$JOB' xpos='200' ypos='250' />
<code name='I need FIFO!' xpos='200' ypos='350' >
<annotation><![CDATA[Do process.SendRequestSync()
]]></annotation>
<![CDATA[ Do process.SendRequestSync("Sub",request,.res)
]]>
</code>
<trace value='$JOB' xpos='200' ypos='450' />
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
