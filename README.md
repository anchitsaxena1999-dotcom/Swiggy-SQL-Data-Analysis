# 🍕 Swiggy Data Analysis — SQL Project

![SQL](https://img.shields.io/badge/SQL-PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)
![Domain](https://img.shields.io/badge/Domain-Food%20Tech%20%7C%20Analytics-orange?style=for-the-badge)

---

## 📌 Project Overview

This project performs end-to-end **SQL-based data analysis** on a real-world Swiggy food delivery dataset. The workflow covers raw data ingestion, data cleaning, dimensional modelling (Star Schema), and business intelligence queries to extract meaningful KPIs and trends.

> **Goal:** Transform raw, flat Swiggy order data into a structured data warehouse and derive actionable business insights using SQL.

---

## 📊 Dataset Description

The raw dataset contains Swiggy food delivery records with the following columns:

| Column | Data Type | Description |
|---|---|---|
| `state` | VARCHAR | State where the order was placed |
| `city` | VARCHAR | City of the order |
| `order_date` | DATE | Date of the order |
| `restaurant_name` | VARCHAR | Name of the restaurant |
| `location` | VARCHAR | Area/locality of the restaurant |
| `category` | VARCHAR | Food category (e.g., Biryani, Pizza) |
| `dish_name` | VARCHAR | Name of the ordered dish |
| `price` | FLOAT | Price of the dish (INR) |
| `rating` | FLOAT | Restaurant rating |
| `rating_count` | INT | Number of ratings received |

---

## 🧱 Project Architecture

The project follows a **Star Schema** (dimensional modelling) approach:

```
                        ┌─────────────┐
                        │  dim_date   │
                        └──────┬──────┘
                               │
┌──────────────┐   ┌───────────▼──────────┐   ┌──────────────────┐
│ dim_location │───│  fact_swiggy_order   │───│  dim_restaurant  │
└──────────────┘   └───────────┬──────────┘   └──────────────────┘
                               │
               ┌───────────────┼───────────────┐
               │                               │
       ┌───────▼──────┐              ┌──────────▼─┐
       │ dim_category │              │  dim_dish  │
       └──────────────┘              └────────────┘
```

| Table | Description |
|---|---|
| `dim_date` | Date attributes — year, month, quarter, week, day |
| `dim_location` | State, city, and area/location |
| `dim_restaurant` | Unique restaurant names |
| `dim_category` | Food categories |
| `dim_dish` | Unique dish names |
| `fact_swiggy_order` | Central fact table — price, rating, rating_count linked to all dimensions |

---

## 🔧 Steps Performed

### 1️⃣ Data Ingestion
- Created the raw staging table `swiggy_data` and loaded the CSV data into PostgreSQL

### 2️⃣ Data Validation & Cleaning
- **Null Check** — Counted NULL values across all columns to assess data completeness
- **Duplicate Detection** — Identified duplicate rows using `GROUP BY` + `HAVING COUNT(*) > 1`
- **Duplicate Removal** — Deleted duplicates using `ROW_NUMBER()` window function with `ctid`

### 3️⃣ Schema Design & Normalization
- Designed a Star Schema with 5 dimension tables and 1 fact table
- Populated dimensions using `SELECT DISTINCT` from the staging table
- Built the fact table by joining all dimensions back to the raw data

### 4️⃣ KPI & Business Analysis
- Total Orders, Total Revenue (₹), Average Dish Price, Average Rating
- Monthly & quarterly order trends
- Orders by day of the week using `TO_CHAR` and `ISODOW`
- Price range distribution using `CASE WHEN` bucketing

---

## 💡 Skills Demonstrated

- Real-world data cleaning and validation with SQL
- Dimensional modelling — Star Schema / Data Warehousing concepts
- Business analytics — KPIs, time-series trends, price segmentation
- PostgreSQL-specific features: `ctid`, `ISODOW`, `TO_CHAR` with INR formatting, `SERIAL` keys

---

## 🙋‍♂️ Author

**Anchit Saxena**
- 💼 [LinkedIn](https://www.linkedin.com/in/anchitsaxena-analyst/)
- 🐙 [GitHub](https://github.com/anchitsaxena1999-dotcom)

---

> ⭐ *If you found this project useful, consider giving it a star!*
