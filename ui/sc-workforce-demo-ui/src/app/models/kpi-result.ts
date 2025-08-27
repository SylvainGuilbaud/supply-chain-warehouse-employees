export interface IKpiResult {
    kpiName: string;
    expandDimension?: string;
    values: IKpiResultValue[];
}

export interface IKpiResultValue {
    label: string;
    value: number;
}