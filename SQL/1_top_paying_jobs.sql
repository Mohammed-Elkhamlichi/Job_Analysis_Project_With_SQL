/*
Question: What are the top-paying data analyst jobs?

- Identify the top 10 highest-paying full-time Data Analyst roles available remotely.
- Focus on job postings with specified salaries (exclude NULL salary values).
- Rank roles by salary, from highest to lowest.
- BONUS: Include company names, job titles, and locations for the top 10 roles.
- Why? Identify the highest-paying remote opportunities for Data Analysts and understand the earning potential and location flexibility of each role.
 */
SELECT
    job_id,
    job_title,
    job_schedule_type,
    job_location,
    job_posted_date::DATE,
    ROUND(salary_year_avg, 0) AS salary_year_avg,
    companies.name AS company_name
FROM
    job_postings_fact AS jobs
    -- left join with the company_dim table using the company_id
    INNER JOIN company_dim AS companies ON jobs.company_id = companies.company_id
WHERE
    -- DATA Analyst Role
    job_title_short = 'Data Analyst'
    -- Full Time Job
    AND job_schedule_type = 'Full-time'
    -- ignore the Null result
    AND salary_year_avg IS NOT NULL
    -- GET Remote Jobs
    AND job_location = 'Anywhere'
    -- Descending Order by yearly salary 
ORDER BY
    salary_year_avg DESC
    -- display only 10 results
LIMIT
    10;


