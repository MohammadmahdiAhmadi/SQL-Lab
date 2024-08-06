USE AdventureWorks2012
GO
	

BEGIN TRANSACTION

UPDATE
	Person.Person
SET
	FirstName = 'Sepehr2'
WHERE
	Person.Person.BusinessEntityID = 60
WAITFOR DELAY '00:00:15'
SELECT * FROM Sales.Store WHERE BusinessEntityID=292

COMMIT
GO
