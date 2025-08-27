/// 
Class CGISC.Processes.CreateMfgOrder Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='CGISC.Requests.WorkOrderRequest' response='Ens.Response' height='2000' width='2000' >
<context>
<property name='exists' type='%Boolean' instantiate='0' />
<property name='MfgOrder' type='SC.Data.MfgOrder' instantiate='0' />
<property name='sc' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
</context>
<sequence xend='200' yend='1000' >
<code xpos='200' ypos='250' >
<![CDATA[ set context.MfgOrder = ##class(SC.Data.MfgOrder).uidIndexOpen(request.OrderId)
 if (context.MfgOrder = "")
 {
 set context.exists = 0
 }
 else
 {
 set context.exists = 1
 }]]>
</code>
<trace value='context.exists' xpos='200' ypos='350' />
<if condition='context.exists = 1' xpos='200' ypos='450' xend='200' yend='900' >
<true>
<code xpos='200' ypos='600' >
<![CDATA[ set context.MfgOrder.notes = request.EmployeeId
  set context.MfgOrder.actualStartDate = request.TimePickedUp
  set context.MfgOrder.actualEndDate = request.TimeDone
  set context.sc = context.MfgOrder.%Save()]]>
</code>
</true>
<false>
<transform class='CGISC.WorkOrderToMfgOrder' source='request' target='context.MfgOrder' xpos='470' ypos='600' />
<code xpos='470' ypos='700' >
<![CDATA[ set context.sc = context.MfgOrder.%Save()]]>
</code>
<trace value='context.sc' xpos='470' ypos='800' />
</false>
</if>
</sequence>
</process>
}

}
