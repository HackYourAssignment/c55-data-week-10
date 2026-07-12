-- Mart: daily borough trip statistics.
-- Grain: one row per (pickup_borough, pickup_date).
-- Used to answer: trip volume, revenue, tipping behaviour, and distance profile
-- per borough per day for January 2024.
{{ config(materialized='table') }}

WITH trips AS (
    SELECT *
    FROM {{ ref('stg_trips') }}
),

zones AS (
    SELECT *
    FROM {{ ref('stg_zones') }}
)

SELECT
    -- TODO: join trips to zones on pickup_location_id = location_id.
    --   Use an INNER JOIN: a few trips have a pickup_location_id with no matching
    --   zone (e.g. 999). INNER JOIN drops those so pickup_borough is never NULL and
    --   can serve as part of the mart's primary key (your not_null test needs this).
    -- TODO: aggregate to grain (pickup_borough, pickup_date)
    -- Required output columns:
    --   pickup_borough   TEXT     - z.borough
    --   pickup_date      DATE     - pickup_datetime::date
    --   trip_count       BIGINT   - count(*)
    --   total_fare       NUMERIC  - sum(fare_amount)
    --   avg_tip_pct      NUMERIC  - avg(tip_pct)
    --   avg_trip_distance NUMERIC - avg(trip_distance)
    z.borough AS pickup_borough,

    t.pickup_datetime::date AS pickup_date,

    count(*) AS trip_count,

    sum(t.fare_amount) AS total_fare,

    avg(t.tip_pct) AS avg_tip_pct,

    avg(t.trip_distance) AS avg_trip_distance


FROM trips t
-- TODO: add JOIN to zones here
INNER JOIN zones z

    ON t.pickup_location_id = z.location_id
-- TODO: add GROUP BY here
GROUP BY

    z.borough,

    t.pickup_datetime::date
