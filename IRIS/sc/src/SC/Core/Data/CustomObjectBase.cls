Class SC.Core.Data.CustomObjectBase Extends (SC.Core.Data.TimeStampedData, %Populate) [ Abstract, NoExtent ]
{

/// unique ID of custom object 
Property uid As %String;

/// Description
Index uidIndex On uid [ PrimaryKey, Unique ];

/// Override to use an alternative unique index name
Parameter IndexToUse As STRING = "uidIndex";

}
