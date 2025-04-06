{{ config(
    materialized='view'
) }}

-- Works with the raw_data table.
SELECT 
    MD5(
        CONCAT_WS(
            '||',
            STRPTIME('4/27/2021 11:02:10', '%m/%d/%Y %H:%M:%S'),
            age,
            industry,
            job_title,
            state,
            annual_salary
        )
    ) AS response_id,
    STRPTIME('4/27/2021 11:02:10', '%m/%d/%Y %H:%M:%S') AS timestamp, 
    CAST(age AS VARCHAR(10)) AS age,
    CAST(industry AS VARCHAR(200)) AS industry,
    CAST(job_title AS VARCHAR(150)) AS job_title,
    CAST(job_title_context AS VARCHAR(1000)) AS job_title_context,
    CAST(REPLACE(annual_salary, ',', '') AS BIGINT) AS annual_salary,
    CAST(additional_compensation AS INT) AS additional_compensation,
    CAST(currency AS VARCHAR(6)) AS currency,
    CAST(other_currency AS VARCHAR) AS other_currency, -- needs treatment 
    CAST(income_context AS VARCHAR) AS income_context, -- needs treatment
    CAST(country AS VARCHAR) AS country,
    CASE 
        WHEN 
            LOWER(REPLACE(REPLACE(country, ' ', ''), '.', '')) LIKE 'uniteds%' 
            OR LOWER(REPLACE(REPLACE(country, ' ', ''), '.', '')) LIKE 'us' 
            OR LOWER(REPLACE(REPLACE(country, ' ', ''), '.', '')) LIKE 'us%'
            OR LOWER(REPLACE(REPLACE(country, ' ', ''), '.', '')) LIKE 'uni%stat%' THEN 'US'
        WHEN 
            LOWER(REPLACE(REPLACE(country, ' ', ''), '.', '')) LIKE 'unitedk%' 
            OR LOWER(REPLACE(REPLACE(country, ' ', ''), '.', '')) LIKE 'uni%k%' 
            OR LOWER(REPLACE(REPLACE(country, ' ', ''), '.', '')) LIKE 'uk%' THEN 'UK'
        ELSE country
    END AS f_country,
    state,
    city,
    year_of_experience as years_of_experience,
    years_in_field,
    highest_education,
    CASE 
        WHEN highest_education = 'High School' THEN 1
        WHEN highest_education = 'College degree' THEN 2
        WHEN highest_education = 'Master''s degree' THEN 3
        WHEN highest_education = 'PhD' THEN 4
        WHEN highest_education = 'Professional degree (MD, JD, etc.)' THEN 5
        WHEN highest_education = 'Some degree' THEN 6
        ELSE 0
    END AS highest_education_encoded,
    gender,
    CASE 
        WHEN gender = 'Non-binary' THEN 1
        WHEN gender = 'Man' THEN 2
        WHEN gender = 'Woman' THEN 3
        WHEN gender = 'Other or prefer not to answer' THEN 4
        WHEN gender = 'Prefer not to answer' THEN 5
        ELSE 0
    END AS gender_encoded,
    race -- needs treatment
FROM {{ ref('raw_data') }}
