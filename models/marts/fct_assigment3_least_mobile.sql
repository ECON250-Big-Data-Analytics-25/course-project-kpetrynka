SELECT 
    hour_of_day,
        SUM(views) AS total_views,
        SUM(CASE WHEN src = 'mobile' THEN views ELSE 0 END) AS total_mobile_views, 
FROM `econ250-2025.kpetrynka.int_assignment3_uk_wiki`
where modified_title = "AWStats"
group by hour_of_day
order by hour_of_day