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











## 🎯 Goals
- Build a solid foundation in SQL fundamentals
- Practice with real-world style datasets
- Track progress consistently, one topic at a time

## 🛠️ Tools
- MySQL

---
*More topics coming soon as the series continues!*