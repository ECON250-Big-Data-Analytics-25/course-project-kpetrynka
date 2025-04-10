{{ config(materialized="table")}}

select {{ zip_code_fix('seller_zip_code_prefix') }} AS seller_zip_code_prefix_fix, 
case when seller_city in ('sao paulo sp', 'sp', 'sao pauo', 'sp / sp', 'sao paulo / sao paulo', 'sao paulo', 'são paulo', 'sao paulop', 'sao  paulo', 'sao paulo - sp', 'sao paluo') 
then 'sao paulo' 
when seller_city in ("santa barbara d'oeste", 'santa barbara d oeste') then 'santa barbara d´oeste'
else seller_city end as seller_city_fx,
*
 
FROM {{source('kpetrynka', 'fp_sellers')}}