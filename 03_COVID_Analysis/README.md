# 🦠 COVID-19 Data Exploration (SQL Project)

## 📌 Overview

This project explores global COVID-19 deaths, cases, population, testing, and vaccination data using MySQL. The analysis focuses on infection rates, death rates, vaccination progress, and global trends over time.

It demonstrates how raw public health data can be imported, cleaned, transformed, and analyzed using SQL.

---

## 🗂️ Dataset

The project is built on two main tables:

* **CovidDeaths** – COVID case, death, population, hospitalization, and ICU data
* **CovidVaccinations** – COVID testing, vaccination, demographic, and health indicator data

---

## ⚙️ Key Techniques Used

* Table creation with `CREATE TABLE`
* CSV import using `LOAD DATA INFILE`
* Data cleaning with `NULLIF`
* Date conversion using `STR_TO_DATE`
* Joins across deaths and vaccination datasets
* Aggregate functions:

  * `SUM`
  * `MAX`

* Window Functions:

  * `SUM() OVER`

* Common Table Expressions (CTEs)
* Temporary tables
* Views for visualization outputs

---

## 📊 Key Analyses

### 1. Data Import & Cleaning

Created MySQL tables for COVID deaths and vaccination data, then imported CSV files using `LOAD DATA INFILE`.

The import process handled:

* Blank values converted to `NULL`
* Date formatting from CSV text into MySQL date format
* Extra CSV columns during file import
* Separate death and vaccination datasets

```sql
date = STR_TO_DATE(@date, '%m/%d/%Y')
```

---

### 2. Total Cases vs. Total Deaths

Analyzed the relationship between total confirmed cases and total deaths to calculate the death percentage among reported cases.

```sql
(total_deaths / total_cases) * 100 AS deathspercase
```

Example business question:

* What percentage of reported COVID cases resulted in death?

---

### 3. Total Cases vs. Population

Compared total cases against population to estimate the percentage of the population that contracted COVID.

```sql
(total_cases / population) * 100 AS contractionpercentage
```

Example business question:

* What share of a country’s population has been infected?

---

### 4. Countries with Highest Infection Rates

Identified countries with the highest infection counts and infection rates relative to population.

```sql
MAX(total_cases / population) * 100 AS HighestInfectionRate
```

---

### 5. Countries with Highest Death Counts

Calculated the highest total death count by country while excluding subtotal rows where continent values were missing.

```sql
WHERE continent IS NOT NULL
```

This helped avoid mixing country-level rows with continent-level subtotal rows.

---

### 6. Death Count by Continent

Aggregated death counts by continent to compare COVID mortality impact across regions.

```sql
SELECT continent, MAX(total_deaths) AS TotalDeathCount
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY continent;
```

---

### 7. Global Numbers by Day

Calculated daily global totals for new cases, new deaths, and death percentage.

```sql
SUM(new_deaths) / SUM(new_cases) * 100 AS DeathPercentage
```

---

### 8. Rolling Vaccination Count

Joined death and vaccination datasets to calculate cumulative vaccination counts by country using a window function.

```sql
SUM(vac.new_vaccinations) OVER (
    PARTITION BY dea.location
    ORDER BY dea.location, dea.date
)
```

---

### 9. Vaccination Rate Analysis

Calculated vaccination rate as rolling vaccinations divided by population.

The project demonstrates this calculation using:

* Direct window function query
* Common Table Expression (CTE)
* Temporary table

```sql
(RollingPeopleVaccinated / Population) * 100 AS VaccinationRate
```

---

### 10. View Creation for Visualization

Created a SQL view to store summarized death count by continent for future dashboarding or visualization work.

```sql
CREATE VIEW TotalDeathbyContinent AS
SELECT continent, MAX(total_deaths) AS TotalDeathCount
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY continent;
```

---

## 📈 Example Outputs

This project produces the following analytical outputs:

- **COVID Death Percentage by Country**
- **COVID Infection Percentage by Population**
- **Countries with Highest Infection Rates**
- **Countries with Highest Death Counts**
- **Global Daily Case and Death Trends**
- **Rolling Vaccination Count by Country**
- **Vaccination Rate by Population**
- **Death Count by Continent View**

---

## 🚀 How to Run

1. Create the MySQL tables:

```sql
CREATE TABLE CovidDeaths (...);
CREATE TABLE CovidVaccinations (...);
```

2. Place CSV files in the MySQL upload directory:

```text
C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/
```

3. Import CSV files using `LOAD DATA INFILE`.

4. Run the exploratory SQL queries.

5. Use the created view for visualization:

```sql
SELECT *
FROM TotalDeathbyContinent;
```

---

## 💡 Key Takeaways

* SQL can be used to clean, transform, and analyze large public health datasets
* `NULLIF` helps safely convert blank CSV values into usable SQL nulls
* Window functions are useful for cumulative metrics like rolling vaccination counts
* Filtering out subtotal rows improves country- and continent-level accuracy
* Views can prepare analysis outputs for dashboard tools like Tableau or Power BI

---

## 🛠️ Tools Used

* MySQL
* SQL
* CSV data import
* Views for visualization preparation

---

## 📌 Future Improvements

* Build Tableau dashboard using SQL output views
* Add rolling averages for cases and deaths
* Compare vaccination rates against death rates
* Add country-level filtering by region or income group
* Create additional views for dashboard-ready outputs

---

## 👤 Author

Nicole Doan
