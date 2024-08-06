-- Q2 Dirty READ 1
USE AdventureWorks2012
GO


BEGIN TRANSACTION

UPDATE
	Person.Person
SET
	FirstName = 'Sepehr3'
WHERE
	Person.Person.BusinessEntityID = 60
WAITFOR DELAY '00:00:15'

ROLLBACK TRANSACTION

----------------------------------------------------------------------

-- Q2 Non Repeatable Read 1
USE AdventureWorks2012
GO


SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

BEGIN TRANSACTION
SELECT
	FirstName
FROM
	Person.Person
WHERE
	Person.Person.BusinessEntityID = 60

WAITFOR DELAY '00:00:15'

SELECT
	FirstName
FROM
	Person.Person
WHERE
	Person.Person.BusinessEntityID = 60

COMMIT TRANSACTION
