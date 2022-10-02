
CREATE PROC uspChangingTables(
	@TableName varchar(max)
)
AS

-- list the results of the table passed in
DECLARE @sql varchar(max) = 'SELECT * FROM ' + @TableName

-- run the query contained in this variable
EXEC(@sql)

GO

EXEC uspChangingTables 'tblCountry'