drop schema if exists data cascade;
create schema data;

create table data.raw_dataset(
    order_date text,
    brand text,
    sneaker_name text,
    sale_price text,
    retail_price text,
    release_date text,
    shoe_size text,
    buyer_region text
);

copy data.raw_dataset
from '/stockx-sales-dashboard/data/raw_dataset.csv'
delimiter ',' header csv;