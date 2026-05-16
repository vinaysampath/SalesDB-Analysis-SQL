
use [Amazon Salesdb]

select * from INFORMATION_SCHEMA.TABLES;

select * from INFORMATION_SCHEMA.Columns;


-- Total Sales & Profit --

select
Sales AS Total_Sales,
Profit AS Total_Profit
from Amazon_sales_data;

--  Total Orders and Sales by Region --

Select
Count(Order_ID) as Orders_Count,
Region,
SUM(sales) as Total_Sales
From Amazon_sales_data
Group By Region

-- Top Products by sales --

select
Product,
SUM(Sales) AS Total_Sales
from Amazon_sales_data
Group By Product
Order By SUM(Sales) Desc;


--  Monthly Trend --

select
FORMAT(date, 'yyyy-MM') AS trend_month,
Region,
Category,
Product,
SUM(Sales) as Total_Sales,
Count(Order_ID) AS Order_Count
from Amazon_sales_data
Group by FORMAT(date, 'yyyy-MM'),Region,Category,Product
Order By trend_month


SELECT 
    FORMAT(Date, 'yyyy-MM') AS Month_Trend,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    COUNT(Order_ID) AS Order_Count
FROM Amazon_sales_data
GROUP BY FORMAT(Date, 'yyyy-MM')
ORDER BY Month_Trend;






