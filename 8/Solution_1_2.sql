USE AdventureWorks2012
GO


BEGIN TRANSACTION

UPDATE
	Sales.Store
SET
	Name = 'new name2'
WHERE
	BusinessEntityID=292
SELECT * FROM Person.Person WHERE BusinessEntityID = 60

COMMIT
