-- data cleaning

select *
from layoffs ;

-- 1. Remove Duplicates
-- 2. Standerize the Data
-- 3. Null Valaues
-- 4. Remove Any Columns


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

