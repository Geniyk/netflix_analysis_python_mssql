
select * from netflix_raw

where show_id='s5023'



--handling foreign characters

--remove duplicates 
select show_id,COUNT(*) 
from netflix_raw
group by show_id 
having COUNT(*)>1

--title 
select title,COUNT(*) 
from netflix_raw
group by title 
having COUNT(*)>1
------
select * from netflix_raw
where title in 
(select title, type 
from netflix_raw
group by title, type
having COUNT(*)>1
)
order by title
-----
select * from netflix_raw
where concat(upper(title),type)  in (
select concat(upper(title),type) 
from netflix_raw
group by upper(title) ,type
having COUNT(*)>1
)
order by title
-------
with cte as (
select * 
,ROW_NUMBER() over(partition by title , type order by show_id) as rn
from netflix_raw
)
select * from cte 
where rn =1;
-----------

--new table for listed_in,director, country,cast
---------new table for director
select show_id, trim(value) as director
from netflix_raw
cross apply string_split(director, ',');

select show_id, trim(value) as director
into netflix_directors
from netflix_raw
cross apply string_split(director, ',');

select * from netflix_directors;


---------new table for country
select show_id, trim(value) as country
from netflix_raw
cross apply string_split(country, ',');

select show_id, trim(value) as country
into netflix_country
from netflix_raw
cross apply string_split(country, ',');

select * from netflix_country;


---------new table for listed_in
select show_id, trim(value) as listed_in
from netflix_raw
cross apply string_split(listed_in, ',');


select show_id , trim(value) as listed_in
into netflix_listed_in
from netflix_raw
cross apply string_split(listed_in,',')

select * from netflix_listed_in
 
 select * from [dbo].[netflix]

---------new table for cast
select show_id, trim(value) as cast
from netflix_raw
cross apply string_split(cast, ',');

select show_id, trim(value) as cast
into netflix_cast
from netflix_raw
cross apply string_split(cast, ',');

select * from netflix_cast ;


--------data type conversions for date added 
with cte as (
select * ,
ROW_NUMBER() over(partition by title , type order by show_id) as rn
from netflix_raw
)
select show_id,type,title,cast(date_added as date) as date_added,release_year
,rating,case when duration is null then rating else duration end as duration,description
into netflix
from cte 

select * from netflix
 
--populate missing values in country,duration columns
select * 
from netflix_raw
where country is null;

select * from netflix_country where show_id= 's101'


insert into netflix_country
select  show_id,m.country 
from netflix_raw nr
inner join (
select director,country
from  netflix_country nc
inner join netflix_directors nd on nc.show_id=nd.show_id
group by director,country
) m on nr.director=m.director
where nr.country is null

select * from netflix_raw where director='Ahishor Solomon'

select director,country
from  netflix_country nc
inner join netflix_directors nd on nc.show_id=nd.show_id
group by director,country
order by director
-------------------
select * from netflix_raw where duration is null

----------------------------------------------
--------data type conversions for date added 
with cte as (
select * ,
ROW_NUMBER() over(partition by title , type order by show_id) as rn
from netflix_raw
)
select show_id,type,title,cast(date_added as date) as date_added,release_year
,rating,case when duration is null then rating else duration end as duration,description
into netflix
from cte 

select * from netflix
--populate rest of the nulls as not_available
--drop columns director , listed_in,country,cast




--netflix data analysis

/*1  for each director count the no of movies and tv shows created by them in separate columns 
for directors who have created tv shows and movies both */
-------- part 1
select n.show_id, n.type, nd.director
from netflix n
inner join netflix_directors nd on n.show_id=nd.show_id

---- part 2
select nd.director 
,COUNT( distinct n.type) as distinct_type
from netflix n
inner join netflix_directors nd on n.show_id=nd.show_id
group by nd.director
order by distinct_type desc

--- part 3
select nd.director 
,COUNT(distinct case when n.type='Movie' then n.show_id end) as no_of_movies
,COUNT(distinct case when n.type='TV Show' then n.show_id end) as no_of_tvshow
from netflix n
inner join netflix_directors nd on n.show_id=nd.show_id
group by nd.director
having COUNT(distinct n.type)>1



-----2 which country has highest number of comedy movies 
--- part 1
select distinct listed_in from netflix_listed_in order by listed_in

--- part 2
select ng.show_id, nc.country
from netflix_listed_in ng
inner join netflix_country nc on ng.show_id=nc.show_id
where ng.listed_in='comdies'

---- part 3
select top 1  nc.country , COUNT(distinct ng.show_id ) as no_of_movies
from netflix_listed_in ng
inner join netflix_country nc on ng.show_id=nc.show_id
inner join netflix n on ng.show_id=nc.show_id
where ng.listed_in='Comedies' and n.type='Movie'
group by  nc.country
order by no_of_movies desc



--3 for each year (as per date added to netflix), which director has maximum number of movies released
select * from netflix

---- part 1
select YEAR(date_added) as date_year, nd.director, n.show_id
from netflix n
inner join netflix_directors nd on n.show_id=nd.show_id

--- part 2
select nd.director, YEAR(date_added) as date_year,count(n.show_id) as no_of_movies
from netflix n
inner join netflix_directors nd on n.show_id=nd.show_id
group by nd.director, YEAR(date_added)
order by no_of_movies desc

---- part 3
with cte as (
select nd.director,YEAR(date_added) as date_year,count(n.show_id) as no_of_movies
from netflix n
inner join netflix_directors nd on n.show_id=nd.show_id
where type='Movie'
group by nd.director,YEAR(date_added)
)
select *
, ROW_NUMBER() over(partition by date_year order by no_of_movies desc, director) as rn
from cte
order by date_year, no_of_movies desc


--- part 4
with cte as (
select nd.director,YEAR(date_added) as date_year,count(n.show_id) as no_of_movies
from netflix n
inner join netflix_directors nd on n.show_id=nd.show_id
where type='Movie'
group by nd.director,YEAR(date_added)
)
, cte2 as (
select *
, ROW_NUMBER() over(partition by date_year order by no_of_movies desc, director) as rn
from cte
-- order by date_year, no_of_movies desc
)
select * from cte2 where rn=1



--4 what is average duration of movies in each genre

--- part 1
select *, REPLACE(duration, ' min', '') as duration_int
from netflix
where type ='Movie'
 
----- part 2
select *, cast(REPLACE(duration, ' min', '') AS int) as duration_int
from netflix
where type ='Movie'

----- part 3
select ng.listed_in , avg(cast(REPLACE(duration,' min','') AS int)) as avg_duration
from netflix n
inner join netflix_listed_in ng on n.show_id=ng.show_id
where type='Movie'
group by ng.listed_in

--5  find the list of directors who have created horror and comedy movies both.
-- display director names along with number of comedy and horror movies directed by them 

select nd.director
, count(distinct case when ng.listed_in='Comedies' then n.show_id end) as no_of_comedy 
, count(distinct case when ng.listed_in='Horror Movies' then n.show_id end) as no_of_horror
from netflix n
inner join netflix_listed_in ng on n.show_id=ng.show_id
inner join netflix_directors nd on n.show_id=nd.show_id
where type='Movie' and ng.listed_in in ('Comedies','Horror Movies')
group by nd.director
having COUNT(distinct ng.listed_in)=2;


--- verify 
select * from netflix_listed_in where show_id in 
(select show_id from netflix_directors where director='Steve Brill')
order by listed_in

----- Steve Brill	5	1
