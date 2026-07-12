-- safe_divide(numerator, denominator)
-- Returns numerator / denominator, or NULL when denominator is 0 or NULL.
-- Use for tip_pct = tip_amount / fare_amount and similar ratio columns.

{% macro safe_divide(numerator, denominator) %}
    
        {{ numerator }} / nullif({{ denominator }}, 0)

{% endmacro %}


