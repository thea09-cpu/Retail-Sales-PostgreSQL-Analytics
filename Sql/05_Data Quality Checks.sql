-- 1. Confirm the expected number of imported records.
SELECT COUNT(*) AS total_rows
FROM staging.raw_superstore;


-- 2. Check for missing values in every source column.
SELECT
    COUNT(*) FILTER (WHERE row_id IS NULL OR TRIM(row_id) = '') AS missing_row_id,
    COUNT(*) FILTER (WHERE order_id IS NULL OR TRIM(order_id) = '') AS missing_order_id,
    COUNT(*) FILTER (WHERE order_date IS NULL OR TRIM(order_date) = '') AS missing_order_date,
    COUNT(*) FILTER (WHERE ship_date IS NULL OR TRIM(ship_date) = '') AS missing_ship_date,
    COUNT(*) FILTER (WHERE ship_mode IS NULL OR TRIM(ship_mode) = '') AS missing_ship_mode,
    COUNT(*) FILTER (WHERE customer_id IS NULL OR TRIM(customer_id) = '') AS missing_customer_id,
    COUNT(*) FILTER (WHERE customer_name IS NULL OR TRIM(customer_name) = '') AS missing_customer_name,
    COUNT(*) FILTER (WHERE segment IS NULL OR TRIM(segment) = '') AS missing_segment,
    COUNT(*) FILTER (WHERE country IS NULL OR TRIM(country) = '') AS missing_country,
    COUNT(*) FILTER (WHERE city IS NULL OR TRIM(city) = '') AS missing_city,
    COUNT(*) FILTER (WHERE state IS NULL OR TRIM(state) = '') AS missing_state,
    COUNT(*) FILTER (WHERE postal_code IS NULL OR TRIM(postal_code) = '') AS missing_postal_code,
    COUNT(*) FILTER (WHERE region IS NULL OR TRIM(region) = '') AS missing_region,
    COUNT(*) FILTER (WHERE product_id IS NULL OR TRIM(product_id) = '') AS missing_product_id,
    COUNT(*) FILTER (WHERE category IS NULL OR TRIM(category) = '') AS missing_category,
    COUNT(*) FILTER (WHERE sub_category IS NULL OR TRIM(sub_category) = '') AS missing_sub_category,
    COUNT(*) FILTER (WHERE product_name IS NULL OR TRIM(product_name) = '') AS missing_product_name,
    COUNT(*) FILTER (WHERE sales IS NULL OR TRIM(sales) = '') AS missing_sales,
    COUNT(*) FILTER (WHERE quantity IS NULL OR TRIM(quantity) = '') AS missing_quantity,
    COUNT(*) FILTER (WHERE discount IS NULL OR TRIM(discount) = '') AS missing_discount,
    COUNT(*) FILTER (WHERE profit IS NULL OR TRIM(profit) = '') AS missing_profit
FROM staging.raw_superstore;


-- 3. Check whether Row ID is duplicated.
-- No returned rows means every Row ID is unique.
SELECT
    row_id,
    COUNT(*) AS times_seen
FROM staging.raw_superstore
GROUP BY row_id
HAVING COUNT(*) > 1;

-- 4. Classify sales lines by profit status without changing raw data.
SELECT
    CASE
        WHEN profit::NUMERIC < 0 THEN 'Loss'
        WHEN profit::NUMERIC > 0 THEN 'Profit'
        ELSE 'Break-even'
    END AS profit_status,
    COUNT(*) AS sales_lines
FROM staging.raw_superstore
GROUP BY
    CASE
        WHEN profit::NUMERIC < 0 THEN 'Loss'
        WHEN profit::NUMERIC > 0 THEN 'Profit'
        ELSE 'Break-even'
    END
ORDER BY profit_status;


-- 5. Classify sales lines by discount status without changing raw data.
SELECT
    CASE
        WHEN discount::NUMERIC = 0 THEN 'No discount'
        ELSE 'Discount applied'
    END AS discount_status,
    COUNT(*) AS sales_lines
FROM staging.raw_superstore
GROUP BY
    CASE
        WHEN discount::NUMERIC = 0 THEN 'No discount'
        ELSE 'Discount applied'
    END
ORDER BY discount_status;


-- 6. Confirm dates follow the day/month/year format.
SELECT
    MIN(TO_DATE(order_date, 'DD/MM/YYYY')) AS earliest_order_date,
    MAX(TO_DATE(order_date, 'DD/MM/YYYY')) AS latest_order_date
FROM staging.raw_superstore;