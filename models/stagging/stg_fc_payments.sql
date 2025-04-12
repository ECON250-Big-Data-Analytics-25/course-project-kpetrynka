{{ config(materialized="table")}}

SELECT case when payment_type in ('voucher') then 1 else 0 end by_voucher, *
FROM {{source('kpetrynka', 'fp_order_payments')}}