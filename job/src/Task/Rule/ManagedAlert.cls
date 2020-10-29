/// 
Class Task.Rule.ManagedAlert Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "Ens.Alerting.Rule.CreateAlertAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="Ens.Alerting.Context.CreateAlert" production="">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="" disabled="false">
<when condition="IsRecentManagedAlert(AlertRequest,600,1)">
<return>0</return>
</when>
<when condition="AlertGroups=&quot;NotImportantAlertGroup&quot;">
<return>0</return>
</when>
<otherwise>
<return>1</return>
</otherwise>
</rule>
</ruleSet>
</ruleDefinition>
}

}
