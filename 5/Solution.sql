-----Q1
SELECT [name],
       [europe],
       [north america],
       [pacific]
FROM   (SELECT production.product.[name],
               sales.salesterritory.[group],
               sales.salesorderdetail.orderqty
        FROM   production.product,
               sales.salesorderdetail,
               sales.salesorderheader,
               sales.salesterritory
        WHERE  production.product.productid = sales.salesorderdetail.productid
               AND sales.salesterritory.territoryid =
                   sales.salesorderheader.territoryid
               AND sales.salesorderdetail.salesorderid =
                   sales.salesorderheader.salesorderid) AS temp
       PIVOT ( Count (temp.orderqty)
             FOR [group] IN ([Europe],
                             [North America],
                             [Pacific]) ) AS pvt 



-----Q2
---a
SELECT person.businessentityid,
       persontype,
       gender
FROM   person.person
       JOIN humanresources.employee
         ON ( person.businessentityid = employee.businessentityid )

---b
SELECT [persontype],
       [m],
       [f]
FROM   (SELECT person.businessentityid,
               persontype,
               gender
        FROM   person.person
               JOIN humanresources.employee ON ( person.businessentityid = employee.businessentityid )
	   ) AS temp

       PIVOT ( Count (temp.businessentityid)
             FOR temp.gender IN ([F], [M])
	   ) AS pvt 



-----Q3
SELECT production.product.[name]
FROM   production.product
WHERE  Len(production.product.[name]) < 15
       AND Patindex('%e_', [name]) = Len(production.product.[name]) - 1 



-----Q4
IF Object_id (N'dbo.Getjalalidate', N'FN') IS NOT NULL
  DROP FUNCTION Getjalalidate
GO

CREATE FUNCTION Getjalalidate(@date CHAR(10))
returns NVARCHAR(50)
AS
  BEGIN
      DECLARE @result NVARCHAR(100)
      DECLARE @day NVARCHAR(10)
      DECLARE @yearandmonth NVARCHAR(10)
      DECLARE @month NVARCHAR(10)
      DECLARE @year NVARCHAR(10)

      SET @day = RIGHT(@date, 2)
      SET @yearandmonth = LEFT (@date, 7)
      SET @month = RIGHT(@yearandmonth, 2)
      SET @year = LEFT (@yearandmonth, 4)

      IF ( @date NOT LIKE '[1-9][0-9][0-9][0-9]/[0-1][0-9]/[0-3][0-9]'
			OR @day = 0
			OR @month = 0
			OR @month > 12
			OR (@month > 6 AND @day > 30)
			OR (@month <= 6 AND @day > 31)
		)
        SET @result = N'فرمت تاریخ ناصحیح است'
      ELSE
        BEGIN
            IF @month = '01'
              SET @result = @day + N' فروردین ماه ' + @year + N' شمسی '

            IF @month = '02'
              SET @result = @day + N' اردیبهشت  ماه ' + @year + N' شمسی '

            IF @month = '03'
              SET @result = @day + N' خرداد  ماه ' + @year + N' شمسی '

            IF @month = '04'
              SET @result = @day + N' تیر  ماه ' + @year + N' شمسی '

            IF @month = '05'
              SET @result = @day + N' مرداد  ماه ' + @year + N' شمسی '

            IF @month = '06'
              SET @result = @day + N' شهرویور  ماه ' + @year + N' شمسی '

            IF @month = '07'
              SET @result = @day + N' مهر  ماه ' + @year + N' شمسی '

            IF @month = '08'
              SET @result = @day + N' آبان  ماه ' + @year + N' شمسی '

            IF @month = '09'
              SET @result = @day + N' آذر  ماه ' + @year + N' شمسی '

            IF @month = '10'
              SET @result = @day + N' دی  ماه ' + @year + N' شمسی '

            IF @month = '11'
              SET @result = @day + N' بهمن  ماه ' + @year + N' شمسی '

            IF @month = '12'
              SET @result = @day + N' اسفند  ماه ' + @year + N' شمسی '
        END

      RETURN @result;
  END;

SELECT dbo.Getjalalidate ('1322/02/30')
SELECT dbo.Getjalalidate ('1402/12/30')
SELECT dbo.Getjalalidate ('1402/12/31')
SELECT dbo.Getjalalidate ('1402/12/32')
SELECT dbo.Getjalalidate ('1402/06/00')
SELECT dbo.Getjalalidate ('1402/06/31')
SELECT dbo.Getjalalidate ('1402/06/32')
SELECT dbo.Getjalalidate ('gdrgdrhd') 



-----Q5
IF Object_id (N'dbo.getProductSoldAtLeastOnce', N'FN') IS NOT NULL
	DROP FUNCTION getProductSoldAtLeastOnce
GO

create function getProductSoldAtLeastOnce(@month int, @year int, @prod varchar(50))
returns table
as
return
(
	select distinct
		Sales.SalesTerritory.[Group]
	from
		Production.Product
		inner join Sales.SalesOrderDetail  
			on (Production.Product.ProductID = Sales.SalesOrderDetail.ProductID)
		inner join Sales.SalesOrderHeader 
			on (Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID)
		inner join Sales.SalesTerritory
			on (Sales.SalesTerritory.TerritoryID = Sales.SalesOrderHeader.TerritoryID)
	where
		year(Sales.SalesOrderHeader.OrderDate) = @year and month(Sales.SalesOrderHeader.OrderDate) = @month
		and Production.Product.[Name] = @prod
)

select * from dbo.getProductSoldAtLeastOnce(8, 2005, 'Sport-100 Helmet, Red')
