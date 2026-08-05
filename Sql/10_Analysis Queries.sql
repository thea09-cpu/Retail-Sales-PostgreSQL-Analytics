-- 1. Overall business performance.
SELECT
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(*) AS sales_lines,
    COUNT(DISTINCT order_id) AS total_orders
FROM core.order_lines;


-- 2. Sales and profit by product category.
SELECT
    p.category,
    ROUND(SUM(ol.sales), 2) AS total_sales,
    ROUND(SUM(ol.profit), 2) AS total_profit
FROM core.order_lines AS ol
JOIN core.products AS p
    ON ol.product_id = p.product_id
GROUP BY p.category
ORDER BY total_profit DESC;


-- 3. Regional performance.
SELECT
    l.region,
    ROUND(SUM(ol.sales), 2) AS total_sales,
    ROUND(SUM(ol.profit), 2) AS total_profit
FROM core.order_lines AS ol
JOIN core.orders AS o
    ON ol.order_id = o.order_id
JOIN core.locations AS l
    ON o.location_id = l.location_id
GROUP BY l.region
ORDER BY total_profit DESC;


-- 4. Ten products with the greatest total losses.
SELECT
    p.product_name,
    ROUND(SUM(ol.sales), 2) AS total_sales,
    ROUND(SUM(ol.profit), 2) AS total_profit
FROM core.order_lines AS ol
JOIN core.products AS p
    ON ol.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_profit
LIMIT 10;


-- 5. Does discount level appear related to profit?
SELECT
    discount,
    COUNT(*) AS sales_lines,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(profit), 2) AS average_profit
FROM core.order_lines
GROUP BY discount
ORDER BY discount;


-- 6. Average delivery time by shipping mode.
SELECT
    ship_mode,
    ROUND(AVG(delivery_days), 0) AS average_delivery_days,
    COUNT(*) AS total_orders
FROM core.orders
GROUP BY ship_mode
ORDER BY average_delivery_days;


-- 7.Top 20 customers by sales.
SELECT
    c.customer_name,
    c.segment,
    COUNT(DISTINCT o.order_id) AS number_of_orders,
    ROUND(SUM(ol.sales), 2) AS total_sales,
    ROUND(SUM(ol.profit), 2) AS total_profit
FROM core.order_lines AS ol
JOIN core.orders AS o
    ON ol.order_id = o.order_id
JOIN core.customers AS c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_name, c.segment
ORDER BY total_sales DESC
LIMIT 20;

-- 8.Sales and profit by product sub-category.
SELECT
    p.category,
    p.sub_category,
    ROUND(SUM(ol.sales), 2) AS total_sales,
    ROUND(SUM(ol.profit), 2) AS total_profit
FROM core.order_lines AS ol
JOIN core.products AS p
    ON ol.product_id = p.product_id
GROUP BY
    p.category,
    p.sub_category
ORDER BY total_profit DESC;