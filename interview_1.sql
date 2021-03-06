CREATE TABLE FLIGHTS (FLIGHT_ID NUMBER, ORIGIN VARCHAR2(5), DESTINATION VARCHAR2(5));

INSERT INTO FLIGHTS VALUES (12323, 'MUM', 'PUN');
INSERT INTO FLIGHTS VALUES (12324, 'PUN', 'MUM');
INSERT INTO FLIGHTS VALUES (13456, 'DLH', 'CCU');
INSERT INTO FLIGHTS VALUES (14567, 'PUN', 'GOA');
INSERT INTO FLIGHTS VALUES (14568, 'GOA', 'PUN');
INSERT INTO FLIGHTS VALUES (15234, 'CHN', 'BGLR');
INSERT INTO FLIGHTS VALUES (15235, 'BGLR', 'CHN');

SELECT 
	COUNT(DISTINCT ASCII(origin)+ASCII(destination)) AS no_of_routes 
FROM flights;