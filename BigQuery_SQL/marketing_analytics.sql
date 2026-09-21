-- Digital Marketing Campaign & Customer Acquisition Analytics
-- BigQuery SQL Script
-- Analysis period: 2020-11-01 to 2021-01-31
-- Replace YOUR_PROJECT_ID with your Google Cloud project ID before running.
-- Advertising campaign data is simulated and explicitly marked as such.

-- ============================================================
-- 1. RAW GA4 MARKETING DATA
-- ============================================================

CREATE OR REPLACE TABLE `YOUR_PROJECT_ID.marketing_analytics.raw_ga4_marketing_data` AS
SELECT
  event_date,
  event_timestamp,
  user_pseudo_id,
  event_name,
  traffic_source.source AS traffic_source,
  traffic_source.medium AS traffic_medium,
  traffic_source.name AS traffic_campaign,
  ecommerce.transaction_id,
  ecommerce.purchase_revenue,
  ecommerce.total_item_quantity,
  (SELECT value.string_value
   FROM UNNEST(event_params)
   WHERE key = 'page_location') AS page_location,
  (SELECT value.string_value
   FROM UNNEST(event_params)
   WHERE key = 'page_title') AS page_title
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131';


-- ============================================================
-- 2. RAW MARKETING FUNNEL EVENTS
-- ============================================================

CREATE OR REPLACE TABLE `YOUR_PROJECT_ID.marketing_analytics.raw_marketing_funnel_events` AS
SELECT
  event_date,
  event_timestamp,
  user_pseudo_id,
  event_name,
  traffic_source.source AS traffic_source,
  traffic_source.medium AS traffic_medium,
  traffic_source.name AS traffic_campaign,
  ecommerce.transaction_id,
  ecommerce.purchase_revenue
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
  AND event_name IN (
    'session_start',
    'page_view',
    'view_item',
    'add_to_cart',
    'begin_checkout',
    'add_shipping_info',
    'add_payment_info',
    'purchase'
  );


-- ============================================================
-- 3. USER-LEVEL FUNNEL TABLE
-- ============================================================

CREATE OR REPLACE TABLE `YOUR_PROJECT_ID.marketing_analytics.funnel_user_level` AS
SELECT
  user_pseudo_id,

  ANY_VALUE(traffic_source) AS traffic_source,
  ANY_VALUE(traffic_medium) AS traffic_medium,
  ANY_VALUE(traffic_campaign) AS traffic_campaign,

  COUNTIF(event_name = 'session_start') AS sessions,
  COUNTIF(event_name = 'page_view') AS page_views,
  COUNTIF(event_name = 'view_item') AS product_views,
  COUNTIF(event_name = 'add_to_cart') AS add_to_carts,
  COUNTIF(event_name = 'begin_checkout') AS checkouts,
  COUNTIF(event_name = 'add_shipping_info') AS shipping_info,
  COUNTIF(event_name = 'add_payment_info') AS payment_info,
  COUNTIF(event_name = 'purchase') AS purchases,

  COALESCE(
    SUM(
      CASE
        WHEN event_name = 'purchase'
        THEN purchase_revenue
        ELSE 0
      END
    ),
    0
  ) AS revenue

FROM `YOUR_PROJECT_ID.marketing_analytics.raw_marketing_funnel_events`
GROUP BY user_pseudo_id;


-- ============================================================
-- 4. CHANNEL-LEVEL MARKETING ANALYSIS
-- ============================================================

