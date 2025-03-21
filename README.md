# Statistical-Analysis-of-Sales

[Project-url](https://swintabel.github.io/Statistical-Analysis-of-Sales/sales.html)

[R Shiny App](http://swintabel.shinyapps.io/Sales)

### Project Summary

This project focuses on analyzing **customer purchasing behavior** using **Association Rule Mining** and RFM (Recency, Frequency, and Monetary) analysis. The goal was to identify high-value and low-value customer segments, uncover frequent itemsets, and gain insights into the most popular products purchased by each segment. The analysis also included visualizations of trends, such as dominant countries for customer segments and the top products bought by high and low-value customers.

## **Key Technologies**

- **R & Shiny** – Interactive web application development
- **Shinydashboard** – UI components for structured layout
- **ggplot2** – Data visualization
- **arulesViz** – Visualization of association rules
- **plotly** – Interactive time series trends
- **visNetwork** – Network representation of frequent itemsets

## **Skills Highlighted**

- **Data Wrangling & Aggregation** (`dplyr`, `tidyverse`)
- **Customer Segmentation & RFM Analysis** (`mutate`, `group_by`, `filter`)
- **Association Rule Mining** (`apriori`, `inspect`, `subset`)
- **Clustering & Product Categorization** (`kmeans`, `ggplot`)
- **Interactive Dashboard Development** (`shiny`, `shinydashboard`)

## **Methodology**

1. **Data Preprocessing & Feature Engineering**
    - Cleaned transaction data (`select`, `mutate`, `filter`)
    - Created RFM segments (`group_by`, `summarise`, `mutate`)
2. **Customer Segmentation & RFM Analysis**
    - Identified high-value and low-value customers (`group_by`, `summarise`)
    - Visualized top countries and products for each segment (`ggplot`)
3. **Time-Series Purchase Trend Analysis**
    - Analyzed monthly purchase trends (`group_by`, `summarise`, `ggplot`, `plotly`)
4. **Cost Group Clustering**
    - Clustered products by price and quantity (`kmeans`, `ggplot`)
    - Visualized clusters (`facet_wrap`, `geom_boxplot`)
5. **Frequent Itemset Mining & Association Rules**
    - Applied **Apriori algorithm** to extract frequent itemsets (`apriori`)
    - Filtered high-lift rules (`subset`, `inspect`)
    - Visualized association rules as a **network graph** (`visNetwork`, `plot`)
