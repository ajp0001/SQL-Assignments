use classicmodels;
# Day 1 - Nill
# Day 2 - Nill
# Day 3
# Day 3 - 1)
select * from customers;
select customernumber, customername, state, creditlimit from customers 
	WHERE creditlimit BETWEEN 50000 and 100000 and state is not null 
    order by state is not null, creditlimit desc, customernumber desc;
    
# Day 3 - 2)
select * from products;
select distinct productline from products where productLine like '%cars';

# Day 4
# Day 4 - 1)
select * from orders;
select ordernumber,status, coalesce(comments,'-')as comments from orders where status='shipped';

# Day 4 - 2)
select employeenumber, firstname, jobtitle, case 
	when jobtitle = 'President' then 'P' 
	when jobtitle in ('Sale Manager', 'Sales Manager','sales Manager') then 'SM' 
	when jobtitle = 'Sales Rep' then 'SR' 
	when jobtitle like '%VP%' then 'VP' else 'SM' 
	end as jobTitle_abbr from employees;

# Day 5
# Day 5 - 1)
select * from payments;
select year(paymentDate), 
	min(amount) as MinAmount 
    from payments 
    group by year(paymentdate) order by year(paymentDate) asc;
    
# Day 5 - 2)
select * from orders;
select Year(orderDate) as 'Year', 
	concat('Q', QUARTER(orderDate)) Quarter, 
    count(distinct customerNumber) as Unique_Customers, 
    count(orderNumber) as Total_Orders 
	from orders group by Year(orderDate), QUARTER order by year, quarter;
    
# Day 5 - 3)
select * from payments;
select date_format(paymentDate,'%b') as Month, 
	concat(format(sum(amount)/1000,0),'k') as formatted_amount 
    from payments 
    group by month
    having sum(amount) between 500000 and 1000000
    order by sum(amount) desc;
	
# Day 6
# Day 6 - 1)
create table journey (
	Bus_ID int NOT null,
    Bus_Name varchar(25) NOT NULL,
    Source_Station varchar(255) Not null,
    Destination varchar(255) Not null,
    Email varchar(25) unique);
select * from journey;

# Day 6 - 2)
create table Vendor (
	Vendor_ID decimal(6,0) unique NOT NULL DEFAULT 0,
    Name varchar(30) not null,
    Email varchar(25) not null UNIQUE,
	Country varchar(30) default 'N/A' );
select * from Vendor;

# Day 6 - 3)
create table movies (
	Movie_ID int NOT NULL unique ,
    Name varchar(30) not null,
    Release_Year char(4) default '-' ,
    Cast varchar(30) not null,
    Gender VARCHAR(20) CHECK (Gender='Male'OR Gender='Female'),
    No_of_shows int unsigned);
select * from movies;

# Day 6 - 4)
# Day 6 - 4a)
select * from suppliers;
create table product (
	product_id integer primary key,
    product_name varchar(255) not null unique,
    description text,
    supplier_id int,
    foreign key (supplier_id) references suppliers(supplier_id) );
select * from product;

# Day 6 - 4b)
create table suppliers (
	supplier_id int primary key,
    supplier_name varchar(255),
    location varchar(255)  );
select * from suppliers;

# Day 6 - 4c)
create table stock (
	id int primary key,
    product_id int,
    foreign key (product_id) references product (product_id),
    balance_stock varchar(30)  );
select * from stock;

# Day 7
# Day 7 - 1)
select * from employees;
select * from customers;
select emp.employeeNumber,
	concat(emp.firstname,' ',emp.lastname) as Sales_Person ,
	count(distinct cst.customernumber) as Unique_Customers 
	from employees as emp join customers as cst 
    on emp.employeeNumber = cst.salesRepEmployeeNumber
    group by emp.employeenumber, Sales_Person
    order by Unique_Customers desc;
    
# Day 7 - 2)
select * from customers;
select * from orders;
select * from orderdetails;
select * from products;
select
    c.customerNumber AS CustomerNumber,
    c.customerName,
    p.productCode AS ProductCode,
    p.productName,
    SUM(od.quantityOrdered) AS `Ordered Qty`,
    SUM(p.quantityInStock) AS `Total Inventory`,
    SUM(p.quantityInStock) - SUM(od.quantityOrdered) AS `Left Qty`
from customers as c 
left join orders as o on o.customerNumber = c.customerNumber
left join orderdetails as od on od.orderNumber = o.orderNumber
left join products as p on p.productCode = od.productCode
group by 1,3
order by 1;

