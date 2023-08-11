--Data Analysis

--Total Revenue
SELECT SUM(Amount) AS Total_Revenue
FROM Order_Details;



--Avg Order Value
SELECT AVG(Amount) AS Average_Order_Value
FROM Order_Details;



--Customer Retention Rate
WITH RepeatCustomers AS (
    SELECT o.Customer_ID
    FROM Orders o
    GROUP BY o.Customer_ID
    HAVING COUNT(DISTINCT o.Order_ID) > 1
)

SELECT 
    (CAST((SELECT COUNT(*) FROM RepeatCustomers) AS FLOAT) 
     / 
     (SELECT COUNT(*) FROM Customers)) * 100 AS Retention_Rate_Percentage;




--ProductSales Trends
-- Sales by Category
SELECT cat.Category_Name, SUM(od.Amount) AS Total_Sales
FROM Order_Details od
JOIN Sub_Category subcat ON od.Sub_Category_ID = subcat.Sub_Category_ID
JOIN Category cat ON subcat.Category_ID = cat.Category_ID
GROUP BY cat.Category_Name
ORDER BY Total_Sales DESC;


--Combine Customer Data with Order Data
SELECT c.CustomerName, c.State, c.City, o.Order_ID, o.Order_Date
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID;



--Combine Customer Data with Order Data:
WITH MonthlySales AS (
    SELECT 
        YEAR(o.Order_Date) AS Year,
        MONTH(o.Order_Date) AS Month,
        SUM(od.Amount) AS TotalSales
    FROM Orders o
    JOIN Order_Details od ON o.Order_ID = od.Order_ID
    GROUP BY YEAR(o.Order_Date), MONTH(o.Order_Date)
)

SELECT 
    Year, 
    Month, 
    TotalSales,
    LAG(TotalSales, 1, 0) OVER (ORDER BY Year, Month) AS PreviousMonthSales,
    CASE
        WHEN LAG(TotalSales, 1, 0) OVER (ORDER BY Year, Month) = 0 THEN NULL
        ELSE ((TotalSales - LAG(TotalSales, 1, 0) OVER (ORDER BY Year, Month)) / LAG(TotalSales, 1, 0) OVER (ORDER BY Year, Month)) * 100
    END AS MoM_Growth_Percentage
FROM MonthlySales
ORDER BY Year, Month;


--Combine Category Data with Order Details
SELECT cat.Category_Name, SUM(od.Amount) AS Total_Sales
FROM Order_Details od
JOIN Sub_Category subcat ON od.Sub_Category_ID = subcat.Sub_Category_ID
JOIN Category cat ON subcat.Category_ID = cat.Category_ID
GROUP BY cat.Category_Name;



--Customer's Most Purchased Category
WITH CustomerCategoryPurchase AS (
    SELECT 
        c.CustomerName, 
        cat.Category_Name,
        SUM(od.Amount) AS Total_Sales
    FROM Order_Details od
    JOIN Orders o ON od.Order_ID = o.Order_ID
    JOIN Customers c ON o.Customer_ID = c.Customer_ID
    JOIN Sub_Category subcat ON od.Sub_Category_ID = subcat.Sub_Category_ID
    JOIN Category cat ON subcat.Category_ID = cat.Category_ID
    GROUP BY c.CustomerName, cat.Category_Name
)

SELECT 
    CustomerName,
    Category_Name,
    Total_Sales
FROM (
    SELECT 
        CustomerName,
        Category_Name,
        Total_Sales,
        ROW_NUMBER() OVER(PARTITION BY CustomerName ORDER BY Total_Sales DESC) AS RowNum
    FROM CustomerCategoryPurchase
) AS RankedData
WHERE RowNum = 1;


