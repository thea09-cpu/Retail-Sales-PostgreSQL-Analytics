-- Customer performance view.
CREATE OR REPLACE VIEW analytics.customer_performance AS
SELECT
    customer_id,
    customer_name,
    segment,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM analytics.sales_detail
GROUP BY
    customer_id,
    customer_name,
    segment;


-- Sub-category performance view.
CREATE OR REPLACE VIEW analytics.subcategory_performance AS
SELECT
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM analytics.sales_detail
GROUP BY
    category,
    sub_category;


-- Regional performance view.
CREATE OR REPLACE VIEW analytics.regional_performance AS
SELECT
    region,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM analytics.sales_detail
GROUP BY region;


-- Loss-making products view.
CREATE OR REPLACE VIEW analytics.loss_making_products AS
SELECT
    product_id,
    product_name,
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM analytics.sales_detail
GROUP BY
    product_id,
    product_name,
    category,
    sub_category
HAVING SUM(profit) < 0;