CREATE TABLE cleaned_data AS 
SELECT * 
FROM raw_data 
WHERE NOT (COALESCE("userID", "Track", artist, genre, "City", CAST(time AS text), "Weekday") IS NULL 
   OR "Report_date" IS NULL) 
   AND "Report_date" BETWEEN '2023-01-01' AND '2023-12-31'; 

SELECT * FROM raw_data; 

SELECT * FROM cleaned_data;
