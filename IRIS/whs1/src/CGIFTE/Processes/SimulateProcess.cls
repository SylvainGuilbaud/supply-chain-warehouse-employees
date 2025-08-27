Class CGIFTE.Processes.SimulateProcess Extends (Ens.BusinessProcess, CGIFTE.Util)
{

/// Entry point for the process
Method OnRequest(pRequest As Ens.Request, Output pResponse As Ens.Response) As %Status
{
        // TO DO: get current time from process 
        Set currentTime = ^currentTime // CurrentTime should be start of week eg. 01-01-2023 00:00:00
        Set endTime = ##class(%SYSTEM.SQL.Functions).DATEADD("d",7,currentTime)

        Set endOfFinalWorkday = ##class(%SYSTEM.SQL.Functions).DATEADD("d", 5, currentTime)

        Set employeeString = ..CreateEmployeeString()

        // Reset employee status
        Set sc = ..ResetEmployeeStatus(employeeString, currentTime)
        If sc '= $$$OK Quit sc

        While (##class(%SYSTEM.SQL.Functions).DATEDIFF("s",currentTime,endOfFinalWorkday) > 0) {
           // Calculate day segments
            Set startOfDay = currentTime
            Set nineAM = ##class(%SYSTEM.SQL.Functions).DATEADD("h", 9, startOfDay)
            Set fivePM = ##class(%SYSTEM.SQL.Functions).DATEADD("h", 17, startOfDay)
            Set nextDay = ##class(%SYSTEM.SQL.Functions).DATEADD("d", 1, startOfDay)

            $$$TRACE("Simulating day from "_startOfDay_" to "_nextDay)

            // --- 1. Load historical sales (00:00–09:00) ---
            Do ..ProcessSalesBetween(startOfDay, nineAM)

            // --- 2. Assign tasks (09:00–17:00) using heap (to be implemented) ---
            Do ..AssignTasksWithHeap(nineAM, fivePM)

            // --- 3. End-of-day + late sales (17:00–00:00) ---
            Do ..ProcessEndOfDay(fivePM)
            Do ..ProcessSalesBetween(fivePM, nextDay)

            // Advance to next day
            Set currentTime = nextDay
        }

        // ProcessWeekend

        Do ..ProcessSalesBetween(currentTime, endTime)


        // Response to the initial trigger
        Set pResponse = ##class(Ens.Response).%New()
        Set ^currentTime = endTime
        Quit $$$OK
}

Method CreateEmployeeString() As %String
{
    Set employeeString = ""
    Set category = ""

    For category = "Control", "Receive,Load", "Storage,Pick,Prepare" {
        Set targetCount = $Get(^employee(category), 0)
        If targetCount > 0 {
            Set stmt = ##class(%SQL.Statement).%New()
            Set sql = "SELECT TOP " _ targetCount _ " EmployeeId FROM CGIFTE_Persistent.Employee WHERE TaskType = ? ORDER BY ID"
            Set sc = stmt.%Prepare(sql)
            If $$$ISERR(sc) return sc

            Set rs = stmt.%Execute(category)
            While rs.%Next() {
                Set empId = rs.%Get("EmployeeId")
                If employeeString '= "" {
                    Set employeeString = employeeString _ "," _ empId
                } Else {
                    Set employeeString = empId
                }
            }
        }
    }
    return employeeString
}

