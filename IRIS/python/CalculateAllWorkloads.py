import pandas as pd
import numpy as np
import random
import json
from datetime import timedelta
import argparse

parser = argparse.ArgumentParser(description="Calculate workloads for given sales data.")
parser.add_argument("--filename", type=str, default="/data/WHS1/test/sales_data_test1_6648061200.csv_2025-08-28_16.57.43.664", help="Path to the sales data CSV file.")
parser.add_argument("--startWeek", type=str, default="2023-01-06 17:00:00", help="Start week in the format 'YYYY-MM-DD HH:MM:SS'.")
parser.add_argument("--weeks", type=int, default=12, help="Number of weeks to calculate workloads for.")

args = parser.parse_args()

filename = args.filename
startWeek = args.startWeek
weeks = args.weeks

print(f"Arguments received: filename={filename}, startWeek={startWeek}, weeks={weeks}")
df = pd.read_csv(filename)

print("nb rows:", len(df))

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

print(json.dumps(out, ensure_ascii=False))
