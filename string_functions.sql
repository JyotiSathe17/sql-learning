-- STRING FUNCTIONS

-- LENGTH
select length('skyfall');

select first_name, length(first_name) as length
from employee_demographics
order by 2
;

-- UPPER CASE & LOWE CASE

SELECT upper('sky');
select lower('SKY');

select first_name, upper(first_name) as upper_case
from employee_demographics
;

select first_name, lower(first_name) as lower_case
from employee_demographics
;


-- TRIM : LTRIM, RTRIM (removes white spaces)

select trim('  sky        ');
select rtrim('                                   sky                                          ') as rtrim;
select ltrim('                       sky                           ') as ltrim;

-- left,right
select first_name, right(first_name, 4) as right_4,
left(first_name, 4) as left_4
from employee_demographics
;

-- substring
select first_name, substring(first_name, 4,3)
from employee_demographics
;

select birth_date, substring(birth_date, 6,2) as month
from employee_demographics
;