Method ResetEmployeeStatus(employeeString As %String, currentTime As %TimeStamp) As %Status
{
    // Update employees
    set sc = $$$OK
    Set tStatement = ##class(%SQL.Statement).%New()
    Set sql = "UPDATE CGIFTE_Persistent.Employee SET Available = 0, BusyUntil = NULL"
    Set sc = tStatement.%Prepare(sql)
    If sc '= $$$OK {
        Quit sc
    }
    Set tResult = tStatement.%Execute()

    // Update employees
    Set tStatement = ##class(%SQL.Statement).%New()
    Set sql = "UPDATE CGIFTE_Persistent.Employee SET Available = 1 WHERE $FIND(?,EmployeeId) != 0"
    Set sc = tStatement.%Prepare(sql)
    If sc '= $$$OK {
        Quit sc
    }
    Set tResult = tStatement.%Execute(employeeString)

    Set tStatement = ##class(%SQL.Statement).%New()
    Set sqlUPDATE = "INSERT INTO CGIFTE_Persistent.EmployeeAvailabilityLog (CurrentTime, EmployeeId) SELECT ?, EmployeeID FROM CGIFTE_Persistent.Employee WHERE Available = 1"
    Set sc = tStatement.%Prepare(sqlUPDATE)
    If sc '= $$$OK {
        Quit sc
    }
    Set tResult = tStatement.%Execute(currentTime)
    return sc
}

/// Process 1: End of Day
Method ProcessEndOfDay(endOfDay As %TimeStamp) As %Status
{
        // Get current timestamp
    Set currentTime = endOfDay // Current time
    Set day = ##class(%SYSTEM.SQL.Functions).DAYOFWEEK(endOfDay) // Day of week (1=Sunday, 7=Saturday)
    // Check if it's Friday (6) or a regular weekday
    If day = 6 {
        Set nextWorkday = ##class(%SYSTEM.SQL.Functions).DATEADD("h",16+(2*24),currentTime) // Friday evening -> next Monday
        do ##class(CGIFTE.Util).CreateForecastCSV(currentTime)
        $$$TRACE("CSVSend")
    } Else {
        Set nextWorkday = ##class(%SYSTEM.SQL.Functions).DATEADD("h",16,currentTime)  // Weekday -> next day
    }

    If (day '= 7) && (day '= 1)
    {
        // Create outbound orders
        Do ..CreateOutboundOrders(day, currentTime, nextWorkday)

        // Create inbound orders
        Do ..CreateInboundOrders(day, currentTime, nextWorkday)
    }
    

    Quit $$$OK
}

/// Create outbound orders
Method CreateOutboundOrders(day As %Integer, currentTime As %TimeStamp, nextWorkday As %TimeStamp) As %Status
{
    // Stores to process based on day of the week
    Set startStore = ((day - 2) * 24) + 1
    Set endStore = startStore + 23

    for i=startStore:1:endStore
    {
        set storeId = i
        // Query sales data for the stores
        Set tStatement = ##class(%SQL.Statement).%New()
        Set tQuery = "SELECT Count(*) AS Total FROM CGIFTE_Persistent.SalesData WHERE StoreId = ? AND SalesDate >= DATEADD('D', -7, ?) AND SalesDate < ?"
        Set sc = tStatement.%Prepare(tQuery)
        If sc '= $$$OK {
            Quit
        }
        Set tResult = tStatement.%Execute(storeId, currentTime, currentTime)
        While tResult.%Next() {
            set totalItems = tResult.Total
            set storeOrder = ##class(CGIFTE.Persistent.StoreOrder).%New()
            set storeOrder.StoreId = storeId
            set storeOrder.Total = totalItems
            set storeOrder.TimePlaced = currentTime
            set sc = storeOrder.%Save()

            Set day = ##class(%SYSTEM.SQL.Functions).DAYOFWEEK(currentTime) // Day of week (1=Sunday, 7=Saturday)
            // Check if it's Friday (6) or a regular weekday
            If day = 6 {
                Set nextWorkday = ##class(%SYSTEM.SQL.Functions).DATEADD("h",16+(2*24),currentTime) // Friday evening -> next Monday
            } Else {
                Set nextWorkday = ##class(%SYSTEM.SQL.Functions).DATEADD("h",16,currentTime)  // Weekday -> next day
            }

            // Create one outbound order per 96 * 33 items
            While totalItems > 0 {
                Set itemsInOrder = $SELECT(totalItems > (96 * 33): (96 * 33), 1: totalItems)
                Set totalItems = totalItems - itemsInOrder

                Set outboundOrder = ##class(CGIFTE.Persistent.OutboundOrder).%New()
                Set outboundOrder.StoreOrderId = storeOrder.StoreOrderId
                Set outboundOrder.StartTime = nextWorkday
                Set outboundOrder.ItemsInOrder = itemsInOrder
                ///Set outboundOrder.PrepareTime = ##class(CGIFTE.Util).CalculatePrepareTime(itemsInOrder)
                ///Set outboundOrder.LoadTime = ##class(CGIFTE.Util).CalculateLoadTime() // Example interval
                Set outboundOrder.Processed = 0
                Set sc = outboundOrder.%Save()
                If sc '= $$$OK {
                    Quit
                }
            }
        }

    }

    Quit sc
}

