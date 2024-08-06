USE carwash;
GO

-- Drop the AddNewOrder procedure
IF OBJECT_ID('AddNewOrder', 'P') IS NOT NULL
    DROP PROCEDURE AddNewOrder;
GO

-- Drop another ProcessOrderPayments procedure
IF OBJECT_ID('ProcessOrderPayments', 'P') IS NOT NULL
    DROP PROCEDURE ProcessOrderPayments;
GO

-- Drop the AddNewCustomer procedure
IF OBJECT_ID('AddNewCustomer', 'P') IS NOT NULL
    DROP PROCEDURE AddNewCustomer;
GO

-- Drop the AddNewVehicle procedure
IF OBJECT_ID('AddNewVehicle', 'P') IS NOT NULL
    DROP PROCEDURE AddNewVehicle;
GO

-- Drop the AddNewService procedure
IF OBJECT_ID('AddNewService', 'P') IS NOT NULL
    DROP PROCEDURE AddNewService;
GO

-- Drop the AddNewFeedback procedure
IF OBJECT_ID('AddNewFeedback', 'P') IS NOT NULL
    DROP PROCEDURE AddNewFeedback;
GO

-- Drop the AddNewEmployee procedure
IF OBJECT_ID('AddNewEmployee', 'P') IS NOT NULL
    DROP PROCEDURE AddNewEmployee;
GO



--AddNewOrder procedure
CREATE PROCEDURE AddNewOrder (
    @CustomerID INT,
    @VehicleID INT,
    @ServiceID INT,
	@NewOrderID INT OUTPUT
)
AS
BEGIN
    DECLARE @ServicePrice NUMERIC(10, 2);
    DECLARE @PricingFactor NUMERIC(5, 2);
    DECLARE @OrderPrice NUMERIC(10, 2);

    -- Get service price and vehicle pricing factor
    SELECT @ServicePrice = Price, @PricingFactor = PricingFactor
    FROM Services s
    JOIN Vehicles v ON v.VehicleID = @VehicleID
    WHERE s.ServiceID = @ServiceID;

    -- Calculate order price
    SET @OrderPrice = dbo.CalculateOrderPrice(@ServicePrice, @PricingFactor);

    -- Insert to Orders table
    INSERT INTO Orders (CustomerID, VehicleID, ServiceID, DateTime, Status, TransactionID, OrderPrice)
    VALUES (@CustomerID, @VehicleID, @ServiceID, GETDATE(), 'pending', NULL, @OrderPrice);

	-- Get the newly inserted OrderID
    SET @NewOrderID = SCOPE_IDENTITY();
END;
GO


--ProcessOrderPayments procedure
CREATE PROCEDURE ProcessOrderPayments
    @OrderIDs NVARCHAR(MAX),
    @PaymentType NVARCHAR(50)
AS
BEGIN
    DECLARE @PaymentID INT;
    DECLARE @TotalOrderPrice NUMERIC(10, 2);

    -- Create Payment entry
    INSERT INTO PaymentTransactions (PaymentType, Amount, TransactionDateTime)
    VALUES (@PaymentType, 0, GETDATE());

    -- Get the newly created Payment ID
    SET @PaymentID = SCOPE_IDENTITY();

    -- Update TransactionID for each order in the list
    UPDATE Orders
    SET TransactionID = @PaymentID
    WHERE OrderID IN (SELECT CAST(value AS INT) FROM STRING_SPLIT(@OrderIDs, ','));

    -- Calculate the total order price
    SELECT @TotalOrderPrice = ISNULL(SUM(OrderPrice), 0)
    FROM Orders
    WHERE OrderID IN (SELECT CAST(value AS INT) FROM STRING_SPLIT(@OrderIDs, ','));

    -- Update the Payment amount with the total order price
    UPDATE PaymentTransactions
    SET Amount = @TotalOrderPrice
    WHERE TransactionID = @PaymentID;
END;
GO


--AddNewCustomer procedure
CREATE PROCEDURE AddNewCustomer
    @Name NVARCHAR(255),
    @Phone NVARCHAR(20),
    @Email NVARCHAR(255),
    @Address NVARCHAR(255),
    @EmployeeRole NVARCHAR(50)
AS
BEGIN
    IF @EmployeeRole = 'Cashier' OR @EmployeeRole = 'Admin'
    BEGIN
        INSERT INTO Customers (Name, Phone, Email, Address)
        VALUES (@Name, @Phone, @Email, @Address);	
    END
    ELSE
    BEGIN
        RAISERROR('Only Cashier or Admin can add new customers.', 16, 1);
    END
END;
GO


--AddNewVehicle procedure
CREATE PROCEDURE AddNewVehicle
    @LicensePlate NVARCHAR(20),
    @Model NVARCHAR(255),
    @VehicleType NVARCHAR(50),
    @PricingFactor NUMERIC(5, 2),
    @EmployeeRole NVARCHAR(50)
AS
BEGIN
    IF @EmployeeRole = 'Cashier' OR @EmployeeRole = 'Admin'
    BEGIN
        INSERT INTO Vehicles (LicensePlate, Model, VehicleType, PricingFactor)
        VALUES (@LicensePlate, @Model, @VehicleType, @PricingFactor);
    END
    ELSE
    BEGIN
        RAISERROR('Only Cashier or Admin can add new vehicles.', 16, 1);
    END
END;
GO


--AddNewService procedure
CREATE PROCEDURE AddNewService
    @ServiceName NVARCHAR(255),
    @Description TEXT,
    @Price NUMERIC(10, 2),
    @EmployeeRole NVARCHAR(50)
AS
BEGIN
    IF @EmployeeRole = 'Cashier' OR @EmployeeRole = 'Admin'
    BEGIN
        INSERT INTO Services (ServiceName, Description, Price)
        VALUES (@ServiceName, @Description, @Price);
    END
    ELSE
    BEGIN
        RAISERROR('Only Cashier or Admin can add new services.', 16, 1);
    END
END;
GO


--AddNewFeedback procedure
CREATE PROCEDURE AddNewFeedback
    @CustomerID INT,
    @ServiceID INT,
    @Rating NUMERIC(4, 2),
    @Comments TEXT,
    @EmployeeRole NVARCHAR(50)
AS
BEGIN
    IF @EmployeeRole = 'Cashier' OR @EmployeeRole = 'Admin'
    BEGIN
        INSERT INTO Feedbacks (CustomerID, ServiceID, Rating, Comments, ReviewDateTime)
        VALUES (@CustomerID, @ServiceID, @Rating, @Comments, GETDATE());
    END
    ELSE
    BEGIN
        RAISERROR('Only Cashier or Admin can add new feedbacks.', 16, 1);
    END
END;
GO


--AddNewEmployee procedure
CREATE PROCEDURE AddNewEmployee
    @Name NVARCHAR(255),
    @Phone NVARCHAR(20),
    @Email NVARCHAR(255),
    @Role NVARCHAR(50),
    @AdminRole NVARCHAR(50)
AS
BEGIN
    IF @AdminRole = 'Admin'
    BEGIN
        INSERT INTO Employees (Name, Phone, Email, Role)
        VALUES (@Name, @Phone, @Email, @Role);
    END
    ELSE
    BEGIN
        RAISERROR('Only Admin can add new employees.', 16, 1);
    END
END;
GO
