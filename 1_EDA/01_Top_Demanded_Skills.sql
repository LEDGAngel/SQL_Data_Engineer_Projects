/* 
Question: What are the most-demand skills for data engineers?
- Identify the top 10 in-demand skills for data engineers
- Focus on Remote jobs and for jobs in Mexico
- Why? Retrieves the top 10 skills with the highest demand in the remote job market and in the national market, 
  providing insights into the most valuable skills for data engineers seeking remote work or job in Mexico
*/

SELECT 
    sd.skills,
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
ORDER BY 
    demand_count DESC
LIMIT 10;
 
/*
There is the result of the most demanded skills for Data Engineers:
- Python and SQL are the most demanded skills by far, with SQL being the first one with around 34000 job posting, followed by Python with
  around 33000 job posting, showing that sql and python are by far the essentials skills for a data engineers.
- Cloud Plataforms are the most demanded after the programming languages with AWS and Azure being on top.
- Apache Spark is in top 5, showing the importance of the data processing tools.
- There are also on the top some pipelines tools like Airflow, Snowflake or Databricks

┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        33811 │
│ python     │        32917 │
│ aws        │        19895 │
│ azure      │        16495 │
│ spark      │        14686 │
│ airflow    │        10880 │
│ snowflake  │         9722 │
│ databricks │         9248 │
│ java       │         8578 │
│ gcp        │         7401 │
└────────────┴──────────────┘
  10 rows         2 columns
*/
