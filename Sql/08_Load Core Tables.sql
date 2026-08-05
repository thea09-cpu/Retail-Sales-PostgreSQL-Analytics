BEGIN;

-- 1. Load unique customers.
INSERT INTO core.customers (
    customer_id,
    customer_name,
    segment
)
SELECT DISTINCT ON (customer_id)
    TRIM(customer_id),
    TRIM(customer_name),
    TRIM(segment)
FROM staging.raw_superstore
ORDER BY customer_id
ON CONFLICT (customer_id) DO NOTHING;


-- 2. Load unique products.
INSERT INTO core.products (
    product_id,
    product_name,
    category,
    sub_category
)
SELECT DISTINCT ON (product_id)
    TRIM(product_id),
    TRIM(product_name),
    TRIM(category),
    TRIM(sub_category)
FROM staging.raw_superstore
ORDER BY product_id
ON CONFLICT (product_id) DO NOTHING;


-- 3. Load unique locations.
INSERT INTO core.locations (
    country,
    city,
    state,
    postal_code,
    region
)
SELECT DISTINCT
    TRIM(country),
    TRIM(city),
    TRIM(state),
    TRIM(postal_code),
    TRIM(region)
FROM staging.raw_superstore
ON CONFLICT ON CONSTRAINT uq_location DO NOTHING;


-- 4. Load one record per order.
INSERT INTO core.orders (
    order_id,
    customer_id,
    location_id,
    order_date,
    ship_date,
    ship_mode
)
SELECT DISTINCT ON (r.order_id)
    TRIM(r.order_id),
    TRIM(r.customer_id),
    l.location_id,
    TO_DATE(r.order_date, 'DD/MM/YYYY'),
    TO_DATE(r.ship_date, 'DD/MM/YYYY'),
    TRIM(r.ship_mode)
FROM staging.raw_superstore AS r
JOIN core.locations AS l
    ON TRIM(r.country) = l.country
   AND TRIM(r.city) = l.city
   AND TRIM(r.state) = l.state
   AND TRIM(r.postal_code) = l.postal_code
   AND TRIM(r.region) = l.region
ORDER BY r.order_id
ON CONFLICT (order_id) DO NOTHING;


-- 5. Load every product line within each order.
INSERT INTO core.order_lines (
    source_row_id,
    order_id,
    product_id,
    sales,
    quantity,
    discount,
    profit
)
SELECT
    r.row_id::INTEGER,
    TRIM(r.order_id),
    TRIM(r.product_id),
    r.sales::NUMERIC(12, 4),
    r.quantity::INTEGER,
    r.discount::NUMERIC(4, 2),
    r.profit::NUMERIC(12, 4)
FROM staging.raw_superstore AS r
ON CONFLICT (source_row_id) DO NOTHING;

COMMIT;