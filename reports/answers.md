# Business Question Answers

Queries run against `dev_<your_name>.fct_daily_borough_stats`.

## Q1: Highest total `total_fare` across the whole loaded dataset

**SQL:**

```sql
select
    pickup_borough,
    round(sum(total_fare)::numeric, 2) as dataset_total_fare_usd
from dev_halyna.fct_daily_borough_stats
group by pickup_borough
order by dataset_total_fare_usd desc
limit 1;
```

**Result:**

| pickup_borough | dataset_total_fare_usd |
| -------------- | ---------------------: |
| Manhattan      |              493955.62 |

**Interpretation:** Manhattan had the highest total fare in the loaded dataset, with total fare revenue of $493,955.62.

---

## Q2: Day with the highest overall `trip_count`

**SQL:**

```sql
select
    pickup_date,
    sum(trip_count) as total_trips
from dev_halyna.fct_daily_borough_stats
group by pickup_date
order by total_trips desc
limit 1;
```

**Result:**

| pickup_date | total_trips |
| ----------- | ----------: |
| 2024-01-17  |        2221 |

**Interpretation:** January 17, 2024 had the highest overall trip volume in the loaded dataset, with 2,221 trips across all pickup boroughs.

---

## Q3: Highest `avg_tip_pct` for any (borough, day) combination

**SQL:**

```sql
select
    pickup_borough,
    pickup_date,
    trip_count,
    round(avg_tip_pct::numeric, 4) as avg_tip_pct
from dev_halyna.fct_daily_borough_stats
order by avg_tip_pct desc nulls last
limit 5;
```

**Result:**

| pickup_borough | pickup_date | trip_count | avg_tip_pct |
| -------------- | ----------: | ---------: | ----------: |
| Unknown        |  2024-01-30 |          4 |      2.5001 |
| Unknown        |  2024-01-07 |          3 |      1.3396 |
| Unknown        |  2024-01-11 |          8 |      1.1045 |
| Unknown        |  2024-01-16 |          2 |      1.0000 |
| Unknown        |  2024-01-18 |          3 |      0.6111 |

**Interpretation:** The highest average tip percentage was 2.5001 for the Unknown borough on 2024-01-30. This is an outlier from a very small group of only 4 trips, so it should be treated as a data-quality or small-sample warning rather than a typical tipping pattern.

---

## Q4: Median daily `trip_count` for Manhattan vs Brooklyn

**SQL:**

```sql
select
    pickup_borough,
    percentile_cont(0.5) within group (order by trip_count) as median_daily_trip_count
from dev_halyna.fct_daily_borough_stats
where pickup_borough in ('Manhattan', 'Brooklyn')
group by pickup_borough
order by pickup_borough;
```

**Result:**

| pickup_borough | median_daily_trip_count |
|---|---:|
| Brooklyn | 248 |
| Manhattan | 1169.5 |

**Interpretation:** Manhattan had a much higher median daily trip volume than Brooklyn: 1,169.5 trips per day compared with 248 trips per day. The `.5` value appears because `percentile_cont` calculates a continuous median and can interpolate between two middle daily counts.
