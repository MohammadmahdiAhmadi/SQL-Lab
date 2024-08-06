USE carwash;
GO

IF OBJECT_ID('CustomerOrdersView', 'V') IS NOT NULL
    DROP VIEW CustomerOrdersView;
GO

IF OBJECT_ID('CustomerPaymentsView', 'V') IS NOT NULL
    DROP VIEW CustomerPaymentsView;
GO

IF OBJECT_ID('CustomerFeedbackAndServicesView', 'V') IS NOT NULL
    DROP VIEW CustomerFeedbackAndServicesView;
GO

IF OBJECT_ID('EmployeesView', 'V') IS NOT NULL
    DROP VIEW EmployeesView;
GO

IF OBJECT_ID('ServiceSummaryView', 'V') IS NOT NULL
    DROP VIEW ServiceSummaryView;
GO


--CustomerOrdersView view
CREATE VIEW CustomerOrdersView AS
SELECT 
    C.Name AS CustomerName,
    O.OrderID,
    O.DateTime,
    O.Status,
    O.OrderPrice,
    PT.PaymentType,
    PT.Amount AS TotalAmount,
    PT.TransactionDateTime,
    S.ServiceName,
    S.Description AS ServiceDescription,
    S.Price AS ServicePrice,
    V.LicensePlate,
    V.Model,
    V.VehicleType,
    V.PricingFactor
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN PaymentTransactions PT ON O.TransactionID = PT.TransactionID
JOIN Services S ON O.ServiceID = S.ServiceID
JOIN Vehicles V ON O.VehicleID = V.VehicleID;
GO


--CustomerPaymentsView view
CREATE VIEW CustomerPaymentsView AS
SELECT 
    DISTINCT C.Name AS CustomerName,
    PT.PaymentType,
    PT.Amount,
    PT.TransactionDateTime
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN PaymentTransactions PT ON O.TransactionID = PT.TransactionID;
GO


--CustomerFeedbackAndServicesView view
CREATE VIEW CustomerFeedbackAndServicesView AS
SELECT 
    C.Name AS CustomerName,
    F.Rating,
    F.Comments,
    S.ServiceName
FROM Customers C
JOIN Feedbacks F ON C.CustomerID = F.CustomerID
JOIN Services S ON F.ServiceID = S.ServiceID;
GO


--ServiceSummaryView view
CREATE VIEW ServiceSummaryView AS
SELECT
	ServiceID,
	ServiceName,
	NumberOfReviews,
	AverageServiceRating,
	TotalSales
FROM GetServiceSummary();
GO


--EmployeesView view
CREATE VIEW EmployeesView AS
SELECT 
    E.EmployeeID,
    E.Name AS EmployeeName,
    E.Phone AS EmployeePhone,
    E.Email AS EmployeeEmail,
    E.Role AS EmployeeRole
FROM Employees E;
GO

CREATE VIEW DatabaseInfo AS
WITH ObjectDetails AS (
    SELECT
        schema_name(schema_id) AS SchemaName,
        name AS ObjectName,
        CASE 
            WHEN type = 'U' THEN 'Table'
            WHEN type = 'FN' THEN 'Function'
            WHEN type = 'P' THEN 'Procedure'
            WHEN type = 'TR' THEN 'Trigger'
            WHEN type = 'V' THEN 'View'
            ELSE 'Unknown'
        END AS ObjectType
    FROM
        sys.objects
    WHERE
        type IN ('U', 'FN', 'P', 'TR', 'V')
)
SELECT
    od.ObjectName,
    od.ObjectType,
    CASE 
        WHEN od.ObjectType = 'Table' THEN
            (SELECT SUM(rows) FROM sys.partitions WHERE object_id = OBJECT_ID(od.SchemaName + '.' + od.ObjectName))
        ELSE
            NULL
    END AS [RowCount]
FROM
    ObjectDetails od;
GO


-- example
SELECT * FROM CustomerOrdersView ORDER BY OrderID
SELECT * FROM CustomerPaymentsView ORDER BY CustomerName, TransactionDateTime
SELECT * FROM CustomerFeedbackAndServicesView ORDER BY Rating DESC
SELECT * FROM ServiceSummaryView ORDER BY AverageServiceRating DESC
SELECT * FROM EmployeesView
SELECT * FROM DatabaseInfo ORDER BY ObjectType
GO
