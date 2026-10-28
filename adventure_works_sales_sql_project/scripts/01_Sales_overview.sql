--Topic: Sales Overview


SELECT total_sales_before_discounts/total_orders AS average_order_value,
	   *
FROM
(SELECT
	SUM(OrderQty * UnitPrice) AS total_sales_before_discounts,
	SUM(OrderQty * UnitPrice * (1- UnitPriceDiscount)) AS total_sales_after_discounts,
	COUNT(DISTINCT SalesOrderID) AS total_orders
FROM Sales.SalesOrderDetail)t
