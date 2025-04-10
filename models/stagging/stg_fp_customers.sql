{{ config(materialized="table")}}

select {{ zip_code_fix('customer_zip_code_prefix') }} AS customer_zip_code_prefix_fix, *
 
FROM {{source('kpetrynka', 'fp_customers')}}