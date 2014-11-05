
 /*------------------------------------------------------------------ */
 /*         SAS(R) Programming for Enterprise Guide(R) Users,         */
 /*                       Second Edition                              */
 /*                                                                   */                                                                                               
 /*                     by Neil Constable                             */
 /*      Copyright(c) 2010 by SAS Institute Inc., Cary, NC, USA       */
 /*                    ISBN 978-1-60764-528-3                         */                  
 /*-------------------------------------------------------------------*/
 /*                                                                   */
 /* This material is provided "as is" by SAS Institute Inc.  There    */
 /* are no warranties, expressed or implied, as to merchantability or */
 /* fitness for a particular purpose regarding the materials or code  */
 /* contained herein. The Institute is not responsible for errors     */
 /* in this material as it now exists or will exist, nor does the     */
 /* Institute provide technical support for it.                       */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
 /* Questions or problem reports concerning this material may be      */
 /* addressed to the authors:                                         */
 /*                                                                   */
 /* SAS Institute Inc.                                                */
 /* SAS Press Series                                                  */
 /* Attn: Neil Constable                                              */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  saspress@sas.com           */
 /* Use this for subject field:                                       */
 /*     Comments for Neil Constable                                   */
 /*                                                                   */
 /*-------------------------------------------------------------------*/


/*
Code Samples
SAS Programming for Enterprise Guide Users, Second Edition

This document contains the code used in SAS Programming for Enterprise Guide Users, Second Edtion.

Complete programming steps can be run directly from this file or used in a code node 
or inserted within a task.

Some of the code lines presented here are fragments to be inserted in tasks as 
indicated in the book. These lines are included within comment blocks to ensure that
they do not impact the indicative colors used for complete steps. 

*/
/*Chapter 1. Why do I need to write code?*/
/*
No code samples were presented in Chapter 1.
*/


/*Chapter 2. Understanding coding with SAS Enterprise Guide*/

/* My First SAS Program*/
TITLE 'Report of Female Students in Class';
PROC REPORT DATA=egprog.class;
WHERE sex='F';
RUN;

/*Note: The code below is generated by a List Data task. 
If you want to run it in a code window make sure you have previously run a task. 
This will ensure that everything is set correctly for the code to run.*/

%_eg_conditional_dropds(WORK.SORTTempTableSorted);

PROC SQL;
CREATE VIEW WORK.SORTTempTableSorted AS
SELECT T.Name, T.Sex, T.Age, T.Height, T.Weight
FROM EGPROG.CLASS as T
;
QUIT;
TITLE;
TITLE1 "Report Listing";
FOOTNOTE;
FOOTNOTE1 "Generated by the SAS System (&_SASSERVERNAME, &SYSSCPL) on %SYSFUNC(DATE(), EURDFDE9.) at %SYSFUNC(TIME(), TIMEAMPM8.)";
PROC PRINT DATA=WORK.SORTTempTableSorted
	OBS="Row number"
	LABEL
	;
	VAR Name Sex Age Height Weight;
RUN;
RUN; QUIT;
%_eg_conditional_dropds(WORK.SORTTempTableSorted);

TITLE; FOOTNOTE;

/*Chapter 3. Getting Started*/

OPTIONS LOCALE='en_US';

PROC OPTIONS;
RUN;

PROC SQL;
	CREATE TABLE SASUSER.QUERY_FOR_CLASS_000A AS
	SELECT 	t1.Name,
		t1.Sex,
		t1.Age,
		t1.Height,
		t1.Weight
		FROM EGPROG.CLASS AS t1
		WHERE t1.Age > 13;
QUIT;


PROC SQL;
CREATE TABLE SASUSER.QUERY_FOR_CLASS_0009 AS
	SELECT 	t1.Name,
		t1.Sex,
		t1.Age,
		t1.Height,
		t1.Weight
	FROM EGPROG.CLASS AS t1
	WHERE ( t1.Sex = 'F' AND t1.Age BETWEEN 12 AND 15 AND
		t1.Height > 56.5 ) OR ( t1.Sex = 'M' AND t1.Age BETWEEN
		12 AND 15 AND t1.Height > 59 );
QUIT;

/* 
** The following lines of code are all code fragments to be inserted or used as indicated 
	in the book. Cut and paste from here as needed.

WHERE Age > 13;

WHERE (Sex = "F" AND Age BETWEEN 12 AND 15 AND Height > 56.5 )
OR ( Sex = "M" AND Age BETWEEN 12 AND 15 AND Height > 59 );

WHERE t1.Age > &AGE;

Generated by the SAS System (&_SASSERVERNAME, &SYSSCPL) on %SYSFUNC(DATE(), EURDFDE9.) at %SYSFUNC(TIME(), TIMEAMPM8.)

%PUT _ALL_;

WHERE Sex = "%SUBSTR(&sex,1,1)";

WHERE Sex = SUBSTR("&sex",1,1);

WHERE �&sex� = �All� or Sex = "%SUBSTR(&sex,1,1)";

ODS HTML FILE="c:\temp\myfile.html";

ODS HTML CLOSE;

ODS HTML FILE="c:\temp\file%SYSFUNC(TODAY(),MMYY5.).html";

** End of code fragments */

