-- finding the change over time (trend analysiis for sales.)

select
			FORMAT(order_date, 'yyyy-MMM') AS sales_year,
			SUM(sales_amount) AS total_sales_amount,
			COUNT (DISTINCT customer_key) AS total_customers
from gold.fact_sales
where order_date is NOT NULL
group by 	FORMAT(order_date, 'yyyy-MMM') 
order by 	FORMAT(order_date, 'yyyy-MMM') 