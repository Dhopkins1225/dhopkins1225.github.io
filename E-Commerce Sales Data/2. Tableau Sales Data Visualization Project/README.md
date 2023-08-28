# Tableau Sales Data Visualization Project 

Welcome to the Tableau Visualization segment of the Sales Data Analysis Project! Building upon the foundation of our SQL analysis, this phase emphasizes on turning those insights into intuitive visual presentations. The goal is to visually interpret sales trends, customer behaviors, and product performance.

## Data Integration with Tableau

### 1. Data Loading 

**Located in:**
- `/outputs/`
  - `aggregated_sales_by_category.csv`
  - `top_performing_subcategories.csv`
  - `monthly_sales_growth.csv`

- `/data/raw/`
  - `List_of_Orders.csv`
  - `Order_Details.csv`
  - `Sales_Targets.csv`

### 2. Interactive Visualizations

**Located in:**
- `/tableau_workbooks/`
  - `01_sales_trends.twb`
  - `02_customer_behavior.twb`
  - `03_product_performance.twb`


### 3. Dashboard Creation

**Located in:**
- `/tableau_dashboard/`
  - `sales_data_analysis_dashboard.twb`



## Additional Resources:

- `/documentation/`
  - `data_dictionary.md` - Details about data columns and types
  - `er_diagram.png` - Entity relationship diagram
- `/outputs/`
  - `aggregated_sales_by_region.csv`
  - `top_performing_products.csv`


# SQL Sales Data Analysis 

### Key Metrics Explored 

1. **Total Revenue** 
   - Overview: Calculating the overall revenue generated from all sales.
   - SQL Insight: `SELECT SUM(Amount) AS Total_Revenue FROM Order_Details;`
   
2. **Average Order Value** 
   - Overview: Finding the mean value of all orders placed.
   - SQL Insight: `SELECT AVG(Amount) AS Average_Order_Value FROM Order_Details;`
   
3. **Customer Retention Rate** 
   - Overview: Determining the percentage of customers who have placed more than one order, indicating loyalty.
   - SQL Insight: [Complex SQL query using CTE `RepeatCustomers` and main calculation.]
   
4. **Sales by Category** 
   - Overview: Insight into the revenue generation of each product category.
   - SQL Insight: `SELECT cat.Category_Name, SUM(od.Amount) AS Total_Sales FROM Order_Details od JOIN Sub_Category subcat ON ...`
   
5. **Customer Order Data** 
   - Overview: Merging customer details with their respective order data.
   - SQL Insight: `SELECT c.CustomerName, c.State, c.City, o.Order_ID, o.Order_Date FROM Customers c JOIN Orders o ON ...`
   
6. **Monthly Sales and MoM Growth** 
   - Overview: Monthly sales tracking and its growth percentage relative to the previous month.
   - SQL Insight: [Complex SQL query using CTE `MonthlySales` and main MoM calculation.]
   
7. **Total Sales by Category** 
   - Overview: Another perspective on the sales divided by category.
   - SQL Insight: `SELECT cat.Category_Name, SUM(od.Amount) AS Total_Sales FROM Order_Details od JOIN ...`
   
8. **Customer's Most Purchased Category** 
   - Overview: Identifying the top-purchased category for each customer.
   - SQL Insight: [Complex SQL query using CTE `CustomerCategoryPurchase` and the main ranking.]

By diving deep into these metrics, we aim to decode sales performance, understand customer behaviors, and highlight product/category strengths. These insights are invaluable for guiding business strategies, optimizing sales efforts, and crafting effective marketing campaigns.

---

**Note**: The SQL Insights provided are concise representations. For the detailed queries, please navigate to the respective SQL scripts in the `/scripts/` directory.

