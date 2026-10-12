/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
helping job seekers understand which skills to develop that align with top salaries
 */
WITH
    top_paying_data_jobs AS (
        SELECT
            job_id,
            job_title,
            job_schedule_type,
            job_location,
            ROUND(salary_year_avg, 0) as salary_year_avg,
            companies.name as company_name
        FROM
            job_postings_fact AS jobs
            -- left join with the company_dim table using the company_id
            LEFT JOIN company_dim AS companies ON jobs.company_id = companies.company_id
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
            10
    )
SELECT
    top_paying_data_jobs.*,
    skills_job_dim.skill_id,
    skills_dim.skills
FROM
    top_paying_data_jobs
    -- Inner join between skills_job_dim and job_postings_fact table using the job_id
    INNER JOIN skills_job_dim ON top_paying_data_jobs.job_id = skills_job_dim.job_id
    -- Inner join between skills_dim and skills_job_dim table using the skill_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    -- order by yearly salary
ORDER BY
    salary_year_avg DESC;

/*
the result
[
{
"job_id": 552322,
"job_title": "Associate Director- Data Insights",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "255830",
"company_name": "AT&T",
"skill_id": 0,
"skills": "sql"
},
{
"job_id": 552322,
"job_title": "Associate Director- Data Insights",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "255830",
"company_name": "AT&T",
"skill_id": 1,
"skills": "python"
},
{
"job_id": 552322,
"job_title": "Associate Director- Data Insights",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "255830",
"company_name": "AT&T",
"skill_id": 5,
"skills": "r"
},
{
"job_id": 552322,
"job_title": "Associate Director- Data Insights",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "255830",
"company_name": "AT&T",
"skill_id": 74,
"skills": "azure"
},
{
"job_id": 552322,
"job_title": "Associate Director- Data Insights",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "255830",
"company_name": "AT&T",
"skill_id": 75,
"skills": "databricks"
},
{
"job_id": 552322,
"job_title": "Associate Director- Data Insights",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "255830",
"company_name": "AT&T",
"skill_id": 76,
"skills": "aws"
},
{
"job_id": 552322,
"job_title": "Associate Director- Data Insights",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "255830",
"company_name": "AT&T",
"skill_id": 93,
"skills": "pandas"
},
{
"job_id": 552322,
"job_title": "Associate Director- Data Insights",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "255830",
"company_name": "AT&T",
"skill_id": 95,
"skills": "pyspark"
},
{
"job_id": 552322,
"job_title": "Associate Director- Data Insights",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "255830",
"company_name": "AT&T",
"skill_id": 102,
"skills": "jupyter"
},
{
"job_id": 552322,
"job_title": "Associate Director- Data Insights",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "255830",
"company_name": "AT&T",
"skill_id": 181,
"skills": "excel"
},
{
"job_id": 552322,
"job_title": "Associate Director- Data Insights",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "255830",
"company_name": "AT&T",
"skill_id": 182,
"skills": "tableau"
},
{
"job_id": 552322,
"job_title": "Associate Director- Data Insights",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "255830",
"company_name": "AT&T",
"skill_id": 183,
"skills": "power bi"
},
{
"job_id": 552322,
"job_title": "Associate Director- Data Insights",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "255830",
"company_name": "AT&T",
"skill_id": 196,
"skills": "powerpoint"
},
{
"job_id": 99305,
"job_title": "Data Analyst, Marketing",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "232423",
"company_name": "Pinterest Job Advertisements",
"skill_id": 0,
"skills": "sql"
},
{
"job_id": 99305,
"job_title": "Data Analyst, Marketing",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "232423",
"company_name": "Pinterest Job Advertisements",
"skill_id": 1,
"skills": "python"
},
{
"job_id": 99305,
"job_title": "Data Analyst, Marketing",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "232423",
"company_name": "Pinterest Job Advertisements",
"skill_id": 5,
"skills": "r"
},
{
"job_id": 99305,
"job_title": "Data Analyst, Marketing",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "232423",
"company_name": "Pinterest Job Advertisements",
"skill_id": 97,
"skills": "hadoop"
},
{
"job_id": 99305,
"job_title": "Data Analyst, Marketing",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "232423",
"company_name": "Pinterest Job Advertisements",
"skill_id": 182,
"skills": "tableau"
},
{
"job_id": 1021647,
"job_title": "Data Analyst (Hybrid/Remote)",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "217000",
"company_name": "Uclahealthcareers",
"skill_id": 0,
"skills": "sql"
},
{
"job_id": 1021647,
"job_title": "Data Analyst (Hybrid/Remote)",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "217000",
"company_name": "Uclahealthcareers",
"skill_id": 23,
"skills": "crystal"
},
{
"job_id": 1021647,
"job_title": "Data Analyst (Hybrid/Remote)",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "217000",
"company_name": "Uclahealthcareers",
"skill_id": 79,
"skills": "oracle"
},
{
"job_id": 1021647,
"job_title": "Data Analyst (Hybrid/Remote)",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "217000",
"company_name": "Uclahealthcareers",
"skill_id": 182,
"skills": "tableau"
},
{
"job_id": 1021647,
"job_title": "Data Analyst (Hybrid/Remote)",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "217000",
"company_name": "Uclahealthcareers",
"skill_id": 215,
"skills": "flow"
},
{
"job_id": 168310,
"job_title": "Principal Data Analyst (Remote)",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "205000",
"company_name": "SmartAsset",
"skill_id": 0,
"skills": "sql"
},
{
"job_id": 168310,
"job_title": "Principal Data Analyst (Remote)",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "205000",
"company_name": "SmartAsset",
"skill_id": 1,
"skills": "python"
},
{
"job_id": 168310,
"job_title": "Principal Data Analyst (Remote)",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "205000",
"company_name": "SmartAsset",
"skill_id": 8,
"skills": "go"
},
{
"job_id": 168310,
"job_title": "Principal Data Analyst (Remote)",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "205000",
"company_name": "SmartAsset",
"skill_id": 80,
"skills": "snowflake"
},
{
"job_id": 168310,
"job_title": "Principal Data Analyst (Remote)",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "205000",
"company_name": "SmartAsset",
"skill_id": 93,
"skills": "pandas"
},
{
"job_id": 168310,
"job_title": "Principal Data Analyst (Remote)",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "205000",
"company_name": "SmartAsset",
"skill_id": 94,
"skills": "numpy"
},
{
"job_id": 168310,
"job_title": "Principal Data Analyst (Remote)",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "205000",
"company_name": "SmartAsset",
"skill_id": 181,
"skills": "excel"
},
{
"job_id": 168310,
"job_title": "Principal Data Analyst (Remote)",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "205000",
"company_name": "SmartAsset",
"skill_id": 182,
"skills": "tableau"
},
{
"job_id": 168310,
"job_title": "Principal Data Analyst (Remote)",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "205000",
"company_name": "SmartAsset",
"skill_id": 220,
"skills": "gitlab"
},
{
"job_id": 731368,
"job_title": "Director, Data Analyst - HYBRID",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189309",
"company_name": "Inclusively",
"skill_id": 0,
"skills": "sql"
},
{
"job_id": 731368,
"job_title": "Director, Data Analyst - HYBRID",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189309",
"company_name": "Inclusively",
"skill_id": 1,
"skills": "python"
},
{
"job_id": 731368,
"job_title": "Director, Data Analyst - HYBRID",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189309",
"company_name": "Inclusively",
"skill_id": 74,
"skills": "azure"
},
{
"job_id": 731368,
"job_title": "Director, Data Analyst - HYBRID",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189309",
"company_name": "Inclusively",
"skill_id": 76,
"skills": "aws"
},
{
"job_id": 731368,
"job_title": "Director, Data Analyst - HYBRID",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189309",
"company_name": "Inclusively",
"skill_id": 79,
"skills": "oracle"
},
{
"job_id": 731368,
"job_title": "Director, Data Analyst - HYBRID",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189309",
"company_name": "Inclusively",
"skill_id": 80,
"skills": "snowflake"
},
{
"job_id": 731368,
"job_title": "Director, Data Analyst - HYBRID",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189309",
"company_name": "Inclusively",
"skill_id": 182,
"skills": "tableau"
},
{
"job_id": 731368,
"job_title": "Director, Data Analyst - HYBRID",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189309",
"company_name": "Inclusively",
"skill_id": 183,
"skills": "power bi"
},
{
"job_id": 731368,
"job_title": "Director, Data Analyst - HYBRID",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189309",
"company_name": "Inclusively",
"skill_id": 189,
"skills": "sap"
},
{
"job_id": 731368,
"job_title": "Director, Data Analyst - HYBRID",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189309",
"company_name": "Inclusively",
"skill_id": 211,
"skills": "jenkins"
},
{
"job_id": 731368,
"job_title": "Director, Data Analyst - HYBRID",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189309",
"company_name": "Inclusively",
"skill_id": 218,
"skills": "bitbucket"
},
{
"job_id": 731368,
"job_title": "Director, Data Analyst - HYBRID",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189309",
"company_name": "Inclusively",
"skill_id": 219,
"skills": "atlassian"
},
{
"job_id": 731368,
"job_title": "Director, Data Analyst - HYBRID",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189309",
"company_name": "Inclusively",
"skill_id": 233,
"skills": "jira"
},
{
"job_id": 731368,
"job_title": "Director, Data Analyst - HYBRID",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189309",
"company_name": "Inclusively",
"skill_id": 234,
"skills": "confluence"
},
{
"job_id": 310660,
"job_title": "Principal Data Analyst, AV Performance Analysis",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189000",
"company_name": "Motional",
"skill_id": 0,
"skills": "sql"
},
{
"job_id": 310660,
"job_title": "Principal Data Analyst, AV Performance Analysis",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189000",
"company_name": "Motional",
"skill_id": 1,
"skills": "python"
},
{
"job_id": 310660,
"job_title": "Principal Data Analyst, AV Performance Analysis",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189000",
"company_name": "Motional",
"skill_id": 5,
"skills": "r"
},
{
"job_id": 310660,
"job_title": "Principal Data Analyst, AV Performance Analysis",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189000",
"company_name": "Motional",
"skill_id": 210,
"skills": "git"
},
{
"job_id": 310660,
"job_title": "Principal Data Analyst, AV Performance Analysis",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189000",
"company_name": "Motional",
"skill_id": 218,
"skills": "bitbucket"
},
{
"job_id": 310660,
"job_title": "Principal Data Analyst, AV Performance Analysis",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189000",
"company_name": "Motional",
"skill_id": 219,
"skills": "atlassian"
},
{
"job_id": 310660,
"job_title": "Principal Data Analyst, AV Performance Analysis",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189000",
"company_name": "Motional",
"skill_id": 233,
"skills": "jira"
},
{
"job_id": 310660,
"job_title": "Principal Data Analyst, AV Performance Analysis",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "189000",
"company_name": "Motional",
"skill_id": 234,
"skills": "confluence"
},
{
"job_id": 1749593,
"job_title": "Principal Data Analyst",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "186000",
"company_name": "SmartAsset",
"skill_id": 0,
"skills": "sql"
},
{
"job_id": 1749593,
"job_title": "Principal Data Analyst",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "186000",
"company_name": "SmartAsset",
"skill_id": 1,
"skills": "python"
},
{
"job_id": 1749593,
"job_title": "Principal Data Analyst",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "186000",
"company_name": "SmartAsset",
"skill_id": 8,
"skills": "go"
},
{
"job_id": 1749593,
"job_title": "Principal Data Analyst",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "186000",
"company_name": "SmartAsset",
"skill_id": 80,
"skills": "snowflake"
},
{
"job_id": 1749593,
"job_title": "Principal Data Analyst",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "186000",
"company_name": "SmartAsset",
"skill_id": 93,
"skills": "pandas"
},
{
"job_id": 1749593,
"job_title": "Principal Data Analyst",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "186000",
"company_name": "SmartAsset",
"skill_id": 94,
"skills": "numpy"
},
{
"job_id": 1749593,
"job_title": "Principal Data Analyst",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "186000",
"company_name": "SmartAsset",
"skill_id": 181,
"skills": "excel"
},
{
"job_id": 1749593,
"job_title": "Principal Data Analyst",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "186000",
"company_name": "SmartAsset",
"skill_id": 182,
"skills": "tableau"
},
{
"job_id": 1749593,
"job_title": "Principal Data Analyst",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "186000",
"company_name": "SmartAsset",
"skill_id": 220,
"skills": "gitlab"
},
{
"job_id": 387860,
"job_title": "ERM Data Analyst",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "184000",
"company_name": "Get It Recruit - Information Technology",
"skill_id": 0,
"skills": "sql"
},
{
"job_id": 387860,
"job_title": "ERM Data Analyst",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "184000",
"company_name": "Get It Recruit - Information Technology",
"skill_id": 1,
"skills": "python"
},
{
"job_id": 387860,
"job_title": "ERM Data Analyst",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"salary_year_avg": "184000",
"company_name": "Get It Recruit - Information Technology",
"skill_id": 5,
"skills": "r"
}
]
 */