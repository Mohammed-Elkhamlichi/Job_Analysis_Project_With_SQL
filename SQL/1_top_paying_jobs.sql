/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely
- Focuses on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
 */
WITH
    top_10_paying_jobs AS (
        SELECT DISTINCT
            job_title_short,
            ROUND(AVG(salary_year_avg), 0) AS average_salary
        FROM
            job_postings_fact
        WHERE
            salary_year_avg IS NOT NULL
            AND job_title_short NOT LIKE 'Senior%'
            AND job_title_short NOT LIKE 'Junior%'
        GROUP BY
            job_title_short
        ORDER BY
            average_salary DESC
        LIMIT
            10
    )
SELECT
    *
FROM
    top_10_paying_jobs;

SELECT
    *
FROM
    company_dim as c
    RIGHT JOIN job_postings_fact as j on c.company_id = j.company_id
LIMIT
    10