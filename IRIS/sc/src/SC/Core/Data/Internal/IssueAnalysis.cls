/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.Internal.IssueAnalysis Extends SC.Core.Data.TimeStampedData
{

/// Issue ID, foreign key to Issue object
Property issueId As %Integer [ Required ];

ForeignKey issueIdFK(issueId) References SC.Data.Issue() [ OnDelete = cascade ];

Index issueIdIndex On issueId;

/// Sequence number of the analysis of the same issue, 1,2,3…
Property runSequence As %Integer [ Required ];

/// Name of the analytis process
Property processName As %String(MAXLEN = 64);

/// severity level, the higher value, the more sever
Property severity As %Integer;

/// urgency level, the higher value, the more urgent
Property urgency As %Integer;

/// Root cause analysis result of the issue
Property rootCauseAnalysis As %String(MAXLEN = 512);

/// Analysis results of the impact of the issue
Property impactAnalysis As %String(MAXLEN = 512);

/// What action was taken for this analysis run. No all analysis to take automatic actions.
Property actionTaken As %String(MAXLEN = 128);

/// Issue resolution recommendation as the result of this analysis run.
Property recommendation As %String(MAXLEN = 128);

/// Supporting data used in the analysis, such as inventory position, labor availability, etc.
Property supportingData As %String(MAXLEN = 512);

/// Production workflow ID
Property workflowId As %String(MAXLEN = 32);

/// Analysis status:
/// completed: analysis completed successfully
/// workflow: waiting for workflow interaction
/// pending: asyn process, waiting on something to complete
/// terminated: analysis in workflow or pending got terminated (such as user want to re-run the analysis)
/// failed: something bad happend while running the analysis
Property status As %String(VALUELIST = ",completed,workflow,pending,terminated,failed") [ Required ];

Parameter STATUSCOMPLETED = "completed";

Parameter STATUSWORKFLOW = "workflow";

Parameter STATUSPENDING = "pending";

Parameter STATUSTERMINATED = "terminated";

Parameter STATUSFAILED = "failed";

/// Issue resolution at the end of the analysis
/// none: no issue resolution at the end of the analysis
/// workflowAction: issue resolved, through workflow actions
/// automaticAction: issue resolved with automatic action defined in the analysis, without and input from users
/// noAction: issue resolved without taking any action (no action is needed) as part of the analysis
Property resolution As %String(VALUELIST = ",none,workflowAction,automaticAction,noAction") [ Required ];

Parameter RESOLUTIONNONE = "none";

Parameter RESOLUTIONWORKFLOW = "workflowAction";

Parameter RESOLUTIONAUTOMATIC = "automaticAction";

Parameter RESOLUTIONNOACTION = "noAction";

/// List of action scenarios for this analysis run
Property scenarios As list Of SC.Core.Data.Internal.ActionScenario;

/// Adding a new scenrio to the analysis
Method addScenario(scenario As SC.Core.Data.Internal.ActionScenario) As %Status
{
    Set sc = $$$OK
    if ..scenarios = "" { set ..scenarios = ##class(%ListOfObjects).%New() }
    if scenario '= "" {
        do scenario.%Save()
        set sc = ..scenarios.Insert(scenario)
    }
    Return sc
}

Storage Default
{
<Data name="IssueAnalysisDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>issueId</Value>
</Value>
<Value name="3">
<Value>lastUpdatedTime</Value>
</Value>
<Value name="4">
<Value>runSequence</Value>
</Value>
<Value name="5">
<Value>runTime</Value>
</Value>
<Value name="6">
<Value>processName</Value>
</Value>
<Value name="7">
<Value>severity</Value>
</Value>
<Value name="8">
<Value>urgency</Value>
</Value>
<Value name="9">
<Value>actionTaken</Value>
</Value>
<Value name="10">
<Value>recommendation</Value>
</Value>
<Value name="11">
<Value>supportingData</Value>
</Value>
<Value name="12">
<Value>recordCreatedTime</Value>
</Value>
<Value name="13">
<Value>workflowId</Value>
</Value>
<Value name="14">
<Value>impactAnalysis</Value>
</Value>
<Value name="15">
<Value>status</Value>
</Value>
<Value name="16">
<Value>scenarios</Value>
</Value>
<Value name="17">
<Value>resolution</Value>
</Value>
<Value name="18">
<Value>rootCauseAnalysis</Value>
</Value>
</Data>
<DataLocation>^SC.Core.Data5DF8.IssueAnalysisD</DataLocation>
<DefaultData>IssueAnalysisDefaultData</DefaultData>
<ExtentSize>1</ExtentSize>
<IdLocation>^SC.Core.Data5DF8.IssueAnalysisD</IdLocation>
<IndexLocation>^SC.Core.Data5DF8.IssueAnalysisI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="actionTaken">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="impactAnalysis">
<AverageFieldSize>66</AverageFieldSize>
<OutlierSelectivity>.999999:"Serious customer satisfaction concerns, and a penalty of $50000."</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="issueId">
<AverageFieldSize>3</AverageFieldSize>
<OutlierSelectivity>.999999:1</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="lastUpdatedTime">
<AverageFieldSize>25</AverageFieldSize>
<OutlierSelectivity>.999999:"2025-04-04 00:51:51.570"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="processName">
<AverageFieldSize>22</AverageFieldSize>
<OutlierSelectivity>.999999:"UnderstaffingProcess"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="recommendation">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="recordCreatedTime">
<AverageFieldSize>25</AverageFieldSize>
<OutlierSelectivity>.999999:"2025-04-04 00:51:51.507"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="resolution">
<AverageFieldSize>6</AverageFieldSize>
<OutlierSelectivity>.999999:"none"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="rootCauseAnalysis">
<AverageFieldSize>55</AverageFieldSize>
<OutlierSelectivity>.999999:"Warehouse understaffed to meet forecasted labor needs"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="runSequence">
<AverageFieldSize>3</AverageFieldSize>
<OutlierSelectivity>.999999:1</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="scenarios">
<AverageFieldSize>20</AverageFieldSize>
<OutlierSelectivity>.999999:$lb($lb("10"),$lb("11"),$lb("12"))</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="severity">
<AverageFieldSize>3</AverageFieldSize>
<OutlierSelectivity>.999999:10</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="status">
<AverageFieldSize>10</AverageFieldSize>
<OutlierSelectivity>.999999:"workflow"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="supportingData">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="urgency">
<AverageFieldSize>3</AverageFieldSize>
<OutlierSelectivity>.999999:10</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="workflowId">
<AverageFieldSize>4</AverageFieldSize>
<OutlierSelectivity>.999999:9183</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="issueIdIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^SC.Core.Data5DF8.IssueAnalysisS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