/// Create inbound orders
Method CreateInboundOrders(currentDayOfWeek As %Integer, currentTime As %TimeStamp, nextWorkday As %TimeStamp) As %Status
{
    // Suppliers to process based on day of the week
    Set startSupplier = ((currentDayOfWeek - 2) * 33) + 1
    Set endSupplier = startSupplier + 32

    for i=startSupplier:1:endSupplier
    {
        set supplierId = i
        // Query sales data for the suppliers
        Set tStatement = ##class(%SQL.Statement).%New()
        Set tQuery = "SELECT SUM(1) AS TotalItems FROM CGIFTE_Persistent.SalesData S INNER JOIN CGIFTE_Persistent.Products P ON S.ProductId = P.ProductId WHERE P.SupplierId = ? AND S.SalesDate >= DATEADD('DAY', -7, ?) AND S.SalesDate < ?"
        Set sc = tStatement.%Prepare(tQuery)
        If sc '= $$$OK {
            Write "Error preparing supplier query: ", sc, !
            Quit 
        }
        Set tResult = tStatement.%Execute(supplierId, currentTime, currentTime)
        
        While tResult.%Next() {
            set totalItems = tResult.TotalItems
            Set inboundOrder = ##class(CGIFTE.Persistent.InboundOrder).%New()
            Set inboundOrder.Total = totalItems
            set inboundOrder.SupplierId = supplierId
            set inboundOrder.TimePlaced = currentTime
            do inboundOrder.%Save()

            // Create one asn per 96 * 33 items
            While totalItems > 0 {
                Set itemsInOrder = $SELECT(totalItems > (96 * 33): (96 * 33), 1: totalItems)
                Set totalItems = totalItems - itemsInOrder

                set Asn = ##class(CGIFTE.Persistent.ASN).%New()
                set Asn.InboundOrderId = inboundOrder.InboundOrderId
                set Asn.ItemsInOrder = itemsInOrder
                set Asn.ArrivalTime = ##class(%SYSTEM.SQL.Functions).DATEADD("ss",##class(CGIFTE.Util).CalculateDelay(), nextWorkday)
                Set tSC = Asn.%Save()
            
            }
        }
    }

    

    Quit $$$OK
}

Method ProcessSalesBetween(startTime As %TimeStamp, endTime As %TimeStamp) As %Status
{
    Try {
        Set sc = $$$OK
        Set tStatement = ##class(%SQL.Statement).%New()
        Set sql = "SELECT DISTINCT ReceiptId FROM CGIFTE_Persistent.SalesData WHERE SalesDate >= ? AND SalesDate < ? AND StoreId = 'WEB'"
        Set sc = tStatement.%Prepare(sql)
        If sc '= $$$OK Throw sc
        
        Set tResult = tStatement.%Execute(startTime, endTime)
        While tResult.%Next() {
            Set receiptID = tResult.%Get("ReceiptId")
            set taskTime = 0
            set pickOrderId = ""
            Do ..ProcessSale(receiptID, .taskTime, .pickOrderId)
        }

        return sc
    } Catch ex {
        $$$TRACE("Exception in ProcessSalesBetween: "_ex.DisplayString())
        return ex.AsStatus()
    }
}

