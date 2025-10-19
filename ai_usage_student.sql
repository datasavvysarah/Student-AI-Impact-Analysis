CREATE DATABASE ai_studentusers;
USE ai_studentusers;

CREATE TABLE IF NOT exists Student_data (
Student_Name VARCHAR(200),
College_Name VARCHAR(300),
Stream VARCHAR(150),
Year_of_Study INT,
AI_Tools_Used VARCHAR(100),
Daily_Usage_Hours DECIMAL(3,1),
Use_Cases VARCHAR(200),
Trust_in_AI_Tools INT,
Impact_on_Grades INTEGER,
Do_Professors_Allow_Use VARCHAR(100),
Preferred_AI_Tool VARCHAR(200),
Awareness_Level INT,
Willing_to_Pay_for_Access VARCHAR(10),
State VARCHAR(100),
Device_Used VARCHAR(100),
Internet_Access VARCHAR(120)
);

SHOW TABLES;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Students Data.csv'
INTO TABLE Student_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; -- Skip the header row

SHOW VARIABLES LIKE 'secure_file_priv';

-- To Check if the Data has been Successfully Imported
SELECT * FROM Student_data;

-- Insight 1: Find the Distinct Values and the No of the Student In the School

SELECT
    COUNT(DISTINCT Student_Name) AS Distinct_Student_Count
FROM
    Student_Data;
    
SELECT DISTINCT
	Student_Name
FROM
	Student_Data;
    
-- Insight 2: Find the total number of student that used distinct devices used when checking out ai

SELECT
	Device_Used,
    COUNT(*) AS Total_students
FROM
	Student_Data
GROUP BY
	Device_Used
ORDER BY
	Total_Students DESC;

-- This query retrieves the total number of students using each type of device from the Student_Data table.
SELECT 
    `Device_Used`,
    COUNT(*) AS Total_Students
FROM Student_Data
GROUP BY `Device_Used`
ORDER by Total_Students DESC;

-- Find the Distinct Values and the No of the Student In the School

SELECT
    COUNT(DISTINCT `Student_Name`) AS Total_Number_of_Students
FROM 
    Student_Data;

-- Categorize the Impact_on_Grades into descriptive labels
SELECT
    *,
    CASE
        WHEN Impact_on_Grades <= -3 THEN 'Very Bad Impact'
        WHEN Impact_on_Grades <= -1 THEN 'Negative Impact'
        WHEN Impact_on_Grades = 0  THEN 'Neutral Impact'
        WHEN Impact_on_Grades <= 2  THEN 'Positive Impact'
        WHEN Impact_on_Grades >= 3  THEN 'Very Good Impact'
        ELSE 'Uncategorized'
    END AS Impact_Severity_Description
FROM
    Student_Data;

-- Calculate the average Impact_on_Grades for each Device_Used
SELECT
    `AI_Tools_Used`,
    AVG(`Impact_on_Grades`) AS Average_Impact
FROM
    Student_Data
GROUP BY `AI_Tools_Used`
ORDER BY Average_Impact DESC;

-- Find the number of students using each AI tool
SELECT
    `AI_Tools_Used`,
    COUNT(*) AS Number_of_Students
FROM
    Student_Data
GROUP BY `AI_Tools_Used`
ORDER BY Number_of_Students DESC;


-- Identify students with significant positive or negative impact on grades
SELECT
    `Student_Name`,
    `Impact_on_Grades`
FROM
    Student_Data
WHERE
    `Impact_on_Grades` >= 3 OR `Impact_on_Grades` <= -3
ORDER BY `Impact_on_Grades` DESC;

-- Insight 1: Correlation Between Usage and Grade Impact
-- Calculate the AI Usage Category on the fly (reusing logic from earlier)
SELECT
    -- Calculate the AI Usage Category on the fly (reusing logic from earlier)
    CASE
        WHEN Daily_Usage_Hours >= 5 THEN 'High Use (>= 5 hrs)'
        WHEN Daily_Usage_Hours >= 2 THEN 'Medium Use (2-5 hrs)'
        ELSE 'Low Use (< 2 hrs)'
    END AS Usage_Category,
	-- Calculate the average grade impact score (range -5 to 5)
    AVG(Impact_on_Grades) AS Avg_Grade_Impact_Score,
    COUNT(*) AS Student_Count
