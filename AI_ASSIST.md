# AI Assistance Log

Document one place you used an LLM during this assignment.

## The problem

tried to run jinja syntax inside dbeaver


## The prompt

select
    pickup_datetime,
    dropoff_datetime,
    pickup_location_id,
    dropoff_location_id,
    fare_amount,
    tip_amount,
    trip_distance,
    {{ safe_divide('tip_amount', 'fare_amount') }} as tip_pct
from {{ source('nyc_taxi', 'raw_trips') }}
where pickup_location_id is not null
and fare_amount > 0
SQL Error [42601]: ERROR: syntax error at or near "{"
  Position: 164

Error position: line: 9 pos: 163



## The response

The error you are seeing happens because your SQL client (like DBeaver, pgAdmin, or Datagrip) is trying to execute this query directly against your database, but it doesn't understand the `{{ ... }}` syntax.

Those double curly braces are **Jinja templates**, which are used by tools like **dbt (Data Build Tool)**. Your database just sees them as a syntax error.

Here is how to fix this depending on what you are trying to do:

### Scenario 1: You are working in a dbt project

If this is part of a dbt project, you cannot run this raw script directly in a standard SQL editor.

* **The Fix:** Run the model through your terminal using `dbt run` or `dbt compile`.
* If you are using an IDE extension (like dbt Power User in VS Code) or dbt Cloud, use their specific **"Preview"** or **"Compile"** buttons instead of your database client's standard "Execute" button.

### Scenario 2: You just want to run this quick query in your SQL client

If you aren't using dbt, or you just want to test this query right now in your SQL tool, you need to replace the Jinja code with standard SQL.

Here is the clean SQL version of your query:

```sql
select
    pickup_datetime,
    dropoff_datetime,
    pickup_location_id,
    dropoff_location_id,
    fare_amount,
    tip_amount,
    trip_distance,
    -- Replaced safe_divide macro with standard SQL handling for division by zero
    case 
        when fare_amount = 0 then 0 
        else tip_amount / fare_amount 
    end as tip_pct
-- Replaced the source() macro with your actual schema and table name
from nyc_taxi.raw_trips 
where pickup_location_id is not null
and fare_amount > 0;

```

> **Note:** Since you already have `where fare_amount > 0` at the bottom of your query, a simple `tip_amount / fare_amount` would technically be safe from division-by-zero errors in this specific run, but using the `CASE` statement mimics what `safe_divide` does behind the scenes!



## Reflection

realized i should remove jinja and got the actual dbeaver query from target>compiled after running dbt compile



---

> Remember: never paste real connection strings, passwords, or PII into an LLM.
> The NYC TLC dataset is public so sample rows are safe here, but practise the habit.
