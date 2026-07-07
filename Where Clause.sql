#where clause with comparision operator, logical operator & like(% ,_)
#Simple where clause
select *
from employee_demographics
where first_name = 'Leslie'
;


#---AND OR NOT----
select *
from employee_demographics
where (first_name = 'Leslie' AND age > 40) OR (first_name = 'tom' AND age < 30)
;


#where with comparision operator
select *
from employee_demographics
where age > 50
;

#Like (%,_)
select *
from employee_demographics
where (first_name Like 'les%' or gender like '_e%') and  birth_date like '%25'
;