/*Chapter 4. Data Manipulation: Part 1*/

PROC SQL;
	SELECT * FROM EGPROG.CLASS;
QUIT;

PROC SQL;
	SELECT sex, name, age 
	FROM EGPROG.CLASS;
QUIT;

PROC SQL;
	SELECT sex, SUBSTR(name,1,1) AS initial, age 
	FROM EGPROG.CLASS;
QUIT;

PROC SQL;
	SELECT sex, SUBSTR(name,1,1) AS initial, age 
	FROM EGPROG.CLASS WHERE age GE 15;
QUIT;

PROC SQL;
	SELECT sex, SUBSTR(name,1,1) AS initial, age 
	FROM EGPROG.CLASS WHERE age GE 15 ORDER BY age;
QUIT;

PROC SQL;
	SELECT sex, SUBSTR(name,1,1) AS initial, age 
	FROM EGPROG.CLASS 
	WHERE age GE 15 
	ORDER BY sex, age DESCENDING;
QUIT;

PROC SQL;
	SELECT *, AVG(age) AS AverageAge 
	FROM EGPROG.CLASS;
QUIT;

PROC SQL;
	SELECT *, AVG(age) AS AverageAge 
	LABEL = "Average Age" FORMAT=5.2
	FROM EGPROG.CLASS;
QUIT;

PROC SQL;
	SELECT *, AVG(age) AS AverageAge 
	LABEL = "Average Age" FORMAT=5.2
	FROM EGPROG.CLASS 
	GROUP BY sex;
QUIT;

PROC SQL;
	SELECT sex, AVG(age) AS AverageAge 
	LABEL = "Average Age" FORMAT=5.2
	FROM EGPROG.CLASS 
	GROUP BY sex;
QUIT;

PROC SQL;
	SELECT sex, AVG(age) AS AverageAge 
	LABEL = "Average Age" FORMAT=5.2
	FROM EGPROG.CLASS 
	GROUP BY sex HAVING AverageAge GE 13.3;
QUIT;

PROC SQL;
	SELECT actor, title 
	FROM EGPROG.BondActors, EGPROG.BondFilms;
QUIT;

PROC SQL;
	SELECT actor, title 
	FROM EGPROG.BondActors, EGPROG.BondFilms
	WHERE BondActors.BondNo = BondFilms.BondNo;
QUIT;

PROC SQL;
	SELECT actor, title 
	FROM EGPROG.BondActors INNER JOIN EGPROG.BondFilms
	ON BondActors.BondNo = BondFilms.BondNo;
QUIT;

PROC SQL;
	CREATE TABLE FullList AS
	SELECT actor, title 
	FROM EGPROG.BondActors INNER JOIN EGPROG.BondFilms
	on BondActors.BondNo = BondFilms.BondNo;

	CREATE VIEW FullListView AS
	SELECT actor, title 
	FROM EGPROG.BondActors INNER JOIN EGPROG.BondFilms
	on BondActors.BondNo = BondFilms.BondNo;
QUIT;

PROC SQL;
	DROP TABLE FullList; 
QUIT;

PROC SQL;
	CREATE INDEX BondNo
		ON EGPROG.BondFilms(BondNo);
QUIT;

PROC SQL;
	CREATE UNIQUE INDEX FilmNo 
		ON EGPROG.BondFilms(FilmNo);
QUIT;

PROC SQL;
	CREATE INDEX FilmActor 
		ON EGPROG.BondFilms(FilmNo, BondNo);
QUIT;

PROC SQL;
	DROP INDEX FilmActor FROM EGPROG.BondFilms;
QUIT;

PROC SQL;
	DROP INDEX FilmActor FROM EGPROG.BondFilms;
	CREATE INDEX FilmActor 
		ON EGPROG.BondFilms(FilmNo, BondNo);
QUIT;

OPTIONS MSGLEVEL=i;

/* 
** The following line of code is a fragment to be inserted or used as indicated 
	in the book. Cut and paste from here as needed.

BY SEX;

** End of code fragments */

PROC SQL;
	DELETE FROM EGPROG.ZoneAccess
		WHERE EmpID in ("E1003", "E1432");
QUIT;

PROC SQL;
	SELECT EmpID FROM EGPROG.EmpMaster
		WHERE SecChange = "D";
QUIT;

PROC SQL;
	DELETE FROM EGPROG.ZoneAccess
		WHERE EmpID in (SELECT EmpID FROM EGPROG.EmpMaster
		WHERE SecChange = "D");
QUIT;

