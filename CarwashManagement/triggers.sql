USE carwash;
GO

-- Drop the tr_UpdateOrderStatusOnPayment trigger if it exists
IF OBJECT_ID('tr_UpdateOrderStatusOnPayment', 'TR') IS NOT NULL
    DROP TRIGGER tr_UpdateOrderStatusOnPayment;
GO

-- Drop the tr_UpdatePendingOrdersOnServicePriceChange trigger if it exists
IF OBJECT_ID('tr_UpdatePendingOrdersOnServicePriceChange', 'TR') IS NOT NULL
    DROP TRIGGER tr_UpdatePendingOrdersOnServicePriceChange;
GO

-- Drop the tr_UpdateOrderPriceOnVehicleChange trigger if it exists
IF OBJECT_ID('tr_UpdateOrderPriceOnVehicleChange', 'TR') IS NOT NULL
    DROP TRIGGER tr_UpdateOrderPriceOnVehicleChange;
GO


-- Create the tr_UpdateOrderStatusOnPayment trigger
CREATE TRIGGER tr_UpdateOrderStatusOnPayment
ON Orders
AFTER UPDATE
AS
BEGIN
    IF UPDATE(TransactionID)
	BEGIN
		UPDATE Orders
		SET Status = 'complete'
		WHERE OrderID IN (SELECT OrderID FROM INSERTED);
	END
END;
GO


--Create the tr_UpdatePendingOrdersOnServicePriceChange trigger
CREATE TRIGGER tr_UpdatePendingOrdersOnServicePriceChange
ON Services
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Price)
    BEGIN
        UPDATE o
        SET o.OrderPrice = dbo.CalculateOrderPrice(i.Price, v.PricingFactor)
        FROM Orders o
        INNER JOIN INSERTED i ON o.ServiceID = i.ServiceID
        INNER JOIN Vehicles v ON v.VehicleID = o.VehicleID
        WHERE o.Status = 'pending';
    END
END;
GO


--Create the tr_UpdateOrderPriceOnVehicleChange trigger
CREATE TRIGGER tr_UpdateOrderPriceOnVehicleChange
ON Orders
AFTER UPDATE
AS
BEGIN
    IF UPDATE(VehicleID) OR UPDATE(ServiceID)
    BEGIN
        UPDATE o
        SET OrderPrice = dbo.CalculateOrderPrice(s.Price, v.PricingFactor)
        FROM Orders o
        INNER JOIN INSERTED i ON o.OrderID = i.OrderID
        INNER JOIN Services s ON s.ServiceID = i.ServiceID
        INNER JOIN Vehicles v ON v.VehicleID = i.VehicleID
        WHERE o.Status = 'pending';
    END
END;
GO
