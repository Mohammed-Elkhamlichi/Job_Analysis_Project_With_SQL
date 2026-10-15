# INTODUCTION

# 📊 Data Analyst Job Market Analysis Using SQL

Explore the data analyst job market through SQL! This project focuses on identifying 💰 the highest-paying data analyst jobs, 🔥 the most in-demand skills, and 📈 the skills that combine strong market demand with high salaries.

🔍 **SQL queries:** Explore the analysis in the [`Job_Analysis_Project_With_SQL`](./SQL/) folder.

## Background

As an aspiring Data Analyst, I created this project to better understand the job market and identify the skills and opportunities that matter most for building a successful career in data analytics. The goal is to use SQL to answer real-world questions about salaries, job demand, and the skills employers value most.

## Data Source

The dataset comes from the [SQL Course by Luke Barousse](https://lukebarousse.com/sql). It contains job-market information, including job titles, salaries, locations, and required skills, providing a foundation for exploring trends and uncovering actionable insights.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# TOOLS I USED

For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# THE ANALYSIS

This project uses SQL to explore the data analyst job market and answer key questions about salaries, job opportunities, and in-demand skills.

### Questions Explored

#### **1. Top-Paying Data Analyst Jobs:** Identify the highest-paying data analyst positions, focusing on full-time, remote opportunities with disclosed salaries.

### **SQL QUERY**

```sql
SELECT
    job_id,
    job_title,
    job_schedule_type,
    job_location,
    job_posted_date::DATE,
    ROUND(salary_year_avg, 0) as salary_year_avg,
    companies.name as company_name
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
```

### **THE RESULT**

### [`Top 10 Paying Data Analyst Jobs JSON DATA`](./JSON/1_top_paying_jobs.json)

!['Top 10 Paying Data Analyst Jobs'](./images/1_top_paying_jobs.png)

#### **2. Skills Required for Top-Paying Jobs:** Analyze the skills associated with the highest-paying data analyst positions.

### **SQL QUERY**

```SQL
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
```

### **THE RESULT**

### [`Skills Required for Top-Paying Jobs JSON DATA`](./JSON/2_top_paying_job_skills.json)

![Skills Required for Top-Paying Jobs](./images/2_top_paying_job_skills.png)

#### **3. Most In-Demand Skills:** Identify the skills most frequently requested by employers in data analyst job postings.

### **SQL QUERY**

```SQL
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
```

### **THE RESULT**

### [`Top 5 In-Demand Skills JSON DATA`](./JSON/3_top_demanded_skills.json)

![`Top 5 In-Demand Skills`](./images/3_top_demanded_skills.png)

```JSON

```

#### **4. Skills Associated with Higher Salaries:** Explore the relationship between specific skills and average data analyst salaries.

### **SQL QUERY**

```SQL
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
```

### **THE RESULT**

### [Top 10 Paying Skills JSON DATA](./JSON/4_top_paying_skills.json)

![Top 10 Paying Skills](./images/4_top_paying_skills.png)

```JSON

```

#### **5. Optimal Skills to Learn:** Identify skills that combine strong employer demand with competitive salaries.

### **SQL QUERY**

```SQL
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
```

### **THE RESULT**

### [`Top 10 Optimal Skills JSON DATA`](./JSON/5_optimal_skills.json)

![Top 10 Optimal Skills](./images/5_optimal_skills.png)

### Tools & Techniques

- **SQL (PostgreSQL):** Data querying, filtering, aggregation, and analysis.
- **Joins:** Combine job postings, company information, and required skills across related tables.
- **Common Table Expressions (CTEs):** Structure complex queries into readable, manageable steps.
- **Aggregate Functions:** Use `COUNT()`, `AVG()`, and other functions to summarize job-market trends.
- **Window Functions:** Analyze and rank job opportunities and skill-related salary trends.

# WHAT I LEARNED

# CONCLUSIONS
