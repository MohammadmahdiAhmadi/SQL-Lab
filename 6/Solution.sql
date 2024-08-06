-- Q1
USE [AdventureWorks2012]
GO
CREATE TABLE [Production].[ProductLogs](
	[ProductID] [int] NULL,
	[Name] [dbo].[Name] NULL,
	[ProductNumber] [nvarchar](25) NULL,
	[MakeFlag] [dbo].[Flag] NULL,
	[FinishedGoodsFlag] [dbo].[Flag] NULL,
	[Color] [nvarchar](15) NULL,
	[SafetyStockLevel] [smallint] NULL,
	[ReorderPoint] [smallint] NULL,
	[StandardCost] [money] NULL,
	[ListPrice] [money] NULL,
	[Size] [nvarchar](5) NULL,
	[SizeUnitMeasureCode] [nchar](3) NULL,
	[WeightUnitMeasureCode] [nchar](3) NULL,
	[Weight] [decimal](8, 2) NULL,
	[DaysToManufacture] [int] NULL,
	[ProductLine] [nchar](2) NULL,
	[Class] [nchar](2) NULL,
	[Style] [nchar](2) NULL,
	[ProductSubcategoryID] [int] NULL,
	[ProductModelID] [int] NULL,
	[SellStartDate] [datetime] NULL,
	[SellEndDate] [datetime] NULL,
	[DiscontinuedDate] [datetime] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NULL,
	[ModifiedDate] [datetime] NULL,
	[ChangeType] [nvarchar](8) NOT NULL
)

-- Insert Trigger
CREATE TRIGGER insertTrigger ON Production.Product
AFTER INSERT
AS
INSERT INTO Production.ProductLogs
	SELECT
		*,
		'INSERTED'
	FROM
		inserted

-- Delete Trigger
CREATE TRIGGER deleteTrigger ON Production.Product
AFTER DELETE
AS
INSERT INTO Production.ProductLogs
	SELECT
		*,
		'DELETED'
	FROM
		deleted

-- Update Trigger
CREATE TRIGGER updateTrigger ON Production.Product
AFTER UPDATE
AS
INSERT INTO Production.ProductLogs
	SELECT
		*,
		'UPDATED'
	FROM
		inserted

-- Test Insert Triggers
INSERT INTO Production.Product
(
 Name, ProductNumber, MakeFlag, FinishedGoodsFlag, SafetyStockLevel,
 ReorderPoint, StandardCost, ListPrice, DaysToManufacture,
 SellStartDate, RowGUID, ModifiedDate
)
VALUES
(
 N'CityBike2', N'CB-5382', 0, 0, 1000, 750, 0.0000, 0.0000, 0,
 GETDATE(), NEWID(), GETDATE()
)
select * from Production.ProductLogs

-- Test Update Triggers
UPDATE Production.Product
SET
	SafetyStockLevel = 2000
WHERE
	NAME = N'CityBike2'
	AND ProductNumber = N'CB-5382'
	AND MakeFlag = 0
	AND FinishedGoodsFlag = 0
	AND SafetyStockLevel = 1000
	AND ReorderPoint = 750
select * from Production.ProductLogs

-- Test Delete Triggers
DELETE FROM
	Production.Product
WHERE
	NAME = N'CityBike'
	AND ProductNumber = N'CB-5381'
	AND MakeFlag = 0
	AND FinishedGoodsFlag = 0
	AND SafetyStockLevel = 2000
	AND ReorderPoint = 750
select * from Production.ProductLogs


-- Q2
select
	*
into
	Production.NewProductLogs
from
	Production.ProductLogs
select * from Production.NewProductLogs

UPDATE
	Production.NewProductLogs
SET
	SafetyStockLevel = 2000
WHERE
	NAME = N'CityBike2'
	AND ProductNumber = N'CB-5382'
	AND MakeFlag = 0
	AND FinishedGoodsFlag = 0
	AND SafetyStockLevel = 1000
	AND ReorderPoint = 750


-- Q3
CREATE PROCEDURE Production.getProductLogsDiff
AS
BEGIN
	SET NOCOUNT ON;

	IF OBJECT_ID(N'Production.ProductLogsDiff', N'U') IS NOT NULL  
	   DROP TABLE [Production].[ProductLogsDiff];
	SELECT * INTO Production.ProductLogsDiff
	FROM (   
		SELECT * FROM Production.ProductLogs
		EXCEPT
		SELECT * FROM Production.NewProductLogs
	) AS Diff
END;

EXECUTE Production.getProductLogsDiff