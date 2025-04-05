{{ config(
    materialized='view'
) }}
SELECT 
    cast("Timestamp" AS timestamp) AS timestamp,
    cast("How old are you?" AS age) as VARCHAR(10),
    CAST("What industry do you work in?" AS industry) as VARCHAR(200),
    CAST("Job title" AS job_title) AS varchar(150),
    CAST("If your job title needs additional context, please clarify here:" AS job_title_context) as VARCHAR(1000),
    CAST(replace(annual_salary, ',', '') "What is your annual salary? (You'll indicate the currency in a later question. If you are part-time or hourly, please enter an annualized equivalent -- what you would earn if you worked the job 40 hours a week, 52 weeks a year.)" AS annual_salary) as BIGINT,
    CAST("How much additional monetary compensation do you get, if any (for example, bonuses or overtime in an average year)? Please only include monetary compensation here, not the value of benefits." AS additional_compensation) as INT,
    CAST("Please indicate the currency" AS currency) as Varchar(6),
    'If ""Other,"" please indicate the currency here:' AS other_currency,
    "If your income needs additional context, please provide it here:" AS income_context,
    "What country do you work in?" AS country,
    "If you're in the U.S., what state do you work in?" AS state,
    "What city do you work in?" AS city,
    "How many years of professional work experience do you have overall?" AS total_experience_years,
    "How many years of professional work experience do you have in your field?" AS field_experience_years,
    "What is your highest level of education completed?" AS education_level,
    "What is your gender?" AS gender,
    "What is your race? (Choose all that apply.)" AS race
FROM {{ ref('raw_data') }}

