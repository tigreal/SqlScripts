
-- show all events in given decade of birth (default to 1925)
ALTER PROC spDecade(
	@dob date = '19250101'
)

AS

-- get start and end of decade
DECLARE @StartYear int = year(@dob) - year(@dob) % 10

-- accumulate list of events in this decade
DECLARE @Events varchar(max) = ''
SELECT
	@Events = @Events + 

	-- usually need a separating comma
	CASE 
		WHEN len(@Events) > 0 THEN ','
		ELSE ''
	END + 

	-- add on this event name
	QUOTENAME(e.EventName,'''')

FROM
	tblEvent AS e
WHERE
	year(e.EventDate) between @StartYear and @StartYear + 9

-- now build up SQL to list these events
DECLARE @sql varchar(max) = 'SELECT * FROM tblEvent WHERE EventName IN (' + @Events + ')'

EXEC (@sql)
GO

spDecade