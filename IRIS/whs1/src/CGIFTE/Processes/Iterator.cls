/// 
Class CGIFTE.Processes.Iterator Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='CGIFTE.Requests.Iterate' response='CGIFTE.Responses.Simulate' height='2000' width='2000' >
<context>
<property name='iterator' type='%Integer' instantiate='0' />
<property name='time' type='%TimeStamp' instantiate='0' />
</context>
<sequence xend='200' yend='550' >
<assign property="context.iterator" value="0" action="set" languageOverride="" xpos='200' ypos='250' />
<assign property="context.time" value="request.CurrentTime" action="set" languageOverride="" xpos='200' ypos='350' />
<while condition='context.iterator &lt; request.NumberOfWeeks' xpos='200' ypos='450' xend='200' yend='450' >
<call name='Call SimulateWeek' target='SimulateProcess' async='0' xpos='200' ypos='250' >
<request type='CGIFTE.Requests.Simulate' >
<assign property="callrequest.CurrentTime" value="context.time" action="set" languageOverride="" />
<assign property="callrequest.EmployeeString" value="request.EmployeeString" action="set" languageOverride="" />
</request>
<response type='CGIFTE.Responses.Simulate' >
<assign property="context.time" value="callresponse.CurrentTime" action="set" languageOverride="" />
<assign property="response.CurrentTime" value="callresponse.CurrentTime" action="set" languageOverride="" />
<assign property="response.Status" value="callresponse.Status" action="set" languageOverride="" />
</response>
</call>
<assign property="context.iterator" value="context.iterator + 1" action="set" languageOverride="" xpos='200' ypos='350' />
</while>
</sequence>
</process>
}

}
