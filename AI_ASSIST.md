# AI Assistance Log

Document one place you used an LLM during this assignment.

## The problem

While building the stg_trips staging model, i had an SQL syntax issue because i placed the "WHERE" clause before the "FROM" clause. 
## The prompt

<!-- TODO: paste the exact prompt you sent to the LLM. -->
Im building a dbt staging model and my SQL query is failing. what is the problem here?
my query was :
SELECT
    pickup_datetime,
    pickup_location_id,
    fare_amount,
    tip_amount,
    trip_distance,

    {{ safe_divide('tip_amount', 'fare_amount') }} as tip_pct

where pickup_location_id is not null
FROM {{ source('nyc_taxi', 'raw_trips') }}
  and fare_amount >= 0
## The response

<!-- TODO: summarise or paste what the LLM returned. -->

the llm explained that SQL clauses follow a fixed order. The FROM clause must come before the WHERE clause because SQL needs to know the source table before applying filters. 

## Reflection

<!-- TODO: what did you change, keep, or discard after reviewing the LLM's answer?
     Be specific: "I kept the NULLIF suggestion but changed the column alias from
     'ratio' to 'tip_pct' to match the assignment schema." -->

TODO
i changed the query order so that "FROM" comes immediately after the SELECT columns, followed by the WHERE filters.

> Remember: never paste real connection strings, passwords, or PII into an LLM.
> The NYC TLC dataset is public so sample rows are safe here, but practise the habit.
