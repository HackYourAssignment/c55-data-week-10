# Business Question Answers

Queries run against `dev_<your_name>.fct_daily_borough_stats`.

## Q1: Highest total `total_fare` across the whole loaded dataset

**SQL:**

```sql
SELECT 
    pickup_borough, 
    SUM(total_fare) AS grand_total_fare
FROM dev_mareh.fct_daily_borough_stats
GROUP BY pickup_borough
ORDER BY grand_total_fare DESC;
```

**Result:** 
Manhattan: 493,955.62
Queens: 274,214.90
**Interpretation:** Manhattan has the highest total fare across the entire dataset, generating nearly double the revenue of the second-highest borough, Queens.

---

## Q2: Day with the highest overall `trip_count`

**SQL:**

```sql
SELECT 
    pickup_date, 
    SUM(trip_count) AS daily_trips
FROM dev_mareh.fct_daily_borough_stats
GROUP BY pickup_date
ORDER BY daily_trips DESC
LIMIT 1;
```

**Result:** pickup_date:2024-01-17 daily_trips: 2,221

**Interpretation:** January 17, 2024, was the busiest day in the dataset, recording the highest overall trip volume with 2,221 trips.

---

## Q3: Highest `avg_tip_pct` for any (borough, day) combination

**SQL:**

```sql
SELECT 
    pickup_borough,
    pickup_date,
    avg_tip_pct
FROM dev_mareh.fct_daily_borough_stats
ORDER BY avg_tip_pct DESC
LIMIT 5;
```

**Result:** 
Unknown (2024-01-30): 2.500125
Unknown (2024-01-07): 1.339630
Unknown (2024-01-11): 1.104496
Unknown (2024-01-16): 1.000000
Unknown (2024-01-18): 0.611111

**Interpretation:** Yes, there are rows where avg_tip_pct > 1 (specifically on Jan 30, Jan 7, and Jan 11, all in the "Unknown" borough). This occurs because the "Unknown" borough represents a very small-sample bucket where a few outlier trips with exceptionally high tips easily skew and dominate the daily average.

---

## Q4: Median daily `trip_count` for Manhattan vs Brooklyn

**SQL:**

```sql
SELECT 
    pickup_borough,
    percentile_cont(0.5) WITHIN GROUP (ORDER BY trip_count) AS median_trip_count
FROM dev_mareh.fct_daily_borough_stats
WHERE pickup_borough IN ('Manhattan', 'Brooklyn')
GROUP BY pickup_borough;
```

**Result:** 
Brooklyn: 248
Manhattan: 1,169.5

**Interpretation:** Manhattan has a significantly higher median daily trip count compared to Brooklyn, outperforming it by nearly 4.7 times.
