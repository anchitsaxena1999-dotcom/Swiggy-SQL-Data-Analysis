-- ============================================
-- File: 01_schema.sql
-- Description: Table creation (Raw + Dimension + Fact)
-- ============================================

-- Raw Table
CREATE TABLE swiggy_data(
	state varchar(20),
	city varchar(20),
	order_date date,
	restaurant_name varchar(55),
	location varchar(50),
	category varchar(60),
	dish_name varchar(200),
	price NUMERIC(10,2),
	rating NUMERIC(3,2),
	rating_count int
);

-- Dimension Tables

CREATE TABLE dim_date(
	date_id serial primary key,
	order_date date,
	year int,
	month int,
	month_name varchar(20),
	quarter int,
	day int,
	week int
);

CREATE TABLE dim_location(
	location_id serial primary key,
	state varchar(20),
	city varchar(20),
	location varchar(60)
);

CREATE TABLE dim_restaurant(
	restaurant_id serial primary key,
	restaurant_name varchar(60)
);

CREATE TABLE dim_category(
	category_id serial primary key,
	category varchar(60)	
);

CREATE TABLE dim_dish(
	dish_id serial primary key,
	dish_name varchar(200)
);

-- Fact Table
DROP TABLE IF EXISTS fact_swiggy_order;

CREATE TABLE fact_swiggy_order (
	order_id serial primary key,
	date_id int,
	location_id int,
	restaurant_id int,
	category_id int,
	dish_id int,
	price NUMERIC(10,2),
	rating NUMERIC(3,2),
	rating_count int,
	foreign key (date_id) references dim_date(date_id),
	foreign key (location_id) references dim_location(location_id),
	foreign key (restaurant_id) references dim_restaurant(restaurant_id),
	foreign key (category_id) references dim_category(category_id),
	foreign key (dish_id) references dim_dish(dish_id)
);