/*
Question: What are the most in-demand skills for data engineers?
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings

. Why? Retrieves the top 10 skills with the highest demand in the remote job market, providing insights into the most valuable skils for data engineers  seeking remote 
*/

SELECT 
    sd.skills,
    COUNT(jpf.*) AS demand_count
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
ORDER BY
    demand_count DESC
LIMIT 10;


/*
Here`s the breakdown of the most demanded skills for data Engineers:
SQL and Python are by far the most in-demand skills, with around 29,000 job posting each, nearly double the next skills
Cloud platforms round out the skills, with AWS leadinf at ~18,000, followed by Azure at ~14,000.
Apache Spark completes the top 5 with nearly 13,000 postings, highlighting the importance of big data processing skills

Key takeaways:
- SQL and python remain the foundational skills for data Engineers
- Cloud platforms (AWS, Azure) are critical for modern data Engineering
- Big data tools like Spark continue to be highly valued
- Data pipeline tools (Airflow, Snowflake, Databricks) show growing demand
- Java and GCP round out the top 10 most requested Skills
┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
└────────────┴──────────────┘
  10 rows         2 columns
*/

/* What we need now is the skills that pay highest amount of salary */

