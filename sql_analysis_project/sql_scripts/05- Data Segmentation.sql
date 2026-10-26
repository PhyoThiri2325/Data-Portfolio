--grouping products by the cost ranges
WITH product_segments AS
(select 
	product_key,
	product_name,
	cost,
	CASE WHEN cost < 100 THEN 'Below 100'
		 WHEN cost BETWEEN 100 AND 500 THEN '100-500'
		 WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
	ELSE 'Above 1000'
END cost_range
from gold.dim_products)
select	
	cost_range,
	count(product_key) total_products
from product_segments
group by cost_range
order by total_products DESC

WITH customer_spending
AS(select 
	c.customer_key,
	sum(f.sales_amount) total_spending,
	min(order_date) first_order,
	max(order_date) last_order,
	DATEDIFF(month, min(order_date), max(order_date)) as lifespan
from gold.fact_sales f
left join gold.dim_customers c
on f.customer_key = c.customer_key
group by c.customer_key)


--grouping customers by their spending behaviors
select
	customer_segment,
	count(customer_key) total_customers
from(
select 
	customer_key,
	CASE WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
		 WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
		 ELSE 'New'
	END customer_segment
from customer_spending)
t
group by customer_segment
order by total_customers desc





