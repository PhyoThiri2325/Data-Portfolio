/*analyzing the yearly performance of the products by comparing their sales to both
the average sales of the product and to the previous year's sales*/
with yearly_product_sales as(
select
	year(f.order_date) as order_year,
	p.product_name,
	sum(f.sales_amount) as current_sales
from gold.fact_sales f
left join gold.dim_products p 
on f.product_key = p.product_key
where f.order_date is not null
group by year(f.order_date),p.product_name)
select 
	order_year,
	product_name,
	current_sales,
	avg(current_sales) over(partition by product_name) as avg_sales,
	current_sales - avg(current_sales) over(partition by product_name) as diff_avg,
	CASE 
		WHEN current_sales - avg(current_sales) over(partition by product_name) > 0 THEN 'Above Average'
		WHEN current_sales - avg(current_sales) over(partition by product_name) < 0 THEN 'Below Average'
		ELSE 'Avg'
	END AS avg_change,
	--year-over-year analysis
	LAG(current_sales) over(partition by product_name order by order_year) as py_sales,
	current_sales - LAG(current_sales) over(partition by product_name order by order_year) as diff_py,
	CASE  
		WHEN current_sales - LAG(current_sales) over(partition by product_name order by order_year) > 0 THEN 'Increase'
		WHEN current_sales - LAG(current_sales) over(partition by product_name order by order_year) < 0 THEN 'Decrease'
		ELSE 'No Change'
	END AS 'py_change'
from yearly_product_sales
order by product_name, order_year

with monthly_product_sales as(
select
	month(f.order_date) as order_month,
	p.product_name,
	sum(f.sales_amount) as current_sales
from gold.fact_sales f
left join gold.dim_products p 
on f.product_key = p.product_key
where f.order_date is not null
group by month(f.order_date),p.product_name)
select 
	order_month,
	product_name,
	current_sales,
	avg(current_sales) over(partition by product_name) as avg_sales,
	current_sales - avg(current_sales) over(partition by product_name) as diff_avg,
	CASE 
		WHEN current_sales - avg(current_sales) over(partition by product_name) > 0 THEN 'Above Average'
		WHEN current_sales - avg(current_sales) over(partition by product_name) < 0 THEN 'Below Average'
		ELSE 'Avg'
	END AS avg_change,
	--month-over-month analysis
	LAG(current_sales) over(partition by product_name order by order_month) as py_sales,
	current_sales - LAG(current_sales) over(partition by product_name order by order_month) as diff_py,
	CASE  
		WHEN current_sales - LAG(current_sales) over(partition by product_name order by order_month) > 0 THEN 'Increase'
		WHEN current_sales - LAG(current_sales) over(partition by product_name order by order_month) < 0 THEN 'Decrease'
		ELSE 'No Change'
	END AS 'py_change'
from monthly_product_sales
order by product_name, order_month