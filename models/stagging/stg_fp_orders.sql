{{ config(materialized="table")}}

SELECT *,  
round(TIMESTAMP_DIFF(order_approved_at,order_purchase_timestamp, SECOND)/3600.0, 2) as diff_to_approve_h, 
round(TIMESTAMP_DIFF(order_estimated_delivery_date,order_approved_at, day), 2) as diff_to_deliver_d, 
TIMESTAMP_DIFF(order_delivered_carrier_date,order_estimated_delivery_date, day) as diff_in_delivery_d
FROM {{source('kpetrynka', 'fp_orders')}}