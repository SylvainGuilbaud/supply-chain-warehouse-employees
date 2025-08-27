import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, map, of, shareReplay, filter } from 'rxjs';
import { byIso } from 'country-code-lookup'

import { environment } from '../../environments/environment';
import { IIssue } from '../models/issue-result';
import { IKpiDefinition } from '../models/kpi-definition-result';
import { IKpiListingResult } from '../models/kpi-listing-result';
import { IKpiResult } from '../models/kpi-result';
import { IMilestone, ISupplyShipment, IShipmentTracking } from '../models/supplyShipment';
import { ILocation } from '../models/location';
import { IShippingSearchCriteria } from '../models/shipping-search-criteria';
import { IInventory } from '../models/inventory';
import { IInventorySearchCriteria } from '../models/inventory-search-criteria';
import { ILaborDeficit } from '../models/labor-deficit';

@Injectable({
  providedIn: 'root'
})
export class KpiApiService {

  constructor(public httpClient: HttpClient) { }

  readonly listingBaseUrl = 'api/SC/scbi/v1/kpi/listings';
  readonly valueBaseUrl = 'api/SC/scbi/v1/kpi/values';
  readonly definitionBaseUrl = 'api/SC/scbi/v1/kpi/definitions';
  readonly issuesBaseUrl = 'api/SC/scdata/v1/issues';
  readonly ordersBaseUrl = 'api/SC/scdata/v1/salesorders';

  readonly kpiDefinitionCache: {[name:string]:IKpiDefinition} = {};
  
  getKpiValue(kpiName: string, objectType:string='', kpiFilter:string=''): Observable<IKpiResult> {
    let queryParm = '';
    if (objectType) {
      queryParm = `?kpiFilter=(objectType,${objectType})`;
    }
    if (kpiFilter) {
      if (!queryParm) {
        queryParm = `?kpiFilter=`;
      } else {
        queryParm += ',';
      }
      queryParm += `${kpiFilter}`;
    }
    console.log(environment)
    return this.httpClient.get(`${environment.apiRootUrl}/${this.valueBaseUrl}/${kpiName}${queryParm}`) as Observable<IKpiResult>;
  }

  getAllKpiDefinitions(): Observable<IKpiDefinition[]> {
    console.log(environment)
    return this.httpClient.get(`${environment.apiRootUrl}/${this.definitionBaseUrl}`) as Observable<IKpiDefinition[]>;
  }
  
  getKpiDefinition(kpiName: string): Observable<IKpiDefinition> {
    if (this.kpiDefinitionCache[kpiName]) {
      console.log(environment) 
      return of(this.kpiDefinitionCache[kpiName]) 
    }
    console.log(environment)
    return this.httpClient.get(`${environment.apiRootUrl}/${this.definitionBaseUrl}/${kpiName}`) as Observable<IKpiDefinition>;
  }

  getKpiValueWithDrillThrough(kpiName: string,  dimension: string): Observable<IKpiResult> {
    console.log(environment)
    return this.httpClient.get(`${environment.apiRootUrl}/${this.valueBaseUrl}/${kpiName}?expandDimension=${dimension}`) as Observable<IKpiResult>;
  }

