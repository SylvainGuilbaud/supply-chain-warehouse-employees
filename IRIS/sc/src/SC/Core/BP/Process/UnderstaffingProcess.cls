/// Process for understaffing with a workflow included
Class SC.Core.BP.Process.UnderstaffingProcess Extends Ens.BusinessProcessBPL [ DependsOn = SC.Core.BP.IssueContext ]
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='SC.Core.BP.Message.IssueAnalysisRequest' response='Ens.Response' contextsuperclass='SC.Core.BP.IssueContext' height='2000' width='2000' >
<context>
<property name='action' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='taskId' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='deficit' type='SC.Core.Data.Internal.LaborDeficit' instantiate='0' />
<property name='penalty' type='%Integer' initialexpression='50000' instantiate='0' />
<property name='productId' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='locationId' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='date' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='optionA' type='SC.Core.Data.Internal.ActionScenario' instantiate='0' />
<property name='optionB' type='SC.Core.Data.Internal.ActionScenario' instantiate='0' />
<property name='optionC' type='SC.Core.Data.Internal.ActionScenario' instantiate='0' />
<property name='ruleResult' type='%Integer' instantiate='0' />
</context>
<sequence xend='200' yend='1350' >
<sequence name='Initialize the analysis' xpos='200' ypos='250' xend='200' yend='850' >
<assign name="Initialize context with issue" property="context.issueId" value="request.issueId" action="set" xpos='200' ypos='250' />
<code name='Initialize deficit' xpos='200' ypos='350' >
<![CDATA[ set context.deficit = context.getImpactedObject()]]>
</code>
<assign name="Initialize location" property="context.locationId" value="context.deficit.locationId" action="set" xpos='200' ypos='450' />
<assign name="Initialize product" property="context.productId" value="context.deficit.productId" action="set" xpos='200' ypos='550' />
<assign name="Initialize date" property="context.date" value="context.deficit.startDate" action="set" xpos='200' ypos='650' />
<assign name="Set process name" property="context.analysis.processName" value="request.targetProcess" action="set" xpos='200' ypos='750' />
</sequence>
<sequence name='Impact analysis' xpos='200' ypos='350' xend='200' yend='650' >
<assign name="Set severity" property="context.analysis.severity" value="$ZABS(40 \ 10)" action="set" xpos='200' ypos='250' />
<assign name="Set urgency" property="context.analysis.urgency" value="$ZABS(40 \ 10)" action="set" xpos='200' ypos='350' />
<assign name="Set impact analysis" property="context.analysis.impactAnalysis" value="&quot;13 customer orders with a value of €50000 at risk. &quot;" action="set" xpos='200' ypos='450' />
<assign name="Set root cause analysis" property="context.analysis.rootCauseAnalysis" value="&quot;Warehouse understaffed to meet forecasted labor needs.&quot;" action="set" xpos='200' ypos='550' />
</sequence>
<sequence name='Option A details' xpos='200' ypos='450' xend='200' yend='1350' >
<code name='Create option A' xpos='200' ypos='250' />
<assign name="Set option A name" property="context.newScenario.optionName" value="&quot;Option A&quot;" action="set" xpos='200' ypos='350' />
<assign name="Set option A number" property="context.newScenario.optionNumber" value="&quot;A&quot;" action="set" xpos='200' ypos='450' />
<assign name="Set option A description" property="context.newScenario.description" value="&quot;Do nothing and accept delays&quot;" action="set" xpos='200' ypos='550' />
<assign name="Set cost impact" property="context.newScenario.costImpact" value="0" action="set" xpos='200' ypos='650' />
<assign name="Set time impact" property="context.newScenario.timeImpact" value="-1 * context.deficit.quantity" action="set" xpos='200' ypos='750' />
<assign name="Set recommended" property="context.newScenario.recommended" value="0" action="set" xpos='200' ypos='850' />
<assign name="Set feasibility" property="context.newScenario.feasibility" value="1" action="set" xpos='200' ypos='950' />
<assign name="Add supporting data" property="context.newScenario.supportingData" value="&quot;Impact: Delayed orders risk serious customer satisfaction concerns. Not recommended. &quot;" action="set" xpos='200' ypos='1050' />
<assign name="Save option A" property="context.optionA" value="context.newScenario" action="set" xpos='200' ypos='1150' />
<code name='Add option A to analysis' xpos='200' ypos='1250' >
<![CDATA[ do context.addScenarioToAnalysis()]]>
</code>
</sequence>
<sequence name='Option B details' xpos='200' ypos='550' xend='200' yend='1350' >
<code name='Create option B' xpos='200' ypos='250' >
<![CDATA[ do context.createNewScenario()]]>
</code>
<assign name="Set option B name" property="context.newScenario.optionName" value="&quot;Option B&quot;" action="set" xpos='200' ypos='350' />
<assign name="Set option B number" property="context.newScenario.optionNumber" value="&quot;B&quot;" action="set" xpos='200' ypos='450' />
<assign name="Set option B description" property="context.newScenario.description" value="&quot;Offer temporary overtime to existing warehouse staff for the next month.&quot;" action="set" xpos='200' ypos='550' />
<assign name="Set cost impact" property="context.newScenario.costImpact" value="-1 * context.deficit.quantity * 70" action="set" xpos='200' ypos='650' />
<assign name="Set time impact" property="context.newScenario.timeImpact" value="0" action="set" xpos='200' ypos='750' />
<assign name="Set recommended" property="context.newScenario.recommended" value="0" action="set" xpos='200' ypos='850' />
<assign name="Set feasibility" property="context.newScenario.feasibility" value="1" action="set" xpos='200' ypos='950' />
<assign name="Add supporting data" property="context.newScenario.supportingData" value="&quot;Impact: Fulfillment will remain on time, at the added cost of overtime labor rates. Recommended given the short time of understaffing. &quot;" action="set" xpos='200' ypos='1050' />
<assign name="Save option B" property="context.optionB" value="context.newScenario" action="set" xpos='200' ypos='1150' />
<code name='Add option B to analysis' xpos='200' ypos='1250' >
<![CDATA[ do context.addScenarioToAnalysis()]]>
</code>
</sequence>
<sequence name='Option C details' xpos='200' ypos='650' xend='200' yend='1350' >
<code name='Create option C' xpos='200' ypos='250' >
<![CDATA[ do context.createNewScenario()]]>
</code>
<assign name="Set option name" property="context.newScenario.optionName" value="&quot;Option C&quot;" action="set" xpos='200' ypos='350' />
<assign name="Set option C number" property="context.newScenario.optionNumber" value="&quot;C&quot;" action="set" xpos='200' ypos='450' />
<assign name="Set option C description" property="context.newScenario.description" value="&quot;Hire outside contract labor&quot;" action="set" xpos='200' ypos='550' />
<assign name="Set cost impact" property="context.newScenario.costImpact" value="-1 * context.deficit.quantity * 45" action="set" xpos='200' ypos='650' />
<assign name="Set time impact" property="context.newScenario.timeImpact" value="-1 * context.deficit.quantity / 2" action="set" xpos='200' ypos='750' />
<assign name="Set recommended" property="context.newScenario.recommended" value="0" action="set" xpos='200' ypos='850' />
<assign name="Set feasibility" property="context.newScenario.feasibility" value="1" action="set" xpos='200' ypos='950' />
<assign name="Add supporting data" property="context.newScenario.supportingData" value="&quot;Impact: Minor delay to manufacturing and lower labor costs than overtime. Not recommended given the short time of understaffing and the expected hiring time. &quot;" action="set" xpos='200' ypos='1050' />
<assign name="Save option C" property="context.optionC" value="context.newScenario" action="set" xpos='200' ypos='1150' />
<code name='Add option C to analysis' xpos='200' ypos='1250' >
<![CDATA[ do context.addScenarioToAnalysis()]]>
</code>
</sequence>
<assign name="Ser recommendation" property="context.optionB.recommended" value="1" action="set" xpos='200' ypos='750' />
<code name='Save analysis to issue' xpos='200' ypos='850' >
<![CDATA[ do context.saveWorkflowAnalysisToIssue()]]>
</code>
<call name='Create workflow' target='Workflow Operation' async='1' xpos='200' ypos='950' >
<request type='EnsLib.Workflow.TaskRequest' >
<assign property="callrequest.%Actions" value="&quot;A,B,C&quot;" action="set" />
<assign property="callrequest.%Message" value="&quot;A. Do nothing; B. Offer overtime; C. Use outside contract labor&quot;" action="set" />
<assign property="callrequest.%Subject" value="&quot;User input required for issue &quot;_context.analysis.issueId" action="set" />
</request>
<response type='EnsLib.Workflow.TaskResponse' >
<assign property="context.action" value="callresponse.%Action" action="set" />
<assign property="context.taskId" value="callresponse.%Id()" action="set" />
</response>
</call>
<code name='Set workflowID' xpos='534' ypos='893' >
<![CDATA[ &SQL(Select top 1 id into :id from EnsLib_Workflow.TaskResponse ORDER BY id desc)
 set context.analysis.workflowId = id]]>
</code>
<sync name='On workflow response' calls='Create workflow' type='all' xpos='200' ypos='1150' />
<trace name='Trace the workflow response' value='context.taskId' xpos='200' ypos='1250' />
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
