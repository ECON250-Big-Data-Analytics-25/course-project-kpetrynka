{{ config(materialized="table")}}

select {{ zip_code_fix('geolocation_zip_code_prefix') }} AS geolocation_zip_code_prefix_fix, 
 regexp_replace(
    regexp_replace(regexp_replace(
        regexp_replace(regexp_replace(
            regexp_replace(regexp_replace(
                geolocation_city, 'ç', 'c'), r'é|ê|è|é|ê|ë', 'e'), r'á|ã|â','a'), r'ó|ô|ò|ó|ô|õ|ö','o'), 
                r'í|ì|í|î', 'i'), r'ú|ù|ú|û|ü', 'u'), r'[^a-zA-Z ]', '') as geolocation_city_fx, *
 
FROM {{source('kpetrynka', 'fp_geolocation')}}