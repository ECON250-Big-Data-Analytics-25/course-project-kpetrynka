{{ config(materialized="table")}}

SELECT
  distinct seller_id,
  COUNT(DISTINCT order_id) AS total_orders,
  COUNT(DISTINCT customer_unique_id) AS total_unique_customers,
  sum(payment_value) as revenue,
  AVG(diff_to_approve_h) AS avg_purchase_to_approvement_hours,
  AVG(diff_to_deliver_d) AS avg_approval_to_shipment_days,
  AVG(diff_in_delivery_d) as avg_diff_delivery_estimate_to_real_days

 FROM {{ref("fp_sales_full")}}
 group by seller_id
 order by total_orders desc
 limit 100