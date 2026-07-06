/* ORDER BY 
BY default it order by ASC order */

SELECT * 
FROM employee_demographics
order by age DESC
;

/* we need to concern about wich col comes first
 Notice difference between both the queries below */

-- we use gender first then age 
SELECT * 
FROM employee_demographics
order by gender,age
;

-- we use age first
SELECT * 
FROM employee_demographics
order by age, gender
;

-- we can represent it with col number also
SELECT * 
FROM employee_demographics
order by 5,4
;