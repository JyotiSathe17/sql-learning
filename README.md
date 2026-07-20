# MySQL Beginner Series 🐬

Documenting my journey learning MySQL from scratch. This repo contains the queries and scripts I write as I go, organized day by day.

## 📅 Progress Log

### Day 1 — 03-07-2026 to 04-07-2026
- **Created a practice database**: `Parks_and_Rec_Create_db` — set up tables to practice queries on.
- **SELECT statements**: Learned the basics of retrieving data from tables using `SELECT_Query`.
- **WHERE clause**: Practiced filtering records with conditions in `Where Clause`.

### Day 2 — 6-7-2026
- Learned about `GROUP BY` and `ORDER BY`
- Practiced grouping records and aggregating data with `GROUP BY`
- Practiced sorting results in ascending/descending order with `ORDER BY`

### Day 3 — 7-7-2026
- Learned about `HAVING`, `LIMIT`, and aliasing
- Practiced filtering grouped results using HAVING
- Practiced limiting the number of rows returned with LIMIT
- Practiced renaming columns/tables using aliases (AS)

### Day 4 — 9-7-26
- Learned about JOINs in depth
- Practiced INNER JOIN
- Practiced OUTER JOIN — LEFT JOIN and RIGHT JOIN
- Practiced SELF JOIN

### Day 5 — 10-7-26
- Learned about `UNION`
- Practiced combining results from multiple queries using UNION
- Learned string functions: `LENGTH`, `UPPER`, `LOWER`, `TRIM`, `LTRIM`, `RTRIM`, `LEFT`, `RIGHT`, `SUBSTRING`
- Practiced manipulating and formatting text data using these functions

### Day 6 — 11-7-26
- Learned more string functions: `REPLACE`, `LOCATE`, `CONCAT`
- Practiced replacing substrings, finding position of a substring, and joining strings together
- Learned the `CASE` statement
- Practiced writing conditional logic within queries using CASE

### Day 7 — 12-7-26
- Learned about subqueries
- Practiced writing subqueries in `WHERE`, `SELECT`, and `FROM` clauses
- Practiced using subqueries to filter results based on another query's output

### Day 8 — 14-7-26
- Learned Window Functions: `OVER`, `PARTITION BY`, ROW_NUMBER, RANK, DENSE_RANK, and running totals

**Key points to remember:**

**OVER() and PARTITION BY**
- A window function performs a calculation across a set of rows *related to the current row*, without collapsing them into a single output row (unlike GROUP BY).
- `PARTITION BY` divides the result set into groups (windows) — the function is applied separately within each group.

**GROUP BY vs OVER() — the core difference**
- `GROUP BY` collapses multiple rows into one row per group — you lose access to individual row details.
- `OVER()` keeps every row visible while still letting you calculate aggregates (SUM, AVG, COUNT, etc.) per group.
- This makes `OVER()` ideal when you want to show detail-level data **alongside** an aggregate value (e.g. each employee's salary next to their department's average salary) — something GROUP BY alone cannot do.

**Running Total (Rolling Sum)**
- Achieved using `SUM() OVER (ORDER BY column)`.
- Instead of a single total, it accumulates the sum row by row, in the order specified.
- Useful for tracking cumulative values over time (e.g. running revenue, running count).

**ROW_NUMBER()**
- Assigns a unique, sequential number to each row within a partition, starting at 1.
- No ties — every row gets a different number, even if values are equal.

**RANK()**
- Assigns a rank to each row within a partition, based on `ORDER BY`.
- If there's a tie, rows share the same rank — but the next rank **skips** numbers (e.g. 1, 2, 2, 4).

**DENSE_RANK()**
- Same as RANK(), but does **not** skip numbers after a tie (e.g. 1, 2, 2, 3).

### Day 9 — 15-07-26
- Learned Common Table Expressions (CTEs): aliasing, default naming, combining multiple CTEs, and two ways to write them

**Key points to remember:**

**What is a CTE?**
- A CTE (Common Table Expression) is a temporary, named result set defined using `WITH`, which you can reference like a table within a single query.
- It exists only for the duration of that query — it's not stored permanently like a view or table.

**Basic Syntax**
```sql
WITH cte_name AS (
    SELECT ...
    FROM ...
)
SELECT * FROM cte_name;
```

**Why use CTEs**
- Makes complex queries more readable by breaking them into logical, named steps.
- Avoids repeating the same subquery multiple times in one query.
- Easier to debug than deeply nested subqueries — each CTE can be tested on its own.

**Aliasing in CTEs**
- You can rename columns inside the CTE definition to make the final query cleaner and more readable.
- Default naming: if you don't alias a column, CTE uses the column name from the original SELECT.

