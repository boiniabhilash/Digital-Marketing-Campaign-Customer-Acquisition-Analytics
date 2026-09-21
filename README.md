# Digital Marketing Campaign & Customer Acquisition Analytics

An end-to-end digital marketing and customer acquisition analytics project for a D2C/e-commerce business using **BigQuery, SQL, Excel, Power BI, and DAX**.

##  Project Overview

This project analyzes the complete digital marketing and customer journey from:

**Acquisition → Website Engagement → Marketing Funnel → Conversion → Customers → Revenue → Campaign Performance**

The project combines **public GA4 e-commerce sample data** with a **separately simulated advertising campaign dataset** to demonstrate an end-to-end marketing analytics workflow.

A key methodological principle was to keep **observed GA4 performance** and **simulated advertising performance** separate to avoid unsupported campaign-level attribution.

---

##  Business Problem

The business invests in multiple digital marketing channels but lacks a clear view of:

* Which acquisition sources generate traffic and revenue
* Where customers drop off in the purchase funnel
* How one-time and repeat customers contribute to revenue
* How advertising campaigns perform across key efficiency metrics
* Which areas require further investigation or optimization

---

##  Tools & Technologies

| Tool                        | Purpose                                                      |
| --------------------------- | ------------------------------------------------------------ |
| **BigQuery**                | Data extraction, transformation and analytical datasets      |
| **SQL**                     | Data cleaning, aggregation, KPI calculations and validation  |
| **Excel**                   | KPI validation, pivot analysis, funnel and customer analysis |
| **Power BI**                | Interactive dashboard and business visualization             |
| **DAX**                     | Measures, KPIs and analytical calculations                   |
| **GA4 Sample Data**         | Observed e-commerce behavior                                 |
| **Simulated Campaign Data** | Advertising performance analysis                             |

---

##  Dashboard

### Executive Overview

![Executive Overview](Dashboard Screenshots/executive overview.png)

### Campaign Performance

![Campaign Performance](Dashboard Screenshots/campaign performance.png)

### Marketing Funnel

![Marketing Funnel](Dashboard Screenshots/marketing funnel.png)

### Customer & Acquisition

![Customer & Acquisition](Dashboard Screenshots/customer acquisition.png)

---

##  Analysis Areas

### 1. Customer Acquisition

Analyzed acquisition sources and mediums to understand:

* User volume
* Purchaser volume
* Revenue contribution
* Conversion performance
* Revenue per user
* Average order value

### 2. Marketing Funnel

Analyzed the customer journey across:

**Product View → Add to Cart → Checkout → Purchase**

Key funnel metrics include:

* View-to-Cart Rate
* Cart-to-Checkout Rate
* Checkout-to-Purchase Rate
* Overall user conversion

### 3. Customer Analysis

Analyzed:

* Purchasing customers
* One-time customers
* Repeat customers
* Repeat customer rate
* Purchase frequency
* Revenue contribution by customer type

### 4. Campaign Performance

Evaluated simulated advertising campaigns using:

* Impressions
* Clicks
* CTR
* CPC
* Conversion Rate
* CAC
* Revenue
* ROAS

---

##  Key Findings

### Observed GA4 Performance

* **269,989** unique users
* **5,692** purchase events
* **$362,165** observed revenue
* Approximately **2.11%** unique-user purchase conversion
* **386,068** product views
* **58,543** add-to-carts
* **38,757** checkouts

### Funnel Performance

* View → Cart: **15.16%**
* Cart → Checkout: **66.20%**
* Checkout → Purchase: **14.69%**

### Customer Behavior

* **4,419** purchasing customers
* **775** repeat customers
* Repeat customers represented approximately **17.54%** of purchasing customers
* Repeat customers contributed approximately **35.35%** of purchaser revenue

### Acquisition

`google / organic` generated the largest observed revenue contribution at approximately **$95,775**.

`shop.googlemerchandisestore.com / referral` generated approximately **$46,521** in observed revenue and showed relatively high revenue per source-level user.

### Simulated Advertising

Simulated campaign ROAS ranged from approximately **0.71 to 2.47**.

The Brand Search campaign recorded:

* Spend: **$274,757.51**
* Conversions: **9,991**
* CAC: **$27.50**
* Revenue: **$679,412.48**
* ROAS: **2.47**

The Prospecting campaign recorded:

* Spend: **$52,068.01**
* Conversions: **596**
* CAC: **$87.36**
* Revenue: **$36,894.99**
* ROAS: **0.71**

---

##  Business Recommendations

Based on the analysis:

1. Investigate checkout-stage abandonment and identify potential friction points.
2. Investigate opportunities to improve product-page-to-cart conversion.
3. Examine high-value acquisition sources for transferable characteristics.
4. Develop strategies to increase repeat purchases and customer lifetime value.
5. Monitor campaign performance using CTR, CPC, CVR, CAC and ROAS together rather than relying on a single metric.
6. Investigate changes in monthly revenue and funnel performance.
7. Maintain an ongoing marketing performance dashboard for regular monitoring.

---

##  Methodology Note

The project uses two distinct data sources:

**Observed Data**

Public GA4 e-commerce sample data covering:

**November 1, 2020 – January 31, 2021**

**Simulated Data**

A separately created advertising campaign dataset covering the same analysis period.

The simulated advertising dataset was created for portfolio demonstration purposes.

**Observed GA4 revenue and simulated campaign revenue were not combined.**

Campaign-level attribution to the public GA4 dataset was not assumed where the available data did not support it.

---

##  Project Structure

```text
digital-marketing-campaign-customer-acquisition-analytics/
│
├── 01_BigQuery_SQL/
│   └── marketing_analytics.sql
│
├── 02_Excel_Analysis/
│   └── Digital_Marketing_Analysis.xlsx
│
├── 03_PowerBI_Dashboard/
│   └── PowerBI_Dashboard.pbix
│
├── 04_Documentation/
│   └── Digital_Marketing_Project_Documentation.pdf
│
├── 05_Dashboard_Screenshots/
│   ├── executive-overview.png
│   ├── campaign-performance.png
│   ├── marketing-funnel.png
│   └── customer-acquisition.png
│
└── README.md
```

---

##  Project Workflow

```text
Raw Data
   ↓
BigQuery / SQL
   ↓
Data Transformation
   ↓
Data Validation
   ↓
Excel Analysis
   ↓
Power BI Data Model
   ↓
DAX Measures
   ↓
Interactive Dashboard
   ↓
Business Insights
   ↓
Recommendations
```

---

##  Skills Demonstrated

**Data Analysis**

* Exploratory Data Analysis
* KPI Development
* Funnel Analysis
* Customer Analysis
* Acquisition Analysis
* Campaign Performance Analysis

**Technical Skills**

* SQL
* BigQuery
* Excel
* Power BI
* DAX
* Data Modeling
* Data Validation

**Business Skills**

* Marketing Analytics
* Customer Acquisition
* Conversion Analysis
* Revenue Analysis
* Marketing Efficiency
* Business Recommendations

---

##  Deliverables

* BigQuery SQL analysis
* Excel analytical workbook
* Power BI dashboard
* Project documentation
* Dashboard screenshots
* Business insights and recommendations
