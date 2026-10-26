/*customers three segements based on the spending behavior:
- VIP: Customers with at least 12 months of history and spending more than 5,000.
- Regular: Customers with at least 12 months of history but spending 5000 or less.
- New: Customers with a lifespan less than 12 months.
and find the total number of customers by each group.*/

--CTE
WITH customer_spending as(
select 
	c.customer_key,
	sum(f.sales_amount) as total_spending,
	min(order_date) as first_order,
	max(order_date) as last_order,
	DATEDIFF(month, min(order_date), max(order_date)) as lifespan
from gold.fact_sales f
left join gold.dim_customers c
on f.customer_key = c.customer_key
group by c.customer_key)
select 
	customer_segment,
	count(customer_key) as total_customers
from(
select 
	customer_key,
	total_spending,
	lifespan,
	CASE
		WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
		WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
		ELSE 'New'
	END AS customer_segment
from customer_spending)t
group by customer_segment
order by total_customers desc