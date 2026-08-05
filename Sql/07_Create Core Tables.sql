CREATE TABLE IF NOT EXISTS core.customers (
    customer_id TEXT PRIMARY KEY,
    customer_name TEXT NOT NULL,
    segment TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS core.products (
    product_id TEXT PRIMARY KEY,
    product_name TEXT NOT NULL,
    category TEXT NOT NULL,
    sub_category TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS core.locations (
    location_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    country TEXT NOT NULL,
    city TEXT NOT NULL,
    state TEXT NOT NULL,
    postal_code TEXT NOT NULL,
    region TEXT NOT NULL,

    CONSTRAINT uq_location
        UNIQUE (country, city, state, postal_code, region)
);

CREATE TABLE IF NOT EXISTS core.orders (
    order_id TEXT PRIMARY KEY,
    customer_id TEXT NOT NULL,
    location_id BIGINT NOT NULL,
    order_date DATE NOT NULL,
    ship_date DATE NOT NULL,
    ship_mode TEXT NOT NULL,
    delivery_days INTEGER
        GENERATED ALWAYS AS (ship_date - order_date) STORED,
		
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES core.customers (customer_id),

    CONSTRAINT fk_orders_location
        FOREIGN KEY (location_id)
        REFERENCES core.locations (location_id),

    CONSTRAINT chk_ship_date
        CHECK (ship_date >= order_date)
);

CREATE TABLE IF NOT EXISTS core.order_lines (
    order_line_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    source_row_id INTEGER NOT NULL UNIQUE,
    order_id TEXT NOT NULL,
    product_id TEXT NOT NULL,
    sales NUMERIC(12, 4) NOT NULL,
    quantity INTEGER NOT NULL,
    discount NUMERIC(4, 2) NOT NULL,
    profit NUMERIC(12, 4) NOT NULL,

    CONSTRAINT fk_order_lines_order
        FOREIGN KEY (order_id)
        REFERENCES core.orders (order_id),

    CONSTRAINT fk_order_lines_product
        FOREIGN KEY (product_id)
        REFERENCES core.products (product_id),

    CONSTRAINT chk_sales_nonnegative
        CHECK (sales >= 0),

    CONSTRAINT chk_quantity_positive
        CHECK (quantity > 0),

    CONSTRAINT chk_discount_range
        CHECK (discount BETWEEN 0 AND 1)
);