PROC SQL;
	INSERT INTO EGPROG.ZoneAccess
		VALUES ('E2343','D123','01JAN2007'd,'01JAN2008'd) 
		VALUES ('E2343','D133','01JAN2007'd,'01JAN2008'd)
		VALUES ('E2344','D133','01JAN2007'd,'01JAN2008'd);
QUIT;

PROC SQL;
	INSERT INTO EGPROG.ZoneAccess
		SET 	EmpID = 'E2343',
			Dept = 'D123',
			StartDate = '01JAN2007'd,
			EndDate = '01JAN2008'd
		SET 	EmpID = 'E2343',
			Dept = 'D133',
			StartDate = '01JAN2007'd,
			EndDate = '01JAN2008'd 
		SET 	EmpID = 'E2344',
			Dept = 'D133',
			StartDate = '01JAN2007'd,
			EndDate = '01JAN2008'd;
QUIT;	

PROC SQL;
	SELECT 	EmpMaster.EmpID, Dept,
			StartDate, EndDate  
	FROM 	EGPROG.EmpMaster,
			EGPROG.EmpDept
		WHERE 	EmpMaster.EmpID = EmpDept.EmpID
		AND 	SecChange = "A";
QUIT;

PROC SQL;
	INSERT INTO EGPROG.ZoneAccess
	SELECT 	EmpMaster.EmpID, Dept,
			StartDate, EndDate  
	FROM 	EGPROG.EmpMaster,
			EGPROG.EmpDept
	WHERE 	EmpMaster.EmpID = EmpDept.EmpID
	AND 		SecChange = "A";
QUIT;

PROC SQL;
	UPDATE EGPROG.ZoneAccess 
	SET 	EndDate = '01JAN2008'd 
	WHERE EmpID = 'E2343' AND Dept = 'D123';
QUIT;

PROC SQL;
UPDATE egprog.ZoneAccess 
	SET 	EndDate = 
	(SELECT EndDate FROM egprog.EmpDept 
	WHERE 	ZoneAccess.EmpID = EmpDept.EmpID
	AND 	  	ZoneAccess.Dept = EmpDept.Dept)
	WHERE ZoneAccess.EmpID IN 
	(SELECT EmpID FROM egprog.EmpMaster
	WHERE 	SecChange = "U")
	;
QUIT;

PROC SQL;
	ALTER TABLE EGPROG.EmpDept 
	ADD CONSTRAINT EndDate_NotNull NOT NULL(EndDate); 
QUIT;

PROC SQL;
	ALTER TABLE EGPROG.EmpDept 
	DROP CONSTRAINT EndDate_NotNull;
QUIT;

PROC SQL;
	ALTER TABLE EGPROG.EmpMaster 
	ADD CONSTRAINT Valid_SecChange 
	CHECK (SecChange in ("U", "D", "A", "X"))
	MESSAGE = 'Invalid SecChange Flag'; 
QUIT;

PROC SQL;
	ALTER TABLE EGPROG.EmpMaster 
	ADD CONSTRAINT Unique_Employee UNIQUE(EmpId); 
QUIT;

PROC SQL;
	ALTER TABLE EGPROG.EmpMaster 
	ADD CONSTRAINT Primary_Employee PRIMARY KEY(EMpId); 
QUIT;

PROC SQL;
	ALTER TABLE EGPROG.EmpDept 
	ADD CONSTRAINT Foreign_Employee 
	FOREIGN KEY(EmpId)
	REFERENCES EGPROG.EmpMaster; 
QUIT;

PROC SQL;
	ALTER TABLE EGPROG.EmpDept 
	ADD CONSTRAINT EndDate_NotNull NOT NULL(EndDate)
	ADD CONSTRAINT Foreign_Employee 
		FOREIGN KEY(EmpId)
		REFERENCES EGPROG.EmpMaster; 
QUIT;

PROC SQL;
	DESCRIBE TABLE egprog.zoneaccess;
QUIT;

/*Chapter 5. Data Manipulation: Part 2*/

DATA products;
		SET egprog.as_products;
RUN;

DATA products;
SET egprog.as_products(KEEP=description cost price product_type);
RUN;

DATA products;
SET egprog.as_products(KEEP=description cost price product_type);
unit_profit = price - cost;
RUN;

DATA products(KEEP=description product_type unit_profit);
SET egprog.as_products(KEEP=description cost price product_type);
		unit_profit = price - cost;
RUN;

PROC SQL;
		CREATE table products AS
		SELECT description, product_type,
		price - cost AS unit_profit
		FROM egprog.as_products;
QUIT;

DATA PRODUCTS(KEEP=description product_type unit_profit);
SET egprog.as_products(keep=description cost price product_type);
		unit_profit = price - cost;
RUN;

DATA PRODUCTS(KEEP=description product_type unit_profit);
SET egprog.as_products(KEEP=description cost price product_type);
		unit_profit = price - cost;
		OUTPUT;
RUN;

