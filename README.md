# SQL-Python-AI-Grade-Analysis

## Project Overview: Assessing the AI "Risk Zone" in Student Academics

This project explores the correlation between specific student AI usage behaviors and the reported impact on their academic grades. By combining the data processing power of **SQL** with the analytical depth of **Python**, we sought to move beyond simple usage rates and pinpoint the exact activities that lead to the most severe negative academic outcomes.

The core finding challenges the assumption that AI misuse primarily occurs in high-stakes creative assignments (like essays). Instead, the data reveals a "risk zone" where negative impact is highest for students using AI for foundational, skill-building tasks.

-----

## Key Findings (The Risk Zone)

The analysis generated 7 key insights, but the most striking discovery was the source of severe negative grade impact ($\le -3$ on the impact scale):

| Rank | Most Problematic Use Case | Implication |
| :--- | :--- | :--- |
| **1** | **MCQ Practice** | Students are likely using AI to generate quick answers, bypassing the necessary learning/critical thinking for successful self-testing. |
| **2** | **Projects** | Students may be relying on AI to complete components they don't fully understand, resulting in poor application and final scores. |

This indicates an **AI literacy gap** where students use the tool as a shortcut to an answer rather than an aid to learning.

-----

## Data Pipeline & Technologies

The project followed a robust data analysis pipeline:

### 1\. Data Foundation (SQL - MySQL)

  * **Role:** Data structuring, initial cleaning, categorization, and aggregation.
  * **Key Operations:** Used `CREATE TABLE` and `LOAD DATA INFILE` for database ingestion. Used `CASE` statements and `GROUP BY` to create derived metrics like **AI Usage Categories** and aggregate **Trust Scores**.
  * **Result:** Fast, reliable, and aggregated tables ready for high-level analysis.

### 2\. Analysis & Visualization (Python - Jupyter Notebook)

  * **Role:** Deeper correlation analysis, complex filtering, and visualization of insights.
  * **Key Libraries:**
      * **Pandas:** For loading SQL query results and powerful DataFrame manipulation.
      * **Seaborn/Matplotlib:** Used to generate clear visualizations (bar charts, line plots) for all 7 insights.
  * **Result:** Clear visual evidence supporting the identified "Risk Zone" and other correlations.

-----

## Repository Contents

This repository contains the following files to fully replicate the analysis:

  * **`ai_usage_college_student.csv` (or similar):** The raw dataset used for this project.
  * **`ai_usage_student.sql`:** The master SQL script containing all `CREATE TABLE` statements, `LOAD DATA INFILE` commands, and the 7 SQL queries used to extract metric data.
  * **`ai_usage_student.ipynb`:** The Jupyter Notebook containing all Python code, including:
      * Database connection setup (using `mysql.connector`).
      * Pandas manipulation for each of the 7 insights.
      * Seaborn/Matplotlib code to generate all project visualizations.
  * **`/outputs` (Folder):** Contains the final output charts, including the visualization for the Top 5 Negative Impact Use Cases.

-----

## Getting Started

To run this analysis yourself:

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/datasavysarah/Student-AI-Impact-Analysis
    ```
2.  **Set up MySQL:** Create a database and run the `ai_usage_student.sql` script to load the data into the `Student_Data` table.
3.  **Install Dependencies:**
    ```bash
    pip install pandas seaborn matplotlib mysql-connector-python
    ```
4.  **Run the Notebook:** Open `ai_usage_student.ipynb` in your Jupyter environment and execute the cells sequentially. Ensure you update the database connection parameters in the first Python cell.

-----

**Author:** Sarah Uko / https://www.linkedin.com/in/datasavysarah/
**Project Date:** October 2025
