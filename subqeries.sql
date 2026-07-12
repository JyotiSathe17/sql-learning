-- subqueries

select *
from employee_demographics
where employee_id in
				(select employee_id
                from employee_salary
                where dept_id = 1
                )
;


select first_name, salary,
( select avg(salary)
from employee_salary)
from employee_salary
group by first_name, salary
;

select avg( `max(age)` )
from 
(select gender, avg(age), max(age), min(age), count(age)
from employee_demographics
group by gender) Agg_table
;


select avg(max_age)
from 
(select gender, 
avg(age),
 max(age) as max_age, 
 min(age) min_age, 
 count(age) count_age
from employee_demographics
group by gender) Agg_table
;