/// Process 2: Sale
Method ProcessSale(receiptId As %String, ByRef taskTime As %Integer, ByRef pickOrderId As %String) As %Status
{
        Set count = 0
     
        Set timePlaced = ""
        Set tStatement = ##class(%SQL.Statement).%New()
        Set sql = "SELECT StoreId,CustomerId,SalesDate, COUNT(*) AS ItemCount FROM CGIFTE_Persistent.SalesData WHERE ReceiptId = ?"
        Set sc = tStatement.%Prepare(sql)
        If sc '= $$$OK Quit

        Set rset = tStatement.%Execute(receiptId)
        If rset.%Next() {
            Set count = rset.%Get("ItemCount")
            set timePlaced = rset.%Get("SalesDate")
            set storeId = rset.%Get("StoreId")
            set customerId = rset.%Get("CustomerId")
        }
        Else 
        {
            Quit
        }

        Set sql = "UPDATE CGIFTE_Persistent.SalesData SET Processed = 1 WHERE ReceiptId = ?"
        Set sc = tStatement.%Prepare(sql)
        If sc '= $$$OK Quit

        Set rset = tStatement.%Execute(receiptId)

        set sale = ##class(CGIFTE.Persistent.Sales).%New()
        set sale.ReceiptId = receiptId
        set sale.CustomerId = customerId
        set sale.SalesDate = timePlaced
        set sale.StoreId = storeId
        set sale.Total = count
        do sale.%Save()

        Set task = ##class(CGIFTE.Persistent.PickOrder).%New()
        Set task.ReceiptId = receiptId
        Set task.TaskType = "Pick"
        set taskTime = ##class(CGIFTE.Util).GeneratePickTimeWeb(count)
        Set task.TaskTime = taskTime
        Set task.TimePlaced = timePlaced // current time in timestamp format
        Set task.Done = 0

        Set sc = task.%Save()
        set pickOrderId = task.OrderId
        If sc '= $$$OK Quit 

        return sc
}

