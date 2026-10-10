SELECT
    *
from
    job_postings_fact
WHERE
    salary_year_avg > 80000
    and job_title_short = 'Data Analyst'
LIMIT
    100