import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

export type EmpKey = 'general' | 'quality' | 'forklift';

export interface StaffResponse {
  general: number;
  quality: number;
  forklift: number;
}

@Injectable({ providedIn: 'root' })
export class SettingsApiService {
  // 👇 Change this to your backend base URL
  private readonly API_BASE = 'http://localhost:4200';

  constructor(private http: HttpClient) {}

  runSimulation(): Observable<HttpResponse<any>> {
    return this.http.post(`${this.API_BASE}/csp/simulateapi/simulate`, {}, { observe: 'response' });
  }

  getWarehouseStaff(warehouseId: number): Observable<StaffResponse> {
    return this.http.get<StaffResponse>(`${this.API_BASE}/csp/warehouse${warehouseId}/employees`);
  }

  updateWarehouseStaff(warehouseId: number, type: EmpKey, value: number): Observable<HttpResponse<any>> {
    return this.http.post(`${this.API_BASE}/csp/warehouse${warehouseId}/employees`, { type, value }, { observe: 'response' });
  }

  
}
