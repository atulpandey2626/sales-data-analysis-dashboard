# Sales Data Analysis Dashboard

A sales data project covering data cleaning in Python, analytical SQL queries, and a Power BI dashboard for tracking revenue, profit margins, and growth trends.

## About

This project takes raw sales data, cleans and standardizes it using Python, runs analytical SQL queries to extract business insights, and visualizes the results in Power BI with key metrics like regional performance, top products, monthly profit margins, and anomaly detection for unusual discounts.

## Features

- Automated data cleaning pipeline (duplicate removal, missing value handling, type standardization)
- Regional sales performance comparison
- Top 10 products by sales volume
- Monthly profit margin and month-over-month growth tracking
- Anomaly detection for unusually high discount transactions
- Power BI dashboard with DAX measures for revenue, profit margin, and growth rate

## Tech Stack

| Layer | Technology |
|---|---|
| Data Cleaning | Python, Pandas |
| Data Analysis | SQL |
| Visualization | Power BI, DAX |

## Project Structure

sales-data-analysis-dashboard/
- scripts/clean_data.py
- sql/sales_queries.sql
- powerbi/dax_measures.txt
- README.md

## How It Works

1. Raw sales data (Excel) is loaded and cleaned using clean_data.py - removing duplicates, handling missing values, and calculating gross and net revenue
2. SQL queries in sales_queries.sql extract key business metrics like regional performance, top products, and monthly growth trends
3. The cleaned data is connected to Power BI, where DAX measures calculate total revenue, profit margin percentage, and month-over-month growth rate
4. Dashboard visuals present these metrics in an easy-to-read format for business decision making

## Setup & Run

### Prerequisites
- Python 3 with pandas and openpyxl installed
- Power BI Desktop

### Steps

Place raw_sales_data.xlsx in a data folder, then run:

python scripts/clean_data.py

This generates cleaned_sales_data.xlsx, which can be loaded into Power BI. Use the SQL queries in sql/sales_queries.sql for further analysis, and the measures in powerbi/dax_measures.txt for building dashboard visuals.

## What I Learned

- Building a data cleaning pipeline with Pandas
- Writing analytical SQL queries with window functions and CTEs
- Creating time-intelligence DAX measures in Power BI
- Connecting raw data through cleaning, analysis, and visualization stages

## Author

Atul Pandey
B.Tech Computer Science 
