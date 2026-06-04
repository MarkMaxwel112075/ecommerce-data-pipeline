# Alteryx One Workflow — E-Commerce ETL Pipeline

## What this workflow does
Cleans and joins two raw CSV files from the Olist Brazilian 
E-Commerce dataset producing 110,197 clean records ready 
for analysis.

## Tools used in order

| Tool | Purpose | Rows in | Rows out |
|------|---------|---------|---------|
| Input Data #1 | Load olist_orders_dataset.csv | — | 99,441 |
| Filter #3 | Keep delivered orders only | 99,441 | 96,478 |
| Select #4 | Keep key columns, fix types | 96,478 | 96,478 |
| Input Data #2 | Load olist_order_items_dataset.csv | — | 112,650 |
| Select #6 | Convert price/freight to numeric | 112,650 | 112,650 |
| Filter #7 | Remove zero or negative prices | 112,650 | 112,650 |
| Formula #8 | Add total_item_value = price + freight | 112,650 | 112,650 |
| Join #9 | Join orders to items on order_id | — | 110,197 |
| Output #10 | Save ecommerce_clean.csv | 110,197 | 110,197 |

## Results
- Records in: 99,441 orders + 112,650 items
- Records out: 110,197 clean joined records
- Unmatched items removed: 2,453 (expected — non-delivered)
- Errors: 0
- Warnings: 0

## Why Alteryx alongside Python
The same ETL pipeline exists in two forms:
- **Python** (ecommerce_pipeline.ipynb) — for technical teams
- **Alteryx One** (this workflow) — for business teams who 
  need to maintain it without writing code

Both produce identical clean output from the same source data.

![Workflow Canvas](alteryx_workflow.png)
