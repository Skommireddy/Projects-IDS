use ids3db;
describe USArrests;
select * from USArrests;
SET SQL_SAFE_UPDATES = 0;
/* updating blank value to NULL */
update USArrests
set Assault = null
where (State='Georgia') and (Murder=17.4) and (UrbanPop = 60);
select * from USArrests;
/* finding the average value of column Assault */
select 
	@avg_assault := format(avg(Assault),2) as avg_assault
from USArrests;
/* finding the NULL values from the table */
select * 
from USArrests 
where Assault is null;
/* updating average value to NULL value */
update USArrests
set Assault = @avg_assault
where Assault is null;

select * from USArrests;
/* finding mean, median, mean and varience */
select max(Murder),min(Murder), format(avg(Murder),2), format(variance(Murder),2)
from USArrests;
select max(Assault),min(Assault), format(avg(Assault),2), format(variance(Assault),2)
from USArrests;
select max(UrbanPop),min(UrbanPop), format(avg(UrbanPop),2), format(variance(UrbanPop),2)
from USArrests;
/* finding the state which has maximum murder rate */
select state, Murder from USArrests where Murder = (select max(Murder) from USArrests);
/* List of states in ascending order of urban population percentages.*/
select State, UrbanPop 
from USArrests
order by UrbanPop asc;
/* List of states having higher murder rates than Arizona */
select state, found_rows() as state_count
from(select state
from USArrests where murder > (select murder from USArrests where state = 'Arizona')
group by state)s;


describe childmortality;
select * from childmortality;
/* updating the blank values to NULL in all three columns*/
SET SQL_SAFE_UPDATES = 0;
update childmortality
set underfivemortalityrate = null
where underfivemortalityrate = 0;
update childmortality
set infantmortalityrate = null
where infantmortalityrate = 0;
update childmortality
set neonatalmortalityrate = null
where neonatalmortalityrate = 0;

select *from childmortality;

/* finding the median of three mortality rates and updating them with the NULL*/
/* median of underfivemortalityrate */
SET @row_index := -1;
update childmortality
set underfivemortalityrate =
(SELECT AVG(subq.underfivemortalityrate) as under_median_value
FROM (
    SELECT @row_index:=@row_index + 1 AS row_index, underfivemortalityrate
    FROM childmortality
    ORDER BY underfivemortalityrate
  ) AS subq
  WHERE subq.row_index 
  IN (FLOOR(@row_index / 2) , CEIL(@row_index / 2))) where underfivemortalityrate is null;
select * from childmortality;
/* median of Infantmortalityrate */
SET @row_index := -1; 
update childmortality
set Infantmortalityrate = 
(SELECT AVG(subq.Infantmortalityrate) as infant_median_value
FROM (
    SELECT @row_index:=@row_index + 1 AS row_index, Infantmortalityrate
    FROM childmortality
    ORDER BY Infantmortalityrate
  ) AS subq
  WHERE subq.row_index 
  IN (FLOOR(@row_index / 2) , CEIL(@row_index / 2))) where Infantmortalityrate is null;
/* median of Neonatalmortalityrate */
SET @row_index := -1;
update childmortality
set Neonatalmortalityrate =
(SELECT AVG(subq.Neonatalmortalityrate) as neo_median_value
FROM (
    SELECT @row_index:=@row_index + 1 AS row_index, Neonatalmortalityrate
    FROM childmortality
    ORDER BY Neonatalmortalityrate
  ) AS subq
  WHERE subq.row_index 
  IN (FLOOR(@row_index / 2) , CEIL(@row_index / 2))) where Neonatalmortalityrate is null;
  
select * from childmortality;
/* finding the lowest and highest infant mortality years */
select year, infantmortalityrate,"Minmortalityrate" as category from childmortality 
where infantmortalityrate = (select min(infantmortalityrate) from childmortality)
union all
select year, infantmortalityrate,"Maxmortalityrate" as category from childmortality 
where infantmortalityrate = (select max(infantmortalityrate) from childmortality);

/* finding the years with neonatal mortality rates which are above average */
select year, neonatalmortalityrate from childmortality where neonatalmortalityrate > (select 
avg(neonatalmortalityrate) as avg_neonatal from childmortality);
/* sorting infant mortality rates in descending order */
select infantmortalityrate from childmortality order by infantmortalityrate desc;

select * from childmortality;
/* finding max, min, mean, variance, and standard deviation for each mortality rate */
select max(underfivemortalityrate),min(underfivemortalityrate), format(avg(underfivemortalityrate),2), format(variance(underfivemortalityrate),2), format(std(underfivemortalityrate),2)
from childmortality;
select max(infantmortalityrate),min(infantmortalityrate), format(avg(infantmortalityrate),2), format(variance(infantmortalityrate),2), format(std(infantmortalityrate),2)
from childmortality;
select max(neonatalmortalityrate),min(neonatalmortalityrate), format(avg(neonatalmortalityrate),2), format(variance(neonatalmortalityrate),2), format(std(neonatalmortalityrate),2)
from childmortality;
/* Adding a new column called Above-Five Mortality Rate and populating it with appropriate values */
alter table childmortality
add abovefivemortalityrate float;
SET SQL_SAFE_UPDATES = 0;
update childmortality set abovefivemortalityrate = format(((underfivemortalityrate - infantmortalityrate) + (infantmortalityrate - neonatalmortalityrate)) / 2,1);
select * from childmortality;




  


 

