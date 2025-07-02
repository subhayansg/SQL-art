-- Consider a file containing an Education column that includes an array of elements, as shown below.

-- Name| Age | Education
-- Azar|25| MBA,BE,HSC
-- Hari|32|
-- Kumar|35|ME,BE,Diploma

-- Write an SQL to Convert Education to SCD Type 2 (It should be splitted in Rows)

SELECT
  Name,
  Age,
  TRIM(edu) AS Education_SCD2,
  CURRENT_DATE() AS valid_from,
  CAST(NULL AS DATE) AS valid_to,
  TRUE AS is_current
FROM (
  SELECT
    Name,
    Age,
    explode(split(Education, ',')) AS edu
  FROM your_table
)
WHERE edu IS NOT NULL AND TRIM(edu) <> ''
