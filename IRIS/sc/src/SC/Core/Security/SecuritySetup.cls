Class SC.Core.Security.SecuritySetup
{

ClassMethod setupSecurity() As %Status
{
        set sc = ..createResources()
        $$$ThrowOnError(sc)

        set sc = ..createRoles()
        $$$ThrowOnError(sc)

        return $$$OK
}

ClassMethod createResources() As %Status
{
    new $Namespace
    set $Namespace="%SYS"

    if '##class(Security.Resources).Exists("SC_BI_API") {
        set sc = ##class(Security.Resources).Create("SC_BI_API", "Controls API for supply chain analytics", "U")
        if $$$ISERR(sc) QUIT sc
    }

    if '##class(Security.Resources).Exists("SC_Data_API") {
        set sc = ##class(Security.Resources).Create("SC_Data_API", "Controls API for CRUD operations of the supply chain database", "U")
        if $$$ISERR(sc) QUIT sc
    }

    if '##class(Security.Resources).Exists("SC_Data_Model_API") {
        set sc = ##class(Security.Resources).Create("SC_Data_Model_API", "Controls API for customizing the schema of SC database", "U")
        if $$$ISERR(sc) QUIT sc
    }
    
    if '##class(Security.Resources).Exists("SC_Cloud_Service_API") {
        set sc = ##class(Security.Resources).Create("SC_Cloud_Service_API", "Controls API for Cloud Services", "U")
        if $$$ISERR(sc) QUIT sc
    }

    return $$$OK
}

