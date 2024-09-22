# 📉 Wordwide layoffs: data cleaning and exploratory analysis

This repository contains a data cleaning and exploratory data analysis project on worldwide layoffs using SQL. 

## Table of content
 - [Intro](https://github.com/herrerovir/SQL-world-layoffs/blob/main/README.md#Introduction)
 - [Goal](https://github.com/herrerovir/SQL-world-layoffs/blob/main/README.md#Goal)
 - [Project Overview](https://github.com/herrerovir/SQL-world-layoffs/blob/main/README.md#Project-Overview)
 - [Dependencies](https://github.com/herrerovir/SQL-world-layoffs/blob/main/README.md#Dependencies)
 - [Technical skills](https://github.com/herrerovir/SQL-world-layoffs/blob/main/README.md#Technical-skills)
 - [Data set](https://github.com/herrerovir/SQL-world-layoffs/blob/main/README.md#Data-set)
 - [Data Cleaning](https://github.com/herrerovir/SQL-world-layoffs/blob/main/README.md#Data-cleaning)
 - [Data Exploration](https://github.com/herrerovir/SQL-world-layoffs/blob/main/README.md#Data-exploration)
 - [Insights](https://github.com/herrerovir/SQL-world-layoffs/blob/main/README.md#Insights)

## Introduction
In this project, a global analysis of worldwide layoffs is performed using SQL to find valuable and useful information. 

The analysis workflow includes essential steps such as data loading, data cleaning, and data exploration using MySQL software.

## Goal
The overall purpose of this project is to explore the csv file dataset to obtain all relevant information about layoffs worldwide.

Once the schema is created and the dataset is loaded, it will be cleaned and preprocessed to undergo further exploration to obtain meaningful results.

By exploring and analyzing the data, we expect to find answers to the following points:

* Maximum amount of people laid off
* Maximum percentage of people laid off
* Count of companies that laid off everyone
* Companies that laid off everyone by number of people laid off
* Companies that closed down with the highes financing 
* Total sum of people laid off by companie
* Period of the layoffs
* Most affected industry
* Most affected country
* Year with most layoffs
* Status of the companies that laidoff
* Rolling total layoffs
* Top 5 companies with the most layoffs per year

## Project overview
   1. Data loading
   2. Data cleaning
   3. Data exploration
   4. Insights

## Dependencies
The following software is required to carry out this project:

* MySQL Workbench 8.0 CE

## Technical skills
The following skills were used throughout the implementation of this project:

* Database creation
* Data definition
* Data manipulation
* Data normalization
* Data querying

## Data set
The data for this analysis is loaded from a csv file which can be found uploaded in this repository.

The dataset consists of:
* 2361 entries
* 9 columns

## Data cleaning
Once the schema was created and the dataset was loaded into MySQL, it was required to clean it to ensure its integrity and reliability. 

Through MySQL's powerful query features, the raw, messy dataset was transformed into a clean, structured and reliable dataset suitable for further analysis.

## Data exploration
To obtain useful information from this dataset, an in-depth exploratory analysis was carried out. 

## Insights
The project successfully analyzed a large amount of data on layoffs worldwide. As expected from this project, the following questions were answered.

### **Maximum amount of people laid off**

The maximum amount of people laid off at once was: 12.000.

### **Maximum percentage of people laid off** 

The maximum percetage of people laid off was 1, which mean all the people in the company were fired.

### **Count of companies that laid off everyone**

116 companies laid off everyone from their staff. 

### **Companies that laid off everyone by number of people laid off**

The query retrieves all the companies that fired everyone. Here is shown the top 5 companies order by number of people fired.

| Company            | Total lay off |
| ------------------ | ------------- |
| Katerra            | 2434          |
| Butler Hospitality | 1000          |
| Deliv              | 669           |
| Jump               | 500           |  
| SEND               | 300           |

### **Companies that closed down with the highest financing**

The query retrieves all 116 the companies order by descending order. Here is shown the top 5 companies with the highest funding that laid off everyone.  

| Company             | Funds raised millions |
| ------------------- | --------------------- |
| Britishvolt         | 2400                  |
| Quibi               | 1800                  |
| Deliveroo Australia | 1700                  |
| BlockFi             | 1600                  |  
| Aura Financial      | 1000                  |

**Total sum of people laid off by company**

These are the top 5 companies that laid off the most people.

| Company             | SUM(total laid off)   |
| ------------------- | --------------------- |
| Amazon              | 18150                 |
| Google              | 12000                 |
| Meta                | 11000                 |
| Salesforce          | 10090                 |  
| Microsoft           | 10000                 |

### **Time of period of the layoffs**

The time period covered by this dataset goes from 11-March-2020 until 06-March-2023.

### **Industry types most affected by layoffs**

These are the top 5 industries most affected by layoffs worldwide.

The consumer and retail sectors were the most affected in these 3 years period. 

| Company             | SUM(total laid off)   |
| ------------------- | --------------------- |
| Consumer            | 45182                 |
| Retail              | 43613                 |
| Other               | 36289                 |
| Transportation      | 33748                 |  
| Finance             | 28344                 |

### **Countries most affected by layoffs**

Top 5 countried that were most affected by layoffs.

The US was the most affected country in the world by layoffs, followed by India which is also much more highly populated than the US. 

| Company             | SUM(total laid off)   |
| ------------------- | --------------------- |
| United States       | 256559                |
| India               | 35993                 |
| Netherlands         | 17220                 |
| Sweden              | 11264                 |  
| Brazil              | 10391                 |

### **Year with most layoffs**

The most affected year by layoffs was by far the year 2023. The dataset only stored data until March 2023 an so far, there were almost as much layoffs as in the previous years. The year 2020 - the year where the coronavirus pandemic took place - had half the layoffs as in the year 2022. Fewer people were let go in the year 2021.

| Year                | SUM(total laid off)   |
| ------------------- | --------------------- |
| 2023                | 125677                |
| 2022                | 160661                |
| 2021                | 15823                 |
| 2020                | 80998                 |  

### **Status of the companies that laidoff**

Most amount of companies that suffered layoffs were in post-IPO stages.

| Stage               | SUM(total laid off)   |
| ------------------- | --------------------- |
| Post-IPO            | 204132                |
| Unknown             | 40716                 |
| Acquired            | 27576                 |
| Series C            | 20017                 |  
| Series D            | 19225                 |

### **Rolling total layoffs**

Here is shown the rolling total layoffs.

| MONTH       | Rolling total  |
| ------------| -------------- |
| 2020-03     | 9628           |
| 2020-04     | 36338          |
| 2020-05     | 62142          |  
| 2020-06     | 69769          |
| 2020-07     | 76881          |
| 2020-08     | 78850          |
| 2020-09     | 79459          |
| 2020-10     | 79909          |  
| 2020-11     | 80146          |
| 2020-12     | 80998          |
| 2021-01     | 87811          |
| 2021-02     | 88679          |
| 2021-03     | 88726          |
| 2021-04     | 88987          |
| 2021-06     | 91421          |  
| 2021-07     | 91501          |
| 2021-08     | 93368          |
| 2021-09     | 93529          |
| 2021-10     | 93551          |
| 2021-11     | 95621          |  
| 2021-12     | 96821          |
| 2022-01     | 97331          |
| 2022-02     | 101016         |
| 2022-03     | 106730         |
| 2022-04     | 110858         |
| 2022-04     | 123743         |
| 2022-06     | 141137         |   
| 2022-07     | 157360         |
| 2022-08     | 170415         |
| 2022-09     | 176296         |
| 2022-10     | 193702         |
| 2022-11     | 247153         |  
| 2022-12     | 257482         |
| 2023-01     | 342196         |
| 2023-02     | 378689         |
| 2023-03     | 383159         |

### **Top 5 companies that laidoff most people per year**

Here is shown the top 5 companies that layoff more people per year. 

| Company     | Year  | Total laid off | Ranking |
| ------------|------ | ---------------| --------|
| Uber        | 2020  | 7525           | 1       |
| Booking.com | 2020  | 4375           | 2       |
| Groupon     | 2020  | 2800           | 3       |
| Swiggy      | 2020  | 2250           | 4       |
| Airbnb      | 2020  | 1900           | 5       |
| Bytedance   | 2021  | 3600           | 1       |
| Katerra     | 2021  | 2434           | 2       |
| Zillow      | 2021  | 2000           | 3       |
| Instacart   | 2021  | 1877           | 4       |
| WhiteHar Jr | 2021  | 1800           | 5       |
| Meta        | 2022  | 11000          | 1       |
| Amazon      | 2022  | 10150          | 2       |
| Cisco       | 2022  | 4100           | 3       |
| Peloton     | 2022  | 4084           | 4       |
| Carvana     | 2022  | 4000           | 5       |
| Philips     | 2022  | 4000           | 5       |
| Google      | 2023  | 12000          | 1       |
| Microsoft   | 2023  | 10000          | 2       |
| Ericsson    | 2023  | 8500           | 3       |
| Amazon      | 2023  | 8000           | 4       |
| Salesforce  | 2023  | 8000           | 4       |
| Dell        | 2023  | 6650           | 5       |
