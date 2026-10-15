SELECT
    job_location,
    -- count how many job postings for each avg yearly salary
    COUNT(job_id) AS job_count,
    -- the avg salary
    ROUND(AVG(salary_year_avg), 0) AS salary_year_avg
FROM
    job_postings_fact
WHERE
    -- Data Analyst jobs
    job_title_short = 'Data Analyst'
    -- ignore NULL Salaries
    AND salary_year_avg IS NOT NULL
    -- ignore NULL locations
    AND job_location IS NOT NULL
GROUP BY
    job_location
HAVING
    -- locations having more then 30 job postings
    COUNT(job_id) > 30
ORDER BY
    salary_year_avg DESC
LIMIT
-- display only 10 locations
    10;