# AI Assistance Log

Document one place you used an LLM during this assignment.

## The problem

After adding the `dbt_utils.unique_combination_of_columns` test to `fct_daily_borough_stats`, I ran `dbt parse`. The project parsed, but dbt showed a deprecation warning about generic test arguments. I wanted to understand what the warning meant and how to update the YAML syntax correctly.

## The prompt

```text
(.venv) pavel@Pavels-MacBook-Air c55-data-week-10 % ./.venv/bin/dbt parse --profiles-dir .
/Users/pavel/Desktop/data _learn/c55-data-week-10/.venv/lib/python3.9/site-packages/urllib3/__init__.py:35: NotOpenSSLWarning: urllib3 v2 only supports OpenSSL 1.1.1+, currently the 'ssl' module is compiled with 'LibreSSL 2.8.3'. See: https://github.com/urllib3/urllib3/issues/3020
  warnings.warn(
23:12:57  Running with dbt=1.10.22
23:12:58  Registered adapter: postgres=1.9.1
23:12:58  Unable to do partial parsing because a project dependency has been added
23:13:00  [WARNING][MissingArgumentsPropertyInGenericTestDeprecation]: Deprecated
functionality
Found top-level arguments to test dbt_utils.unique_combination_of_columns
Arguments to generic tests should be nested under the arguments property.
23:13:00  Performance info: /Users/pavel/Desktop/data _learn/c55-data-week-10/target/perf_info.json
23:13:00  [WARNING][DeprecationsSummary]: Deprecated functionality
Summary of encountered deprecations:
- MissingArgumentsPropertyInGenericTestDeprecation: 1 occurrence
To see all deprecation instances instead of just the first occurrence of each,
run command again with the --show-all-deprecations flag. You may also need to
run with --no-partial-parse` as some deprecations are only encountered during
parsing.
What should I change?
```

## The response

The LLM explained that the test logic was correct, but the YAML used an older style for passing arguments to a generic test. It said that in newer dbt style, test parameters should be placed under an explicit `arguments:` key.

It suggested changing this:

```yaml
tests:
  - dbt_utils.unique_combination_of_columns:
      combination_of_columns:
        - pickup_borough
        - pickup_date
```

to this:

```yaml
tests:
  - dbt_utils.unique_combination_of_columns:
      arguments:
        combination_of_columns:
          - pickup_borough
          - pickup_date
```

## Reflection

I kept the `arguments:` suggestion because it removed the dbt deprecation warning while keeping the same test logic: one row per combination of `pickup_borough` and `pickup_date`.

I did not change the grain of the mart or the tested columns. I only changed the YAML syntax for the generic test arguments.

After the change, `dbt parse` ran without the deprecation warning, and the mart tests completed successfully:

```text
Done. PASS=4 WARN=0 ERROR=0 SKIP=0 NO-OP=0 TOTAL=4
```

Later, the full project build completed with one expected warning from the singular `avg_tip_pct` test:

```text
Done. PASS=11 WARN=1 ERROR=0 SKIP=0 NO-OP=0 TOTAL=12
```

---

> Remember: never paste real connection strings, passwords, or PII into an LLM.
> The NYC TLC dataset is public so sample rows are safe here, but practise the habit.
