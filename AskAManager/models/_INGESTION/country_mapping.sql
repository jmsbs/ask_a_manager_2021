{{ config(
    materialized='table'
) }}

SELECT 
    CAST(country AS VARCHAR) AS country_raw,
    CASE
        WHEN LOWER(REPLACE (REPLACE (country, ' ', ''), '.', '')) LIKE 'uniteds%' 
        OR LOWER(REPLACE (REPLACE (country, ' ', ''), '.', '')) LIKE 'united s%'
        OR LOWER(REPLACE (REPLACE (country, ' ', ''), '.', '')) LIKE 'us'
        OR LOWER(REPLACE (REPLACE (country, ' ', ''), '.', '')) LIKE 'us%'
        OR LOWER(REPLACE (REPLACE (country, ' ', ''), '.', '')) LIKE '%us%'
        OR LOWER(REPLACE (REPLACE (country, ' ', ''), '.', '')) LIKE 'uni%stat%' THEN 'US'
        WHEN LOWER(REPLACE (REPLACE (country, ' ', ''), '.', '')) LIKE 'unitedk%'
        OR LOWER(REPLACE (REPLACE (country, ' ', ''), '.', '')) LIKE 'uni%k%'
        OR LOWER(REPLACE (REPLACE (country, ' ', ''), '.', '')) LIKE 'uk%'
        OR LOWER(REPLACE (REPLACE (country, ' ', ''), '.', '')) LIKE '%uk%' THEN 'UK'
        WHEN LENGTH(country) > 50 THEN NULL
        ELSE country
    END AS country_encoded,
    c.name,
    c.alpha2,
    c.alpha3
FROM {{ ref ('raw_data') }}
JOIN    read_csv_auto('/home/jmsbs/_dev/askAManager/_data/countries.csv') as c