  getKpiListing(kpiName: string, parms?:{
    dimensionName?:string,
    dimensionDescription?:string,
    pageSize?:number,
    pageNumber?:number,
    orderBy?:string,
    filter: any,
  }): Observable<IKpiListingResult[]> {
    if (parms?.dimensionName === "month" && parms?.dimensionDescription?.length ===8) {
      let internalValue = parms.dimensionDescription.substring(4);
      switch (parms.dimensionDescription.substring(0,3)) {
        case "Jan":
          internalValue += "01";
          break;
        case "Feb":
          internalValue += "02";
          break;
        case "Mar":
          internalValue += "03";
          break;
        case "Apr":
          internalValue += "04";
          break;
        case "May":
          internalValue += "05";
          break;
        case "Jun":
          internalValue += "06";
          break;
        case "Jul":
          internalValue += "07";
          break;
        case "Aug":
          internalValue += "08";
          break;
        case "Sep":
          internalValue += "09";
          break;
        case "Oct":
          internalValue += "10";
          break;
        case "Nov":
          internalValue += "11";
          break;
        case "Dec":
          internalValue += "12";
          break;
      }
      parms.dimensionDescription = internalValue;
    }
    
    const filter = {...parms?.filter};
    const dateFilter:{committedDeliveryDate?:string} = {};
    const valueFilter:{orderValue?:string} = {};

    if (filter?.endCommittedDeliveryDate || filter.startCommittedDeliveryDate){
      dateFilter.committedDeliveryDate = (filter.startCommittedDeliveryDate?.toISOString() || '') + '..' + (filter.endCommittedDeliveryDate?.toISOString() || '');
      delete filter.startCommittedDeliveryDate;
      delete filter.endCommittedDeliveryDate;
    }

    if (filter?.orderValue || filter?.orderValueMax) {
      valueFilter.orderValue = (filter.orderValue?.toString() || '') + '..' + (filter.orderValueMax?.toString() || '');
      delete filter.orderValue;
      delete filter.orderValueMax;
    }

    const params = new HttpParams({
      fromObject: {
        ...parms?.dimensionName && parms?.dimensionDescription && {kpiFilter: `(${parms.dimensionName},${parms.dimensionDescription})`},
        ...parms?.pageSize && {pageSize: parms.pageSize.toString()},
        ...parms?.pageNumber && {pageIndex: (parms.pageNumber-1).toString()},
        ...parms?.orderBy && {sortBy: parms.orderBy},
        ...filter,
        ...dateFilter,
        ...valueFilter,
      }
    });
    
    console.log(environment)
    return this.httpClient.get(`${environment.apiRootUrl}/${this.listingBaseUrl}/${kpiName}`, {params}) as Observable<IKpiListingResult[]>;
  }

  getRegionalKpiValueWithDrillThrough(kpiName: string, dimension: string): Observable<IKpiResult> {
    if (kpiName === "testRegion") {
      console.log(environment)
      return new Observable(observer => {
        setTimeout(()=>{
          let rslt:IKpiResult = {
            kpiName,
            values:[
              {label:"US", value:75000},
              {label:"FR", value:31000},
              {label:"CN", value:52000},
              {label:"JP", value:40000},
              {label:"IN", value:38000}
            ]
          };
          observer.next(rslt);
          observer.complete();
        },2000);
      }) as Observable<IKpiResult>;
    }

    console.log(environment)
    return (this.httpClient.get(`${environment.apiRootUrl}/${this.valueBaseUrl}/${kpiName}?expandDimension=${dimension}`) as Observable<IKpiResult>).pipe(map(c=> {
      c.values.forEach(v=>{
        if (v.label.length <= 3) {
          const country = byIso(v.label);
          if (country) {
            v.label = country.iso2;
          }
        }
      });
      console.log(environment)
      return c;
    }))  as Observable<IKpiResult>;
  }

  getAllIssues(objectType:string, filter:{key:string,value:string}[]): Observable<IIssue[]> {
    const filterQuery = '&' + filter.map(x=>(`${x.key}=${x.value}`)).join('&');
    return this.httpClient.get(`${environment.apiRootUrl}/api/SC/scdata/v1/issues?impactedObjectType=${objectType}${filterQuery}`) as Observable<IIssue[]>;
  }

  getOrder(orderId: string): Observable<IKpiListingResult> {
    console.log(environment)
    return this.httpClient.get(`${environment.apiRootUrl}/${this.ordersBaseUrl}/${orderId}`) as Observable<IKpiListingResult>;
  }

  getIssue(issueId: string): Observable<IIssue> {
    return this.httpClient.get(`${environment.apiRootUrl}/api/SC/scdata/v1/issues/${issueId}`) as Observable<IIssue>;
  }

