-- Customer Segmentation based on Sales and Lifetime

WITH customer_sales_summary AS (
select 
	c.customer_key,
	SUM(f.sales_amount) AS total_sales,
	MAX(f.order_date) AS last_order_date,
	MIN(f.order_date) AS first_order_date,
	DATEDIFF(MONTH,MIN(f.order_date),MAX(f.order_date)) AS customer_lifetime_months
from gold.fact_sales f
left join gold.dim_customers c
	on f.customer_key = c.customer_key
GROUP BY c.customer_key
)

SELECT 
customer_segment,
count(customer_key) as customer_count

from(
select
customer_key,
	CASE WHEN customer_lifetime_months >= 12 AND total_sales > 5000 THEN 'High Value'
	 WHEN customer_lifetime_months >= 12 AND total_sales <= 5000 THEN 'Regular'
	ELSE 'New' END AS customer_segment
FROM customer_sales_summary) as t
GROUP BY customer_segment
order by customer_count DESC