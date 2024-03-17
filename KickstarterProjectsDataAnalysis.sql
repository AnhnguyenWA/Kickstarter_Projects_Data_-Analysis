-- Wiew all records in the dataset
SELECT * FROM kickstarter;

-- QUESTION 1: What are the top 10 most funded projects from 2010 - 2018.
SELECT Name, Category, 
CASE 
	WHEN MONTH(Deadline) = 2010 THEN Pledged END AS 2010_,
CASE
	WHEN MONTH(Deadline) = 2011 THEN Pledged END AS 2011_,
CASE
	WHEN MONTH(Deadline) = 2012 THEN Pledged END AS 2012_,
CASE
	WHEN MONTH(Deadline) = 2013 THEN Pledged END AS 2013_,
CASE
	WHEN MONTH(Deadline) = 2014 THEN Pledged END AS 2014_,
CASE
	WHEN MONTH(Deadline) = 2015 THEN Pledged END AS 2015_,
CASE
	WHEN MONTH(Deadline) = 2016 THEN Pledged END AS 2016_,
CASE
	WHEN MONTH(Deadline) = 2017 THEN Pledged END AS 2017_,
CASE
	WHEN MONTH(Deadline) = 2018 THEN Pledged END AS 2018_
FROM kickstarter
LIMIT 10;

-- QUESTION 2: What is the success rate of projects by category?
SELECT Category,
SUM(CASE WHEN State = "Successful" THEN 1 ELSE 0 END) / COUNT(*) * 100 AS Success_Percentage
FROM kickstarter
GROUP BY 1
ORDER BY 2 DESC;

-- QUESTION 3: Which months have the highest number of launches and successes?
SELECT
MONTH(Launched) AS Launched_Months,
COUNT(*) AS Total_Launched,
SUM(CASE WHEN State = "Successful" THEN 1 ELSE 0 END) AS Successful_Projects
FROM Kickstarter
GROUP BY 1
ORDER BY 3 DESC;

-- QUESTION 4: What is the average pledge amount per backer for successful projects?
SELECT 
DISTINCT Category,
SUM(CASE WHEN State = "Successful" THEN Pledged END) / SUM(CASE WHEN State = "Successful" THEN Backers END) AS Average_dollars_Per_Backer
FROM Kickstarter
GROUP BY 1
ORDER BY 2 DESC;

-- QUESTION 5: What is the success rate trend throughout the years
SELECT
YEAR(Launched) AS YearLaunched,
SUM(CASE WHEN State = "Successful" THEN  1 ELSE 0 END) / COUNT(*) * 100 AS Successful_Rate
FROM Kickstarter
GROUP BY 1
ORDER BY 2 DESC;

-- QUESTION 6: What are the characteristics of projects that exceed their funding goal by 200% or more?
SELECT 
Name,
Category,
Subcategory,
Country,
CASE WHEN State = "Successful" THEN Pledged END / CASE WHEN State = "Successful" THEN Goal END * 100 AS Percentage_Rate,
DATEDIFF(Deadline, Launched) AS Duration
FROM Kickstarter
HAVING Percentage_rate > 200
ORDER BY 5 DESC;

-- QUESTION 7: For projects that failed, what was the average shortfall from the goal (percentage of goal reached)?
SELECT Category,
SUM(CASE WHEN State = "Failed" THEN Pledged END) / SUM(CASE WHEN State = "Failed" THEN Goal END) * 100 AS Percentage_Of_Goal_Reached
FROM Kickstarter
GROUP BY 1
ORDER BY 2 DESC;

-- QUESTION 8: What is the distribution of project goals, and how does this distribution differ between successful and failed projects?
SELECT 
Category,
SUM(CASE WHEN Goal BETWEEN 0 AND 1000 THEN 1 ELSE 0 END) AS "$0 - $1000",
SUM(CASE WHEN Goal BETWEEN 1000 AND 5000 THEN 1 ELSE 0 END) AS "$1000 - $5000",
SUM(CASE WHEN Goal BETWEEN 5000 AND 10000 THEN 1 ELSE 0 END) AS "$5000 - $10000",
SUM(CASE WHEN Goal >= 10000 THEN 1 ELSE 0 END) AS "Larger_Than_10000",
SUM(CASE WHEN State = "Successful" THEN 1 ELSE 0 END) AS Successful_Projects,
SUM(CASE WHEN State = "Failed" THEN 1 ELSE 0 END) AS Failed_Projects
FROM Kickstarter
GROUP BY 1;
