export interface IShippingSearchCriteria { 
    shipmentId?:string;
    supplierId?:string;
    status?:string;
    orderId?:string;
    carrierId?:string;
    originLocationId?:string;
    destinationLocationId?:string;
    productIds?:string[];
    shipmentType?:string;
    startShipmentDate?:Date;
    endShipmentDate?:Date;
    startDeliveryDate?:Date;
    endDeliveryDate?:Date;
    startEstimatedTimeOfArrival?:Date;
    endEstimatedTimeOfArrival?:Date;
    actualTimeOfArrival?:string;
}