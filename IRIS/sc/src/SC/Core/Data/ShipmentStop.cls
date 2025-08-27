/*
Copyright (c) 2024 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// ShipmentStop object can be used to store information regarding shipment stops
/// like origin, destination of the shipment, in between stops. 
Class SC.Core.Data.ShipmentStop Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// Unique ID of the location
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// Shipment Id: referring to the shipment to which this stop is related to
Property shipmentId As %String(MAXLEN = 256);

/// Type of the shipment (e.g. Sales, Supply, etc)
Property shipmentType As %String(MAXLEN = 20);

/// Name assigned to the stop
Property name As %String(MAXLEN = 128);

/// Used to store what type of stop it is (e.g. Pickup, DropOff)
Property stopType As %String(MAXLEN = 20);

/// refereing to the location data which stores the address details of the stop
Property locationId As %String(MAXLEN = 256);

/// Earliest date/time for a shipment to arrive at a stop
Property earliestDateTime As %DateTime;

/// Latest date/time for a shipment to arrive at a stop
Property latestDateTime As %DateTime;

/// The geofence by the stop
Property geofence As %Numeric;

/// Unit of the geofence
Property geofenceUnit As %String(MAXLEN = 20);

/// The number of the particular stop in the a multistop shipment
Property stopNumber As %Numeric;

/// notes assigned to a stop
Property notes As %String(MAXLEN = 256);

}
