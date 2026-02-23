create database sales_dashboard;

use sales_dashboard;

create table Customers(
	CustomerID int primary key,
    CustomerName varchar(100),
    Segment varchar(50),
    City varchar(50),
    State varchar(50),
    Region varchar(50)
);

create table Products (
	ProductID int primary key,
    ProductName varchar(100),
    Category varchar(50),
    SubCategory varchar(50),
    Cost DECIMAL(10,2),
    Price DECIMAL(10,2)
);

create table Orders (
	OrderID int primary key,
    OrderDate Date,
    CustomerID int,
    ProductID int,
    Quantity int,
    Sales Decimal(10,2),
    Profit Decimal(10,2),
    Foreign key (CustomerID) REFERENCES Customers(CustomerID),
    Foreign key (ProductID) REFERENCES Products(ProductID)
);

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM orders;

#total sales and profit
SELECT
	round(SUM(Sales),2) AS Total_sales,
    round(SUM(Profit),2) AS Total_Profit
from OrderS;

# Monthly Revenue Trend
select
	year(OrderDate) as Year,
    month(OrderDate) as Month,
    round(sum(Sales),2) as Total_Sales
from Orders
group by Year, Month
Order by Year, Month;

# Top 10 Product by sales
select
	c.CustomerName,
    ROUND(SUM(o.Sales),2) as Total_Sales
from Orders o
Join Customers c
on o.CustomerID = C.CustomerID
group by c.CustomerName
Order by Total_Sales desc
LIMIT 10;

# Top 10 Customers
select
	c.CustomerName,
    ROUND(Sum(o.Sales),2) as Total_Sales
from Orders o
JOIN Customers c
on o.CustomerID = c.CustomerID
group by c.CustomerName
Order by Total_sales desc
limit 10;

# Region wise sales
select
	c.Region,
    ROUND(SUM(o.sales),2) as Total_Sales
from Orders o
join Customers c
on o.CustomerID = c.CustomerID
group by Region
order by Total_Sales desc
LIMIT 10;

# Category wise sales
select
	p.Category,
    ROUND(SUM(o.Sales),2) as Total_Sales
from Orders o
JOIN Products p
on o.ProductID = p.ProductID
group by Category
order by Total_Sales
limit 10;