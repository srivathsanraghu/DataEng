use TechNova

CREATE SCHEMA technova

SELECT * from [technova].[cleaned_employee]
SELECT * from [technova].[cleaned_manager]
SELECT * from [technova].[cleaned_office]


---- Q1

select COUNT(employee_id) from [technova].[cleaned_employee]

--- Q2

select department, count(employee_id) 'Count of employee' from [technova].[cleaned_employee]
GROUP BY department

--- Q3
select department, AVG(salary) 'Average salary' from [technova].[cleaned_employee]
GROUP BY department

---Q4
select top 1 department from [technova].[cleaned_employee]
GROUP BY department order by AVG(salary) DESC

--Q5

select top 5 employee_name,salary from [technova].[cleaned_employee]
ORDER BY salary DESC

-- Q6
select department, AVG(performance_rating) 'Average Rating' from [technova].[cleaned_employee]
GROUP BY department

-- Q7
select employee_name, performance_rating from [technova].[cleaned_employee]
where performance_rating > 4

--Q8
select employee_name,attendance from [technova].[cleaned_employee]
where attendance < 93

--Q9
select employee_name,overtime from [technova].[cleaned_employee]
where overtime > 30

--Q10
select employee_name,projects_completed from [technova].[cleaned_employee]
where projects_completed > 10

--Q11
select cm.manager_id, cm.manager_name, count(ce.employee_id) 'Reporting employee count' from [technova].[cleaned_employee] ce
JOIN [technova].[cleaned_manager] cm ON cm.manager_id = ce.manager_id
GROUP BY cm.manager_id,cm.manager_name

-- Q12
select TOP 1 cm.manager_name, count(ce.employee_id) 'Reporting employee count' from [technova].[cleaned_employee] ce
JOIN [technova].[cleaned_manager] cm ON cm.manager_id = ce.manager_id
GROUP BY cm.manager_name ORDER BY count(ce.employee_id) DESC

--Q13
select cm.manager_name, AVG(ce.salary) 'Average salary' from [technova].[cleaned_employee] ce
JOIN [technova].[cleaned_manager] cm ON cm.manager_id = ce.manager_id
GROUP BY cm.manager_name 

--Q14
select TOP 1 cm.manager_name, AVG(ce.performance_rating) 'Average performance rating' 
from [technova].[cleaned_employee] ce
JOIN [technova].[cleaned_manager] cm ON cm.manager_id = ce.manager_id
GROUP BY cm.manager_name ORDER BY AVG(ce.performance_rating) DESC

--Q15
SELECT cm.manager_name, ce.department, count(ce.employee_id) 'Employee count',
AVG(ce.salary) 'Average salary',
AVG(ce.performance_rating) 'Average performance rating',
AVG(ce.attendance) 'Average attendance'
from [technova].[cleaned_employee] ce
JOIN [technova].[cleaned_manager] cm ON cm.manager_id = ce.manager_id
GROUP BY cm.manager_name, ce.department

--Q16
select co.office_name, count(ce.employee_id) 'employee count' from [technova].[cleaned_employee] ce
JOIN [technova].[cleaned_office] co ON co.office_id = ce.office_id
GROUP BY co.office_name

--Q17

select top 1 co.city, count(ce.employee_id) 'employee_count' from [technova].[cleaned_employee] ce
JOIN [technova].[cleaned_office] co ON co.office_id = ce.office_id
GROUP BY co.city ORDER BY employee_count DESC

--Q18
select co.office_name, AVG(ce.salary) 'Average_salary' from [technova].[cleaned_employee] ce
JOIN [technova].[cleaned_office] co ON co.office_id = ce.office_id
GROUP BY co.office_name

--Q19
select TOP 1 co.office_name, AVG(ce.performance_rating) 'Average_performance_rating' from [technova].[cleaned_employee] ce
JOIN [technova].[cleaned_office] co ON co.office_id = ce.office_id
GROUP BY co.office_name ORDER BY AVG(ce.performance_rating) DESC