DATA games storage other;
SET egprog.as_products(KEEP=description cost price product_type);
		unit_profit = price - cost;
		OUTPUT;
RUN;

DATA games	storage other;
SET egprog.as_products(KEEP=description cost price product_type);
		unit_profit = price - cost;
		IF product_type = "GAMES" THEN OUTPUT games;
		ELSE IF 	product_type = "DATABASE" OR 
			 	product_type = "SPREADSHEET" 
				THEN output storage;
		ELSE OUTPUT other;
RUN;

DATA 	GAMES(KEEP=description unit_profit)
			STORAGE(KEEP=description product_type unit_profit)
			OTHER(KEEP=description product_type unit_profit);
SET egprog.as_products(KEEP=description cost price product_type);
		unit_profit = price - cost;
		IF product_type = "GAMES" THEN output games;
		ELSE IF 	product_type = "DATABASE" OR 
				product_type = "SPREADSHEET" 
				then output storage;
		ELSE output other;
RUN;

DATA tallest;
	RETAIN ranking;
	SET sortedclass;
	BY sex;
	IF first.sex THEN ranking=0;
	ranking = ranking+1;
	IF ranking LE 2 THEN OUTPUT;
RUN;

DATA tallest;
	SET sortedclass;
	BY sex;
	IF first.sex THEN ranking=0;
	ranking+1;
	IF ranking LE 2 THEN OUTPUT;
RUN;

DATA egprog.promotions 
		(KEEP=id name description start end 
		product_code product_description);
RETAIN id name description start end;
SET egprog.as_promotions;
IF promotion_id NE "" THEN DO;
		id = promotion_id;
		name = promo_name;
		description = promotion_description;
		start = datepart(start_date);
		end = datepart(end_date);
END;
FORMAT start end NLDATE.;
RUN;


/*Chapter 6. Seeing Data Differently*/

/* Note: The code below is generated by a Create Format task. 
If you want to run it in a code window make sure you have previously run a task. 
This will ensure that everything is set correctly for the code to run.*/

PROC FORMAT 
	LIB=WORK
; 
		VALUE $gender
			 "M" = "Male"
			 "F" = "Female";
RUN;

PROC FORMAT FMTLIB LIB=WORK; 
RUN;

PROC FORMAT FMTLIB LIB=WORK;
	SELECT $GENDER;
RUN;

/*Note: In the next two examples replace �yourlibrary� with the name of a library in which you 
have stored formats.*/

OPTIONS FMTSEARCH=(yourlibrary);

OPTIONS FMTSEARCH=(yourlibrary, WORK, LIBRARY, EGTASK);

PROC FORMAT LIB=WORK; 
		PICTURE CCFORMAT OTHER = "9999 9999 9999 9999";
RUN;

PROC FORMAT LIB=WORK; 
		PICTURE NEGPERC (DEFAULT=9) 
			LOW - < 0 = "09.99%)" (PREFIX="(-")
			0 - HIGH = "09.99%)" (PREFIX="(");
RUN;

PROC FORMAT LIB=WORK fmtlib; 
		PICTURE NEGPERC (DEFAULT=9) 
			LOW - < 0 = "09.99%)" 
				(PREFIX="(-" multiplier=10000)
			0 - HIGH = "09.99%)" 
				(PREFIX="(" multiplier=10000);
RUN;

PICTURE million LOW-HIGH='00.0M' 
       (PREFIX='$' MULT=.00001);

PROC FORMAT LIB=WORK fmtlib; 
		PICTURE mydate 
OTHER = "Day %w of week %U in the year %Y" (datatype=date);
RUN;

PROC FORMAT LIB=WORK; 
	VALUE agegroup (MULTILABEL NOTSORTED)
		11 -13 = "11 to 13 years old"
		14 -16 = "14 to 16 years old"
		11-12 = "Pre-Teenager"
		13-16 = "Teenager";
RUN;

PROC FORMAT LIB=WORK;
	VALUE history
		LOW -< '01JAN2000'd = [YYQ6.]
		'01JAN2000'd - HIGH = [YYMM7.];
RUN;

PROC FORMAT CNTLIN=bondformat;
RUN;

PROC FORMAT LIB=work;
INVALUE $genderin (UPCASE)
	"MALE" = "M"
	"FEMALE" = "F";
RUN;

/*Chapter 7. Enhancing Report Output*/

/*Note: In the following examples words starting with the prefix �your� should 
be replaced with your own relevant information. */

