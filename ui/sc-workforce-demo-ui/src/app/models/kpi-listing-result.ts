import { IIssue } from "./issue-result";

export interface IKpiListingResult {
    [x: string]: any;
    uid: string;
    orderStatus: string;
    customerId: string;
    requestedShipDate: string;
    requestedDeliveryDate: string;
    committedShipDate: string;
    committedDeliveryDate: string;
    orderPlacedDate: string;
    shipToLocationId: string;
    orderValue: number;
    orderCurrency: string;
    recordCreatedTime: string;
    lastUpdatedTime: string;
    lineItems: ILineItem[];
    issues: IIssue[];
}

export interface ILineItem {
    lineNumber:string;
    uid: string;
    quantity: number;
    salesOrderId: string;
    unitOfMeasure: string;
    productId: string;
    status: string;
    value: number;
    valueCurrency: string;
    recordCreatedTime: string;
    lastUpdatedTime: string;
}