ClassMethod createRoles() As %Status
{
    new $Namespace
    set homeNameSpace = $Namespace
    
    set $Namespace="%SYS"
    set sc=##Class(Config.Namespaces).Get(homeNameSpace, .properties)
    if $$$ISERR(sc) QUIT sc
    set globalDbName = properties("Globals")
    set routinesDbName = properties("Routines")
    set globalDbResource = "%DB_"_globalDbName
    if '##class(Security.Resources).Exists(globalDbResource) {
        set globalDbResource = "%DB_%default"
    }
    set dbResourceNameRW = globalDbResource_":RWU"
    set dbResourceNameRO = globalDbResource_":RU"
    if (routinesDbName'=globalDbName) {
        set routinesDbResource = "%DB_"_routinesDbName
        if '##class(Security.Resources).Exists(routinesDbResource) {
            set routinesDbResource = "%DB_%default"
        }
        if (routinesDbResource '= globalDbResource) {
            set dbResourceNameRW = dbResourceNameRW_routinesDbResource_":RWU"
            set dbResourceNameRO = dbResourceNameRO_routinesDbResource_":RU"
        }                     
    }
    set scApiCrudResources = dbResourceNameRW_",%Service_SQL:U,SC_BI_API:RWU,SC_Data_Model_API:RWU,SC_Data_API:RWU,%DB_IRISLIB:R,%DB_IRISLOCALDATA:R,%DB_IRISTEMP:RW,%DB_IRISSYS:RW"
    set scApiRoResesources = dbResourceNameRO_",%Service_SQL:U,SC_BI_API:U,SC_Data_Model_API:RU,SC_Data_API:R,%DB_IRISLIB:R,%DB_IRISLOCALDATA:R,%DB_IRISTEMP:RW,%DB_IRISSYS:RW"
    set scApiAnalyticsResources = dbResourceNameRW_",%DB_IRISLIB:R,%DB_IRISLOCALDATA:R,%DB_IRISTEMP:RW,%Development:U,%DocDB_Admin:U,%Service_Console:U,%Service_DocDB:U,%Service_Native:U,%Service_Object:U,%Service_SQL:U,%Service_Telnet:U,%Service_Terminal:U,%Service_WebGateway:U,%System_CallOut:U,%DB_IRISSYS:RW"
    set scApiDatamodelAdminResources = dbResourceNameRW_",%Service_SQL:U,SC_Data_Model_API:RWU,SC_Data_API:RWU,%DB_IRISLIB:R,%DB_IRISLOCALDATA:R,%DB_IRISTEMP:RW,%DB_IRISSYS:RW"
    set scDeveloperResources = dbResourceNameRW_",%Service_SQL:U,SC_Data_Model_API:RWU,SC_Data_API:RWU,%DB_IRISLIB:R,%DB_IRISLOCALDATA:R,%DeepSee_Analyzer:U,%DeepSee_AnalyzerEdit:U,%DeepSee_Architect:U,%DeepSee_ListingGroup:U,%DeepSee_Portal:U,%DeepSee_ReportBuilder:U,SC_BI_API:RWU,%Ens_Alerts,%Ens_Code,%Ens_DTL,%Ens_DTLTest,%Ens_Dashboard,%Ens_EDISchema,%Ens_EDISchemaAnnotations,%Ens_ITK,%Ens_Jobs,%Ens_LookupTables,%Ens_MessageContent,%Ens_MessageDiscard,%Ens_MessageEditResend,%Ens_MessageSuspend,%Ens_MsgBank_MessageEditResend,%Ens_Portal:U,%Ens_ProductionConfig,%Ens_ProductionDocumentation,%Ens_PubSub,%Ens_Purge,%Ens_Queues,%Ens_RuleLog,%Ens_Rules,%Ens_TestingService,%Ens_ViewFileSystem,%Ens_WorkflowConfig,%DB_IRISTEMP:RW"
    set scInterOpDevResources = dbResourceNameRW_",%Service_SQL:U,SC_Data_Model_API:RWU,%DB_IRISLIB:R,%DB_IRISLOCALDATA:R,SC_Data_API:RWU,SC_BI_API:RWU,%Ens_Alerts,%Ens_Code,%Ens_DTL,%Ens_DTLTest,%Ens_Dashboard,%Ens_EDISchema,%Ens_EDISchemaAnnotations,%Ens_ITK,%Ens_Jobs,%Ens_LookupTables,%Ens_MessageContent,%Ens_MessageDiscard,%Ens_MessageEditResend,%Ens_MessageSuspend,%Ens_MsgBank_MessageEditResend,%Ens_Portal:U,%Ens_ProductionConfig,%Ens_ProductionDocumentation,%Ens_PubSub,%Ens_Purge,%Ens_Queues,%Ens_RuleLog,%Ens_Rules,%Ens_TestingService,%Ens_ViewFileSystem,%Ens_WorkflowConfig,%DB_IRISTEMP:RW,%DB_IRISSYS:RW"
    set scDataArchitectResources = dbResourceNameRW_",%Service_SQL:U,SC_Data_Model_API:RWU,SC_Data_API:RWU,%DB_IRISLIB:R,%DB_IRISLOCALDATA:R,%DeepSee_Analyzer:U,%DeepSee_AnalyzerEdit:U,%DeepSee_Architect:U,%DeepSee_ListingGroup:U,%DeepSee_Portal:U,%DeepSee_ReportBuilder:U,SC_BI_API:RWU,%DB_IRISTEMP:RW,%DB_IRISSYS:RW"
    set scDataAnalystResoures = dbResourceNameRW_",%DeepSee_Analyzer:U,%DeepSee_AnalyzerEdit:U,%DeepSee_Architect:U,%DeepSee_ListingGroup:U,%DeepSee_Portal:U,%DeepSee_ReportBuilder:U,%Service_SQL:U,SC_Data_Model_API:RU,SC_Data_API:RWU,%DB_IRISTEMP:RW,%DB_IRISSYS:RW"
    set scBusinessUserResources = dbResourceNameRO_",%DB_IRISLIB:R,%DB_IRISLOCALDATA:R,%DeepSee_Analyzer:U,%DeepSee_Architect:U,%DeepSee_ListingGroup:U,%DeepSee_Portal:U,%Service_SQL:U,SC_Data_Model_API:RU,SC_Data_API:RU,%DB_IRISTEMP:RW,%DB_IRISSYS:RW"
    set scSysAdminResources = dbResourceNameRO_",%DB_IRISLIB:R,%DB_IRISLOCALDATA:R,%DB_IRISTEMP:R"
    set scApiCloudServiceResources = dbResourceNameRW_",%Service_SQL:U,SC_BI_API:RWU,SC_Data_Model_API:RWU,SC_Data_API:RWU,%DB_IRISLIB:R,%DB_IRISLOCALDATA:R,%DB_IRISTEMP:RW,%DB_IRISSYS:RW,SC_Cloud_Service_API:RWU"

    if ##class(Security.Roles).Exists("SC_API_CRUD") {
        set roleProperties("Resources") = scApiCrudResources
        set roleProperties("GrantedRoles") = ""
        set sc = ##class(Security.Roles).Modify("SC_API_CRUD", .roleProperties)
        if $$$ISERR(sc) QUIT sc
    } else {
        set sc = ##class(Security.Roles).Create("SC_API_CRUD", "Call API to perform CRUD on supply chain DB", scApiCrudResources, "")
        if $$$ISERR(sc) QUIT sc
    }

    if ##class(Security.Roles).Exists("SC_API_RO") {
        set roleProperties("Resources") = scApiRoResesources
        set roleProperties("GrantedRoles") = ""
        set sc = ##class(Security.Roles).Modify("SC_API_RO", .roleProperties)
        if $$$ISERR(sc) QUIT sc
    } else {
        set sc = ##class(Security.Roles).Create("SC_API_RO", "Call API to perform Read only on supply chain DB", scApiRoResesources, "")
        if $$$ISERR(sc) QUIT sc
    }

    if ##class(Security.Roles).Exists("SC_API_Analytics") {
        set roleProperties("Resources") = scApiAnalyticsResources
        set roleProperties("GrantedRoles") = ""
        set sc = ##class(Security.Roles).Modify("SC_API_Analytics", .roleProperties)
        if $$$ISERR(sc) QUIT sc
    } else {
        set sc = ##class(Security.Roles).Create("SC_API_Analytics", "Call API to perform Analytics on supply chain DB", scApiAnalyticsResources, "")
        if $$$ISERR(sc) QUIT sc
    }

    if ##class(Security.Roles).Exists("SC_API_Datamodel_Admin") {
        set roleProperties("Resources") = scApiDatamodelAdminResources
        set roleProperties("GrantedRoles") = ""
        set sc = ##class(Security.Roles).Modify("SC_API_Datamodel_Admin", .roleProperties)
        if $$$ISERR(sc) QUIT sc
    } else {
        set sc = ##class(Security.Roles).Create("SC_API_Datamodel_Admin", "Call API to edit DB schema", scApiDatamodelAdminResources, "")
        if $$$ISERR(sc) QUIT sc
    }

    if ##class(Security.Roles).Exists("SC_API_CloudService") {
        set roleProperties("Resources") = scApiCloudServiceResources
        set roleProperties("GrantedRoles") = ""
        set sc = ##class(Security.Roles).Modify("SC_API_CloudService", .roleProperties)
        if $$$ISERR(sc) QUIT sc
    } else {
        set sc = ##class(Security.Roles).Create("SC_API_CloudService", "Call API for cloud services", scApiCloudServiceResources, "")
        if $$$ISERR(sc) QUIT sc
    }

    if ##class(Security.Roles).Exists("SC_Developer") {
        set roleProperties("Resources") = scDeveloperResources
        set roleProperties("GrantedRoles") = ""
        set sc = ##class(Security.Roles).Modify("SC_Developer", .roleProperties)
        if $$$ISERR(sc) QUIT sc
    } else {
        set sc = ##class(Security.Roles).Create("SC_Developer", "Supply Chain Developer", scDeveloperResources, "")
        if $$$ISERR(sc) QUIT sc
    }

    if ##class(Security.Roles).Exists("SC_InterOp_Dev") {
        set roleProperties("Resources") = scInterOpDevResources
        set roleProperties("GrantedRoles") = ""
        set sc = ##class(Security.Roles).Modify("SC_InterOp_Dev", .roleProperties)
        if $$$ISERR(sc) QUIT sc
    } else {
        set sc = ##class(Security.Roles).Create("SC_InterOp_Dev", "Supply Chain Interoperability Developer", scInterOpDevResources, "")
        if $$$ISERR(sc) QUIT sc
    }

    if ##class(Security.Roles).Exists("SC_Data_Architect") {
        set roleProperties("Resources") = scDataArchitectResources
        set roleProperties("GrantedRoles") = ""
        set sc = ##class(Security.Roles).Modify("SC_Data_Architect", .roleProperties)
        if $$$ISERR(sc) QUIT sc
    } else {
        set sc = ##class(Security.Roles).Create("SC_Data_Architect", "Supply Chain Data Architect Developer", scDataArchitectResources, "")
        if $$$ISERR(sc) QUIT sc
    }

    if ##class(Security.Roles).Exists("SC_Data_Analyst") {
        set roleProperties("Resources") = scDataAnalystResoures
        set roleProperties("GrantedRoles") = ""
        set sc = ##class(Security.Roles).Modify("SC_Data_Analyst", .roleProperties)
        if $$$ISERR(sc) QUIT sc
    } else {
        set sc = ##class(Security.Roles).Create("SC_Data_Analyst", "Supply Chain Data Analyst - no coding", scDataAnalystResoures, "")
        if $$$ISERR(sc) QUIT sc
    }

    if ##class(Security.Roles).Exists("SC_Business_User") {
        set roleProperties("Resources") = scBusinessUserResources
        set roleProperties("GrantedRoles") = ""
        set sc = ##class(Security.Roles).Modify("SC_Business_User", .roleProperties)
        if $$$ISERR(sc) QUIT sc
    } else {
        set sc = ##class(Security.Roles).Create("SC_Business_User", "Supply Chain business user", scBusinessUserResources, "")
        if $$$ISERR(sc) QUIT sc
    }

    if ##class(Security.Roles).Exists("SC_Sys_Admin") {
        set roleProperties("Resources") = scSysAdminResources
        set roleProperties("GrantedRoles") = "%Manager"
        set sc = ##class(Security.Roles).Modify("SC_Sys_Admin", .roleProperties)
        if $$$ISERR(sc) QUIT sc
    } else {
        set sc = ##class(Security.Roles).Create("SC_Sys_Admin", "Supply Chain System Admin", scSysAdminResources, "%Manager")
        if $$$ISERR(sc) QUIT sc
    }
    return $$$OK
}

ClassMethod checkAndGrantSQLTableReadPrivilege(obj As %String) As %Status
{
    if '##class(%SYSTEM.SQL.Security).CheckPrivilege($USERNAME, 1, obj, "s", $NAMESPACE)
    {
        set st = ##class(%SYSTEM.SQL.Security).GrantPrivilege("Select", obj, "Table", $USERNAME)
    }
    return $$$OK
}

}
