{{ config(materialized="view")}}

SELECT 
REGEXP_REPLACE(title, r'^(.*?)(В?ікіпедія)(.*)', r'Вікіпедія') AS modified_title,

REGEXP_CONTAINS(title, r'^[^\w]*(Вікіпедія|Спеціальна|Шаблон|Файл|Довідка|Обговорення|Категорія|Портал|Користувач)[:_]') 
as is_meta_page, 
REGEXP_EXTRACT(title, r'^[^\w]*(Вікіпедія|Спеціальна|Шаблон|Файл|Довідка|Обговорення|Категорія|Портал|Користувач)[:_]') 
as meta_page_type,
*
from {{ref('stg_assignment3_uk_wiki')}}