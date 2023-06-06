/****** Script for SelectTopNRows command from SSMS  ******/

select * from car_makes

select * from [car_models]

select * 
from car_makes cm
inner join [car_models] cmo
on cm.make_ID = cmo.make_ID

	



