-- CREATING FINAL REPORT TO ANALYZE CUSTOMER SEGMENTATION BASED ON SALES, QUANTITY, AND LIFETIME (dashboard)

CREATE VIEW gold.customer_analysis AS
-- these are the basic details of sales and customers, we will use this as a base for further analysis

WITH basic_details AS(
SELECT
	f.order_number,
	f.product_key,
	f.order_date,
	f.sales_amount,
	f.quantity,
	c.customer_key,
	c.customer_number,
	CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
	DATEDIFF(YEAR, c.birthdate, GETDATE()) age
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
),

Customer_aggregation AS(
-- customer segmentation based on sales, quantity, and lifetime
select 
	customer_key,
	customer_number,
	customer_name,
	age,
	COUNT(DISTINCT order_number) as total_orders,
	sum(sales_amount) as total_sales,
	sum(quantity) as total_quantity,
	COUNT(DISTINCT product_key) as total_products_purchased,
	MAX(order_date) as last_order_date,
	DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) as customer_lifetime_months
from basic_details
group by 
	customer_key, 
	customer_number, 
	customer_name, 
	age
)
select
	customer_key,
	customer_number,
	customer_name,
	age,
CASE 
	WHEN age < 20 THEN 'Under 20'
	WHEN age between 20 and 29 THEN '20-29'
	WHEN age between 30 and 39 THEN '30-39'
	WHEN age between 40 and 49 THEN '40-49'
ELSE '50 and above'
END AS age_group,

CASE
	WHEN customer_lifetime_months >= 12 AND total_sales > 5000 THEN 'VIP'
	WHEN customer_lifetime_months >= 12 AND total_sales <= 5000 THEN 'Regular'
ELSE 'New'
END AS customer_segment,
	last_order_date,
	DATEDIFF(month, last_order_date, GETDATE()) AS recency,
	total_orders,
	total_sales,
	total_quantity,
	total_products_purchased,
	customer_lifetime_months,

-- Calculating average order value
CASE WHEN total_sales = 0 THEN 0
ELSE total_sales / total_orders
END AS avg_order_value,

-- Calculaitng average monthly spend
CASE WHEN customer_lifetime_months = 0 THEN total_sales
ELSE (total_sales / customer_lifetime_months)
END AS avg_monthly_spend
from Customer_aggregation
