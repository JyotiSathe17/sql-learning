-- group by clause

SELECT gender
FROM employee_demographics
group by gender
;

-- group by with aggregate functions 
SELECT gender ,AVG(age), min(age), max(age),count(age)
FROM employee_demographics
group by gender
;

SELECT occupation, salary
FROM employee_salary
group by occupation, salary
;

