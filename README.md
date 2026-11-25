 # Orion Data Systems - Workforce Analytics | SQL Capstone

Analysed workforce data for Orion Data Systems (107 employees, 27 departments, 19 job roles, 25 countries) using MySQL to answer 10 HR & Strategy business questions.

## Tools
MySQL, SQL

## Dataset
- `employees` - 107 rows
- `departments` - 27 rows
- `jobs` - 19 rows
- `countries` - 25 rows

## Questions Answered
1. Workforce Distribution - COUNT, GROUP BY, ORDER BY
2. Salary Comparison - AVG, GROUP BY, LIMIT
3. Salary Bands - CASE, COUNT, GROUP BY
4. Country-Level Analysis - JOIN, GROUP BY, COUNT
5. High Earners - Subquery, AVG, WHERE
6. Department Leaders - INNER JOIN, GROUP BY, COUNT
7. Job Role Analysis - CTE, AVG, HAVING
8. Employee Ranking - ROW_NUMBER, PARTITION BY
9. Salary Growth Trend - JOIN, SUM, GROUP BY
10. Workforce Gaps - RIGHT JOIN, WHERE IS NULL

## Key Insights
- Highest headcount: Shipping (45), Sales (34)
- Highest avg salary: Executive ($19,333.33) | Lowest: Shipping ($3,475.56)
- Salary bands: Low (<5000) = 49, Medium (5000-10000) = 43, High (>10000) = 15
- Company average salary: $6,461.68 - 51 employees earn above it
- Highest total salary cost: Switzerland ($75,100)
- Jobs with no employees: 0 - no workforce gaps (verified with RIGHT JOIN)
- Only 4 job titles have avg salary > $12,000: President, Admin VP, Marketing Manager, Sales Manager

## How to Run
1. Create schema `capstone`
2. Create tables from script
3. Import the 4 CSVs
4. Run queries Q1-Q10 in order