ClassMethod InsertEventIntoQueue(ByRef taskQueue, time As %TimeStamp, eventType As %String, addInfo1 As %String = "", addInfo2 As %String = "", addInfo3 As %String = "") As %Status
{
    // Determine next available sub-index
    Set i = 1
    While $Data(taskQueue(time, i)) {
        Set i = i + 1
    }

    // Insert event node
    Set taskQueue(time, i, "Type") = eventType
    Set taskQueue(time, i, "AddInfo1") = addInfo1
    if (addInfo2 '= "") 
    {
        Set taskQueue(time, i, "AddInfo2") = addInfo2
    }
    if (addInfo3 '= "") 
    {
        Set taskQueue(time, i, "AddInfo3") = addInfo3
    }
    Quit $$$OK
}

Method LoadTaskQueue(startTime As %TimeStamp, endTime As %TimeStamp, ByRef taskQueue) As %Status
{
    Try {
        Set stmt = ##class(%SQL.Statement).%New()
        Set sc = $$$OK

        // --- 1. SalesData → queue sales by ReceiptId ---
        Set sql = "SELECT DISTINCT ReceiptId, MIN(SalesDate) AS SalesDate FROM CGIFTE_Persistent.SalesData WHERE SalesDate >= ? AND SalesDate < ?  AND StoreId = 'WEB' GROUP BY ReceiptId"
        Set sc = stmt.%Prepare(sql)
        If sc '= $$$OK Throw sc
        Set rs = stmt.%Execute(startTime, endTime)
        While rs.%Next() {
            Set receiptId = rs.%Get("ReceiptId")
            Set saleTime = rs.%Get("SalesDate")
            Do ..InsertEventIntoQueue(.taskQueue, saleTime, "Sale", receiptId)
        }

        // --- 2. ASN Events ---
        Set sql = "SELECT ASNId, ArrivalTime, ItemsInOrder FROM CGIFTE_Persistent.ASN WHERE ArrivalTime >= ? AND ArrivalTime < ?"
        Set sc = stmt.%Prepare(sql)
        If sc '= $$$OK Throw sc
        Set rs = stmt.%Execute(startTime, endTime)
        While rs.%Next() {
            Set asnId = rs.%Get("ASNId")
            Set asnTime = rs.%Get("ArrivalTime")
            Set itemsInOrder = rs.%Get("ItemsInOrder")
            Do ..InsertEventIntoQueue(.taskQueue, asnTime, "ASN", asnId, itemsInOrder)
        }

        // --- 3. OutboundOrders Events ---
        Set sql = "SELECT OutboundOrderId, StartTime, ItemsInOrder FROM CGIFTE_Persistent.OutboundOrder WHERE StartTime >= ? AND StartTime < ?"
        Set sc = stmt.%Prepare(sql)
        If sc '= $$$OK Throw sc
        Set rs = stmt.%Execute(startTime, endTime)
        While rs.%Next() {
            Set orderId = rs.%Get("OutboundOrderId")
            Set startTimeOrder = rs.%Get("StartTime")
            Set itemsInOrder = rs.%Get("ItemsInOrder")
            Do ..InsertEventIntoQueue(.taskQueue, startTimeOrder, "Outbound", orderId, itemsInOrder)
        }

        // --- 4. Open WorkOrders ---
        Set sql = "SELECT OrderId, TaskType, TimePlaced, TaskTime FROM CGIFTE_Persistent.WorkOrder WHERE Done = 0 AND TimePlaced < ?"
        Set sc = stmt.%Prepare(sql)
        If sc '= $$$OK Throw sc
        Set rs = stmt.%Execute(endTime)
        While rs.%Next() {
            Set workId = rs.%Get("OrderId")
            Set type = rs.%Get("TaskType")
            Set tPlaced = rs.%Get("TimePlaced")
            Set duration = rs.%Get("TaskTime")

            // Add WorkOrder to task queue
            Do ..InsertEventIntoQueue(.taskQueue, tPlaced, type, workId, duration)
        }

        return $$$OK
    } Catch ex {
        $$$TRACE("Error in LoadTaskQueue: "_ex.DisplayString())
        return ex.AsStatus()
    }
}

Method InitEmployeeHeap(ByRef heap, startTime As %TimeStamp) As %Status
{
    Try {

        Set stmt = ##class(%SQL.Statement).%New()
        Set sql = "SELECT EmployeeId, TaskType FROM CGIFTE_Persistent.Employee WHERE Available = 1"
        Set sc = stmt.%Prepare(sql)
        If sc '= $$$OK Throw sc

        Set rs = stmt.%Execute()
        While rs.%Next() {
            Set empId = rs.%Get("EmployeeId")
            Set taskTypes = rs.%Get("TaskType")  // Comma-separated string

            // Add to heap    
            If taskTypes '= "" {
                // Determine next available subnode
                Set j = 1
                While $Data(heap(taskTypes, startTime, j)) {
                    Set j = j + 1
                }
                Set heap(taskTypes, startTime, j) = empId
            }
            
        }

        Return $$$OK
    } Catch ex {
        $$$TRACE("Error in InitEmployeeHeap: "_ex.DisplayString())
        Return ex.AsStatus()
    }
}

Method RunSimulationLoop(startTime As %TimeStamp, endTime As %TimeStamp, ByRef taskQueue, ByRef heap) As %Status
{
    Try {
        Set time = $Order(taskQueue(""))
        While (time '= "") && (##class(%SYSTEM.SQL.Functions).DATEDIFF("s",time, endTime) > 0) {
            Set i = $Order(taskQueue(time, ""))
            While i '= "" {
                Set type = taskQueue(time, i, "Type")
                Set add1 = $Get(taskQueue(time, i, "AddInfo1"), "")
                Set add2 = $Get(taskQueue(time, i, "AddInfo2"), "")
                Set add3 = $Get(taskQueue(time, i, "AddInfo3"), "")

                If type = "Sale" {
                    set taskTime = 0
                    set pickOrderId = ""
                    Do ..ProcessSale(add1, .taskTime, .pickOrderId)  // add1 = ReceiptId
                    Do ..InsertEventIntoQueue(.taskQueue, time, "Pick", pickOrderId, taskTime)
                }
                ElseIf type = "ASN" {
                    Set ro = ##class(CGIFTE.Persistent.ReceiveOrder).%New()
                    Set ro.ASNId = add1
                    Set ro.TaskType = "Receive"
                    Set ro.TimePlaced = time
                    Set ro.TaskTime = ..CalculateReceptionTime((add2/96\1))
                    Set ro.Done = 0
                    Do ro.%Save()
                    Do ..InsertEventIntoQueue(.taskQueue, time, "Receive", ro.OrderId, ro.TaskTime, add2)
                }
                ElseIf type = "Outbound" {
                    Set po = ##class(CGIFTE.Persistent.PrepareOrder).%New()
                    Set po.OutboundOrderId = add1
                    Set po.TaskType = "Prepare"
                    Set po.TimePlaced = time
                    Set po.TaskTime = ..CalculatePrepareTime(add2)
                    Set po.Done = 0
                    Do po.%Save()
                    Do ..InsertEventIntoQueue(.taskQueue, time, "Prepare", po.OrderId, po.TaskTime, add2)
                }
                Else {
                    // It's a real task like Pick, Prepare, etc.
                    Set taskType = type
                    Set taskId = add1
                    set taskTime = add2
                    Set taskGroup = ""

                    // Determine the compatible heap group
                    If (taskType = "Pick") || (taskType = "Prepare") || (taskType = "Storage") {
                        Set taskGroup = "Storage,Pick,Prepare"
                    } ElseIf (taskType = "Receive") || (taskType = "Load") {
                        Set taskGroup = "Receive,Load"
                    } ElseIf (taskType = "Control") {
                        Set taskGroup = "Control"
                    } Else {
                        Quit  ; unknown task
                    }

                    // Find first compatible employee in heap
                    Set empId = ""
                    Set empTime = ""
                    Set empIndex = ""
                    Set found = 0

                    Set availableTime = $Order(heap(taskGroup, ""))
                    If (availableTime '= "") && (found = 0) {
                        Set j = $Order(heap(taskGroup, availableTime, ""))
                        if (j '= "") && (found = 0) {
                            Set potentialEmpId = heap(taskGroup, availableTime, j)

                            // Can employee start at or before task time, and finish by end of day?
                            If ##class(%SYSTEM.SQL.Functions).DATEDIFF("s", availableTime, time) > 0 {
                                Set taskStart = time
                            } Else {
                                Set taskStart = availableTime
                            }
                            Set taskEnd = ##class(%SYSTEM.SQL.Functions).DATEADD("s", taskTime, taskStart)

                            If ##class(%SYSTEM.SQL.Functions).DATEDIFF("s", taskEnd, endTime) >= 0 {
                                // Assign!
                                Set empId = potentialEmpId
                                Set empTime = availableTime
                                Set empIndex = j
                                Set found = 1
                            }
                        }
                    }

                    If found {
                        // Assign task to employee
                        Set task = ##class(CGIFTE.Persistent.WorkOrder).OrderIDXOpen(taskId)
                        Set task.EmployeeId = empId
                        Set task.TimePickedUp = taskStart
                        Set task.TimeDone = taskEnd
                        Set task.Done = 1
                        Set task.Changed = 1
                        Do task.%Save()

                        // Remove from heap
                        Kill heap(taskGroup, empTime, empIndex)

                        // Push employee back with updated availability
                        Set newTime = taskEnd
                        Set newIndex = 1
                        While $Data(heap(taskGroup, newTime, newIndex)) {
                            Set newIndex = newIndex + 1
                        }
                        Set heap(taskGroup, newTime, newIndex) = empId

                        // Create follow-up task if needed
                        If taskType = "Prepare" {
                            Set outboundOrderId = task.OutboundOrderId
                            Set outboundOrder = ##class(CGIFTE.Persistent.OutboundOrder).IndexOnOutboundOrderIdOpen(outboundOrderId)
                            Set items = outboundOrder.ItemsInOrder
                            Set newTask = ##class(CGIFTE.Persistent.LoadOrder).%New()
                            Set newTask.TaskType = "Load"
                            Set newTask.OutboundOrderId = outboundOrderId
                            Set newTask.TaskTime = ..CalculateLoadTime(items/96\1)
                            Set newTask.TimePlaced = taskEnd
                            Set newTask.Done = 0
                            Do newTask.%Save()
                            Do ..InsertEventIntoQueue(.taskQueue, taskEnd, "Load", newTask.OrderId, newTask.TaskTime)
                        }
                        ElseIf taskType = "Receive" {
                            Set ASNId = task.ASNId
                            Set asn = ##class(CGIFTE.Persistent.ASN).IndexOnASNIdOpen(ASNId)
                            Set items = asn.ItemsInOrder
                            Set newTask = ##class(CGIFTE.Persistent.ControlOrder).%New()
                            Set newTask.TaskType = "Control"
                            Set newTask.ASNId = ASNId
                            Set newTask.TaskTime = ..CalculateControlTime(items/96\1)
                            Set newTask.TimePlaced = taskEnd
                            Set newTask.Done = 0
                            Do newTask.%Save()
                            Do ..InsertEventIntoQueue(.taskQueue, taskEnd, "Control", newTask.OrderId, newTask.TaskTime)
                        }
                        ElseIf taskType = "Control" {
                            Set ASNId = task.ASNId
                            Set asn = ##class(CGIFTE.Persistent.ASN).IndexOnASNIdOpen(ASNId)
                            Set items = asn.ItemsInOrder
                            Set newTask = ##class(CGIFTE.Persistent.StorageOrder).%New()
                            Set newTask.TaskType = "Storage"
                            Set newTask.ASNId = ASNId
                            Set newTask.TaskTime = ..CalculateStorageTime(items/96\1)
                            Set newTask.TimePlaced = taskEnd
                            Set newTask.Done = 0
                            Do newTask.%Save()
                            Do ..InsertEventIntoQueue(.taskQueue, taskEnd, "Storage", newTask.OrderId, newTask.TaskTime)
                        }
                    }
                }
                            

                Set i = $Order(taskQueue(time, i))
            }
            Set time = $Order(taskQueue(time))

            
        }
        

        Return $$$OK
    } Catch ex {
        $$$TRACE("Error in RunSimulationLoop: "_ex.DisplayString())
        Return ex.AsStatus()
    }
}

Method AssignTasksWithHeap(startTime As %TimeStamp, endTime As %TimeStamp) As %Status
{
    Try {
        Set sc = $$$OK

        // Declare in-memory data structures
        kill taskQueue, heap
        set taskQueue = ""
        set heap = ""

        // Step 1: Load events and existing tasks into queue
        Set sc = ..LoadTaskQueue(startTime, endTime, .taskQueue)
        If sc '= $$$OK Throw sc

        // Step 2: Initialize employee availability heap
        Set sc = ..InitEmployeeHeap(.heap, startTime)
        If sc '= $$$OK Throw sc 

        // Step 3: Run simulation loop
        Set sc = ..RunSimulationLoop(startTime, endTime, .taskQueue, .heap)
        If sc '= $$$OK Throw sc

        Return $$$OK
    } Catch ex {
        $$$TRACE("Error in AssignTasksWithHeap: "_ex.DisplayString())
        Return ex.AsStatus()
    }
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
