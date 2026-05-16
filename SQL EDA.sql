use salesdb;

-- query for Exploring ALL the Tables content

select * from INFORMATION_SCHEMA.TABLES;

-- query for Exploring ALL the Coulmns in all tables

select * from INFORMATION_SCHEMA.COLUMNS;

-- query for checking columns in specific table

select * from INFORMATION_SCHEMA.columns
where Table_name = 'Orders';