-- ============================================
-- File: 02_cleaning.sql
-- Description: Data validation & cleaning
-- ============================================

-- Null Check
SELECT 
	sum(case when state is null then 1 else 0 end) as null_state,
	sum(case when city is null then 1 else 0 end) as null_city,
	sum(case when order_date is null then 1 else 0 end) as null_order_date,
	sum(case when location is null then 1 else 0 end) as null_location,
	sum(case when restaurant_name is null then 1 else 0 end) as null_restaurant,
	sum(case when category is null then 1 else 0 end) as null_category,
	sum(case when dish_name is null then 1 else 0 end) as null_dish_name,
	sum(case when price is null then 1 else 0 end) as null_price,
	sum(case when rating is null then 1 else 0 end) as null_rating,
	sum(case when rating_count is null then 1 else 0 end) as null_rating_count
FROM swiggy_data;

-- Duplicate Check
SELECT state, city, order_date, restaurant_name, location, category, dish_name, price, rating, rating_count, COUNT(*)
FROM swiggy_data
GROUP BY state, city, order_date, restaurant_name, location, category, dish_name, price, rating, rating_count
HAVING COUNT(*) > 1;

-- Remove Duplicates
DELETE FROM swiggy_data
WHERE ctid IN (
    SELECT ctid
    FROM (
        SELECT ctid,
               ROW_NUMBER() OVER (
                   PARTITION BY state, city, order_date, restaurant_name, location, 
                                category, dish_name, price, rating, rating_count
                   ORDER BY ctid
               ) AS rn
        FROM swiggy_data
    ) t
    WHERE rn > 1
);