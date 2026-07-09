# AI Assistance Log

Document one place you used an LLM during this assignment.

## The problem

I used an LLM while debugging my Week 10 dbt assignment after I ran into several errors that blocked the project from running correctly. The main issue was not writing the assignment from scratch, but understanding and fixing setup/runtime problems: VS Code showed false SQL syntax errors for dbt/Jinja syntax, `dbt deps` failed on Windows because `dbt_packages` was locked by another process, YAML parsing failed in `_fct_daily_borough_stats.yml`, and `dbt build` failed because the local `profiles.yml` connection settings were incorrect.

## The prompt

I asked the LLM several debugging questions while I was trying to get the dbt project to run correctly. The main prompt was:

```text
I am working on a Week 10 dbt assignment. I already have the dbt models and YAML files, but I am getting several errors while trying to run and validate the project.

Please help me debug the errors step by step. I want to understand what is wrong, which files need to be fixed, and how to verify that the project works correctly.

The errors include:
- VS Code shows SQL syntax errors near dbt/Jinja syntax such as {{ ref(...) }}, {{ source(...) }}, and {% macro %}.
- dbt deps fails on Windows with a file-locking error in dbt_packages.
- dbt compile fails with: Env var required but not provided: 'PG_HOST'.
- A YAML file fails with: mapping values are not allowed in this context.
- dbt build fails because of PostgreSQL profile/connection settings.

Please explain which errors are real dbt problems, which ones are only editor/linter warnings, and give the exact commands I should run to verify the project.
```

## The response

The LLM explained that many red VS Code “SQL syntax” errors were false positives because VS Code was parsing dbt/Jinja files as plain PostgreSQL. It advised me to validate the project with dbt compile and dbt build instead of relying only on the Problems panel.

For the real errors, the LLM identified concrete fixes:

add dbt_utils correctly in packages.yml;
clean and reinstall dbt_packages after the Windows file-lock error;
fix _fct_daily_borough_stats.yml by using a YAML multiline description with description: |;
use a local profiles.yml only for running dbt, but keep profiles.yml.example for the repo;
make sure the profile points to the correct database, schema, SSL mode, and password environment variable;
run the final validation with:
dbt deps
dbt debug --profiles-dir .
dbt compile --profiles-dir .
dbt build --profiles-dir . --select +fct_daily_borough_stats

## Reflection

I used the LLM output as debugging guidance, not as a blind code generator. I kept the advice that dbt/Jinja syntax should be checked with dbt compile rather than by the generic SQL linter in VS Code. I also applied the YAML fix using description: |, corrected the package setup, and checked the dbt project with dbt build.

I did not paste any real password or private connection string into the LLM. I reviewed the suggested changes before applying them and kept the assignment logic focused on the required dbt models, tests, documentation, and business-answer queries.

---

> Remember: never paste real connection strings, passwords, or PII into an LLM.
> The NYC TLC dataset is public so sample rows are safe here, but practise the habit.
```
