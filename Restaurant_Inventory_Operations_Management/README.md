# 🍽️ Restaurant Inventory Analysis (SQL Project)

## 📌 Overview

This project analyzes restaurant food and drink inventory data using MySQL to evaluate inventory distribution, identify outdated pricing records, and generate shopping/restocking insights from inventory history. It demonstrates how operational inventory data can be transformed into actionable business insights using joins, aggregations, window functions, and Common Table Expressions (CTEs).

---

## 🗂️ Dataset

The project is built on three relational tables:

* **foods** – food item catalog including pricing, brand, and storage information
* **drinks** – drink item catalog including pricing and storage information
* **food_inventories** – historical food inventory quantity tracking

---

## ⚙️ Key Techniques Used

* Common Table Expressions (CTEs)
* Window Functions:

  * `SUM() OVER`
* Aggregations (`COUNT`, `MAX`)
* Multi-table joins
* `UNION ALL`
* Data cleaning with `ALTER TABLE` and `UPDATE`
* Date calculations using MySQL functions
* Null handling with `COALESCE`

---

## 📊 Key Analyses

### 1. Data Cleaning & Standardization

* Fixed imported BOM/encoding issues in column names
* Standardized missing storage type values

```sql
UPDATE foods
SET storage_type = 'unknown'
WHERE storage_type = '';
```

---

### 2. Food Brand Distribution

* Calculated total number of foods per brand
* Calculated each brand’s percentage contribution to the full food catalog using a window function

```sql
ROUND(
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
    2
)
```

---

### 3. Storage Type Analysis

* Aggregated food counts by storage category
* Evaluated inventory distribution across storage types

| Storage Type | Example Insight |
|---|---|
| Frozen | High inventory concentration |
| Refrigerated | Moderate inventory volume |
| Unknown | Missing classification requiring cleanup |

---

### 4. Price List Audit

Combined food and drink datasets to identify outdated pricing records:

* Calculated days since last price update
* Unified food and drink reporting using `UNION ALL`

```sql
DATEDIFF(
    CURRENT_DATE,
    CAST(price_last_updated_ts AS DATE)
)
```

---

### 5. Shopping List Generation

Built a shopping/restocking report using the most recent inventory snapshot:

* Pulled latest inventory date using a CTE
* Joined latest inventory levels back to the foods table
* Replaced null inventory quantities with `0` using `COALESCE`
* Prioritized lowest-stock items first

```sql
COALESCE(i.quantity, 0)
```

---

## 📈 Example Outputs

This project produces the following analytical outputs:

- **Brand Distribution Analysis**  
  → Food counts and percentage contribution by brand

- **Storage Type Summary**  
  → Inventory distribution across storage categories

- **Outdated Pricing Report**  
  → Food and drink items with aging price list records

- **Shopping / Restocking List**  
  → Lowest inventory items prioritized for purchasing

---

## 🚀 How to Run

1. Create database:

```sql
CREATE DATABASE restaurant_project;
USE restaurant_project;
```

2. Import CSV datasets into MySQL tables

3. Run the SQL analysis script:

```sql
restaurant_inventory_analysis.sql
```

---

## 💡 Key Takeaways

* Window functions simplify percentage-based analysis
* CTEs improve readability for multi-step inventory logic
* `UNION ALL` enables consolidated operational reporting
* Null handling is critical when analyzing inventory datasets
* SQL can support operational decision-making beyond financial analytics

---

## 🛠️ Tools Used

* MySQL
* SQL (CTEs, joins, aggregations, window functions)

---

## 📌 Future Improvements

* Build dashboard visualizations in Tableau or Power BI
* Add inventory turnover analysis
* Track inventory trends over time
* Add supplier/vendor performance analysis
* Create automated low-stock alerts

---

## 👤 Author

Nicole Doan
