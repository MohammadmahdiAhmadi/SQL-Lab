USE [master]
GO
CREATE LOGIN [login_ahmadi] WITH PASSWORD=N'123', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO




USE [master]
GO
CREATE SERVER ROLE [Role1] AUTHORIZATION [login_ahmadi]
GO
ALTER SERVER ROLE [dbcreator] ADD MEMBER [Role1]
GO




USE [AdventureWorks2012]
GO
CREATE USER [user_ahmadi] FOR LOGIN [login_ahmadi]
GO




USE [AdventureWorks2012]
GO
ALTER ROLE [db_datareader] ADD MEMBER [user_ahmadi]
GO
ALTER ROLE db_owner ADD MEMBER [user_ahmadi]
GO
USE [AdventureWorks2012]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [user_ahmadi]
GO
USE [AdventureWorks2012]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [user_ahmadi]
GO




USE [AdventureWorks2012]
GO
CREATE TABLE table_ahmadi (
	column_ahmadi INT
)
INSERT INTO table_ahmadi (column_ahmadi) VALUES (1);
INSERT INTO table_ahmadi (column_ahmadi) VALUES (2);
INSERT INTO table_ahmadi (column_ahmadi) VALUES (3);
SELECT * FROM table_ahmadi;




USE [master]
GO
CREATE SERVER ROLE [Role2] AUTHORIZATION [login_ahmadi]
GO
ALTER SERVER ROLE [securityadmin] ADD MEMBER [Role2]
GO