CREATE OR REPLACE TABLE `YOUR_PROJECT_ID.marketing_analytics.marketing_channel_analysis` AS
SELECT
  traffic_source AS source,
  traffic_medium AS medium,

  COUNT(DISTINCT user_pseudo_id) AS users,
  SUM(sessions) AS sessions,
  SUM(product_views) AS product_views,
  SUM(add_to_carts) AS add_to_carts,
  SUM(checkouts) AS checkouts,
  COUNTIF(purchases > 0) AS purchasers,
  SUM(purchases) AS transactions,
  SUM(revenue) AS revenue,

  SAFE_DIVIDE(
    SUM(purchases),
    COUNT(DISTINCT user_pseudo_id)
  ) * 100 AS conversion_rate_pct,

  SAFE_DIVIDE(
    SUM(revenue),
    COUNT(DISTINCT user_pseudo_id)
  ) AS revenue_per_user,

  SAFE_DIVIDE(
    SUM(revenue),
    COUNTIF(purchases > 0)
  ) AS revenue_per_purchaser,

  SAFE_DIVIDE(
    SUM(revenue),
    SUM(purchases)
  ) AS aov,

  SAFE_DIVIDE(
    SUM(add_to_carts),
    SUM(product_views)
  ) * 100 AS view_to_cart_rate_pct,

  SAFE_DIVIDE(
    SUM(checkouts),
    SUM(add_to_carts)
  ) * 100 AS cart_to_checkout_rate_pct,

  SAFE_DIVIDE(
    SUM(purchases),
    SUM(checkouts)
  ) * 100 AS checkout_to_purchase_rate_pct,

  SAFE_DIVIDE(
    COUNTIF(purchases > 1),
    COUNTIF(purchases > 0)
  ) * 100 AS repeat_customer_rate_pct,

  CASE
    WHEN SAFE_DIVIDE(SUM(purchases), COUNT(DISTINCT user_pseudo_id)) >= 0.03
      THEN 'High conversion'
    WHEN SAFE_DIVIDE(SUM(purchases), COUNT(DISTINCT user_pseudo_id)) < 0.01
      THEN 'Low conversion'
    ELSE 'Monitor'
  END AS recommendation_area

FROM `YOUR_PROJECT_ID.marketing_analytics.funnel_user_level`
GROUP BY
  source,
  medium;


-- ============================================================
-- 5. CUSTOMER ANALYSIS
-- ============================================================

CREATE OR REPLACE TABLE `YOUR_PROJECT_ID.marketing_analytics.customer_analysis` AS
SELECT
  CASE
    WHEN purchases = 0 THEN 'Non-Purchaser'
    WHEN purchases = 1 THEN 'One-Time Customer'
    ELSE 'Repeat Customer'
  END AS customer_type,

  COUNT(*) AS users,
  SUM(purchases) AS purchases,
  SUM(revenue) AS revenue,

  SAFE_DIVIDE(
    SUM(revenue),
    COUNT(*)
  ) AS revenue_per_user

FROM `YOUR_PROJECT_ID.marketing_analytics.funnel_user_level`
GROUP BY customer_type;


-- ============================================================
-- 6. PURCHASE FREQUENCY ANALYSIS
-- ============================================================

CREATE OR REPLACE TABLE `YOUR_PROJECT_ID.marketing_analytics.purchase_frequency_analysis` AS
SELECT
  CASE
    WHEN purchases = 0 THEN '0'
    WHEN purchases = 1 THEN '1'
    WHEN purchases = 2 THEN '2'
    WHEN purchases = 3 THEN '3'
    WHEN purchases >= 4 THEN '4+'
  END AS purchase_frequency_group,

  COUNT(*) AS users,
  SUM(revenue) AS revenue,

  SAFE_DIVIDE(
    SUM(revenue),
    COUNT(*)
  ) AS revenue_per_user

FROM `YOUR_PROJECT_ID.marketing_analytics.funnel_user_level`
GROUP BY purchase_frequency_group;


-- ============================================================
-- 7. SIMULATED CAMPAIGN PERFORMANCE
-- ============================================================
-- NOTE:
-- This dataset is simulated for portfolio purposes.
-- It must not be represented as observed advertising data.

CREATE OR REPLACE TABLE `YOUR_PROJECT_ID.marketing_analytics.simulated_campaign_performance` AS
WITH campaign_base AS (

  SELECT
    date,
    channel,
    campaign,
    objective,

    impressions,
    clicks,
    spend,

    'SIMULATED' AS data_status

  FROM UNNEST([
    STRUCT(
      DATE '2020-11-01' AS date,
      'Google Ads' AS channel,
      'Brand Search' AS campaign,
      'Search' AS objective,
      32000 AS impressions,
      2500 AS clicks,
      2750.00 AS spend
    )
    -- Replace this example block with the complete campaign-day
    -- simulation table used in the analysis if rebuilding from scratch.
  ])

)

SELECT *
FROM campaign_base;


-- ============================================================
-- 8. SIMULATED CAMPAIGN OUTCOMES
-- ============================================================
-- If the campaign dataset has already been created, this section
-- adds campaign-level conversion and revenue calculations.

