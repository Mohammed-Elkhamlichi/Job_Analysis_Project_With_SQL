/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and 
helps identify the most financially rewarding skills to acquire or improve
 */
SELECT
    -- the averege salary
    ROUND(AVG(j.salary_year_avg), 0) as avg_salary,
    -- skills
    skills.skills
FROM
    job_postings_fact as j
    -- inner join between the job_postings_fact and skills_job_dim table using the job_id
    INNER JOIN skills_job_dim ON j.job_id = skills_job_dim.job_id
    -- inner join between the skills_job_dim and skills_dim table using the job_id
    INNER JOIN skills_dim as skills ON skills.skill_id = skills_job_dim.skill_id
WHERE
    -- data analyst roles
    job_title_short = 'Data Analyst'
    -- salary is not NULL
    AND j.salary_year_avg IS NOT NULL
GROUP BY
    skills.skills
ORDER BY
    avg_salary DESC
LIMIT
    10;

/*
[
{
"avg_salary": "400000",
"skills": "svn"
},
{
"avg_salary": "179000",
"skills": "solidity"
},
{
"avg_salary": "160515",
"skills": "couchbase"
},
{
"avg_salary": "155486",
"skills": "datarobot"
},
{
"avg_salary": "155000",
"skills": "golang"
},
{
"avg_salary": "149000",
"skills": "mxnet"
},
{
"avg_salary": "147633",
"skills": "dplyr"
},
{
"avg_salary": "147500",
"skills": "vmware"
},
{
"avg_salary": "146734",
"skills": "terraform"
},
{
"avg_salary": "138500",
"skills": "twilio"
}
]
 */