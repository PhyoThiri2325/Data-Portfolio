--Topic: Sales Overview

--1. total sales before discounts, total sales after discounts, total orders
SELECT 
	ROUND(SUM(OrderQty * UnitPrice),2) AS total_sales_before_discounts,
	ROUND(SUM(OrderQty * UnitPrice * (1- UnitPriceDiscount)),2) AS total_sales_after_discounts,
	COUNT(DISTINCT SalesOrderID) AS total_orders
FROM Sales.SalesOrderDetail;

--2. total discount amount
SELECT 
	ROUND(SUM(OrderQty * UnitPrice * UnitPriceDiscount),2) AS total_discount
FROM Sales.SalesOrderDetail;

--3. average order value(AOV) after discounts
SELECT 
	ROUND(SUM(OrderQty * UnitPrice * (1- UnitPriceDiscount))/ COUNT(DISTINCT SalesOrderID),2) AS average_order_value
FROM Sales.SalesOrderDetail;
