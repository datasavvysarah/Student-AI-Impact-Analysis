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