--Q20
SELECT co.office_name, co.city, count(ce.employee_id) 'employee_count',
AVG(ce.salary) 'Average_salary',
AVG(ce.performance_rating) 'Average_performance_rating',
AVG(ce.attendance) 'Average_attendance'
FROM [technova].[cleaned_employee] ce JOIN
[technova].[cleaned_office] co
ON ce.office_id = co.office_id
GROUP BY co.office_name, co.city


--Q21

with rank_sal as (
    SELECT department,employee_name,salary,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) 'Salary_rank'
    from [technova].[cleaned_employee]
)
select * from rank_sal

--Q22
with rank_sal as (
    SELECT department,employee_name,salary,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) 'Salary_rank'
    from [technova].[cleaned_employee]
)
select * from rank_sal where Salary_rank = 1

--Q23
with highsal as (
    SELECT employee_name,salary,department,
    AVG(salary) over (partition by department) 'averagesalary' FROM [technova].[cleaned_employee]
)
select * from highsal where salary > averagesalary

--Q24
select employee_name,department FROM [technova].[cleaned_employee]
where performance_rating>=4 AND attendance<93

--Q25
select employee_name,department FROM [technova].[cleaned_employee]
where overtime>30 AND performance_rating<4

--Q26
select employee_name,department  FROM [technova].[cleaned_employee]
where performance_rating >= 4.5 AND years_experience>=5 AND attendance>=95

--Q27
select employee_name,department  FROM [technova].[cleaned_employee]
where salary > (select AVG(salary) from [technova].[cleaned_employee]) 
AND performance_rating >= 4
AND projects_completed > (select AVG(projects_completed) from [technova].[cleaned_employee])

--Q28
select department, count(*) 'employee_count', AVG(salary) 'Average_salary',
MIN(salary) 'Minimum_salary', MAX(salary) 'Maximul_salary',
AVG(performance_rating) 'Average_performance', 
AVG(attendance) 'Average_attendance',
AVG(overtime) 'Average_overtime' from [technova].[cleaned_employee]
GROUP BY department

--Q29

select gender, count(*) 'Employee_count', AVG(salary) 'Average_salary',
AVG(performance_rating) 'Average_performance', 
AVG(attendance) 'Average_attendance'
from [technova].[cleaned_employee]
GROUP BY gender

--Q30
with exp_band as (
SELECT
        employee_name,
        salary,
        years_experience,
        CASE 
            WHEN years_experience >= 0 AND years_experience <= 3 THEN '0–3 years'
            WHEN years_experience >= 4 AND years_experience <= 7 THEN '4–7 years'
            WHEN years_experience >= 8 AND years_experience <= 12 THEN '8–12 years'
            WHEN years_experience >= 13 THEN '13+ years'
            END AS [Experience_Band]
    FROM [technova].[cleaned_employee]
) select Experience_Band, count(*) 'Employee_count',AVG(salary) 'Average_salary' from exp_band
GROUP BY Experience_Band



--Q12

WITH manager_count AS
(
    SELECT
        cm.manager_id,
        cm.manager_name,
        COUNT(ce.employee_id) AS reporting_employee_count
    FROM [technova].[cleaned_employee] AS ce
    JOIN [technova].[cleaned_manager] AS cm
        ON ce.manager_id = cm.manager_id
    GROUP BY
        cm.manager_id,
        cm.manager_name
),
manager_rank AS
(
    SELECT *,
        DENSE_RANK() OVER (
            ORDER BY reporting_employee_count DESC
        ) AS team_rank
    FROM manager_count
)
SELECT
    manager_id,
    manager_name,
    reporting_employee_count
FROM manager_rank
WHERE team_rank = 2;


--Q14

with highavgperformance as (
   select cm.manager_id, cm.manager_name, AVG(ce.performance_rating) 'Average_performance'
       FROM [technova].[cleaned_employee] AS ce
    JOIN [technova].[cleaned_manager] AS cm
        ON ce.manager_id = cm.manager_id
    GROUP BY
        cm.manager_id,
        cm.manager_name
), perform_rank as (
    select *,
    DENSE_RANK() OVER (order by Average_performance DESC) 'rank'
    from highavgperformance
) select * from perform_rank
where rank=1