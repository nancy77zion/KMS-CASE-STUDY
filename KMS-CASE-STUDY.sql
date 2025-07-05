select * from KMS_Tables

-- Which product category had the highest sales?

SELECT TOP 1 
    Product_Category, 
    SUM(Sales) AS Product_Category_Total_Sales
FROM 
    KMS_Tables
GROUP BY 
    Product_Category
ORDER BY 
    Product_Category_Total_Sales DESC;

---What are the Top 3 and Bottom 3 regions in terms of sales?

SELECT TOP 3 
    Region, 
    SUM(Sales) AS Region_Total_Sales 
FROM 
    KMS_Tables
GROUP BY 
    Region
ORDER BY 
    Region_Total_Sales  DESC --- region top three

SELECT TOP 3 
    Region, 
    SUM(Sales) AS Region_Total_Sales 
FROM 
    KMS_Tables
GROUP BY 
    Region
ORDER BY 
    Region_Total_Sales  asc	--- region bottom three


-- Combined Top 3 and Bottom 3 Regions by Sales
-- Wrapped each SELECT TOP 3 in a subquery to use ORDER BY

-- Top 3 Regions
SELECT * FROM (
    SELECT TOP 3
        Region,
        SUM(Sales) AS Region_Total_Sales,
        'Top 3' AS Category
    FROM 
        KMS_Tables
    GROUP BY 
        Region
    ORDER BY 
        SUM(Sales) DESC
) AS TopRegions

UNION ALL

-- Bottom 3 Regions
SELECT * FROM (
    SELECT TOP 3
        Region,
        SUM(Sales) AS Region_Total_Sales,
        'Bottom 3' AS Category
    FROM 
        KMS_Tables
    GROUP BY 
        Region
    ORDER BY 
        SUM(Sales) ASC
) AS BottomRegions;

---Total sales of appliances in Ontario?


SELECT 
    SUM(Sales) AS Total_Sales
FROM 
    KMS_Tables
WHERE 
    Product_SubCategory = 'Appliances'
    AND Province = 'Ontario';

------Higest shipping cost?
SELECT TOP 1
    Ship_Mode,
    SUM(Sales - Profit) AS Estimated_Shipping_Cost
FROM 
    KMS_Tables
GROUP BY 
    Ship_Mode
ORDER BY 
    Estimated_Shipping_Cost DESC;

---Identify Bottom 10 Customers by Total Sales
SELECT TOP 10
    [Customer_Name],
    SUM(Sales) AS Total_Sales
FROM 
    KMS_Tables
GROUP BY 
    [Customer_Name]
ORDER BY 
    Total_Sales ASC;

-- Bottom 10 Customers
SELECT TOP 10
    Customer_Name,
    SUM(Sales) AS Total_Sales
INTO Bottom10Customers 
FROM 
    KMS_Tables
GROUP BY 
    Customer_Name
ORDER BY 
    Total_Sales ASC;

select * from Bottom10Customers

select * from Top10Customers

DROP TABLE Bottom10Customers 

DROP TABLE Top10Customers 

-- Products purchased by the bottom 10 customers
SELECT 
    b.Customer_Name,
    k.Product_Name,
    k.Product_SubCategory,
    k.Product_Category,
    SUM(k.Sales) AS Product_Sales
FROM 
    Bottom10Customers b
JOIN 
    KMS_Tables k ON b.Customer_Name = k.Customer_Name
GROUP BY 
    b.Customer_Name, k.Product_Name, k.Product_SubCategory, k.Product_Category
ORDER BY 
    b.Customer_Name, Product_Sales DESC;
	 
-- TOP 10 Customers
SELECT TOP 10
    Customer_Name,
    SUM(Sales) AS Total_Sales
INTO Top10Customers 
FROM 
    KMS_Tables
GROUP BY 
    Customer_Name
ORDER BY 
    Total_Sales DESC;

-- Products purchased by the top 10 customers
SELECT 
    b.Customer_Name,
    k.Product_Name,
    k.Product_SubCategory,
    k.Product_Category,
    SUM(k.Sales) AS Product_Sales
FROM 
    Top10Customers b
JOIN 
    KMS_Tables k ON b.Customer_Name = k.Customer_Name
GROUP BY 
    b.Customer_Name, k.Product_Name, k.Product_SubCategory, k.Product_Category
