SELECT
  sf.customer_state,
  COUNT(DISTINCT sf.order_id) AS sales_orders,
  mart.total_orders AS mart_orders
FROM {{ ref('fp_sales_full') }} sf
JOIN {{ ref('fct_fp_regional_differences') }} mart
  ON sf.customer_state = mart.customer_state
GROUP BY sf.customer_state, mart.total_orders
HAVING COUNT(DISTINCT sf.order_id) != mart.total_orders