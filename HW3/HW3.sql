use ids3db;
describe Life_Expectancy;
select * from Life_Expectancy;
select count(*) from Life_Expectancy;
SET SQL_SAFE_UPDATES = 0;
select * from Life_Expectancy where population = 0;
delete from Life_Expectancy where population = 0;
select count(*) from Life_Expectancy;
#updating mean of Life_Expectancy to null values
SET SQL_SAFE_UPDATES = 0;
update Life_Expectancy
set Life_Expectancy = null
where Life_Expectancy = 0;
select 
@avg_Life_Expectancy := format(avg(Life_Expectancy),2) as Life_Expectancy
from Life_Expectancy;
update Life_Expectancy
set Life_Expectancy = @avg_Life_Expectancy
where Life_Expectancy is null;
#updating mean of Adult_Mortality to null values
SET SQL_SAFE_UPDATES = 0;
update Life_Expectancy
set Adult_Mortality = null
where Adult_Mortality = 0;
select 
	@avg_Adult_Mortality := format(avg(Adult_Mortality),2) as Adult_Mortality
from Life_Expectancy;
update Life_Expectancy
set Adult_Mortality = @avg_Adult_Mortality
where Adult_Mortality is null;
#updating mean of Alcohol to null values
SET SQL_SAFE_UPDATES = 0;
update Life_Expectancy
set Alcohol = null
where Alcohol = 0;
select 
	@avg_Alcohol := format(avg(Alcohol),2) as Alcohol
from Life_Expectancy;
update Life_Expectancy
set Alcohol = @avg_Alcohol
where Alcohol is null;
#updating mean of Percentage_Expenditure to null values
SET SQL_SAFE_UPDATES = 0;
update Life_Expectancy
set Percentage_Expenditure = null
where Percentage_Expenditure = 0;
select 
	@avg_Percentage_Expenditure := round(avg(Percentage_Expenditure),8) as Percentage_Expenditure
from Life_Expectancy;
update Life_Expectancy
set Percentage_Expenditure = @avg_Percentage_Expenditure
where Percentage_Expenditure is null;
#updating mean of BMI to null values
SET SQL_SAFE_UPDATES = 0;
update Life_Expectancy
set BMI = null
where BMI = 0;
select 
	@avg_BMI := round(avg(BMI),2) as BMI
from Life_Expectancy;
update Life_Expectancy
set BMI = @avg_BMI
where BMI is null;
#updating mean of Total_Expenditure to null values
SET SQL_SAFE_UPDATES = 0;
update Life_Expectancy
set Total_Expenditure = null
where Total_Expenditure = 0;
select 
	@avg_Total_Expenditure := format(avg(Total_Expenditure),2) as Total_Expenditure
from Life_Expectancy;
update Life_Expectancy
set Total_Expenditure = @avg_Total_Expenditure
where Total_Expenditure is null;
#updating mean of GDP to null values
SET SQL_SAFE_UPDATES = 0;
update Life_Expectancy
set GDP = null
where GDP = 0;
select 
	@avg_GDP := round(avg(GDP),6) as GDP
from Life_Expectancy;
update Life_Expectancy
set GDP = @avg_GDP
where GDP is null;
#updating mean of Schooling to null values
SET SQL_SAFE_UPDATES = 0;
update Life_Expectancy
set Schooling = null
where Schooling = 0;
select 
	@avg_Schooling := format(avg(Schooling),2) as Schooling
from Life_Expectancy;
update Life_Expectancy
set Schooling = @avg_Schooling
where Schooling is null;
#countries with the highest and lowest average mortality rates
(select Country, Adult_Mortality, 'Lowest' as Average from 
(select distinct Country, avg(Adult_Mortality) as Adult_Mortality from Life_Expectancy group by Country)S
order by Adult_Mortality limit 1)
union
(select Country, Adult_Mortality, 'Highest' as Average from 
(select distinct Country, avg(Adult_Mortality) as Adult_Mortality from Life_Expectancy group by Country)S
order by Adult_Mortality Desc limit 1);
#countries with the highest and lowest average population
(select Country, Population, 'Lowest' as Average from 
(select distinct Country, avg(Population) as Population from Life_Expectancy group by Country)S
order by Population limit 1)
union
(select Country, Population, 'Highest' as Average from 
(select distinct Country, avg(Population) as Population from Life_Expectancy group by Country)S
order by Population Desc limit 1);
#countries with the highest and lowest average GDP
(select Country, GDP, 'Lowest' as Average from 
(select distinct Country, avg(GDP) as GDP from Life_Expectancy group by Country)S
order by GDP limit 1)
union
(select Country, GDP, 'Highest' as Average from 
(select distinct Country, avg(GDP) as GDP from Life_Expectancy group by Country)S
order by GDP Desc limit 1);
#countries with the highest and lowest average Schooling
(select Country, Schooling, 'Lowest' as Average from 
(select distinct Country, round(avg(Schooling),2) as Schooling from Life_Expectancy group by Country)S
order by Schooling limit 1)
union
(select Country, Schooling, 'Highest' as Average from 
(select distinct Country, round(avg(Schooling),2) as Schooling from Life_Expectancy group by Country)S
order by Schooling Desc limit 1);
#countries have the highest and lowest average alcohol consumption
(select Country, Alcohol, 'Lowest' as Average from 
(select distinct Country, avg(Alcohol) as Alcohol from Life_Expectancy group by Country)S
order by Alcohol limit 1)
union
(select Country, Alcohol, 'Highest' as Average from 
(select distinct Country, avg(Alcohol) as Alcohol from Life_Expectancy group by Country)S
order by Alcohol Desc limit 1);
#Do densely populated countries tend to have lower life expectancy
(select Country, Population, Life_Expectancy from 
(select distinct Country, avg(Population) as Population, avg(Life_Expectancy) as Life_Expectancy from Life_Expectancy group by Country)S
order by Life_Expectancy limit 1)
union
(select Country, Population, Life_Expectancy from 
(select distinct Country, avg(Population) as Population, avg(Life_Expectancy) as Life_Expectancy from Life_Expectancy group by Country)S
order by Life_Expectancy Desc limit 1);