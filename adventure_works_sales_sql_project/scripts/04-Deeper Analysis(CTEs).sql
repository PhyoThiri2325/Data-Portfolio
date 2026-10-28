--Topic: CTEs

--10. Use a CTE to calculate sales by product, then return products whose sales are above the average product sales.
WITH product_sales AS(
SELECT 
	p.ProductID,
	p.Name AS product_name,
	SUM(d.OrderQty * d.UnitPrice * (1 - d.UnitPriceDiscount)) AS total_sales
FROM Sales.SalesOrderDetail d
LEFT JOIN Production.Product p
ON d.ProductID = p.ProductID
GROUP BY p.ProductID,p.Name)
SELECT
	ProductID,
	product_name,
	total_sales
FROM product_sales
WHERE total_sales > (SELECT AVG(total_sales) FROM product_sales)
ORDER BY total_sales DESC

--11. Calculate each product category's percentage contribution to total sales.
WITH category_sales AS(
SELECT 
	c.Name AS product_category,
	SUM(d.OrderQty * d.UnitPrice * (1 - d.UnitPriceDiscount)) AS total_sales
FROM Sales.SalesOrderDetail d
LEFT JOIN Production.Product p
ON d.ProductID = p.ProductID
LEFT JOIN Production.ProductSubcategory s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
LEFT JOIN Production.ProductCategory c
ON s.ProductCategoryID = c.ProductCategoryID
GROUP BY c.Name)
SELECT 
	product_category,
	total_sales,
	CONCAT(ROUND(CAST(total_sales AS FLOAT)/ SUM(total_sales) OVER() * 100,2), '%') AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC

--12. Compare each month's sales with the previous month using LAG().
WITH monthly_sales AS(
SELECT 
	FORMAT(h.OrderDate, 'yyyy-MM') AS order_date,
	ROUND(SUM(d.OrderQty * d.UnitPrice * (1 - d.UnitPriceDiscount)),2) AS current_sales
FROM Sales.SalesOrderDetail d
LEFT JOIN Sales.SalesOrderHeader h
ON d.SalesOrderID = h.SalesOrderID
GROUP BY FORMAT(h.OrderDate, 'yyyy-MM'))
SELECT 
	order_date,
	current_sales,
	LAG(current_sales) OVER(ORDER BY order_date) pm_sales,
	current_sales - LAG(current_sales) OVER(ORDER BY order_date) AS diff_pm,
	CASE 
		WHEN current_sales - LAG(current_sales) OVER(ORDER BY order_date) > 0 THEN 'Increase'
		WHEN current_sales - LAG(current_sales) OVER(ORDER BY order_date) < 0 THEN 'Decrease'
		ELSE 'No Change'
	END AS pm_change
FROM monthly_sales
