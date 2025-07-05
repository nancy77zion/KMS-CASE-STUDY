# KMS-CASE-STUDY
Sales and Order data analysis for Kultra Mega Stores

## ✅ 1. Project Overview

This analysis focuses on the **KMS sales dataset**, imported from Excel and cleaned for use in **Microsoft SQL Server**.  
Key insights were extracted using custom **SQL queries** to help KMS understand its customer segments, shipping costs, and sales performance.

---

## ✅ 2. Tables & New Columns

- **Main Table:** `KMS_Tables`
- **New Column Added:** `Order_Status`  
  - Used to flag returned items and track order delivery status

---

## ✅ 3. Key Questions Answered

1. **Who are the most and least valuable customers?**  
   - Top customers by total sales were identified.

2. **What do the top and bottom customers buy?**  
   - Top customers primarily purchase high-value office supplies and furniture.  
   - Products with repeat purchases were identified for upselling.
   - Bottom customers were analyzed for products purchased, order frequency, and shipping preferences.
   - Top customers were analyzed for products purchased, order frequency, and shipping preferences.

3. **Which product category had the highest sales?**  
   - Simple `GROUP BY` queries confirmed the top categories for targeted marketing.

4. **Which shipping methods cost the most?**  
   - Estimated shipping costs were analyzed using `Sales - Profit`.  
   - Finding: *Regular Air* is the fastest and most expensive

5. **Does our shipping spend align with Order Priority?**  
   - A shipping report showed whether urgent orders used faster shipping.  
   - **Finding:** Some *Low Priority* orders were still shipped via *Express Air*, suggesting overspending on non-urgent deliveries.

6. **Customer Returns & Segments**  
   - A query identified which customers returned items and what segments they belong to.  
   - Helps pinpoint quality or satisfaction issues by segment.


## ✅ 4. Advice & Recommendations

### 🔍 Bottom Customers
- Engage the bottom 10 customers with **personalized offers**, loyalty programs, or bundles to increase their spend.
- Analyze feedback to understand why they spend less.

### 🚚 Shipping Costs
- Enforce clear shipping rules:  
  - Use **Express Air** only for **High** and **Critical** priority orders.  
  - Use **Delivery Truck** for **Low** and **Medium** priority orders.

### 🔄 Returns Management
- Monitor frequent returners to address product or service issues.
- Use return trends by segment to improve product quality or customer experience

**Prepared By:** *[EBERECHI NWANKUDU]*  
**Date:** *July 05, 2025*  
**Tool:** *Microsoft SQL Server*
