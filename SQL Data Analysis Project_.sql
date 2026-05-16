

-- EXPLORATORY DATA ANALYSIS PROJECT


select * from sales.Employees;

-- 1. How many unique customers do we have, and how are they distributed across different countries.--


SELECT Country, COUNT(CustomerID) AS TotalCustomers
FROM Sales.Customers
GROUP BY Country;


-- 2. List all products, their categories, and their prices. Order them from most expensive to least expensive.--

select
Product,
category,
price
from sales.products
order by price desc


-- 3.total quantity of items sold and the total revenue generated.--

select
SUM(quantity) as total_sales,
SUM(sales) as Total_revenue 
from sales.orders

-- 4. List all employees, their departments, and calculate their current age based on their BirthDate.--

select
FirstName,
LastName,
Department,
Birthdate,
datediff(year, (Birthdate), Getdate()) as current_age
from sales.employees


-- 5. Idenitfy Second highest salary among the Employees

Select
FirstName,
Salary
from sales.Employees
Order By salary desc
OFFSET 1 ROW
FETCH NEXT 1 ROW ONLY


SELECT
MAX(salary) as second_highest_salary
from sales.Employees
Where salary < (select MAX(salary) from sales.Employees);


-- 6. Which product category generates the most revenue.--

select
p.category,
SUM(o.sales) as revenue
from sales.orders o Left Join sales.products p ON o.ProductID = p.ProductID
Group by p.category


-- 7. Who are the top 3 employees based on the total sales amount they’ve handled? --

select
e.EmployeeID,
e.FirstName,
e.LastName,
SUM(o.Sales) as Total_Sales
from sales.Orders o JOIN sales.employees e ON 
o.SalesPersonID = e.EmployeeID
Group by EmployeeID, FirstName, LastName
Order by Total_Sales desc


-- 8. Identify customers who have placed more than 2 orders. Show their full name and the total amount they have spent.--

select
Count(o.OrderID) as Order_Count,
SUM(o.sales) as Total_amount_spent,
c.FirstName,
c.LastName
from sales.Orders o JOIN sales.Customers c ON o.CustomerID = c.CustomerID
Group by c.FirstName,
c.LastName
Having Count(o.OrderID) > 2;


--9. Calculate the average number of days it takes for an order to ship.--

select
Orderstatus,
AVG(datediff(day,OrderDate,ShipDate)) as Avgshippingtime
from sales.Orders
Group by Orderstatus


--10. Find all orders where the BillAddress is missing or empty. If it is NULL or Empty then replace it with the ShipAddress.--

select 
OrderID,
BillAddress as Original_Billaddress,
ShipAddress,
  CASE
    When BillAddress is Null or BillAddress = '' Then ShipAddress
    Else BillAddress
  END as UpdatedBillAddress
from sales.orders


--11. Display fullname of customers and replace nulls with empty strings.--


select 
    FirstName,
    COALESCE(LastName, '') as LastName, 
    FirstName + ' ' + COALESCE(LastName, '') as FullName
from Sales.Customers;


--12.Which orders are currently stuck in 'Shipped' status for more than 7 days.--


select
OrderID,
CustomerID,
OrderDate,
Shipdate,
Datediff(Day,Shipdate, Getdate() ) as DaysInTransist
from sales.Orders
where Orderstatus = 'Shipped' AND
Datediff(Day,shipdate, Getdate()) > 7;


-- 13. Analysing All orders with Total Sales and customers by Month Level --

select
Month(OrderDate) AS OrdersByMonth,
Year(OrderDate) AS OrdersByYear,
SUM(Sales) AS Total_Sales,
Count(Distinct CustomerID) as Total_Cutsomers
from sales.Orders
Group BY Month(OrderDate),
Year(OrderDate)
Order BY SUM(Sales) DESC;




 








