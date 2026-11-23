/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote and national Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. 
      It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical 
      and valuable to learn for data engineering careers.
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*))) / 1_000_000, 2) AS optimal_score
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
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY 
    sd.skills
HAVING 
    COUNT(jpf.*) > 100
ORDER BY 
    optimal_score DESC
LIMIT 25;

/*
There is the result of the most optimal skills for Data Engineers, based on demand and salaries, in remote and national jobs:

Top Skills by Optimal Score:
- Terraform leads the list with a $184K median salary and 193 postings, resulting in the highest overall "optimal score".
- Python appears in the second  place  with a strong demand and a median salary of $135K
- On third position is a data plataform, AWS with 793 job posting and a median salary of $137K
- Then there is SQL that, as python, has a strong demand with a high median salary of $130K

┌────────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│  varchar   │    double     │    int64     │     double      │    double     │
├────────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ terraform  │      184000.0 │          195 │             5.3 │          0.97 │
│ python     │      135000.0 │         1150 │             7.0 │          0.95 │
│ aws        │      137500.0 │          793 │             6.7 │          0.92 │
│ sql        │      130000.0 │         1145 │             7.0 │          0.92 │
│ airflow    │      150000.0 │          389 │             6.0 │          0.89 │
│ spark      │      140000.0 │          514 │             6.2 │          0.87 │
│ snowflake  │      136000.0 │          442 │             6.1 │          0.83 │
│ kafka      │      145000.0 │          295 │             5.7 │          0.82 │
│ azure      │      130000.0 │          485 │             6.2 │           0.8 │
│ java       │      135000.0 │          311 │             5.7 │          0.77 │
│ scala      │      136645.0 │          252 │             5.5 │          0.76 │
│ kubernetes │      150000.0 │          149 │             5.0 │          0.75 │
│ databricks │      133400.0 │          269 │             5.6 │          0.75 │
│ git        │      140000.0 │          215 │             5.4 │          0.75 │
│ redshift   │      130000.0 │          277 │             5.6 │          0.73 │
│ gcp        │      136000.0 │          202 │             5.3 │          0.72 │
│ hadoop     │      135000.0 │          202 │             5.3 │          0.72 │
│ pyspark    │      140000.0 │          154 │             5.0 │          0.71 │
│ nosql      │      135000.0 │          197 │             5.3 │          0.71 │
│ mongodb    │      137000.0 │          140 │             4.9 │          0.68 │
│ docker     │      135000.0 │          148 │             5.0 │          0.67 │
│ go         │      140000.0 │          113 │             4.7 │          0.66 │
│ github     │      135000.0 │          131 │             4.9 │          0.66 │
│ r          │      135000.0 │          135 │             4.9 │          0.66 │
│ bigquery   │      135000.0 │          125 │             4.8 │          0.65 │
└────────────┴───────────────┴──────────────┴─────────────────┴───────────────┘
  25 rows                                                           5 columns
*/