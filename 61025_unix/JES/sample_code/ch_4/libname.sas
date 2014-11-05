

 %LET USER=my_user; %LET pw =my_password; %LET path=my_path;
 LIBNAME Jesdb ORACLE USER=&user PW=&pw PATH=&path;

 LIBNAME Smith ORACLE USER=&user PW=&pw PATH=&path SCHEMA="smith";
 
 /*===========================================
 Extract a subset of the Units data set
 ============================================*/
 PROC SQL;
         CREATE TABLE NY_Recent_1 AS
         SELECT SN, Install
         FROM Jesdb.Units
         WHERE Loc = "NY"
         AND DATEPART(Install) >= '09JUN2006'd ;
 QUIT;

 
 /*===========================================
 Extract the same subset of the Units data set
 using a DATA step instead of PROC SQL
 ============================================*/

 DATA NY_Recent_2; SET Jesdb.Units;
    IF Loc="NY";
    IF DATEPART(Install) >= '09JUN2006'd;
    KEEP SN Install;
 RUN;

 /*==============================================
  Convert Install from a Datetime to a Date value
 ===============================================*/
 DATA NY_Recent_1; SET NY_Recent_1;
    FORMAT Install DATE9.;
    Install=DATEPART(Install);
 RUN;
  

 /*=============================================
 Use PROC SQL to MERGE, or JOIN, the data sets
 Units and Fails
 Use alias's for the full table name
 =============================================*/
 PROC SQL;
         CREATE TABLE Join AS 
                 SELECT u.*, f.Fail, f.Code
                 FROM Jesdb.Units u, Jesdb.Fails f
                 WHERE u.SN = f.SN;
 QUIT;

 
 /*=============================================
 Use a Left Outer Join to join the data sets
 Units and Fails, including unmatched rows from 
 Units
 =============================================*/
 PROC SQL;
         CREATE TABLE Join_Left AS 
                 SELECT Units.*, Fails.Fail, Fails.Code
                 FROM Jesdb.Units LEFT JOIN Jesdb.Fails
                 ON Units.SN = Fails.SN;
 QUIT;
 
 
 /*=============================================
 Use a Right Outer Join to join the data sets
 Units and Fails, Including unmatched rows from
 Fails
 =============================================*/
 PROC SQL;
         CREATE TABLE Join_Right AS 
                 SELECT Units.*, Fails.Fail, Fails.Code
                 FROM Jesdb.Units RIGHT JOIN Jesdb.Fails
                 ON Units.SN = Fails.SN;
 QUIT;

 
 /*=============================================
 Use a Full Outer Join to join the data sets
 Units and Fails, Including unmatched rows from
 Fails
 =============================================*/
 PROC SQL;
         CREATE TABLE Join_FULL AS 
                 SELECT Units.*, Fails.Fail, Fails.Code
                 FROM Jesdb.Units FULL JOIN Jesdb.Fails
                 ON Units.SN = Fails.SN;
 QUIT;

 
 /*=============================================
 A Left Join with a WHERE clause
 =============================================*/
 PROC SQL;
         CREATE TABLE Join_Left_2 AS 
                 SELECT Units.*, Fails.Fail, Fails.Code
                 FROM Jesdb.Units LEFT JOIN Jesdb.Fails
                 ON Units.SN = Fails.SN
             WHERE DATEPART(Units.Install)>='09JUN2006'd;
 QUIT;

 
 
