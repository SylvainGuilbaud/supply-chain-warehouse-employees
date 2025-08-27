import { IIssue } from "./issue-result";

export interface IInventory {
    uid:string,
    siteLocationId:string,
    siteLocationName?:string,
    siteLocationRegion?:string,
    productId:string,
    productCategory?:string,
    locationNumber?:string,
    lotNumber?:string,
    quantity:number,
    uom:string,
    storageDate?:string,
    expirationDate:string,
    status?:string,
    inventoryType?:string,
    inventoryClass?:string,
    inventoryValue:number,
    valueCurrency:string,
    quantityReserved?:number,
    quantityReservedUom?:string

    issues: IIssue[];
}