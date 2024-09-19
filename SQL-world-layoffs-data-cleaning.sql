-- World Layoffs: data cleaning

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

-- 1. Remove duplicates:
-- There is not an index column, so the row_number function will be used
SELECT *,
	ROW_NUMBER() OVER(
		PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

-- Find duplicates
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

-- Create another staging table to delete duplicates from it
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
INSERT INTO layoffs_staging2
SELECT *, 
	ROW_NUMBER() OVER(
	PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

-- Show the duplicates in the new table
SELECT * 
FROM layoffs_staging2
WHERE row_num > 1;

-- Delete the duplicates
DELETE
FROM layoffs_staging2
WHERE row_num > 1;

-- 2. Standardize the data

-- Remove blank spaces from the companies names
SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

-- Remove incorrect industry names
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE industry LIKE "Crypto%";

UPDATE layoffs_staging2
SET industry = "Crypto"
WHERE industry LIKE "Crypto%";

-- All industry names are now clean and correct
SELECT DISTINCT industry
FROM layoffs_staging2;

-- Check location for incorrect data. All are correct
SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;

-- Check country for incorrect data. Correct wrong country spelling 
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT country, TRIM(TRAILING "." FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING "." FROM country)
WHERE country LIKE "United States%";

-- Change date format
SELECT `date`,
STR_TO_DATE(`date`, "%m/%d/%Y")
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, "%m/%d/%Y");

-- Change date column type
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- 3. Null values

SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Transform industry blank values to null values
UPDATE layoffs_staging2
SET industry = NULL 
WHERE industry = "";

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = "";

-- Populate null values
-- Join the staging table 2 to find the industry values to populate the null values
SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
	AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = "")
AND t2.industry IS NOT NULL;

-- Update the table and populate null values with the industry values from the join table
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

-- 4. Remove columns or rows which are unnecessary

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

-- Clean dataset
SELECT * 
FROM layoffs_staging2;