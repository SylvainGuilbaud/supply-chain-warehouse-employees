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
        set sc = $$$OK
        set path = pPath

        for warehouse = "WHS1","WHS2" {
            zn warehouse    
            for table ="CGIFTE_Persistent.Products", "CGIFTE_Persistent.SalesData"
            {
                set sc = ..purge(table)
            }

            set sc = ..LoadFromCSV(path_"Product referential.csv","CGIFTE_Persistent.Products")
            set sc = ..LoadFromCSV(path_"Sales_receipts/Sales_receipts_STORE_"_warehouse_".csv","CGIFTE_Persistent.SalesData")
            set sc = ..LoadFromCSV(path_"Sales_receipts/Sales_receipts_WEB_"_warehouse_".csv","CGIFTE_Persistent.SalesData")

            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP1','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP5','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP4','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP2','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP10','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP12','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP17','Receive,Load'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP7','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP11','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP20','Receive,Load'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP14','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP19','Receive,Load'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP21','Control'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP18','Receive,Load'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP16','Receive,Load'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP22','Control'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP24','Control'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP25','Control'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP23','Control'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP3','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP13','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP8','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP6','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP15','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP9','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP26','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP27','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP28','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP29','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP30','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP31','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP32','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP33','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP34','Storage,Pick,Prepare'))
            &SQL(INSERT INTO CGIFTE_Persistent.Employee (Available, BusyUntil, EmployeeId, TaskType) VALUES (0,NULL,'EMP35','Storage,Pick,Prepare'))    

        }

        zn "SC"
        &sql(INSERT INTO SC_Data.Product (defaultUom, description, lastUpdatedTime, name, recordCreatedTime, type, uid) VALUES ('hours','Labor related to receiving and loading tasks in the warehouse','2025-04-03 15:59:08.493','Forklift operator','2025-04-03 15:59:08.493','LABOR','laborproduct-01'))
        &sql(INSERT INTO SC_Data.Product (defaultUom, description, lastUpdatedTime, name, recordCreatedTime, type, uid) VALUES ('hours','Labor related to quality control task in the warehouse','2025-04-03 15:59:18.912','Quality control','2025-04-03 15:59:18.912','LABOR','laborproduct-02'))
        &sql(INSERT INTO SC_Data.Product (defaultUom, description, lastUpdatedTime, name, recordCreatedTime, type, uid) VALUES ('hours','Labor related to picking, packing and storage task in the warehouse','2025-04-03 15:59:27.986','General warehouse operations','2025-04-03 15:59:27.986','LABOR','laborproduct-03'))
        &sql(INSERT INTO SC_Data.Location (city, coordinates, country, lastUpdatedTime, name, recordCreatedTime, type, uid) VALUES ('Paris','48.85341, 2.3488','France','2025-04-03 16:05:21.207','Pompéa warehouse','2025-04-03 16:05:21.207','WAREHOUSE','warehouse-01'))
        &sql(INSERT INTO SC_Data.Location (city, coordinates, country, lastUpdatedTime, name, recordCreatedTime, type, uid) VALUES ('Lille','50.6330, 3.0586','France','2025-04-30 14:33:09.815','Pompéa warehouse Lille','2025-04-30 14:33:09.815','WAREHOUSE','warehouse-02'))

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
