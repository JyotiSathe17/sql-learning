-- store procedures

create procedure large_salaries()
select *
from employee_salary
where salary >= 50000;

call large_salaries();

delimiter $$
create procedure large_salaries2()
begin 
select *
from employee_salary
where salary >= 50000;
select *
from employee_salary
where salary >= 10000;
end $$
delimiter ;

call large_salaries2();


-- calling employee salary by id

create procedure salaries_by_id(empl_id int)
select salary 
from employee_salary
where employee_id = empl_id;


call salaries_by_id(2);
