/*
Copyright (c) 2024 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// ShipmentMilestone object can be used to store any kind of milestones regarding shipments
/// like shipment arrived, shipment left destinantion, in between stops milestones, etc.
Class SC.Core.Data.ShipmentMilestone Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// Shipment Id: referring to the shipment to which this stop is related to
Property shipmentId As %String(MAXLEN = 256);

/// Type of the shipment (e.g. Sales, Supply, etc)
Property shipmentType As %String(MAXLEN = 20);

/// Refers to the stop id provided in the request while creating order
Property stopId As %String(MAXLEN = 256);

/// This is the event message recevied from the tracking service provider (e.g. Arrived, Departed, etc.)
Property milestone As %String(MAXLEN = 256);

/// Estimated time of the mileston in UTC
Property estimatedTime As %DateTime;

/// Estimated time of the mileston in local time
Property estimatedTimeLocal As %String(MAXLEN = 128);

/// Distance to the stop provided by the tracking service provider
Property distanceToStop As %Numeric;

/// Unit of the distance
Property distanceToStopUnit As %String(MAXLEN = 10);

/// Time in ISO8601 and in UTC
Property lastUpdatedTimeUTC As %DateTime;

/// The date and time that this event occurred in the local time zone
Property lastUpdatedTimeLocal As %String(MAXLEN = 128);

/// Refers to the physical location of the port for ocean tracking
Property unLocode As %String(MAXLEN = 15);

/// The type of stop that is expected to occur next: Pickup or Dropoff
Property stopType As %String(MAXLEN = 20);

/// A numeric code that represents the current status of the order
Property statusCode As %String(MAXLEN = 20);

/// Method by which event was captured.
Property updatedBy As %String(MAXLEN = 128);

}