  getCarriers(): Observable<any> {
    console.log(environment)
    return this.httpClient.get(`${environment.apiRootUrl}/api/SC/scdata/v1/carriers?sortBy=name`).pipe(shareReplay(1))
  }

  getSuppliers(): Observable<any> {
    console.log(environment)
    return this.httpClient.get(`${environment.apiRootUrl}/api/SC/scdata/v1/suppliers?sortBy=name`).pipe(shareReplay(1));
  }

  getProducts(): Observable<any> {
    console.log(environment)
    return this.httpClient.get(`${environment.apiRootUrl}/api/SC/scdata/v1/products?sortBy=name`).pipe(shareReplay(1));
  }

  getProduct(productId: string): Observable<any> {
    console.log(environment)
    return this.httpClient.get(`${environment.apiRootUrl}/api/SC/scdata/v1/products/${productId}`);
  }

  getCustomers(): Observable<any> {
    console.log(environment)
    return this.httpClient.get(`${environment.apiRootUrl}/api/SC/scdata/v1/customers?sortBy=name`).pipe(shareReplay(1));
  }

  getCustomer(customerId:string): Observable<any> {
    console.log(environment)
    return this.httpClient.get(`${environment.apiRootUrl}/api/SC/scdata/v1/customers/${customerId}?sortBy=name`).pipe(shareReplay(1));
  }

  getSupplyShipment(shipmentId:string): Observable<ISupplyShipment> {
    console.log(environment)
    return this.httpClient.get(`${environment.apiRootUrl}/api/SC/scdata/v1/supplyshipments/${shipmentId}`) as Observable<ISupplyShipment>;
  }

  getShipmentMilestone(shipmentId:string): Observable<IMilestone[]> {
    return this.httpClient.get(`${environment.apiRootUrl}/api/SC/scdata/v1/shipmentmilestones?shipmentId=${shipmentId}&sortBy=recordCreatedTime`) as Observable<IMilestone[]>;
  }

  getShipmentTracking(shipmentId:string): Observable<IShipmentTracking[]> {
    return this.httpClient.get(`${environment.apiRootUrl}/api/SC/scdata/v1/shipmenttrackings?shipmentId=${shipmentId}`) as Observable<IShipmentTracking[]>;
  }

  getInventory(inventoryId:string):Observable<IInventory> {
    console.log(environment)
    return this.httpClient.get(`${environment.apiRootUrl}/api/SC/scdata/v1/productinventories/${inventoryId}`) as Observable<IInventory>;
  }

  getLocation(locationId:string): Observable<ILocation> {
    console.log(environment)
    return this.httpClient.get(`${environment.apiRootUrl}/api/SC/scdata/v1/locations/${locationId}`) as Observable<ILocation>;
  }
  
  getLocations(): Observable<any> {
    console.log(environment)
    return this.httpClient.get(`${environment.apiRootUrl}/api/SC/scdata/v1/locations?sortBy=name`) as Observable<ILocation[]>;
  }

