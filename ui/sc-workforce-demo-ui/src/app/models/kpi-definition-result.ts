export interface IKpiDefinition {
    name: string;
    label: string;
    description: string;
    type: string;
    baseObject: string;
    status: string
    watchingThreshold?: number;
    warningThreshold?: number;
    deepseeKpiSpec: IDeepseeKpiSpec;
}

export interface IDeepseeKpiSpec {
    namespace: string;
    cube:string;
    kpiMeasure: string;
    valueType: string;
    kpiDimensions: IDimension[];
}

export interface IDimension {
    name: string;
    cubeDimension: string;
    label: string;
}