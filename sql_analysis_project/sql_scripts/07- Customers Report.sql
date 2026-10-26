/* Customer Report
Purpose - This report consolidates key customer metrics and behaviors

Highlights:
1. Gather essentital fields such as names, ages, and transaction details.
2. Segment customers into categories(VIP, Regular, New) and age groups.
3. Aggregate customer-level metrics:
   - total orders
   - total sales
   - total quantity purchased
   - total products
   - lifespan(in months)
4. Calculate valuable KPIs:
   - recency(months since last order)
   - average order value
   - average monthly spend
*/

WITH base_query AS(
select 
	f.order_number,
	f.product_key,
	f.order_date,
	f.sales_amount,
	f.quantity,
	c.customer_key,
	c.customer_number,
	CONCAT(c.first_name, ' ', c.last_name) as customer_name,
	DATEDIFF(year, c.birthdate, GETDATE()) as age
from gold.fact_sales f
left join gold.dim_customers c
on f.customer_key = c.customer_key
where order_date IS NOT NULL)
, customer_aggregation as(
select 
	customer_key,
	customer_number,
	customer_name,
	age,
	count(distinct order_number) as total_orders,
	sum(sales_amount) as total_sales,
	sum(quantity) as total_quantity,
	count(distinct product_key) as total_products,
	max(order_date) as last_order_date,
    DATEDIFF(month, min(order_date), max(order_date)) as life_span
from base_query
group by customer_key, customer_number, customer_name, age)
select 
	customer_key,
	customer_number,
	customer_name,
	age,
	CASE 
		WHEN age < 20 THEN 'Under 20'
		WHEN age BETWEEN 20 and 29 THEN '20-29'
		WHEN age BETWEEN 30 and 39 THEN '30-39'
		WHEN age BETWEEN 40 and 49 THEN '40-49'
		ELSE '50 and above'
	END AS age_group,
	CASE
		WHEN life_span >= 12 AND total_sales > 5000 THEN 'VIP'
		WHEN life_span >= 12 AND total_sales <= 5000 THEN 'Regular'
		ELSE 'New'
	END AS customer_segment,
	last_order_date,
	DATEDIFF(month, last_order_date, GETDATE()) as recency,
	total_orders,
    total_sales,
	total_quantity,
	total_products,
	life_span,
	-- compuate average order value(avo)
	CASE WHEN total_sales = 0 THEN 0
		 ELSE total_sales / total_orders
    END AS avg_order_value,
	-- Computate average montly spend
	CASE WHEN life_span = 0 THEN total_sales
		 ELSE total_sales/life_span
	END AS avg_monthly_spend
from 
customer_aggregation