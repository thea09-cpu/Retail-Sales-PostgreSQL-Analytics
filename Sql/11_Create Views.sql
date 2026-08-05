-- A reusable detailed sales view.
CREATE OR REPLACE VIEW analytics.sales_detail AS
SELECT
    ol.source_row_id,
    o.order_id,
    o.order_date,
    o.ship_date,
    o.ship_mode,
    o.delivery_days,

    c.customer_id,
    c.customer_name,
    c.segment,

    p.product_id,
    p.product_name,
    p.category,
    p.sub_category,

    l.country,
    l.city,
    l.state,
    l.postal_code,
    l.region,

    ol.sales,
    ol.quantity,
    ol.discount,
    ol.profit
FROM core.order_lines AS ol
JOIN core.orders AS o
    ON ol.order_id = o.order_id
JOIN core.customers AS c
    ON o.customer_id = c.customer_id
JOIN core.products AS p
    ON ol.product_id = p.product_id
JOIN core.locations AS l
    ON o.location_id = l.location_id;


-- A reusable monthly performance view.
CREATE OR REPLACE VIEW analytics.monthly_performance AS
SELECT
    DATE_TRUNC('month', order_date)::DATE AS month_start,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM analytics.sales_detail
GROUP BY DATE_TRUNC('month', order_date)::DATE;