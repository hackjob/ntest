-- Question 2, section B 
use Nephila_Metarisks_Candidate_Sample
go

-- utilizing Aaron Bertrand's simple CTE
-- http://sqlperformance.com/2012/07/t-sql-queries/split-strings

CREATE FUNCTION dbo.SplitStrings_CTE
(
   @List       NVARCHAR(MAX),
   @Delimiter  NVARCHAR(255)
)
RETURNS @Items TABLE (Item NVARCHAR(4000))
WITH SCHEMABINDING
AS
BEGIN
   DECLARE @ll INT = LEN(@List) + 1, @ld INT = LEN(@Delimiter);
 
   WITH a AS
   (
       SELECT
           [start] = 1,
           [end]   = COALESCE(NULLIF(CHARINDEX(@Delimiter, 
                       @List, 1), 0), @ll),
           [value] = SUBSTRING(@List, 1, 
                     COALESCE(NULLIF(CHARINDEX(@Delimiter, 
                       @List, 1), 0), @ll) - 1)
       UNION ALL
       SELECT
           [start] = CONVERT(INT, [end]) + @ld,
           [end]   = COALESCE(NULLIF(CHARINDEX(@Delimiter, 
                       @List, [end] + @ld), 0), @ll),
           [value] = SUBSTRING(@List, [end] + @ld, 
                     COALESCE(NULLIF(CHARINDEX(@Delimiter, 
                       @List, [end] + @ld), 0), @ll)-[end]-@ld)
       FROM a
       WHERE [end] < @ll
   )
   INSERT @Items SELECT [value]
   FROM a
   WHERE LEN([value]) > 0
   OPTION (MAXRECURSION 0);
 
   RETURN;
END
GO

--- create temp table
create table #NSTRING (field1 char(30))
insert into #NSTRING values('a,b,c,d,e,f,g,NULL,h,,I')
select * from #NSTRING
go

-- exec splitstrings 
declare @inList varchar(30)
set @inList = (select field1 from #NSTRING)
select Item from dbo.splitstrings_cte( @inList , ',');
go

