-- Category table
CREATE TABLE Category (
    Category_ID INT PRIMARY KEY IDENTITY(1,1),
    Category_Name NVARCHAR(255) NOT NULL UNIQUE
);

-- Sub_Category table
CREATE TABLE Sub_Category (
    Sub_Category_ID INT PRIMARY KEY IDENTITY(1,1),
    Category_ID INT FOREIGN KEY REFERENCES Category(Category_ID),
    Sub_Category_Name NVARCHAR(255) NOT NULL UNIQUE
);

-- Order table
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Order_Date DATE NOT NULL,
    CustomerName NVARCHAR(255) NOT NULL,
    State NVARCHAR(100) NOT NULL,
    City NVARCHAR(100) NOT NULL
);

-- Order_Details table
CREATE TABLE Order_Details (
    Order_Detail_ID INT PRIMARY KEY IDENTITY(1,1),
    Order_ID INT FOREIGN KEY REFERENCES Orders(Order_ID),
    Amount DECIMAL(18,2) NOT NULL,
    Profit DECIMAL(18,2) NOT NULL,
    Quantity INT NOT NULL,
    Sub_Category_ID INT FOREIGN KEY REFERENCES Sub_Category(Sub_Category_ID)
);

-- Sales_Target table
CREATE TABLE Sales_Target (
    Month_of_Order_Date DATE NOT NULL,
    Category_ID INT FOREIGN KEY REFERENCES Category(Category_ID),
    Target DECIMAL(18,2) NOT NULL,
    PRIMARY KEY (Month_of_Order_Date, Category_ID)
);


-- Insert distinct categories from the old table into the new Category table
INSERT INTO Category (Category_Name)
SELECT DISTINCT Category
FROM old_order_details;

-- Insert distinct sub-categories and their corresponding categories into the Sub_Category table
INSERT INTO Sub_Category (Sub_Category_Name, Category_ID)
SELECT DISTINCT old_order_details.Sub_Category, Category.Category_ID
FROM old_order_details
JOIN Category ON old_order_details.Category = Category.Category_Name;

-- Insert orders from the old list of orders into the new Orders table
INSERT INTO Orders (Order_ID, Order_Date, CustomerName, State, City)
SELECT Order_ID, Order_Date, CustomerName, State, City
FROM old_list_of_orders;

-- Insert order details from the old order details into the new Order_Details table
INSERT INTO Order_Details (Order_ID, Amount, Profit, Quantity, Sub_Category_ID)
SELECT old_order_details.Order_ID, old_order_details.Amount, old_order_details.Profit, old_order_details.Quantity, Sub_Category.Sub_Category_ID
FROM old_order_details
JOIN Sub_Category ON old_order_details.Sub_Category = Sub_Category.Sub_Category_Name;

-- Insert sales targets from the old sales target table into the new Sales_Target table
INSERT INTO Sales_Target (Month_of_Order_Date, Category_ID, Target)
SELECT 
    CONVERT(DATE, '2023-' + RIGHT('0' + CAST(SUBSTRING(old_sales_target.Month_of_Order_Date, 4, 3) AS VARCHAR), 3) + '-' + LEFT(old_sales_target.Month_of_Order_Date, 2)), 
    Category.Category_ID, 
    old_sales_target.Target
FROM old_sales_target
JOIN Category ON old_sales_target.Category = Category.Category_Name;

--create a new Customers table and move relevant data from the Orders table, you need to identify the columns related to customers.
	CREATE TABLE Customers (
		Customer_ID INT PRIMARY KEY IDENTITY(1,1),
		CustomerName NVARCHAR(255) NOT NULL UNIQUE,
		State NVARCHAR(100) NOT NULL,
		City NVARCHAR(100) NOT NULL
);

	ALTER TABLE Customers
	DROP CONSTRAINT UQ__Customer__7A22C6EA234764B4;


	INSERT INTO Customers (CustomerName, State, City)
	SELECT DISTINCT CustomerName, State, City
	FROM Orders;

	SP_HELP Customers;


	ALTER TABLE Orders ADD Customer_ID INT;
	UPDATE Orders
	SET Orders.Customer_ID = Customers.Customer_ID
	FROM Orders
	JOIN Customers ON Orders.CustomerName = Customers.CustomerName
					AND Orders.State = Customers.State
					AND Orders.City = Customers.City;

	ALTER TABLE Orders DROP COLUMN CustomerName;
	ALTER TABLE Orders DROP COLUMN State;
	ALTER TABLE Orders DROP COLUMN City;

	ALTER TABLE Orders
	ADD FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID);

