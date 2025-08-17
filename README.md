
## Netflix Movies & TV Shows Analysis – Data Pipeline & SQL Insights

Building a complete data pipeline for cleaning, transforming, and analyzing Netflix content data using Python and SQL Server.

📌 **Table of Contents**

- [Overview](#overview)
- [Business Problem](#business-problem)
- [Dataset](#dataset)
- [Tools & Technologies](#tools--technologies)
- [Project Structure](#project-structure)
- [Data Cleaning & Preparation](#data-cleaning--preparation)
- [Exploratory Data Analysis (EDA)](#exploratory-data-analysis-eda)
- [Research Questions & Key Findings](#research-questions--key-findings)
- [Final Recommendations](#final-recommendations)


## Overview

This project analyzes the Netflix Movies & TV Shows dataset to uncover trends, clean inconsistencies, and answer key business questions. A complete data pipeline was built:

- Python to ingest and load raw data into SQL Server

- SQL scripts for data cleaning, transformation, and modeling

- SQL queries to answer predefined research questions

### Business Problem

Netflix manages thousands of movies and shows across multiple countries. The dataset contains inconsistencies such as missing values, duplicates, and foreign characters. The project aims to:

- Standardize and clean the dataset for reliable analysis

- Identify patterns in Netflix content distribution (movies vs. TV shows, by country, by release year)

- Explore key business insights such as the availability of content across countries and categories


## Dataset

- Source: Publicly available Netflix dataset (https://www.kaggle.com/datasets/shivamb/netflix-shows)

- Contents: Titles, Type (Movie/TV Show), Director, Cast, Country, Date Added, Release Year, Rating, Duration, Genre

- Format: CSV file loaded into SQL Server via Python

## Tools & Technologies

- Python: Data ingestion and loading (Pandas, pyodbc / SQLAlchemy)

- SQL Server:
 
- (a) Raw Data Layer

- (b) Staging Layer for transformations

- (c) Final Layer for cleaned data and analysis

- SQL: Joins, Aggregations, Case statements, Window functions

- Jupyter Notebook: Initial dataset handling and automation


## Project Structure

![Image](https://github.com/user-attachments/assets/4277f6c0-d93d-48f7-a716-3b1cc616509c)

![Image](https://github.com/user-attachments/assets/79fdbbd5-ba73-40b9-88ab-29a1164a6b63)


## Data Cleaning & Preparation

Steps performed in SQL Server:

- Handling foreign/unicode characters

- Removing duplicates

- Data type conversions (dates, numeric fields)

- Identifying and populating missing values

- Creating a new dimension table for countries

- Building a clean staging table for analysis


## Exploratory Data Analysis (EDA)

- Distribution of Movies vs. TV Shows

- Most frequent countries contributing content

- Trend of content added over years

- Ratings distribution (TV-MA, PG, R, etc.)

- Popular genres/categories


## Research Questions & Key Findings

# 1.Which directors have created both Movies and TV Shows?

- 75+ directors contributed to both formats.

- Notable examples: Anurag Kashyap (8 Movies, 1 TV Show), Ken Burns (2 Movies, 3 TV Shows), Joe Berlinger (3 Movies, 2 TV Shows).

# 2.Which country has the highest number of Comedy Movies?

- United States leads with 685 Comedy titles, showing strong dominance in global entertainment.

# 3.For each year, which director released the maximum movies on Netflix?

- Directors like Jan Suter (2016, 2018) and Rajiv Chilaka (2021 – 17 movies) stood out.

- Clear trend of rising volume of releases post-2015, aligning with Netflix’s global expansion.

# 4.What is the average duration of Movies across genres?

- Longest: Classic Movies (118 mins), Dramas & Action/Adventure (~113 mins).

- Shortest: Stand-Up Comedy (67 mins) and Children & Family (79 mins).

- Indicates genre-specific content strategies—shorter runtime for lighter formats, longer for story-driven ones.

# 5.Which directors have created both Horror and Comedy Movies?

- 50+ directors crossed genres, showing versatility.

- Examples: Kevin Smith (5 Horror, 3 Comedy), McG (4 Horror, 2 Comedy), Tim Burton (2 Horror, 1 Comedy).


## Final Recommendations

- Diversify Content Formats: Many directors already create both Movies and TV Shows; Netflix can leverage these creators to expand successful franchises across formats.

- Strengthen Global Comedy Portfolio: With the U.S. dominating Comedy content (685 titles), Netflix should encourage regional comedy production to appeal to diverse audiences.

- Capitalize on High-Output Directors: Directors like Rajiv Chilaka (17 movies in 2021) and Jan Suter show high productivity—partnering with them can ensure consistent content flow.

- Optimize Genre Durations: Maintain shorter formats (Stand-Up, Children & Family) for engagement, while preserving longer runtimes for Dramas/Action that require storytelling depth.

- Promote Multi-Genre Directors: Directors active in both Horror & Comedy (e.g., Kevin Smith, McG, Tim Burton) could be tapped for innovative genre-blending originals.