**Combining Multiple CTEs**
- You can define more than one CTE in a single `WITH` clause, separated by commas:
```sql
WITH cte1 AS (
    SELECT ...
),
cte2 AS (
    SELECT ...
)
SELECT * FROM cte1
JOIN cte2 ON ...;
```
- Later CTEs in the chain can reference earlier ones — this is useful for multi-step transformations.

**Two Ways to Write CTEs**
1. **Single CTE** — one `WITH` block feeding directly into the main query.
2. **Chained/Multiple CTEs** — several `WITH` blocks stacked together (comma-separated), where each can build on the previous one, useful for breaking a big problem into smaller logical pieces.

**CTE vs Subquery**
- A CTE is essentially a more readable, named alternative to a subquery — functionally similar, but easier to reuse and maintain within the same query.

### Day 10 — 16-7-26
- Learned about Temporary Tables

**Key points to remember:**

**What is a Temporary Table?**
- A temporary table is a table that exists only for the duration of a session (or connection) — it's automatically dropped once the session ends or the connection closes.
- Useful for storing intermediate results when a query is too complex to handle in one step.

**Why use Temporary Tables**
- Helpful for breaking down complex, multi-step logic into manageable pieces.
- Useful when the same intermediate result is needed multiple times within a session — avoids recalculating it each time.
- Good for testing/prototyping without affecting permanent tables.

**Temporary Table vs CTE**
- A CTE only exists for the single query it's defined in; a temporary table persists for the whole session and can be reused across multiple queries.
- Temporary tables can be indexed, updated, and queried repeatedly — CTEs cannot.
- Temporary tables use actual storage (in tempdb or similar), so they have a bit more overhead than a CTE.

**Things to remember**
- Temporary tables are session-specific — other users/connections can't see them, even if named the same.
- They're automatically dropped when the session ends, but can also be manually dropped using:
```sql
DROP TEMPORARY TABLE temp_table_name;
```

### Day 11 — 18-7-26
- Learned about Stored Procedures

**Key points to remember:**

**What is a Stored Procedure?**
- A stored procedure is a saved, precompiled set of SQL statements that you can run whenever needed by calling its name — instead of rewriting the same query every time.
- Stored permanently in the database (unlike temporary tables or CTEs).

**Basic Syntax**
```sql
DELIMITER //

CREATE PROCEDURE procedure_name()
BEGIN
    SELECT ...
    FROM ...;
END //

DELIMITER ;
```

**Calling a Stored Procedure**
```sql
CALL procedure_name();
```

**Parameters in Stored Procedures**
- Procedures can accept input parameters, making them reusable with different values:
```sql
CREATE PROCEDURE procedure_name(IN param1 datatype)
BEGIN
    SELECT ...
    FROM ...
    WHERE column = param1;
END //
```
- `IN` — passes a value into the procedure (most common)
- `OUT` — returns a value from the procedure
- `INOUT` — used for both passing in and returning a value

**Why use Stored Procedures**
- Reusability — write the logic once, call it anytime.
- Performance — precompiled, so it can run faster than sending the same raw query repeatedly.
- Security — users can be given permission to run a procedure without direct access to underlying tables.
- Maintainability — logic changes happen in one place (the procedure), not scattered across the app.

**Stored Procedure vs Function**
- A stored procedure can perform actions (INSERT, UPDATE, DELETE) and doesn't have to return a value.
- A function must return a single value and is typically used within a SELECT statement.

**Things to remember**
- Use `DELIMITER //` before defining a procedure so MySQL doesn't treat the semicolons inside the procedure body as the end of the statement.
- To remove a procedure:
```sql
DROP PROCEDURE procedure_name;
```

### Day 12 — 19-7-26
- Learned about Triggers and Events

**Key points to remember:**

**What is a Trigger?**
- A trigger is a block of SQL code that automatically executes in response to a specific event on a table — `INSERT`, `UPDATE`, or `DELETE`.
- Runs automatically; you don't call it manually like a stored procedure.

**Basic Syntax**
```sql
DELIMITER //

CREATE TRIGGER trigger_name
BEFORE INSERT ON table_name
FOR EACH ROW
BEGIN
    -- logic here
END //

DELIMITER ;
```

**Timing and Events**
- Timing: `BEFORE` or `AFTER` — whether the trigger runs before or after the triggering action.
- Event: `INSERT`, `UPDATE`, or `DELETE` — the action that fires the trigger.
- Combinations: `BEFORE INSERT`, `AFTER INSERT`, `BEFORE UPDATE`, `AFTER UPDATE`, `BEFORE DELETE`, `AFTER DELETE`.

**NEW and OLD keywords**
- `NEW` — refers to the new row's values (used in INSERT and UPDATE triggers).
- `OLD` — refers to the row's values before the change (used in UPDATE and DELETE triggers).

**Why use Triggers**
- Automatically enforce business rules (e.g. prevent negative stock values).
- Keep audit logs — automatically record changes to a table.
- Maintain data consistency across related tables without relying on the application layer.

