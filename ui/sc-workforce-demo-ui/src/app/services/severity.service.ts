import { Injectable } from '@angular/core';
import { IInventory } from '../models/inventory';
import { IIssue } from '../models/issue-result';
import { IKpiListingResult } from '../models/kpi-listing-result';
import { ISupplyShipment } from '../models/supplyShipment';

export enum Severity {
  High,
  Medium,
  Warn,
  None
}

export const defaultBackgroundColor = 'inherit';

@Injectable({
  providedIn: 'root'
})
export class SeverityService {

  constructor() { }

  getIssueSeverityLevel(order: IKpiListingResult | ISupplyShipment | IInventory ) {
    if (order.issues && order.issues.find(x=>x.severity == 3 && x.status !=='closed')) {
      return Severity.High;
    }
    if (order.issues && order.issues.find(x=>x.severity == 2 && x.status !=='closed')) { 
      return Severity.Medium;
    }
    if (order.issues && order.issues.length && order.issues.find(x=>x.status !=='closed')) {
      return Severity.Warn;
    }
    return Severity.None;
  }

  getSeverityLevelForIssues(issues: IIssue[]): Severity {
    if (issues.find(x=>x.severity == 3 && x.status !=='closed')) {
      return Severity.High;
    }
    if (issues.find(x=>x.severity == 2 && x.status !=='closed')) {
      return Severity.Medium;
    }
    if (issues.length && issues.find(x=>x.status !=='closed')) {
      return Severity.Warn;
    }
    return Severity.None;
  }

  getSeverityBackgroundColor(severity: Severity): string {
    switch (severity) {
      case Severity.High:
        return '#CA0000';
      case Severity.Medium:
        return '#f5af00'
      case Severity.Warn:
        return '#FFF000';
      default: 
        return defaultBackgroundColor;
    }
  }

  getSeverityForegroundColor(severity: Severity): string {
    switch (severity) {
      case Severity.High:
        return '#FFF';
      case Severity.Medium:
        return '#FFF'
      case Severity.Warn:
        return '#000';
      default: 
        return 'inherit';
    }
  }
}
