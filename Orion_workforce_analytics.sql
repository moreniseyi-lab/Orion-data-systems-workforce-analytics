-- Capstone Project - Orion Data Systems Workforce Analytics
-- Schema: capstone
-- File: Feyisayo_Morenikeji_Jatto_wk6.sql

USE capstone;

SELECT* from departments;
SELECT* FROM countries;
SELECT* FROM employees;
SELECT* FROM jobs;

-- Q1. Workforce Distribution

SELECT
    d.department_id,
    d.department_name,
    COUNT(e.employee_id) AS headcount
FROM departments AS d
LEFT JOIN employees AS e
    ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY headcount DESC;

-- Q2. Salary Comparison - Average Salary per Department

SELECT
    d.department_name,
    ROUND(AVG(e.salary), 2) AS avg_salary,
    COUNT(e.employee_id) AS headcount
FROM departments AS d
INNER JOIN employees AS e
    ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY avg_salary DESC;

-- Q3. Salary Bands for Employees
-- Low <5000, Medium 5000-10000, High >10000

SELECT
    CASE
        WHEN salary < 5000 THEN 'Low'
        WHEN salary BETWEEN 5000 AND 10000 THEN 'Medium'
        ELSE 'High'
    END AS salary_band,
    COUNT(*) AS employee_count
FROM employees
GROUP BY salary_band
ORDER BY salary_band; 

-- Q4. Country-Level Analysis

SELECT c.country_id,
       c.country_name,
       COUNT(DISTINCT e.department_id) AS department_count
FROM countries AS c
LEFT JOIN employees AS e
       ON e.country_id = c.country_id
GROUP BY c.country_id, c.country_name
ORDER BY c.country_name;

-- Q5. High Earners - salary > company average

SELECT
    employee_id,
    emp_name,
    job_id,
    department_id,
    salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;

-- Q6. Department Leaders
-- departments.manager_id = employees.employee_id

SELECT
    d.department_id,
    d.department_name,
    COALESCE(m.emp_name, 'No Manager') AS manager_name,
    COUNT(e.employee_id) AS employee_count
FROM departments AS d
LEFT JOIN employees AS m
    ON d.manager_id = m.employee_id
LEFT JOIN employees AS e
    ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name, m.emp_name
ORDER BY d.department_id;

-- Q7. Job Role Analysis - CTE, avg salary > 12000

WITH job_salary_averages AS (
    SELECT j.job_id,
           j.job_title,
           ROUND(AVG(e.salary),2) AS average_salary
    FROM jobs AS j
    JOIN employees AS e
         ON e.job_id = j.job_id
    GROUP BY j.job_id, j.job_title
)
SELECT job_id, job_title, average_salary
FROM job_salary_averages
WHERE average_salary > 12000
ORDER BY average_salary DESC;

-- Q8. Employee Ranking - ROW_NUMBER within department

SELECT
    e.employee_id,
    e.emp_name,
    d.department_name,
    e.salary,
    ROW_NUMBER() OVER (
        PARTITION BY e.department_id
        ORDER BY e.salary DESC
    ) AS salary_rank_in_dept
FROM employees AS e
LEFT JOIN departments AS d
    ON e.department_id = d.department_id
ORDER BY d.department_name, salary_rank_in_dept;

-- Q9. Salary Growth Trend - Total salaries per country

SELECT
    c.country_name,
    ROUND(SUM(e.salary), 2) AS total_salary_cost,
    COUNT(e.employee_id) AS headcount
FROM countries AS c
INNER JOIN employees AS e
    ON c.country_id = e.country_id
GROUP BY c.country_id, c.country_name
ORDER BY total_salary_cost DESC;

-- Q10. Workforce Gaps - Jobs with NO employees
-- RIGHT JOIN as required in brief

SELECT
    j.job_id,
    j.job_title,
    j.min_salary,
    j.max_salary
FROM employees AS e
RIGHT JOIN jobs AS j
    ON e.job_id = j.job_id
WHERE e.employee_id IS NULL
ORDER BY j.job_id;





