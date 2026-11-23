/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote and national positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
  how common those skills are, providing a more complete picture for skill development priorities
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count
FROM
    job_postings_fact AS jpf
INNER JOIN
    skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN
    skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND 
    (jpf.job_work_from_home = True OR jpf.job_country = 'Mexico')
GROUP BY 
    sd.skills
HAVING 
    COUNT(jpf.*) > 100
ORDER BY 
    median_salary DESC
LIMIT 25;

/*
ENG
There is the result of the highest-paying skills for Data Engineers in remote and national jobs:

Key Insights:
- Rust is the top-paying skill at $210K median salary even though demand is low (259 posting) 
- Terraform and Golang have a median salary of $184K  and a strong demand, with Terraform being
  the third skill on the list with most demand (3583 posting)
- Airflow is the skill with most demand on the list (10880 posting) with a median salary of $150k
- Bitbucket, Ruby, Redis, Ansible, and Jupyter all appear in the top 25 for pay, each with hundreds of postings.
- Most skills on the list are no longer extreme statistical outliers with just a handful of postings; 
  instead, many show consistently strong demand because of the condition on the demand_count column.

┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ rust       │      210000.0 │          259 │
│ terraform  │      184000.0 │         3583 │
│ golang     │      184000.0 │          948 │
│ spring     │      175500.0 │          417 │
│ neo4j      │      170000.0 │          321 │
│ gdpr       │      169616.0 │          614 │
│ zoom       │      168438.0 │          127 │
│ graphql    │      167500.0 │          498 │
│ mongo      │      162250.0 │          302 │
│ fastapi    │      157500.0 │          222 │
│ bitbucket  │      155000.0 │          602 │
│ crystal    │      154224.0 │          131 │
│ sheets     │      152500.0 │          121 │
│ atlassian  │      151500.0 │          270 │
│ c          │      151500.0 │          547 │
│ typescript │      151000.0 │          407 │
│ ruby       │      150000.0 │          860 │
│ airflow    │      150000.0 │        10880 │
│ css        │      150000.0 │          304 │
│ node       │      150000.0 │          192 │
│ kubernetes │      150000.0 │         4508 │
│ ansible    │      150000.0 │          522 │
│ django     │      150000.0 │          317 │
│ redis      │      149500.0 │          660 │
│ vmware     │      148798.0 │          159 │
└────────────┴───────────────┴──────────────┘
  25 rows                         3 columns
*/