/* 
** The following lines of code are all code fragments to be inserted or used as indicated 
	in the book. Cut and paste from here as needed.

ODS RTF 	FILE='yourfile.rtf' 
			AUTHOR="yourname" TITLE="yourtitle";

ODS PDF 	FILE='yourfile.pdf' 
			AUTHOR="yourname" TITLE="yourtitle";

ODS PDF 	FILE='yourfile.pdf' 
			AUTHOR="yourname" TITLE="yourtitle"
			STARTPAGE=NO;

ODS RTF 	FILE='yourfile.rtf'
			AUTHOR="yourname" TITLE="yourtitle"
			STYLE=BARRETTSBLUE;

OPTIONS ORIENTATION=LANDSCAPE;
ODS RTF 	FILE='yourfile.rtf' 
			AUTHOR="yourname" TITLE="yourtitle"
			STYLE=BARRETTSBLUE;

ODS PDF 	FILE='yourfile.pdf' 
			BOOKMARKGEN=YES
			BOOKMARKLIST=YES;

ODS HTML 	FILE='yourfile.html' 
			STYLE=BARRETTSBLUE
			STYLESHEET='yourstyle.css';

ODS HTML 	FILE='yourfile.html' 
			STYLESHEET=(URL='yourstyle.css');

ODS HTML PATH="c:\temp" FRAME="frame.html" (TITLE='Frames Output') BODY="prod.html" CONTENTS="contents.html" NEWFILE=bygroup ;

ODS HTML CLOSE;

OPTIONS NOBYLINE;

OPTIONS BYLINE;

Listing for #BYVAL(sex) Students

ODS ESCAPECHAR="*";

OPTIONS NOBYLINE;
ODS ESCAPECHAR="*";

Page *{thispage} of *{lastpage}

Page *{pageof}

TITLE J=L 'Confidential' J=C 'Listing for #BYVAL(sex) students' J=R 'Page *{thispage} of *{lastpage}';

FOOTNOTE LINK="mypdf.pdf" "Print Version";
ODS HTML PATH="c:\temp\" FILE="myhtml.html"
			STYLE=barrettsblue STYLESHEET="mystyle.css";
ODS PDF FILE="c:\temp\mypdf.pdf" BOOKMARKGEN=NO;
ODS HTML CLOSE;
ODS PDF CLOSE;

** End of code fragments */

PROC REPORT DATA=egprog.class;
RUN;

PROC REPORT DATA=egprog.class;
		COLUMN sex age height weight;
RUN;

PROC REPORT DATA=egprog.class;
		COLUMN sex age height weight;
		DEFINE sex / 'Gender' CENTER;
		DEFINE age / CENTER;
		DEFINE height / FORMAT=3.0;
		DEFINE weight / FORMAT=3.0;
RUN;

PROC REPORT DATA=egprog.class;
		COLUMN sex age height weight;
		DEFINE sex / ORDER 'Gender' CENTER;
		DEFINE age / CENTER;
		DEFINE height / FORMAT=3.0;
		DEFINE weight / FORMAT=3.0;
RUN;

PROC REPORT DATA=egprog.class ;
		COLUMN sex age height weight hwratio;
		DEFINE sex / ORDER 'Gender' CENTER;
		DEFINE age / CENTER;
		DEFINE height / FORMAT=3.0;
		DEFINE weight / Format=3.0;
		DEFINE hwratio / COMPUTED 'Ratio' FORMAT=4.2;
		COMPUTE hwratio;
			HWRATIO = height.SUM / weight.SUM;
		ENDCOMP;
RUN; 

PROC REPORT DATA=egprog.class ;
	COLUMN age height weight;
RUN;

PROC REPORT DATA=egprog.class ;
		COLUMN age height weight;
		DEFINE age / DISPLAY;
RUN;

PROC REPORT DATA=egprog.class ;
		COLUMN age height weight;
		DEFINE age / MEAN;
		DEFINE height / MEAN;
		DEFINE weight / MEAN;
RUN;

PROC REPORT DATA=egprog.class ;
		COLUMN ('Age' age age=maxage) 
			('Height' height height=maxheight) 
			('Weight' weight weight=maxweight);
		DEFINE age / MIN 'Minimum ';
		DEFINE maxage / MAX 'Maximum ';
		DEFINE height / MIN 'Minimum ';
		DEFINE maxheight / MAX 'Maximum ';
		DEFINE weight / MIN 'Minimum ';
		DEFINE maxweight / MAX 'Maximum ';
run;

PROC REPORT DATA=egprog.class ;
		COLUMN sex age height weight hwratio;
		DEFINE sex /  ORDER DESCENDING 'Gender' CENTER;
		DEFINE age / DISPLAY CENTER;
		DEFINE height / format=4.0;
		DEFINE weight / FORMAT=4.0;
		DEFINE hwratio / COMPUTED 'Ratio' FORMAT=4.2;
		RBREAK AFTER / SUMMARIZE;
		BREAK AFTER sex / SUMMARIZE;
		COMPUTE hwratio;
			hwratio = height.sum / weight.sum;
		ENDCOMP;
RUN;

