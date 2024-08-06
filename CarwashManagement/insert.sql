USE carwash;
GO

-- Insert data into Customers Table
EXEC AddNewCustomer 'John Doe', '123-456-7890', 'john@example.com', '123 Main St', 'Cashier';
EXEC AddNewCustomer 'Jane Smith', '987-654-3210', 'jane@example.com', '456 Oak Ave', 'Cashier';
EXEC AddNewCustomer 'Bob Johnson', '555-123-4567', 'bob@example.com', '789 Elm St', 'Cashier';
EXEC AddNewCustomer 'Alice Williams', '222-333-4444', 'alice@example.com', '101 Pine Ave', 'Cashier';
EXEC AddNewCustomer 'Charlie Brown', '888-999-0000', 'charlie@example.com', '202 Maple Dr', 'Cashier';
EXEC AddNewCustomer 'Eva Davis', '777-666-5555', 'eva@example.com', '303 Birch Ln', 'Cashier';
EXEC AddNewCustomer 'Frank White', '444-777-8888', 'frank@example.com', '404 Cedar Rd', 'Cashier';
EXEC AddNewCustomer 'Grace Turner', '999-111-2222', 'grace@example.com', '505 Oak St', 'Cashier';
EXEC AddNewCustomer 'Harry Black', '666-444-3333', 'harry@example.com', '606 Pine Ln', 'Cashier';
EXEC AddNewCustomer 'Ivy Green', '111-222-3333', 'ivy@example.com', '707 Maple Rd', 'Cashier';
GO

-- Insert data into Vehicles Table
EXEC AddNewVehicle 'ABC123', 'Toyota Camry', 'Sedan', 1.00, 'Cashier';
EXEC AddNewVehicle 'XYZ789', 'Honda Accord', 'Coupe', 1.20, 'Cashier';
EXEC AddNewVehicle '123XYZ', 'Ford Explorer', 'SUV', 1.10, 'Cashier';
EXEC AddNewVehicle '789ABC', 'Chevrolet Malibu', 'Sedan', 1.00, 'Cashier';
EXEC AddNewVehicle '456DEF', 'Nissan Rogue', 'SUV', 1.10, 'Cashier';
EXEC AddNewVehicle 'JKL321', 'Toyota Prius', 'Hatchback', 1.30, 'Cashier';
EXEC AddNewVehicle 'MNO987', 'Jeep Wrangler', 'SUV', 1.10, 'Cashier';
EXEC AddNewVehicle 'DEF456', 'Ford Mustang', 'Convertible', 1.40, 'Cashier';
EXEC AddNewVehicle 'GHI654', 'Honda CR-V', 'SUV', 1.10, 'Cashier';
EXEC AddNewVehicle 'PQR321', 'Chevrolet Silverado', 'Truck', 3.00, 'Cashier';
GO

-- Insert data into Services Table
EXEC AddNewService 'Outside Car Wash', 'Exterior cleaning of the car', 15.00, 'Cashier';
EXEC AddNewService 'Inside Car Wash', 'Interior cleaning of the car', 20.00, 'Cashier';
EXEC AddNewService 'Full Car Detailing', 'Comprehensive interior and exterior cleaning', 32.00, 'Cashier';
EXEC AddNewService 'Tire Rotation', 'Rotation of vehicle tires', 10.00, 'Cashier';
EXEC AddNewService 'Oil Change', 'Engine oil replacement', 30.00, 'Cashier';
GO

-- Insert data into Employees Table
EXEC AddNewEmployee 'Caroline Davis', '111-222-3333', 'caroline@example.com', 'Car Washer', 'Admin';
EXEC AddNewEmployee 'David Smith', '444-555-6666', 'david@example.com', 'Cashier', 'Admin';
EXEC AddNewEmployee 'Emma Brown', '777-888-9999', 'emma@example.com', 'Car Washer', 'Admin';
EXEC AddNewEmployee 'George White', '333-444-5555', 'george@example.com', 'Cashier', 'Admin';
EXEC AddNewEmployee 'Hannah Black', '666-777-8888', 'hannah@example.com', 'Car Washer', 'Admin';
EXEC AddNewEmployee 'Admin', '888-444-5555', 'admin@example.com', 'Admin', 'Admin';
GO

