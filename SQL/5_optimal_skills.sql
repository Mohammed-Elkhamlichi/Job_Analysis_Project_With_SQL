/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
offering strategic insights for career development in data analysis
 */
WITH
    skills_in_demand AS (
        SELECT
            skills.skill_id,
            skills.skills,
            COUNT(DISTINCT j.job_id) AS skills_demand
        FROM
            job_postings_fact AS j
            INNER JOIN skills_job_dim AS sj ON j.job_id = sj.job_id
            INNER JOIN skills_dim AS skills ON sj.skill_id = skills.skill_id
        WHERE
            j.job_title_short = 'Data Analyst'
            AND j.job_work_from_home IS TRUE
            AND j.salary_year_avg IS NOT NULL
        GROUP BY
            skills.skill_id,
            skills.skills
    ),
    highest_paying_skills AS (
        SELECT
            skills.skill_id,
            skills.skills,
            ROUND(AVG(j.salary_year_avg), 0) AS avg_salary
        FROM
            job_postings_fact AS j
            INNER JOIN skills_job_dim AS sj ON j.job_id = sj.job_id
            INNER JOIN skills_dim AS skills ON sj.skill_id = skills.skill_id
        WHERE
            j.job_title_short = 'Data Analyst'
            AND j.job_work_from_home IS TRUE
            AND j.salary_year_avg IS NOT NULL
        GROUP BY
            skills.skill_id,
            skills.skills
    )
SELECT
    d.skills,
    d.skills_demand,
    p.avg_salary
FROM
    skills_in_demand AS d
    INNER JOIN highest_paying_skills AS p ON d.skill_id = p.skill_id
ORDER BY
    d.skills_demand DESC,
    p.avg_salary DESC
LIMIT
    10;