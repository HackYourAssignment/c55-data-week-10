# Business Question Answers

Queries run against `dev_<your_name>.fct_daily_borough_stats`.

## Q1: Highest total `total_fare` across the whole loaded dataset

**SQL:**

```sql
-- TODO: query fct_daily_borough_stats grouped by pickup_borough, sum total_fare, order DESC
```

select
    pickup_borough,
    sum(total_fare) as sum_total_fare
from dev_hannahwn.fct_daily_borough_stats
group by pickup_borough
order by sum_total_fare   desc;

**Result:** 
pickup_borough|sum_total_fare    |
--------------+------------------+
Manhattan     |         493557.47|
Queens        |         273361.44|
Brooklyn      |         165283.83|
Bronx         |          20699.92|
Unknown       |2167.4000000000005|
NaN           |           1644.51|
EWR           |            309.77|
Staten Island |228.09999999999997|

**Interpretation:**     Manhattan has the hghest total fare across the loaded dataset

---

## Q2: Day with the highest overall `trip_count`

**SQL:**

```sql
-- TODO: query fct_daily_borough_stats grouped by pickup_date, sum trip_count, order DESC LIMIT 1
```
SELECT pickup_date,
sum(trip_count) AS sum_trip_count
FROM dev_hannahwn.fct_daily_borough_stats
GROUP BY  pickup_date
ORDER BY sum_trip_count   desc
LIMIT 1;


**Result:** 
pickup_date|sum_trip_count|
-----------+--------------+
 2024-01-17|          2225|

**Interpretation:** ON 2024/01/17 they did 2225 trips

---

## Q3: Highest `avg_tip_pct` for any (borough, day) combination

**SQL:**

```sql
-- TODO: query fct_daily_borough_stats order by avg_tip_pct DESC LIMIT 5
```

SELECT  
pickup_date,pickup_borough,
avg_tip_pct
FROM dev_hannahwn.fct_daily_borough_stats
ORDER BY avg_tip_pct DESC
LIMIT 5;

**Result:** 
pickup_date|pickup_borough|avg_tip_pct       |
-----------+--------------+------------------+
 2024-01-30|Unknown       |          2.500125|
 2024-01-07|Unknown       |1.3396296296296295|
 2024-01-11|Unknown       |1.1044956140350877|
 2024-01-16|Unknown       |               1.0|
 2024-01-18|Unknown       | 0.611111111111111|

**Interpretation:** TODO — note whether any avg_tip_pct > 1 rows appear and what causes them

---

## Q4: Median daily `trip_count` for Manhattan vs Brooklyn

**SQL:**

```sql
-- TODO: use percentile_cont(0.5) WITHIN GROUP (ORDER BY trip_count) filtered by borough
```

SELECT pickup_borough,
trip_count
FROM dev_hannahwn.fct_daily_borough_stats
GROUP BY
ORDER BY trip_count

**Result:** TODO

**Interpretation:** TODO (one sentence on the ratio)
