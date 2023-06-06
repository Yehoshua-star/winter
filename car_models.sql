/****** Object:  Table [dbo].[cars]    Script Date: 5/31/2023 3:00:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--1. Create temp cars table for data import

CREATE TABLE [dbo].[car_makes_temp](
	[make] [nchar](30) NOT NULL,
	[model] [nchar](30) NOT NULL)
GO

--1b. Create permanent car_makes tables

CREATE TABLE [dbo].[car_makes](
	[make_ID] [int] IDENTITY(1,1) NOT NULL,
	[make] [nchar](30) NOT NULL,
 CONSTRAINT [PK_cars] PRIMARY KEY CLUSTERED 
(
	[make_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--2. Populate car_makes_temp table

INSERT INTO [dbo].[car_makes_temp]   ([make] ,[model]) VALUES ('Mitsubishi' ,'Eclipse')
INSERT INTO [dbo].[car_makes_temp]   ([make] ,[model]) VALUES ('Mitsubishi',  'Outlander')
INSERT INTO [dbo].[car_makes_temp]   ([make] ,[model]) VALUES ('Hyundai', 'i30')
INSERT INTO [dbo].[car_makes_temp]   ([make] ,[model]) VALUES ('Ram',   '1500')
INSERT INTO [dbo].[car_makes_temp]   ([make] ,[model]) VALUES ('Ford'   ,'F150')
INSERT INTO [dbo].[car_makes_temp]   ([make] ,[model]) VALUES ('BMW' ,'335i')
INSERT INTO [dbo].[car_makes_temp]   ([make] ,[model]) VALUES ('BMW', '330i')

--2b. INsert distinct makes into car_makes table

INSERT INTO [dbo].[car_makes]
           ([make])
select distinct make
from [car_makes_temp];

--3. Create car_models table to hold the models of cars with Primary Key and FK column car_ID

CREATE TABLE [dbo].car_models(
	[model_ID] [int] IDENTITY(1,1) NOT NULL,
	[model] [nchar](30) NOT NULL,
	[make_ID] int NOT NULL,
CONSTRAINT PK_car_models PRIMARY KEY (model_ID)
) ON [PRIMARY]
GO

--4. Create FK on car_models table

ALTER TABLE dbo.car_models
ADD CONSTRAINT FK_cars
FOREIGN KEY (make_ID) REFERENCES car_makes(make_ID);

--5. Populate the car_models table with model data from cars table

INSERT INTO [dbo].[car_models]
           ([model]
           ,[make_ID])
	SELECT cmt.model, cm.make_ID
	FROM car_makes_temp cmt
	inner join car_makes cm
	on cm.make = cmt.make

GO

--6. Clean up temp data - drop table [dbo].[car_makes_temp]

drop table [dbo].[car_makes_temp];


