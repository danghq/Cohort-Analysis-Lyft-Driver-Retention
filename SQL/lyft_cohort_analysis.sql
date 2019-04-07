-- Code only; data not provided

WITH dedup AS (
SELECT driver_onboard_date, driver_id, DATEPART(week, dropped_off_time) AS drive_week FROM driver_partner
UNION
SELECT driver_onboard_date, driver_id, DATEPART(week, dropped_off_time) AS drive_week FROM driver_partner),

cohort AS (
	SELECT 
		driver_onboard_date, 
		drive_week,
		COUNT(driver_id) AS rides
	FROM dedup
	GROUP BY driver_onboard_date, drive_week),

cohort_normalized AS (
	SELECT 
		driver_onboard_date,
		row_number() OVER (PARTITION BY driver_onboard_date ORDER BY drive_week) AS normalized_week,
		rides
	FROM cohort)

SELECT 
	driver_onboard_date,
	[1], [2], [3], [4], [5],
	[6], [7], [8], [9], [10],
	[11], [12], [13], [14]
FROM cohort_normalized
PIVOT (MAX(rides) FOR normalized_week 
IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10],[11], [12], [13], [14])) reshape;







		