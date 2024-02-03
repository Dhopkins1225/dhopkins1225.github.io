-- Perform data cleaning and transformation using SQL queries to handle missing values and standardize data.
-- Check missing values in Orders table
SELECT 
    COUNT(CASE WHEN Order_ID IS NULL THEN 1 END) AS Missing_Order_ID,
    COUNT(CASE WHEN Order_Date IS NULL THEN 1 END) AS Missing_Order_Date
    -- Add other columns in a similar pattern if there are more columns
FROM Orders;


SELECT 
    COUNT(CASE WHEN Customer_ID IS NULL THEN 1 END) AS Missing_Customer_ID,
    COUNT(CASE WHEN CustomerName IS NULL THEN 1 END) AS Missing_CustomerName,
    COUNT(CASE WHEN State IS NULL THEN 1 END) AS Missing_State,
    COUNT(CASE WHEN City IS NULL THEN 1 END) AS Missing_City
FROM Customers;


SELECT 
    COUNT(CASE WHEN Month_of_Order_Date IS NULL THEN 1 END) AS Missing_Month_of_Order_Date,
    COUNT(CASE WHEN Category_ID IS NULL THEN 1 END) AS Missing_Category_ID,
    COUNT(CASE WHEN Target IS NULL THEN 1 END) AS Missing_Target
FROM Sales_Target;


SP_HELP Order_Details;
SELECT 
    COUNT(CASE WHEN Order_ID IS NULL THEN 1 END) AS Missing_Order_ID,
    COUNT(CASE WHEN Amount IS NULL THEN 1 END) AS Missing_Amount,
    COUNT(CASE WHEN Profit IS NULL THEN 1 END) AS Missing_Profit,
    COUNT(CASE WHEN Quantity IS NULL THEN 1 END) AS Missing_Quantity
FROM Order_Details;


--Check for Duplicate Values:
-- Category
SELECT Category_ID, COUNT(*) 
FROM Category 
GROUP BY Category_ID 
HAVING COUNT(*) > 1;

-- Customers
SELECT Customer_ID, COUNT(*) 
FROM Customers 
GROUP BY Customer_ID 
HAVING COUNT(*) > 1;

-- Order_Details
SELECT Order_Detail_ID, COUNT(*)  -- Assuming Order_Detail_ID is a primary key
FROM Order_Details 
GROUP BY Order_Detail_ID 
HAVING COUNT(*) > 1;

-- Orders
SELECT Order_ID, COUNT(*) 
FROM Orders 
GROUP BY Order_ID 
HAVING COUNT(*) > 1;

-- Sales_Target
SELECT Month_of_Order_Date, Category_ID, COUNT(*) 
FROM Sales_Target 
GROUP BY Month_of_Order_Date, Category_ID 
HAVING COUNT(*) > 1;

--Validate Foreign Key Relations:
-- Check for orphan Order_Details
SELECT * FROM Order_Details
WHERE Order_ID NOT IN (SELECT Order_ID FROM Orders);


--Check Data Distribution:
SELECT Category_Name, COUNT(*) as Count 
FROM Category
GROUP BY Category_Name;

-- For CustomerName
SELECT CustomerName, COUNT(*) as Count 
FROM Customers
GROUP BY CustomerName
ORDER BY Count DESC;

-- For State
SELECT State, COUNT(*) as Count 
FROM Customers
GROUP BY State
ORDER BY Count DESC;

-- For City
SELECT City, COUNT(*) as Count 
FROM Customers
GROUP BY City
ORDER BY Count DESC;


--Remove leading/trailing spaces:
-- For Customers
UPDATE Customers
SET CustomerName = LTRIM(RTRIM(CustomerName));

UPDATE Category
SET Category_Name = LTRIM(RTRIM(Category_Name));

UPDATE Customers
SET 
    CustomerName = LTRIM(RTRIM(CustomerName)),
    State = LTRIM(RTRIM(State)),
    City = LTRIM(RTRIM(City));

