import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export interface LaborDeficit {
  uid: string;
  locationId: 'warehouse-01' | 'warehouse-02' | string;
  supplyQuantity: number;      // workforce available (hours)
  demandQuantity: number;      // workload (hours)
  productId: string;           // laborprofile id
  startDate: string;           // ISO date/time (week bucket anchor)
  quantity: number;            // gap = supply - demand
  recordCreatedTime: string;
  lastUpdatedTime: string;
}

export interface KPIValuesResponse {
  kpiName: string;
  expandDimension: string;
  kpiFilter: Array<{ dimension: string; value: string }>;
  values: Array<{ label: string; value: number }>; // label = laborproduct-0X
}

@Injectable({ providedIn: 'root' })
export class ForecastApiService {
  private readonly DEFICITS =
    'http://localhost:4200/api/SC/scdata/v1/labordeficits';

  private readonly KPI_BASE =
    'http://localhost:4200/api/SC/scbi/v1/kpi/values/StaffingIssue';

  constructor(private http: HttpClient) {}

  getLaborDeficits(): Observable<LaborDeficit[]> {
    return this.http.get<LaborDeficit[]>(this.DEFICITS);
  }

  getStaffingIssues(location: 'warehouse-01' | 'warehouse-02'): Observable<KPIValuesResponse> {
    const url = `${this.KPI_BASE}?kpiFilter=(location,${location})&expandDimension=laborProfile`;
    return this.http.get<KPIValuesResponse>(url);
  }
}
