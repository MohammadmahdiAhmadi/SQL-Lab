این کوئری
OrderDate, LineTotal, میانگین متحرک LineTotal 
برای هر مشتری را نمایش میدهد.

مقدار میانگین متحرک به معنی 
میانگین LineTotal
ردیف فعلی و دو ردیف قبلی میباشد. 
که درواقع بر اساس OrderDate و SalesOrderID مرتب سازی شده اند.



-- 2
SELECT 
    CASE 
        WHEN st.Name IS NULL THEN 'All Territories'
        ELSE st.Name
    END AS TerritoryName,
    CASE 
        WHEN st.[Group] IS NULL THEN 'All Regions'
        ELSE st.[Group]
    END AS Region,
    SUM(soh.TotalDue) AS SalesTotal,
    COUNT(soh.SalesOrderID) AS SalesCount
FROM Sales.SalesTerritory st
INNER JOIN Sales.SalesOrderHeader soh ON st.TerritoryID = soh.TerritoryID
GROUP BY ROLLUP(st.[Group], st.Name)



-- 3

SELECT
  CASE
    WHEN GROUPING(c.Name) = 0 THEN c.Name
    WHEN GROUPING(c.Name) = 1 THEN 'All Categories'
  END AS Category,
  CASE
    WHEN GROUPING(sc.Name) = 0 THEN sc.Name
    WHEN GROUPING(sc.Name) = 1 THEN 'All Subcategories'
  END AS Subcategory,
  SUM(sod.LineTotal) AS sum_total,
  COUNT(sod.SalesOrderID) AS order_count
FROM
  Production.ProductCategory AS c
  INNER JOIN Production.ProductSubcategory AS sc ON c.ProductCategoryID = sc.ProductCategoryID
  INNER JOIN (
    Production.Product AS p
    INNER JOIN Sales.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
  ) ON p.ProductSubcategoryID = sc.ProductSubcategoryID
GROUP BY ROLLUP(c.Name, sc.Name);



-- 4

WITH EmployeeCounts AS (
    SELECT
        NationalIDNumber AS EmployeeName,
        NationalIDNumber AS NationalCode,
        Gender,
        MaritalStatus,
        JobTitle,
        COUNT(*) OVER (PARTITION BY JobTitle) AS NumberOfEmployeesInJob
    FROM HumanResources.Employee
)
SELECT
    NationalCode,
    Gender,
    MaritalStatus,
    JobTitle,
    NumberOfEmployeesInJob
FROM EmployeeCounts
WHERE NumberOfEmployeesInJob > 3;

