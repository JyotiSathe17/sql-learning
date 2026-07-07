-- having 

-- diff bet where and having
/*having is used after group by for filtering with aggregate functions alter
we cannot use where clause with aggregate function*/

select gender, avg(age)
from employee_demographics
group by gender
having avg(age) > 34
;

select occupation, avg(salary)
from employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary) >40000
;