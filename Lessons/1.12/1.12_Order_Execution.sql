EXPLAIN ANALYZE
SELECT
    cd.name AS company_name,
    COUNT(jpf.*) AS posting_count
FROM job_postings_fact AS jpf
INNER JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE jpf.job_country = 'United State'
GROUP BY cd.name
HAVING COUNT(jpf.*) > 3000
ORDER BY posting_count DESC
LIMIT 10;

/*
EXECUTION ORDER
- FROM/JOINS
- WHERE
- GROUP BY
- HAVING
- SELECT
- ORDER BY
- LIMIT
*/