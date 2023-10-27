-- 0 --
USE AdventureWorks2012;
GO


-- 1 --
SELECT SOH.*, ST.Name
FROM Sales.SalesOrderHeader AS SOH
INNER JOIN Sales.SalesTerritory AS ST ON SOH.TerritoryID = ST.TerritoryID
WHERE SOH.TotalDue BETWEEN 100000 AND 500000 AND (ST.[Name] = 'France' OR ST.[Group] = 'North America');


-- 2 --
SELECT SOH.SalesOrderID, SOH.CustomerID, SOH.TotalDue, SOH.OrderDate, ST.[Name]
FROM Sales.SalesOrderHeader AS SOH, Sales.SalesTerritory AS ST
WHERE SOH.TerritoryID = ST.TerritoryID
  

-- 3 --
IF OBJECT_ID('Sales_NAmerica', 'U') IS NOT NULL
BEGIN
	DROP TABLE Sales_NAmerica
END

SELECT SOH.*, ST.Name
INTO Sales_NAmerica
FROM Sales.SalesOrderHeader AS SOH
INNER JOIN Sales.SalesTerritory AS ST ON SOH.TerritoryID = ST.TerritoryID
WHERE SOH.TotalDue BETWEEN 100000 AND 500000 AND (ST.[Group] = 'North America');

Alter Table dbo.Sales_NAmerica
ADD TotalDueCategory CHAR(4) CHECK (TotalDueCategory in ('Low', 'Mid', 'High'))

UPDATE dbo.Sales_NAmerica
SET dbo.Sales_NAmerica.TotalDueCategory =
    CASE
        WHEN TotalDue > (SELECT AVG(TotalDue) FROM dbo.Sales_NAmerica) THEN 'High'
        WHEN TotalDue < (SELECT AVG(TotalDue) FROM dbo.Sales_NAmerica) THEN 'Low'
        ELSE 'Mid'
    END;


-- 4 --
WITH SalaryAnalysis AS (
	SELECT BusinessEntityID, max(Rate) AS MaxRate, NTILE(4) OVER (ORDER BY max(Rate)) AS Quartile
	FROM HumanResources.EmployeePayHistory
	GROUP BY BusinessEntityID
)

SELECT
    SA.BusinessEntityID,
    CASE
        WHEN SA.Quartile = 1 THEN SA.MaxRate * 1.20
        WHEN SA.Quartile = 2 THEN SA.MaxRate * 1.15
        WHEN SA.Quartile = 3 THEN SA.MaxRate * 1.10
        ELSE SA.MaxRate * 1.05
    END AS NewSalary,
    CASE
        WHEN SA.MaxRate < 29 THEN 3
        WHEN SA.MaxRate >= 29 AND SA.MaxRate < 50 THEN 2
        ELSE 1
    END AS Level
FROM SalaryAnalysis AS SA
ORDER BY SA.BusinessEntityID;
