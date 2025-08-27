/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Util.KpiIssueUtil
{

/// Create and/or update issues related to a KPI. 
ClassMethod updateIssuesForKpi(kpiDef As SC.Core.Analytics.KPI.KpiDefinition, Output totalCount As %Integer, Output newCount As %Integer, Output existCount As %Integer, Output closedCount As %Integer) As %Status
{
    
    if ((kpiDef.name = "Overstaffing") || (kpiDef.name = "Understaffing"))
    {
        
        do ..updateStaffingIssuesForKpi(kpiDef, .totalCount, .newCount, .existCount, .closedCount)
        quit $$$OK
    }
    
    Set sc = $$$OK
    if kpiDef = "" {
        return $$$ERROR("Empty KPI definition")
    }
    if kpiDef.issueKpi = 0 {
        set newCount = 0
        set closedCount = 0
        return sc
    }

    set dimList = ""
    set valueList = ""
    set mdx =  ##class(SC.Core.API.KPI.KpiApiImpl).ConstructDrillThroughMdx(kpiDef, 0, dimList, valueList)
    set rset =  ##class(SC.Core.API.KPI.KpiApiImpl).ExecuteMdxQuery(mdx)
    set idSelect =  ##class(SC.Core.API.KPI.KpiApiImpl).ExtractDrillThroughSelect(rset)
    set rs = ##class(%SQL.Statement).%ExecDirect(,idSelect)
    if rs.%SQLCODE < 0 {
        return $$$ERROR($$$SQLCode,rs.SQLCODE,rs.%Message)
    }
    set newCount = 0
    set existCount = 0
    set closedCount = 0
    set uidList = ##class(%ListOfDataTypes).%New()
    set issueClass = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName("Issue")
	while rs.%Next() {
        set objId = rs.%Get("_DSsourceId")
        set uid = ##class(SC.Core.Util.ScObjectUtil).getObjectUidById(kpiDef.baseObject, objId)
        do uidList.Insert(uid)
        set issExist = ..checkKpiIssueExist(kpiDef.name, uid)
        if issExist = 0 {
            // set iss = ##class(SC.Core.Data.Internal.Issue).%New()
            set iss = $System.OBJ.New(issueClass)
            set iss.uid = $System.Util.CreateGUID()
            set iss.description = kpiDef.description
            set iss.triggerType = iss.#TRIGGERKPI
            set iss.triggerObjectId = kpiDef.name
            set iss.impactedObjectType = kpiDef.baseObject
            set iss.impactedObjectId = uid
            set iss.processName = kpiDef.analysisService
            set iss.severity = kpiDef.defaultIssueSeverity
            set iss.status = iss.#STATUSOPEN
            set sc =  iss.%Save()
            if $$$ISOK(sc) {
                set newCount = newCount +1
            }
        }
        else {
            set existCount = existCount + 1
        }
    }   
    set totalCount =  uidList.Count()
    set closedCount = ..processDatedKpiIssues(kpiDef, .uidList)
    Return sc
}

/// Create and/or update issues related to a KPI. 
ClassMethod updateStaffingIssuesForKpi(kpiDef As SC.Core.Analytics.KPI.KpiDefinition, Output totalCount As %Integer, Output newCount As %Integer, Output existCount As %Integer, Output closedCount As %Integer) As %Status
{
    Set sc = $$$OK

    if kpiDef = "" {
        return $$$ERROR("Empty KPI definition")
    }
    if kpiDef.issueKpi = 0 {
        set newCount = 0
        set closedCount = 0
        return sc
    }

    set dimList = ""
    set valueList = ""
    set mdx =  ##class(SC.Core.API.KPI.KpiApiImpl).ConstructDrillThroughMdx(kpiDef, 0, dimList, valueList)
    set rset =  ##class(SC.Core.API.KPI.KpiApiImpl).ExecuteMdxQuery(mdx)
    set idSelect =  ##class(SC.Core.API.KPI.KpiApiImpl).ExtractDrillThroughSelect(rset)
    set rs = ##class(%SQL.Statement).%ExecDirect(,idSelect)
    if rs.%SQLCODE < 0 {
        return $$$ERROR($$$SQLCode,rs.SQLCODE,rs.%Message)
    }
    set newCount = 0
    set existCount = 0
    set closedCount = 0
    set uidList = ##class(%ListOfDataTypes).%New()
    set map = ##class(%Library.ArrayOfDataTypes).%New()
    set issueClass = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName("Issue")
	while rs.%Next() {
        set objId = rs.%Get("_DSsourceId")
        set uid = ##class(SC.Core.Util.ScObjectUtil).getObjectUidById(kpiDef.baseObject, objId)
        set ^Test($h) = uid
        set issExist = ..checkKpiIssueExist(kpiDef.name, $extract(uid,4,30))
        set ^Test($h) = issExist
        if issExist = 0 {
            do uidList.Insert($extract(uid,4,30))
            // set iss = ##class(SC.Core.Data.Internal.Issue).%New()
            set iss = $System.OBJ.New(issueClass)
            set iss.uid = $System.Util.CreateGUID()
            do map.SetAt(iss.uid, $extract(uid,4,30))
            set iss.description = kpiDef.description
            set iss.triggerType = iss.#TRIGGERKPI
            set iss.triggerObjectId = kpiDef.name
            set iss.impactedObjectType = kpiDef.baseObject
            set iss.impactedObjectId = $extract(uid,4,30)
            set iss.issueData = uid
            set iss.processName = kpiDef.analysisService
            set iss.severity = kpiDef.defaultIssueSeverity
            set iss.status = iss.#STATUSOPEN
            set sc =  iss.%Save()
            if $$$ISOK(sc) {
                set newCount = newCount +1
            }
        }
        else {
            set iss = ##class(SC.Data.Issue).uidIndexOpen(map.GetAt($extract(uid,4,30)))
            set iss.issueData = iss.issueData _ "," _ uid
            do iss.%Save()
            set existCount = existCount + 1
        }
    }   
    set totalCount =  uidList.Count()
    set closedCount = ..processDatedKpiIssues(kpiDef, .uidList)
    Return sc
}

/// Check all existing issues for a given KPI, and close out those no longer part of the KPI listing
ClassMethod processDatedKpiIssues(kpiDef As SC.Core.Analytics.KPI.KpiDefinition, uidList As %ListOfDataTypes) As %Integer
{
    set count = 0
    if (kpiDef '= "") && (uidList '= "") {
        set tablename = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName("Issue")
        set sql="select ID,impactedObjectId from "_tablename_" where triggerObjectId = ? "_
                "AND triggerType = '"_##class(SC.Core.Data.Internal.Issue).#TRIGGERKPI_"' "
        set rs = ##class(%SQL.Statement).%ExecDirect(,sql, kpiDef.name)
        if rs.%SQLCODE < 0 {
            $$$ThrowStatus($$$ERROR($$$SQLCode,rs.SQLCODE,rs.%Message))
        }
        if ( rs.%SQLCODE = 0 ) {
            while ( rs.%Next() '= 0 ) {
                set iid = rs.%Get("ID")
                set uid = rs.%Get("impactedObjectId")
                if uidList.Find(uid,0) = "" {
                    // Issue no longer match the KPI condition
                    set iss = ##class(SC.Core.Util.ScObjectUtil).getObjectById("Issue",iid)
                    //set iss = ##class(SC.Core.Data.Internal.Issue).%OpenId(iid)
                    if iss.status '= iss.#STATUSCLOSED {
                        // Only update the issue if it is not closed yet
                        set iss.status = iss.#STATUSCLOSED
                        set iss.resolutionType = iss.#RESOLUTIONNOLONGERVALID
                        set iss.resolutionUser = "SYSTEM"
                        do iss.%Save()
                        set count = count +1
                    }
                }
            }
        }
    }
    return count
}

/// Check if a issue already exist for a KPI with a given target object ID
ClassMethod checkKpiIssueExist(kpiName As %String, uid As %String) As %Integer
{
    set ret = 0
    if (kpiName '= "") && (uid '= "") {
        set tablename = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName("Issue")
        set sql="select ID from "_tablename_" where triggerObjectId = ? and impactedObjectId = ?"
        set rs = ##class(%SQL.Statement).%ExecDirect(,sql, kpiName, uid)
        if rs.%SQLCODE < 0 {
            $$$ThrowStatus($$$ERROR($$$SQLCode,rs.SQLCODE,rs.%Message))
        }
        if ( rs.%SQLCODE = 0 ) {
            if ( rs.%Next() '= 0 ) {
                set ret = 1
            }
        }
    }
    return ret
}

}
