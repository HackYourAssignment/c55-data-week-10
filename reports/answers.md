# Business Question Answers

Queries run against `dev_pavel_tisner.fct_daily_borough_stats`.

## Q1: Highest total `total_fare` across the whole loaded dataset

**SQL:**

```sql
select
    pickup_borough,
    sum(total_fare) as total_fare_across_dataset
from dev_pavel_tisner.fct_daily_borough_stats
group by pickup_borough
order by total_fare_across_dataset desc
limit 1;
```

**Result:** 
| pickup_borough | total_fare_across_dataset |
| --- | ---: |
| Manhattan | 493,955.620... |

**Interpretation:** Manhattan had the highest total fare across the loaded dataset, meaning it generated the most fare revenue among pickup boroughs.

---

## Q2: Day with the highest overall `trip_count`

**SQL:**

```sql
select
    pickup_date,
    sum(trip_count) as overall_trip_count
from dev_pavel_tisner.fct_daily_borough_stats
group by pickup_date
order by overall_trip_count desc
limit 1;
```

**Result:** 
| pickup_date | overall_trip_count |
| --- | ---: |
| 2024-01-17 | 2,221 |

**Interpretation:** January 17, 2024 had the highest overall trip count in the loaded dataset.

---

## Q3: Highest `avg_tip_pct` for any (borough, day) combination

**SQL:**

```sql
select
    pickup_borough,
    pickup_date,
    avg_tip_pct
from dev_pavel_tisner.fct_daily_borough_stats
order by avg_tip_pct desc
limit 5;
```

**Result:** 
| pickup_borough | pickup_date | avg_tip_pct |
| --- | --- | ---: |
| Unknown | 2024-01-30 | 2.500... |
| Unknown | 2024-01-07 | 1.340... |
| Unknown | 2024-01-11 | 1.104... |
| Unknown | 2024-01-16 | 1.000... |
| Unknown | 2024-01-18 | 0.611... |

**Interpretation:** The highest average tip percentage was for the `Unknown` borough on 2024-01-30, at about 2.5, meaning tips averaged about 250% of fare amount for that borough/date combination. The `avg_tip_pct > 1` rows are unusual but expected warning-level findings because low-volume or dirty borough buckets can be dominated by a few high-tip trips.

---

## Q4: Median daily `trip_count` for Manhattan vs Brooklyn

**SQL:**

```sql
select
    pickup_borough,
    percentile_cont(0.5) within group (order by trip_count) as median_daily_trip_count
from dev_pavel_tisner.fct_daily_borough_stats
where pickup_borough in ('Manhattan', 'Brooklyn')
group by pickup_borough
order by pickup_borough;
```

**Result:** 
| pickup_borough | median_daily_trip_count |
| --- | ---: |
| Brooklyn | 248.0 |
| Manhattan | 1,169.5 |

**Interpretation:** Manhattan’s median daily trip count was much higher than Brooklyn’s, at about 4.7 times Brooklyn’s median daily volume.