-- Insert data into Feedbacks Table
EXEC AddNewFeedback 1, 1, 5, 'Great service!', 'Cashier';
EXEC AddNewFeedback 2, 2, 4, 'Prompt and efficient', 'Cashier';
EXEC AddNewFeedback 3, 3, 5, 'Excellent detailing work', 'Cashier';
EXEC AddNewFeedback 4, 4, 3, 'Average service, could improve', 'Cashier';
EXEC AddNewFeedback 5, 4, 4, 'Good services', 'Cashier';
EXEC AddNewFeedback 6, 5, 4, 'Good oil change service', 'Cashier';
GO

-- Insert data to Orders and PaymentTransactions
DECLARE @NewlyInsertedOrderID1 INT;
DECLARE @NewlyInsertedOrderID2 INT;
DECLARE @NewlyInsertedOrderID3 INT;
EXEC AddNewOrder 1, 1, 1, @NewlyInsertedOrderID1 OUTPUT;
EXEC AddNewOrder 1, 1, 2, @NewlyInsertedOrderID2 OUTPUT;
EXEC AddNewOrder 1, 1, 5, @NewlyInsertedOrderID3 OUTPUT;
DECLARE @OrderIDs1 NVARCHAR(MAX);
SET @OrderIDs1 = CONCAT(@NewlyInsertedOrderID1, ',', @NewlyInsertedOrderID2, ',', @NewlyInsertedOrderID3);
EXEC ProcessOrderPayments @OrderIDs1, 'Cash';
GO

DECLARE @NewlyInsertedOrderID4 INT;
DECLARE @NewlyInsertedOrderID5 INT;
DECLARE @NewlyInsertedOrderID6 INT;
EXEC AddNewOrder 2, 10, 1, @NewlyInsertedOrderID4 OUTPUT;
EXEC AddNewOrder 2, 10, 2, @NewlyInsertedOrderID5 OUTPUT;
EXEC AddNewOrder 2, 10, 4, @NewlyInsertedOrderID6 OUTPUT;
DECLARE @OrderIDs2 NVARCHAR(MAX);
SET @OrderIDs2 = CONCAT(@NewlyInsertedOrderID4, ',', @NewlyInsertedOrderID5, ',', @NewlyInsertedOrderID6);
EXEC ProcessOrderPayments @OrderIDs2, 'Credit Card';
GO

DECLARE @NewlyInsertedOrderID7 INT;
DECLARE @NewlyInsertedOrderID8 INT;
EXEC AddNewOrder 3, 7, 3, @NewlyInsertedOrderID7 OUTPUT;
EXEC AddNewOrder 3, 7, 5, @NewlyInsertedOrderID8 OUTPUT;
DECLARE @OrderIDs3 NVARCHAR(MAX);
SET @OrderIDs3 = CONCAT(@NewlyInsertedOrderID7, ',', @NewlyInsertedOrderID8);
EXEC ProcessOrderPayments @OrderIDs3, 'Credit Card';
GO

DECLARE @NewlyInsertedOrderID9 INT;
DECLARE @NewlyInsertedOrderID10 INT;
EXEC AddNewOrder 4, 8, 4, @NewlyInsertedOrderID9 OUTPUT;
EXEC AddNewOrder 4, 8, 5, @NewlyInsertedOrderID10 OUTPUT;
DECLARE @OrderIDs4 NVARCHAR(MAX);
SET @OrderIDs4 = CONCAT(@NewlyInsertedOrderID9, ',', @NewlyInsertedOrderID10);
EXEC ProcessOrderPayments @OrderIDs4, 'Cash';
GO


SELECT * FROM Customers
SELECT * FROM Vehicles
SELECT * FROM Services
SELECT * FROM Employees
SELECT * FROM Feedbacks
SELECT * FROM Orders
SELECT * FROM PaymentTransactions
GO
