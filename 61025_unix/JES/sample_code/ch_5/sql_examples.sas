



/*=== Create New Variables ===*/
PROC SQL;
	CREATE TABLE Dset AS
	SELECT A.*, Fail+Defects AS Tot
	FROM JES.First A; 
QUIT;
DATA Dset2; SET JES.First;
	Tot=Fail+Defects;
RUN;
PROC COMPARE BASE=Dset COMPARE=Dset2; RUN;

/*=== Select Columns ===*/
PROC SQL;
	CREATE TABLE Dset AS
	SELECT Batch, Sample, Result 
	FROM JES.First; 
QUIT;
DATA Dset2; 
	SET JES.First;
	KEEP Batch Sample Result;
RUN;
PROC COMPARE BASE=Dset COMPARE=Dset2; RUN;

/*=== Select Rows ===*/	
PROC SQL;
	CREATE TABLE Dset AS
	SELECT * FROM JES.First
	WHERE Result="Low Res"; 
QUIT;
DATA Dset2; SET JES.First;
	IF Result="Low Res";
RUN;
PROC COMPARE BASE=Dset COMPARE=Dset2; RUN;

/*=== Find Distinct Values of a Variable ===*/
PROC SQL;
	CREATE TABLE Dset AS
	SELECT distinct SN from JES.Units;
QUIT;
PROC SORT DATA=JES.Units OUT=Dset2; 
	BY SN; 
RUN;
DATA Dset2(keep=SN); SET Dset; 
	BY SN;
	IF LAST.SN;
RUN;
PROC COMPARE BASE=Dset COMPARE=Dset2; RUN;

/*=== Select Rows with First or Last Value of a Variable ===*/
PROC SQL;
	CREATE TABLE Dset AS
	SELECT * FROM JES.Units 
	GROUP BY SN
	HAVING Install=MIN(Install);
QUIT;
PROC SORT DATA=JES.Units OUT=Dset2;
	BY SN Install;
RUN;
DATA Dset2; SET Dset2;
	BY SN Install;
	IF First.SN;
RUN;
PROC COMPARE BASE=Dset COMPARE=Dset2; RUN;

/*=== Summarize ===*/
PROC SQL;
	CREATE TABLE Dset AS
	SELECT Vendor, Month,
		SUM(Defects) AS Sum,
		MEAN(Defects) AS Avg
	FROM JES.Results
	GROUP BY Vendor, Month;
QUIT;
PROC MEANS DATA=JES.Results NWAY;
	CLASS Vendor Month;
	OUTPUT OUT=Dset2
	SUM(Defects)=Sum 
	MEAN(Defects)=Avg;
RUN;
DATA Dset2; SET Dset2; FORMAT Sum Avg; RUN;
PROC COMPARE BASE=Dset COMPARE=Dset2(DROP=_TYPE_ _FREQ_); RUN;	


/*=== Concatenate Data Sets ===*/
PROC SQL;
		CREATE TABLE Dset AS
		SELECT * from JES.First
		UNION
		SELECT * from JES.Second;
QUIT;
DATA Dset2; 
	SET JES.First JES.Second; 
RUN;
/* Dset and Dset2 contain the same rows, but in different order */
PROC SORT DATA=Dset; BY Batch Sample Resistance; RUN;
PROC SORT DATA=Dset2; BY Batch Sample Resistance; RUN;
PROC COMPARE BASE=Dset COMPARE=Dset2; RUN;

/*=== Inner Join ===*/
/*=== Cannot have repeat values of BY variables in both data sets ==*/
PROC SQL;
	CREATE TABLE Dset AS
	SELECT a.SN, a.Install, a.Loc, b.Fail  
	FROM JES.Units_U a, JES.Fails b
	WHERE a.SN = b.SN;
QUIT;

PROC SORT DATA=JES.Units_U
(KEEP=SN Install Loc) 
 OUT=Units; BY SN; 
RUN;
PROC SORT 
 DATA=JES.Fails(KEEP=SN Fail) 
 OUT=Fails; BY SN; 
RUN;
DATA Dset2;
 MERGE Units(IN=u) Fails(IN=f);
 BY SN;
 IF u AND f;
RUN;
PROC SORT DATA=Dset; BY SN Fail; RUN;
PROC SORT DATA=Dset2; BY SN Fail; RUN; 
PROC COMPARE BASE=Dset COMPARE=Dset2; RUN;


/*=== Full Outer Join ===*/
PROC SQL NOPRINT;
	CREATE TABLE Dset AS SELECT 
	COALESCE(a.SN, b.SN) AS SN, 
	a.Install, a.Loc, b.Fail
	FROM JES.Units_U AS a 
	FULL JOIN JES.Fails AS b
	ON a.SN=b.SN;
QUIT;

PROC SORT DATA=JES.Units_U
	(KEEP=SN Install Loc)
	OUT=Units; BY SN; 
RUN;
PROC SORT DATA=JES.Fails(KEEP=SN Fail) 
	OUT=Fails; BY SN; 
RUN;
DATA Dset2; MERGE Units Fails; 
	BY SN; 
RUN;

PROC SORT DATA=Dset; BY SN Fail; RUN;
PROC SORT DATA=Dset2; BY SN Fail; RUN; 
DATA Dset2; SET Dset2; FORMAT SN; RUN;
PROC COMPARE BASE=Dset COMPARE=Dset2; RUN;	



/*=== Inner Join with repeat values of BY variables in both data sets===*/
PROC SQL;
	CREATE TABLE Dset AS
	SELECT a.SN, a.Install, b.Fail  
	FROM JES.Units a, JES.Fails b
	WHERE a.SN = b.SN;
QUIT;

PROC SORT DATA=JES.Units
(KEEP=SN Install) 
 OUT=Units; BY SN; 
RUN;
PROC SORT 
 DATA=JES.Fails(KEEP=SN Fail) 
 OUT=Fails; BY SN; 
RUN;
DATA Dset2;
 MERGE Units(IN=u) Fails(IN=f);
 BY SN;
 IF u AND f;
RUN;
PROC SORT DATA=Dset; BY SN Fail; RUN;
PROC SORT DATA=Dset2; BY SN Fail; RUN; 
PROC COMPARE BASE=Dset COMPARE=Dset2; RUN;
DATA Dset_; SET Dset; RUN;
DATA Dset2_; SET Dset2; RUN;

/*=== Outer Join with repeat values of BY variables in both data sets===*/
PROC SQL NOPRINT;
	CREATE TABLE Dset AS SELECT 
	a.SN, a.Install, a.Loc, b.Fail
	FROM JES.Units AS a 
	FULL OUTER JOIN JES.Fails AS b
	ON a.SN=b.SN;
QUIT;

PROC SORT DATA=JES.Units
	(KEEP=SN Install Loc)
	OUT=Units; BY SN; 
RUN;
PROC SORT DATA=JES.Fails(KEEP=SN Fail) 
	OUT=Fails; BY SN; 
RUN;
DATA Dset2; MERGE Units Fails; 
	BY SN; 
RUN;

PROC SORT DATA=Dset; BY SN Fail; RUN;
PROC SORT DATA=Dset2; BY SN Fail; RUN; 
PROC COMPARE BASE=Dset COMPARE=Dset2; RUN;	
PROC COMPARE BASE=Dset(WHERE=(SN NE '')) COMPARE=Dset2(WHERE=(SN NE '0085')); RUN;	


 

