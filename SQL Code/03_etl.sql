-- ============================================
-- File: 03_etl.sql
-- Description: Data transformation & loading into dimensions and fact table
-- ============================================

-- Insert into dim_date
INSERT INTO dim_date(order_date, year, month, month_name, quarter, day, week)
SELECT DISTINCT
	order_date,
	EXTRACT(YEAR FROM order_date),
	EXTRACT(MONTH FROM order_date),
	TO_CHAR(order_date,'Mon'),
	EXTRACT(QUARTER FROM order_date),
	EXTRACT(DAY FROM order_date),
	EXTRACT(WEEK FROM order_date)
FROM swiggy_data;

-- Location
INSERT INTO dim_location (state, city, location)
SELECT DISTINCT state, city, location
FROM swiggy_data;

-- Restaurant
INSERT INTO dim_restaurant(restaurant_name)
SELECT DISTINCT restaurant_name
FROM swiggy_data;

-- Category
INSERT INTO dim_category(category)
SELECT DISTINCT category
FROM swiggy_data;

-- Dish
INSERT INTO dim_dish(dish_name)
SELECT DISTINCT dish_name
FROM swiggy_data;

-- Fact Table Load
INSERT INTO fact_swiggy_order
(date_id, location_id, restaurant_id, category_id, dish_id, price, rating, rating_count)
SELECT
	dd.date_id, 
	dl.location_id, 
	dr.restaurant_id, 
	dc.category_id, 
	di.dish_id, 
	s.price, 
	s.rating, 
	s.rating_count
FROM swiggy_data s
JOIN dim_date dd 
	ON s.order_date = dd.order_date
JOIN dim_location dl 
	ON s.state = dl.state 
	AND s.city = dl.city 
	AND s.location = dl.location
JOIN dim_restaurant dr 
	ON s.restaurant_name = dr.restaurant_name
JOIN dim_category dc 
	ON s.category = dc.category
JOIN dim_dish di 
	ON s.dish_name = di.dish_name;