{{
  config(
    materialized='incremental',
    unique_key='visitId',
    incremental_strategy='merge'
  )
}}

SELECT 
date, visitId, page.pagePath as landing_page

 FROM {{ source('test_dataset', 'week5_hits')}}
 where hitNumber = 1

{% if is_incremental() %}

and date >= (select coalesce(max(date) - 7,'2000-01-01') from {{ this }} )

{% endif %}

qualify row_number() over(partition by visitid order by hitNumber) = 1