/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
providing insights into the most valuable skills for job seekers.
 */
SELECT
    skills.skills,
    count(skills_job_dim.job_id) AS skills_demand
FROM
    job_postings_fact AS j
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = j.job_id
    INNER JOIN skills_dim AS skills ON skills.skill_id = skills_job_dim.skill_id
WHERE
    j.job_title_short = 'Data Analyst'
    -- AND job_location LIKE '%Anywhere%'
    -- AND job_posted_date BETWEEN '2023-01-01' AND '2023-09-30'
    -- j.job_title_short = 'Data Enginner'
GROUP BY
    skills
ORDER BY
    skills_demand DESC
LIMIT
    5;

select
    *
from
    job_postings_fact
LIMIT
    10