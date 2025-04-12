{{ config(materialized="table")}}

select date(shipping_limit_date) as shipping_limit_day, *
FROM {{source('kpetrynka', 'fp_order_items')}}