{{
    config( materialized = 'incremental',
    incremental_strategy = "insert_overwrite",
    partition_by = {
        "feld": "date",
        "data_type": "date" })
}}

select date, title, sum(views)

from {{source ('test_dataset', 'assignment5_input')}}
group by date, title