# Day 7 - 3)
create table Laptop (Laptop_Name varchar(50) );
insert into Laptop values ('Dell'),('HP') ;
create table colour (Colour_Name varchar(50) );
insert into colour values ('White'),('Silver'),('Black');
select lp.Laptop_Name, clr.Colour_Name 
	from laptop as lp join colour as clr 
    order by laptop_name;
    
# Day 7 - 4)
create table Project (
	EmployeeID int ,
    FullName varchar(50),
    Gender VARCHAR(20) CHECK (Gender='Male'OR Gender='Female') ,
    ManagerID int );
INSERT INTO Project VALUES (1, 'Pranaya', 'Male', 3),
	(2, 'Priyanka', 'Female', 1),
	(3, 'Preety', 'Female', NULL),
	(4, 'Anurag', 'Male', 1),
	(5, 'Sambit', 'Male', 1),
	(6, 'Rajesh', 'Male', 3),
	(7, 'Hina', 'Female', 3);
select
    m.FullName AS ManagerName,
    p.FullName AS EmpName
from Project as m inner join Project as p 
ON p.ManagerID = m.EmployeeID order by 1;
    
# Day 8
create table Facility (
	Facility_ID int not null,
    Name varchar(100),
    State varchar(100),
    Country varchar(100) );
alter table Facility modify Facility_ID int primary key auto_increment;
alter table Facility add column City varchar(100)not null after Name;
describe facility;

# Day 9
create table University (
	ID int primary key,
    Name Varchar(100) );
INSERT INTO University (ID, Name)
VALUES 
	(1, "       Pune          University     "),
	(2, "  Mumbai          University     "),
    (3, "     Delhi   University     "),
    (4, "Madras University"),
    (5, "Nagpur University");
UPDATE University SET Name = trim(REGEXP_REPLACE(Name, ' +', ' '));
SET SQL_SAFE_UPDATES = 0 ;
select * from University;

# Day 10
select * from products;
create view products_status as
select YEAR(o.orderDate) AS Year,
    CONCAT(COUNT(od.productCode), 
    ' (', ROUND(COUNT(od.productCode) / (SELECT COUNT(*) FROM orderdetails) * 100), '%)') AS Value
FROM orders o JOIN orderdetails od ON o.orderNumber = od.orderNumber GROUP BY year order by value asc;
select * from products_status;

# Day 11
# Day 11 - 1)
select * from customers;

DELIMITER //
CREATE PROCEDURE GetCustomerLevel(IN customerNumber INT, OUT customerLevel VARCHAR(20))
BEGIN
    DECLARE customerCreditLimit DECIMAL(10, 2);
    
    SELECT creditLimit INTO customerCreditLimit FROM Customers
    WHERE customerNumber = customerNumber LIMIT 1;

    IF customerCreditLimit > 100000 THEN
        SET customerLevel = 'Platinum';
    ELSEIF customerCreditLimit >= 25000 THEN
        SET customerLevel = 'Gold';
    ELSE
        SET customerLevel = 'Silver';
    END IF;
END //
DELIMITER ;
CALL GetCustomerLevel(114, @customerLevel);
SELECT @customerLevel AS CustomerLevel;

# Day 11 - 2)
select * from customers;
select * from payments;

DELIMITER //
CREATE PROCEDURE Get_country_payments
	(IN inputYear INT, IN inputCountry VARCHAR(100), OUT outputYear INT, OUT outputCountry VARCHAR(100), OUT totalAmountFormatted VARCHAR(10))
BEGIN
    DECLARE totalAmount DECIMAL(10, 2);

    SELECT YEAR(p.paymentDate) AS Year, c.country AS Country, SUM(p.amount) AS TotalAmount
		INTO outputYear, outputCountry, totalAmount
    FROM Payments p
		JOIN Customers c ON p.customerNumber = c.customerNumber
    WHERE YEAR(p.paymentDate) = inputYear AND c.country = inputCountry group by year;

    SET totalAmountFormatted = CONCAT(FORMAT(totalAmount / 1000, 0), 'K');
END //
DELIMITER ;
CALL Get_country_payments(2003, 'France', @outputYear, @outputCountry, @totalAmountFormatted);
SELECT @outputYear AS Year, @outputCountry AS Country, @totalAmountFormatted AS `Total Amount`;

# Day 12
# Day 12 - 1) 
select * from orders;
select
    YEAR(orderDate) AS Year,
    MONTHNAME(orderDate) AS Month,
    COUNT(*) AS TotalOrders,
    CONCAT(IFNULL(FORMAT((COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY YEAR(orderDate), 
					MONTH(orderDate))) / LAG(COUNT(*)) OVER (ORDER BY YEAR(orderDate), 
					MONTH(orderDate)) * 100, 0), 'NULL'),'%') AS '% YoY Change'
