# Netflix Movies and TV Shows Data Analysis using SQL

![Netflix Logo](https://platform.theverge.com/wp-content/uploads/sites/2/chorus/uploads/chorus_asset/file/15844974/netflixlogo.0.0.1466448626.png?quality=90&strip=all&crop=1.2535702951444%2C0%2C97.492859409711%2C100&w=2400)

## Overview
This project focuses on an in-depth SQL analysis of Netflix’s movie and TV show catalog. The aim is to uncover meaningful insights and address specific business queries using the dataset. This README outlines the project’s purpose, the problems addressed, the implemented solutions, key findings, and final conclusions.

## Objectives

- Examine the distribution between movies and TV shows.
- Determine the most frequent ratings for both movies and TV shows.
- Analyze content based on release year, country of origin, and duration.
- Categorize and filter content according to specific conditions and keywords.

## Dataset

The dataset used in this project is publicly available on Kaggle:

- **Source:** [Netflix Movies and TV Shows Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Schema
```sql
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
```

## Business Problems and Solutions

### 1. Count the Number of Movies vs TV Shows

```sql
select typ, count(*) from netflix group by 1;
```

**Objective:** Determine the distribution of content types on Netflix.

### 2. Find the Most Common Rating for Movies and TV Shows

```sql
WITH RatingCounts AS (
select typ, rating from 
(select typ, rating, count(*), RANK() OVER(partition by typ order by count(*) desc) as ranking from netflix group by typ, rating)
as tl where ranking = '1';
```

**Objective:** Identify the most frequently occurring rating for each type of content.

### 3. List All Movies Released in a Specific Year (e.g., 2020)

```sql
select title, release_year from netflix where release_year = 2020 and typ = 'Movie';

```

**Objective:** Retrieve all movies released in a specific year.

### 4. Find the Top 5 Countries with the Most Content on Netflix

```sql
select UNNEST(STRING_TO_ARRAY(country, ',')) as new, count(typ) from netflix group by country order by count(typ) desc limit 5;

```

**Objective:** Identify the top 5 countries with the highest number of content items.

### 5. Identify the Longest Movie

```sql
select duration, title from netflix where typ='Movie' and duration = (select max(duration) from netflix);
```

**Objective:** Find the movie with the longest duration.

### 6. Find Content Added in the Last 5 Years

```sql
select title from netflix where TO_DATE(date_added, 'Month DD, YYYY') > current_date - INTERVAL '5 Years';

```

**Objective:** Retrieve content added to Netflix in the last 5 years.

### 7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'

```sql
select title, director from netflix where director like '%Rajiv Chilaka%';

```

**Objective:** List all content directed by 'Rajiv Chilaka'.

### 8. List All TV Shows with More Than 5 Seasons

```sql
select title, duration, SPLIT_PART(duration, ' ', 1) as durn from netflix where typ = 'TV Show' and duration ilike '%seasons' and SPLIT_PART(duration, ' ', 1)>'5';

```

**Objective:** Identify TV shows with more than 5 seasons.

### 9. Count the Number of Content Items in Each Genre

```sql
select count(show_id), UNNEST(STRING_TO_ARRAY(listed_in, ',')) as genre from netflix group by 2;

```

**Objective:** Count the number of content items in each genre.

### 10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!

```sql
select release_year, (count(show_id)::numeric/(Select count(*) from netflix where country = 'India')::numeric)*100 as Shows from netflix where country='India' group by release_year order by 2 desc limit 5;

```

**Objective:** Calculate and rank years by the average number of content releases by India.

### 11. List All Movies that are Documentaries

```sql
select title from netflix where listed_in ilike '%documentaries%' and typ ilike '%Movie%'; 

```

**Objective:** Retrieve all movies classified as documentaries.

### 12. Find All Content Without a Director

```sql
select title, director from netflix where director is null;

```

**Objective:** List content that does not have a director.

### 13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years

```sql
select title, typ, release_year from netflix where casts ilike '%salman khan%' and (EXTRACT(YEAR FROM CURRENT_DATE) - release_year) <= 10;

```

**Objective:** Count the number of movies featuring 'Salman Khan' in the last 10 years.

### 14. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India

```sql
select  count(show_id), UNNEST(STRING_TO_ARRAY(casts, ',')) from netflix group by 2 order by 1 desc limit 10;

```

**Objective:** Identify the top 10 actors with the most appearances in Indian-produced movies.

### 15. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords

```sql
select count(show_id), CASE
					   WHEN description ilike '%kill%' or description ilike '%violence%' THEN 'Bad'
					   else 'Good' end Label
from netflix group by 2;

```

**Objective:** Categorize content as 'Bad' if it contains 'kill' or 'violence' and 'Good' otherwise. Count the number of items in each category.
