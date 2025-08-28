Class CGIFTE.Util
{

ClassMethod GetFirstSalesDate(currentTime As %TimeStamp, ByRef property As %String) As %TimeStamp
{
        Set tStatement = ##class(%SQL.Statement).%New()
        Set tQuery = "SELECT TOP 1 ReceiptId, SalesDate FROM CGIFTE_Persistent.SalesData WHERE SalesDate >= ? AND Processed = 0 AND StoreId = 'WEB' ORDER BY SalesDate ASC"
        Set sc = tStatement.%Prepare(tQuery)
        If sc '= $$$OK {
            Quit $$$ERROR(sc)
        }

        Set rset = tStatement.%Execute(currentTime)
        If rset.%Next() {
            // Extract the result as a dynamic object
            Set property = rset.ReceiptId
            Quit rset.SalesDate
        } Else {
            Quit ""
        }
}

ClassMethod GetFirstASNArrivalTime(currentTime As %TimeStamp, ByRef property As %String) As %TimeStamp
{
        Set tStatement = ##class(%SQL.Statement).%New()
        Set tQuery = "SELECT TOP 1 ASNId, ArrivalTime FROM CGIFTE_Persistent.ASN WHERE ArrivalTime >= ? AND Processed = 0 ORDER BY ArrivalTime ASC"
        Set sc = tStatement.%Prepare(tQuery)
        If sc '= $$$OK {
            Quit $$$ERROR(sc)
        }

        Set rset = tStatement.%Execute(currentTime)
        If rset.%Next() {
            // Extract the result as a dynamic object
            Set property = rset.ASNId
            Quit rset.ArrivalTime
        } Else {
            Quit ""
        }
}

ClassMethod GetFirstOutboundOrderStartTime(currentTime As %TimeStamp, ByRef property As %String) As %TimeStamp
{
        Set tStatement = ##class(%SQL.Statement).%New()
        Set tQuery = "SELECT TOP 1 OutboundOrderId, StartTime FROM CGIFTE_Persistent.OutboundOrder WHERE StartTime >= ? AND Processed = 0 ORDER BY StartTime ASC"
        Set sc = tStatement.%Prepare(tQuery)
        If sc '= $$$OK {
            Quit $$$ERROR(sc)
        }

        Set rset = tStatement.%Execute(currentTime)
        If rset.%Next() {
            // Extract the result as a dynamic object
            Set property = rset.OutboundOrderId
            Quit rset.StartTime
        } Else {
            Quit ""
        }
}

ClassMethod GetFirstEmployeeBusyUntil(currentTime As %TimeStamp) As %TimeStamp
{
        Set tStatement = ##class(%SQL.Statement).%New()
        Set tQuery = "SELECT TOP 1 BusyUntil FROM CGIFTE_Persistent.Employee WHERE BusyUntil >= ? AND Available = 1 ORDER BY BusyUntil ASC"
        Set sc = tStatement.%Prepare(tQuery)
        If sc '= $$$OK {
            Quit $$$ERROR(sc)
        }

        Set rset = tStatement.%Execute(currentTime)
        If rset.%Next() {
            // Extract the result as a dynamic object
            Quit rset.BusyUntil
        } Else {
            Quit ""
        }
}

ClassMethod GeneratePickTimeWeb(numReferences As %Integer) As %Integer [ Language = python ]
{
        import random
        from datetime import timedelta

        # Load properties from ObjectScript
        avg_prep_time = 1
        std_dev_prep_time = 0.3
        avg_time_per_ref = 0.3
        std_dev_time_per_ref = 0.1

        # Generate the number of references
        num_references = numReferences

        # Generate picking time using a normal distribution around the average
        picking_time_per_reference = abs(random.gauss(avg_time_per_ref, std_dev_time_per_ref))
        order_preparation_time = abs(random.gauss(avg_prep_time, std_dev_prep_time))

        # Calculate total picking time
        picking_time = (picking_time_per_reference * num_references + order_preparation_time)*60

        # Convert timedelta to total seconds and return as string
        return int(picking_time)
}

// Method to calculate arrival and processing times

ClassMethod CalculateDelay() As %Integer [ Language = python ]
{
        import random

        dockinTime = random.gauss(7, 2)
        delay = abs(random.normalvariate(0, 3*60)) + dockinTime
        
        return int(delay*60)
}

ClassMethod CalculateReceptionTime(totalPallets As %Integer) As %Integer [ Language = python ]
{
        import random

        
        reception_time_per_pallet = random.gauss(3, 1)
        
        # Calculate total reception and storage times
        totalreceptiontime = reception_time_per_pallet * totalPallets * (1 + 0.9)
        
        return int(totalreceptiontime*60)
}

ClassMethod CalculateStorageTime(totalPallets As %Integer) As %Integer [ Language = python ]
{
        import random

        storage_time_per_pallet = random.gauss(5, 1.5)
        
        
        totalstoragetime = storage_time_per_pallet * totalPallets

        # Return finish time as string
        return int(totalstoragetime*60)
}

ClassMethod CalculateControlTime(totalPallets As %Integer) As %Integer [ Language = python ]
{
        import random

        control_time_per_pallet = random.gauss(4, 1)
        
        
        totalstoragetime = control_time_per_pallet * totalPallets

        # Return finish time as string
        return int(totalstoragetime*60)
}

