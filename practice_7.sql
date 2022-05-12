-- Clean DB
-- Find duplicates:

SELECT company,
       street,
       city,
       st,
       count(*) AS address_count
FROM meat_poultry_egg_establishments
GROUP BY company, street, city, st
HAVING count(*) > 1
ORDER BY company, street, city, st;

-- Another way is group and count the data:

SELECT st, 
       count(*) AS st_count
FROM meat_poultry_egg_establishments
GROUP BY st
ORDER BY st;

-- Find missing values

SELECT establishment_number,
       company,
       city,
       st,
       zip
FROM meat_poultry_egg_establishments
WHERE st IS NULL;

Another interesting thing we can do is grouping and sorting to find inconsistent data:

SELECT company,
       count(*) AS company_count
FROM meat_poultry_egg_establishments
GROUP BY company
ORDER BY company ASC;

-- Backup the table:

CREATE TABLE meat_poultry_egg_establishments_backup AS
SELECT * FROM meat_poultry_egg_establishments;

-- Add a new column that says whether a estabishment has activities related to meat processing:

-- First add a column 
ALTER TABLE meat_poultry_egg_establishments ADD COLUMN meat_processing boolean;

-- Fill the column with condition
UPDATE meat_poultry_egg_establishments set meat_processing = true WHERE activities LIKE '%Meat Processing%';

-- When we want to keep one record for duplicated results, use aggregation functions such as max:

SELECT max(establishment_number)
FROM meat_pultry_egg_establishments
GROUP BY company, street, city, st
HAVING count(*) > 1
ORDER BY company, street, city, st;

-- Clean data 
DELETE FROM meat_pultry_egg_establishments
WHERE establishment_number not in (
       SELECT max(establishment_number)
       FROM meat_pultry_egg_establishments
       GROUP BY company, street, city, st
);

-- Data consistency is really important among modern databases systems. This can be achieved using TRANSACTIONS.

-- If something fails inside a transaction, we can rollback. This will not save the changes.

start transaction

UPDATE meat_pultry_egg_establishments SET company = 'wrong data';

rollback;

-- To save them, call 'commit;'

-- Use transaction everytime you're updating your data.