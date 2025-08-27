/*
Copyright (c) 2024 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// ServiceSLA object can be used to store any kind of information for different cloud services
/// values can be stored in key value pairs
Class SC.Core.Data.ServiceSLA Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// Service Id: referring to the tracking service uid for which the information belongs
Property serviceId As %String(MAXLEN = 256);

/// name of the term (Key)
Property termName As %String(MAXLEN = 256);

/// value of the term (value)
Property termValue As %String(MAXLEN = 256);

/// Unit of measure for the term
Property termValueUOM As %String(MAXLEN = 256);

/// Name of the object to which serviceId belongs
Property serviceObject As %String(MAXLEN = 256);

/// type of the SLA
Property type As %String(MAXLEN = 256);

}
