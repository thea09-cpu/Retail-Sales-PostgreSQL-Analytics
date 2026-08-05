SELECT 'customers' AS table_name, COUNT(*) AS row_count
FROM core.customers

UNION ALL

SELECT 'products', COUNT(*)
FROM core.products

UNION ALL

SELECT 'locations', COUNT(*)
FROM core.locations

UNION ALL

SELECT 'orders', COUNT(*)
FROM core.orders

UNION ALL

SELECT 'order_lines', COUNT(*)
FROM core.order_lines;