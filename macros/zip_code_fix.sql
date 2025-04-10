
{% macro zip_code_fix(column_name) %}
CASE 
    WHEN LENGTH(CAST({{ column_name }} AS STRING)) = 4 THEN 
        CONCAT('0', CAST({{ column_name }} AS STRING))
    ELSE 
        CAST({{ column_name }} AS STRING)
END
{% endmacro %}