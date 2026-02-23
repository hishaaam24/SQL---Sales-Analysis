Here’s a polished **GitHub README** you can paste. It’s written to explain **what you were trying to find**, **what questions you answered**, and **what you delivered**, without being CV-short.

---

# Sales, Product & Customer Analytics (SQL)

## Overview

This project uses SQL to analyze sales performance over time, understand what drives revenue (product/category contribution), and segment customers by value and lifecycle. The goal was to create both **insight-led analysis** (answering business questions) and **reusable reporting views** that can power dashboards and make future analysis faster and consistent.

## Business Questions Answered

### 1) How are sales and customers changing over time?

* Built a monthly trend view to track **total sales** and **active customers** over time.
* Used this to understand growth patterns, seasonality, and changes in customer activity.

### 2) Which product categories contribute most to overall revenue?

* Performed a **part-to-whole** analysis to calculate each category’s percentage contribution to total sales.
* This identifies revenue concentration and areas with potential growth opportunity.

### 3) Which products are driving growth (and which are declining)?

* Created a **year-over-year (YoY)** product performance analysis:

  * Annual sales per product
  * Comparison to product’s historical average (above/below average performance)
  * YoY trend signals (increased / decreased / no change)
* This helps surface top-performing products, consistent performers, and declining products that may require action.

### 4) What does our customer base look like by value and lifecycle?

* Segmented customers using:

  * **Customer lifetime** (months between first and last purchase)
  * **Total customer sales**
* Classified customers into meaningful groups (e.g., New / Regular / VIP) to support retention, loyalty strategy, and targeted marketing.

## What I Built (Deliverables)

### 1) Analysis Queries

* Monthly sales & customer trend query
* Category contribution (% of total sales)
* Product YoY performance and benchmarking

### 2) Dashboard-Ready SQL Views

To make analysis repeatable and easy for others, I created two reusable views:

#### `gold.customer_analysis`

A customer-level reporting view designed for segmentation and dashboarding. Includes:

* Customer demographics (age + age band)
* Customer segment (New / Regular / VIP)
* KPIs: recency, lifetime, total orders, total sales, total quantity, products purchased
* Derived metrics: **Average Order Value (AOV)** and **Average Monthly Spend**

#### `gold.product_analysis`

A product-level reporting view designed for product performance tracking. Includes:

* Product attributes (category, subcategory, cost)
* KPIs: total sales, orders, customers, units sold, average selling price
* Portfolio indicators: product lifespan, recency since last sale, performance tier (high/mid/low)
* Derived metrics: **Average Order Revenue** and **Average Monthly Revenue**

## Dataset / Schema Used

This project uses a simple star-schema style structure:

* `gold.fact_sales` — transactional sales data (order_date, sales_amount, quantity, keys)
* `gold.dim_products` — product attributes (name, category, subcategory, cost)
* `gold.dim_customers` — customer attributes (name, birthdate, identifiers)

## Tools & SQL Techniques

* Joins (fact ↔ dimensions)
* Aggregations (SUM, COUNT DISTINCT)
* Window functions (AVG OVER, LAG)
* Time-based grouping (monthly, yearly)
* KPI engineering (recency, lifetime, AOV, monthly spend)
* View creation for reusable reporting layers

