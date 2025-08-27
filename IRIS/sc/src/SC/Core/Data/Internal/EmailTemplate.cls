Class SC.Core.Data.Internal.EmailTemplate Extends (%Persistent, SC.Core.Data.TimeStampedData)
{

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// message key to identify each template uniquely
Property messageKey As %String(MAXLEN = 256);

/// locale
Property locale As %String(MAXLEN = 256);

/// email subject
Property header As %String(MAXLEN = "");

/// email body
Property body As %String(MAXLEN = "");

/// email signature
Property signature As %String(MAXLEN = "");

Storage Default
{
<Data name="EmailTemplateDefaultData">
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
<Value>messageKey</Value>
</Value>
<Value name="5">
<Value>locale</Value>
</Value>
<Value name="6">
<Value>header</Value>
</Value>
<Value name="7">
<Value>body</Value>
</Value>
<Value name="8">
<Value>signature</Value>
</Value>
<Value name="9">
<Value>uid</Value>
</Value>
</Data>
<DataLocation>^SC.Core.Data5DF8.EmailTemplateD</DataLocation>
<DefaultData>EmailTemplateDefaultData</DefaultData>
<ExtentSize>1</ExtentSize>
<IdLocation>^SC.Core.Data5DF8.EmailTemplateD</IdLocation>
<IndexLocation>^SC.Core.Data5DF8.EmailTemplateI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="body">
<AverageFieldSize>182</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="header">
<AverageFieldSize>57</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="lastUpdatedTime">
<AverageFieldSize>25</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="locale">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="messageKey">
<AverageFieldSize>23</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="recordCreatedTime">
<AverageFieldSize>24</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="signature">
<AverageFieldSize>43</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="uid">
<AverageFieldSize>23</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="uidIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^SC.Core.Data5DF8.EmailTemplateS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
