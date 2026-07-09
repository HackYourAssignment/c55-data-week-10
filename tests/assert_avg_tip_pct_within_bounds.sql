-- Singular test: flag (borough, date) combinations where avg_tip_pct > 1.
-- A tip_pct > 1 means the average tip exceeded the total fare for that cell,
-- which is unusual and almost always indicates a small-sample bucket (e.g. the
-- Unknown borough) where a few high-tip outliers dominate the average.
--

{{ config(severity='warn') }}

SELECT
    pickup_borough,
    pickup_date,
    avg_tip_pct
FROM {{ ref('fct_daily_borough_stats') }}
WHERE avg_tip_pct > 1


