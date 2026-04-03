-- ============================================
-- File: 04_analysis.sql
-- Description: KPI & Business Insights
-- ============================================

-- Total Orders
SELECT COUNT(*) AS total_orders
FROM fact_swiggy_order;

-- Total Revenue
SELECT ROUND(SUM(price),2) AS total_revenue
FROM fact_swiggy_order;

-- Average Price
SELECT ROUND(AVG(price),2) AS avg_price
FROM fact_swiggy_order;

-- Average Rating
SELECT ROUND(AVG(rating),2) AS avg_rating
FROM fact_swiggy_order;

-- Monthly Trend
SELECT dd.year, dd.month, dd.month_name, COUNT(*) AS total_orders
FROM fact_swiggy_order f
JOIN dim_date dd ON dd.date_id = f.date_id
GROUP BY dd.year, dd.month, dd.month_name
ORDER BY dd.year, dd.month;

-- Quarterly Trend
SELECT dd.year, dd.quarter, COUNT(*) AS total_orders
FROM fact_swiggy_order f
JOIN dim_date dd ON dd.date_id = f.date_id
GROUP BY dd.year, dd.quarter
ORDER BY dd.year, dd.quarter;

-- Orders by Day
SELECT
	TO_CHAR(dd.order_date,'Dy') AS day_name,
	COUNT(*) AS total_orders,
	EXTRACT(ISODOW FROM dd.order_date) AS day_order
FROM fact_swiggy_order f
JOIN dim_date dd ON dd.date_id = f.date_id
GROUP BY day_name, day_order
ORDER BY day_order;

-- Price Range Distribution
SELECT price_range, COUNT(*) AS order_count
FROM (
	SELECT 
		CASE 
			WHEN price < 100 THEN 'Under 100'
			WHEN price BETWEEN 100 AND 199 THEN '100-199'
			WHEN price BETWEEN 200 AND 299 THEN '200-299'
			WHEN price BETWEEN 300 AND 499 THEN '300-499'
			ELSE '500+'
		END AS price_range
	FROM fact_swiggy_order
) t
GROUP BY price_range
ORDER BY price_range;

--Ratings Analysis
--Distribution of dish ratings from 1–5.

SELECT 
	CASE 
		WHEN rating BETWEEN 1 AND 1.9 THEN '1 - 1.9'
		WHEN rating BETWEEN 2 AND 2.9 THEN '2 - 2.9'
		WHEN rating BETWEEN 3 AND 3.9 THEN '3 - 3.9'
		WHEN rating BETWEEN 4 AND 4.5 THEN '4 - 4.5'
		WHEN rating > 4.5 THEN '4.5+'
		ELSE 'Unknown'
	END AS rating_range,
	COUNT(*) AS total_dishes
FROM fact_swiggy_order
GROUP BY rating_range
ORDER BY rating_range;