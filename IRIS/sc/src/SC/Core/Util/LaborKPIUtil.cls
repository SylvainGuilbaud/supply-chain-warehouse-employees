Class SC.Core.Util.LaborKPIUtil
{

Parameter ISSUECOUNTKPI = "{
        ""name"": ""IssueCount"",
        ""label"": ""Total Issues"",
        ""description"": ""The total count of supply chain issues, regardless of the status"",
        ""type"": ""DeepSee"",
        ""baseObject"": ""Issue"",
        ""status"": ""Active"",
        ""issueKpi"": false,
        ""deepseeKpiSpec"": {
            ""namespace"": ""SC"",
            ""cube"": ""IssueCube"",
            ""kpiMeasure"": ""%COUNT"",
            ""valueType"": ""raw"",
            ""kpiDimensions"": [
                {
                    ""name"": ""status"",
                    ""label"": ""Issue Status"",
                    ""cubeDimension"": ""[status].[H1].[status]""
                },
                {
                    ""name"": ""country"",
                    ""label"": ""Impacted Country"",
                    ""cubeDimension"": ""[issueLocation].[H1].[country]""
                },
                {
                    ""name"": ""severity"",
                    ""label"": ""Issue Severity"",
                    ""cubeDimension"": ""[severity].[H1].[severity]""
                },
                {
                    ""name"": ""objectType"",
                    ""label"": ""Impacted Object type"",
                    ""cubeDimension"": ""[impactedObjectType].[H1].[impactedObjectType]""
                },
                {
                    ""name"": ""category"",
                    ""label"": ""Issue Category"",
                    ""cubeDimension"": ""[issueCategory].[H1].[issueCategory]""
                }
            ]
        }
    }";

Parameter UNDERSTAFFINGKPI = "{
    ""name"": ""Understaffing"",
    ""label"": ""Understaffing"",
    ""description"": ""Labor supply lower than demand"",
    ""type"": ""DeepSee"",
    ""baseObject"": ""LaborDeficit"",
    ""status"": ""Active"",
    ""issueKpi"": true,
    ""defaultIssueSeverity"": 3,
    ""deepseeKpiSpec"": {
        ""namespace"": ""SC"",
        ""cube"": ""LaborDeficitCube"",
        ""kpiMeasure"": ""%COUNT"",
        ""valueType"": ""raw"",
        ""kpiConditions"": [
            ""[status].[H1].[status].&[Understaffed]""
        ],
        ""kpiDimensions"": [
            {
                ""name"": ""location"",
                ""label"": ""Location"",
                ""cubeDimension"": ""[locationId].[H1].[locationId]""
            },
            {
                ""name"": ""laborProfile"",
                ""label"": ""LaborProfile"",
                ""cubeDimension"": ""[productId].[H1].[productId]""
            },
            {
                ""name"": ""date"",
                ""label"": ""Date"",
                ""cubeDimension"": ""[startDate].[H1].[startDate]""
            }
        ]
    }
}";

Parameter OVERSTAFFINGKPI = "{
    ""name"": ""Overstaffing"",
    ""label"": ""Overstaffing"",
    ""description"": ""Labor supply higher than demand"",
    ""type"": ""DeepSee"",
    ""baseObject"": ""LaborDeficit"",
    ""status"": ""Active"",
    ""issueKpi"": true,
    ""defaultIssueSeverity"": 3,
    ""deepseeKpiSpec"": {
        ""namespace"": ""SC"",
        ""cube"": ""LaborDeficitCube"",
        ""kpiMeasure"": ""%COUNT"",
        ""valueType"": ""raw"",
        ""kpiConditions"": [
            ""[status].[H1].[status].&[Overstaffed]""
        ],
        ""kpiDimensions"": [
            {
                ""name"": ""location"",
                ""label"": ""Location"",
                ""cubeDimension"": ""[locationId].[H1].[locationId]""
            },
            {
                ""name"": ""laborProfile"",
                ""label"": ""LaborProfile"",
                ""cubeDimension"": ""[productId].[H1].[productId]""
            },
            {
                ""name"": ""date"",
                ""label"": ""Date"",
                ""cubeDimension"": ""[startDate].[H1].[startDate]""
            }
        ]
    }
}";

Parameter STAFFINGISSUEKPI = "{
    ""name"": ""StaffingIssue"",
    ""label"": ""Staffing Issue"",
    ""description"": ""Labor supply different than demand"",
    ""type"": ""DeepSee"",
    ""baseObject"": ""LaborDeficit"",
    ""status"": ""Active"",
    ""issueKpi"": false,
    ""defaultIssueSeverity"": 3,
    ""deepseeKpiSpec"": {
        ""namespace"": ""SC"",
        ""cube"": ""LaborDeficitCube"",
        ""kpiMeasure"": ""%COUNT"",
        ""valueType"": ""raw"",
        ""kpiConditions"": [
            ""[combinedStatus].[H1].[combinedStatus].&[Misstaffed]""
        ],
        ""kpiDimensions"": [
            {
                ""name"": ""location"",
                ""label"": ""Location"",
                ""cubeDimension"": ""[locationId].[H1].[locationId]""
            },
            {
                ""name"": ""laborProfile"",
                ""label"": ""LaborProfile"",
                ""cubeDimension"": ""[productId].[H1].[productId]""
            },
            {
                ""name"": ""date"",
                ""label"": ""Date"",
                ""cubeDimension"": ""[startDate].[H1].[startDate]""
            }
        ]
    }
}";

ClassMethod loadUnderstaffing() As %Status
{
    set body = ##class(%DynamicAbstractObject).%FromJSON(..#UNDERSTAFFINGKPI)
    set obj = ##class(SC.Core.Analytics.KPI.KpiDefinition).%New()
    set st = obj.%JSONImport(body)
    if $$$ISERR(st) return st
    set st = obj.%Save()
    return st
}

ClassMethod loadOverstaffing() As %Status
{
    set body = ##class(%DynamicAbstractObject).%FromJSON(..#OVERSTAFFINGKPI)
    set obj = ##class(SC.Core.Analytics.KPI.KpiDefinition).%New()
    set st = obj.%JSONImport(body)
    if $$$ISERR(st) return st
    set st = obj.%Save()
    return st
}

ClassMethod loadStaffingIssue() As %Status
{
    set body = ##class(%DynamicAbstractObject).%FromJSON(..#STAFFINGISSUEKPI)
    set obj = ##class(SC.Core.Analytics.KPI.KpiDefinition).%New()
    set st = obj.%JSONImport(body)
    if $$$ISERR(st) return st
    set st = obj.%Save()
    return st
}

ClassMethod loadIssueCount() As %Status
{
    set body = ##class(%DynamicAbstractObject).%FromJSON(..#ISSUECOUNTKPI)
    set obj = ##class(SC.Core.Analytics.KPI.KpiDefinition).%New()
    set st = obj.%JSONImport(body)
    if $$$ISERR(st) return st
    set st = obj.%Save()
    return st
}

ClassMethod loadLaborKPIs() As %Status
{
    set st1 = ..loadUnderstaffing()
    set st2 = ..loadOverstaffing()
    set st3 = ..loadStaffingIssue()
    set st4 = ..loadIssueCount()
    if $$$ISERR(st1) return st1
    if $$$ISERR(st2) return st2
    if $$$ISERR(st3) return st3
    if $$$ISERR(st4) return st4
    return $$$OK
}

}
