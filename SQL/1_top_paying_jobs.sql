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

/*
Massive Outlier at the Peak:

Mantys leads the ranking significantly at $650,000 for a standard "Data Analyst" title. In job market datasets, exceptionally high single-posting salaries for early or mid-tier titles can represent executive equity packages, high-end consulting contracts, or unique compensation reporting structures.

Leadership & Senior Titles Command Top Dollar:

Positions such as Director of Analytics (Meta at $336,500), Associate Director (AT&T at $255,830), and various Principal Data Analyst roles (SmartAsset, Motional ranging from $186k to $205k) clearly demonstrate that scaling up compensation requires stepping into leadership, architecture, or principal-level analytical responsibilities.

Remote Flexibility at Elite Companies:

Major industry players like Meta, AT&T, and Pinterest offer fully remote positions ("Anywhere") with salaries comfortably exceeding $230k, proving that remote workers can secure top-tier tech compensation without traditional office constraints.
[
{
"job_id": 226942,
"job_title": "Data Analyst",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"job_posted_date": "2023-02-20",
"salary_year_avg": "650000",
"company_name": "Mantys"
},
{
"job_id": 547382,
"job_title": "Director of Analytics",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"job_posted_date": "2023-08-23",
"salary_year_avg": "336500",
"company_name": "Meta"
},
{
"job_id": 552322,
"job_title": "Associate Director- Data Insights",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"job_posted_date": "2023-06-18",
"salary_year_avg": "255830",
"company_name": "AT&T"
},
{
"job_id": 99305,
"job_title": "Data Analyst, Marketing",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"job_posted_date": "2023-12-05",
"salary_year_avg": "232423",
"company_name": "Pinterest Job Advertisements"
},
{
"job_id": 1021647,
"job_title": "Data Analyst (Hybrid/Remote)",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"job_posted_date": "2023-01-17",
"salary_year_avg": "217000",
"company_name": "Uclahealthcareers"
},
{
"job_id": 168310,
"job_title": "Principal Data Analyst (Remote)",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"job_posted_date": "2023-08-09",
"salary_year_avg": "205000",
"company_name": "SmartAsset"
},
{
"job_id": 731368,
"job_title": "Director, Data Analyst - HYBRID",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"job_posted_date": "2023-12-07",
"salary_year_avg": "189309",
"company_name": "Inclusively"
},
{
"job_id": 310660,
"job_title": "Principal Data Analyst, AV Performance Analysis",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"job_posted_date": "2023-01-05",
"salary_year_avg": "189000",
"company_name": "Motional"
},
{
"job_id": 1749593,
"job_title": "Principal Data Analyst",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"job_posted_date": "2023-07-11",
"salary_year_avg": "186000",
"company_name": "SmartAsset"
},
{
"job_id": 387860,
"job_title": "ERM Data Analyst",
"job_schedule_type": "Full-time",
"job_location": "Anywhere",
"job_posted_date": "2023-06-09",
"salary_year_avg": "184000",
"company_name": "Get It Recruit - Information Technology"
}
]
 */