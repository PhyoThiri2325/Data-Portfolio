# AdventureWorks Sales Analysis Using SQL

## Project Overview

This project uses Microsoft SQL Server and the AdventureWorks 2022 sample database to analyse sales performance, product categories, and monthly sales trends.

The goal is to practise SQL querying techniques and use sales data to answer business questions, identify patterns, and generate insights.

## Business Questions

### 1. Sales Overview
- Calculate total sales before and after discounts, and the total number of orders.
- Calculate the total discount amount.
- Calculate the average order value (AOV) after discounts.

### 2. Sales Trends
- Analyse total sales after discounts by year.
- Track monthly sales over time.
- Identify the month with the highest sales.

### 3. Product Analysis
- Identify the top 10 products by sales.
- Analyse sales by product category.
- Rank product categories by total sales using a window function.

### 4. Deeper Analysis
- Identify products with sales above the average product-level sales.
- Calculate each product category's percentage contribution to total sales.
- Compare monthly sales with the previous month using `LAG()`.

## Tools and SQL Skills

- **Database:** Microsoft SQL Server
- **Language:** T-SQL
- **Joins:** Combine data from related tables
- **Aggregate functions:** `SUM()`, `COUNT()`, and `AVG()`
- **Grouping and sorting:** `GROUP BY`, `ORDER BY`
- **Subqueries and CTEs:** Organise queries and compare results
- **Window functions:** `RANK()`, `LAG()`, and `SUM() OVER()`
- **Conditional logic:** `CASE`
- **Business metrics:** Total sales, discounts, average order value, and percentage contribution

## Database Tables Used

This project uses the following tables from the AdventureWorks transactional database:

| Table | Purpose |
|---|---|
| `Sales.SalesOrderHeader` | Order-level information, including order dates and order IDs |
| `Sales.SalesOrderDetail` | Product-level order details, including quantities, unit prices, and discounts |
| `Production.Product` | Product information and product names |
| `Production.ProductSubcategory` | Links products to their subcategories |
| `Production.ProductCategory` | Product category names and category identifiers |

These tables are joined to analyse sales across different time periods and product categories.

## Key Findings

- **Total sales after discounts:** Approximately 109.85 million.
- **Total sales before discounts:** Approximately 110.37 million.
- **Top-performing category:** Bikes contributed approximately 86.17% of total sales, followed by Components at 10.74%.
- **Highest-sales month:** March 2014, with approximately 7.22 million in sales after discounts.

*Note: The analysis covers May 2011 to June 2014. The first and last calendar years represent partial-year periods, so annual comparisons should be interpreted accordingly.*

## Project Structure

```text
AdventureWorks-SQL-Analysis/
├── 01_sales_overview.sql
├── 02_sales_trends.sql
├── 03_product_analysis.sql
├── 04_deeper_analysis.sql
└── README.md
```

## Dataset and Setup

This project uses Microsoft's AdventureWorks sample database. The database file is not included in this repository.

To download and restore the sample database, follow Microsoft's official instructions:

[AdventureWorks Sample Databases — Microsoft Learn](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver17&tabs=ssms)

I used AventureWorks2022 version for my project.

## Project Purpose

This project demonstrates my practical SQL skills in querying relational data, calculating business metrics, analysing sales trends, and using SQL techniques to answer business-focused questions.
