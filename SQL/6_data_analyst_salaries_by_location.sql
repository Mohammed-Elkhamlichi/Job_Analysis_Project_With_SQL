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

/*
[
{
"job_location": "San Jose, CA",
"job_count": "32",
"salary_year_avg": "129426"
},
{
"job_location": "San Francisco, CA",
"job_count": "73",
"salary_year_avg": "122909"
},
{
"job_location": "Los Angeles, CA",
"job_count": "97",
"salary_year_avg": "105705"
},
{
"job_location": "Washington, DC",
"job_count": "109",
"salary_year_avg": "102779"
},
{
"job_location": "Jacksonville, FL",
"job_count": "48",
"salary_year_avg": "102373"
},
{
"job_location": "Boston, MA",
"job_count": "55",
"salary_year_avg": "101529"
},
{
"job_location": "New York, NY",
"job_count": "327",
"salary_year_avg": "101079"
},
{
"job_location": "Austin, TX",
"job_count": "71",
"salary_year_avg": "98851"
},
{
"job_location": "Tampa, FL",
"job_count": "92",
"salary_year_avg": "97640"
},
{
"job_location": "United States",
"job_count": "37",
"salary_year_avg": "96611"
}
]*/