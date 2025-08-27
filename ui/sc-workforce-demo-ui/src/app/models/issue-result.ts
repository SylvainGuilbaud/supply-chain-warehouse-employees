export interface IIssue {
    description: string;
    triggerType: string;
    triggerObjectId:string;
    triggerObjectType?:string;
    impactedObjectType:string;
    impactedObjectId:string;
    severity:number;
    recordCreatedTime:string;
    lastUpdatedTime:string;
    issueCategory?:string;
    issueData?:string;
    processName?:string;
    urgency?:number;
    status:string;
    closeTime?:string;
    resolutionType?:string;
    latestAnalysis?: IAnalysis;
    resolutionNote?:string;
    uid: string;
}

export interface IAnalysis {
    recordCreatedTime:string;
    lastUpdatedTime:string;
    issueId: number;
    runSequence: number;
    processName: string;
    severity: number;
    urgency: number;
    rootCauseAnalysis: string;
    impactAnalysis: string;
    actionTaken:string;
    recommendation: string;
    supportingData: string;
    status: string;
    resolution: string;
    scenarios: IScenario[];
}

export interface IScenario {
    optionNumber:string;
    optionName: string;
    description: string;
    costImpact: number;
    timeImpact: number;
    supportingData: string;
    feasibility: number;
    recommended: number;
}