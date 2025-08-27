/*
Copyright (c) 2024 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// ShipmentTracking object is used to store shipment tracking information
/// like ETA, shipment status and messages from tracking service provider, latest location, etc.
Class SC.Core.Data.ShipmentTracking Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// Unique ID of the location
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// Shipment Id: referring to the shipment to which this stop is related to
Property shipmentId As %String(MAXLEN = 256);

/// Type of the shipment (e.g. Sales, Supply, etc)
Property shipmentType As %String(MAXLEN = 20);

/// Refering to ID of the location object having the location details
Property latestLocationId As %String(MAXLEN = 256);

/// Name of the tracking service provider
Property trackingServiceProvider As %String(MAXLEN = 50);

/// OrderId received from tracking service provider for reference and all the updates
Property trackingServiceOrderId As %String(MAXLEN = 256);

/// RequestId received from tracking service provider for reference and all the updates
Property trackingServiceRequestId As %String(MAXLEN = 256);

/// Refers to the status of the tracking request (Error, Active, New, Closed)
Property trackingServiceStatus As %String(MAXLEN = 10);

/// Refers to the UTC time when the shipment tracking was last updated
Property trackingServiceLastUpdatedTimeUTC As %DateTime;

/// Refers to the local time when the shipment tracking was last updated
Property trackingServiceLastUpdatedTimeLocal As %String(MAXLEN = 128);

/// Referes to the code of the shipment status provided by the tracking service provider
Property trackingServiceShipmentStatus As %String(MAXLEN = 20);

/// Refers to the message of the shipment status provided by tge tracking service provider
Property trackingServiceShipmentMessage As %String(MAXLEN = 256);

/// Estimated time of arrival in UTC
Property etaDateTimeUTC As %DateTime;

/// Estimated time of arrival in local time
Property etaDateTimeLocalTime As %String(MAXLEN = 128);

/// Refers to the physical location of the port for ocean tracking
Property unLocode As %String(MAXLEN = 15);

/// Approximate uncertainty radius, in miles
Property uncertainty As %Numeric;

/// Source the data was received from
Property datasource As %String(MAXLEN = 128);

/// TMS ID, Truck Number, Trailer Number, or Mobile Cell Phone Number from which the data was received
Property locator As %String(MAXLEN = 128);

}
