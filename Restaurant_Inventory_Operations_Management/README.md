# 🍽️ Restaurant Inventory Operations Analysis (SQL Project)

## 📌 Overview

This project analyzes restaurant inventory and pricing data using MySQL to support operational decision-making around inventory management, data quality, and restocking workflows. The analysis focuses on identifying inventory distribution patterns, auditing outdated pricing records, and generating actionable shopping lists from historical inventory data.

The project demonstrates how SQL can be used for operational analytics through data cleaning, joins, aggregations, Common Table Expressions (CTEs), and reporting logic.

---

## 🗂️ Dataset

The project is built on three relational tables:

* **foods** – food item catalog including pricing, storage type, and brand information
* **drinks** – drink item catalog including pricing and storage information
* **food_inventories** – historical inventory quantity tracking

---

## ⚙️ Key Techniques Used

* Common Table Expressions (CTEs)
* Aggregate Functions (`COUNT`, `MAX`)
* Window Functions (`SUM() OVER`)
* Multi-table joins
* `UNION ALL`
* Data cleaning with `ALTER TABLE` and `UPDATE`
* Date calculations using MySQL functions
* Null handling with `COALESCE`

---

## 📊 Key Analyses

### 1. Data Cleaning & Standardization

* Fixed imported BOM/encoding issues in primary key column names
* Standardized blank storage type values to improve reporting consistency

```sql
UPDATE foods
SET storage_type = 'unknown'
WHERE storage_type = '';
```

---

### 2. Brand Distribution Analysis

* Calculated total food items per brand
* Measured each brand’s contribution to the overall inventory catalog using a window function

```sql
ROUND(
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
    2
)
```

---

### 3. Storage Type Operational Analysis

* Aggregated inventory counts by storage category
* Evaluated operational distribution across frozen, refrigerated, and dry storage inventory

| Storage Type | Operational Insight |
|---|---|
| Frozen | High inventory concentration |
| Refrigerated | Moderate inventory volume |
| Unknown | Missing classification requiring cleanup |

---

### 4. Pricing Record Audit

Combined food and drink datasets into a unified operational report:

* Calculated days since last pricing update
* Identified records potentially requiring pricing review or refresh
* Standardized reporting across inventory categories using `UNION ALL`

```sql
DATEDIFF(
    CURRENT_DATE,
    CAST(price_last_updated_ts AS DATE)
)
```

---

### 5. Inventory Restocking Workflow

Built a shopping/restocking report using the most recent inventory snapshot:

* Retrieved latest inventory records using a CTE
* Joined latest inventory quantities back to the product catalog
* Replaced null quantities with `0` using `COALESCE`
* Prioritized lowest-stock items for operational purchasing review

```sql
COALESCE(i.quantity, 0)
```

---

## 📈 Example Outputs

This project generates operational reporting outputs including:

- **Brand Inventory Distribution**
- **Storage Type Summary Reporting**
- **Outdated Pricing Audit**
- **Low-Inventory Restocking List**

These outputs support inventory visibility, pricing maintenance, and operational purchasing decisions.

---

## 🚀 How to Run

1. Create database:

```sql
CREATE DATABASE restaurant_project;
USE restaurant_project;
```

2. Import CSV datasets into MySQL tables

3. Execute the SQL analysis script:

```sql
restaurant_inventory_analysis.sql
```

---

## 💡 Key Takeaways

* SQL can support operational inventory management and workflow optimization
* CTEs improve readability for multi-step operational reporting
* Window functions simplify percentage-based inventory analysis
* Data cleaning is critical for accurate operational reporting
* Consolidated reporting improves visibility across inventory categories

---

## 🛠️ Tools Used

* MySQL
* SQL (CTEs, joins, aggregations, window functions)

---

## 📌 Future Improvements

* Build dashboard visualizations in Tableau or Power BI
* Add inventory turnover analysis
* Analyze inventory trends over time
* Add supplier/vendor performance metrics
* Implement automated low-stock alert logic

---

## 👤 Author

Nicole Doan
