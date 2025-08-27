/*
Copyright (c) 2025 by InterSystems Corporation.
Boston, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Include Ensemble

Class SC.Core.Util.LaborProductionUtil
{

ClassMethod startProduction() As %Status
{
    // This class is called on close so starting the production will not impact the rollback when anything else fails
    set sc = $$$OK
    set sql = "SELECT ID FROM Ens_Config.Production WHERE ID != 'SC.Core.BP.LaborProduction'"
    set tStatement = ##class(%SQL.Statement).%New()
    set qStatus = tStatement.%Prepare(sql)
    if qStatus'=1 {
        return qStatus
    }
    set rset = tStatement.%Execute()
    if rset.%SQLCODE<0{
        return $$$ERROR(rset.%SQLCODE)
    }

    do rset.%Next()
    set prodName = "SC.Core.BP.LaborProduction"
    if rset.ID '= ""{
        set prodName = rset.ID
    }

    Set initTLevel = $TLevel
    do ##class(Ens.Director).StartProduction(prodName)

    while $TLevel < initTLevel{
        TStart
    }
    return sc
}

ClassMethod loadProduction() As %Status
{
    set nameSpace = $NAMESPACE

    set sc = ##class(Ens.Director).GetProductionStatus(.prodName, .prodState)
    if prodState = 1{
        set sc = ##class(Ens.Director).StopProduction(5,1)
    }
    if (prodName = "") || (prodName = "SC.Core.BP.LaborProduction"){
        set sql = "SELECT ID FROM Ens_Config.Production WHERE ID != 'SC.Core.BP.LaborProduction'"
        set tStatement = ##class(%SQL.Statement).%New()
        set qStatus = tStatement.%Prepare(sql)
        if qStatus'=1 {
            $$$ThrowOnError(qStatus)
        }
        set rset = tStatement.%Execute()
        if rset.%SQLCODE<0{
            $$$ThrowOnError($$$ERROR(rset.%SQLCODE))
        }

        do rset.%Next()

        if rset.ID = ""{
            do ##class(%Library.EnsembleMgr).SetAutoStart(nameSpace, "SC.Core.BP.LaborProduction")
            do ##class(Ens.Director).UpdateProduction(5, 1)
            return 1
        }
        else{
            set prodName = rset.%Get("ID")
        }
    }
    #; set sc = ..RemoveBusinessItem(prodName, "Bulk Upload Cloud Service Download")
    #; if $$$ISERR(sc) $$$ThrowOnError(sc)
    #; set sc = ..RemoveBusinessItem(prodName, "Bulk Upload Cloud Upload Helper")
    #; if $$$ISERR(sc) $$$ThrowOnError(sc)
    #; set sc = ..RemoveBusinessItem(prodName, "Bulk Upload FTP Download")
    #; if $$$ISERR(sc) $$$ThrowOnError(sc)
    #; set sc = ..RemoveBusinessItem(prodName, "Bulk Upload FTP Upload Helper")
    #; if $$$ISERR(sc) $$$ThrowOnError(sc)
    set sc = ..RemoveBusinessItem(prodName, "SC.Core.BP.Service.SingleIssueBS")
    if $$$ISERR(sc) $$$ThrowOnError(sc)
    set sc = ..RemoveBusinessItem(prodName, "UnderstaffingProcess")
    if $$$ISERR(sc) $$$ThrowOnError(sc)
    set sc = ..RemoveBusinessItem(prodName, "Workflow Operation")
    if $$$ISERR(sc) $$$ThrowOnError(sc)
    #; set sc = ..RemoveBusinessItem(prodName, "Bulk Upload FTP Upload")
    #; if $$$ISERR(sc) $$$ThrowOnError(sc)
    #; set sc = ..RemoveBusinessItem(prodName, "Bulk Upload Save File")
    #; if $$$ISERR(sc) $$$ThrowOnError(sc)
    #; set sc = ..AddBusinessItem(prodName, "Bulk Upload Cloud Service Download", "SC.Core.BP.Service.CloudDownload", , 0, 0, 1, )
    #; if $$$ISERR(sc) $$$ThrowOnError(sc)
    #; set sc = ..AddBusinessItem(prodName, "Bulk Upload Cloud Upload Helper", "SC.Core.BP.Service.CloudUpload", , 0, 0, 1, )
    #; if $$$ISERR(sc) $$$ThrowOnError(sc)
    #; set sc = ..AddBusinessItem(prodName, "Bulk Upload FTP Download", "SC.Core.BP.Service.FTPDownload", , 0, 0, 1, )
    #; if $$$ISERR(sc) $$$ThrowOnError(sc)
    #; set sc = ..AddBusinessItem(prodName, "Bulk Upload FTP Upload Helper", "SC.Core.BP.Service.FTPUpload", , 0, 0, 1, )
    #; if $$$ISERR(sc) $$$ThrowOnError(sc)
    set sc = ..AddBusinessItem(prodName, "SC.Core.BP.Service.SingleIssueBS", "SC.Core.BP.Service.SingleIssueBS", , 1, 0, 1, )
    if $$$ISERR(sc) $$$ThrowOnError(sc)
    set sc = ..AddBusinessItem(prodName, "UnderstaffingProcess", "SC.Core.BP.Process.UnderstaffingProcess", , 1, 0, 2, )
    if $$$ISERR(sc) $$$ThrowOnError(sc)
    set sc = ..AddBusinessItem(prodName, "Workflow Operation", "EnsLib.Background.Workflow.Operation", , 1, 0, 1, )
    if $$$ISERR(sc) $$$ThrowOnError(sc)
    #; set sc = ..AddBusinessItem(prodName, "Bulk Upload FTP Upload", "EnsLib.FTP.PassthroughOperation", , 1, 0, 1, )
    #; if $$$ISERR(sc) $$$ThrowOnError(sc)
    #; set sc = ..AddBusinessItem(prodName, "Bulk Upload Save File", "SC.Core.BP.Operation.FileTransfer", , 1, 0, 1, )
    #; if $$$ISERR(sc) $$$ThrowOnError(sc)
    
    set sc = ##class(%Library.EnsembleMgr).SetAutoStart(nameSpace, prodName)
    if $$$ISERR(sc) $$$ThrowOnError(sc)
    return sc
}

ClassMethod stopProduction()
{
    set sc = ##class(Ens.Director).GetProductionStatus(.activeProd, .prodState)
    set sql = "SELECT ID FROM Ens_Config.Production WHERE ID != 'SC.Core.BP.LaborProduction'"
    set tStatement = ##class(%SQL.Statement).%New()
    set qStatus = tStatement.%Prepare(sql)
    if qStatus'=1 {
        $$$ThrowOnError(qStatus)
    }
    set rset = tStatement.%Execute()
    if rset.%SQLCODE<0{
        $$$ThrowOnError($$$ERROR(rset.%SQLCODE))
    }

    while (rset.%Next()){
        set prodName = rset.ID
        w !,rset.ID

        #; set sc = ..RemoveBusinessItem(prodName, "Bulk Upload Cloud Service Download")
        #; if $$$ISERR(sc) $$$ThrowOnError(sc)
        #; set sc = ..RemoveBusinessItem(prodName, "Bulk Upload Cloud Upload Helper")
        #; if $$$ISERR(sc) $$$ThrowOnError(sc)
        #; set sc = ..RemoveBusinessItem(prodName, "Bulk Upload FTP Download")
        #; if $$$ISERR(sc) $$$ThrowOnError(sc)
        #; set sc = ..RemoveBusinessItem(prodName, "Bulk Upload FTP Upload Helper")
        #; if $$$ISERR(sc) $$$ThrowOnError(sc)
        set sc = ..RemoveBusinessItem(prodName, "Bulk Upload Queue Uploads")
        if $$$ISERR(sc) $$$ThrowOnError(sc)
        set sc = ..RemoveBusinessItem(prodName, "Bulk Upload Process Job")
        if $$$ISERR(sc) $$$ThrowOnError(sc)
        #; set sc = ..RemoveBusinessItem(prodName, "Bulk Upload Cloud Service Upload")
        #; if $$$ISERR(sc) $$$ThrowOnError(sc)
        #; set sc = ..RemoveBusinessItem(prodName, "Bulk Upload FTP Upload")
        #; if $$$ISERR(sc) $$$ThrowOnError(sc)
        #; set sc = ..RemoveBusinessItem(prodName, "Bulk Upload Save File")
        #; if $$$ISERR(sc) $$$ThrowOnError(sc)
        set sc = ##class(Ens.Director).UpdateProduction(5, 1)
        if $$$ISERR(sc) $$$ThrowOnError(sc)
    }
    if activeProd = "SC.Core.BP.LaborProduction"{
        set sc = ##class(Ens.Director).StopProduction(5,1)
        if $$$ISERR(sc) $$$ThrowOnError(sc)
    }
    set sc = ##class(Ens.Director).DeleteProduction("SC.Core.BP.LaborProduction")
    if $$$ISERR(sc) $$$ThrowOnError(sc)
}

ClassMethod AddBusinessItem(pProduction As %String, pName As %String, pClassName As %String, pCategory As %String = "", pEnabled As %Boolean = 1, pLogTraceEvents As %Boolean = 1, pPoolSize As %Integer = 1, pComment As %String = "", callInterval As %Numeric = "") As %Status
{
    Set ret = $$$OK
    Try {
        // Check the mandatories values
        If ((pName '="") && (pClassName '=""))
        {
            Set production = ##class(Ens.Config.Production).%OpenId(pProduction)
            Write !,"Installing "_pName
            Set objItem = ##class(Ens.Config.Item).%New()
            Set objItem.Name = pName
            Set objItem.ClassName = pClassName
            Set objItem.Enabled = pEnabled
            Set objItem.LogTraceEvents = pLogTraceEvents
            Set objItem.Category = pCategory
            Set objItem.PoolSize = pPoolSize
            Set objItem.Comment = pComment
            
            if callInterval '= ""{
                set setting = ##class(SC.Core.API.Data.LaborApiImpl).ConfigureSetting("CallInterval", "Adapter", callInterval)
                Do objItem.Settings.Insert(setting)
            }

            Do production.Items.Insert(objItem)
            Set st = production.%Save()
            kill objItem
            Do ##class(Ens.Director).RestartProduction(0,1)
            Write !,"Item "_pName_" installed."
        }
        Else
        {
            If (pName = "") set attrib = "pName"
            If (pClassName ="") set attrib = "pClassName"

            $$$ThrowOnError($System.Status.Error(406,attrib))
        }
    }
    Catch ex {
        Set ret = ex.AsStatus()
        Write !,"Error #",$System.Status.GetErrorCodes(ret),!
        Write !,$System.Status.GetOneStatusText(ret,1),!
    }

    Quit ret
}

ClassMethod RemoveBusinessItem(pProduction As %String, pName As %String) As %Status
{
    Set ret = $$$OK

    Try {
        If (pName '="")
        {
            If ##class(Ens.Config.Item).NameExists(pProduction,pName,.idItem)
            {
                Set production = ##class(Ens.Config.Production).%OpenId(pProduction)
                Write !,"Removing "_pName
                Set objItem = production.FindItemByConfigName(pName)
                Do production.RemoveItem(objItem)
                Set st = production.%Save()
                kill objItem
                Do ##class(Ens.Director).RestartProduction(0,1)
                Write !,"Item "_pName_" removed"
            }
            Else
            {
                Write !,"Item "_pName_" not found."
            }
        }
        Else
        {
            If (pName = "") set attrib = "pName"

            $$$ThrowOnError($System.Status.Error(406,attrib))
        }
    }
    Catch ex {
        Set ret = ex.AsStatus()
        Write !,"Error #",$System.Status.GetErrorCodes(ret),!
        Write !,$System.Status.GetOneStatusText(ret,1),!
    }

    Quit ret
}

ClassMethod GetBasename(filePath As %String) As %String
{
    set baseName = ##class(%File).GetFilename(filePath)
    return baseName
}

}
