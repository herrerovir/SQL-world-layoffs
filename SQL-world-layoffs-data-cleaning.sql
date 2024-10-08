/* World layoffs - Data cleaning project by Virginia Herrero */

/* This project focuses on cleaning and preparing the dataset for further exploratory analysis. 
   The cleaning process consists on removing duplicated data, standardize data, remove null values and unnecessary columns to ensure the integrity of the dataset. 
   The cleaned dataset will provide more accurate and insightful analysis, leading to a better understanding of global tendencies.
*/

-- DATA STAGING
-- Show database
SELECT *
FROM layoffs;

-- Create a copy of the layoffs table
CREATE TABLE layoffs_staging
LIKE layoffs;

-- Insert data from the original table to the staging table
INSERT layoffs_staging
SELECT *
FROM layoffs;

-- DUPLICATES
-- Handle duplicates
-- This query creates an row_number function to act as index since it does not exist in the dataset
SELECT *,
	ROW_NUMBER() OVER(
		PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

-- Find duplicates
-- This CTE query fetches the duplicated data
WITH duplicate_cte AS
(
SELECT *, 
	ROW_NUMBER() OVER(
		PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)

SELECT * 
FROM duplicate_cte
WHERE row_num > 1;

-- Create copy of the data
-- This query creates an staging table to ensure that the original data is not modified or deleted by mistake
CREATE TABLE `layoffs_staging2` (
`company` text,
`location`text,
`industry`text,
`total_laid_off` int,
`percentage_laid_off` text,
`date` text,
`stage`text,
`country` text,
`funds_raised_millions` int,
`row_num` int
);

SELECT * 
FROM layoffs_staging2;

-- Insert data into the new staging table
-- This query inserts the data from the layoffs_staging table to the new staging table
INSERT INTO layoffs_staging2
SELECT *, 
	ROW_NUMBER() OVER(
	PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

-- Select the duplicates in the new table
-- This query shows the duplicated values in the new staging table
SELECT * 
FROM layoffs_staging2
WHERE row_num > 1;

-- Delete the duplicates
-- This query deletes all the duplicated values from the table
DELETE
FROM layoffs_staging2
WHERE row_num > 1;

-- STANDARDIZE DATA
-- Clean company names
-- This query removes blank spaces from the companies names
SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

-- Correct faulty data
-- This query removes incorrect industry names
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE industry LIKE "Crypto%";

UPDATE layoffs_staging2
SET industry = "Crypto"
WHERE industry LIKE "Crypto%";

-- Show all industry names are now clean and correct
SELECT DISTINCT industry
FROM layoffs_staging2;

-- Check location for incorrect data. All are correct
SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;

-- Check country for incorrect data 
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

-- Correct wrong country spelling
-- This query removes the dot from the country name
SELECT DISTINCT country, TRIM(TRAILING "." FROM country)
FROM layoffs_staging2
ORDER BY 1;

-- Update table
-- This query updates the staging table 2 with the new spelling
UPDATE layoffs_staging2
SET country = TRIM(TRAILING "." FROM country)
WHERE country LIKE "United States%";

-- Change date format
-- This query changes the column date from string to date format
SELECT `date`,
STR_TO_DATE(`date`, "%m/%d/%Y")
FROM layoffs_staging2;

-- Update table
-- This query updates the table with the new date format
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, "%m/%d/%Y");

-- Change date column type
-- This query alter the table to change the data type of the column date
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- NULL VALUES
-- Select null values
SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Transform industry blank values to null values
UPDATE layoffs_staging2
SET industry = NULL 
WHERE industry = "";

-- Select null or blank values in the industry column
SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = "";

-- Populate null values
-- This query joins the staging table 2 to find the industry values to populate the null values
SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
	AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = "")
AND t2.industry IS NOT NULL;

-- Update the table 
-- This query updats the table and populate null values with the industry values from the join table
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- This null value cannot be populated because there is not data to fill it with
SELECT *
FROM layoffs_staging2
WHERE company LIKE "Bally%";

-- REMOVE UNNECESSARY COLUMNS OR ROWS
/* All these null values will be removed because the columns will be further analysed
and the null values alter the results of the analysis */
SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * 
FROM layoffs_staging2;

-- Drop row_num column
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

-- CLEAN DATASET
SELECT * 
FROM layoffs_staging2;