ORDER BY 
    b.Customer_Name, Product_Sales desc;

-- Order frequency from top customer
SELECT 
    b.Customer_Name,
    COUNT(DISTINCT k.Order_ID) AS Number_of_Orders,
    MIN(k.Order_Date) AS First_Order_Date,
    MAX(k.Order_Date) AS Last_Order_Date
FROM 
    Top10Customers b
JOIN 
    KMS_Tables k ON b.Customer_Name = k.Customer_Name
GROUP BY 
    b.Customer_Name;


-- Shipping mode preferences
SELECT 
    b.Customer_Name,
    k.Ship_Mode,
    COUNT(*) AS Times_Used
FROM 
    Top10Customers b
JOIN 
    KMS_Tables k ON b.Customer_Name = k.Customer_Name
GROUP BY 
    b.Customer_Name, k.Ship_Mode
ORDER BY 
    b.Customer_Name, Times_Used DESC;



--Most valueble customer

SELECT TOP 10
    Customer_Name,
    SUM(Sales) AS Total_Sales
FROM 
    KMS_Tables
GROUP BY 
    Customer_Name
ORDER BY 
    Total_Sales DESC;

-- Products purchased by Top 10 Customers
WITH Top10Customers AS (
    SELECT TOP 10
        Customer_Name
    FROM 
        KMS_Tables
    GROUP BY 
        Customer_Name
    ORDER BY 
        SUM(Sales) DESC
)

SELECT 
    t.Customer_Name,
    k.Product_Name,
    k.Product_SubCategory,
    k.Product_Category,
    SUM(k.Sales) AS Product_Sales
FROM 
    Top10Customers t
JOIN 
    KMS_Tables k ON t.Customer_Name = k.Customer_Name
GROUP BY 
    t.Customer_Name, k.Product_Name, k.Product_SubCategory, k.Product_Category
ORDER BY 
    t.Customer_Name, Product_Sales DESC;

--small business customer with highest sales

SELECT TOP 1
    Customer_Name,
    SUM(Sales) AS Total_Sales
FROM 
    KMS_Tables
WHERE 
    Customer_Segment = 'Small Business'
GROUP BY 
    Customer_Name
ORDER BY 
    Total_Sales DESC;

-- Corporate customer with most order

SELECT TOP 1
    Customer_Name,
    COUNT(DISTINCT Order_ID) AS Number_of_Orders
FROM 
    KMS_Tables
WHERE 
    Customer_Segment = 'Corporate'
    AND YEAR(Order_Date) BETWEEN 2009 AND 2012
GROUP BY 
    Customer_Name
ORDER BY 
    Number_of_Orders DESC;

---Most profitable  Consumer customer

SELECT
    Customer_Name,
    SUM(profit) AS total_customer_profit
FROM
    KMS_Tables
WHERE
    Customer_Segment = 'Consumer'
GROUP BY
    Customer_Name
ORDER BY
    total_customer_profit DESC


select * from KMS_Tables

---check shipping methods by order priority
SELECT 
    Order_Priority,
    Ship_Mode,
    COUNT(*) AS Num_Orders,
    SUM(Sales - Profit) AS Estimated_Shipping_Cost
FROM 
    KMS_Tables
GROUP BY 
    Order_Priority, Ship_Mode
ORDER BY 
    Order_Priority, Ship_Mode;

--- Which customer returned items, and what segment do they belong to?
--added a new column called Order_Status

ALTER TABLE KMS_Tables
ADD Order_Status nVARCHAR(50);


select * from KMS_Tables


UPDATE KMS_Tables
SET Order_Status = 
    CASE 
        WHEN Order_Priority = 'High' THEN 'Delivered'
        WHEN Order_Priority = 'Critical' THEN 'Delivered'
		WHEN Order_Priority = 'Medium' THEN 'Delivered'
		WHEN Order_Priority = 'Low' THEN 'Pending'
        ELSE 'Returned'
    END;

-- customers returned items by segment
SELECT 
    Customer_Name,
    Customer_Segment,
    COUNT(DISTINCT Order_ID) AS Number_of_Returned_Orders
FROM 
    KMS_Tables
WHERE 
    Order_Status = 'Returned'
GROUP BY 
    Customer_Name, Customer_Segment
ORDER BY 
    Number_of_Returned_Orders DESC;


