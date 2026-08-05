-- Speeds up joins between order lines and orders.
CREATE INDEX IF NOT EXISTS idx_order_lines_order_id
ON core.order_lines (order_id);

-- Speeds up joins between order lines and products.
CREATE INDEX IF NOT EXISTS idx_order_lines_product_id
ON core.order_lines (product_id);

-- Speeds up customer-based analysis.
CREATE INDEX IF NOT EXISTS idx_orders_customer_id
ON core.orders (customer_id);

-- Speeds up region/location analysis.
CREATE INDEX IF NOT EXISTS idx_orders_location_id
ON core.orders (location_id);

-- Speeds up date-range and trend analysis.
CREATE INDEX IF NOT EXISTS idx_orders_order_date
ON core.orders (order_date);