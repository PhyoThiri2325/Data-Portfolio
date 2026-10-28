--Topic: Sales Trend

--4. total sales after discounts for each year
SELECT 
	YEAR(h.OrderDate) order_year,
	ROUND(SUM(d.OrderQty * d.UnitPrice * (1- d.UnitPriceDiscount)),2) AS total_sales_after_discounts
FROM Sales.SalesOrderHeader h
LEFT JOIN Sales.SalesOrderDetail d
on h.SalesOrderID = d.SalesOrderID
GROUP BY YEAR(h.OrderDate)
ORDER BY YEAR(h.OrderDate) DESC

--5. monthly sales
SELECT 
	format(h.OrderDate, 'yyyy-MM') AS order_month,
	ROUND(SUM(d.OrderQty * d.UnitPrice * (1- d.UnitPriceDiscount)),2) AS total_sales_after_discounts
FROM Sales.SalesOrderHeader h
LEFT JOIN Sales.SalesOrderDetail d
on h.SalesOrderID = d.SalesOrderID
GROUP BY format(h.OrderDate, 'yyyy-MM')
ORDER BY format(h.OrderDate, 'yyyy-MM')

--6. month with the higest sales
SELECT TOP 1 * FROM(
SELECT 
	format(h.OrderDate, 'yyyy-MM') AS order_month,
	ROUND(SUM(d.OrderQty * d.UnitPrice * (1- d.UnitPriceDiscount)),2) AS total_sales_after_discounts
FROM Sales.SalesOrderHeader h
LEFT JOIN Sales.SalesOrderDetail d
on h.SalesOrderID = d.SalesOrderID
GROUP BY format(h.OrderDate, 'yyyy-MM'))t
ORDER BY total_sales_after_discounts DESC
