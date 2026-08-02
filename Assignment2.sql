----- AdventureWorksLT SQL Weekend Assignment
Instructions: Use only the SalesLT schema. Write SQL queries for the following questions. Do not
include answers.

---Question 1
---Display Category Name, Number of Products, Average List Price, Minimum List Price and
---Maximum List Price for each product category. Consider only products with ListPrice > 500. Display
---only categories having at least 3 such products. Sort by Average List Price descending.

use AdventureWorksLT2019

select * from [SalesLT].[Customer]
select * from [SalesLT].[CustomerAddress]
select * from [SalesLT].[Address]
select * from [SalesLT].[SalesOrderDetail]
select * from [SalesLT].[SalesOrderHeader]
select * from SalesLT.Product
select * from SalesLT.ProductCategory


select pc.name, count(p.productid) as NumberOfProducts, avg(p.ListPrice) as AverageListPrice, 
min(p.ListPrice) as MinimumListPrice, max(p.ListPrice) as MaximumListPrice from SalesLT.ProductCategory pc
join SalesLT.Product p on pc.productcategoryid = p.productcategoryid
where p.ListPrice > 500
group by pc.name
having count(p.productid) >= 3
order by avg(p.ListPrice) desc

---Question 2
---Display Customer ID, Customer Name, Number of Orders, Total Order Amount and Average Order
---Amount. Consider only orders where TotalDue > 1000. Display only customers with at least 2 such
---orders. Sort by Total Order Amount descending.

select C.customerId, ISNULL(C.FirstName, '') + ' ' + ISNULL(C.MiddleName, '') + ' ' 
+ ISNULL(C.LastName, '') + ' ' AS 'customerName', COUNT(SOH.SalesOrderID) 'NoofOrder',
SUM(SOH.TotalDue) 'TotalOrderAmount', AVG(SOH.TotalDue) 'AvgOrderAmount'
FROM [SalesLT].[Customer] C JOIN [SalesLT].[SalesOrderHeader] SOH
ON c.customerId = SOH.customerId
where SOH.TotalDue>1000 GROUP BY C.customerId,c.FirstName, C.middleName, c.LastName
HAVING COUNT(C.customerId)>=2
ORDER BY TotalOrderAmount DESC

---Question 3
---Display Product ID, Product Name, Product Number and List Price for products whose ListPrice is
---greater than the average ListPrice of all products. Use a single-row subquery.

select productid, name,productNumber,listprice from saleslt.product
where listprice > (select avg(listprice) from saleslt.product)

---Question 4
---Display Customer ID, Customer Name, Number of Orders and Total Amount Spent for customers
---whose total spending is greater than the average customer spending. Use a subquery.

select c.customerid, ISNULL(c.FirstName, '')  + ' ' + ISNULL(C.middleName, '') + ' ' + ISNULL(c.LastName, '') as CustomerName, 
count(s.salesorderid) as numberoforders, sum(s.totaldue) as totalamountspent 
from [SalesLT].[Customer] c JOIN [SalesLT].[SalesOrderHeader] s on c.customerid = s.customerid 
group by c.customerid, c.FirstName, C.middleName, c.LastName 
Having sum(s.totaldue) > (select AVG(sumoftotaldue) from 
(select customerId,SUM(totaldue) 'sumoftotaldue' from [SalesLT].[SalesOrderHeader] group by customerID)
 AS CustomerTotals ) 


---Question 5
---Using a CTE, calculate Total Quantity Sold, Number of Order Lines and Total Sales Value for each
---product. Display only products with Total Quantity Sold > 20 and Total Sales Value > 5000. Sort by
---total Sales Value descending.

with product_sales as (
    select sum(orderQty) 'Totalqualitysold', count(salesorderid) 'NumberofOrderLines', sum(linetotal) 'TotalSalesValue', 
    productid from saleslt.salesorderdetail
    group by productid
    )
    select * from product_sales
    where totalqualitysold > 20 AND  TotalSalesValue > 5000
    order by TotalSalesValue desc



---Question 6
---Using a CTE, calculate Total Sales Value for each product category. Display only categories whose
---Total Sales Value is greater than the average category sales. Also display Number of Distinct
---Products Sold and Total Quantity Sold.

