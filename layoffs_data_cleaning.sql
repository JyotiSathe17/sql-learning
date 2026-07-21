-- data cleaning

select *
from layoffs ;

-- 1. Remove Duplicates
-- 2. Standerize the Data
-- 3. Null Valaues and ('') blank values
-- 4. Remove Any Columns or rows


-- 1. Remove Duplicates

-- Step 1: Create a staging table

create table layoffs_staging
like layoffs ;

-- 1.1: checking if staging table is created or not
select *
from layoffs_staging ;

-- 1.2: inserting values in staging table
insert into layoffs_staging
select *
from layoffs ;

-- 1.3: checking values are inserted or not
select *
from layoffs_staging ;


-- step 2: Create another staging table with row_num

create table layoffs_staging2 as
select *,
row_number() over(
partition by company, location, industry
, total_laid_off, percentage_laid_off, `date`
, stage, country, funds_raised_millions
) as row_num
from layoffs_staging ;

-- 2.1: checking layoffs_staging2
select *
from layoffs_staging2 ;


-- Step 3: Check duplicate rows

select *
from layoffs_staging2
where row_num > 1 ;

-- Step 4: Delete duplicate rows
set sql_safe_updates = 0 ;

delete
from layoffs_staging2
where row_num > 1 ;

set sql_safe_updates = 1 ;


-- Step 5: Verify duplicates are removed

select *
from layoffs_staging2
where row_num > 1 ;

-- Step 6: getting table with no duplicates

select *
from layoffs_staging2 ;


-- we can perform it by using CTEs : we need to create another table because mysql dont allow to delete from CTEs
CREATE TABLE `layoffs_staging3` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num1` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoffs_staging3 ;

insert into layoffs_staging3
select *,
row_number() over(
partition by company, location, industry
, total_laid_off, percentage_laid_off, `date`
, stage, country, funds_raised_millions
) as row_num1
from layoffs_staging ;

select *
from layoffs_staging3 
where row_num1 > 1 ;

set sql_safe_updates = 0 ;

delete 
from layoffs_staging3 
where row_num1 > 1 ;

set sql_safe_updates = 1 ;

select *
from layoffs_staging3 ;


-- 2: Standerize Data

select company, trim(company)
from layoffs_staging2 ;

update layoffs_staging2
set company = trim(company) ;


select distinct industry
from layoffs_staging2 
order by 1;

select *
from layoffs_staging2
where industry like 'crypto%' ;

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%' ;

select *
from layoffs_staging2 
where country like 'United States%' ;

update layoffs_staging2
set country = 'United States'
where country like 'United States%' ;

-- or we can do 
select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1 ;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%' ;

select *
from layoffs_staging2 ;

-- converting `date` from text to date
-- format for date:'%m/%d/%Y' remember capital and small letters

select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2 ;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y') ;

select `date`
from layoffs_staging2 ;

-- changing data type 
alter table layoffs_staging2
modify column `date` date ;



-- 3. Null Valaues and ('') blank values

select *
from layoffs_staging2 
where industry is null
or industry = '' ;

select *
from layoffs_staging2 
where company like 'bally%' ;


select t1.company, t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company 
where (t1.industry is null or t1.industry = '' )
and t2.industry is not null ;

update layoffs_staging2
set industry = null
where industry = '' ;

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company 
set t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null ;


select *
from layoffs_staging2 
where total_laid_off is null
and  percentage_laid_off is null ;

delete 
from layoffs_staging2 
where total_laid_off is null
and  percentage_laid_off is null ;


-- 4. remove column or row

alter table layoffs_staging2
drop column row_num ;



