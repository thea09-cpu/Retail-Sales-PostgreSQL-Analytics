SELECT *
FROM staging.raw_superstore
ORDER BY row_id::INTEGER
LIMIT 10;