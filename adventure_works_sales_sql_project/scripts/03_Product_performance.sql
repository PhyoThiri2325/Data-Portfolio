--Topic: Product Performance

--7. top 10 products by sales after discounts.
SELECT TOP 10 *
FROM(SELECT 
	ROUND(SUM(d.OrderQty * d.UnitPrice * (1 - d.UnitPriceDiscount)),2) total_sales_after_discounts,
	p.ProductID,
	p.Name AS product_category
FROM Sales.SalesOrderDetail d 
LEFT JOIN Production.Product p
ON d.ProductID = p.ProductID
GROUP BY p.ProductID,p.Name)t
ORDER BY total_sales_after_discounts DESC

--8. sales by product category.
SELECT 
	c.Name AS product_category,
	ROUND(SUM(d.OrderQty * d.UnitPrice * (1- d.UnitPriceDiscount)),2) AS total_sales
FROM Sales.SalesOrderDetail d
LEFT JOIN Production.Product p
ON d.ProductID = p.ProductID
LEFT JOIN Production.ProductSubcategory s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
LEFT JOIN Production.ProductCategory c
ON s.ProductCategoryID = c.ProductCategoryID
GROUP BY c.Name;

--9. Rank product categories from highest to lowest sales using a window function.
SELECT 
	product_category,
	total_sales,
	RANK() OVER(ORDER BY total_sales DESC) AS ranking
FROM(SELECT 
	c.Name AS product_category,
	ROUND(SUM(d.OrderQty * d.UnitPrice * (1- d.UnitPriceDiscount)),2) AS total_sales
FROM Sales.SalesOrderDetail d
LEFT JOIN Production.Product p
ON d.ProductID = p.ProductID
LEFT JOIN Production.ProductSubcategory s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
LEFT JOIN Production.ProductCategory c
ON s.ProductCategoryID = c.ProductCategoryID
GROUP BY c.Name)t