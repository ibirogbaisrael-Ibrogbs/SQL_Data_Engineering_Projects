 SELECT 
    sd.skills,
   ROUND(median(jpf.salary_year_avg), 0) as median_salary,
   COUNT (jpf.*) AS demand_count,
   LN(COUNT(jpf.*)) AS ln_demand_count,
   median(jpf.salary_year_avg) * LN(COUNT(jpf.*)) AS optimal_score
FROM data_jobs.job_postings_fact As jpf
INNER JOIN data_jobs.skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN data_jobs.skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE 
   job_title_short = 'Data Engineer'
   AND job_work_from_home = 'True'
GROUP BY 
    sd.skills
HAVING 
    COUNT(jpf.*) > 100
ORDER BY
    optimal_score DESC 
LIMIT 25;




SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
    ROUND(MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*))/1000000, 2) AS optimal_score

FROM data_jobs.job_postings_fact AS jpf

INNER JOIN data_jobs.skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id

INNER JOIN data_jobs.skills_dim AS sd
    ON sjd.skill_id = sd.skill_id

WHERE 
    job_title_short = 'Data Engineer'
    AND job_work_from_home = TRUE

GROUP BY 
    sd.skills

HAVING 
    COUNT(jpf.*) > 100

ORDER BY
    optimal_score DESC

LIMIT 25;


/*Here`s a breakdown of the most optimal skills for Data Engineers, based on both high demand and high salaries:

Top Skills by Optimal Score:

- Terraform ranks 1st with an optimal score of 1.49. It has a very high median salary of $184,000, although its demand (3,248 jobs) is much lower than Python or SQL.
- Python ranks 2nd with a score of 1.39. Its salary is $135,000, but it has extremely high demand with 28,776 jobs.
- Airflow ranks 3rd, with $150,000 median salary and 9,996 job postings.
- AWS and SQL both score 1.34. SQL has the highest demand in the table at 29,221 jobs, while AWS has a slightly higher median salary of $137,320.
- Spark also performs strongly, with a $140,000 median salary and 12,799 job postings.
- Kafka, Kubernetes, Golang, Snowflake, Azure, Java, Scala, and Databricks form the middle group, offering reasonable combinations of salary and demand.
- Rust has the highest median salary at $210,000, but only 232 job postings, which explains its relatively lower optimal score.
- Golang is similar: very high salary ($184,000) but relatively low demand (912 jobs).
-Pandas, MongoDB, BigQuery, and Docker have lower scores because their salary and/or demand combination is weaker than the skills above them.
┌────────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│  varchar   │    double     │    int64     │     double      │    double     │
├────────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ terraform  │      184000.0 │         3248 │             8.1 │          1.49 │
│ python     │      135000.0 │        28776 │            10.3 │          1.39 │
│ airflow    │      150000.0 │         9996 │             9.2 │          1.38 │
│ aws        │      137320.0 │        17823 │             9.8 │          1.34 │
│ sql        │      130000.0 │        29221 │            10.3 │          1.34 │
│ spark      │      140000.0 │        12799 │             9.5 │          1.32 │
│ kafka      │      145000.0 │         6415 │             8.8 │          1.27 │
│ kubernetes │      150500.0 │         4202 │             8.3 │          1.26 │
│ golang     │      184000.0 │          912 │             6.8 │          1.25 │
│ snowflake  │      135500.0 │         8639 │             9.1 │          1.23 │
│ azure      │      128000.0 │        14143 │             9.6 │          1.22 │
│ java       │      135000.0 │         7267 │             8.9 │           1.2 │
│ scala      │      137290.0 │         6304 │             8.7 │           1.2 │
│ databricks │      132750.0 │         8183 │             9.0 │           1.2 │
│ pyspark    │      140000.0 │         4898 │             8.5 │          1.19 │
│ gcp        │      136000.0 │         6446 │             8.8 │          1.19 │
│ git        │      140000.0 │         4641 │             8.4 │          1.18 │
│ hadoop     │      135000.0 │         5447 │             8.6 │          1.16 │
│ rust       │      210000.0 │          232 │             5.4 │          1.14 │
│ nosql      │      134415.0 │         4514 │             8.4 │          1.13 │
│ docker     │      135000.0 │         4316 │             8.4 │          1.13 │
│ redshift   │      130000.0 │         5737 │             8.7 │          1.13 │
│ pandas     │      140000.0 │         2929 │             8.0 │          1.12 │
│ mongodb    │      135750.0 │         3512 │             8.2 │          1.11 │
│ bigquery   │      135000.0 │         3523 │             8.2 │           1.1 │
└────────────┴───────────────┴──────────────┴─────────────────┴───────────────┘