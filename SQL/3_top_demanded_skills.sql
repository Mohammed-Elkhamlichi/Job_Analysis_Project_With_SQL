/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
providing insights into the most valuable skills for job seekers.
 */
WITH
    data_analyst_jobs AS (
        SELECT
            job_id,
            job_title_short,
            job_posted_date
        FROM
            job_postings_fact
        WHERE
            job_title_short = 'Data Analyst'
        LIMIT
            100
    )
SELECT
    data_analyst_jobs.*,
    skills_job_dim.skill_id,
    skills_dim.skills
from
    data_analyst_jobs AS j
    INNER JOIN skills_job_dim ON j.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id