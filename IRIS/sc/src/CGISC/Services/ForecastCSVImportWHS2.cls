Class CGISC.Services.ForecastCSVImportWHS2 Extends Ens.BusinessService
{

Parameter ADAPTER = "EnsLib.File.InboundAdapter";

Method OnProcessInput(pInput As %FileCharacterStream, pOutput As %RegisteredObject) As %Status
{
   set filename = pInput.Filename
   $$$TRACE(filename)
   set namespace = $NAMESPACE
   zn "WHS2"
   set sql = "SELECT TaskType, SUM(40) AS TotalHours FROM CGIFTE_Persistent.Employee WHERE Available = 1 GROUP BY TaskType"
   // Create a %SQL.Statement object
    Set tStatement = ##class(%SQL.Statement).%New()
    
    // Prepare the SQL statement
    Set sc = tStatement.%Prepare(sql)
    If $$$ISERR(sc) {
        // Handle the error if the statement preparation fails
        Do $System.Status.DisplayError(sc)
        Quit sc
    }
    
    // Execute the SQL statement
    Set tResultSet = tStatement.%Execute()
    set GATime = ""
    set ForkliftTime = ""
    set ControlTime = ""
    
    // Process the results
    While tResultSet.%Next() {
        // Retrieve each row's data
        if tResultSet.TaskType = "CONTROL"
        {
            set ControlTime = tResultSet.TotalHours
        }
        if tResultSet.TaskType = "RECEIVE,LOAD"
        {
            set ForkliftTime = tResultSet.TotalHours
        }
        if tResultSet.TaskType = "STORAGE,PICK,PREPARE"
        {
            set GATime = tResultSet.TotalHours
        }
    }
   zn namespace
   $$$TRACE("ok")
   Set file = $PIECE(filename, "\", *)
   set fileWOEXT= $PIECE(file, ".", 1)
   set timehwc = $PIECE(fileWOEXT, "_", *)
   set timeh = $e(timehwc,1,5)_","_$e(timehwc,6,*)
   $$$TRACE(timeh)
   set time = $zdt(timeh,3)
   for i = 0:1:11
   {
    set fcTime = ##class(%SYSTEM.SQL.Functions).DATEADD("week",i, time)
    $$$TRACE(fcTime)
    set response =  ..CalculateWorkloadForWeek(filename, fcTime)
    hang 2
    $$$TRACE("after calcul:"_response)
    set pRequest = ##class(CGISC.Requests.CreateDemandRequest).%New()
    set pRequest.InitWeek = time
    set pRequest.Week = fcTime
    set pRequest.GATime = $PIECE(response,",",1)
    set pRequest.ForkliftTime = $PIECE(response,",",2)
    set pRequest.ControlTime = $PIECE(response,",",3)
    set pRequest.PlanType = "forecast"
    set pRequest.Warehouse = "warehouse-02"
    set tSc = ..SendRequestSync("CreateDemandPlan", pRequest, .pResponse, -1)
    set sRequest = ##class(CGISC.Requests.CreateSupplyRequest).%New()
    set sRequest.InitWeek = time
    set sRequest.Week = fcTime
    set sRequest.GATime = GATime
    set sRequest.ForkliftTime = ForkliftTime
    set sRequest.ControlTime = ControlTime
    set sRequest.PlanType = "forecast"
    set sRequest.Warehouse = "warehouse-02"
    set tSc = ..SendRequestSync("CreateSupplyPlan", sRequest, .sResponse, -1)
   }


   $$$TRACE("part1")

    set sql = "SELECT productId As productId, SUM(quantity)/60/60 AS TotalHours FROM SC_Data.MfgOrder WHERE (actualEndDate >= DATEADD('dd', -7, ?)) OR (notes IS NULL AND plannedStartDate <= ?) GROUP BY productId"
   // Create a %SQL.Statement object
    Set tStatement = ##class(%SQL.Statement).%New()
    
    // Prepare the SQL statement
    Set sc = tStatement.%Prepare(sql)
    If $$$ISERR(sc) {
        // Handle the error if the statement preparation fails
        $$$TRACE(sc)
        Do $System.Status.DisplayError(sc)
        Quit sc
    }
    
    // Execute the SQL statement
    Set tResultSet = tStatement.%Execute(time,time)
    set GATimeWL = ""
    set ForkliftTimeWL = ""
    set ControlTimeWL = ""
    
    // Process the results
    While tResultSet.%Next() {
        // Retrieve each row's data
        $$$TRACE(tResultSet.productId)
        $$$TRACE(tResultSet.TotalHours)
        if tResultSet.productId = "LABORPRODUCT-02"
        {
            set ControlTimeWL = tResultSet.TotalHours
        }
        if tResultSet.productId = "LABORPRODUCT-01"
        {
            set ForkliftTimeWL = tResultSet.TotalHours
        }
        if tResultSet.productId = "LABORPRODUCT-03"
        {
            set GATimeWL = tResultSet.TotalHours
        }
    }

    set pRequest = ##class(CGISC.Requests.CreateDemandRequest).%New()
    set pRequest.InitWeek = time
    set pRequest.Week = ##class(%SYSTEM.SQL.Functions).DATEADD("week", -1, time)
    set pRequest.GATime = GATimeWL
    set pRequest.ForkliftTime = ForkliftTimeWL
    set pRequest.ControlTime = ControlTimeWL
    set pRequest.PlanType = "historical"
    set pRequest.Warehouse = "warehouse-02"
    set tSc = ..SendRequestSync("CreateDemandPlan", pRequest, .pResponse, -1)
    set sRequest = ##class(CGISC.Requests.CreateSupplyRequest).%New()
    set sRequest.InitWeek = time
    set sRequest.Week = ##class(%SYSTEM.SQL.Functions).DATEADD("week", -1, time)
    set sRequest.GATime = GATime
    set sRequest.ForkliftTime = ForkliftTime
    set sRequest.ControlTime = ControlTime
    set sRequest.PlanType = "historical"
    set sRequest.Warehouse = "warehouse-02"
    set tSc = ..SendRequestSync("CreateSupplyPlan", sRequest, .sResponse, -1)


    set tSc = ##class(SC.Core.Data.Internal.ManualTask).KickOffTask(time, "warehouse-02")
    $$$TRACE("trace" _ tSc)

   
   return tSc
}

ClassMethod CalculateWorkloadForWeek(filename As %String, week As %TimeStamp) As %String [ Language = python ]
{
    import pandas as pd
    import numpy as np
    import random

        

    # Load the CSV file
    df = pd.read_csv(filename)

    # Filter the DataFrame for the specified week using a string comparison
    filtered_df = df[df['Week'] == week]

    # Check if filtered DataFrame is empty
    if filtered_df.empty:
        print(f"No data available for the week: {week}")
        return

    # Aggregate TotalSales by StoreId
    store_totals = filtered_df.groupby('StoreId')['TotalSales'].sum()

    # Execute code for each StoreId
    prepare_time = 0
    load_time = 0
    pick_time = 0
    for store_id, total_sales in store_totals.items():
        if store_id == "WEB":
            # Load properties from ObjectScript
            avg_prep_time = 1
            avg_time_per_ref = 0.3
            # Generate picking time using a normal distribution around the average
            picking_time_per_reference = avg_time_per_ref
            order_preparation_time = avg_prep_time
            pick_time += (total_sales/4)*(picking_time_per_reference * 2 + order_preparation_time)/60
        else:
            totalItems = np.ceil(total_sales)
            items_per_order = 96 * 33
            ### each while represents one inboundorder
            while totalItems > 0:
                if totalItems > items_per_order:
                    items_in_order = items_per_order
                else:
                    items_in_order = totalItems

                totalItems -= items_in_order
                totalPallets = items_in_order/96
                picking_time_per_reference = random.gauss(0.33, 0.05)
                pallet_prep_time = random.gauss(4,1)
                totalpreptime = picking_time_per_reference * (1 + 0.1 * (items_in_order - 1)) + pallet_prep_time
                # Return finish time as string
                prepare_time += int(totalpreptime*60)/60/60
                reception_time_per_pallet = random.gauss(3, 1)

                # Calculate total reception and storage times
                totalreceptiontime = reception_time_per_pallet * totalPallets * (1 + 0.9)
                
                load_time += int(totalreceptiontime*60)/60/60

    # Aggregate TotalSales by SupplierId
    # calculate avg unit per week
    receiveTime = 0
    controlTime = 0
    storageTime = 0
    supplier_totals = filtered_df.groupby('SupplierId')['TotalSales'].sum()

    # Execute code for each SupplierId
    for supplier_id, total_sales in supplier_totals.items():
        totalItems = np.ceil(total_sales)
        items_per_order = 96 * 33
        ### each while represents one inboundorder
        while totalItems > 0:
            if totalItems > items_per_order:
                items_in_order = items_per_order
            else:
                items_in_order = totalItems

            totalItems -= items_in_order
            totalPallets = items_in_order/96
            reception_time_per_pallet = random.gauss(3, 1)
            # Calculate total reception and storage times
            totalreceptiontime = reception_time_per_pallet * totalPallets * (1 + 0.9)
            receiveTime += int(totalreceptiontime*60)/60/60
            control_time_per_pallet = random.gauss(4, 1)
            cont = control_time_per_pallet * totalPallets
            # Return finish time as string
            controlTime += int(cont*60)/60/60
            storage_time_per_pallet = random.gauss(5, 1.5)
            totalstoragetime = storage_time_per_pallet * totalPallets
            # Return finish time as string
            storageTime += int(totalstoragetime*60)/60/60
    
    pickprepstore = storageTime + prepare_time + 2*pick_time
    forklift = receiveTime + load_time
    return str(pickprepstore) + "," + str(forklift) + "," + str(controlTime)
}

}
