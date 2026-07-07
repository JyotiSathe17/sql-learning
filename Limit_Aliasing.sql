-- Limit and aliasing

select * 
from employee_demographics
limit 4
;

select * 
from employee_demographics
order by age desc
limit 2,2
;

-- Aliasing
-- to change column name we can use it by default ,as,(as)

select gender , avg(age) as avg_age 
from employee_demographics
group by gender
having avg_age > 40

