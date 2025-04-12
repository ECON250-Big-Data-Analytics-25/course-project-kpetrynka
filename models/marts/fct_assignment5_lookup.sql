{{
config(materialized = 'incremental',
unique_key = 'title')
}}

select distinct title, MIN(date(datehour)) as min_date, max(date(datehour)) as max_date, sum(views) as  total_views
 
from {{source ('test_dataset', 'assignment5_input')}}

{% if is_incremental() %}
where date(datehour) >= (select max(date(datehour)) from {{ this }}) - 1
{% endif %}
group by title