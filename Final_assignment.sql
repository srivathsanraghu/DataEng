
1. where is used to filter a row wise before group by. we cannot use functions level filter in where condition
eg, salary > AVG(salary) but reverse will work
 having is used to filter a data group wise after grouping the data.

 2. Delete -> its DML type. used to delete a record from a table with or without where condition. execution time is high
 TRUNCATE -> its DDL, used to delete a entire record and keep table struction remins same.
 DROP -> its DDL, used to delete a table and its structure. execution time is faster

 3.Primary Key -> uniquely identifies each row in a table and does not allow NULL values.
Foreign Key ->  creates a relationship between tables by referencing a key in another table.


4. INNER JOIN -> it will join matching records in both a table beased on a common key. it will ignore the non matching records
eg. if any student doesnot have department, then that record will be irnored.

LEFT JOIN -> it will display all the rows in left table and show matching records from the right table.
if there is no matching value for left table, then it will be shown as null.
eg.
student 1 -> IT
student 2 -> null (where this student sont have department)

5. A subquery is a sql query or statement which is used inside the condition of query
eg, select * from employee where id = (SUBQUERY).

A query which is dependent on another query is called subquery.
it is used to find the common value using function eg, AVG(), SUM(), MIN(), MAX()
bcoz the aggeregative function calculation will not be able to do in where condition.

6. A CTE is a table which is used while execution and its a virtual table which will not be stored in DB.
it is used to make the complex query easier.

7. ROW number -> rownumber function will add a unique number for each record or inside the group. row number will not have duplicates 
Rank -> rank is used to calculate the rank based on a value within a column. it will have duplicate if the 
results are similer. it contains gap between a ranks if one or more record contains same result.
100 ->1
100 ->1
101->3
dense rank -> dense rank is used to calculate the rank based on a value within a column. it will have duplicate if the 
results are similer. it doesnot contains gap between a ranks if one or more record contains same result.
100 ->1
100 ->1
101->2

8. clustered index -> organise a table and used to retrieve fast (performance improve).
only one clustered index in a table
non cluesterd index -> additional index that contains indexed key values and references

9. Views -> its a virtual table used to view a selective column in a table by creative view.
used for security and data redundancy

use case -> an powerbi developer wants to view only certain information of sale.
eg:
create view tablename(
    select salesid, totalpaid, customrename from tables
)
here we can avoid seeing the extra info like ship details,GST,category..etc.,

Stored Procedures -> its a collection of sql statement used to manipulate a table by doing certain operations like insert,update 
we can pass the parameter here.
we have to call this explicitely 

use case:
displaying a subscriber count in many places, we can use stored procedure. so that the sql statement cannot be written in multiple places


Functions -> it is used for calculative purpose, like GST calculation or age calculation.
we can call the function in any places so that the calculation remins same

Triggers -> used for a task depends on another task.
doing a task like insert,update or delete, after an certain operations performed on DB/table
no need to call explicitely.

eg, audit book -> list of operations that audits on another table


10. avoid select * (select only wanted columns instead of all which will cost the CPM, memory and exec time)
filter early
avoid order by
avoid functions on index columns
use top for testing 
use index
correct data type
use exist 
proper joins
avoid distinct




----------------------------------------------------------------------

select * from [dbo].[Departments]
select * from [dbo].[Employee_Details]
select DISTINCT department from [dbo].[Employee_Details]
select * from [dbo].[Departments]

use assignment1

1. ------------

select ed.name,dt.deptname from [dbo].[Employee_Details] ed 
left join [dbo].[Departments] dt on ed.department=dt.deptname

2. ------------

with rank as (
select name, department,salary,
dense_rank() over (partition by department order by salary desc) 'dense_rank' from [dbo].[Employee_Details]
)
select department,* from rank
where dense_rank <= 3

3.--------
select department, AVG(salary) 'Average salary' from [dbo].[Employee_Details]
group by department having AVG(salary)>60000

4. ------

with average as (
    select department, AVG(salary) 'average' from [dbo].[Employee_Details]
    group by department
)
select name,salary,ed.department from [dbo].[Employee_Details] ed join
average a on ed.department=a.department
where ed.salary > a.average

5. ------

select Max(salary) from [dbo].[Employee_Details]
where salary < (select max(salary) from [dbo].[Employee_Details])

6.------
with duplicate as (
    select *, row_number() over (partition by name,joindate order by empId) 'rownumber' from [dbo].[Employee_Details]
)
delete from duplicate where rownumber>1

7.----
with dept_sal as (
    select department, SUM(salary) 'total_salary' from [dbo].[Employee_Details]
    group by department
)
select * from dept_sal where total_salary > 300000

8.---------
use [AdventureWorksLT2019]

select CONCAT(firstname + ' ',middlename +  ' ', lastname + ' ') 'customername',
sum(soh.totaldue) 'Total order value' from [SalesLT].[SalesOrderHeader] soh 
join [SalesLT].[Customer] c on soh.customerid=c.customerid
group by c.customerid,CONCAT(firstname + ' ',middlename +  ' ', lastname + ' ')
having count(DISTINCT soh.salesorderid) > 3

9.-------

use assignment1

create procedure empdept 
        @deptid int
    AS
    BEGIN

        select emp.Name,salary from [dbo].[Employee_Details] emp join
        [dbo].[Departments] dpt on emp.department = dpt.deptname
        where deptid=@deptid
        order by salary

    end

    exec empdept @deptid=30

10.-------

    select * from dbo.employee_details

    create table employee_audit (
        empid INT,
        actionemp varchar(50),
        action_date date
    )

CREATE TRIGGER trigger_name
ON [dbo].[Employee_Details]
AFTER INSERT
AS
BEGIN

 INSERT INTO employee_audit
    (
        empid,actionemp,action_date
    )
    SELECT
        empid,'Employee inserted',GETDATE()
    FROM inserted;
   
END

select * from employee_audit

insert into [dbo].[Employee_Details] values 
(201,'srivathsan','Finance',49000,33,'chennai',5,5500,'2021-09-14')


-----------------------

additional

create function dbo.CalculateGST
(
    @amt INT
)
Returns INT

AS
BEGIN
Return @amt*0.18
End

ALTER FUNCTION dbo.CalculateGST
(
    @amt INT
)
RETURNS INT
AS
BEGIN
    RETURN @amt * 0.18;
END;

select dbo.CalculateGST(5000) AS GST

create view empview
AS
select Name,salary from [dbo].[Employee_Details]

select * from empview
