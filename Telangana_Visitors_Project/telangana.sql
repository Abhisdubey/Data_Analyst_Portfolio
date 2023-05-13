/****** Script for SelectTopNRows command from SSMS  ******/

use Telangana
SELECT TOP (10) [district]
      ,[date]
      ,[month]
      ,[year]
      ,[visitors]
  FROM [Telangana].[dbo].[domestic_visitors]

  select * from foreign_visitors

  ALTER TABLE foreign_visitors
ALTER COLUMN visitors decimal;

   with newtable as(
 select * from foreign_visitors_2019
  union
   select * from domestic_visitors_2019
 )

select sum(visitors) from newtable

select  sum(visitors) from domestic_visitors_2019

  -- ----------  1st question--------------------------------------------------------------------------------------------------
  select  top 10 district, SUM(visitors) visitors from domestic_visitors
  group by district order by visitors desc

  select  top 4 district, SUM(visitors) visitors from Foreign_visitors
  group by district order by visitors desc

  ------ --   2nd question---------------------------------------------------------------------------------------------------------

select top 3 district,
CASE
        WHEN sum(case when year= '2016' then visitors end) = 0
            THEN NULL
		else
			round(POWER(SUM(CASE WHEN year = '2019' THEN visitors END) / SUM(CASE WHEN year = '2016' THEN visitors END), 0.333333333) - 1,4)*100
			
			end as cagr

			from Domestic_visitors

group by district 
order by cagr desc

select top 3 district,
CASE
        WHEN sum(case when year= '2016' then visitors end) = 0
            THEN NULL
		else
			round(POWER(SUM(CASE WHEN year = '2019' THEN visitors END) / SUM(CASE WHEN year = '2016' THEN visitors END), 0.333333333) - 1,4)*100
			
			end as cagr

			from Foreign_visitors

group by district 
order by cagr desc

 ------ --   3rd question-------------------------------------------------------------------------------------------------------------

select top 3 district,
CASE
        WHEN sum(case when year= '2016' then visitors end) = 0
            THEN 0
		
		else
			coalesce(round(POWER(SUM(CASE WHEN year = '2019' THEN visitors END) / SUM(CASE WHEN year = '2016' THEN visitors END), 0.333333333) - 1,4)*100,00000)
			end as cagr

			from Domestic_visitors

group by district 
order by cagr 


select top 3 district,
CASE
        WHEN sum(case when year= '2016' then visitors end) = 0
            THEN 0
		
		else
			coalesce(round(POWER(SUM(CASE WHEN year = '2019' THEN visitors END) / SUM(CASE WHEN year = '2016' THEN visitors END), 0.333333333) - 1,4)*100,00000)
			end as cagr

			from foreign_visitors

group by district 
order by cagr 

-------  4th question-----------------------------------------------------------------------------------------------------
select district,month, sum(visitors) as total_visitors
from Domestic_visitors
where district='Hyderabad'
group by district,month
order by total_visitors desc,month 

select district,month, sum(visitors) as total_visitors
from Foreign_visitors
where district='Hyderabad'
group by district,month
order by total_visitors desc,month 

-------- 5th question-------------------------------------------------------------------------------------------------

with cte as (

SELECT dv.district, sum(dv.visitors) as dv_vis , sum(fv.visitors) AS fv_visitors
FROM Domestic_visitors AS dv
JOIN Foreign_visitors AS fv
ON dv.district = fv.district
AND dv.date = fv.date
AND dv.month = fv.month
AND dv.year = fv.year
group by dv.district
having sum(dv.visitors) is not null and sum(fv.visitors) !=0)

select top 3 *,round(dv_vis/fv_visitors,0) as ratio from cte
order by ratio

with cte as (

SELECT dv.district, sum(dv.visitors) as dv_vis , sum(fv.visitors) AS fv_visitors
FROM Domestic_visitors AS dv
JOIN Foreign_visitors AS fv
ON dv.district = fv.district
AND dv.date = fv.date
AND dv.month = fv.month
AND dv.year = fv.year
group by dv.district
having sum(dv.visitors) is not null and sum(fv.visitors) !=0)

select top 3 *,round(dv_vis/fv_visitors,0) as ratio from cte
order by ratio desc











  

