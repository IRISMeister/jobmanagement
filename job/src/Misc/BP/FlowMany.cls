/// 
Class Misc.BP.FlowMany Extends Ens.BusinessProcessBPL [ ClassType = persistent, ProcedureBlock ]
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<sequence xend='200' yend='1200' >
<trace value='"main seq start"' xpos='200' ypos='250' />
<flow xpos='200' ypos='350' xend='200' yend='1000' >
<sequence >
<trace value='"sub seq#1 start"' xpos='200' ypos='500' />
<call name='call1' target='cBPNoOp01' async='0' xpos='200' ypos='600' >
<annotation><![CDATA[OP呼び出し]]></annotation>
<request type='Ens.Request' />
<response type='Ens.Response' />
</call>
<trace value='"sub seq#1 end"' xpos='200' ypos='700' />
</sequence>
<sequence >
<trace value='"sub seq#2 start"' xpos='470' ypos='500' />
<call name='call2' target='cBPNoOp02' async='0' xpos='470' ypos='600' >
<annotation><![CDATA[OP呼び出し]]></annotation>
<request type='Ens.Request' />
<response type='Ens.Response' />
</call>
<trace value='"sub seq#2 end"' xpos='470' ypos='700' />
</sequence>

<sequence >
<trace value='"sub seq#3 start"' xpos='470' ypos='500' />
<call name='call3' target='cBPNoOp03' async='0' xpos='470' ypos='600' >
<annotation><![CDATA[OP呼び出し]]></annotation>
<request type='Ens.Request' />
<response type='Ens.Response' />
</call>
<trace value='"sub seq#3 end"' xpos='470' ypos='700' />
</sequence>
<sequence >
<trace value='"sub seq#4 start"' xpos='470' ypos='500' />
<call name='call4' target='cBPNoOp04' async='0' xpos='470' ypos='600' >
<annotation><![CDATA[OP呼び出し]]></annotation>
<request type='Ens.Request' />
<response type='Ens.Response' />
</call>
<trace value='"sub seq#4 end"' xpos='470' ypos='700' />
</sequence>
<sequence >
<trace value='"sub seq#5 start"' xpos='470' ypos='500' />
<call name='call5' target='cBPNoOp05' async='0' xpos='470' ypos='600' >
<annotation><![CDATA[OP呼び出し]]></annotation>
<request type='Ens.Request' />
<response type='Ens.Response' />
</call>
<trace value='"sub seq#5 end"' xpos='470' ypos='700' />
</sequence>
<sequence >
<trace value='"sub seq#6 start"' xpos='470' ypos='500' />
<call name='call6' target='cBPNoOp06' async='0' xpos='470' ypos='600' >
<annotation><![CDATA[OP呼び出し]]></annotation>
<request type='Ens.Request' />
<response type='Ens.Response' />
</call>
<trace value='"sub seq#6 end"' xpos='470' ypos='700' />
</sequence>
<sequence >
<trace value='"sub seq#7 start"' xpos='470' ypos='500' />
<call name='call7' target='cBPNoOp07' async='0' xpos='470' ypos='600' >
<annotation><![CDATA[OP呼び出し]]></annotation>
<request type='Ens.Request' />
<response type='Ens.Response' />
</call>
<trace value='"sub seq#7 end"' xpos='470' ypos='700' />
</sequence>
<sequence >
<trace value='"sub seq#8 start"' xpos='470' ypos='500' />
<call name='call8' target='cBPNoOp08' async='0' xpos='470' ypos='600' >
<annotation><![CDATA[OP呼び出し]]></annotation>
<request type='Ens.Request' />
<response type='Ens.Response' />
</call>
<trace value='"sub seq#8 end"' xpos='470' ypos='700' />
</sequence>
<sequence >
<trace value='"sub seq#9 start"' xpos='470' ypos='500' />
<call name='call9' target='cBPNoOp09' async='0' xpos='470' ypos='600' >
<annotation><![CDATA[OP呼び出し]]></annotation>
<request type='Ens.Request' />
<response type='Ens.Response' />
</call>
<trace value='"sub seq#9 end"' xpos='470' ypos='700' />
</sequence>
<sequence >
<trace value='"sub seq#10 start"' xpos='470' ypos='500' />
<call name='call10' target='cBPNoOp10' async='0' xpos='470' ypos='600' >
<annotation><![CDATA[OP呼び出し]]></annotation>
<request type='Ens.Request' />
<response type='Ens.Response' />
</call>
<trace value='"sub seq#10 end"' xpos='470' ypos='700' />
</sequence>


<sequence >
<trace value='"sub seq#99 start"' xpos='740' ypos='500' />
<call name='call99a' target='WaitSecs' async='1' xpos='740' ypos='600' >
<annotation><![CDATA[OP呼び出し]]></annotation>
<request type='Ens.StringRequest' >
<assign property="callrequest.StringValue" value="5" action="set" />
</request>
<response type='Ens.Response' />
</call>
<call name='call99b' target='WaitSecs' async='1' xpos='740' ypos='700' >
<annotation><![CDATA[OP呼び出し]]></annotation>
<request type='Ens.StringRequest' >
<assign property="callrequest.StringValue" value="3" action="set" />
</request>
<response type='Ens.Response' />
</call>
<sync name='sync' calls='call99a,call99b' type='all' xpos='740' ypos='800' />
<trace value='"sub seq#99 end"' xpos='740' ypos='900' />
</sequence>
</flow>
<trace value='"main seq end"' xpos='200' ypos='1100' />
</sequence>
</process>
}

}
