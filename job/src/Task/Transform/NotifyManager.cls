Class Task.Transform.NotifyManager Extends Ens.DataTransformDTL
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Ens.Alerting.NotificationRequest' targetClass='Ens.Alerting.Context.Notify' create='existing' language='objectscript' >
<assign value='"test@localhost.localdomain"' property='AlwaysEmail' action='set' />
<assign value='"test@localhost.localdomain"' property='ABCEmail' action='set' />
<assign value='"test@localhost.localdomain"' property='XYZEmail' action='set' />
<assign value='"test@localhost.localdomain"' property='EscalatedEmail' action='set' />
<assign value='"EnsLib.EMail.AlertOperation"' property='target.Targets.(1).TargetConfigName' action='set' />
<assign value='1' property='target.Notify' action='set' />
<assign value='AlwaysEmail' property='target.Targets.(1).AlertDestinations' action='append' />
<if condition='..Contains(source.ManagedAlert.AlertGroups,"TaskGroup")' >
<true>
<assign value='ABCEmail' property='target.Targets.(1).AlertDestinations' action='append' />
</true>
</if>
<if condition='..Contains(source.ManagedAlert.AlertGroups,"FileGroup")' >
<true>
<assign value='XYZEmail' property='target.Targets.(1).AlertDestinations' action='append' />
</true>
</if>
<if condition='source.ManagedAlert.EscalationLevel&gt;0' >
<true>
<assign value='EscalatedEmail' property='target.Targets.(1).AlertDestinations' action='append' />
</true>
</if>
</transform>
}

}
