{{ config(materialized="table")}}

SELECT 
    modified_title,
    total_views, 
    total_mobile_views,
    ROUND((total_mobile_views / total_views) * 100, 2) AS mobile_percentage
FROM (
    SELECT 
        modified_title,
        SUM(views) AS total_views,
        SUM(CASE WHEN src = 'mobile' THEN views ELSE 0 END) AS total_mobile_views
    FROM {{ref ("int_assignment3_uk_wiki")}}
    WHERE is_meta_page = FALSE
    GROUP BY modified_title
    ORDER BY total_views DESC
    LIMIT 200
) sub
ORDER BY mobile_percentage ASC