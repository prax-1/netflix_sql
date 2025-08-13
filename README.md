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
'''sql
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
'''
