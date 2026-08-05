SELECT *
FROM analytics.customer_performance
ORDER BY total_sales DESC
LIMIT 20;

SELECT *
FROM analytics.subcategory_performance
ORDER BY total_profit DESC;

SELECT *
FROM analytics.regional_performance
ORDER BY total_profit DESC;

SELECT *
FROM analytics.loss_making_products
ORDER BY total_profit
LIMIT 10;