# Digital Marketing Campaign & Customer Acquisition Analytics

An end-to-end marketing analytics project analyzing **customer acquisition, e-commerce funnel performance, customer behavior, revenue, and simulated advertising campaign performance** using BigQuery, SQL, Excel, Power BI, and DAX.

##  Project Overview

This project simulates a Digital Marketing / Marketing Analyst workflow for a D2C/e-commerce business.

The analysis follows the journey:

**Digital Marketing → Acquisition → Website Engagement → Funnel → Conversion → Customers → Revenue → Campaign Performance**

The project combines:

* **Public GA4 e-commerce sample data** for observed user behavior and revenue
* **Simulated advertising campaign data** for campaign-level spend, conversions, and revenue analysis

Observed and simulated revenue were kept separate to avoid unsupported campaign attribution.

##  Tools & Technologies

* **Google BigQuery**
* **SQL**
* **Microsoft Excel**
* **Power BI**
* **DAX**

##  Analysis Areas

### Customer Acquisition

* Acquisition source and medium performance
* Users and purchasers
* Revenue contribution
* Revenue per user
* Average order value

### Marketing Funnel

* Product Views
* Add to Cart
* Checkout
* Purchase
* Stage-level conversion rates

### Customer Analysis

* One-time customers
* Repeat customers
* Purchase frequency
* Revenue by customer type

### Campaign Analysis

* Impressions
* Clicks
* CTR
* CPC
* Conversion Rate
* CAC
* ROAS

## Power BI Dashboard

The Power BI dashboard contains four pages:

1. **Executive Overview**
2. **Campaign Performance**
3. **Marketing Funnel**
4. **Customer & Acquisition**

## Key Findings

* Observed dataset contained **269,989 unique users** and **5,692 purchase events**.
* Product View → Add to Cart conversion was **15.16%**.
* Checkout → Purchase conversion was **14.69%**.
* Repeat customers represented approximately **17.54% of purchasing customers**.
* Repeat customers generated approximately **35.35% of purchaser revenue**.
* Simulated campaign ROAS ranged from **0.71 to 2.47**.

##  Business Recommendations

The analysis identified potential areas for:

* Improving checkout conversion
* Increasing product-page engagement
* Investigating high-value acquisition sources
* Strengthening repeat-customer strategies
* Evaluating advertising efficiency using CAC and ROAS
* Monitoring changes in monthly performance

##  Data & Methodology Note

The GA4 data represents a **public sample dataset** and should not be interpreted as the complete production data of a real company.

Advertising campaign spend, conversions, and campaign revenue are **simulated for portfolio-analysis purposes**.

Observed GA4 revenue and simulated advertising revenue were intentionally kept separate because the public GA4 sample does not provide sufficient campaign-level attribution to reliably connect all simulated campaigns to observed purchases.

##  Project Structure

```
01_BigQuery_SQL/
02_Excel_Analysis/
03_PowerBI_Dashboard/
04_Documentation/
README.md
```

##  Skills Demonstrated

**SQL • BigQuery • Excel • Power BI • DAX • Data Analysis • Marketing Analytics • Customer Acquisition • Funnel Analysis • Customer Analytics • KPI Development • Data Visualization • Business Insights**

