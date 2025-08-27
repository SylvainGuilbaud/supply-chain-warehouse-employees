export interface ILocation {
    uid:string;
    name:string;
    type:string;
    status:string;
    street:string;
    city:string;
    stateProvince:string;
    country:string;
    postalCode?:string;
    coordinates?:string;
    latitude?:string;
    longitude?:string;
    recordCreatedTime:string;
    lastUpdatedTime:string;
}