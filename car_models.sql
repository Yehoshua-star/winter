/****** Object:  Table [dbo].[cars]    Script Date: 5/31/2023 3:00:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--1. Drop & re-create basic cars table

DROP TABLE [dbo].[cars]
GO

CREATE TABLE [dbo].[cars](
	[make_ID] int IDENTITY(1,1) NOT NULL,
	[make] [nchar](30) NOT NULL,
	[model] [nchar](30) NOT NULL,
CONSTRAINT PK_cars PRIMARY KEY (make_ID)
) ON [PRIMARY]
GO

--2. Populate cars table

INSERT INTO [dbo].[cars]   ([make] ,[model]) VALUES ('Mitsubishi' ,'Eclipse')
INSERT INTO [dbo].[cars]   ([make] ,[model]) VALUES ('Mitsubishi',  'Outlander')
INSERT INTO [dbo].[cars]   ([make] ,[model]) VALUES ('Hyundai', 'i30')
INSERT INTO [dbo].[cars]   ([make] ,[model]) VALUES ('Ram',   '1500')
INSERT INTO [dbo].[cars]   ([make] ,[model]) VALUES ('Ford'   ,'F150')
INSERT INTO [dbo].[cars]   ([make] ,[model]) VALUES ('BMW' ,'335i')
INSERT INTO [dbo].[cars]   ([make] ,[model]) VALUES ('BMW', '330i')

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
FOREIGN KEY (make_ID) REFERENCES cars(make_ID);

--5. Populate the car_models table with model data from cars table

INSERT INTO [dbo].[car_models]
           ([model]
           ,[make_ID])
	SELECT model, make_ID
	FROM cars
GO

--6. Remove the model column from the cars table

  ALTER TABLE [dbo].[cars]
DROP COLUMN model;