PROC REPORT DATA=egprog.class ;
		COLUMN sex age height weight hwratio;
		DEFINE sex /  GROUP DESCENDING 'Gender' CENTER;
		DEFINE age / GROUP  CENTER;
		DEFINE height / FORMAT=4.0;
		DEFINE weight / FORMAT=4.0;
		DEFINE hwratio / COMPUTED 'Ratio' format=4.2;
		RBREAK AFTER / SUMMARIZE;
		BREAK AFTER sex / SKIP SUMMARIZE;
		COMPUTE hwratio;
			hwratio = height.sum / weight.sum;
		ENDCOMP;
RUN;

TITLE 'Listing of Female Students';
PROC REPORT DATA=egprog.class nowd;
		COLUMN name age age=minage age=maxage height weight n;
		DEFINE minage / MIN NOPRINT;
		DEFINE maxage / MAX NOPRINT;
		DEFINE height /MEAN;
		DEFINE weight /MEAN;
		DEFINE N / NOPRINT;
		WHERE sex = 'F';
		COMPUTE AFTER;
			LINE ' ';
			x = CATX(' ','The ', n ,' female students in the class are aged between ');
			LINE x $55.;
			y = CATX(' ', minage, ' and ', maxage, ' years old. They have an average height of  ');
			LINE y $55.;
			z = CATX(' ', put(height.mean,5.1) ,' inches, and 
				an average weight of ', 
			put(weight.mean,5.1) , ' pounds.');
			LINE z $55.;
		ENDCOMP;
RUN;

ODS HTML PATH="c:\temp" BODY="contents.html";
PROC REPORT DATA=egprog.as_products;
COLUMN product_type n;
DEFINE product_type / GROUP 'Product Type';
DEFINE N / 'Number of/Products';
RUN;
ODS HTML CLOSE;

ODS HTML PATH="c:\temp" (URL=NONE) body="contents.html";
PROC REPORT DATA=egprog.as_products;
		COLUMN product_type N;
		DEFINE product_type / GROUP 'Product Type';
		DEFINE n / 'Number of/Products';
		COMPUTE BEFORE;
			counter = 1;
		ENDCOMP;
		COMPUTE product_type;
			IF counter = 0 THEN CALL DEFINE (_col_ ,'url','prod.html');
			ELSE CALL DEFIne (_col_ ,"url",cats('prod',counter,'.html'));
			counter=counter+1;
		ENDCOMP;
RUN;
ODS HTML CLOSE;

/* 
** The following lines of code are all code fragments to be inserted or used as indicated 
	in the book. Cut and paste from here as needed.

FOOTNOTE LINK='contents.html' 'Return to Contents'; 

VAR name sex age height;
VAR weight / STYLE(DATA) = 
            {BACKGROUND = wformat. };
* This comments out as far as the next semicolon

*{STYLE={BACKGROUND=wformat.}}

** End of code fragments */

PROC REPORT DATA=egprog.class;
		COLUMN name age sex height weight;
		DEFINE WEIGHT / STYLE=[BACKGROUND=wformat.];
RUN;

PROC REPORT DATA=egprog.class;
		COLUMN name age sex height weight;
		COMPUTE WEIGHT;
			IF weight.sum > 100 THEN CALL DEFINE
				(_COL_,"STYLE","STYLE={BACKGROUND=RED}");
		ENDCOMP;
RUN;

/*Note: In the following examples replace �myoutput� with any valid name. */

/* 
** The following lines of code are all code fragments to be inserted or used as indicated 
	in the book. Cut and paste from here as needed.

ODS PDF FILE='c:\temp\myfile.pdf';
ODS HTML FILE='c:\temp\myfile.html';
ODS HTML TEXT="<a HREF='c:\temp\myfile.pdf' TARGET='_blank'>Printable
Version</a>";

ODS HTML TEXT="<a href='c:\temp\myfile.pdf' target='_blank'
style='float: right; text-decoration: none; background-color:
blue; color: white; padding: 5px;'>Printable Version</a>";

ODS CSVALL FILE="yourfile.csv";

ODS CSV FILE="yourfile.csv";

ODS TAGSETS.EXCELXP FILE="yourfile.xls";

ODS _ALL_ CLOSE;
 
** End of code fragments */

/*Chapter 8. Graphical Output*/

PROC GCHART DATA=egprog.class;
	VBAR3D Sex;
	RUN; 
QUIT;

PROC SQL;
	SELECT product_type, mean(price) AS Average_price 
	FROM EGPROG.as_products GROUP BY product_type;
QUIT;

PROC SQL NUMBER;
	SELECT product_type, mean(price) AS Average_price 
	FROM egprog.as_products GROUP BY product_type;
QUIT;

ODS OUTPUT SQL_RESULTS=Prod1;
PROC SQL NUMBER;
	SELECT product_type, mean(price) AS Average_price 
	FROM egprog.as_products GROUP BY product_type;
QUIT;

