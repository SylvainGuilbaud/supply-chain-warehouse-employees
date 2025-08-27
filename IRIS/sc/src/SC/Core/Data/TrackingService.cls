/*
Copyright (c) 2024 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// TrackingService object is used to store tracking service provider information
/// like tracking service provider name, all the configurable parameters and 
/// paramters based on the contract from tracking service provider
Class SC.Core.Data.TrackingService Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// Unique ID of the location
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// The service provider id given by the service provider
Property serviceProviderId As %String(MAXLEN = 50);

/// To report alerts regarding stops in order of stops on tracking session
Property stopSequencingRequired As %Boolean;

/// Maximum driving hours for the driver per day
Property maximumAllowableDrivingHoursPerDay As %Numeric;

/// Name of the tracking service provider
Property trackingServiceProvider As %String(MAXLEN = 50);

/// Start date of the contract with the service provider
Property startDate As %DateTime;

/// End date of the contract with the service provider
Property endDate As %DateTime;

}
