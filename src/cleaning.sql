-- Grabs the first ten lines to see the overall structure.
SELECT * FROM data.raw_dataset LIMIT 10;

-- Showcases the columns.
\d data.raw_dataset

-- Views the number of rows in the dataset.
SELECT COUNT(*) FROM data.raw_dataset;

-- Creates an intermediate "staging table" to clean data.
CREATE TABLE data.staging_table AS SELECT * FROM data.raw_dataset;

-- Confirms that there aren't any missing values.
SELECT COUNT(*) FROM data.staging_table WHERE COALESCE(order_date, brand, sneaker_name, sale_price, retail_price, release_date, shoe_size, buyer_region) IS NULL;

-- We can observe that there's a blank space behind every instance of "Yeezy", so let's fix that.
UPDATE data.staging_table SET brand = TRIM(brand);

-- Confirming changes.
SELECT DISTINCT brand FROM data.staging_table  WHERE brand LIKE ' Yeezy';

-- Converting data types to be accurate.
ALTER TABLE data.staging_table
ALTER COLUMN order_date TYPE DATE USING TO_DATE(order_date, 'MM/DD/YY'),
ALTER COLUMN sale_price TYPE TEXT USING REGEXP_REPLACE(sale_price, '[^0-9]+', '', 'g'),
ALTER COLUMN retail_price TYPE TEXT USING REGEXP_REPLACE(retail_price, '[^0-9]+', '', 'g'),
ALTER COLUMN release_date TYPE DATE USING TO_DATE(release_date, 'MM/DD/YY'),
ALTER COLUMN shoe_size TYPE NUMERIC USING shoe_size::numeric;

-- Could potentially be wrapped around the REGEXP_REPLACE statement above.
ALTER TABLE data.staging_table
ALTER COLUMN sale_price TYPE INTEGER USING CAST(sale_price AS INTEGER),
ALTER COLUMN retail_price TYPE INTEGER USING CAST(retail_price AS INTEGER);

-- Showcases the columns have the right values now.
\d data.staging_table

-- Ensuring correct order overall.
-- We're limited it to 10 because the entire database prints otherwise.
SELECT
  order_date,
  brand,
  sneaker_name,
  sale_price,
  retail_price,
  release_date,
  shoe_size,
  buyer_region
FROM
  data.staging_table
ORDER BY
  order_date ASC,
  brand ASC,
  sneaker_name ASC,
  shoe_size ASC,
  buyer_region ASC
LIMIT 10;

-- Confirming everything looks right.
\d data.staging_table
SELECT * FROM data.staging_table LIMIT 10;

-- Closes the SQL connection.
\q