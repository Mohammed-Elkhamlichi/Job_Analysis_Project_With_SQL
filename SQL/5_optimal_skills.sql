/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
offering strategic insights for career development in data analysis
 */
SELECT
    skills.skill_id,
    ROUND(AVG(j.salary_year_avg), 0) as avg_salary,
    COUNT(skills_job_dim.job_id) as skills_demand,
    skills.skills
FROM
    job_postings_fact as j
    -- inner join between the job_postings_fact and skills_job_dim table using the job_id
    INNER JOIN skills_job_dim ON j.job_id = skills_job_dim.job_id
    -- inner join between the skills_job_dim and skills_dim table using the job_id
    INNER JOIN skills_dim as skills ON skills.skill_id = skills_job_dim.skill_id
WHERE
    -- Data Analyst roles
    j.job_title_short = 'Data Analyst'
    -- salary NOT NULL
    AND j.salary_year_avg IS NOT NULL
    -- work from home job
    and j.job_work_from_home IS TRUE
GROUP BY
    skills.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    -- avg_salary DESC,
    skills_demand DESC
LIMIT
    10;

/*
📊 Executive Summary & Key Insights
Highest Demand: SQL is by far the most in-demand skill with 398 job listings, followed by Excel (256) and Python (236).

Highest Earning Potential: Looker commands the highest average salary at $103,795, closely followed by Python ($101,397) and R ($100,499). All three break the $100k threshold.

Salary vs. Demand Trade-off: Core database and spreadsheet tools (SQL, Excel) boast massive market demand with solid, competitive mid-to-high salaries, whereas specialized BI and programming tools (Looker, R, Python) offer premium salaries with more targeted or niche demand.

Overall Metrics:

Average Salary Across All Skills: $97,170.89

Median Salary: $98,902.00

Salary Range: $87,288 (Excel) to $103,795 (Looker)

[
{
"skill_id": 0,
"avg_salary": "97237",
"skills_demand": "398",
"skills": "sql"
},
{
"skill_id": 181,
"avg_salary": "87288",
"skills_demand": "256",
"skills": "excel"
},
{
"skill_id": 1,
"avg_salary": "101397",
"skills_demand": "236",
"skills": "python"
},
{
"skill_id": 182,
"avg_salary": "99288",
"skills_demand": "230",
"skills": "tableau"
},
{
"skill_id": 5,
"avg_salary": "100499",
"skills_demand": "148",
"skills": "r"
},
{
"skill_id": 183,
"avg_salary": "97431",
"skills_demand": "110",
"skills": "power bi"
},
{
"skill_id": 186,
"avg_salary": "98902",
"skills_demand": "63",
"skills": "sas"
},
{
"skill_id": 7,
"avg_salary": "98902",
"skills_demand": "63",
"skills": "sas"
},
{
"skill_id": 196,
"avg_salary": "88701",
"skills_demand": "58",
"skills": "powerpoint"
},
{
"skill_id": 185,
"avg_salary": "103795",
"skills_demand": "49",
"skills": "looker"
}
]
 */