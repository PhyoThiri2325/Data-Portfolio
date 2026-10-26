/*
Product Report
Purpose: This report consolidates key product metrics and behaviors.

Highlights:
1.Gather essentital fields such as product name, category, subcategory and cost.
2.Segment products by revenue to identify High-Performers, Mid-Range and Low-Performers.
3.Aggregate product-level metrics:
 - total orders
 - total sales
 - total quantity sold
 - total customers(unique)
 - lifespan(in months)
4.Calculate valuable KPIS:
 - recency(months since last sale)
 - average order revenue (AOR)
 - average monthly revenue
*/
WITH base_query as (
select 
	f.order_number,
	f.order_date,
	f.customer_key,
	f.sales_amount,
	f.quantity,
	p.product_key,
	p.product_name,
	p.category,
	p.subcategory,
	p.cost
from gold.fact_sales f
left join gold.dim_products p
on f.product_key = p.product_key
where order_date is not null
),
product_aggregation as(
--2. Summarize key metrics at the product level
select 
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	DATEDIFF(month, min(order_date), max(order_date)) as lifespan,
	max(order_date) as last_sale_date,
	count(distinct order_number) as total_orders,
	count(distinct customer_key) as total_customers,
	sum(sales_amount) as total_sales,
	sum(quantity) as total_quantity,
	round(avg(cast(sales_amount as float)/Nullif(quantity,0)),1) as avg_selling_price
from base_query
group by product_key,
		 product_name,
		 category,
		 subcategory,
		 cost)
/*3. Final Quert: Combine all product results into one output*/
select 
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	last_sale_date,
	DATEDIFF(month, last_sale_date, GETDATE()) as receny_in_months,
	CASE	
		WHEN total_sales > 50000 THEN 'High-Performer'
		WHEN total_sales >= 10000 THEN 'Mid-Range'
		ELSE 'Low-Performer'
	END As product_segment,
	lifespan,
	total_orders,
	total_sales,
	total_quantity,
	total_customers,
	avg_selling_price,
	--Average Order Revenue(AOR)
	CASE
		WHEN total_orders = 0 THEN 0
		ELSE total_sales/ total_orders
	END AS avg_order_revenue,
	--Average Monthly Revenue
	CASE
		WHEN lifespan = 0 THEN total_sales
		ELSE total_sales/lifespan
	END AS avg_monthly_revenue
from
product_aggregation