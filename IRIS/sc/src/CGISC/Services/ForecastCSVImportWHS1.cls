Class CGISC.Services.ForecastCSVImportWHS1 Extends Ens.BusinessService
{

Parameter ADAPTER = "EnsLib.File.InboundAdapter";

Method OnProcessInput(pInput As %FileCharacterStream, pOutput As %RegisteredObject) As %Status
{
   set filename = pInput.Filename
   $$$TRACE("Inbound file: "_filename)

   // --- Pull supply capacity ---
   set nsOld = $NAMESPACE
   zn "WHS1"
   set sql = "SELECT TaskType, SUM(40) AS TotalHours FROM CGIFTE_Persistent.Employee WHERE Available = 1 GROUP BY TaskType"

   set stmt = ##class(%SQL.Statement).%New()
   set sc = stmt.%Prepare(sql)
   If $$$ISERR(sc) { Do $System.Status.DisplayError(sc)  zn nsOld  Quit sc }
   set rs = stmt.%Execute()

   set GATime="", ForkliftTime="", ControlTime=""
   // Process the results
    While rs.%Next() {
        // Retrieve each row's data
        if rs.TaskType = "CONTROL"
        {
            set ControlTime = rs.TotalHours
        }
        if rs.TaskType = "RECEIVE,LOAD"
        {
            set ForkliftTime = rs.TotalHours
        }
        if rs.TaskType = "STORAGE,PICK,PREPARE"
        {
            set GATime = rs.TotalHours
        }
    }
   zn nsOld

   // --- Parse initial week from filename (unchanged) ---
   Set file = $PIECE(filename, "\", *)
   set fileWOEXT= $PIECE(file, ".", 1)
   set timehwc = $PIECE(fileWOEXT, "_", *)
   set timeh = $e(timehwc,1,5)_","_$e(timehwc,6,*)
   set time = $zdt(timeh,3)
   $$$TRACE("Init week: "_time)

   // --- Single Python call: CSV is read ONCE and all weeks computed there ---
   set json = ..CalculateAllWorkloads(filename, time, 12)
   $$$TRACE(json)

   // Parse JSON to a dynamic array
   set weeksArr = ##class(%DynamicAbstractObject).%FromJSON(json)
   if weeksArr.%Size()=0 {
     $$$TRACE("No weeks returned by CalculateAllWorkloads()")
     Quit $$$OK
   }

   // --- Create Demand/Supply plans using the precomputed results ---
   set iter = weeksArr.%GetIterator()
   while iter.%GetNext(.key, .value ) {
     set item = value
     // Recreate fcTime the same way as the Python produced Week string 
     set fcTime = ##class(%SYSTEM.SQL.Functions).DATEADD("week", item.%Get("Index"), time)

     set pRequest = ##class(CGISC.Requests.CreateDemandRequest).%New()
     set pRequest.InitWeek = time
     set pRequest.Week = fcTime
     set pRequest.GATime = item.%Get("GATime")
     set pRequest.ForkliftTime = item.%Get("ForkliftTime")
     set pRequest.ControlTime = item.%Get("ControlTime")
     set pRequest.PlanType = "forecast"
     set pRequest.Warehouse = "warehouse-01"
     set sc = ..SendRequestSync("CreateDemandPlan", pRequest, .pResponse, -1)

     set sRequest = ##class(CGISC.Requests.CreateSupplyRequest).%New()
     set sRequest.InitWeek = time
     set sRequest.Week = fcTime
     set sRequest.GATime = GATime
     set sRequest.ForkliftTime = ForkliftTime
     set sRequest.ControlTime = ControlTime
     set sRequest.PlanType = "forecast"
     set sRequest.Warehouse = "warehouse-01"
     set sc = ..SendRequestSync("CreateSupplyPlan", sRequest, .sResponse, -1)

   }

   // --- Historical block (unchanged) ---
   set sql = "SELECT productId As productId, SUM(quantity)/60/60 AS TotalHours FROM SC_Data.MfgOrder " _
           "WHERE (actualEndDate >= DATEADD('dd', -7, ?)) OR (notes IS NULL AND plannedStartDate <= ?) " _
           "GROUP BY productId"
   set stmt = ##class(%SQL.Statement).%New()
   set sc = stmt.%Prepare(sql)
   If $$$ISERR(sc) { $$$TRACE(sc) Do $System.Status.DisplayError(sc) Quit sc }
   set rs = stmt.%Execute(time, time)

   set GATimeWL="", ForkliftTimeWL="", ControlTimeWL=""
   While rs.%Next() {
       if rs.productId = "LABORPRODUCT-02" { set ControlTimeWL = rs.TotalHours }
       elseif rs.productId = "LABORPRODUCT-01" { set ForkliftTimeWL = rs.TotalHours }
       elseif rs.productId = "LABORPRODUCT-03" { set GATimeWL = rs.TotalHours }
   }

   set histWeek = ##class(%SYSTEM.SQL.Functions).DATEADD("week", -1, time)

   set pRequest = ##class(CGISC.Requests.CreateDemandRequest).%New()
   set pRequest.InitWeek = time
   set pRequest.Week = histWeek
   set pRequest.GATime = GATimeWL
   set pRequest.ForkliftTime = ForkliftTimeWL
   set pRequest.ControlTime = ControlTimeWL
   set pRequest.PlanType = "historical"
   set pRequest.Warehouse = "warehouse-01"
   set sc = ..SendRequestSync("CreateDemandPlan", pRequest, .pResponse, -1)

   set sRequest = ##class(CGISC.Requests.CreateSupplyRequest).%New()
   set sRequest.InitWeek = time
   set sRequest.Week = histWeek
   set sRequest.GATime = GATime
   set sRequest.ForkliftTime = ForkliftTime
   set sRequest.ControlTime = ControlTime
   set sRequest.PlanType = "historical"
   set sRequest.Warehouse = "warehouse-01"
   set sc = ..SendRequestSync("CreateSupplyPlan", sRequest, .sResponse, -1)

   set sc = ##class(SC.Core.Data.Internal.ManualTask).KickOffTask(time, "warehouse-01")
   $$$TRACE("KickOffTask -> "_sc)

   Quit sc
}

ClassMethod CalculateAllWorkloads(filename As %String, startWeek As %TimeStamp, weeks As %Integer = 12) As %String [ Language = python ]
{
    import pandas as pd
    import numpy as np
    import random
    import json
    from datetime import timedelta
    import iris

    # --- Load once ---
    df = pd.read_csv(filename)
    glob=iris.gref('rows')
    rows = len(df)
    glob[1] = rows

    # Normalize/validate columns
    if 'Week' not in df.columns or 'TotalSales' not in df.columns:
        raise ValueError("CSV must include 'Week' and 'TotalSales' columns.")
    if 'StoreId' not in df.columns:
        df['StoreId'] = ''
    if 'SupplierId' not in df.columns:
        df['SupplierId'] = ''

    # Canonicalize weeks in CSV and the startWeek coming from IRIS
    df['WeekCanon'] = pd.to_datetime(df['Week']).dt.strftime('%Y-%m-%d %H:%M:%S')

    start = pd.to_datetime(str(startWeek))
    # Build exact weekly targets the same way ObjectScript would
    targets = [(i, (start + pd.Timedelta(weeks=i))) for i in range(int(weeks))]
    target_str = [(i, t.strftime('%Y-%m-%d %H:%M:%S')) for (i, t) in targets]

    out = []

    for (idx, wkstr) in target_str:
        fdf = df[df['WeekCanon'] == wkstr]

        # No data for this week → 0s
        if fdf.empty:
            out.append({
                "Index": int(idx),
                "Week": wkstr,
                "GATime": 0.0,
                "ForkliftTime": 0.0,
                "ControlTime": 0.0
            })
            continue

        # --- Original model, per StoreId (WEB vs others) ---
        prepare_time = 0.0
        load_time    = 0.0
        pick_time    = 0.0

        store_totals = fdf.groupby('StoreId')['TotalSales'].sum()

        for store_id, total_sales in store_totals.items():
            if store_id == "WEB":
                avg_prep_time = 1
                avg_time_per_ref = 0.3
                picking_time_per_reference = avg_time_per_ref
                order_preparation_time = avg_prep_time
                # minutes → hours
                pick_time += (total_sales/4) * (picking_time_per_reference * 2 + order_preparation_time) / 60
            else:
                totalItems = np.ceil(total_sales)
                items_per_order = 96 * 33
                while totalItems > 0:
                    items_in_order = items_per_order if totalItems > items_per_order else totalItems
                    totalItems -= items_in_order
                    totalPallets = items_in_order / 96

                    picking_time_per_reference = random.gauss(0.33, 0.05)
                    pallet_prep_time = random.gauss(4, 1)
                    totalpreptime = picking_time_per_reference * (1 + 0.1 * (items_in_order - 1)) + pallet_prep_time
                    # seconds rounding → hours
                    prepare_time += int(totalpreptime * 60) / 60 / 60

                    reception_time_per_pallet = random.gauss(3, 1)
                    totalreceptiontime = reception_time_per_pallet * totalPallets * (1 + 0.9)
                    load_time += int(totalreceptiontime * 60) / 60 / 60

        # --- Per SupplierId (receive/control/storage) ---
        receiveTime  = 0.0
        controlTime  = 0.0
        storageTime  = 0.0

        supplier_totals = fdf.groupby('SupplierId')['TotalSales'].sum()
        for supplier_id, total_sales in supplier_totals.items():
            totalItems = np.ceil(total_sales)
            items_per_order = 96 * 33
            while totalItems > 0:
                items_in_order = items_per_order if totalItems > items_per_order else totalItems
                totalItems -= items_in_order
                totalPallets = items_in_order / 96

                reception_time_per_pallet = random.gauss(3, 1)
                totalreceptiontime = reception_time_per_pallet * totalPallets * (1 + 0.9)
                receiveTime += int(totalreceptiontime * 60) / 60 / 60

                control_time_per_pallet = random.gauss(4, 1)
                cont = control_time_per_pallet * totalPallets
                controlTime += int(cont * 60) / 60 / 60

                storage_time_per_pallet = random.gauss(5, 1.5)
                totalstoragetime = storage_time_per_pallet * totalPallets
                storageTime += int(totalstoragetime * 60) / 60 / 60

        pickprepstore = storageTime + prepare_time + 2 * pick_time
        forklift      = receiveTime + load_time

        out.append({
            "Index": int(idx),
            "Week": wkstr,
            "GATime": float(pickprepstore),
            "ForkliftTime": float(forklift),
            "ControlTime": float(controlTime)
        })

    return json.dumps(out, ensure_ascii=False)
}

}
