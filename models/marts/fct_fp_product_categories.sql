{{ config(materialized="table")}}


SELECT distinct item.product_category_agg, extract(MONTH from order_purchase_timestamp) as month, 
extract(YEAR from order_purchase_timestamp) as year, count(distinct order_id) as popularity

FROM {{ref('fp_sales_full')}}, unnest(items_info) as item
group by item.product_category_agg, month, year
order by popularity desc