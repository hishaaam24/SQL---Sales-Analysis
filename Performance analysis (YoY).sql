--- PERFORMANCE ANALYSIS OF PRODUCT SALES OVER TIME (YoY)

WITH product_sales_by_year AS (

select 
	YEAR(f.order_date) AS order_year,
	p.product_name,
	SUM(f.sales_amount) AS current_year_sales
from gold.fact_sales f
left join gold.dim_products p
	on f.product_key = p.product_key
where order_date is not NULL
group by YEAR(f.order_date), p.product_name
)

select 
	 order_year,
	 product_name,
	 current_year_sales,
	 AVG(current_year_sales) OVER (PARTITION BY product_name) AS average_sales,
	 current_year_sales - AVG(current_year_sales) OVER (PARTITION BY product_name) AS sales_difference_from_average,
CASE WHEN current_year_sales - AVG(current_year_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Average'
	 WHEN current_year_sales - AVG(current_year_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Average'
ELSE 'Average' 
END AS performance_category,
LAG(current_year_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS previous_year_sales,
CASE 
	 WHEN current_year_sales - LAG(current_year_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increased'
	 WHEN current_year_sales - LAG(current_year_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decreased'
ELSE 'No Change' 
END AS sales_trend
from product_sales_by_year
order by product_name, order_year