ODS OUTPUT SQL_RESULTS=Prod1;
PROC SQL NUMBER;
	SELECT product_type, MEAN(price) AS Average_price
		FROM egprog.as_products GROUP BY product_type;
	CREATE TABLE Prod2 AS
		SELECT product_type, Average_price,
		CATS("href='c:\temp\prod",row,".html'") AS href
		FROM prod1;
	DROP TABLE Prod1;
QUIT;

/* 
** The following lines of code are all code fragments to be inserted or used as indicated 
	in the book. Cut and paste from here as needed.

HTML=href

EXPLODE="GAMES"

EXPLODE="GAMES" "SPREADSHEET"

EXPLODE="&segname"

DETAIL=sex

DETAIL=sex;
FORMAT sex $gender.

** End of code fragments */

PROC GAREABAR DATA=egprog.revenue;
   HBAR3D product_type*quantity / SUMVAR=revenue; 
RUN;

/*Chapter 9. Macro � Reusable Programming*/

TITLE "Listing of Students aged 14";
PROC REPORT DATA=egprog.class;
	COLUMNS name sex height weight;
	WHERE age = 14;
RUN;

%LET limit = 14;
TITLE "Listing of Students aged &limit";
	PROC REPORT DATA=egprog.class;
	COLUMNS name sex height weight;
	WHERE age = &limit;
RUN;

%MACRO myprint;
TITLE "Listing of Students aged &limit";
PROC REPORT DATA=egprog.class;
	COLUMNS name sex height weight;
	WHERE age = &limit;
RUN;
%mend;

%LET limit=14;
%myprint
%LET limit=13;
%myprint

%MACRO myprint(limit);
TITLE "Listing of Students aged &limit";
PROC REPORT DATA=egprog.class;
	COLUMNS name sex height weight;
	WHERE age = &limit;
RUN;
%MEND;

%myprint(14)
%myprint(13)

%MACRO myprint(limit,gender);
%IF &gender = M %THEN %LET fullgender = Male;
%ELSE %LET fullgender = Female;
TITLE "Listing of &fullgender Students Aged &limit";
PROC REPORT DATA=egprog.class;
	COLUMNS name sex height weight;
	WHERE age = &limit and sex="&gender";
RUN;
%mend;

%myprint(14,M)
%myprint(13,F)

/* 
** The following lines of code are all code fragments to be inserted or used as indicated 
	in the book. Cut and paste from here as needed.

%macro myprint(limit=,gender=);

%myprint(limit=14,gender=M)

%macro myprint(limit=14,gender=M);

** End of code fragments */

%myprint() /* Uses default of 14 and M */
%myprint(gender=F) /* Uses default of 14 and passed F */
%myprint(limit=13) /* Uses default of M and passed 13*/
%myprint(gender=F,limit=13) 
				/* Uses passed values of 13 and F */


/* 
** The following lines of code are all code fragments to be inserted or used as indicated 
	in the book. Cut and paste from here as needed.

Listing of &fullgender Students Aged &limit

%MACRO myprint(limit=14,gender=M);
%IF &gender = M %THEN %LET fullgender = Male;
%ELSE %LET fullgender = Female;

WHERE age = &limit and sex="&gender";
%MEND;

** End of code fragments */

%myprint() /* Uses default of 14 and M */
%myprint(gender=F) /* Uses default of 14 and passed F */
%myprint(limit=13) /* Uses default of M and passed 13*/
%myprint(gender=F,limit=13) 
				/* Uses passed values of 13 and F */

/* 
** The following lines of code are all code fragments to be inserted or used as indicated 
	in the book. Cut and paste from here as needed.

Listing of &fullgender Students Aged &limit

%MACRO myprint(limit=14,gender=M);
%IF &gender = M %THEN %LET fullgender = Male;
%ELSE %LET fullgender = Female;

WHERE age = &limit and sex="&gender";

%MEND;

WHERE "&sex" = "_ALL_VALUES_" or Sex = "%SUBSTR(&sex,1,1)";

Listing for %sysfunc(IFC(&sex=_ALL_VALUES_,All,&sex)) students

WHERE %_eg_WhereParam( name, Promo, IN, TYPE=S );

%scan(%_eg_WhereParam(name, Promo, IN, TYPE=S ),2,())

List of the following promotions %scan(%_eg_WhereParam(name,
Promo, IN, TYPE=N ),2,())  

** End of code fragments */

%MACRO LINKS(file);
ODS HTML FILE="&file..html";
ODS PDF FILE="&file.pdf";
ODS HTML TEXT="<a href=�&file..pdf' target='_blank'
style='float: right; text-decoration: none; background-color:
blue; color: white; padding: 5px;'>Printable Version</a>";
%MEND;

/* 
** The following lines of code are all code fragments to be inserted or used as indicated 
	in the book. Cut and paste from here as needed.


%INCLUDE 'c:\temp\links.sas';
%LINKS(c:\temp\myfile)


** End of code fragments */