FROM
    Student_Data
GROUP BY
    Usage_Category
ORDER BY
    Avg_Grade_Impact_Score DESC;

-- Insight 2: Professor Policy vs. Student Tool Preference
SELECT
    Preferred_AI_Tool,
    COUNT(*) AS Preference_Count,
    AVG(Trust_in_AI_Tools) AS Avg_Trust_Score
FROM
    Student_Data
WHERE
    -- Assuming 'No' means disallow or restrict
    Do_Professors_Allow_Use = 'No' 
GROUP BY
    Preferred_AI_Tool
HAVING
    COUNT(*) > 10 -- Only show tools with significant preference
ORDER BY
    Preference_Count DESC;

SELECT
    Preferred_AI_Tool,
    COUNT(*) AS Preference_Count,
    AVG(Trust_in_AI_Tools) AS Avg_Trust_Score
FROM
    Student_Data
WHERE
    -- Assuming 'Yes' means allow
    Do_Professors_Allow_Use = 'Yes' 
GROUP BY
    Preferred_AI_Tool
HAVING
    COUNT(*) > 10 -- Only show tools with significant preference
ORDER BY
    Preference_Count DESC;

-- Insight 3: The Most Common Use Cases for AI
SELECT
	`Use_Cases`,
	COUNT(*) AS Student_Usage_Count,
AVG(Awareness_Level) AS Avg_Awareness
FROM
    Student_Data
GROUP BY
    Use_Cases
ORDER BY
    Student_Usage_Count DESC;

-- Insight 4: High Impact/Low Awareness Students (Risk Group)
SELECT
    COUNT(*) AS High_Risk_Student_Count,
    AVG(Daily_Usage_Hours) AS Avg_Hours_for_Risk_Group
FROM
    Student_Data
WHERE
    -- Filter for students with a very bad reported grade impact
    CASE
        WHEN Impact_on_Grades <= -3 THEN 'Very Bad Impact'
        ELSE 'Other'
    END = 'Very Bad Impact'
    -- AND filter for students with low awareness
    AND Awareness_Level <= 2;

-- Insight 5: Trust Levels Across Different AI Tools
SELECT
    Preferred_AI_Tool,
    AVG(Trust_in_AI_Tools) AS Avg_Trust_Score,
    COUNT(*) AS Student_Count
FROM
    Student_Data
GROUP BY
    Preferred_AI_Tool
HAVING
    COUNT(*) >= 20  -- Filter for tools with at least 20 reported uses
ORDER BY
    Avg_Trust_Score DESC;


-- Insight 6: Impact on Grades by Awareness Level
SELECT
    Awareness_Level,
    AVG(Impact_on_Grades) AS Avg_Grade_Impact,
    COUNT(*) AS Student_Count
FROM
    Student_Data
GROUP BY
    Awareness_Level
ORDER BY
    Awareness_Level DESC;

-- Insight 7: Most Negative Use Cases

WITH Negative_Impact_Data AS (
    -- Step 1: Filter the data for severe negative impact (Impact_on_Grades <= -3)
    SELECT
        Use_Cases,
        Daily_Usage_Hours
    FROM
        Student_Data
    WHERE
        Impact_on_Grades <= -3
)
SELECT
    N.Use_Cases,
    COUNT(*) AS Negative_Impact_Count,
    AVG(N.Daily_Usage_Hours) AS Avg_Usage_Hours_in_Risk_Group
FROM
    Negative_Impact_Data N
GROUP BY
    N.Use_Cases
ORDER BY
    Negative_Impact_Count DESC
LIMIT 5; -- Filter to show only the top 5 most frequent negative use cases

