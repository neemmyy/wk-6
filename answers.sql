USE salesDB;
-- ==============================
-- Use salesDB (already created earlier)
-- ==============================
USE salesDB;

-- ==============================
-- Drop old tables (safe clean-up)
-- ==============================
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS productlines;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS offices;
DROP TABLE IF EXISTS customers;
SET FOREIGN_KEY_CHECKS = 1;

-- ==============================
-- Create Offices table
-- ==============================
CREATE TABLE offices (
    officeCode INT PRIMARY KEY,
    city VARCHAR(50),
    country VARCHAR(50)
) ENGINE=InnoDB;

INSERT INTO offices (officeCode, city, country) VALUES
(1, 'Lagos', 'Nigeria'),
(2, 'Nairobi', 'Kenya'),
(3, 'Cape Town', 'South Africa');

-- ==============================
-- Create Employees table
-- ==============================
CREATE TABLE employees (
    employeeNumber INT PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    email VARCHAR(100),
    officeCode INT,
    CONSTRAINT fk_emp_office FOREIGN KEY (officeCode) REFERENCES offices(officeCode)
) ENGINE=InnoDB;

INSERT INTO employees (employeeNumber, firstName, lastName, email, officeCode) VALUES
(101, 'Chinedu', 'Okafor', 'chinedu.okafor@nigeria.com', 1),
(102, 'Ngozi', 'Balogun', 'ngozi.balogun@nigeria.com', 1),
(103, 'Tunde', 'Adebayo', 'tunde.adebayo@nigeria.com', 2);

-- ==============================
-- Create Productlines table
-- ==============================
CREATE TABLE productlines (
    productLine VARCHAR(50) PRIMARY KEY,
    description VARCHAR(255)
) ENGINE=InnoDB;

INSERT INTO productlines (productLine, description) VALUES
('Beverages', 'Soft drinks and juices'),
('Electronics', 'Consumer electronic gadgets'),
('Clothing', 'Traditional and modern wear');

-- ==============================
-- Create Products table
-- ==============================
CREATE TABLE products (
    productCode INT PRIMARY KEY,
    productName VARCHAR(100),
    productVendor VARCHAR(100),
    productLine VARCHAR(50),
    CONSTRAINT fk_prod_line FOREIGN KEY (productLine) REFERENCES productlines(productLine)
) ENGINE=InnoDB;

INSERT INTO products (productCode, productName, productVendor, productLine) VALUES
(201, 'Maltina', 'Nigerian Breweries', 'Beverages'),
(202, 'Infinix Note 30', 'Infinix Nigeria', 'Electronics'),
(203, 'Aso Oke Fabric', 'Lagos Tailors Assoc.', 'Clothing'),
(204, 'Zobo Drink', 'Homemade Drinks Ltd', 'Beverages');

-- ==============================
-- Create Customers table
-- ==============================
CREATE TABLE customers (
    customerNumber INT PRIMARY KEY,
    customerName VARCHAR(100),
    country VARCHAR(50),
    contactFirstName VARCHAR(50),
    contactLastName VARCHAR(50)
) ENGINE=InnoDB;

INSERT INTO customers (customerNumber, customerName, country, contactFirstName, contactLastName) VALUES
(301, 'Ade & Sons Ltd', 'Nigeria', 'Kunle', 'Adeyemi'),
(302, 'Nairobi Traders', 'Kenya', 'Mary', 'Njeri'),
(303, 'CapeTown Supplies', 'South Africa', 'Sipho', 'Khumalo');

-- ==============================
-- Create Orders table
-- ==============================
CREATE TABLE orders (
    orderNumber INT PRIMARY KEY,
    orderDate DATE,
    shippedDate DATE,
    status VARCHAR(20),
    customerNumber INT,
    CONSTRAINT fk_orders_customer FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
) ENGINE=InnoDB;

INSERT INTO orders (orderNumber, orderDate, shippedDate, status, customerNumber) VALUES
(1001, '2025-08-01', '2025-08-05', 'Shipped', 301),
(1002, '2025-08-10', NULL, 'In Process', 302),
(1003, '2025-08-15', '2025-08-20', 'Shipped', 303),
(1004, '2025-08-18', NULL, 'In Process', 301);

-- ==============================
-- 🔹 Assignment Queries
-- ==============================

-- QUESTION1: INNER JOIN employees with offices
SELECT 
    e.firstName,
    e.lastName,
    e.email,
    o.officeCode
FROM employees e
INNER JOIN offices o ON e.officeCode = o.officeCode;

-- QUESTION2: LEFT JOIN products with productlines
SELECT 
    p.productName,
    p.productVendor,
    pl.productLine
FROM products p
LEFT JOIN productlines pl ON p.productLine = pl.productLine;

-- QUESTION3: RIGHT JOIN customers with orders (limit 10)
SELECT 
    o.orderDate,
    o.shippedDate,
    o.status,
    o.customerNumber
FROM customers c
RIGHT JOIN orders o ON c.customerNumber = o.customerNumber
LIMIT 10;
