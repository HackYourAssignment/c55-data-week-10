-- safe_divide(numerator, denominator)
-- Returns numerator / denominator, or NULL when denominator is 0 or NULL.
-- Use for tip_pct = tip_amount / fare_amount and similar ratio columns.




{% macro safe_divide(numerator, denominator) %}
    {{ numerator }} / NULLIF({{ denominator }}, 0)
    {#- NULLIF(x, 0) returns NULL when the denominator is 0, and Postgres propagates
        NULL through division, so the whole expression becomes NULL instead of raising
        a division-by-zero error. Standard dbt pattern for any ratio column. -#}
{% endmacro %}