  getSupplyShipments(parms?:{
    pageSize?:number,
    pageNumber?:number,
    filter?:IShippingSearchCriteria
    sort?: string
  }):Observable<ISupplyShipment[]> {

    const dateFilter:any = {};
    let filter = parms?.filter || {};
    
    if ((filter && filter.startShipmentDate) ||
        filter && filter.endShipmentDate
    ) {
      dateFilter.actualShipDate = (filter.startShipmentDate?.toISOString() || '') + '..' + (filter.endShipmentDate?.toISOString() || '');
      delete filter.startShipmentDate;
      delete filter.endShipmentDate;
    }

    if ((filter && filter.startDeliveryDate) ||
        filter && filter.endDeliveryDate
    ) {
      dateFilter.deliveryDate = (filter.startDeliveryDate?.toISOString() || '') + '..' + (filter.endDeliveryDate?.toISOString() || '');
      delete filter.startDeliveryDate;
      delete filter.endDeliveryDate;
    }

    if ((filter && filter.startEstimatedTimeOfArrival) ||
        filter && filter.endEstimatedTimeOfArrival
    ) {
      dateFilter.estimatedTimeOfArrival = (filter.startEstimatedTimeOfArrival?.toISOString() || '') + '..' + (filter.endEstimatedTimeOfArrival?.toISOString() || '');
      delete filter.startEstimatedTimeOfArrival;
      delete filter.endEstimatedTimeOfArrival;
    }

    if (filter?.shipmentType === 'Open' || Object.keys(filter).length === 0 /*default option*/) {
      filter.actualTimeOfArrival = 'NULL';
    }

    const params = new HttpParams({
      fromObject: {
        ...parms?.pageSize && {pageSize: parms.pageSize.toString()},
        ...parms?.pageNumber && {pageIndex: (parms.pageNumber-1).toString()},
        ...filter?.shipmentId && {uid: filter.shipmentId},
        ...filter?.supplierId && {supplierId: filter.supplierId},
        ...filter?.status && {status: filter.status},
        ...filter?.orderId && {orderId: filter.orderId},
        ...filter?.carrierId && {carrierId: filter.carrierId},
        ...filter?.originLocationId && {originLocationId: filter.originLocationId},
        ...filter?.destinationLocationId && {destinationLocationId: filter.destinationLocationId},
        ...filter?.actualTimeOfArrival && {actualTimeOfArrival: filter.actualTimeOfArrival},
        ...parms?.sort && {sortBy: parms.sort},
        ...dateFilter
      }
    });
    let url = `${environment.apiRootUrl}/api/SC/scdata/v1/supplyshipments`;
    if (parms?.filter?.shipmentType) {
      switch (parms.filter.shipmentType) {
        case "Late":
          url=`${environment.apiRootUrl}/api/SC/scbi/v1/kpi/listings/SupplyShipmentLateVsRequested`;
          break;
        case "Expect":
          url=`${environment.apiRootUrl}/api/SC/scbi/v1/kpi/listings/SupplyShipmentEstimatedLateVsRequested`;
          break;
        case "Predicted":
          url=`${environment.apiRootUrl}/api/SC/scbi/v1/kpi/listings/SupplyShipmentPredictedLateVsRequested`;
          break;
      }
    }
    console.log(environment)
    return this.httpClient.get(url,{params}) as Observable<ISupplyShipment[]>;
  }

  getInventories(parms?:{
    pageSize?:number,
    pageNumber?:number,
    filter?:IInventorySearchCriteria,
    sort?: string,
  }):Observable<IInventory[]> {

    const quantityFilter:any = {};
    const dateFilter:any = {};
    let filter = parms?.filter || {};

    if ((filter && filter.minQuantity) ||
      filter && filter.maxQuantity
    ) {
    quantityFilter.quantity = (filter.minQuantity?.toString() || "") + '..' + (filter.maxQuantity?.toString() || "");
    delete filter.minQuantity;
    delete filter.maxQuantity;
  }

  if ((filter && filter.startStorageDate) ||
      filter && filter.endStorageDate
  ) {
    dateFilter.storageDate = (filter.startStorageDate?.toISOString() || '') + '..' + ((filter.endStorageDate)?.toISOString() || '');
    delete filter.startStorageDate;
    delete filter.endStorageDate;
  }

  if ((filter && filter.startExpirationDate) ||
      filter && filter.endExpirationDate
  ) {
    dateFilter.expirationDate = (filter.startExpirationDate?.toISOString() || '') + '..' + (filter.endExpirationDate?.toISOString() || '');
    delete filter.startExpirationDate;
    delete filter.endExpirationDate;
  }
  
    const params = new HttpParams({
      fromObject: {
        ...parms?.pageSize && {pageSize: parms.pageSize.toString()},
        ...parms?.pageNumber && {pageIndex: (parms.pageNumber-1).toString()},
        ...filter?.lotNumber && {lotNumber: filter.lotNumber},
        ...filter?.productId && {productId: filter.productId.toString()},
        ...filter?.siteLocationId && {siteLocationId: filter.siteLocationId},
        ...parms?.sort && {sortBy: parms.sort},
        ...quantityFilter,
        ...dateFilter
      }
    });
    let url = `${environment.apiRootUrl}/api/SC/scdata/v1/productinventories`;
    if (parms?.filter?.inventoryType) {
      switch (parms.filter.inventoryType) {
        case "OutOfStock":
          url=`${environment.apiRootUrl}/api/SC/scbi/v1/kpi/listings/InventoryOutOfStock`;
          break;
        case "ApproachingOutOfStock":
          url=`${environment.apiRootUrl}/api/SC/scbi/v1/kpi/listings/InventoryApproachingOutOfStock`;
          break;
        case "ExcessiveStock":
          url=`${environment.apiRootUrl}/api/SC/scbi/v1/kpi/listings/ExcessiveInventory`;
          break;
        case "Expired":
          url=`${environment.apiRootUrl}/api/SC/scbi/v1/kpi/listings/ExpiredInventory`;
          break;
      }
    }
    console.log(environment)
    return this.httpClient.get(url, {params}) as Observable<IInventory[]>;
  }

