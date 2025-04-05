{{ config(
    materialized='table'
) }}

select * 
from read_csv_auto('/home/jmsbs/_dev/askAManager/_data/responses.csv')
