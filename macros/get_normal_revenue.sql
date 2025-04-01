
{% macro get_normal_revenue(column_name, scale=2) %}
    CAST({{ column_name }} / 1e6 AS FLOAT64)
{% endmacro %}