
# 📊 Pizza Sales Dashboard Analysis

## Project Overview
This report focuses on the key insights derived from the interactive Power BI dashboards, built using the cleaned and analyzed pizza sales data. The dashboards provide a visual summary of performance, trends, and product insights, complementing the underlying SQL analysis.

## Tools Used
- **Data Visualization:** Microsoft Power BI

## Dashboard Visualizations

### 1. Home Dashboard

This dashboard provides an overall view of key performance indicators (KPIs) and general sales trends. It summarizes total revenue, average order value, total pizzas sold, total orders, and average pizzas per order. It also includes daily and monthly order trends, as well as sales distribution by pizza category and size.

![Home Dashboard](pizza_sales_analysis/Home.png)

#### Key Insights from Home Dashboard:

* **Overall Sales Performance (KPIs):**
    * **Total Revenue:** `$817.86K`
    * **Average Order Value:** `$38.31`
    * **Total Pizza Sold:** `49,574`
    * **Total Orders:** `21,350`
    * **Average Pizzas Per Order:** `2.32` (This indicates that on average, customers order about 2 to 3 pizzas per transaction.)

* **Daily Trends:**
    * **Busiest Days:** Orders are notably highest on **Fridays and Saturdays**, suggesting weekends are peak periods. Thursdays also show strong performance.
    * **Quietest Day:** Sundays appear to be slightly less busy compared to weekdays.

* **Monthly Trends:**
    * **Peak Months:** The dashboard shows a significant peak in orders during **July and August**, followed by another strong period in **January**.
    * **Lower Months:** October and November show a dip in orders, which could be seasonal or due to other factors.

* **Sales Distribution by Category:**
    * The **Classic** pizza category is the dominant performer, contributing the largest percentage of sales and total orders.
    * **Supreme** and **Veggie** categories also hold substantial shares.
    * **Chicken** is the lowest-contributing category.

* **Sales Distribution by Size:**
    * **Large** pizzas account for the highest percentage of total sales, indicating a strong preference for larger sizes or family orders.
    * **Medium** and **Regular** sizes follow, while **XXL** and **X-Large** make up a smaller portion.

### 2. Best/Worst Sellers Dashboard

This dashboard dives deeper into individual pizza performance, identifying the top and bottom performers based on revenue, quantity sold, and the number of orders.

![Best/Worst Sellers Dashboard](pizza_sales_analysis/Best_Worst_Seller)

#### Key Insights from Best/Worst Sellers Dashboard:

* **Best Sellers by Revenue:**
    * **The Thai Chicken Pizza** leads significantly in total revenue.
    * Other strong performers include The Barbecue Chicken Pizza and The California Chicken Pizza.

* **Best Sellers by Quantity Sold:**
    * **The Classic Deluxe Pizza** is the most frequently purchased pizza by quantity.
    * The Barbecue Chicken Pizza and The Hawaiian Pizza also sell in high volumes.

* **Best Sellers by Total Orders:**
    * **The Classic Deluxe Pizza** is ordered the most frequently.
    * This aligns with its high quantity sold, suggesting it's a popular choice for individual orders as well.

* **Worst Sellers by Revenue:**
    * **The Brie Carre Pizza** consistently ranks as the lowest performer across all metrics.
    * Other low-revenue pizzas include The Spinach Pesto & Ricotta and The Mediterranean.

* **Worst Sellers by Quantity Sold:**
    * Again, **The Brie Carre Pizza** sells the least in terms of quantity.

* **Worst Sellers by Total Orders:**
    * **The Brie Carre Pizza** also receives the fewest orders.

## Consolidated Key Findings and Recommendations

* **Peak Demand Management:** High order volumes on Fridays, Saturdays, and during July/August and January indicate a need for increased staffing, optimized inventory, and targeted promotions during these times.
* **Menu Optimization:**
    * **Promote Bestsellers:** Focus marketing efforts on "The Classic Deluxe Pizza" and "The Thai Chicken Pizza" as they are key drivers of quantity and revenue, respectively. Consider featuring them prominently.
    * **Re-evaluate Underperformers:** The "Brie Carre Pizza" is consistently the worst seller. Consider removing it from the menu, revamping its recipe, or offering it as a limited-time special to test new interest.
* **Pricing Strategy:** The dominance of "Large" pizzas suggests customers are willing to spend more for larger sizes. Consider bundles or family deals around these sizes.
* **Category Focus:** Continue to emphasize the "Classic" pizza category and explore expanding offerings within this successful category. Address the lower performance of the "Chicken" category, perhaps through new recipes or targeted promotions.
* **Customer Experience:** Given an average of 2.32 pizzas per order, explore bundling options or suggestive selling at checkout to gently encourage slightly higher order values (e.g., adding a side or drink).

## Future Enhancements

* **Interactive Dashboards:** Publish these dashboards online (e.g., Power BI Service) for interactive exploration by stakeholders.
* **Profitability Analysis:** Integrate cost data to calculate gross profit margins for individual pizzas and categories.
* **Customer Segmentation:** If customer IDs are available, segment customers based on purchasing behavior for personalized marketing.
* **Geospatial Analysis:** If location data is available, analyze sales by region or delivery zone.
