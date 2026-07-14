-- window fuction

-- check results of both to see difference hy we use window function
-- if we group it with multiple col it will not give use avg_sal
select dem.first_name, dem.last_name, avg(salary) as avg_salary
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by dem.first_name, dem.last_name,gender;


-- it will give us avg_sal even if we want to retrive or group more than one col because over is completely independent for avg_age
select dem.first_name, dem.last_name, gender, avg(salary) over(partition by gender) avg_sal
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
;


-- rolling total
select dem.first_name, dem.last_name, gender, salary,
sum(salary) over(partition by gender order by dem.employee_id) rolling_total
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
;

-- row_number
select dem.first_name, dem.last_name, gender, salary,
row_number() over(partition by gender order by salary) as row_num,
rank() over(partition by gender order by salary desc) as rank_num,
dense_rank() over(partition by gender order by salary desc) as rank_num
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
;
