
# 🦠 COVID-19 Data Analysis with SQL

This project is a data exploration and analysis of global COVID-19 data using **Microsoft SQL Server** and **SQL Server Management Studio (SSMS)**. The project focuses on analyzing cases, deaths, and vaccinations using SQL queries, including the use of **CTEs**, **temp tables**, and **views**.

---

## 📁 Dataset Overview

Two datasets from **Our World in Data** are used:

- `CovidDeaths.csv`: Includes daily COVID-19 cases, deaths, and population data by location.
- `CovidVaccinations.csv`: Includes daily vaccination data by location.

These are imported into a SQL Server database named `PortfolioProject` with the following tables:

- `PortfolioProject..CovidDeaths`
- `PortfolioProject..CovidVaccinations`

---

## 🔍 Key SQL Queries and Analysis

### 1. **Exploratory Data Queries**
- View and sort data by location and date.
- Compare total cases, new cases, total deaths, and population.

### 2. **Case Fatality Analysis**
```sql
SELECT location, date, total_cases, total_deaths,
       (CAST(total_deaths AS FLOAT) / total_cases) * 100 AS "Death Percentage"
FROM PortfolioProject..CovidDeaths
```

### 3. **Infection Rate Analysis**
```sql
SELECT location, date, total_cases, population,
       (CAST(total_cases AS FLOAT) / population) * 100 AS "Infected_Population_Percentage"
FROM PortfolioProject..CovidDeaths
```

### 4. **Highest Infection and Death Counts**
```sql
SELECT location, MAX(total_cases) AS "Highest Infection Count", population,
       MAX((CAST(total_cases AS FLOAT) / population)) * 100 AS "Infected_Population_Percentage"
FROM PortfolioProject..CovidDeaths
GROUP BY location, population
ORDER BY [Infected_Population_Percentage] DESC
```

### 5. **Death Rate by Continent**
```sql
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths,
       SUM(CAST(new_deaths AS FLOAT)) / SUM(new_cases) * 100 AS "Death Percentage"
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
```

### 6. **Vaccination Progress Using JOIN**
```sql
SELECT CD.continent, CD.location, CD.date, CD.population,
       CV.new_vaccinations,
       SUM(CONVERT(INT, CV.new_vaccinations)) OVER (PARTITION BY CV.location ORDER BY CV.location, CV.date) AS "RollingPeopleVaccinated"
FROM PortfolioProject..CovidDeaths CD
JOIN PortfolioProject..CovidVaccinations CV ON CD.location = CV.location AND CD.date = CV.date
WHERE CD.continent IS NOT NULL
```

### 7. **Using CTE (Common Table Expression)**
```sql
WITH PopVsVac AS (
  SELECT CD.continent, CD.location, CD.date, CD.population,
         CV.new_vaccinations,
         SUM(CONVERT(INT, CV.new_vaccinations)) OVER (PARTITION BY CV.location ORDER BY CV.location, CV.date) AS RollingPeopleVaccinated
  FROM PortfolioProject..CovidDeaths CD
  JOIN PortfolioProject..CovidVaccinations CV ON CD.location = CV.location AND CD.date = CV.date
  WHERE CD.continent IS NOT NULL
)
SELECT *, (CAST(RollingPeopleVaccinated AS FLOAT) / Population) * 100 AS "Vaccinated People Percentage"
FROM PopVsVac
```

### 8. **Using Temp Table**
```sql
DROP TABLE IF EXISTS #VaccinatedPopulationPercent

CREATE TABLE #VaccinatedPopulationPercent (
  Continent VARCHAR(50),
  Location VARCHAR(50),
  Date DATETIME,
  Population NUMERIC,
  New_vaccinations NUMERIC,
  RollingPeopleVaccinated NUMERIC
)

INSERT INTO #VaccinatedPopulationPercent
SELECT dea.continent, dea.location, dea.date, dea.population,
       vac.new_vaccinations,
       SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.Location, dea.date)
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac ON dea.location = vac.location AND dea.date = vac.date
```

### 9. **Creating a View**
```sql
CREATE VIEW VaccinatedPopulationPercent AS
SELECT dea.continent, dea.location, dea.date, dea.population,
       vac.new_vaccinations,
       SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.Location, dea.date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac ON dea.location = vac.location AND dea.date = vac.date
```

---

## 🛠 Tools Used

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- T-SQL
- Window Functions
- CTEs, Temp Tables, Views

---

## 📌 Project Highlights

- Data analysis through pure SQL queries
- Window functions to track trends over time
- Intermediate-level SQL: joins, subqueries, aggregation, filtering
- Creation of views and temp tables for modular query design

---

## 📈 Potential Extensions

- Build interactive dashboards using Power BI or Tableau
- Automate data refresh using SQL Agent
- Add time-series trend charts

---

## ✅ How to Use

1. Import `CovidDeaths.csv` and `CovidVaccinations.csv` into SQL Server.
2. Run the SQL script file (`Covid_SQL_Analysis.sql`) in SSMS.
3. Explore or modify queries for your own insights.

---

## 📬 Contact

Have questions or feedback? Feel free to open an issue or connect with me!
