
 /*=============================================
  Oracle query showing
  SQL syntax for selecting records with the SN 
  field matching values in a list
  =============================================*/
%LET USER=my_user; %LET pw =my_password; %LET path=my_path;
 PROC SQL;
   CONNECT TO ORACLE(USER=&user PW=&pw PATH="&path");
     CREATE TABLE SN_Match AS SELECT * FROM CONNECTION TO ORACLE
     (
       SELECT * FROM Units
       WHERE SN IN ('0027','0016','0156')
     );
   %PUT SQLXMSG;
   DISCONNECT FROM ORACLE;
 QUIT;


 /*=============================================
  Create a SAS data set containing a list of SN
  =============================================*/
 DATA SN_Table;
     SN="0027"; OUTPUT;
     SN="0016"; OUTPUT;
     SN="0156"; OUTPUT;
 RUN;


 /*=============================================
  Use a SAS/ACCESS LIBNAME Statement to
  join an Oracle DBMS with a SAS data set
  =============================================*/
 LIBNAME Jesdb ORACLE USER=&user PW=&pw PATH=&path;
 PROC SQL;
      CREATE TABLE SN_Match_1 AS 
          SELECT Units.*
          FROM Jesdb.Units, SN_Table
          WHERE Units.SN = SN_Table.SN;
 QUIT;


 /*===============================================
  Same  query as above, but using the DBKEY option
  ===============================================*/
 LIBNAME Jesdb ORACLE USER=&user PW=&pw PATH=&path;
 PROC SQL;
      CREATE TABLE SN_Match_2 AS 
          SELECT Units.*
          FROM Jesdb.Units (DBKEY=SN), SN_Table
          WHERE Units.SN = SN_Table.SN;
 QUIT;

 /*===============================================
  Same  query as above, but using the
  MULTI_DATASRC_OPT option
  ===============================================*/
 LIBNAME Jesdb ORACLE USER=&user PW=&pw PATH=&path
         MULTI_DATASRC_OPT=IN_CLAUSE;
 PROC SQL;
      CREATE TABLE SN_Match_3 AS 
          SELECT Units.*
          FROM Jesdb.Units, SN_Table
          WHERE Units.SN = SN_Table.SN;
 QUIT;


 /*=============================================
  Create a macro variable containing all values
  SN in the data set SN_Table, formatted as a
  list for use in an SQL query
  - From SUGI Paper 155-27 by Garth Helf
  =============================================*/
 PROC SQL NOPRINT;
    SELECT DISTINCT TRANSLATE(QUOTE(TRIM(LEFT(SN))), "'", '"')
     INTO :snlist SEPARATED BY ','
     FROM SN_Table;
 QUIT;
 %PUT snlist=&snlist;

 /*=============================================
  Use the &snlist variable created above in a
  Pass-Through SQL query
  =============================================*/
 PROC SQL;
   CONNECT TO ORACLE(USER=&user PW=&pw PATH="&path");
     CREATE TABLE SN_Match_4 AS SELECT * FROM CONNECTION TO ORACLE
     (SELECT * FROM Units WHERE SN IN (&snlist)  );
   DISCONNECT FROM ORACLE;
 QUIT;
