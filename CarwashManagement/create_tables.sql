--DROP DATABASE IF EXISTS carwash;

CREATE DATABASE carwash;

USE carwash;
GO

-- Table 6: Payment Transactions Table
IF OBJECT_ID('PaymentTransactions', 'U') IS NOT NULL
    DROP TABLE PaymentTransactions;
	
-- Table 4: Orders/Appointments Table
IF OBJECT_ID('Orders', 'U') IS NOT NULL
    DROP TABLE Orders;
	
-- Table 7: Feedback and Reviews Table
IF OBJECT_ID('Feedbacks', 'U') IS NOT NULL
    DROP TABLE Feedbacks;

-- Table 1: Customers Table
IF OBJECT_ID('Customers', 'U') IS NOT NULL
    DROP TABLE Customers;

-- Table 2: Vehicles Table
IF OBJECT_ID('Vehicles', 'U') IS NOT NULL
    DROP TABLE Vehicles;

-- Table 3: Services Table
IF OBJECT_ID('Services', 'U') IS NOT NULL
    DROP TABLE Services;

-- Table 5: Employees Table
IF OBJECT_ID('Employees', 'U') IS NOT NULL
    DROP TABLE Employees;
	


-- Table 1: Customers Table
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(255),
    Phone NVARCHAR(20),
    Email NVARCHAR(255),
    Address NVARCHAR(255)
);

-- Table 2: Vehicles Table
CREATE TABLE Vehicles (
    VehicleID INT IDENTITY(1,1) PRIMARY KEY,
    LicensePlate NVARCHAR(20),
    Model NVARCHAR(255),
    VehicleType NVARCHAR(50),
	PricingFactor NUMERIC(5, 2)
);

-- Table 3: Services Table
CREATE TABLE Services (
    ServiceID INT IDENTITY(1,1) PRIMARY KEY,
    ServiceName NVARCHAR(255),
    Description TEXT,
    Price NUMERIC(10, 2)
);

-- Table 6: Payment Transactions Table
CREATE TABLE PaymentTransactions (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    PaymentType NVARCHAR(50),
    Amount NUMERIC(10, 2),
    TransactionDateTime DATETIME
);

-- Table 4: Orders/Appointments Table
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    VehicleID INT FOREIGN KEY REFERENCES Vehicles(VehicleID),
    ServiceID INT FOREIGN KEY REFERENCES Services(ServiceID),
    DateTime DATETIME,
    Status NVARCHAR(50),
	TransactionID INT FOREIGN KEY REFERENCES PaymentTransactions(TransactionID),
    OrderPrice NUMERIC(10, 2)
);

-- Table 5: Employees Table
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(255),
    Phone NVARCHAR(20),
    Email NVARCHAR(255),
    Role NVARCHAR(50)
);

-- Table 7: Feedback and Reviews Table
CREATE TABLE Feedbacks (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    ServiceID INT FOREIGN KEY REFERENCES Services(ServiceID),
    Rating NUMERIC(4, 2) CHECK (Rating >= 0 AND Rating <= 5),
    Comments TEXT,
    ReviewDateTime DATETIME
);
