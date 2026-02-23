-- cumulative sum of sales by month

Select 
sales_month,
total_sales,
SUM(total_sales) OVER(partition by sales_month ORDER BY sales_month) as running_total_Sales
from
(
select
			datetrunc(month, order_date) AS sales_month,
			SUM(sales_amount) AS total_sales
from gold.fact_sales
where order_date is NOT NULL
group by 	datetrunc(month, order_date)
) as sales_by_month

-- cumulative sum of sales by year (+ running average)

Select 
sales_year,
total_sales,
SUM(total_sales) OVER( ORDER BY sales_year) as running_total_Sales,
AVG(total_sales) OVER( ORDER BY sales_year) as running_avg_Sales
from
(
select
			datetrunc(YEAR, order_date) AS sales_year,
			SUM(sales_amount) AS total_sales,
			AVG(sales_amount) AS avg_sales
from gold.fact_sales
where order_date is NOT NULL
group by 	datetrunc(Year, order_date)
) as sales_by_year


