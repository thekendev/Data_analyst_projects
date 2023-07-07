-- CREATE DATABASE Portfolio_projects;
-- SET AUTOCOMMIT = OFF;
-- COMMIT;
-- ROLLBACK;

USE Human_resource;
SELECT *
From hr;


  
-- DATA CLEANING
	-- All columns types are texts! Converting column types
DESCRIBE hr;

-- SQL running on safe, this is to take it off safe mode!
SET sql_safe_updates = 0;

-- BIRTH-DATE UPDATE
UPDATE hr
SET birthdate = CASE 
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    ELSE NULL
END;    

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

-- verify changes in BIRTHDATE
SELECT birthdate 
FROM hr; 


-- HIRE-DATE UPDATE
UPDATE hr
SET hire_date = CASE 
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    ELSE NULL
END;    

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

-- verify changes in BIRTHDATE
SELECT hire_date
FROM hr; 

-- TERMDATE
SET sql_mode = 'ALLOW_INVALID_DATES';
UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate !="", 
	date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
    WHERE true;
    
SELECT termdate 
FROM hr;
-- UPDATE hr
-- SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
-- WHERE termdate IS NOT NULL AND termdate !=''
-- ELSE NULL;
-- UPDATE hr
-- SET termdate = CASE 
-- WHEN termdate LIKE '%-%' THEN date(str_to_date(termdate, '%Y-%m-%d'), '%Y-%m-%d')
-- ELSE NULL
-- END;   



-- Modifying termdate column
ALTER TABLE hr 
MODIFY COLUMN termdate DATE;



SELECT termdate 
FROM hr;


ALTER TABLE hr
MODIFY COLUMN termdate DATE;


-- ADD AGE COLUMN
SELECT *
FROM hr;

ALTER TABLE hr 
ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT 
      min(age) AS youngest,
	  max(age) AS oldest
FROM hr;       








































