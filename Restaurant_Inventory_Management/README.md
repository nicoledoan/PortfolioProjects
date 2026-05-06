# Restaurant Inventory SQL Analysis

This project analyzes restaurant food and drink inventory data using MySQL. The SQL script performs data cleaning, inventory analysis, price list auditing, and shopping list generation using aggregate queries, window functions, joins, and Common Table Expressions (CTEs).

## Project Goals

- Clean imported inventory data
- Analyze food distribution across brands and storage types
- Identify outdated price list records
- Generate a shopping/restocking list from latest inventory counts

## Tools Used

- MySQL
- SQL Window Functions
- Common Table Expressions (CTEs)
- Aggregate Functions
- Data Cleaning Techniques

## SQL Concepts Demonstrated

- `ALTER TABLE`
- `UPDATE`
- `GROUP BY`
- `COUNT`
- `ROUND`
- Window Functions
- `UNION ALL`
- `DATEDIFF`
- `CAST`
- `COALESCE`
- `LEFT JOIN`
- CTEs
- Subqueries

## Dataset Overview

The project uses three tables:

| Table | Description |
|---|---|
| `foods` | Food item catalog and pricing information |
| `drinks` | Drink item catalog and pricing information |
| `food_inventories` | Historical inventory quantity tracking for Foods |

## Analysis Included

### Data Cleaning
- Fixed imported BOM/encoding issues in column names
- Standardized missing storage type values

### Brand Analysis
- Calculated total foods per brand
- Calculated percent contribution of each brand

### Storage Type Analysis
- Summarized inventory counts by storage category

### Price List Audit
- Identified food and drink items with outdated pricing records
- Calculated days since last price update

### Shopping List Generation
- Pulled latest inventory snapshot
- Identified low-stock items for restocking prioritization

## Example Business Questions Answered

- Which brands make up the largest portion of inventory?
- Which storage types contain the most products?
- Which products may require updated pricing?
- Which inventory items are lowest in stock?
- What items should be prioritized for purchasing?

## File Included

| File | Description |
|---|---|
| `restaurant_inventory_analysis.sql` | Complete SQL script containing all cleaning, analysis, and reporting queries |

## Author

Nicole Doan
