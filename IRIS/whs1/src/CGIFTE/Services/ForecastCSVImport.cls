Class CGIFTE.Services.ForecastCSVImport Extends Ens.BusinessService
{

Parameter ADAPTER = "EnsLib.File.InboundAdapter";

Method OnProcessInput(pInput As %FileCharacterStream, pOutput As %RegisteredObject) As %Status
{
   set filename = pInput.Filename
   $$$TRACE(filename)
   Set file = $PIECE(filename, "/", *)
   set fileWOEXT= $PIECE(file, ".", 1)
   set time = $PIECE(fileWOEXT, "_", *)
   for i = 0:1:4
   {
    set response =  ..CalculateWorkloadForWeek(filename, time)
    set pRequest = ##class(Ens.StringRequest).%New()
    set pRequest.StringValue = response
    set tSc = ..SendRequestSync("CreateDemandPlan", pRequest, .pResponse, -1)
   }
#;    do ##class(SC.Core.Data.Internal.ManualTask).KickOffTask(time)
   
   return tSc
}

ClassMethod CalculateWorkloadForWeek(filename As %String, week As %TimeStamp) As %String [ Language = python ]
{
    import pandas as pd
    import numpy as np
    import random

        

    # Load the CSV file
    df = pd.read_csv(filename)

    # calculate avg unit per week
    receiveTime = 0
    controlTime = 0
    storageTime = 0
    column_sums = df.drop('Store_id', axis = 1).sum(axis=1)*7/31
    for i in column_sums:
        totalItems = np.ceil(i)
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
    prepare_time = 0
    load_time = 0
    pick_time = 0

    row_sums = df.drop('Store_id', axis=1).sum(axis=1)*7/30
    for ind, i in enumerate(row_sums):
        if ind == 120:
            print(ind)
            print(i)
            # Load properties from ObjectScript
            avg_prep_time = 1
            avg_time_per_ref = 0.3
            # Generate picking time using a normal distribution around the average
            picking_time_per_reference = avg_time_per_ref
            order_preparation_time = avg_prep_time
            pick_time += (i/1.5)*(picking_time_per_reference * 1.5 + order_preparation_time)*60/60/60
        totalItems = np.ceil(i)
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


    output_string = f'Receive Time: {receiveTime}, Control Time: {controlTime}, Storage Time: {storageTime}, Load Time: {load_time}, Prepare Time: {prepare_time}, Pick Time: {pick_time}'
    return output_string
}

}
