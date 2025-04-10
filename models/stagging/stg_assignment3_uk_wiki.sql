{{ config(materialized="view")}}

SELECT title, views, 
"desktop" as src, 
Date(datehour) as date,
EXTRACT(day from datehour) as day_of_month, 
EXTRACT(hour from datehour) as hour_of_day, 

from {{source ('test_dataset', 'assignment3_input_uk')}} 

UNION All

SELECT title, views, 
"mobile" as src, 
Date(datehour) as date,
EXTRACT(day from datehour) as day_of_month, 
EXTRACT(hour from datehour) as hour_of_day, 

from {{source ('test_dataset', 'assignment3_input_uk_m')}} 