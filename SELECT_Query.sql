SELECT * 
FROM parks_and_recreation.employee_demographics;

SELECT * 
FROM employee_demographics;

SELECT first_name,last_name,age
FROM employee_demographics;

SELECT first_name,
last_name,
age,
(age + 10) * 10 - 10
FROM employee_demographics;

SELECT distinct gender
FROM employee_demographics;
