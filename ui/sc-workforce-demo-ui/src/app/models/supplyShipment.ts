import { IIssue } from "./issue-result";
import { ILocation } from "./location";

export interface ISupplyShipment {
    uid:string;
    
    requestedTimeOfArrival?:string;
    committedTimeOfArrival?:string;
    estimatedTimeOfArrival?:string;
    predictedTimeOfArrival?:string;
    actualTimeOfArrival?:string;

    recordCreatedTime?:string;
    lastUpdatedTime?:string;
    actualShipDate?:string;
    supplierId?:string;
    carrierId?:string;
    carrierName?:string; //Add on to store the carrier name for display
    latestCoordinate?:string;
    latestCoordinateTime?:string;
    originLocationId?:string;
    originLocationName?:string; //Add on to store the location name if determinable
    originLocation?: ILocation;
    destinationLocationId?:string;
    destinationLocationName?:string; //Add on to store the location name if determinable.
    destinationLocation?: ILocation;
    shippingCost?:number;
    shippingCostCurrency?:string;
    transportMode?:string;
    status?:string;
    type?:string;
    freightForwarder?:string;
    carrierContainer?:string;
    houseAirwayBill?:string;
    parcelTrackingNumber?:string;
    billOfLandingNumber?:string;
    masterAirwaybillNumber?:string

    issues: IIssue[];
    lineItems: ISupplyShipmentLineItems[];
    milestones?: IMilestone[];
    shipmentTracking?: IShipmentTracking[];
}

export interface ISupplyShipmentLineItems {
    lastUpdatedTime:string;
    lineNumber:string;
    productId:string;
    purchaseOrderId:string;
    purchaseOrderLineId:string;
    purchaseOrderLineNumber:string;
    quantityShipped:number;
    recordCreatedTime:string;
    supplyShipmentId:string;
    uid:string;
    unitOfMeasure:string;
    value:number;
    valueCurrency:string;
}

export interface IMilestone {
    actualEndDate?:string;
    actualStartDate?:string;
    associatedObjectId?:string;
    associatedObjectType?:string;
    description?:string;
    milestoneLocationId?:string;
    milestoneNumber:number;
    name?:string
    plannedEndDate?:string;
    plannedStartDate?:string;
    status?:string;
    uid:string;
    distanceToStop?:number;
    distanceToStopUnit?:string;
    estimatedTime?:string;
    estimatedTimeLocal?:string;
    lastUpdatedTime?:string;
    lastUpdatedTimeLocal?:string;
    lastUpdatedTimeUTC?:string;
    milestone?:string;
    shipmentId?:string;
    shipmentType?:string;
    statusCode?:string;
    stopId?:string;
    stopType?:string;
    unLocode?:string;
    updatedBy?:string;
    recordCreatedTime?:string;
}

export interface IShipmentTracking {
    datasource?:string;
    etaDateTimeLocalTime?:string;
    etaDateTimeUTC?:string;
    lastUpdatedTime?:string;
    latestLocationId?:string;
    locator?:string;
    recordCreatedTime?:string;
    shipmentId?:string;
    shipmentType?:string;
    trackingServiceLastUpdatedTimeLocal?:string;
    trackingServiceLastUpdatedTimeUTC?:string;
    trackingServiceOrderId?:string;
    trackingServiceProvider?:string;
    trackingServiceRequestId?:string;
    trackingServiceShipmentMessage?:string;
    trackingServiceShipmentStatus?:string;
    trackingServiceStatus?:string;
    uid:string;
    unLocode?:string;
    uncertainty?:number;
}