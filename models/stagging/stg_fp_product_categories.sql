SELECT *, regexp_replace(regexp_replace(regexp_replace(product_category_name_english, r'fashio', 'fashion'), 
r'costruction', 'construction'), r'confort', 'comfort') as product_category_name_english_fx,
case 
when REGEXP_CONTAINS(product_category_name_english, r'fashio') then 'fashion' 
when REGEXP_CONTAINS(product_category_name_english, r'furniture') then 'furniture' 
when REGEXP_CONTAINS(product_category_name_english, r'construction|costruction') then 'construction_tools' 
when REGEXP_CONTAINS(product_category_name_english, r'books') then 'books' 
else product_category_name_english end product_category_agg

FROM {{source('kpetrynka', 'fp_product_category')}}