PROC SQL NOPRINT;
	SELECT product_type INTO :explode SEPARATED BY '" "'
	FROM work.pie
	WHERE frequency = (SELECT MAX(frequency) FROM work.pie);
QUIT;
%LET explode = "&explode";

PROC SQL ;
SELECT product_type FROM work.pie
WHERE frequency = (SELECT MAX(frequency) FROM work.pie);
QUIT;

PROC SQL ;
SELECT product_type INTO :explode SEPARATED BY '" "'
FROM work.pie
WHERE frequency = (SELECT MAX(frequency) FROM work.pie);
QUIT;

/* 
** The following line of code is a code fragment to be inserted or used as indicated 
	in the book. Cut and paste from here as needed.

EXPLODE = &explode

** End of code fragment */

/*Appendix A*/

PROC CONTENTS DATA=yourlibrary._ALL_ NODS;
RUN;

/* 
** The following line of code is a code fragment to be inserted or used as indicated 
	in the book. Cut and paste from here as needed.

STARFILL=SOLID CSTARFILL=RED

** End of code fragment */

/*Appendix B*/

PROC APPEND BASE=table1 DATA=table2;
RUN;

OPTIONS PARMCARDS=extfile;
FILENAME extfile "parmfile";
PROC EXPLODE;
PARMCARDS;
 HELLO!
		;
PROC OPTIONS;
RUN;

PROC OPTIONS OPTION=LOCALE;
RUN;

PROC OPTIONS GROUP=ERRORHANDLING;
RUN;

/*Appendix D*/

/* 
** The following lines of code are all code fragments to be inserted or used as indicated 
	in the book. Cut and paste from here as needed.

WHERE age GE &lower AND age LE &Upper;

ODS PDF FILE="c:\temp\&sysuserid.pdf";

** End of code fragments */

PROC SQL;
	SELECT 	empmaster.empid LABEL="Number", 
			name LABEL="Name", 
			dept LABEL="Department", 
			startdate LABEL="Start Date" FORMAT=DDMMYY10., 
			enddate LABEL="End Date" FORMAT=DDMMYY10.
	FROM egprog.empmaster, egprog.empdept
	WHERE empmaster.empid = empdept.empid;
QUIT;

PROC SQL;
	SELECT * FROM egprog.empmaster;
	UPDATE egprog.empmaster 
	SET 	secchange = "X"
	WHERE secchange NE "X";
	SELECT * FROM egprog.empmaster;
QUIT;

PROC SQL;
	ALTER TABLE egprog.empdept 
		DROP CONSTRAINT valid_date
		ADD CONSTRAINT valid_date 
		CHECK (startdate < enddate)
		MESSAGE = 'Start Date must be before End Date'; 
	DESCRIBE TABLE egprog.empdept;
	ALTER TABLE egprog.zoneaccess 
		DROP CONSTRAINT valid_date
		ADD CONSTRAINT valid_date 
		CHECK (startdate < enddate)
		MESSAGE = 'Start Date must be before End Date'; 
	DESCRIBE TABLE egprog.empdept;
QUIT;

DATA 	promotions
		(KEEP=	promotion promo_name promotion_description 
			start_date end_date)
		promotion_product(KEEP=promotion product_code);
	RETAIN Promotion;
	SET egprog.as_promotions;
	IF Promotion_id NE " " THEN DO;
		promotion=promotion_id;
		start_date=DATEPART(start_date);
		end_date=DATEPART(end_date);
		OUTPUT promotions;
	END;
	OUTPUT promotion_product;
	FORMAT start_date end_date DDMMYY10.;
RUN;

PROC FORMAT CNTLIN=pformat FMTLIB;
RUN;

PROC FORMAT FMTLIB;
PICTURE phone (DEFAULT=16)
	LOW-HIGH = 9) 999 999 9999 (PREFIX="(");
RUN;

PROC FORMAT FMTLIB;
PICTURE phone
	LOW-HIGH = 999 999 9999 (PREFIX="(0) ");
RUN;

/* 
** The following lines of code are all code fragments to be inserted or used as indicated 
	in the book. Cut and paste from here as needed.

OPTIONS NOBYLINE;
ODS HTML FILE='C:\temp\bond.html' NEWFILE=PAGE;

List of James Bond Films starring #BYVAL(actor)

EXPLODE=�&pie�

ODS OUTPUT SQL_RESULTS=bondgraph1;
PROC SQL NUMBER;
	SELECT actor, count(*) AS number_of_films 
	FROM completebond GROUP BY actor;

	CREATE TABLE bondgraph AS
	SELECT actor, number_of_films, 
	CASE row
 		WHEN 1 THEN "href='c:\temp\bond.html'"
 		ELSE CATS("href='c:\temp\prod",row - 1,".html'")
 	END AS href 
	FROM bondgraph1;
	DROP TABLE bondgraph1;
QUIT;

HTML=href

%MACRO mypie(pie);

%MEND;

%mypie(February Gamer)

** End of code fragments */