with product_sales as (
    select p.productcategoryid, SUM(sod.linetotal) 'TotalSalesValue',count(DISTINCT sod.ProductID) 'noofproductsold',
    SUM(sod.orderqty) 'TotalQTYsold' from saleslt.salesorderdetail sod JOIN [SalesLT].[Product] p
    on sod.productid = p.productid
    Group by p.productcategoryid
)
 select pc.Name ,TotalSalesValue,noofproductsold,TotalQTYsold from product_sales ps 
 JOIN [SalesLT].[ProductCategory] pc
 on ps.ProductCategoryID=pc.[ProductCategoryID]
 where TotalSalesValue > (select AVG(TotalSalesValue) from product_sales)
 order by totalsalesvalue desc


---Question 7
---Calculate Total Spending for each customer and assign ROW_NUMBER(), RANK() and
---DENSE_RANK() based on Total Spending in descending order. Use a CTE.

with customerspend as (
    select customerid, SUM(totaldue) 'totalspend',
    ROW_NUMBER() OVER (order by SUM(totaldue) DESC) 'RowNumber',
    RANK() OVER (order by SUM(totaldue) DESC) 'Rank' ,
    DENSE_RANK() OVER (order by SUM(totaldue) DESC) 'Denserank' from [SalesLT].[SalesOrderHeader]
    group by customerid
)
select * from customerspend order by RowNumber


---Question 8
---Rank products within each category based on ListPrice using DENSE_RANK(). Display only the top
---3 price ranks from each category. Use a CTE.

with productcat as (
    select pc.[Name] 'productcategoryname',p.listprice,
    DENSE_RANK() OVER (partition BY pc.[Name] ORDER BY p.listprice DESC) 'DenseRank'
    from [SalesLT].[Product] p JOIN [SalesLT].[ProductCategory] pc
    ON p.[ProductCategoryID] = pc.[ProductCategoryID]
)
select * from productcat where DenseRank<=3

select listprice from [SalesLT].[Product] p JOIN [SalesLT].[ProductCategory] pc
    ON p.[ProductCategoryID] = pc.[ProductCategoryID] where pc.name='Handlebars'
    order by listprice


---Question 9
---Find the highest-value order for each customer using ROW_NUMBER(). Partition by Customer and
---order by TotalDue descending. If two orders have the same TotalDue, consider the latest
---OrderDate.

with highvaluecus AS (
    select customerId, totaldue, orderdate,
    ROW_NUMBER() 
    OVER (partition by customerId order by totaldue desc, orderdate DESC) 'rownumber'
    from [SalesLT].[SalesOrderHeader]
)
select * from highvaluecus where rownumber=1


---Question 10
---Prepare a sales performance report for each product category showing 
---Number of Orders, 
---Number of Products Sold, 
---Total Quantity Sold, 
---Total Sales Value, 
---Average Sales Per Order and 
---Sales Rank.
---Consider only orders where TotalDue > 1000. Display only categories whose Total Sales Value is
---greater than the average category sales. Use CTEs, a subquery and DENSE_RANK().

--- productcategory, salesorderheader,product,

took help of chatGPT for a concept understanding

with salesreport AS (
    select p.[ProductCategoryID],COUNT(DISTINCT soh.SalesOrderID) 'nooforders', 
    COUNT(DISTINCT sod.productId) 'noofproductsold',
    SUM(sod.OrderQty) 'totalQYT', SUM(sod.linetotal) 'totalsalesvalue', 
    SUM(sod.linetotal)/COUNT(DISTINCT soh.SalesOrderID) 'Averagesale',
    DENSE_RANK() OVER (order by SUM(sod.linetotal) DESC) 'denserank' 
    from [SalesLT].[SalesOrderDetail] sod 
    JOIN [SalesLT].[SalesOrderHeader] soh on soh.[SalesOrderID] = sod.[SalesOrderID]
    JOIN [SalesLT].[Product] p ON p.productID = sod.productid
    where totaldue>1000
    group by p.[ProductCategoryID]
)
select pc.[Name] 'productcategoryname',* from salesreport sr JOIN [SalesLT].[ProductCategory] pc 
on sr.ProductCategoryID = pc.[ProductCategoryID]
where totalsales>(select AVG(totalsales) from salesreport)

select * from salesreport

select * from [SalesLT].[SalesOrderHeader]
select * from [SalesLT].[SalesOrderDetail]
select * from [SalesLT].[Customer]
select * from [SalesLT].[CustomerAddress]
select * from [SalesLT].[Address]
select * from [SalesLT].[SalesOrderDetail]
select * from [SalesLT].[SalesOrderHeader]
select * from SalesLT.Product
select * from SalesLT.ProductCategory

select [SalesOrderID], AVG(linetotal) from [SalesLT].[SalesOrderDetail]
group by SalesOrderID