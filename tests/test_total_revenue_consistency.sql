SELECT 
  ABS(
    (SELECT ROUND(SUM(payment_value), 2) FROM {{ ref('fp_sales_full') }}) -
    (SELECT ROUND(SUM(total_revenue), 2) FROM {{ ref('fct_fp_regional_differences') }})
  ) AS revenue_diff