**Things to remember**
- Triggers run automatically — no `CALL` needed.
- Overusing triggers can make debugging harder since logic runs silently in the background.
- To remove a trigger:
```sql
DROP TRIGGER trigger_name;
```

---

**What is an Event?**
- An event (Event Scheduler) is a task that runs automatically at a scheduled time or interval — like a cron job, but built into MySQL.

**Basic Syntax**
```sql
CREATE EVENT event_name
ON SCHEDULE EVERY 1 DAY
DO
    -- SQL statement(s) here
```

**Enabling the Event Scheduler**
- MySQL's event scheduler must be turned on for events to run:
```sql
SET GLOBAL event_scheduler = ON;
```

**Trigger vs Event**
- A trigger runs in response to a data change (INSERT/UPDATE/DELETE) on a specific table.
- An event runs based on time/schedule, independent of any specific data change.

**Things to remember**
- Events are useful for recurring maintenance tasks — e.g. archiving old records, cleaning up logs, resetting counters.
- To remove an event:
```sql
DROP EVENT event_name;
```

## 🚀 Project: Data Cleaning

### Day 13 — 20-7-26
- Started a hands-on data cleaning project
- Downloaded a new dataset from GitHub
- Created a new schema in MySQL and imported the dataset
- Performed removal of duplicate records
- *(This script will be built on further as more cleaning steps are added)*

**Key points to remember:**

**Importing a Dataset into MySQL**
- Create a new schema first to keep the project isolated from other practice databases:
```sql
CREATE DATABASE schema_name;
USE schema_name;
```
- Import CSV data using either MySQL Workbench's **Table Data Import Wizard**, 
**Why Data Cleaning Matters**
- Raw datasets often have duplicates, inconsistent formatting, missing values, or incorrect data types — cleaning ensures accurate analysis later.
- It's usually the first and most important step before any real analysis or reporting.

**Removing Duplicates**
- One common approach: use `ROW_NUMBER()` with `PARTITION BY` to identify duplicate rows based on key columns, then delete rows where the row number is greater than 1.
- Always duplicate the raw table first (e.g. `table_name_staging`) before cleaning, so the original data isn't lost if something goes wrong.

**Things to remember**
- Never clean data directly on the raw/original table — always work on a staging copy.
- Identify duplicates based on the *combination* of relevant columns, not just one column, to avoid false positives.

| `layoffs.csv` | Original dataset downloaded from GitHub |
| `layoffs_data_cleaning.sql` | Importing dataset and removing duplicates (ongoing — more cleaning steps to be added) |



## 📁 Files

| File | Description |
|------|-------------|
| `Beginner - Parks_and_Rec_Create_db.sql` | Creates the practice database and tables (Parks and Recreation themed data) |
| `SELECT_Query.sql` | Basic `SELECT` statement examples |
| `Where Clause.sql` | Filtering data using the `WHERE` clause |
| `GROUP_BY.sql` | Grouping records and using aggregate functions (COUNT, SUM, etc.) |
| `ORDER_BY.sql` | Sorting query results using ORDER BY (ASC/DESC) |
| `Having.sql` | Filtering grouped data using HAVING |
| `Limit_Aliasing.sql` | Restricting result rows using LIMIT And Renaming columns/tables with aliases |
| `Join.sql` | Combining rows from multiple tables using INNER JOIN, Returning all rows from the left table with LEFT JOIN, Returning all rows from the right table with RIGHT JOIN, Joining a table to itself using SELF JOIN|
| `UNION.sql` | Combining results of multiple SELECT queries using UNION |
| `string_functions.sql` | Practicing LENGTH, UPPER, LOWER, TRIM, LTRIM, RTRIM, LEFT, RIGHT, SUBSTRING |
| `string_functions.sql` | Practicing REPLACE, LOCATE, and CONCAT |
| `Case_Statement.sql` | Writing conditional logic using CASE |
| `subquery.sql` | Practicing subqueries in WHERE, SELECT, and FROM clauses |
| `Window_Functions.sql` | Practicing OVER, PARTITION BY, running totals, ROW_NUMBER, RANK, DENSE_RANK |
| `CTE_Query.sql` | Practicing CTEs — aliasing, default naming, combining multiple CTEs |
| `Temporary_Table.sql` | Practicing creation and use of temporary tables |
| `Stored_Procedures.sql` | Practicing creation and calling of stored procedures |
| `Triggers_and_Events.sql` | Practicing creation of triggers (BEFORE/AFTER INSERT, UPDATE, DELETE) & Practicing creation of scheduled events |














## 🎯 Goals
- Build a solid foundation in SQL fundamentals
- Practice with real-world style datasets
- Track progress consistently, one topic at a time

## 🛠️ Tools
- MySQL

---
*More topics coming soon as the series continues!*