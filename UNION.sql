-- UNION: multiple select statement, combine rows froms diff tables
-- by default it returns all unique value it has by default distinct

select first_name, last_name
from employee_demographics
union distinct
select first_name,last_name
from employee_salary
;


-- if we want all data we can use all

select first_name, last_name
from employee_demographics
union all
select first_name,last_name
from employee_salary
;

select first_name, last_name, 'old man' as label
from employee_demographics
where age > 50 AND gender = 'male'
union
select first_name, last_name, 'old lady' as label
from employee_demographics
where age > 40 AND gender = 'female'
union 
select first_name,last_name, 'highest salary' as label
from employee_salary
where salary > 70000
order by first_name
;


