{{
    config( materialized = 'view',
    cluster_by=["customer_unique_id", "order_id"],
    partition_by = {
        "field": "order_purchase_timestamp",
        "data_type": "date"})
}}


  SELECT order_id, customer_unique_id, customer_id, customer_city, customer_state, customer_zip_code_prefix_fix, 
  geolocation_city_fx,
    order_status, order_purchase_timestamp, order_estimated_delivery_date, diff_in_delivery_d, diff_to_approve_h, 
    diff_to_deliver_d, payment_type, payment_installments, payment_value, seller_id, seller_city,
    seller_state, by_voucher, 
    ARRAY_AGG(struct(products.product_id as product_id, product_category_agg,
    items.price as price, items.freight_value as freight_value)) as items_info, 


FROM {{ref('stg_fp_orders')}} orders
INNER JOIN {{ref('stg_fc_payments')}} payments
using(order_id) 
INNER JOIN {{ref('stg_fp_order_items')}} items
using(order_id) 
Inner JOIN {{ref("stg_fp_customers")}} customers
using(customer_id)
INNER JOIN {{source('kpetrynka', 'fp_products')}} products
using(product_id)
INNER JOIN {{ref('stg_fp_sellers')}} sellers
using(seller_id)
INNER JOIN {{ref('stg_fp_geolocation')}} geo
on sellers.seller_zip_code_prefix_fix = geo.geolocation_zip_code_prefix_fix
INNER JOIN {{ref('stg_fp_product_categories')}} categories
using(product_category_name)

GROUP BY 
  order_id, customer_unique_id, customer_id, customer_city, customer_state, 
  customer_zip_code_prefix_fix, geolocation_city_fx, order_status, 
  order_purchase_timestamp, order_estimated_delivery_date, diff_in_delivery_d, 
  diff_to_approve_h, diff_to_deliver_d, payment_type, payment_installments, 
  payment_value, seller_id, seller_city, seller_state, by_voucher