from Orders GROUP BY YEAR(orderDate), MONTH(orderDate)
			ORDER BY YEAR(orderDate), MONTH(orderDate);

# Day 12 - 2)
create table emp_udf (
    Emp_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    DOB DATE);
INSERT INTO Emp_UDF (Name, DOB)
VALUES ("Piyush", "1990-03-30"), 
		("Aman", "1992-08-15"), 
        ("Meena", "1998-07-28"), 
        ("Ketan", "2000-11-21"), 
        ("Sanjay", "1995-05-21");

DELIMITER //
create function calculate_age(dob DATE) RETURNS VARCHAR(50)
DETERMINISTIC
READS SQL DATA
begin
    DECLARE years INT;
    DECLARE months INT;
    DECLARE age VARCHAR(50);
    SET years = TIMESTAMPDIFF(YEAR, dob, CURDATE());
    SET months = TIMESTAMPDIFF(MONTH, dob, CURDATE()) - (years * 12);
    SET age = CONCAT(years, ' years ', months, ' months');
    RETURN age;
end //
DELIMITER ;
SELECT Emp_ID, Name, DOB, calculate_age(DOB) AS Age FROM emp_udf;

# Day 13
# Day 13 - 1)
select * from customers;
select * from orders;
select customerNumber, customerName from Customers
where customerNumber NOT IN (select customerNumber from Orders);

# Day 13 - 2)
select c.customerNumber, c.customerName, COUNT(o.orderNumber) AS orderCount from Customers c
	left join Orders o on c.customerNumber = o.customerNumber
	GROUP BY c.customerNumber, c.customerName
UNION
select c.customerNumber, c.customerName, COUNT(o.orderNumber) AS orderCount from Orders o
	right join Customers c on o.customerNumber = c.customerNumber
	GROUP BY c.customerNumber, c.customerName;

# Day 13 - 3)
select * from orderdetails;
select orderNumber, MAX(quantityOrdered) AS secondHighestQuantity from Orderdetails as od
	WHERE quantityOrdered < (select MAX(quantityOrdered) from Orderdetails where orderNumber = od.orderNumber)
	GROUP BY orderNumber;

# Day 13 - 4)
select * from orderdetails;
SELECT MAX(productCount) AS `MAX(Total)`, 
		MIN(productCount) AS `MIN(Total)`
FROM (SELECT orderNumber, 
	COUNT(*) AS productCount 
    FROM Orderdetails GROUP BY orderNumber) as abc;

# Day 13 - 5)
select productLine, 
	COUNT(*) as Total
from products
where buyPrice > (select AVG(buyPrice) from products) GROUP BY productLine;

# Day 14
create table Emp_EH (
	EmpID int primary key,
    EmpName varchar(25),
    EmailAddress varchar(100) );
select * from Emp_EH;
DELIMITER //
CREATE PROCEDURE InsertIntoEmp_EH(
    IN input_EmpID INT,
    IN input_EmpName VARCHAR(100),
    IN input_EmailAddress VARCHAR(100)
)
BEGIN
    DECLARE error_occurred BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION, SQLWARNING, NOT FOUND
    BEGIN
        SET error_occurred = TRUE;
    END;

    START TRANSACTION;

    INSERT INTO Emp_EH (EmpID, EmpName, EmailAddress)
		VALUES (input_EmpID, input_EmpName, input_EmailAddress);

    IF error_occurred THEN
        ROLLBACK;
        SELECT 'Error occurred' AS Message;
    ELSE
        COMMIT;
        SELECT 'Data inserted successfully' AS Message;
    END IF;
END //
DELIMITER ;
CALL InsertIntoEmp_EH(1, 'Shubh', 'shubh@example.com');

# Day 15
create table Emp_BIT (
	Name varchar(100),
    Occupation varchar(100),
	Working_date date,
    Working_hours int );
INSERT INTO Emp_BIT VALUES
	('Robin', 'Scientist', '2020-10-04', 12),  
	('Warner', 'Engineer', '2020-10-04', 10),  
	('Peter', 'Actor', '2020-10-04', 13),  
	('Marco', 'Doctor', '2020-10-04', 14),  
	('Brayden', 'Teacher', '2020-10-04', 12),  
	('Antonio', 'Business', '2020-10-04', 11);  
select * from Emp_BIT;
DELIMITER //
CREATE TRIGGER Before_Insert_Emp_BIT
	BEFORE INSERT ON Emp_BIT FOR EACH ROW
BEGIN
    IF NEW.Working_hours < 0 THEN
        SET NEW.Working_hours = -NEW.Working_hours;
    END IF;
END //
DELIMITER ;
SHOW TRIGGERS ;

################################################################# End #####################################################################




