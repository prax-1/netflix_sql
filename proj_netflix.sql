
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(show_id VARCHAR(6) ,
typ VARCHAR (10) ,
title VARCHAR (150) ,
director VARCHAR(208) ,
casts VARCHAR (1000) ,
country VARCHAR(150) ,
date_added VARCHAR(50) ,
release_year INT ,
rating VARCHAR(10),
duration VARCHAR(15),
listed_in VARCHAR (100) ,
description VARCHAR(250)
);


select * from netflix;


--1st Ques
select typ, count(*) from netflix group by 1;

--2nd Ques
select typ, rating from 
(select typ, rating, count(*), RANK() OVER(partition by typ order by count(*) desc) as ranking from netflix group by typ, rating)
as tl where ranking = '1';


--3rd Ques
select title, release_year from netflix where release_year = 2020 and typ = 'Movie';


-- 4th Ques
select UNNEST(STRING_TO_ARRAY(country, ',')) as new, count(typ) from netflix group by country order by count(typ) desc limit 5;


-- 5th Ques
-- with count
select duration, count(*) from netflix where typ='Movie' and duration = (select max(duration) from netflix) group by duration;

--without count (all names)
select duration, title from netflix where typ='Movie' and duration = (select max(duration) from netflix);



-- 6th Ques
select title from netflix where TO_DATE(date_added, 'Month DD, YYYY') > current_date - INTERVAL '5 Years';

-- 7th Ques
select title, director from netflix where director like '%Rajiv Chilaka%';

-- 8th Ques
select title, duration, SPLIT_PART(duration, ' ', 1) as durn from netflix where typ = 'TV Show' and duration ilike '%seasons' and SPLIT_PART(duration, ' ', 1)>'5';

-- 9th Ques

select count(show_id), UNNEST(STRING_TO_ARRAY(listed_in, ',')) as genre from netflix group by 2;

-- 10th ques(percentage)
select release_year, (count(show_id)::numeric/(Select count(*) from netflix where country = 'India')::numeric)*100 as Shows from netflix where country='India' group by release_year order by 2 desc limit 5;

-- 11th Ques
select title from netflix where listed_in ilike '%documentaries%' and typ ilike '%Movie%'; 

--12th Ques
select title, director from netflix where director is null;


--13th Ques
select title, typ, release_year from netflix where casts ilike '%salman khan%' and (EXTRACT(YEAR FROM CURRENT_DATE) - release_year) <= 10;

-- 14th Ques

select  count(show_id), UNNEST(STRING_TO_ARRAY(casts, ',')) from netflix group by 2 order by 1 desc limit 10;

-- 15th Ques
select show_id, title from netflix where description ilike '%kill%' or description ilike '%violence%';

select count(show_id), CASE
					   WHEN description ilike '%kill%' or description ilike '%violence%' THEN 'Bad'
					   else 'Good' end Label
from netflix group by 2;
