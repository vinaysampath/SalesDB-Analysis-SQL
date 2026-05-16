

--SELECT * INTO SalesDB.Sales.OrdersArchive2 
 -- FROM SalesDB.Sales.OrdersArchive;



 
-- DATA CLEANING --


-- Identifying the Duplicate rows

WITH duplicaes_cte AS
(
select OrderID, CreationTime,
ROW_NUMBER() OVER (Partition BY OrderID ORDER BY ProductID ) AS Row_Num
from sales.OrdersArchive2
)
Select * from duplicaes_cte
where Row_Num > 1


-- Removing duplicate rows

WITH duplicaes_cte AS
(
select OrderID, CreationTime,
ROW_NUMBER() OVER (Partition BY OrderID ORDER BY ProductID ) AS Row_Num
from sales.OrdersArchive2
)
DELETE from duplicaes_cte
where Row_Num > 1


-- IDENTIFYING AND MODIFYING NULL AND EMPTY ROWS


select * from sales.OrdersArchive2


select Billaddress, shipaddress
from sales.OrdersArchive2
where Billaddress IS NULL OR
      Billaddress = '' OR
      ShipAddress IS NULL OR
      ShipAddress = '';


Update Sales.OrdersArchive2
SET BillAddress = COALESCE (BillAddress, ShipAddress, 'No data provided')
Where BillAddress IS Null;


Update Sales.OrdersArchive2
SET BillAddress = COALESCE (NullIF (BillAddress, ''), ShipAddress)
Where BillAddress IS Null OR BillAddress = ''; 




