/* World layoffs - Exploratory data analysis project by Virginia Herrero */

/* This project focuses on exploring the world layoffs dataset to gather insightful information. */

-- Select all data from the clean dataset
SELECT *
FROM layoffs_staging2;

-- Maximum amount of people laid off
-- This query shows the maximum amount of people laidoff at once
SELECT MAX(total_laid_off)
FROM layoffs_staging2;

-- Maximum percentaje of people laid off
-- This query retrieves the maximum percentage of people laidoff at once
SELECT MAX(percentage_laid_off)
FROM layoffs_staging2;

-- Companies that laid off everyone
-- This query fetches all the companies that laid off everyone
SELECT COUNT(percentage_laid_off)
FROM layoffs_staging2
WHERE percentage_laid_off = 1;

-- Most amount of people fired from companies that fired everyone
-- This query shows companies that laid off everyone by number of people fired
SELECT company, total_laid_off
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- Companies with highest funding that fired everyone
-- This query selects all companies that closed down by funds raised
SELECT company, funds_raised_millions
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- Total amount of people laidoff per company
-- This query calculates the total sum of people laid off per company
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Period of time of the layoffs
-- This query selects the time perios in which these laidoffs took place
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- Type of company that laid off more people
-- This query retrieves the type of industry that fired the most people
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- Countries with more layoffs
-- This query shows the countries that had more layoffs
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- Year with more layoffs
-- This query selects which year had the biggest layoffs
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

-- Company status at the time of the layoffs
-- This query obtains the status of the companies at the time of the layoffs
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- Rolling total layoffs
SELECT SUBSTRING(`date`, 1 , 7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1 , 7) IS NOT NULL
GROUP BY SUBSTRING(`date`, 1 , 7)
ORDER BY 1 ASC;

WITH Rolling_Total AS
(
	SELECT SUBSTRING(`date`, 1 , 7) AS `MONTH`, SUM(total_laid_off) AS total_off
	FROM layoffs_staging2
	WHERE SUBSTRING(`date`, 1 , 7) IS NOT NULL
	GROUP BY SUBSTRING(`date`, 1 , 7)
	ORDER BY 1 ASC
)
SELECT `MONTH`, total_off
, SUM(total_off) OVER (ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;

-- Top 5 companies that laidoff most people per year
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY company ASC;

WITH Company_Year (company, years, total_laid_off) AS
(
	SELECT company, YEAR(`date`), SUM(total_laid_off)
	FROM layoffs_staging2
	GROUP BY company, YEAR(`date`)
)
, Company_Year_Rank AS (
	SELECT *, 
	DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
	FROM Company_Year
	WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5;
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5;
