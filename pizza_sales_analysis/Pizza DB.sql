SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;
SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS Average_Order_Value FROM pizza_sales;

SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales;

SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) /
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Average_Pizza_Per_Order FROM pizza_sales;

---Total Orders by Day
SELECT DATENAME(DW, order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_Order 
FROM pizza_sales
GROUP BY DATENAME(DW, order_date);

--Total Order by Month
SELECT DATENAME(MONTH,order_date) AS Month_Name, COUNT(DISTINCT order_id) AS Total_Order 
FROM pizza_sales
GROUP BY DATENAME(MONTH,order_date)
ORDER BY Total_Order DESC;

SELECT pizza_category,SUM(total_price) AS total_sales, (SUM(total_price)/(SELECT SUM(total_price) from pizza_sales) * 100) AS Total_Sales_Percentage
FROM pizza_sales 
GROUP BY pizza_category;

--Flitering with month(Only Jan)
SELECT pizza_category,SUM(total_price) AS total_sales, 
(SUM(total_price)/(SELECT SUM(total_price) from pizza_sales WHERE MONTH(order_date) = 1) * 100) AS Total_Sales_Percentage
FROM pizza_sales 
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_sales, 
CAST((SUM(total_price)/(SELECT SUM(total_price) FROM pizza_sales)*100) AS DECIMAL(10,2)) AS Sales_Percentage_By_Size
FROM pizza_sales
GROUP BY pizza_size
ORDER BY Sales_Percentage_By_Size DESC;

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_sales, 
CAST((SUM(Total_price)/(SElECT SUM(Total_price) FROM pizza_sales WHERE DATEPART(QUARTER, order_date) = 1) *100) AS decimal(10,2)) AS Sales_Percentage_By_Size
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY pizza_size
ORDER BY Sales_Percentage_By_Size DESC;



---Top 5 By Revenue
SELECT TOP 5 pizza_name,
       SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;

--Bottom 5 by Revenue
SELECT TOP 5 pizza_name,
       SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;

select * from pizza_sales
--Top 5 by Total Quantity
SELECT TOP 5 pizza_name,
       SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC

--Bottom 5 by Total Quantity
SELECT TOP 5 pizza_name,
       SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC

--Top 5 by Total Orders
SELECT TOP 5 pizza_name,
       COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC

--Bottom 5 by Total Orders
SELECT TOP 5 pizza_name,
       COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC

select * from pizza_sales;

select distinct(pizza_size) from pizza_sales