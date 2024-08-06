--Prerequisites
sp_configure 'show advanced options', 1;
RECONFIGURE;
Go
sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
GO
exec sp_configure 'Advanced', 1 RECONFIGURE
exec sp_configure 'Ad Hoc Distributed Queries', 1
RECONFIGURE
EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0',
N'AllowInProcess', 1
EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0',
N'DynamicParameters', 1
GO
-----
-- To enable the feature.
EXEC sp_configure 'xp_cmdshell', 1
GO
-- To update the currently configured value for this feature.
RECONFIGURE
GO


---------------------------------------------------------------------------
-----Q1
EXEC xp_cmdshell 'bcp "SELECT * FROM AdventureWorks2012.Sales.SalesTerritory" queryout "D:\dblab\7\Q1_ANS.txt" -T -c -t"|"'

-- Create the SalesTerritoryNew table if it doesn't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'SalesTerritoryNew')
BEGIN
    CREATE TABLE SalesTerritoryNew (
        [TerritoryID] [int] NOT NULL,
		[Name] [dbo].[Name] NOT NULL,
		[CountryRegionCode] [nvarchar](3) NOT NULL,
		[Group] [nvarchar](50) NOT NULL,
		[SalesYTD] [money] NOT NULL,
		[SalesLastYear] [money] NOT NULL,
		[CostYTD] [money] NOT NULL,
		[CostLastYear] [money] NOT NULL,
		[rowguid] [uniqueidentifier] NOT NULL,
		[ModifiedDate] [datetime] NOT NULL
    );
END
-- Use BULK INSERT to load data from the file into the SalesTerritoryNew table
BULK INSERT SalesTerritoryNew
FROM 'D:\dblab\7\Q1_ANS.txt'
WITH (
    FIELDTERMINATOR = '|'
);


-----Q2
EXEC xp_cmdshell 'bcp "SELECT Name, TerritoryID FROM AdventureWorks2012.Sales.SalesTerritory" queryout "D:\dblab\7\Q2_ANS.txt" -T -c -t,'


-----Q3
EXEC xp_cmdshell 'bcp AdventureWorks2012.Production.Location out D:\dblab\7\location.dat -T -c -t,'


-----Q4
CREATE TABLE
	xmlTable
	(
		Name [nvarchar](250) NULL,
		AnnualSales [xml] NULL,
		YearOpened [xml] NULL,
		NumberEmployees [xml] NULL
	)
--
INSERT INTO
xmlTable
SELECT
	Name,
	Demographics.query
	('
		declare default element namespace
		"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
		for $P in /StoreSurvey
		return
		<AnnualSales>
		{ $P/AnnualSales }
		</AnnualSales>
	') as AnnualSales,
	Demographics.query
	('
		declare default element namespace
		"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
		for $P in /StoreSurvey
		return
		<YearOpened>
		{ $P/YearOpened }
		</YearOpened>
	') as YearOpened,
	Demographics.query
	('
		declare default element namespace
		"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
		for $P in /StoreSurvey
		return
		<NumberEmployees>
		{ $P/NumberEmployees }
		</NumberEmployees>
	') as NumberEmployees
FROM
	AdventureWorks2012.Sales.Store
--
EXEC xp_cmdshell 'bcp AdventureWorks2012.dbo.xmlTable out D:\dblab\7\Q4_ANS.txt -T -c -q -t,'
