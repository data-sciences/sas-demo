

%LET user= my_user; %LET pw = my_password; %LET path=my_path;
PROC SQL;
  CONNECT TO ORACLE(USER=&user PW=&pw PATH="&path");
    CREATE TABLE NY_Recent AS SELECT * FROM CONNECTION TO ORACLE
    (
      SELECT SN, Install
      FROM Units
      WHERE Loc = 'NY'
      AND Install >= '09-JUN-2006'
    );
  %PUT SQLXMSG;
  DISCONNECT FROM ORACLE;
QUIT;

DATA NY_Recent; SET NY_Recent;
   FORMAT Install DATE9.;
   Install=DATEPART(Install);
RUN;

PROC SQL;
  CONNECT TO ORACLE(USER=&user PW=&pw PATH="&path");
    CREATE TABLE Join AS SELECT * FROM CONNECTION TO ORACLE
    (
      SELECT Units.*, Fails.Fail, Fails.Code
      FROM Units, Fails
      WHERE Units.SN = Fails.SN
    );
  %PUT SQLXMSG;
  DISCONNECT FROM ORACLE;
QUIT;

PROC SQL;
  CONNECT TO ORACLE(USER=&user PW=&pw PATH="&path");
    CREATE TABLE Join_Left AS SELECT * FROM CONNECTION TO ORACLE
    (
      SELECT Units.*, Fails.Fail
      FROM Units, Fails
      WHERE Units.SN = Fails.SN(+)
    );
  %PUT SQLXMSG;
  DISCONNECT FROM ORACLE;
QUIT;

PROC SQL;
  CONNECT TO ORACLE(USER=&user PW=&pw PATH="&path");
    CREATE TABLE Join_Right AS SELECT * FROM CONNECTION TO ORACLE
    (
      SELECT Units.*, Fails.Fail
      FROM Units, Fails
      WHERE Units.SN(+) = Fails.SN
    );
  %PUT SQLXMSG;
  DISCONNECT FROM ORACLE;
QUIT;


/*
   Full Outer Join is new in Oracle 9i
*/
PROC SQL;
  CONNECT TO ORACLE(USER=&user PW=&pw PATH="&path");
    CREATE TABLE Join_Full AS SELECT * FROM CONNECTION TO ORACLE
    (
      SELECT Units.*, Fails.Fail
      FROM Units FULL OUTER JOIN Fails
      ON  Units.SN = Fails.SN
    );
  %PUT SQLXMSG;
  DISCONNECT FROM ORACLE;
QUIT;
