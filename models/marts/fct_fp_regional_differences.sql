{{ config(materialized="table")}}

select distinct customer_state,  
COUNT(DISTINCT order_id) AS total_orders,
COUNT(DISTINCT customer_unique_id) AS total_unique_customers,
avg(payment_value) as avg_check,
avg(payment_installments) as avg_payment_installments,
round(sum(by_voucher)/count(*),3) as rate_of_vaucher_orders

FROM {{ref('fp_sales_full')}}
group by customer_state
order by avg_check desc