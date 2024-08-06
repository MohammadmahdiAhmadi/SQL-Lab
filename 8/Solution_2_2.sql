-- Q2 Dirty Read 2
USE AdventureWorks2012
GO


SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT
	FirstName
FROM
	Person.Person
WHERE
	Person.Person.BusinessEntityID = 60

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

----------------------------------------------------------------------

-- Q2 Non Repeatable Read 2
USE AdventureWorks2012
GO


UPDATE
	Person.Person
SET
	FirstName = 'Sepehr5'
WHERE
	Person.Person.BusinessEntityID = 60
