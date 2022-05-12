-- INDEXES
-- Uses data structures like tree and hash to optimize searching

-- Create Table for Importing data
CREATE TABLE new_york_addresses (
    longitude numeric(9,6),
    latitude numeric(9,6),
    street_number text,
    street text,
    unit text,
    postcode text,
    id integer CONSTRAINT new_york_key PRIMARY KEY
);

-- Import Table from csv file
COPY new_york_addresses
FROM '/tmp/city_of_new_york.csv'
WITH (FORMAT CSV, HEADER);

SELECT count(*) FROM new_york_addresses;

-- Check index performance

EXPLAIN ANALYZE SELECT * FROM new_york_addresses
WHERE street = 'BROADWAY';

DROP INDEX street_idx;

-- Create B-tree index
CREATE INDEX street_idx ON new_york_addresses (street);