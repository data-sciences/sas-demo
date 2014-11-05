
/*===============================================
Delete any data sets in the WORK Library
and create three data sets - Units, Fails and Modes
===============================================*/
PROC DATASETS LIBRARY=WORK MEMTYPE=DATA GENNUM=ALL KILL; QUIT;
%INCLUDE "&JES.sample_code/ch_4/random_data.sas";

/*===========================================
Extract a subset of the Units data set
============================================*/
PROC SQL;
	CREATE TABLE NY_Recent AS
	SELECT SN, Install
	FROM Units
	WHERE Loc = "NY"
	AND Install >= '09JUN2006'd ;
QUIT;

/*===========================================
Extract the same subset of the Units data set
using a data step instead of PROC SQL
============================================*/
DATA NY_Recent; set Units;
	IF Loc="NY"; 
	IF Install >= '09JUN2006'd;
	KEEP SN Install;
RUN;

/*=============================================
Use PROC SQL to MERGE, or JOIN, the data sets
Units and Fails
=============================================*/
PROC SQL;
	CREATE TABLE Join AS 
		SELECT Units.*, Fails.Fail, Fails.Code
		FROM Units, Fails
		WHERE Units.SN = Fails.SN;
QUIT;

/*=============================================
Use a Left Outer Join to join the data sets
Units and Fails, including unmatched rows from 
Units
=============================================*/
PROC SQL;
	CREATE TABLE Join_Left AS 
		SELECT Units.*, Fails.Fail, Fails.Code
		FROM Units LEFT JOIN Fails
		ON Units.SN = Fails.SN;
QUIT;

/*=============================================
A Left Join with a where clause
=============================================*/
PROC SQL;
	CREATE TABLE Join_LEFT_2 AS 
		SELECT Units.*, Fails.Fail, Fails.Code
		FROM Units LEFT JOIN Fails
		ON Units.SN = Fails.SN
	    WHERE Units.Install>='09JUN2006'd;
QUIT;

/*=============================================
Use a Right Outer Join to join the data sets
Units and Fails, including unmatched rows from
Fails
=============================================*/
PROC SQL;
	CREATE TABLE Join_Right AS 
		SELECT Units.*, Fails.Fail, Fails.Code
		FROM Units RIGHT JOIN Fails
		ON Units.SN = Fails.SN;
QUIT;

/* Use the COALESCE function to preserve the SN variable from each data set */
PROC SQL;
	CREATE TABLE Join_Right_2 AS 
		SELECT COALESCE(Units.SN, Fails.SN) AS SN, 
			Units.Install, Units.Loc, Fails.Fail, Fails.Code
		FROM Units RIGHT JOIN Fails
		ON Units.SN = Fails.SN;
QUIT;

/*=============================================
Use a Full Outer Join to join the data sets
Units and Fails, Including unmatched rows from
Units and Fails
=============================================*/
PROC SQL;
	CREATE TABLE Join_Full AS 
		SELECT COALESCE(Units.SN,Fails.SN) AS SN,
		Units.Install, Units.Loc, Fails.Fail, Fails.Code
		FROM Units FULL JOIN Fails
		ON Units.SN = Fails.SN;
QUIT;

/*=============================================
Using a Merge statement to create a Full Outer Join
=============================================*/
PROC SORT DATA=Units; BY SN; RUN;
PROC SORT DATA=Fails; BY SN; RUN;
DATA Join_Full_2; MERGE Units Fails; BY SN; RUN;


