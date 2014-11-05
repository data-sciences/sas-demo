/*-------------------------------------------------------------------------------------------
13.2.1  Specifying a Libref to a Relational Database
-------------------------------------------------------------------------------------------*/
LIBNAME RelDB oracle USER     = 'scott'
                     PASSWORD = 'tiger' 
                     PATH     = 'unix'
                     SCHEMA   = 'production';

/*-------------------------------------------------------------------------------------------
13.2.2  Accessing Data
-------------------------------------------------------------------------------------------*/
DATA data.CustomerData;
 SET RelDB.CustomerData;
RUN;

PROC COPY IN  = RelDB OUT = data;
 SELECT CustomerData UsageData;
RUN;

/*-------------------------------------------------------------------------------------------
13.2.3  Implicit Pass-Through
-------------------------------------------------------------------------------------------*/

DATA data.CustomerData_S1;
 SET RelDB.CustomerData;
 WHERE Segment = 1;
RUN;
PROC MEANS DATA = RelDB.CustomerData;
 VAR age income;
RUN;

/*-------------------------------------------------------------------------------------------
13.2.4  Explicit Pass-Through
-------------------------------------------------------------------------------------------*/


PROC SQL;
 CONNECT TO ORACLE (USER     = 'scott'
                    PASSWORD = 'tiger' 
                    PATH     = 'unix');
 %PUT &sqlxmsg;
 CREATE TABLE CustomerData_S1
 AS
 SELECT *
 FROM CONNECTION TO ORACLE
   (SELECT *
    FROM dwh.CustomerData
    WHERE Segment = 1)
 %PUT &sqlxmsg;
 DISCONNECT FROM ORACLE;
QUIT;


/*-------------------------------------------------------------------------------------------
13.3.1  Using LIBNAME Statements
-------------------------------------------------------------------------------------------*/

LIBNAME xlslib 'c:\data\lookup.xls';
LIBNAME mdblib 'c:\data\productlist.mdb';
DATA lookup;
 SET xlslib.'Sheet1$'n;
RUN;

/*-------------------------------------------------------------------------------------------
13.3.2  Using PROC IMPORT
-------------------------------------------------------------------------------------------*/

PROC IMPORT OUT= lookup 
            DATAFILE= "c:\data\lookup.xls" 
            REPLACE;
            GETNAMES=YES;
RUN;


/*-------------------------------------------------------------------------------------------
13.4  Accessing Data from Text Files
-------------------------------------------------------------------------------------------*/

Date;CustomerID;Duration;NumberOfCalls;Amount
010505;31001;8874.3;440;32.34
010505;31002;0;0;0
010505;31003;2345;221;15.99
010505;31004;1000.3;520;64.21
010505;31005;5123;50;77.21
020505;31001;1887.3;640;31.34
020505;31002;0;0;0
020505;31003;1235;221;27.99
020505;31004;1100.3;530;68.21
020505;31005;1512;60;87.21

;

DATA CDR_Data;
 INFILE 'C:\DATA\CDR.csv' DELIMITER = ';' 
         MISSOVER DSD LRECL=32767 FIRSTOBS=2 ;

 INFORMAT Date          ddmmyy. 
          CustomerID    8. 
          Duration      8.1 
          NumberOfCalls 8.
          Amount        8.2 ;

 FORMAT Date          date9. 
        CustomerID    8. 
        Duration      8.2 
        NumberOfCalls 8.
        Amount        8.2 ;

 INPUT Date CustomerID Duration NumberOfCalls Amount;
RUN;

/*-------------------------------------------------------------------------------------------
13.5  Accessing Data from Hierarchical Text Files
-------------------------------------------------------------------------------------------*/

C;31001;160570;MALE;STANDARD
U;010505;8874.3;440;32.34
U;020505;1887.3;640;31.34
U;030505;0;0;0
U;040505;0;0;0
C;31002;300748;FEMALE;ADVANCED
U;010505;2345;221;15.99
U;020505;1235;221;27.99
U;030505;1000.3;520;64.21
C;31003;310850;FEMALE;STANDARD
U;010505;1100.3;530;68.21
U;020505;5123;50;77.21
U;030505;1512;60;87.21

;

DATA CustomerCDR;
   DROP check;
   RETAIN CustID BirthDate Gender Tariff;
   INFORMAT 
          CustID		8.
          BirthDate		ddmmyy.
          Gender		$6.
          Tariff		$10.
          Date          ddmmyy. 
          Duration      8.1 
          NumberOfCalls 8.
          Amount        8.2 ;
   FORMAT CustID		8.
          BirthDate		date9.
          Gender		$6.
          Tariff		$10.
          Date          date9. 
          Duration      8.2 
          NumberOfCalls 8.
          Amount        8.2 ;
  INFILE 'C:\data\hierarch_DB.csv' DELIMITER = ';' 
            DSD LRECL=32767 FIRSTOBS=1 ;
   LENGTH check $ 1;
   INPUT @@ check $;
   IF check = 'C' THEN INPUT  CustID BirthDate Gender $ Tariff $;
   ELSE if check = 'U' THEN INPUT Date Duration NumberOfCalls Amount;
   IF check = 'U' THEN OUTPUT;
RUN;





data CustomerCDR
     Customer(keep= CustID BirthDate Gender Tariff)
     CDR(keep = CustID Date Duration NumberOfCalls Amount);
< more DATA step code lines, see above example >
   if check = 'U' then do;  output CDR;
                            output CustomerCDR; end;
   if check = 'C' then output Customer;
RUN;
