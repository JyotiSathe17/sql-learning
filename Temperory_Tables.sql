-- temperory table
-- it is gonna work in new window but not after closing the session

create temporary table temp_table
(first_name varchar(50),
last_name varchar(50),
fav_movie varchar(50)
);

select *
FROM temp_table;

insert into temp_table
values ('jyoti', 'sathe', 'ye jawani hai deewani');


select *
from employee_demographics;

create temporary table salary_over_50k

select * 
from employee_salary
where salary >= 50000;

select *
from salary_over_50k;



