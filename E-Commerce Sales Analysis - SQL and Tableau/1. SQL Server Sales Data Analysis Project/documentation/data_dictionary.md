# Data Dictionary for E-commerce Sales Database

## The database has been organized according to the principles of the Third Normal Form (3NF). 

## Tables

### 1. `Category`

| Column Name | Data Type | Description |
|-------------|----------|-------------|
| Category_ID | INT | Unique identifier for each category. Auto-incremented. |
| Category_Name | NVARCHAR(255) | Name of the category. Unique for each category. |

### 2. `Sub_Category`

| Column Name | Data Type | Description |
|-------------|----------|-------------|
| Sub_Category_ID | INT | Unique identifier for each sub-category. Auto-incremented. |
| Category_ID | INT | Foreign key referencing the `Category` table. Represents the main category for each sub-category. |
| Sub_Category_Name | NVARCHAR(255) | Name of the sub-category. Unique for each sub-category. |

### 3. `Orders`

| Column Name | Data Type | Description |
|-------------|----------|-------------|
| Order_ID | INT | Unique identifier for each order. |
| Order_Date | DATE | Date when the order was placed. |
| CustomerName | NVARCHAR(255) | Name of the customer who placed the order. |
| State | NVARCHAR(100) | State of the customer's address. |
| City | NVARCHAR(100) | City of the customer's address. |

### 4. `Order_Details`

| Column Name | Data Type | Description |
|-------------|----------|-------------|
| Order_Detail_ID | INT | Unique identifier for each order detail. Auto-incremented. |
| Order_ID | INT | Foreign key referencing the `Orders` table. Links order details to a specific order. |
| Amount | DECIMAL(18,2) | Total amount for the specific order detail. |
| Profit | DECIMAL(18,2) | Profit obtained from the specific order detail. |
| Quantity | INT | Quantity of items in the specific order detail. |
| Sub_Category_ID | INT | Foreign key referencing the `Sub_Category` table. Indicates the sub-category of the product. |

### 5. `Sales_Target`

| Column Name | Data Type | Description |
|-------------|----------|-------------|
| Month_of_Order_Date | DATE | The month and year for which the sales target is set. |
| Category_ID | INT | Foreign key referencing the `Category` table. Indicates the category for which the target is set. |
| Target | DECIMAL(18,2) | The sales target amount for the specific category in a particular month. |

### 6. `Customers`

| Column Name | Data Type | Description |
|-------------|----------|-------------|
| Customer_ID | INT | Unique identifier for each customer. Auto-incremented. |
| CustomerName | NVARCHAR(255) | Name of the customer. |
| State | NVARCHAR(100) | State of the customer's address. |
| City | NVARCHAR(100) | City of the customer's address. |

---

