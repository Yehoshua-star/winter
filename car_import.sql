USE [DatabaseStar_project]
GO

--1. import new car makes

INSERT INTO [dbo].[car_makes]
           ([make])
     SELECT distinct [manufacturer]
  FROM [DatabaseStar_project].[dbo].[cars]
  where manufacturer not in (
  select make 
  from car_makes)
  
  --2. import model data

  ;WITH CTE(manufacturer, 
    model, 
	make_id,
    duplicatecount)
AS (SELECT c.manufacturer, 
			c.model,  
			cm.make_id,
           ROW_NUMBER() OVER(PARTITION BY c.manufacturer, 
											c.model	
           ORDER BY c.manufacturer, c.model) AS DuplicateCount
    FROM [cars] c
	inner join car_makes cm
  on cm.make = c.manufacturer
  where c.model is not null
	and manufacturer is not null
	and model is not null)

	INSERT INTO [dbo].[car_models]
           ([model]
           ,[make_ID])
SELECT left(model,30),
make_id
FROM CTE
where duplicatecount = 1;


