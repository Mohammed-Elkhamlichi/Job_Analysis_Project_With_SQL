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
    count(skills_job_dim.job_id) AS skill_demand
FROM
    job_postings_fact AS j
    -- Inner join between skills_job_dim and job_postings_fact table using the job_id
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = j.job_id
    -- Inner join between skills_dim and skills_job_dim table using the skill_id
    INNER JOIN skills_dim AS skills ON skills.skill_id = skills_job_dim.skill_id
WHERE
    j.job_title_short = 'Data Analyst'
    -- AND job_location LIKE '%Anywhere%'
    -- AND job_posted_date BETWEEN '2023-01-01' AND '2023-09-30'
    -- j.job_title_short = 'Data Enginner'
GROUP BY
    skills
ORDER BY
    skill_demand DESC
LIMIT
    5;

/*
RESULT of to 5 in-demand skills for Data analyst
[
{
"skills": "sql", 
"skill_demand": "92628"
},
{
"skills": "excel",
"skill_demand": "67031"
},
{
"skills": "python",
"skill_demand": "57326"
},
{
"skills": "tableau",
"skill_demand": "46554"
},
{
"skills": "power bi",
"skill_demand": "39468"
}
]
 */