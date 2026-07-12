-- Staging model: one row per NYC green taxi trip (January 2024).
-- Renames source columns, adds derived columns, and filters bad rows.
-- Downstream: fct_daily_borough_stats joins this to stg_zones.
{{ config(materialized='view') }}

SELECT
    pickup_datetime,
    pickup_location_id,
    fare_amount,
    tip_amount,
    trip_distance,

    {{ safe_divide('tip_amount', 'fare_amount') }} as tip_pct

FROM {{ source('nyc_taxi', 'raw_trips') }}

where pickup_location_id is not null
  and fare_amount >= 0
