-- Part to whole analysis to calculate the percentage contribution of each product category to the overall sales.

With sales_by_category AS (
select 
	p.category,
	SUM(f.sales_amount) AS total_sales
from gold.fact_sales f
	left join gold.dim_products p
		on f.product_key = p.product_key
group by p.category
)

select 
 category,
 total_sales,
 SUM(total_sales) OVER() AS overall_sales,
 CONCAT(ROUND(CAST(total_sales AS Float)* 100.0 / SUM(total_sales) OVER(),2),'%') AS sales_percentage
 from 
 sales_by_category
 order by sales_percentage DESC