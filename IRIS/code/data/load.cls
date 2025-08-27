Class data.load
{

/*
    LOAD DATA FROM FILE '/external/csv/Product 
    referential.csv' INTO CGIFTE_Persistent.Products USING {"from":{"file":{"header":true}}}

    LOAD DATA FROM FILE '/external/csv/Sales_receipts/Sales_receipts_STORE_WHS1.csv' INTO CGIFTE_Persistent.SalesData USING {"from":{"file":{"header":true}}}

    LOAD DATA FROM FILE '/external/csv/Sales_receipts/Sales_receipts_WEB_WHS1.csv' INTO CGIFTE_Persistent.SalesData USING {"from":{"file":{"header":true}}}

    in WHS1 and

    LOAD DATA FROM FILE '/external/csv/Product referential.csv' INTO CGIFTE_Persistent.Products USING {"from":{"file":{"header":true}}}

    LOAD DATA FROM FILE '/external/csv/Sales_receipts/Sales_receipts_STORE_WHS1.csv' INTO CGIFTE_Persistent.SalesData USING {"from":{"file":{"header":true}}}

    LOAD DATA FROM FILE '/external/csv/Sales_receipts/Sales_receipts_WEB_WHS1.csv' INTO CGIFTE_Persistent.SalesData USING {"from":{"file":{"header":true}}}
    */
ClassMethod init(pPath As %String = "/home/irisowner/dev/data/") As %Status
{
        set ns=$NAMESPACE
        Set sc = $$$OK


        set path = pPath


        zn "WHS1"

        for table ="CGIFTE_Persistent.Products", "CGIFTE_Persistent.SalesData"
        {
            set sc = ..purge(table)
        }

        set sc = ..LoadFromCSV(path_"Product referential.csv","CGIFTE_Persistent.Products")
        set sc = ..LoadFromCSV(path_"Sales_receipts/Sales_receipts_STORE_WHS1.csv","CGIFTE_Persistent.SalesData")
        set sc = ..LoadFromCSV(path_"Sales_receipts/Sales_receipts_WEB_WHS1.csv","CGIFTE_Persistent.SalesData")

        zn "WHS2"

         for table = "CGIFTE_Persistent.Products", "CGIFTE_Persistent.SalesData"
        {
            set sc = ..purge(table)
        }

        set sc = ..LoadFromCSV(path_"Product referential.csv","CGIFTE_Persistent.Products")
        set sc = ..LoadFromCSV(path_"Sales_receipts/Sales_receipts_STORE_WHS2.csv","CGIFTE_Persistent.SalesData")
        set sc = ..LoadFromCSV(path_"Sales_receipts/Sales_receipts_WEB_WHS2.csv","CGIFTE_Persistent.SalesData")

        zn ns
        Return sc
}

ClassMethod LoadFromCSV(pPath As %String, pTable As %String) As %Status
{
    Set sql = "LOAD DATA FROM FILE '"_pPath_"' INTO "_pTable_" USING {""from"":{""file"":{""header"":true}}}"
   

    
    Set stmt = ##class(%SQL.Statement).%New()
    Set sc = stmt.%Prepare(sql)  
    if 'sc {
        write "Failed to prepare SQL statement: ", sql, !
        Return $System.Status.Error(5000,"SQL PREPARE failed")
    } else {
        Set r = stmt.%Execute() 
        if 'r {
            write "Failed to execute SQL statement: ", sql, !
            Return $System.Status.Error(5001,"SQL EXECUTE failed")
        }
        #; write "SQL EXECUTE succeeded: ", sql _ "%SQLCODE:"_r.%SQLCODE
    }

    set msg = $NAMESPACE _":"_r.%ROWCOUNT _ " lines inserted into "_pTable
    write msg,!
    do ##class(%SYS.System).WriteToConsoleLog(msg)
    return $$$OK
}

/// Description
ClassMethod purge(pTable As %String) As %Status
{
    Set sc = $$$OK
       // Delete all previous data from the table
        Set deleteSQL = "TRUNCATE TABLE "_pTable
        Set deleteStmt = ##class(%SQL.Statement).%New()
        Set sc = deleteStmt.%Prepare(deleteSQL)
        If 'sc {
            write "Failed to prepare DELETE SQL statement: ", deleteSQL, !
            Return $System.Status.Error(5002,"SQL DELETE PREPARE failed")
        } Else {
            Set deleteResult = deleteStmt.%Execute()
            If 'deleteResult {
                write "Failed to execute DELETE SQL statement: ", deleteSQL, !
                Return $System.Status.Error(5003,"SQL DELETE EXECUTE failed")
            }
            write $NAMESPACE _": all lines deleted from "_pTable,!
        }
    Return sc
}

}