ClassMethod CalculatePrepareTime(quantity As %Integer) As %Integer [ Language = python ]
{
        import random

        picking_time_per_reference = random.gauss(0.33, 0.05)
        pallet_prep_time = random.gauss(4,1)
        
        
        totalpreptime = picking_time_per_reference * (1 + 0.1 * (quantity - 1)) + pallet_prep_time

        # Return finish time as string
        return int(totalpreptime*60)
}

ClassMethod CalculateLoadTime(totalPallets) As %Integer [ Language = python ]
{
        import random

        
        reception_time_per_pallet = random.gauss(3, 1)
        
        # Calculate total reception and storage times
        totalreceptiontime = reception_time_per_pallet * totalPallets * (1 + 0.9)
        
        return int(totalreceptiontime*60)
}

ClassMethod Reset() As %Status
{
    set ^currentTime = "2023-01-02 00:00:00"
    if $namespace = "WHS1" {
        set ^employee("Control") = 2
        set ^employee("Receive,Load") = 3
        set ^employee("Storage,Pick,Prepare") = 12
    }
    if $namespace = "WHS2" {
        set ^employee("Control") = 2
        set ^employee("Receive,Load") = 2
        set ^employee("Storage,Pick,Prepare") = 8
    }
    
    &SQL(DELETE FROM CGIFTE_Persistent.EmployeeAvailabilityLog)
    &SQL(DELETE FROM CGIFTE_Persistent.OutboundOrder)
    &SQL(DELETE FROM CGIFTE_Persistent.StoreOrder)
    &SQL(DELETE FROM CGIFTE_Persistent.ReceiptLine)
    &SQL(DELETE FROM CGIFTE_Persistent.Sales)
    &SQL(UPDATE CGIFTE_Persistent.SalesData SET Processed = 0 WHERE Processed = 1)
    &SQL(DELETE FROM CGIFTE_Persistent.ASN)
    &SQL(DELETE FROM CGIFTE_Persistent.ControlOrder)
    &SQL(DELETE FROM CGIFTE_Persistent.PickOrder)
    &SQL(DELETE FROM CGIFTE_Persistent.PrepareOrder)
    &SQL(DELETE FROM CGIFTE_Persistent.StorageOrder)
    &SQL(DELETE FROM CGIFTE_Persistent.ReceiveOrder)
    &SQL(DELETE FROM CGIFTE_Persistent.LoadOrder)
    &SQL(DELETE FROM CGIFTE_Persistent.InboundOrder)

    return $$$OK
}

ClassMethod CreateForecastCSV(currentTime, ByRef fileName) As %Status
{
        Set sql = "SELECT sd.StoreId As StoreId, p.SupplierId As SupplierId, COUNT(*) AS TotalSales " 
        _ "FROM CGIFTE_Persistent.SalesData sd JOIN CGIFTE_Persistent.Products p ON sd.ProductId = p.ProductId " 
        _  "WHERE sd.SalesDate BETWEEN ? AND DATEADD(WEEK, 1, ?) "
        _ "GROUP BY sd.StoreId, p.SupplierId ORDER BY sd.StoreId, p.SupplierId"
    Set tStatement = ##class(%SQL.Statement).%New()
    Set sc = tStatement.%Prepare(sql)
    If $$$ISERR(sc) {
        set ^Test("csverror") =  sc
        Quit
    }

    set sc = ##class(Ens.Config.DefaultSettings).%GetSetting("SCPKG.FoundationProduction", "*", "*", "", "FilePath", .pSetting)
    Set fileName = pSetting _ "sales_data_test1_"_$zdatetimeh(currentTime,3,1)_".csv"
    set ^Test(fileName) = ""
    Set file = ##class(%Stream.FileCharacter).%New()
    Set file.Filename = fileName
    If $$$ISERR(sc) {
        set ^Test("csverror") =  sc
        Quit
    }

    // Write headers
    Do file.WriteLine("Week,StoreId,SupplierId,TotalSales")
    for i=0:1:11
    {
        Set currentWeek = ##class(%SYSTEM.SQL.Functions).DATEADD("week",i, currentTime)
        Set rs = tStatement.%Execute(currentWeek, currentWeek)
        // Write data
        While rs.%Next() {
            Set line = currentWeek _ "," _ rs.StoreId _ "," _ rs.SupplierId _ "," _ ..EstimateTotalSales(rs.TotalSales)
            Do file.WriteLine(line)
        }
    }
    set ^Test = file.Filename


    

    Do file.%Save()
    Do file.%Close()

    return $$$OK
}

ClassMethod CreateOKFile(fileName) As %Status
{
    // Create a semaphore file to indicate the CSV file is finished
    Set okFileName = $replace(fileName, ".csv", ".ok")
    Set okFile = ##class(%Stream.FileCharacter).%New()
    Set okFile.Filename = okFileName
    Do okFile.WriteLine("OK:"_$zdt($h,3))
    Do okFile.%Save()
    Do okFile.%Close()

    return $$$OK
}

ClassMethod EstimateTotalSales(totalSales) As %Float [ Language = python ]
{
    import random
    sales = (1+random.gauss(0,0.01))*totalSales
    return sales
}

}
