export enum BreadcrumbSectionEnum {
  Orders,
  Shipments,
  Inventory,
  Manufacturing,
}

export interface IBreadcrumbNotification {
  section: BreadcrumbSectionEnum;
  crumbs: breadcrumbPart[];
}

export interface breadcrumbPart {
    title:string;
    routerLink?:string;
  }