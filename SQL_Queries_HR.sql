-- Calling data to see if correctly imported
select *
from hrdata;


-- Obtaining the employee count

SELECT sum(employee_count) AS Employee_Count
FROM hrdata;
--WHERE education = 'High School';


-- Obtaining the attrition count

SELECT count(attrition) AS Attrition
FROM hrdata
where attrition = 'Yes';


-- Calculation the attrition rate 

select round 
	(((select count(attrition) 
	   from hrdata 
	   where attrition='Yes')/ sum(employee_count)) * 100,2)
from hrdata;


-- Active employees

select sum(employee_count) - 
	(select count(attrition) from hrdata  where attrition='Yes') 
from hrdata;
--where attrition='Yes';


-- Average Age

select round(avg(age),0) 
from hrdata;


-- Attrition by gender

select gender, count(attrition) as attrition_count from hrdata
where attrition='Yes'
group by gender
order by count(attrition) desc;


-- Department wide Attrition 

select department, count(attrition), round((cast (count(attrition) as numeric) / 
(select count(attrition) from hrdata where attrition= 'Yes')) * 100, 2) as pct from hrdata
where attrition='Yes'
group by department 
order by count(attrition) desc;

-- No of employees by age group 

SELECT age,  sum(employee_count) AS employee_count 
FROM hrdata
GROUP BY age
order by age;


-- Education field wide attrition 

select education_field, count(attrition) as attrition_count 
from hrdata
where attrition='Yes'
group by education_field
order by count(attrition) desc;

-- Attrition by gender for different age groups

select age_band, gender, count(attrition) as attrition, 
round((cast(count(attrition) as numeric) / (select count(attrition) from hrdata where attrition = 'Yes')) * 100,2) as pct
from hrdata
where attrition = 'Yes'
group by age_band, gender
order by age_band, gender desc;


-- Job satisfaction  rating 

CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT *
FROM crosstab(
  'SELECT job_role, job_satisfaction, sum(employee_count)
   FROM hrdata
   GROUP BY job_role, job_satisfaction
   ORDER BY job_role, job_satisfaction'
	) AS ct(job_role varchar(50), one numeric, two numeric, three numeric, four numeric)
ORDER BY job_role;