CREATE OR REPLACE TABLE `YOUR_PROJECT_ID.marketing_analytics.simulated_campaign_outcomes` AS
SELECT
  channel,
  campaign,
  objective,

  SUM(impressions) AS impressions,
  SUM(clicks) AS clicks,
  SUM(spend) AS spend,

  SUM(conversions) AS conversions,
  SUM(revenue) AS revenue,

  SAFE_DIVIDE(
    SUM(clicks),
    SUM(impressions)
  ) * 100 AS ctr_pct,

  SAFE_DIVIDE(
    SUM(spend),
    SUM(clicks)
  ) AS cpc,

  SAFE_DIVIDE(
    SUM(conversions),
    SUM(clicks)
  ) * 100 AS conversion_rate_pct,

  SAFE_DIVIDE(
    SUM(spend),
    SUM(conversions)
  ) AS cac,

  SAFE_DIVIDE(
    SUM(revenue),
    SUM(spend)
  ) AS roas

FROM `YOUR_PROJECT_ID.marketing_analytics.simulated_campaign_performance`
GROUP BY
  channel,
  campaign,
  objective;


-- ============================================================
-- 9. CHANNEL MAPPING
-- ============================================================

CREATE OR REPLACE TABLE `YOUR_PROJECT_ID.marketing_analytics.channel_mapping` AS
SELECT
  'Google Ads' AS advertising_channel,
  'google' AS observed_source,
  'cpc' AS observed_medium,
  'SIMULATED_ADVERTISING' AS data_status

UNION ALL

SELECT
  'Meta Ads',
  NULL,
  NULL,
  'SIMULATED_ADVERTISING_ONLY'

UNION ALL

SELECT
  'Display',
  NULL,
  NULL,
  'SIMULATED_ADVERTISING_ONLY';


-- ============================================================
-- 10. INTEGRATED MARKETING PERFORMANCE
-- ============================================================
-- IMPORTANT:
-- Observed GA4 revenue and simulated advertising revenue are
-- intentionally kept separate.

CREATE OR REPLACE TABLE `YOUR_PROJECT_ID.marketing_analytics.integrated_marketing_performance` AS

SELECT
  'Google Ads' AS advertising_channel,
  'SIMULATED + OBSERVED' AS analysis_type,
  SUM(spend) AS simulated_spend,
  SUM(conversions) AS simulated_conversions,
  SUM(revenue) AS simulated_revenue

FROM `YOUR_PROJECT_ID.marketing_analytics.simulated_campaign_performance`

WHERE channel = 'Google Ads'

GROUP BY advertising_channel, analysis_type;


-- ============================================================
-- 11. POWER BI CAMPAIGN PERFORMANCE TABLE
-- ============================================================
-- Flattened campaign-level table intended for Power BI.

CREATE OR REPLACE TABLE `YOUR_PROJECT_ID.marketing_analytics.powerbi_campaign_performance` AS
SELECT
  date,
  channel,
  campaign,
  objective,
  impressions,
  clicks,
  spend,
  conversions,
  revenue,
  data_status
FROM `YOUR_PROJECT_ID.marketing_analytics.simulated_campaign_performance`;


-- ============================================================
-- 12. VALIDATION QUERIES
-- ============================================================

-- User-level control totals
SELECT
  COUNT(*) AS users,
  SUM(sessions) AS sessions,
  SUM(page_views) AS page_views,
  SUM(product_views) AS product_views,
  SUM(add_to_carts) AS add_to_carts,
  SUM(checkouts) AS checkouts,
  SUM(purchases) AS purchases,
  SUM(revenue) AS revenue
FROM `YOUR_PROJECT_ID.marketing_analytics.funnel_user_level`;


-- Channel-level totals
SELECT
  COUNT(*) AS total_channels,
  SUM(users) AS summed_source_users,
  SUM(purchasers) AS total_purchasers,
  SUM(transactions) AS total_transactions,
  SUM(revenue) AS total_revenue
FROM `YOUR_PROJECT_ID.marketing_analytics.marketing_channel_analysis`;


-- Funnel conversion validation
SELECT
  SAFE_DIVIDE(
    SUM(add_to_carts),
    SUM(product_views)
  ) * 100 AS view_to_cart_rate_pct,

  SAFE_DIVIDE(
    SUM(checkouts),
    SUM(add_to_carts)
  ) * 100 AS cart_to_checkout_rate_pct,

  SAFE_DIVIDE(
    SUM(purchases),
    SUM(checkouts)
  ) * 100 AS checkout_to_purchase_rate_pct

FROM `YOUR_PROJECT_ID.marketing_analytics.funnel_user_level`;
"""

path = Path("/mnt/data/marketing_analytics.sql")
path.write_text(sql, encoding="utf-8")

print(f"Created: {path}")
print(f"Lines: {len(sql.splitlines())}")
