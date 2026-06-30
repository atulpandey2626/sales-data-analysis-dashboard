-- Relational Queries for Data Extraction and Aggregation Tasks

-- 1. Regional Performance Comparison KPI
SELECT 
    Region,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Quantity) AS Total_Units_Sold,
    ROUND(SUM(Gross_Revenue), 2) AS Gross_Revenue,
    ROUND(SUM(Net_Revenue), 2) AS Total_Net_Revenue
FROM sales_records
GROUP BY Region
ORDER BY Total_Net_Revenue DESC;


-- 2. Top 10 Products by Sales Volume KPI
SELECT 
    Product_ID,
    Product_Name,
    Category,
    SUM(Quantity) AS Total_Volume_Sold,
    ROUND(SUM(Net_Revenue), 2) AS Generated_Revenue
FROM sales_records
GROUP BY Product_ID, Product_Name, Category
ORDER BY Total_Volume_Sold DESC
LIMIT 10;


-- 3. Monthly Profit Margins & Month-over-Month Growth Tracker
WITH MonthlyMetrics AS (
    SELECT 
        DATE_TRUNC('month', Order_Date) AS Sales_Month,
        SUM(Net_Revenue) AS Total_Revenue,
        SUM(Total_Cost) AS Total_Production_Cost,
        (SUM(Net_Revenue) - SUM(Total_Cost)) AS Total_Profit
    FROM sales_records
    GROUP BY DATE_TRUNC('month', Order_Date)
),
MoMGrowth AS (
    SELECT 
        Sales_Month,
        Total_Revenue,
        Total_Profit,
        ROUND((Total_Profit / Total_Revenue) * 100, 2) AS Profit_Margin_Percentage,
        LAG(Total_Revenue) OVER (ORDER BY Sales_Month) AS Previous_Month_Revenue
    FROM MonthlyMetrics
)
SELECT 
    TO_CHAR(Sales_Month, 'YYYY-MM') AS Calendar_Month,
    ROUND(Total_Revenue, 2) AS Monthly_Revenue,
    ROUND(Profit_Margin_Percentage, 2) AS Profit_Margin_Pct,
    ROUND(
        COALESCE(
            ((Total_Revenue - Previous_Month_Revenue) / Previous_Month_Revenue) * 100, 
            0
        ), 2
    ) AS Month_over_Month_Growth_Rate_Pct
FROM MoMGrowth
ORDER BY Calendar_Month ASC;


-- 4. Anomaly Detection Query
SELECT 
    Order_ID,
    Customer_ID,
    Order_Date,
    Net_Revenue,
    Discount,
    ROUND((Discount / Gross_Revenue) * 100, 2) AS Discount_Ratio_Percentage
FROM sales_records
WHERE Discount > (SELECT AVG(Discount) + (2 * STDDEV(Discount)) FROM sales_records)
ORDER BY Discount DESC;