  getPredictedInventories(product:string, location:string): Observable<any[]>{
    const params = {productId:product, locationId:location};
    console.log(environment)
    return this.httpClient.get(`${environment.apiRootUrl}/api/SC/scdata/v1/predictedinventories`,{params}) as Observable<any[]>;
  }

  getPredictedInventory(product:string, location:string, dayInFuture:number): Observable<any>{
    const params = {productId:product, locationId:location, dayInFuture:dayInFuture};
    console.log(environment)
    return this.httpClient.get(`${environment.apiRootUrl}/api/SC/scdata/v1/predictedinventories`,{params}) as Observable<any[]>;
  }

  getInventoryThreshold(product:string, location:string): Observable<any> {
    const params = {productId:product, siteLocationId:location};
    console.log(environment)
    return this.httpClient.get(`${environment.apiRootUrl}/api/SC/scdata/v1/inventorythresholds`,{params}) as Observable<any>;
  }
  
  closeIssue(issueId:string, reason:string) {
    console.log(environment)
    return this.httpClient.post(`${environment.apiRootUrl}/api/SC/scbi/v1/closeissue/${issueId}`,{comment:reason}) as Observable<any>;
  }

  updateAnalysis(issueId:string, processName:string) {
    console.log(environment)
    return this.httpClient.post(`${environment.apiRootUrl}/api/SC/scbi/v1/runissueanalysis/${issueId}`,{processName}) as Observable<any>;
  }

  completeWorkflowIssue(issueId:string, selectedOption:string, comment: string) {
    let msg = {
      comment,
      selectedOption
    }
    console.log(environment)
    return this.httpClient.post(`${environment.apiRootUrl}/api/SC/scbi/v1/completeissueworkflow/${issueId}`,msg) as Observable<any>;
  }

  getUIVersion() {
    console.log(environment)
    return this.httpClient.get('assets/UI_version.txt', { responseType: "text" }) as Observable<any>;
  }

  getBackendVersion() {
    return this.httpClient.get(`${environment.apiRootUrl}/api/SC/scdata/v1/backend-version`, { responseType: "text" }) as Observable<string>;
  }

  getLaborDeficits(productId:string, locationId:string) {
    return this.httpClient.get(`${environment.apiRootUrl}/api/SC/scdata/v1/labordeficits?productId=${productId}&locationId=${locationId}`) as Observable<ILaborDeficit[]>
  }

  getLaborDeficitsById(uid:string) {
    return this.httpClient.get(`${environment.apiRootUrl}/api/SC/scdata/v1/labordeficits?uid=${uid}`) as Observable<ILaborDeficit[]>
  }
}
