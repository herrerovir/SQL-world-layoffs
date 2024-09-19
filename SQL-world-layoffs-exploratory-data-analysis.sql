-- World Layoffs: exploratory data analysis

-- Show database
SELECT *
FROM layoffs_staging2;

-- Maximum amount of people laid off
SELECT MAX(total_laid_off)
FROM layoffs_staging2;

-- Maximum percentaje of people laid off
SELECT MAX(percentage_laid_off)
FROM layoffs_staging2;

-- Show companies that laid off everyone
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- Show companies which laid off everyone by number of people fired
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- Show companies that closed down by funds raised
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- Show total sum of people laid off by company
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Show in which period of time these laidoffs took place
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- Show type of industry that fired the most people
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- Show the countries that had more layoffs
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- Show which year had the biggest layoffs
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

-- Show the status of the companies at the time of the layoffs
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 1 DESC;

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

-- Top 5 companieslayoffs_staging2 that laidoff most people per year
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