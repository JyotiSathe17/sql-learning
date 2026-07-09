-- joins

select * 
from employee_demographics;

select *
from employee_salary;


-- Inner Join: retrive common data from both table
select * 
from employee_demographics as dem
Inner Join employee_salary as sal
 on dem.employee_id = sal.employee_id
;

-- performing inner join on specific colums
select sal.employee_id,age,occupation
from employee_demographics as dem
Inner Join employee_salary as sal
 on dem.employee_id = sal.employee_id
;


-- outer join
/* Left outer join- it retrives all the info from left table and matches it with right table
right outer join- it retrives all the info from right table and matches with left */

select * 
from employee_demographics as dem
right Join employee_salary as sal
 on dem.employee_id = sal.employee_id
;

select * 
from employee_demographics as dem
left Join employee_salary as sal
 on dem.employee_id = sal.employee_id
;


-- self join- join same table

select *
from employee_salary emp1
join employee_salary emp2
 on emp1.employee_id + 1=emp2.employee_id
;

select emp1.employee_id as emp_santa,
emp1.first_name as first_name_santa,
emp1.last_name as last_name_santa,
emp2.employee_id as emp_name,
emp2.first_name as first_name_emp,
emp2.last_name as last_name_emp
from employee_salary emp1
Join employee_salary emp2
 on emp1.employee_id + 1 = emp2.employee_id
;


-- joining multiple table

select *
from employee_demographics dem
inner join employee_salary sal
 on dem.employee_id = sal.employee_id
inner join parks_departments pd
 on sal.dept_id = pd.department_id
 ;



