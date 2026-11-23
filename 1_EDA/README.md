# Exploratory Data Analysis w/ SQL: Job Market Analytics

![Proyect 1 Overview](../Images/1_1_Project1_EDA.png)

A SQL project analyzing the data engineer job market using real world job posting data. It demonstrates my ability to **write production-quality analytical SQL, design efficient queries, and turn business questions into data-driven insights**.

## Executive Summary

- **Proyect Scope:** Build **3 analytical queries** that help to answer the question. What are the best skills to learn as a data engineer?
- **Data modeling:** Used **multi-table joins** across fact and dimension tables to extract insights  
- **Analytics:** Applied **aggregations, filtering, and sorting** to find top skills by demand, salary, and an optimal parameter
- **Outcomes:** Delivered **meaningful insights** on SQL/Python dominance.

Review these files for more information:

1. [`01_top_demanded_skills.sql`](01_Top_Demanded_Skills.sql) – demand analysis with multi-table joins  
2. [`02_top_paying_skills.sql`](./02_Top_Paying_Skills.sql) – salary analysis with aggregations  
3. [`03_optimal_skills.sql`](./03_Optimal_Skill.sql) – combined demand/salary optimization query  

## Problem & Context

A good job market analysis needs to answer the question: **'What are the best skills to learn as a data engineer?'** To achieve this, job market analysts need to answer questions like:

- 🎯 **Most in-demand:** *Which skills are most in-demand for data engineers?*  
- 💰 **Highest paid:** *Which skills command the highest salaries?*  
- ⚖️ **Best trade-off:** *What is the optimal skill set balancing demand and compensation?*  

This project analyzes a **data warehouse** built using a star schema design. The warehouse structure consists of:

![Data Warehouse Schema](../Images/1_2_Data_Warehouse.png)

- **Fact Table:** `job_postings_fact` - Central table containing job posting details (job titles, locations, salaries, dates, etc.)
- **Dimension Tables:** 
  - `company_dim` - Company information linked to job postings
  - `skills_dim` - Skills catalog with skill names and types
- **Bridge Table:** `skills_job_dim` - Resolves the many-to-many relationship between job postings and skills

By querying across these interconnected tables, I extracted insights about skill demand and salary patterns and created an optimal parameter, based on a mathematical function, for data engineering roles.  

## Tech Stack

- 🐤 **Query Engine:** DuckDB for fast OLAP-style analytical queries  
- 🧮 **Language:** SQL (ANSI-style with analytical functions)  
- 📊 **Data Model:** Star schema with fact + dimension + bridge tables  
- 🛠️ **Development:** VS Code for SQL editing + Terminal for DuckDB CLI  
- 📦 **Version Control:** Git/GitHub for versioned SQL scripts  

## Repository Structure

```text
1_EDA/
├── 01_Top_Demanded_Skills.sql    # Demand analysis query
├── 02_Top_Paying_Skills.sql      # Salary analysis query
├── 03_Optimal_Skills.sql         # Combined demand/salary optimization
└── README.md                     # You are here
```
## Analysis Overview

### Query Structure

1. **[Top Demanded Skills](./01_Top_Demanded_Skills.sql)** – Identifies the 10 most in-demand skills for remote and national data engineer positions
2. **[Top Paying Skills](./02_Top_Paying_Skills.sql)** – Analyzes the 25 highest-paying skills with salary and demand metrics
3. **[Optimal Skills](./03_Optimal_Skill.sql)** – Calculates an optimal score using natural log of demand combined with median salary to identify the most valuable skills to learn

### Key Insights

- Languages: SQL and Python are the most demanded skills for data engineers appearing in more than 30000 job postings
- Cloud Plataforms: After the programing languages, the cloud plataforms are the most demanded skills with exampleslike AWS and Azure
- Infra & tooling: Kubernetes, Docker, and Terraform are associated with premium salaries
- Outliers: Rust and Golang are programing languages not too used in data engineers but highly valued for the job 
- Big data tools: Apache Spark shows strong demand with competitive compensation

## SQL Skill Demostrated

### Query Design & Optimization

- **Complex Joins**: Multi-table `INNER JOIN` operations across `job_postings_fact`, `skills_job_dim`, and `skills_dim`
- **Aggregations**: `COUNT()`, `MEDIAN()`, `ROUND()` for statistical analysis
- **Filtering**: Boolean logic with `WHERE` clauses and multiple conditions (`job_title_short`, `job_work_from_home`, `salary_year_avg IS NOT NULL`)
- **Sorting & Limiting**: `ORDER BY` with `DESC` and `LIMIT` for top-N analysis

### Data Analysis Techniques

- **Grouping**: `GROUP BY` for categorical analysis by skill
- **Mathematical Functions**: `LN()` for natural logarithm transformation to normalize demand metrics
- **Calculated Metrics**: Derived optimal score combining log-transformed demand with median salary
- **HAVING Clause**: Filtering aggregated results (skills with >= 100 postings)
- **NULL Handling**: Proper filtering of incomplete records (`salary_year_avg IS NOT NULL`)

