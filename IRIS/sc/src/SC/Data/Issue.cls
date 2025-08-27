/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// This object is used to capture issues/risks/challenges in the supply chain. Issues can be generated 
/// by the system (such as through KPIs or business processes), or be imported through API. 
Class SC.Data.Issue Extends SC.Core.Data.Internal.Issue
{

Storage Default
{
<Data name="IssueDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>recordCreatedTime</Value>
</Value>
<Value name="3">
<Value>lastUpdatedTime</Value>
</Value>
<Value name="4">
<Value>description</Value>
</Value>
<Value name="5">
<Value>issueCategory</Value>
</Value>
<Value name="6">
<Value>issueRegion</Value>
</Value>
<Value name="7">
<Value>triggerType</Value>
</Value>
<Value name="8">
<Value>triggerObjectId</Value>
</Value>
<Value name="9">
<Value>impactedObjectType</Value>
</Value>
<Value name="10">
<Value>impactedObjectId</Value>
</Value>
<Value name="11">
<Value>issueData</Value>
</Value>
<Value name="12">
<Value>processName</Value>
</Value>
<Value name="13">
<Value>source</Value>
</Value>
<Value name="14">
<Value>severity</Value>
</Value>
<Value name="15">
<Value>urgency</Value>
</Value>
<Value name="16">
<Value>status</Value>
</Value>
<Value name="17">
<Value>closeTime</Value>
</Value>
<Value name="18">
<Value>resolutionUser</Value>
</Value>
<Value name="19">
<Value>resolutionType</Value>
</Value>
<Value name="20">
<Value>resolutionNote</Value>
</Value>
<Value name="21">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Data.IssueD</DataLocation>
<DefaultData>IssueDefaultData</DefaultData>
<ExtentSize>12</ExtentSize>
<IdLocation>^SC.Data.IssueD</IdLocation>
<IndexLocation>^SC.Data.IssueI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="closeTime">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="description">
<AverageFieldSize>33</AverageFieldSize>
<OutlierSelectivity>.999999:"Labor supply higher than demand"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="impactedObjectId">
<AverageFieldSize>33.5</AverageFieldSize>
<Selectivity>8.3333%</Selectivity>
</Property>
<Property name="impactedObjectType">
<AverageFieldSize>14</AverageFieldSize>
<OutlierSelectivity>.999999:"LaborDeficit"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="issueCategory">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="issueData">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="issueRegion">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="lastUpdatedTime">
<AverageFieldSize>25</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="processName">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="recordCreatedTime">
<AverageFieldSize>25</AverageFieldSize>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="resolutionNote">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="resolutionType">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="resolutionUser">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="severity">
<AverageFieldSize>3</AverageFieldSize>
<OutlierSelectivity>.999999:3</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="source">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="status">
<AverageFieldSize>6</AverageFieldSize>
<OutlierSelectivity>.999999:"open"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="triggerObjectId">
<AverageFieldSize>14</AverageFieldSize>
<OutlierSelectivity>.999999:"Overstaffing"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="triggerType">
<AverageFieldSize>5</AverageFieldSize>
<OutlierSelectivity>.999999:"KPI"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="uid">
<AverageFieldSize>38</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="urgency">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="uidIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^SC.Data.IssueS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
