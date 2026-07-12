SELECT
    location_id,
    borough
FROM {{ source('nyc_taxi', 'raw_zones') }}
