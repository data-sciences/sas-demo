/*-------------------------------------------------------------------*/
 /*             PROC SQL: Beyond the Basics Using SAS                */
 /*                     by Kirk Paul Lafler                          */
 /*       Copyright(c) 2004 by SAS Institute Inc., Cary, NC, USA     */
 /*                   SAS Publications order # 58316                 */
 /*                        ISBN 1-59047-534-8                        */
 /*------------------------------------------------------------------*/
 /*                                                                  */
 /* This material is provided "as is" by SAS Institute Inc.  There   */
 /* are no warranties, expressed or implied, as to merchantabilityor */
 /* fitness for a particular purpose regarding the materials or coe  */
 /* contained herein. The Institute is not responsible for errors    */
 /* in this material as it now exists or will exist, nor does the    */
 /* Institute provide technical support for it.                      */
 /*------------------------------------------------------------------*/
 /* Date last updated: October 22, 2004                              */
 /*------------------------------------------------------------------*/
 /* Questions or problem reports concerning this material may be     */
 /* addressed to the author:                                         */
 /*                                                                  */
 /* SAS Institute Inc.                                               */
 /* Books by Users                                                   */
 /* Attn: Kirk Paul Lafler                                           */
 /* SAS Campus Drive                                                 */
 /* Cary, NC   27513                                                 */
 /*                                                                  */
 /*                                                                  */
 /* If you prefer, you can send email to:  sasbbu@sas.com            */
 /* Use this for subject field:                                      */
 /*     Comments for Kirk Paul Lafler                                */
 /*                                                                  */
 /*------------------------------------------------------------------*/


/****************************************************************/
/* INSTRUCTIONS FOR CREATING TABLES AND USING CODE EXAMPLES     */
/*      (1) Create the tables using the DATA steps below by     */
/*          copying and pasting the code into the SAS Display   */
/*          Manager. Each DATA step consists of complete code   */
/*          and instream data.                                  */
/*      (2) Copy and paste the PROC SQL code into the SAS       */
/*          Display Manager.                                    */
/*      (3) Run the code corresponding to the selected example. */
/****************************************************************/

/*********************************************************************/
/* READ IN THE SAMPLE DATA                                           */
/*  The following DATA step code is set up to store all files and    */
/*  tables in the WORK directory. If you wish to use a different     */
/*  directory, define a user-defined libref with a LIBNAME statement,*/ 
/*  store or copy the data to the desired folder, then reference the */ 
/*   libref in the FROM clauses used in the examples.                */
/*********************************************************************/

options ls=132 nofmterr nocenter nodate nonumber;


/*******************/
/* CUSTOMERS TABLE */
/*******************/
DATA CUSTOMERS;
  INFILE CARDS MISSOVER;
  INPUT @1 CUSTNUM 4.  @7 CUSTNAME $25.  @36 CUSTCITY $20.;
  CARDS;
 101  La Mesa Computer Land        La Mesa
 201  Vista Tech Center            Vista
 301  Coronado Internet Zone       Coronado
 401  La Jolla Computing           La Jolla
 501  Alpine Technical Center      Alpine
 601  Oceanside Computer Land      Oceanside
 701  San Diego Byte Store         San Diego
 801  Jamul Hardware & Software    Jamul
 901  Del Mar Tech Center          Del Mar
1001  Lakeside Software Center     Lakeside
1101  Bonsall Network Store        Bonsall
1201  Rancho Santa Fe Tech         Rancho Santa Fe
1301  Spring Valley Byte Center    Spring Valley
1401  Poway Central                Poway
1501  Valley Center Tech Center    Valley Center
1601  Fairbanks Tech USA           Fairbanks Ranch
1701  Blossom Valley Tech          Blossom Valley
1801  Chula Vista Networks
;
RUN;

/********************/
/* CUSTOMERS2 TABLE */
/********************/
DATA CUSTOMERS2;
  INFILE CARDS MISSOVER;
  INPUT @1 CUSTNUM 2.  @5 CUSTNAME $10.  @17 CUSTCITY $20.;
  CARDS;
 1  Smith       San Diego
 7  Lafler      Spring Valley
11  Jones       Carmel
13  Thompson    Miami
 7  Loffler     Spring Valley
 1  Smithe      San Diego
 7  Laughler    Spring Valley
 7  Laffler     Spring Valley
;
RUN;

/*******************/
/* INVENTORY TABLE */
/*******************/
DATA INVENTORY;
  INFILE CARDS MISSOVER;
  INPUT @1 PRODNUM 4.  @8 INVENQTY 2.  @13 ORDDATE MMDDYY10.  @27 INVENCST COMMA10.2  @39 MANUNUM 3.;
  FORMAT INVENCST DOLLAR10.2 ORDDATE MMDDYY10.;
  CARDS;
1110   20   09/01/2000    45,000.00   111
1700   10   08/15/2000    28,000.00   170
5001    5   08/15/2000     1,000.00   500
5002    3   08/15/2000       900.00   500
5003   10   08/15/2000     2,000.00   500
5004   20   09/01/2000     1,400.00   500
5001    2   09/01/2000     1,200.00   600
;
RUN;

/*****************/
/* INVOICE TABLE */
/*****************/
DATA INVOICE;
  INFILE CARDS MISSOVER;
  INPUT @1 INVNUM 4.  @7 MANUNUM 3.  @13 CUSTNUM 4.  @20 INVQTY 2.  @25 INVPRICE COMMA10.2  @37 PRODNUM 4.;
  FORMAT INVPRICE DOLLAR12.2;
  CARDS;
1001  500    201   5      1,495.00  5001
1002  600   1301   2      1,598.00  6001
1003  210    101   7        245.00  2101
1004  111    501   3      9,600.00  1110
1005  500    801   2        798.00  5002
1006  500    901   4        396.00  6000
1007  500    401   7     23,100.00  1200
;
RUN;

/***********************/
/* MANUFACTURERS TABLE */
/***********************/
DATA MANUFACTURERS;
  INFILE CARDS MISSOVER;
  INPUT @1  MANUNUM 3.  @6 MANUNAME $22.  @29 MANUCITY $12.  @41 MANUSTAT $2.;
  CARDS;
111  Cupid Computer         Houston     TX
210  Global Comm Corp       San Diego   CA
600  World Internet Corp    Miami       FL
120  Storage Devices Inc    San Mateo   CA
500  KPL Enterprises        San Diego   CA
700  San Diego PC Planet    San Diego   CA
;
RUN;

/******************/
/* PRODUCTS TABLE */
/******************/
DATA PRODUCTS;
  INFILE CARDS MISSOVER;
  INPUT @1 PRODNUM 4.  @7 PRODNAME $25.  @33 MANUNUM 3.  @38 PRODTYPE $15.  @53 PRODCOST COMMA10.2;
  FORMAT PRODCOST DOLLAR9.2;
  CARDS;
1110  Dream Machine             111  Workstation    3,200.00
1200  Business Machine          120  Workstation    3,300.00
1700  Travel Laptop             170  Laptop         3,400.00
2101  Analog Cell Phone         210  Phone             35.00
2102  Digital Cell Phone        210  Phone            175.00
2200  Office Phone              220  Phone            130.00
5001  Spreadsheet Software      500  Software         299.00
5002  Database Software         500  Software         399.00
5003  Wordprocessor Software    500  Software         299.00
5004  Graphics Software         500  Software         299.00
;
RUN;

/*******************/
/* PURCHASES TABLE */
/*******************/
DATA PURCHASES;
  INFILE CARDS MISSOVER;
  INPUT @1 CUSTNUM 2.  @5 ITEM $10.  @18 UNITS 2.  @21 UNITCOST COMMA12.2;
  FORMAT UNITCOST DOLLAR12.2;
  CARDS;
 1  Chair         1   179.00
 1  Pens         12     0.89
 1  Paper         4     6.95
 1  Stapler       1     8.95
 7  Mouse Pad     1    11.79
 7  Pens         24     1.59
13  Markers       .     0.99
;
RUN;




/**********************************************************/
/* Chapter 2: Working with Data in PROC SQL               */
/**********************************************************/


/* 2.2.1  Code Example: Numeric Data */
PROC SQL;
  CREATE TABLE PURCHASES
    (CUSTNUM  CHAR(4),
     ITEM     CHAR(10)
     UNITS    NUM
     UNITCOST NUM(8,2));
QUIT;


/* 2.2.1  Code Example: Numeric Data */
DATA PURCHASES;
  LENGTH CUSTNUM  $4.
         ITEM    $10.
         UNITS     3.
         UNITCOST  4.;
  LABEL CUSTNUM  = 'Customer Number'
        ITEM     = 'Item Purchased'
        UNITS    = '# Units Purchased'
        UNITCOST = 'Unit Cost';
  FORMAT UNITCOST DOLLAR12.2;
RUN;
PROC CONTENTS DATA=PURCHASES;
RUN;


/* 2.2.5  Code Example: Arithmetic and Missing Data */
PROC SQL;
  SELECT CUSTNUM,
         ITEM,
         UNITS,
         UNITCOST,
         UNITS * UNITCOST AS TOTAL
    FROM PURCHASES
      ORDER BY TOTAL;
QUIT;


/* 2.2.6.1  Code Example: Creating Column Aliases */
PROC SQL;
  SELECT PRODNAME,
         PRODTYPE,
         PRODCOST * 0.80  AS Discount_Price
    FROM PRODUCTS
      ORDER BY 3;
QUIT;


/* 2.2.6.2  Code Example: Finding Duplicate Values */
PROC SQL;
  SELECT DISTINCT MANUNUM
    FROM INVENTORY;
QUIT;


/* 2.2.6.3  Code Example: Finding Unique Values */
PROC SQL;
  SELECT UNIQUE MANUNUM
    FROM INVENTORY;
QUIT;


/* 2.3.1  Code Example: Comparison Operators */
PROC SQL;
  SELECT PRODNAME,
         PRODTYPE,
         PRODCOST
    FROM PRODUCTS
      WHERE PRODCOST > 300;
QUIT;


/* 2.3.2  Code Example: AND Logical Operator */
PROC SQL;
  SELECT PRODNAME,
         PRODTYPE,
         PRODCOST
    FROM PRODUCTS
      WHERE PRODTYPE = 'Software' AND
            PRODCOST > 300;
QUIT;


/* 2.3.2  Code Example: OR Logical Operator */
PROC SQL;
  SELECT PRODNAME,
         PRODTYPE,
         PRODCOST
    FROM PRODUCTS
      WHERE PRODTYPE = 'Software' OR
            PRODCOST > 300;
QUIT;


/* 2.3.2  Code Example: NOT Logical Operator */
PROC SQL;
  SELECT PRODNAME,
         PRODTYPE,
         PRODCOST
    FROM PRODUCTS
      WHERE NOT PRODTYPE = 'Software' AND
            NOT PRODCOST > 300;
QUIT;


/* 2.3.3  Code Example: Arithmetic Operator */
PROC SQL;
  SELECT PRODNAME,
         PRODTYPE,
         PRODCOST * 0.80
    FROM PRODUCTS;
QUIT;


/* 2.3.3  Code Example: CALCULATED Keyword */
PROC SQL;
  SELECT PRODNAME,
         PRODTYPE,
         PRODCOST * 0.80 AS DISCOUNT_PRICE
                  FORMAT=DOLLAR9.2,
         PRODCOST - CALCULATED DISCOUNT_PRICE AS LOSS
                  FORMAT=DOLLAR7.2
    FROM PRODUCTS
      ORDER BY 3;
QUIT;


/* 2.3.4.1  Code Example: Concatenating Strings Together */
PROC SQL;
  SELECT MANUCITY || "," || MANUSTAT
    FROM MANUFACTURERS;
QUIT;


/* 2.3.4.2  Code Example: Finding the Length of a String */
PROC SQL;
  SELECT PRODNUM,
         PRODNAME,
         LENGTH(PRODNAME) AS Length
    FROM PRODUCTS;
QUIT;


/* 2.3.4.3  Code Example: Combining Functions and Operators #1 */
PROC SQL;
  UPDATE PRODUCTS
    SET PRODNAME = SCAN(PRODNAME,1) || TRIM(PRODTYPE);
QUIT;


/* 2.3.4.3  Code Example: Combining Functions and Operators #2 */
PROC SQL;
  UPDATE PRODUCTS
    SET PRODNAME = SCAN(PRODNAME,1) || TRIM(PRODTYPE)
      WHERE PRODTYPE IN ('Phone');
QUIT;


/* 2.3.4.4  Code Example: LEFT Aligning Characters */
PROC SQL;
  SELECT LEFT(TRIM(MANUCITY) || ", " || MANUSTAT)
    FROM MANUFACTURERS;
QUIT;


/* 2.3.4.4  Code Example: RIGHT Aligning Characters */
PROC SQL;
  SELECT RIGHT(MANUCITY)
    FROM MANUFACTURERS;
QUIT;


/* 2.3.4.5  Code Example: Finding the Occurrence of a Pattern with INDEX */
PROC SQL;
  SELECT PRODNUM,
         PRODNAME,
         PRODTYPE
    FROM PRODUCTS
      WHERE INDEX(PRODNAME, 'phone') > 0;
QUIT;


/* 2.3.4.7  Code Example: Changing the Case in a String - UPCASE */
PROC SQL;
  SELECT PRODNUM,
         PRODNAME,
         PRODTYPE
    FROM PRODUCTS
      WHERE INDEX(UPCASE(PRODNAME), 'PHONE') > 0;
QUIT;


/* 2.3.4.7  Code Example: Changing the Case in a String - LOWCASE */
PROC SQL;
  SELECT PRODNUM,
         PRODNAME,
         PRODTYPE
    FROM PRODUCTS
      WHERE INDEX(LOWCASE(PRODNAME), ' phone') > 0;
QUIT;


/* 2.3.4.8  Code Example: Extracting Information from a String */
PROC SQL;
  SELECT PRODNUM,
         PRODNAME,
         PRODTYPE,
         SUBSTR(PRODTYPE,1,4)
    FROM PRODUCTS
      WHERE PRODCOST > 100.00;
QUIT;


/* 2.3.4.9  Code Example: Phonetic Matching #1 */
PROC SQL;
  SELECT CUSTNUM,
         CUSTNAME,
         CUSTCITY
    FROM CUSTOMERS2
      WHERE CUSTNAME =* 'Lafler';
QUIT;


/* 2.3.4.9  Code Example: Phonetic Matching #2 */
PROC SQL;
  SELECT CUSTNUM,
         CUSTNAME,
         CUSTCITY
    FROM CUSTOMERS2
      WHERE CUSTNAME =* 'Lafler'   OR
            CUSTNAME =* 'Laughler' OR
            CUSTNAME =* 'Lasler';
QUIT;


/* 2.3.4.10  Code Example: Finding the First Non-Missing Value */
PROC SQL;
  SELECT CUSTNUM,
         ITEM,
         UNITS,
         UNITCOST,
         (COALESCE(UNITS, 0) * COALESCE(UNITCOST, 0))
               AS Totcost FORMAT=DOLLAR6.2
    FROM PURCHASES;
QUIT;


/* 2.3.4.11  Code Example: Producing a Row Number with the MONOTONIC() Function */
PROC SQL;
  SELECT MONOTONIC() AS Row_Number FORMAT=COMMA6.,
         ITEM,
         UNITS,
         UNITCOST
    FROM PURCHASES;
QUIT;


/* 2.3.4.11  Code Example: Producing a Row Number with the NUMBER Option */
PROC SQL NUMBER;
  SELECT ITEM,
         UNITS,
         UNITCOST
    FROM PURCHASES;
QUIT;


/* 2.3.5  Code Example: Summarizing Data with the COUNT(*) Function */
PROC SQL;
  SELECT COUNT(*) AS Row_Count
    FROM PURCHASES;
QUIT;


/* 2.3.5  Code Example: Summarizing Data with the COUNT Function */
PROC SQL;
  SELECT COUNT(UNITS) AS Non_Missing_Row_Count
    FROM PURCHASES;
QUIT;


/* 2.3.5  Code Example: Summarizing Data with the MIN Function */
PROC SQL;
  SELECT MIN(prodcost) AS Cheapest
            Format=dollar9.2 Label='Least Expensive'
    FROM PRODUCTS;
QUIT;


/* 2.3.5  Code Example: Summarizing Data with the SUM Function */
PROC SQL;
  SELECT SUM((UNITS) * (UNITCOST))
               AS Total_Purchases FORMAT=DOLLAR6.2
    FROM PURCHASES
      WHERE UPCASE(ITEM)='PENS' OR 
            UPCASE(ITEM)='MARKERS';
QUIT;


/* 2.3.5  Code Example: Summarizing Data Down Rows */
PROC SQL;
 SELECT AVG(PRODCOST) AS
      Average_Product_Cost
  FROM PRODUCTS
   WHERE UPCASE(PRODTYPE) IN
         ("SOFTWARE");
QUIT;


/* 2.3.5  Code Example: Summarizing Data Across Columns */
PROC SQL;
 SELECT PRODNUM,
        (INVPRICE / INVQTY) AS
          Averge_Price
            FORMAT=DOLLAR8.2
  FROM INVOICE;
QUIT;


/* 2.3.6.1  Code Example: Selecting a Range of Values #1 */
PROC SQL;
  SELECT PRODNAME,
         PRODTYPE,
         PRODCOST
    FROM PRODUCTS
      WHERE PRODCOST BETWEEN 200 AND 500;
QUIT;


/* 2.3.6.1  Code Example: Selecting a Range of Values #2 */
PROC SQL;
  SELECT PRODNUM,
         INVENQTY,
         ORDDATE
    FROM INVENTORY
      WHERE YEAR(ORDDATE) BETWEEN 1999 AND 2000;
QUIT;


/* 2.3.6.1  Code Example: Selecting a Range of Values #3 */
PROC SQL;
  SELECT PRODNUM,
         INVENQTY,
         ORDDATE
    FROM INVENTORY
      WHERE (YEAR(ORDDATE) BETWEEN 1999 AND 2000) OR
             INVENQTY > 15;
QUIT;


/* 2.3.6.2  Code Example: Selecting Non-consecutive Values #1 */
PROC SQL;
  SELECT PRODNAME,
         PRODTYPE,
         PRODCOST
    FROM PRODUCTS
      WHERE UPCASE(PRODTYPE) = 'PHONE';
QUIT;


/* 2.3.6.2  Code Example: Selecting Non-consecutive Values #2 */
PROC SQL;
  SELECT PRODNAME,
         PRODTYPE,
         PRODCOST
    FROM PRODUCTS
      WHERE UPCASE(PRODTYPE) IN ('PHONE', 'SOFTWARE');
QUIT;


/* 2.3.6.3  Code Example: Testing for NULL or Missing Values #1 */
PROC SQL;
  SELECT PRODNUM,
         INVENQTY,
         INVENCST
    FROM INVENTORY
      WHERE INVENQTY IS NULL;
QUIT;


/* 2.3.6.3  Code Example: Testing for NULL or Missing Values #2 */
PROC SQL;
  SELECT PRODNUM,
         INVENQTY,
         INVENCST
    FROM INVENTORY
      WHERE INVENQTY IS NOT NULL;
QUIT;


/* 2.3.6.3  Code Example: Testing for NULL or Missing Values #3 */
PROC SQL;
  SELECT PRODNUM,
         INVENQTY,
         INVENCST
    FROM INVENTORY
      WHERE INVENQTY IS NOT MISSING;
QUIT;


/* 2.3.6.4  Code Example: Finding Patterns in a String #1 */
PROC SQL;
  SELECT PRODNAME
    FROM PRODUCTS
      WHERE PRODNAME LIKE 'A%';
QUIT;


/* 2.3.6.4  Code Example: Finding Patterns in a String #2 */
PROC SQL;
  SELECT PRODNAME,
         PRODTYPE,
         PRODCOST
    FROM PRODUCTS
      WHERE PRODTYPE LIKE '%Soft%';
QUIT;


/* 2.3.6.4  Code Example: Finding Patterns in a String #3 */
PROC SQL;
  SELECT PRODNAME
    FROM PRODUCTS
      WHERE PRODNAME LIKE  '% ';
QUIT;


/* 2.3.6.4  Code Example: Finding Patterns in a String #4 */
PROC SQL;
   SELECT PRODNAME,
          PRODTYPE,
          PRODCOST
     FROM PRODUCTS
       WHERE UPCASE(PRODTYPE) LIKE 'P_____';
QUIT;


/* 2.3.6.4  Code Example: Finding Patterns in a String #5 */
PROC SQL;
  SELECT PRODNAME
    FROM PRODUCTS
      WHERE PRODNAME LIKE  '___a%';
QUIT;


/* 2.3.6.5  Code Example: Testing for the Existence of a Value */
PROC SQL;
  SELECT CUSTNUM,
         CUSTNAME,
         CUSTCITY
    FROM CUSTOMERS2 C
      WHERE EXISTS 
        (SELECT *
          FROM PURCHASES P
            WHERE C.CUSTNUM = P.CUSTNUM);
QUIT;


/* 2.4.1  Code Example: Displaying Dictionary Table Definitions */
PROC SQL;
  DESCRIBE TABLE
    DICTIONARY.OPTIONS;
QUIT;


/* 2.4.3.1  Code Example: Dictionary.CATALOGS */
PROC SQL;
  SELECT *
    FROM DICTIONARY.CATALOGS
      WHERE LIBNAME="SASUSER";
QUIT;


/* 2.4.3.2  Code Example: Dictionary.COLUMNS */
PROC SQL;
  SELECT *
    FROM DICTIONARY.COLUMNS
      WHERE UPCASE(LIBNAME)="WORK" AND
            UPCASE(NAME)="CUSTNUM";
QUIT;


/* 2.4.3.3  Code Example: Dictionary.EXTFILES */
PROC SQL;
  SELECT *
    FROM DICTIONARY.EXTFILES;
QUIT;


/* 2.4.3.4  Code Example: Dictionary.INDEXES */
PROC SQL;
  SELECT *
    FROM DICTIONARY.INDEXES
      WHERE UPCASE(NAME)="CUSTNUM"      /* Column Name  */
            AND UPCASE(LIBNAME)="WORK"; /* Library Name */
QUIT;


/* 2.4.3.5  Code Example: Dictionary.MACROS */
PROC SQL;
  SELECT *
    FROM DICTIONARY.MACROS
      WHERE UPCASE(SCOPE)="GLOBAL";
QUIT;


/* 2.4.3.6  Code Example: Dictionary.MEMBERS */
PROC SQL;
  SELECT *
    FROM DICTIONARY.MEMBERS
      WHERE UPCASE(LIBNAME)="WORK";
QUIT;


/* 2.4.3.7  Code Example: Dictionary.OPTIONS */
PROC SQL;
  SELECT *
    FROM DICTIONARY.OPTIONS;
QUIT;


/* 2.4.3.8  Code Example: Dictionary.TABLES */
PROC SQL;
  SELECT *
    FROM DICTIONARY.TABLES
      WHERE UPCASE(LIBNAME)="WORK";
QUIT;


/* 2.4.3.9  Code Example: Dictionary.TITLES */
PROC SQL;
  SELECT *
    FROM DICTIONARY.TITLES;
QUIT;


/* 2.4.3.10  Code Example: Dictionary.VIEWS */
PROC SQL;
  SELECT *
    FROM DICTIONARY.VIEWS
      WHERE UPCASE(LIBNAME)="WORK";
QUIT;





/**********************************************************/
/*  Chapter 3: Formatting Output                          */
/**********************************************************/


/* 3.2.1  Code Example: Writing a Blank Line Between Each Row */
PROC SQL DOUBLE;
  SELECT *
    FROM INVOICE;
QUIT;


/* 3.2.1  Code Example: Resetting to Single-spaced Output */
PROC SQL;
  RESET NODOUBLE;
QUIT;


/* 3.2.2  Code Example: Displaying Row Numbers */
PROC SQL NUMBER;
  SELECT ITEM,
         UNITS,
         UNITCOST
    FROM PURCHASES;
QUIT;


/* 3.2.3  Code Example: Concatenating Character Strings #1 */
PROC SQL;
  SELECT manucity || manustat
    FROM  MANUFACTURERS;
QUIT;


/* 3.2.3  Code Example: Concatenating Character Strings #2 */
PROC SQL;
  SELECT TRIM(manucity) || manustat AS Headquarters
    FROM MANUFACTURERS;
QUIT;


/* 3.2.4  Code Example: Inserting Text and Constraints Between Columns #1 */
PROC SQL;
  SELECT trim(manucity) || ', ' || manustat
           As Headquarters
    FROM MANUFACTURERS;
QUIT;


/* 3.2.4  Code Example: Inserting Text and Constraints Between Columns #2 */
PROC SQL;
  SELECT CATX(',', manucity, manustat)
           As Headquarters
    FROM MANUFACTURERS;
QUIT;


/* 3.2.5  Code Example: Using Scalar Expressions with Selected Columns #1 */
PROC SQL;
  SELECT prodname, prodcost,
         .075 * prodcost
    FROM PRODUCTS;
QUIT;


/* 3.2.5  Code Example: Using Scalar Expressions with Selected Columns #2 */
PROC SQL;
  SELECT prodname, prodcost,
         .075 * prodcost AS Sales_Tax
    FROM PRODUCTS
      ORDER BY 3;
QUIT;


/* 3.2.5  Code Example: Using Scalar Expressions with Selected Columns #3 */
PROC SQL;
  SELECT prodname, prodcost,
         .075 * prodcost FORMAT=DOLLAR7.2
                         LABEL='Sales Tax'
    FROM PRODUCTS;
QUIT;


/* 3.2.6  Code Example: Ordering Output by Columns #1 */
PROC SQL;
  SELECT *
    FROM PRODUCTS
      ORDER BY prodnum;
QUIT;


/* 3.2.6  Code Example: Ordering Output by Columns #2 */
PROC SQL;
  SELECT prodname, prodtype, prodcost, prodnum
    FROM PRODUCTS
      ORDER BY prodtype, DESC prodcost;
QUIT;


/* 3.2.7  Code Example: Grouping Data with Summary Functions #1 */
PROC SQL;
  SELECT prodtype,
         prodcost
    FROM PRODUCTS
      GROUP BY prodtype;
QUIT;


/* 3.2.7  Code Example: Grouping Data with Summary Functions #2 */
PROC SQL;
  SELECT prodtype,
         MIN(prodcost) AS Cheapest
            Format=dollar9.2 Label='Least Expensive'
    FROM PRODUCTS
      GROUP BY prodtype;
QUIT;


/* 3.2.8  Code Example: Grouping Data and Sorting */
PROC SQL;
  SELECT prodtype,
         MIN(prodcost) AS Cheapest
            Format=dollar9.2 Label='Least Expensive'
    FROM PRODUCTS
      GROUP BY prodtype
        ORDER BY cheapest;
QUIT;


/* 3.2.9  Code Example: Subsetting Groups with the HAVING Clause */
PROC SQL;
  SELECT prodtype,
         AVG(prodcost)
            FORMAT=DOLLAR9.2 LABEL='Average Product Cost'
    FROM PRODUCTS
      GROUP BY prodtype
        HAVING AVG(prodcost) <= 200.00;
QUIT;


/* 3.3.2  Code Example: Sending Output to a SAS Data Set */
ODS LISTING CLOSE;
ODS OUTPUT SQL_Results = SQL_DATA;
PROC SQL;
  TITLE1 'Delivering Output to a Data Set';
  SELECT prodname, prodtype, prodcost, prodnum
    FROM PRODUCTS
      ORDER BY prodtype;
QUIT;
ODS OUTPUT CLOSE;
ODS LISTING;


/* 3.3.3  Code Example: Converting Output to Rich Text Format */
ODS LISTING CLOSE;
ODS RTF FILE='c:\SQL_Results.rtf';
PROC SQL;
  TITLE1 'Delivering Output to Rich Text Format';
  SELECT prodname, prodtype, prodcost, prodnum
    FROM PRODUCTS
      ORDER BY prodtype;
QUIT;
ODS RTF CLOSE;
ODS LISTING;


/* 3.3.4  Code Example: Delivering Results to the Web */
ODS LISTING CLOSE;
ODS HTML     BODY='c:\Products-body.html'
         CONTENTS='c:\Products-contents.html'
             PAGE='c:\Products-page.html'
            FRAME='c:\Products-frame.html';
PROC SQL;
  TITLE1 'Products List';
  SELECT prodname, prodtype, prodcost, prodnum
    FROM PRODUCTS
      ORDER BY prodtype;
QUIT;
ODS HTML CLOSE;
ODS LISTING;





/**********************************************************/
/* Chapter 4: Coding PROC SQL Logic                       */
/**********************************************************/


/* 4.2  Code Example: Conditional Logic #1 */
PROC SQL;
  SELECT *
    FROM PRODUCTS
      WHERE PRODCOST < 400.00;
QUIT;


/* 4.2  Code Example: Conditional Logic #2 */
PROC SQL;
  SELECT *
    FROM PRODUCTS
      WHERE PRODCOST > 400.00;
QUIT;


/* 4.2  Code Example: Conditional Logic #3 */
PROC SQL;
  SELECT *
    FROM PRODUCTS
      WHERE PRODTYPE = "Software";
QUIT;


/* 4.2  Code Example: Conditional Logic #4 */
PROC SQL;
  SELECT *
    FROM PRODUCTS
      WHERE UPCASE(PRODTYPE) = "SOFTWARE";
QUIT;


/* 4.3  Code Example: CASE Expressions #1 */
PROC SQL;
  SELECT MANUNAME,
         MANUSTAT,
         CASE
           WHEN MANUSTAT = 'CA' THEN 'West'
           WHEN MANUSTAT = 'FL' THEN 'East'
           WHEN MANUSTAT = 'TX' THEN 'Central'
           ELSE 'Unknown'
         END AS Region
    FROM MANUFACTURERS;
QUIT;


/* 4.3  Code Example: CASE Expressions #2 */
PROC SQL;
  SELECT PRODNAME,
         CASE PRODTYPE
           WHEN 'Laptop'      THEN 'Hardware'
           WHEN 'Phone'       THEN 'Hardware'
           WHEN 'Software'    THEN 'Software'
           WHEN 'Workstation' THEN 'Hardware'
           ELSE 'Unknown'
         END AS Product_Classification
    FROM PRODUCTS;
QUIT;


/* 4.3.1  Code Example: Case Logic versus COALESCE Expression #1 */
PROC SQL;
  SELECT CUSTNAME,
         CASE 
           WHEN CUSTCTY IS NOT NULL THEN CUSTCITY
           ELSE 'Unknown'
         END AS Customer_City
    FROM CUSTOMER;
QUIT;


/* 4.3.1  Code Example: Case Logic versus COALESCE Expression #2 */
PROC SQL;
  SELECT CUSTNAME,
         COALESCE(CUSTCTY,'Unknown')
           AS Customer_City
    FROM CUSTOMER;
QUIT;


/* 4.3.1  Code Example: Case Logic versus COALESCE Expression #3 */
PROC SQL;
  SELECT ITEM,
         COALESCE(UNITS, 0)
    FROM PURCHASES;
QUIT;


/* 4.3.2  Code Example: Assigning Labels and Grouping Data #1 */
PROC FORMAT;
  VALUE INVQTY
       0 -   5 = 'Low on Stock - Reorder'
       6 -  10 = 'Stock Levels OK'
      11 -  99 = 'Plenty of Stock'
     100 - 999 = 'Excessive Quantities';
RUN;

PROC SORT DATA=INVENTORY;
  BY INVENQTY;
RUN;

PROC PRINT DATA=INVENTORY(KEEP=PRODNUM INVENQTY) NOOBS;
  FORMAT INVENQTY INVQTY.;
RUN;


/* 4.3.2  Code Example: Assigning Labels and Grouping Data #2 */
PROC SQL;
  SELECT PRODNUM,
         CASE
           WHEN INVENQTY LE 5 
                THEN 'Low on Stock - Reorder'
           WHEN 6 LE INVENQTY LE 10
                THEN 'Stock Levels OK'
           WHEN 11 LE INVENQTY LE 99
                THEN 'Plenty of Stock'
           ELSE 'Excessive Quantities'
         END AS Inventory_Status
    FROM INVENTORY
      ORDER BY INVENQTY;
QUIT;


/* 4.3.3  Code Example: Logic and Nulls #1 */
PROC SQL;
  SELECT MANUNAME,
         MANUSTAT,
         CASE
           WHEN MANUSTAT = 'CA' THEN 'South West'
           WHEN MANUSTAT = 'FL' THEN 'South East'
           WHEN MANUSTAT = 'TX' THEN 'Central'
           WHEN MANUSTAT = ' '  THEN 'Missing'
           ELSE 'Unknown'
         END AS Region
    FROM MANUFACTURERS;
QUIT;


/* 4.3.3  Code Example: Logic and Nulls #2 */
PROC SQL;
  SELECT MANUNAME,
         MANUSTAT,
         CASE
           WHEN MANUSTAT = 'CA' THEN 'South West'
           WHEN MANUSTAT = 'FL' THEN 'South East'
           WHEN MANUSTAT = 'TX' THEN 'Central'
           WHEN MANUSTAT = ' '  THEN 'Missing'
           ELSE 'Unknown'
         END AS Region
    FROM MANUFACTURERS;
QUIT;


/* 4.4.1.1  Code Example: Creating a Macro Variable with %LET #1 */
%LET PRODTYPE=SOFTWARE;
TITLE "Listing of &PRODTYPE Products";
PROC SQL;
  SELECT PRODNAME,
         PRODCOST
    FROM PRODUCTS
      WHERE UPCASE(PRODTYPE) = "&PRODTYPE"
        ORDER BY PRODCOST;
QUIT;


/* 4.4.1.1  Code Example: Creating a Macro Variable with %LET #2 */
%MACRO VIEW(NAME);
%IF %UPCASE(&NAME) ^= %STR(PRODUCTS) AND
    %UPCASE(&NAME) ^= %STR(MANUFACTURERS) AND
    %UPCASE(&NAME) ^= %STR(INVENTORY) %THEN %DO;
  %PUT A valid view name was not supplied and no output
       will be generated!;
%END;
%ELSE %DO;
  PROC SQL;
  TITLE "Listing of &NAME View";
  %IF %UPCASE(&NAME)=%STR(PRODUCTS) %THEN %DO;
    SELECT PRODNAME,
           PRODCOST
      FROM &NAME._view
        ORDER BY PRODCOST;
  %END;
  %ELSE %IF %UPCASE(&NAME)=%STR(MANUFACTURERS) %THEN %DO;
    SELECT MANUNAME,
           MANUCITY,
           MANUSTAT
      FROM &NAME._view
        ORDER BY MANUCITY;
  %END;
  %ELSE %IF %UPCASE(&NAME)=%STR(INVENTORY) %THEN %DO;
    SELECT PRODNUM,
           INVENQTY,
           INVENCST
      FROM &NAME._view
        ORDER BY INVENCST;
  %END;
  QUIT;
  %END;
%MEND VIEW;

%VIEW(Products)



/* 4.4.1.2  Code Example: Creating a Macro Variable from a Table Row Column #1 */
PROC SQL NOPRINT;
  SELECT PRODNAME,
         PRODCOST
    INTO :PRODNAME,
         :PRODCOST
      FROM PRODUCTS;
QUIT;
%PUT &PRODNAME &PRODCOST;


/* 4.4.1.2  Code Example: Creating a Macro Variable from a Table Row Column #2 */
PROC SQL NOPRINT;
  SELECT PRODNAME,
         PRODCOST
    INTO :PRODNAME,
         :PRODCOST
      FROM PRODUCTS
        WHERE UPCASE(PRODTYPE) IN ('SOFTWARE');
QUIT;
%PUT &PRODNAME &PRODCOST;


/* 4.4.1.3  Code Example: Creating a Macro Variable with Aggregate Functions */
PROC SQL NOPRINT;
  SELECT MIN(PRODCOST) FORMAT=DOLLAR10.2
    INTO :MIN_PRODCOST
      FROM PRODUCTS;
QUIT;
%PUT &MIN_PRODCOST;


/* 4.4.1.4  Code Example: Creating Multiple Macro Variables */
PROC SQL NOPRINT;
  SELECT PRODNAME,
         PRODCOST
    INTO :PRODUCT1 - :PRODUCT3,
         :COST1 - :COST3
      FROM PRODUCTS
        ORDER BY PRODCOST;
QUIT;
%PUT &PRODUCT1 &COST1;
%PUT &PRODUCT2 &COST2;
%PUT &PRODUCT3 &COST3;


/* 4.4.1.5  Code Example: Creating a List of Values in a Macro Variable #1 */
PROC SQL NOPRINT;
  SELECT MANUNAME
    INTO :MANUNAME SEPARATED BY '  '
      FROM MANUFACTURERS
        WHERE UPCASE(MANUCITY)='SAN DIEGO';
QUIT;
%PUT &MANUNAME;


/* 4.4.1.5  Code Example: Creating a List of Values in a Macro Variable #2 */
PROC SQL NOPRINT;
  SELECT MANUNAME
    INTO :MANUNAME SEPARATED BY ', '
      FROM MANUFACTURERS
        WHERE UPCASE(MANUCITY)='SAN DIEGO';
QUIT;
%PUT &MANUNAME;


/* 4.4.1.6  Code Example: Using Automatic Macro Variables to Control Processing */
%PUT _AUTOMATIC_;


/* 4.4.2.2  Code Example: Cross-Referencing Columns          */
/* NOTE: This example has been Corrected with Double-quotes! */
%MACRO COLUMNS(LIB, COLNAME);
  PROC SQL;
    SELECT LIBNAME, MEMNAME, NAME, TYPE, LENGTH
      FROM DICTIONARY.COLUMNS
        WHERE LIBNAME="&LIB" AND
              UPCASE(NAME)="&COLNAME" AND
              MEMTYPE="DATA";
  QUIT;
%MEND COLUMNS;

%COLUMNS(WORK,CUSTNUM);



/* 4.4.2.3  Code Example: Determining the Number of Rows in a Table */
%MACRO NOBS(LIB, TABLE);
  PROC SQL;
    SELECT LIBNAME, MEMNAME, NOBS
      FROM DICTIONARY.TABLES
        WHERE UPCASE(LIBNAME)="&LIB" AND
              UPCASE(MEMNAME)="&TABLE" AND
              UPCASE(MEMTYPE)="DATA";
  QUIT;
%MEND NOBS;

%NOBS(WORK,PRODUCTS);



/* 4.4.2.4  Code Example: Identifying Duplicate Rows in a Table */
%MACRO DUPS(LIB, TABLE, GROUPBY);
  PROC SQL;
    SELECT &GROUPBY, COUNT(*) AS Duplicate_Rows
      FROM &LIB..&TABLE
        GROUP BY &GROUPBY
          HAVING COUNT(*) > 1;
  QUIT;
%MEND DUPS;

%DUPS(WORK,PRODUCTS,PRODTYPE);





/**********************************************************/
/* Chapter 5: Creating, Populating, and Deleting Tables   */
/**********************************************************/


/* 5.2.1  Code Example: Creating a Table Using Column-Definition Lists #1 */
PROC SQL;
  CREATE TABLE CUSTOMERS
    (CUSTNUM   NUM      LABEL='Customer Number',
     CUSTNAME  CHAR(25) LABEL='Customer Name',
     CUSTCITY  CHAR(20) LABEL='Customer''s Home City');
QUIT;


/* 5.2.1  Code Example: Creating a Table Using Column-Definition Lists #2 */
DATA CUSTOMERS;
  LENGTH CUSTNUM 3.;
  SET CUSTOMERS(DROP=CUSTNUM);
  LABEL CUSTNUM = 'Customer Number';
RUN;


/* 5.2.1  Code Example: Creating a Table Using Column-Definition Lists #3 */
PROC SQL;
  CREATE TABLE PRODUCTS
    (PRODNUM   NUM(3)   LABEL='Product Number',
     PRODNAME  CHAR(25) LABEL='Product Name',
     MANUNUM   NUM(3)   LABEL='Manufacturer Number',
     PRODTYPE  CHAR(15) LABEL='Product Type',
     PRODCOST  NUM(5,2) FORMAT=DOLLAR9.2 LABEL='Product Cost');
QUIT;


/* 5.2.1  Code Example: Creating a Table Using Column-Definition Lists #4 */
DATA PRODUCTS;
  LENGTH PRODNUM MANUNUM 3.
         PRODCOST 5.;
  SET PRODUCTS(DROP=PRODNUM MANUNUM PRODCOST);
  LABEL PRODNUM  = 'Product Number'
        MANUNUM  = 'Manufacturer Number'
        PRODCOST = 'Product Cost';
  FORMAT PRODCOST DOLLAR9.2;
RUN;


/* 5.2.2  Code Example: Creating a Table Using the LIKE Clause #1 */
PROC SQL;
  CREATE TABLE HOT_PRODUCTS
    LIKE PRODUCTS;
QUIT;


/* 5.2.2  Code Example: Creating a Table Using the LIKE Clause #2 */
PROC SQL;
  CREATE TABLE HOT_PRODUCTS(KEEP=PRODNAME PRODTYPE PRODCOST)
    LIKE PRODUCTS;
QUIT;


/* 5.2.3  Code Example: Deriving a Table and Data from an Existing Table #1 */
PROC SQL;
  CREATE TABLE HOT_PRODUCTS AS
    SELECT *
      FROM PRODUCTS;
QUIT;


/* 5.2.3  Code Example: Deriving a Table and Data from an Existing Table #2 */
PROC SQL;
  CREATE TABLE HOT_PRODUCTS AS
    SELECT *
      FROM PRODUCTS
        WHERE UPCASE(PRODTYPE) IN ("SOFTWARE", "PHONE");
QUIT;


/* 5.2.3  Code Example: Deriving a Table and Data from an Existing Table #3 */
PROC SQL;
  CREATE TABLE NOT_SO_HOT_PRODUCTS AS
    SELECT *
      FROM PRODUCTS
        WHERE UPCASE(PRODTYPE) NOT IN ("SOFTWARE", "PHONE");
QUIT;


/* 5.3.1  Code Example: Adding Data to All the Columns in a Row #1 */
PROC SQL;
  INSERT INTO CUSTOMERS (CUSTNUM, CUSTNAME, CUSTCITY)
     VALUES (702, 'Mission Valley Computing', 'San Diego');
QUIT;


/* 5.3.1  Code Example: Adding Data to All the Columns in a Row #2 */
PROC SQL;
  INSERT INTO CUSTOMERS
            (CUSTNUM, CUSTNAME, CUSTCITY)
    VALUES (402, 'La Jolla Tech Center', 'La Jolla')
    VALUES (502, 'Alpine Byte Center',   'Alpine')
    VALUES (1702,'Rancho San Diego Tech','Rancho San Diego');

  SELECT *
    FROM CUSTOMERS
      ORDER BY CUSTNUM;
QUIT;


/* 5.3.2  Code Example: Adding Data to Some of the Columns in a Row #1 */
PROC SQL;
  INSERT INTO CUSTOMERS
            (CUSTNUM, CUSTNAME)
     VALUES (102, 'La Mesa Byte & Floppy')
     VALUES (902, 'Del Mar Technology Center');

  SELECT *
    FROM CUSTOMERS
      ORDER BY CUSTNUM;
QUIT;


/* 5.3.2  Code Example: Adding Data to Some of the Columns in a Row #2 */
PROC SQL;
  INSERT INTO PRODUCTS
            (PRODNUM, PRODNAME, PRODTYPE, PRODCOST)
   VALUES(6002,'Security Software','Software',375.00)
   VALUES(1701,'Travel Laptop SE', 'Laptop',  4200.00);

  SELECT *
    FROM PRODUCTS
      ORDER BY PRODNUM;
QUIT;


/* 5.3.3  Code Example: Adding Data with a SELECT Query */
PROC SQL;
  INSERT INTO PRODUCTS
            (PRODNUM, PRODNAME, PRODTYPE, PRODCOST)

  SELECT PRODNUM, PRODNAME, PRODTYPE, PRODCOST
    FROM SOFTWARE_PRODUCTS
      WHERE PRODTYPE IN ('Software');
QUIT;


/* 5.4.3  Code Example: Preventing Null Values with a NOT NULL Constraint #1 */
PROC SQL;
  CREATE TABLE CUSTOMER_CITY
     (CUSTNUM NUM,
      CUSTCITY CHAR(20) NOT NULL);
QUIT;


/* 5.4.3  Code Example: Preventing Null Values with a NOT NULL Constraint #2 */
PROC SQL;
  INSERT INTO CUSTOMER_CITY
    VALUES(101,'La Mesa Computer Land')
    VALUES(1301,'Spring Valley Byte Center');
QUIT;


/* 5.4.3  Code Example: Preventing Null Values with a NOT NULL Constraint #3 */
PROC SQL;
  INSERT INTO CUSTOMER_CITY
    VALUES(101,'La Mesa Computer Land')
    VALUES(1301,'Spring Valley Byte Center')
    VALUES(1801,'');
QUIT;


/* 5.4.3  Code Example: Preventing Null Values with a NOT NULL Constraint #4 */
PROC SQL;
  ALTER TABLE CUSTOMERS
    ADD CONSTRAINT NOT_NULL_CUSTCITY NOT NULL(CUSTCITY);
QUIT;


/* 5.4.4  Code Example: Enforcing Unique Values with a UNIQUE Constraint #1 */
PROC SQL;
  CREATE TABLE CUSTOMER_CITY
     (CUSTNUM NUM UNIQUE,
      CUSTCITY CHAR(20));
QUIT;


/* 5.4.4  Code Example: Enforcing Unique Values with a UNIQUE Constraint #2 */
PROC SQL;
  INSERT INTO CUSTOMER_CITY
    VALUES(101,'La Mesa Computer Land')
    VALUES(1301,'Spring Valley Byte Center')
    VALUES(1301,'Chula Vista Networks');
QUIT;


/* 5.4.5  Code Example: Validating Column Values with a CHECK Constraint #1 */
PROC SQL;
  ALTER TABLE PRODUCTS
    ADD CONSTRAINT CHECK_PRODUCT_TYPE
      CHECK (PRODTYPE IN ('Laptop',
                          'Phone',
                          'Software',
                          'Workstation'));
QUIT;


/* 5.4.5  Code Example: Validating Column Values with a CHECK Constraint #2 */
PROC SQL;
  INSERT INTO PRODUCTS
    VALUES(5005,'Internet Software',500,'Software',99.)
    VALUES(1701,'Elite Laptop',170,'Laptop',3900.)
    VALUES(2103,'Digital Cell Phone',210,'Fone',199.);
QUIT;


/* 5.4.7  Code Example: Establishing a Primary Key #1 */
PROC SQL;
  ALTER TABLE MANUFACTURERS
    ADD CONSTRAINT PRIM_KEY PRIMARY KEY (MANUNUM);
QUIT;


/* 5.4.7  Code Example: Establishing a Primary Key #2 */
PROC SQL;
  ALTER TABLE PRODUCTS
    ADD CONSTRAINT PRIM_PRODUCT_KEY PRIMARY KEY (PRODNUM);
QUIT;


/* 5.4.8  Code Example: Establishing a Foreign Key #1 */
PROC SQL; 
 ALTER TABLE INVENTORY
  ADD CONSTRAINT FOREIGN_PRODUCT_KEY FOREIGN KEY (PRODNUM)  
   REFERENCES PRODUCTS
    ON DELETE RESTRICT
    ON UPDATE RESTRICT; 
QUIT;


/* 5.4.8  Code Example: Establishing a Foreign Key #2 */
PROC SQL; 
 ALTER TABLE INVENTORY
  ADD CONSTRAINT FOREIGN_MISSING_PRODUCT_KEY FOREIGN KEY (PRODNUM)  
   REFERENCES PRODUCTS
    ON DELETE SET NULL;
QUIT;


/* 5.4.8  Code Example: Establishing a Foreign Key #3 */
PROC SQL; 
 ALTER TABLE INVENTORY
  ADD CONSTRAINT FOREIGN_PRODUCT_KEY FOREIGN KEY (PRODNUM)  
   REFERENCES PRODUCTS
    ON UPDATE CASCADE
    ON DELETE RESTRICT  /* DEFAULT VALUE */; 
QUIT;


/* 5.4.9  Code Example: Displaying Integrity Constraints */
PROC SQL;
  DESCRIBE TABLE MANUFACTURERS;
QUIT;


/* 5.5.1  Code Example: Deleting a Single Row in a Table */
PROC SQL;
  DELETE FROM CUSTOMERS
    WHERE UPCASE(CUSTNAME) = "LAUGHLER";
QUIT;


/* 5.5.2  Code Example: Deleting More Than One Row in a Table */
PROC SQL;
  DELETE FROM PRODUCTS
    WHERE UPCASE(PRODTYPE) = 'PHONE';
QUIT;


/* 5.5.3  Code Example: Deleting All Rows in a Table */
PROC SQL;
  DELETE FROM CUSTOMERS;
QUIT;


/* 5.6.1  Code Example: Deleting a Single Table */
PROC SQL;
  DROP TABLE HOT_PRODUCTS;
QUIT;


/* 5.6.2  Code Example: Deleting Multiple Tables */
PROC SQL;
  DROP TABLE HOT_PRODUCTS, NOT_SO_HOT_PRODUCTS;
QUIT;


/* 5.6.3  Code Example: Deleting Tables Containing Integrity Constraints #1 */
/* NOTE: This Code Intentionally Produces an ERROR!                         */
PROC SQL;
  DROP TABLE INVENTORY;
QUIT;


/* 5.6.3  Code Example: Deleting Tables Containing Integrity Constraints #2 */
PROC SQL;
  ALTER TABLE INVENTORY
    DROP CONSTRAINT FOREIGN_PRODUCT_KEY;
QUIT;

PROC SQL;
  DROP TABLE INVENTORY;
QUIT;






/**********************************************************/
/* Chapter 6: Modifying and Updating Tables and Indexes   */
/**********************************************************/


/* 6.2.1  Code Example: Adding New Columns */
PROC SQL;
  ALTER TABLE INVENTORY
    ADD inventory_status char(12);
QUIT;


/* 6.2.2  Code Example: Controlling the Position of Columns in a Table #1 */
PROC SQL;
  ALTER TABLE INVENTORY
    ADD INVENTORY_STATUS CHAR(12);
  CREATE TABLE INVENTORY_COPY AS
    SELECT PRODNUM, INVENQTY, ORDDATE, INVENTORY_STATUS,
           INVENCST, MANUNUM
      FROM INVENTORY;
QUIT;
PROC CONTENTS DATA=INVENTORY_COPY;
RUN;


/* 6.2.2  Code Example: Controlling the Position of Columns in a Table #2 */
PROC SQL;
  CREATE VIEW INVENTORY_VIEW AS
    SELECT PRODNUM, INVENQTY, INVENTORY_STATUS
      FROM INVENTORY;
QUIT;


/* 6.2.3  Code Example: Changing a Column's Length #1 */
PROC SQL;
  ALTER TABLE MANUFACTURERS
    MODIFY MANUCITY CHAR(15);
QUIT;


/* 6.2.3  Code Example: Changing a Column's Length #2 */
PROC SQL;
  CREATE TABLE MANUFACTURERS_MODIFIED
    SELECT MANUNUM, MANUNAME, MANUCITY LENGTH=15, MANUSTAT
      FROM MANUFACTURERS;
QUIT;


/* 6.2.3  Code Example: Changing a Column's Length #3 */
PROC SQL;
  CREATE TABLE MANUFACTURERS_MODIFIED AS
    SELECT MANUNUM LENGTH=4, MANUNAME, MANUCITY, MANUSTAT
      FROM MANUFACTURERS;
QUIT;


/* 6.2.3  Code Example: Changing a Column's Length #4 */
DATA MANUFACTURERS;
  LENGTH MANUNUM 4.;
  SET MANUFACTURERS
RUN;


/* 6.2.4  Code Example: Changing a Column's Format */
PROC SQL;
  ALTER TABLE PRODUCTS
    MODIFY PRODCOST FORMAT=DOLLAR12.2;
QUIT;


/* 6.2.5  Code Example: Changing a Column's Label */
PROC SQL;
  ALTER TABLE PRODUCTS
    MODIFY PRODCOST LABEL="Retail Product Cost";
QUIT;


/* 6.2.6  Code Example: Renaming a Column #1 */
PROC SQL;
  CREATE TABLE PURCHASES AS
    SELECT CUSTNUM, ITEM AS ITEM_PURCHASED, UNITS, UNITCOST
      FROM PURCHASES;
QUIT;


/* 6.2.6  Code Example: Renaming a Column #2 */
PROC SQL;
  SELECT *
    FROM PURCHASES (RENAME=ITEM=ITEM_PURCHASED);
QUIT;

/*  < or >  */

PROC SQL;
  SELECT *
    FROM PURCHASES (RENAME=(ITEM=ITEM_PURCHASED));
QUIT;


/* 6.2.7  Code Example: Renaming a Table #1 */
PROC DATASETS LIBRARY=SQL;
  CHANGE PRODUCTS = MANUFACTURED_PRODUCTS;
RUN;


/* 6.2.7  Code Example: Renaming a Table #2 */
PROC SQL;
  CREATE TABLE MANUFACTURED_PRODUCTS AS
    SELECT *
      FROM PRODUCTS;
  DROP TABLE PRODUCTS;
QUIT;


/* 6.3.2  Code Example: Creating a Simple Index */
PROC SQL;
  CREATE INDEX PRODTYPE ON PRODUCTS(PRODTYPE);
QUIT;


/* 6.3.3  Code Example: Creating a Composite Index */
PROC SQL;
  CREATE INDEX
         MANUNUM_PRODTYPE ON PRODUCTS(MANUNUM,PRODTYPE);
QUIT;


/* 6.3.6  Code Example: Deleting (Dropping) Indexes #1 */
PROC SQL;
  DROP INDEX MANUNUM_PRODTYPE
    FROM PRODUCTS;
QUIT;


/* 6.3.6  Code Example: Deleting (Dropping) Indexes #2 */
PROC SQL;
  DROP INDEX MANUNUM, PRODTYPE
    FROM PRODUCTS;
QUIT;


/* 6.4  Code Example: Updating Data in a Table */
PROC SQL;
  UPDATE PRODUCTS
    SET PRODCOST = PRODCOST - (PRODCOST * 0.2)
      WHERE UPCASE(PRODTYPE) = 'LAPTOP';

  SELECT *
    FROM PRODUCTS;
QUIT;






/**********************************************************/
/* Chapter 7: Coding Complex Queries                      */
/**********************************************************/


/* 7.4  Code Example: Cartesian Product Joins */
PROC SQL;
  SELECT prodname, prodcost,
         manufacturers.manunum, manuname
    FROM PRODUCTS, MANUFACTURERS;
QUIT;


/* 7.5.1  Code Example: Equijoins #1 */
PROC SQL;
  SELECT prodname, prodcost,
         manufacturers.manunum, manuname
           FROM PRODUCTS, MANUFACTURERS
      WHERE products.manunum =
            manufacturers.manunum;
QUIT;


/* 7.5.1  Code Example: Equijoins #2 */
PROC SQL;
  SELECT prodname, prodcost,
         manufacturers.manunum, manuname
    FROM PRODUCTS, MANUFACTURERS
      WHERE products.manunum =
            manufacturers.manunum    AND
            products.manunum = 500;
QUIT;


/* 7.5.1  Code Example: Equijoins #3 */
PROC SQL;
  SELECT DISTINCT SUM(prodcost) AS Total_Cost
                  FORMAT=DOLLAR10.2,
         manufacturers.manunum
    FROM PRODUCTS, MANUFACTURERS
      WHERE products.manunum =
            manufacturers.manunum AND
            manufacturers.manuname = 'KPL Enterprises';
QUIT;


/* 7.5.2  Code Example: Non-Equijoins */
PROC SQL;
  SELECT prodname, prodtype, prodcost,
         manufacturers.manunum, manufacturers.manuname
    FROM PRODUCTS, MANUFACTURERS
      WHERE manufacturers.manunum = 500 AND
            prodtype = 'Software' AND
            prodcost > 299.00;
QUIT;


/* 7.5.3  Code Example: Reflexive or Self Joins #1 */
PROC SQL;
  SELECT products.prodname, products.prodtype,
            products.prodcost,
         products_copy.prodnum, products_copy.prodtype,
            products_copy.prodcost
    FROM PRODUCTS, PRODUCTS PRODUCTS_COPY
      WHERE products.prodtype =
               products_copy.prodtype AND
            products.prodcost <
               products_copy.prodcost;
QUIT;


/* 7.5.3  Code Example: Reflexive or Self Joins #2 */
PROC SQL;
  SELECT invoice.custnum, invoice.invprice,
         invoice_copy.custnum, invoice_copy.invprice
    FROM INVOICE, INVOICE INVOICE_COPY
      WHERE invoice.invprice <
               invoice_copy.invprice;
QUIT;


/* 7.5.4  Code Example: Using Table Aliases in Joins */
PROC SQL;
  SELECT prodnum, prodname, prodtype, M.manunum
    FROM PRODUCTS  P, MANUFACTURERS  M
      WHERE P.manunum  = M.manunum AND
            M.manuname = 'Global Software';
QUIT;


/* 7.5.5  Code Example: Performing Computations in Joins */
PROC SQL;
  SELECT prodname, prodtype, prodcost,
         prodcost * .0775 AS SalesTax
         FORMAT=dollar10.2  LABEL='California Sales Tax'
    FROM PRODUCTS  P, MANUFACTURERS  M
      WHERE P.manunum = M.manunum AND
            M.manustat = 'CA';
QUIT;


/* 7.5.6  Code Example: Joins with Three Tables #1 */
PROC SQL;
  SELECT P.prodname,
         P.prodcost,
         M.manuname,
         I.invqty
    FROM PRODUCTS  P,
         MANUFACTURERS  M,
         INVOICE  I
      WHERE P.manunum = M.manunum AND
            P.prodnum = I.prodnum AND
            M.manunum = 500;
QUIT;


/* 7.5.6  Code Example: Joins with Three Tables #2 */
PROC SQL;
  SELECT P.prodname,
         P.prodcost,
         C.custname,
         I.invprice
    FROM PRODUCTS  P,
         INVOICE   I,
         CUSTOMERS C
      WHERE P.prodnum = I.prodnum AND
            I.custnum = C.custnum;
QUIT;


/* 7.5.7  Code Example: Joins with More Than Three Tables #1 */
PROC SQL;
  SELECT sum(inventory.invenqty)
           AS Products_Ordered_Before_09012000
    FROM PRODUCTS,
         INVOICE,
         CUSTOMERS,
         INVENTORY
      WHERE inventory.orddate < mdy(09,01,00) AND
            products.prodnum  = invoice.prodnum AND
            invoice.custnum   = customers.custnum AND
            invoice.prodnum   = inventory.prodnum;
QUIT;


/* 7.5.7  Code Example: Joins with More Than Three Tables #2 */
PROC SQL;
  SELECT sum(inventory.invenqty)
           AS Products_Ordered_Before_09012000
    FROM INVOICE   I,
         INVENTORY I2
      WHERE inventory.orddate < mdy(09,01,00) AND
            invoice.prodnum   = inventory.prodnum;
QUIT;


/* 7.5.7  Code Example: Joins with More Than Three Tables #3 */
PROC SQL;
  SELECT products.prodname,
         products.prodtype,
         customers.custname,
         manufacturers.manuname
    FROM MANUFACTURERS,
         PRODUCTS,
         INVOICE,
         CUSTOMERS
      WHERE manufacturers.manunum = products.manunum  AND
            manufacturers.manunum = invoice.manunum   AND
            products.prodnum      = invoice.prodnum   AND
            invoice.custnum       = customers.custnum;
QUIT;


/* 7.6.1  Code Example: Left Outer Joins */
PROC SQL;
  SELECT manuname, manucity, manufacturers.manunum,
         products.prodtype, products.prodcost
    FROM MANUFACTURERS LEFT JOIN PRODUCTS
       ON manufacturers.manunum =
          products.manunum;
QUIT;


/* 7.6.1.1  Code Example: Specifying a WHERE Clause */
PROC SQL;
  SELECT manuname, manucity, manufacturers.manunum,
         products.prodtype, products.prodcost
    FROM MANUFACTURERS LEFT JOIN PRODUCTS
      ON manufacturers.manunum = 
         products.manunum
        WHERE prodcost < 300 AND
              prodcost NE .;
QUIT;


/* 7.6.1.2  Code Example: Specifying Aggregate Functions */
PROC SQL;
  SELECT manuname,
         SUM(invoice.invprice) AS Total_Invoice_Amt
             FORMAT=DOLLAR10.2
    FROM MANUFACTURERS LEFT JOIN INVOICE
      ON manufacturers.manunum =
         invoice.manunum
        GROUP BY MANUNAME;
QUIT;


/* 7.6.2  Code Example: Right Outer Joins */
PROC SQL;
  SELECT prodname, prodtype,
         products.manunum, manuname
    FROM PRODUCTS RIGHT JOIN MANUFACTURERS
       ON products.manunum =
          manufacturers.manunum;
QUIT;


/* 7.6.3  Code Example: Full Outer Joins */
PROC SQL;
  SELECT prodname, prodtype,
         products.manunum, manuname
    FROM PRODUCTS FULL JOIN MANUFACTURERS
       ON products.manunum =
          manufacturers.manunum;
QUIT;


/* 7.7.1  Code Example: Alternate Approaches to Subqueries #1 */
PROC SQL;
  SELECT *
    FROM INVOICE
      WHERE manunum = 210;
QUIT;


/* 7.7.1  Code Example: Alternate Approaches to Subqueries #2 */
PROC SQL;
  SELECT M.manunum, I.manuname, I.invnum,
         I.invqty, I.invprice
    FROM MANUFACTURERS M, INVOICE I
      WHERE M.manunum = I.manunum AND
            M.manuname = 'Global Comm Corp';
QUIT;


/* 7.7.2  Code Example: Passing a Single Value with a Subquery #1 */
PROC SQL;
  SELECT *
    FROM INVOICE
      WHERE manunum =
        (SELECT manunum
          FROM MANUFACTURERS
            WHERE manuname = 'Global Comm Corp');
QUIT;


/* 7.7.2  Code Example: Passing a Single Value with a Subquery #2 */
PROC SQL;
  SELECT *
    FROM INVOICE
      WHERE prodnum =
        (SELECT prodnum
          FROM PRODUCTS
            WHERE prodname LIKE 'Dream%');
QUIT;


/* 7.7.2  Code Example: Passing a Single Value with a Subquery #3 */
PROC SQL;
  SELECT *
    FROM INVOICE
      WHERE manunum =
        (SELECT manunum
          FROM MANUFACTURERS
            WHERE UPCASE(manucity) LIKE 'SAN DIEGO%');
QUIT;


/* 7.7.2  Code Example: Passing a Single Value with a Subquery #4 */
PROC SQL;
  SELECT prodnum, invnum, invqty, invprice
    FROM INVOICE
      WHERE invqty <
        (SELECT AVG(invqty)
          FROM INVOICE);
QUIT;


/* 7.7.3  Code Example: Passing More Than One Row with a Subquery */
PROC SQL;
  SELECT *
    FROM INVOICE
      WHERE manunum IN
        (SELECT manunum
          FROM MANUFACTURERS
            WHERE UPCASE(manucity) LIKE 'SAN DIEGO%');
QUIT;


/* 7.7.4  Code Example: Comparing a Set of Values #1 */
PROC SQL;
  SELECT manunum, prodnum, invqty, invprice
    FROM INVOICE
      WHERE invprice GE ANY
        (SELECT invprice
          FROM INVOICE
            WHERE prodnum IN (5001,5002));
QUIT;


/* 7.7.4  Code Example: Comparing a Set of Values #2 */
PROC SQL;
  SELECT manunum, prodnum, invqty, invprice
    FROM INVOICE
      WHERE invprice < ALL
        (SELECT invprice
          FROM INVOICE
            WHERE prodnum IN (5001,5002));
QUIT;


/* 7.7.5  Code Example: Correlated Subqueries #1 */
PROC SQL;
  SELECT prodnum, prodname, prodtype
    FROM PRODUCTS
      WHERE NOT EXISTS
        (SELECT *
          FROM INVOICE
            WHERE PRODUCTS.prodnum = INVOICE.prodnum);
QUIT;


/* 7.7.5  Code Example: Correlated Subqueries #2 */
PROC SQL;
  SELECT prodnum, prodname, prodtype
    FROM PRODUCTS
      WHERE EXISTS
        (SELECT *
          FROM INVOICE
            WHERE PRODUCTS.manunum = INVOICE.manunum
              HAVING COUNT(*) > 1);
QUIT;


/* 7.8.1  Code Example: Accessing Rows from the Intersection of Two Queries #1 */
PROC SQL;
  SELECT *
    FROM PRODUCTS
      WHERE prodcost < 300.00 AND
            prodtype = 'Phone';
QUIT;


/* 7.8.1  Code Example: Accessing Rows from the Intersection of Two Queries #2 */
PROC SQL;
  SELECT *
    FROM PRODUCTS
      WHERE prodcost < 300.00

  INTERSECT

  SELECT *
    FROM PRODUCTS
      WHERE prodtype = "Phone";
QUIT;


/* 7.8.2  Code Example: Accessing Rows from the Combination of Two Queries #1 */
PROC SQL;
  SELECT *
    FROM PRODUCTS
      WHERE prodcost < 300.00 OR
            prodtype = "Workstation";
QUIT;


/* 7.8.2  Code Example: Accessing Rows from the Combination of Two Queries #2 */
PROC SQL;
  SELECT *
    FROM PRODUCTS
      WHERE prodcost < 300.00

  UNION

  SELECT *
    FROM PRODUCTS
      WHERE prodtype = 'Workstation';
QUIT;


/* 7.8.3  Code Example: Concatenating Rows from Two Queries #1 */
PROC SQL;
  SELECT prodnum, prodname, prodtype, prodcost
    FROM PRODUCTS

  OUTER UNION

  SELECT prodnum, prodname, prodtype, prodcost
    FROM PRODUCTS;
QUIT;


/* 7.8.3  Code Example: Concatenating Rows from Two Queries #2 */
PROC SQL;
  SELECT prodnum, prodname, prodtype, prodcost
    FROM PRODUCTS

  OUTER UNION CORR

  SELECT prodnum, prodname, prodtype, prodcost
    FROM PRODUCTS;
QUIT;


/* 7.8.4  Code Example: Comparing Rows from Two Queries */
PROC SQL;
  SELECT *
    FROM CUSTOMERS

  EXCEPT

  SELECT *
    FROM CUSTOMERS_BACKUP;
QUIT;






/**********************************************************/
/* Chapter 8: Working with Views                          */
/**********************************************************/


/* 8.2.3  Code Example: Creating Views #1 */
PROC SQL;
  CREATE VIEW MANUFACTURERS_VIEW AS
    SELECT manuname, manunum, manucity, manustat
      FROM MANUFACTURERS;
QUIT;


/* 8.2.3  Code Example: Creating Views #2 */
PROC SQL;
  CREATE VIEW INVENTORY_VIEW AS
    SELECT prodnum, invenqty, invencst,
           invencst/invenqty AS AverageAmount
      FROM INVENTORY;
QUIT;


/* 8.2.4  Code Example: Displaying a View's Contents */
PROC CONTENTS DATA=INVENTORY_VIEW;
RUN;


/* 8.2.5  Code Example: Describing View Definitions */
PROC SQL;
   DESCRIBE VIEW INVENTORY_VIEW;
QUIT;


/* 8.2.6  Code Example: Creating and Using Views in the SAS System */
/* NOTE: This code Intentionally Produces an Error!                */
PROC SQL;
  CREATE VIEW NO_CAN_DO_VIEW AS
    SELECT *
      FROM NO_CAN_DO_VIEW;

  SELECT *
    FROM NO_CAN_DO_VIEW;
QUIT;


/* 8.2.7  Code Example: Views and SAS Procedures #1 */
PROC MEANS DATA=INVENTORY_VIEW;
  TITLE1 'Inventory Statistical Report';
  TITLE2 'Demonstration of a View used in PROC MEANS';
RUN;


/* 8.2.7  Code Example: Views and SAS Procedures #2 */
PROC PRINT DATA=INVENTORY_VIEW N NOOBS UNIFORM;
  TITLE1 'Inventory Detail Listing';
  TITLE2 'Demonstration of a View used in PROC PRINT';
  FORMAT AverageAmount dollar10.2;
RUN;


/* 8.2.8  Code Example: Views and DATA Steps */
DATA _NULL_;
  SET INVENTORY_VIEW (KEEP=PRODNUM AVERAGEAMOUNT);
  FILE PRINT HEADER=H1;
  PUT @10 PRODNUM
      @30 AVERAGEAMOUNT DOLLAR10.2;
RETURN;
H1: PUT @9 'Using a View in a DATA Step'
    /// @5 'Product Number'
       @26 'Average Amount';
RETURN;
RUN;


/* 8.4  Code Example: Restricting Data Access - Security #1 */
PROC SQL;
  CREATE VIEW SOFTWARE_PRODUCTS_VIEW AS
    SELECT prodnum, prodname, manunum, prodtype
      FROM PRODUCTS
        WHERE UPCASE(PRODTYPE) IN ('SOFTWARE');
QUIT;


/* 8.4  Code Example: Restricting Data Access - Security #2 */
PROC SQL;
  SELECT *
    FROM SOFTWARE_PRODUCTS_VIEW
      ORDER BY prodname;
QUIT;


/* 8.5  Code Example: Hiding Logic Complexities #1 */
PROC SQL;
  CREATE VIEW PROD_MANF_VIEW AS
    SELECT DISTINCT SUM(prodcost) FORMAT=DOLLAR10.2,
           M.manunum,
           M.manuname
      FROM PRODUCTS AS P, MANUFACTURERS AS M
        WHERE P.manunum  = M.manunum AND
              M.manuname = 'KPL Enterprises';
QUIT;


/* 8.5  Code Example: Hiding Logic Complexities #2 */
PROC SQL;
  SELECT *
    FROM PROD_MANF_VIEW;
QUIT;


/* 8.6  Code Example: Nesting Views #1 */
PROC SQL;
  CREATE VIEW WORKSTATION_PRODUCTS_VIEW AS
    SELECT PRODNUM, PRODNAME, PRODTYPE, PRODCOST
      FROM PRODUCTS
        WHERE UPCASE(PRODTYPE)="WORKSTATION";
QUIT;


/* 8.6  Code Example: Nesting Views #2 */
PROC SQL;
  CREATE VIEW INVOICE_1K_VIEW AS
    SELECT INVNUM, CUSTNUM, PRODNUM, INVQTY, INVPRICE
      FROM INVOICE
        WHERE INVPRICE >= 1000.00;
QUIT;


/* 8.6  Code Example: Nesting Views #3 */
PROC SQL;
  CREATE VIEW JOINED_VIEW AS
    SELECT V1.PRODNUM, V1.PRODNAME,
           V2.CUSTNUM, V2.INVQTY, V2.INVPRICE
      FROM WORKSTATION_PRODUCTS_VIEW  V1,
           INVOICE_1K_VIEW   V2
        WHERE V1.PRODNUM = V2.PRODNUM;
QUIT;


/* 8.6  Code Example: Nesting Views #4 */
PROC SQL;
  CREATE VIEW LARGEST_AMOUNT_VIEW AS
    SELECT MAX(INVPRICE*INVQTY) AS Maximum_Price
           FORMAT=DOLLAR12.2
           LABEL="Largest Invoice Amount"
      FROM JOINED_VIEW;
QUIT;


/* 8.7.1  Code Example: Inserting New Rows of Data #1 */
PROC SQL;
  CREATE VIEW SOFTWARE_PRODUCTS_VIEW AS
    SELECT prodnum, prodname, prodtype, prodcost
           FORMAT=DOLLAR8.2
      FROM PRODUCTS
        WHERE UPCASE(PRODTYPE) IN ('SOFTWARE');
QUIT;


/* 8.7.1  Code Example: Inserting New Rows of Data #2 */
PROC SQL;
  INSERT INTO SOFTWARE_PRODUCTS_VIEW
    VALUES(6002,'Security Software','Software',375.00);
QUIT;


/* 8.7.1  Code Example: Inserting New Rows of Data #3 */
/* NOTE: This Code Intentionally Produces an Error    */
PROC SQL;
  INSERT INTO SOFTWARE_PRODUCTS_VIEW
    VALUES(1701,'Travel Laptop SE','Laptop',4200.00);
QUIT;


/* 8.7.1  Code Example: Inserting New Rows of Data #4 */
/* NOTE: This Code Intentionally Produces an Error    */
PROC SQL;
  INSERT INTO SOFTWARE_PRODUCTS_VIEW
   VALUES(6003,'Cleanup Software','Software');
QUIT;


/* 8.7.1  Code Example: Inserting New Rows of Data #5 */
PROC SQL;
  CREATE VIEW SOFTWARE_PRODUCTS_TAX_VIEW AS
    SELECT prodnum, prodname, prodtype, prodcost,
           prodcost * .07 AS Tax
           FORMAT=DOLLAR8.2 LABEL='Sales Tax'
      FROM PRODUCTS
        WHERE UPCASE(PRODTYPE) IN ('SOFTWARE');
QUIT;


/* 8.7.1  Code Example: Inserting New Rows of Data #6 */
/* NOTE: This Code Intentionally Produces a Warning!  */
PROC SQL;
  INSERT INTO SOFTWARE_PRODUCTS_TAX_VIEW
   VALUES(6003,'Cleanup Software','Software',375.00,26.25);
QUIT;


/* 8.7.2  Code Example: Updating Existing Rows of Data #1 */
PROC SQL;
  CREATE VIEW LAPTOP_PRODUCTS_VIEW AS
    SELECT PRODNUM, PRODNAME, PRODTYPE, PRODCOST
      FROM PRODUCTS
        WHERE UPCASE(PRODTYPE) = 'LAPTOP';
QUIT;


/* 8.7.2  Code Example: Updating Existing Rows of Data #2 */
PROC SQL;
  UPDATE LAPTOP_PRODUCTS_VIEW
    SET PRODCOST = PRODCOST - (PRODCOST * 0.2);
QUIT;


/* 8.7.2  Code Example: Updating Existing Rows of Data #3 */
PROC SQL;
  CREATE VIEW LAPTOP_DISCOUNT_VIEW AS
    SELECT PRODNUM, PRODNAME, PRODTYPE, PRODCOST
      FROM PRODUCTS
        WHERE UPCASE(PRODTYPE) = 'LAPTOP' AND
              PRODCOST > 2800.00;
QUIT;


/* 8.7.2  Code Example: Updating Existing Rows of Data #4 */
PROC SQL;
  UPDATE LAPTOP_DISCOUNT_VIEW
    SET PRODCOST = PRODCOST - (PRODCOST * 0.2);
QUIT;


/* 8.7.3  Code Example: Deleting Rows of Data */
PROC SQL;
  DELETE FROM SOFTWARE_PRODUCTS_VIEW
    WHERE MANUNUM=600;
QUIT;


/* 8.8  Code Example: Deleting Views #1 */
PROC SQL;
  DROP VIEW INVENTORY_VIEW;
QUIT;


/* 8.8  Code Example: Deleting Views #2 */
PROC SQL;
  DROP VIEW INVENTORY_VIEW, LAPTOP_PRODUCTS_VIEW;
QUIT;






/**********************************************************/
/* Chapter 9: Troubleshooting and Debugging Techniques    */
/**********************************************************/


/* 9.5.1  Code Example: Validating Queries with the VALIDATE Statement */
PROC SQL;
  VALIDATE
    SELECT *
      FROM PRODUCTS
        WHERE PRODTYPE = 'Software';
QUIT;


/* 9.5.2.1  Code Example: FEEDBACK Option #1 */
PROC SQL FEEDBACK;
  SELECT *
    FROM PRODUCTS; 
QUIT;


/* 9.5.2.1  Code Example: FEEDBACK Option #2 */
PROC SQL FEEDBACK; 
   SELECT *
      FROM PRODUCTS, MANUFACTURERS
        WHERE PRODUCTS.MANUNUM = MANUFACTURERS.MANUNUM AND
              MANUFACTURERS.MANUNAME = 'KPL Enterprises';
QUIT;


/* 9.5.2.1  Code Example: FEEDBACK Option #3 */
%MACRO DUPS(LIB, TABLE, GROUPBY);
  PROC SQL FEEDBACK;
    SELECT &GROUPBY, COUNT(*) AS Duplicate_Rows 
      FROM &LIB..&TABLE
        GROUP BY &GROUPBY
          HAVING COUNT(*) > 1;
  QUIT;
%MEND DUPS;

%DUPS(WORK,PRODUCTS,PRODTYPE);



/* 9.5.2.1  Code Example: FEEDBACK Option #4 */
%MACRO DUPS(LIB, TABLE, GROUPBY);
  PROC SQL;
    SELECT &GROUPBY, COUNT(*) AS Duplicate_Rows 
      FROM &LIB..&TABLE
        GROUP BY &GROUPBY
          HAVING COUNT(*) > 1;
  QUIT;
  %PUT LIB = &LIB TABLE = &TABLE GROUPBY = &GROUPBY;
%MEND DUPS;

%DUPS(WORK,PRODUCTS,PRODTYPE);



/* 9.5.2.2  Code Example: INOBS= Option #1 */
PROC SQL INOBS=10;
  SELECT *
    FROM PRODUCTS; 
QUIT;


/* 9.5.2.2  Code Example: INOBS= Option #2 */
PROC SQL INOBS=5;
  SELECT prodname, prodcost,
         manufacturers.manunum, manuname
    FROM PRODUCTS, MANUFACTURERS;
QUIT;


/* 9.5.2.3  Code Example: LOOPS= Option #1 */
PROC SQL LOOPS=8;
  SELECT *
    FROM PRODUCTS;
QUIT;


/* 9.5.2.3  Code Example: LOOPS= Option #2 */
PROC SQL LOOPS=50;
  SELECT P.prodname, P.prodcost,
         M.manuname,
         I.invqty
    FROM PRODUCTS  P,
         MANUFACTURERS  M,
         INVOICE  I
      WHERE P.manunum = M.manunum AND
            P.prodnum = I.prodnum AND
            M.manunum = 500;
QUIT;


/* 9.5.2.4  Code Example: NOEXEC Option */
PROC SQL NOEXEC;
  CREATE TABLE NOEXEC_CHECK
    SELECT *
      FROM PRODUCTS
        WHERE PRODTYPE = 'Software';
QUIT;


/* 9.5.2.5  Code Example: OUTOBS= Option */
PROC SQL OUTOBS=5;
  CREATE TABLE PRODUCTS_SAMPLE AS
    SELECT *
      FROM PRODUCTS; 
QUIT;


/* 9.5.2.6  Code Example: PROMPT Option */
PROC SQL PROMPT INOBS=5;
  SELECT *
    FROM PRODUCTS; 
QUIT;


/* 9.5.2.7  Code Example: RESET Statement #1 */
PROC SQL FEEDBACK;
  SELECT *
    FROM PRODUCTS;

  RESET NOFEEDBACK;

  SELECT *
    FROM PRODUCTS
      WHERE PRODTYPE='Software';
QUIT;


/* 9.5.2.7  Code Example: RESET Statement #2 */
PROC SQL DOUBLE NUMBER OUTOBS=1;
  SELECT *
    FROM PRODUCTS
      WHERE PRODTYPE='Software';

  RESET NODOUBLE NONUMBER OUTOBS=MAX;

  SELECT *
    FROM PRODUCTS
      WHERE PRODTYPE='Software';
QUIT;


/* 9.5.2.7  Code Example: RESET Statement #3         */
/* NOTE: This Code Intentionally Produces a Warning! */
PROC SQL UNDO_POLICY=REQUIRED;
  UPDATE PRODUCTS
    SET PRODCOST = PRODCOST - (PRODCOST * 0.2)
      WHERE UPCASE(PRODTYPE) = 'LAPTOP';

  RESET UNDO_POLICY=NONE;

  UPDATE PRODUCTS
    SET PRODCOST = PRODCOST - (PRODCOST * 0.2)
      WHERE UPCASE(PRODTYPE) = 'LAPTOP';
QUIT;


/* 9.6  Code Example: Undocumented PROC SQL Options */
PROC SQL _TREE;
  SELECT *
    FROM PRODUCTS
      WHERE PRODTYPE = 'Software';
QUIT;


/* 9.6.1.2  Code Example: SQLOBS Macro Variable #1 */
PROC SQL;
 SELECT *
  FROM PRODUCTS
   WHERE PRODTYPE='Software';

 %PUT SQLOBS = &SQLOBS;

QUIT;



/* 9.6.1.2  Code Example: SQLOBS Macro Variable #2 */
PROC SQL;
 INSERT INTO PRODUCTS
           (PRODNUM, PRODNAME, PRODTYPE, PRODCOST)
  VALUES(6002,'Security Software','Software',375.00)
  VALUES(1701,'Travel Laptop SE', 'Laptop',  4200.00);

 %PUT SQLOBS = &SQLOBS;

QUIT;



/* 9.6.1.3  Code Example: SQLOOPS Macro Variable */
PROC SQL;
 SELECT *
  FROM PRODUCTS
   WHERE PRODTYPE='Software';

 %PUT SQLOOPS = &SQLOOPS;

QUIT;



/* 9.6.1.4  Code Example: SQLRC Macro Variable */
PROC SQL;
 SELECT *
  FROM PRODUCTS
   WHERE PRODTYPE='Software';

 %PUT SQLRC = &SQLRC;

QUIT;






/**********************************************************/
/* Chapter 10: Tuning for Performance and Efficiency      */
/**********************************************************/


/* 10.4  Code Example: Splitting Tables */
PROC SQL;
  CREATE TABLE INVENTORY_CURRENT AS
    SELECT *
      FROM INVENTORY
        WHERE YEAR(ORDDATE) = YEAR(TODAY());

  DELETE FROM INVENTORY
    WHERE YEAR(ORDDATE) = YEAR(TODAY());
QUIT;


/* 10.6  Code Example: Reviewing CONTENTS Output and System Messages */
PROC SQL;
  SELECT MEMNAME, NPAGE
    FROM DICTIONARY.TABLES
      WHERE LIBNAME='WORK' AND
        MEMNAME='INVENTORY';

  SELECT VARNUM, NAME, TYPE, LENGTH, FORMAT,
         INFORMAT, LABEL
    FROM DICTIONARY.COLUMNS
      WHERE LIBNAME='WORK' AND
        MEMNAME='INVENTORY';
QUIT;


/* 10.7.1  Code Example: Constructing Efficient Logic Conditions #1 */
/* NOTE: Less Efficient Code                                        */
PROC SQL;
  SELECT *
    FROM PRODUCTS
      WHERE UPCASE(PRODTYPE) = 'SOFTWARE' AND
            PRODCOST < 100.00;
QUIT;


/* 10.7.1  Code Example: Constructing Efficient Logic Conditions #2 */
/* NOTE: More Efficient Code                                        */
PROC SQL;
  SELECT *
    FROM PRODUCTS
      WHERE PRODCOST < 100.00 AND
            UPCASE(PRODTYPE) = 'SOFTWARE';
QUIT;


/* 10.7.1  Code Example: Constructing Efficient Logic Conditions #3 */
/* NOTE: Less Efficient Code                                        */
PROC SQL;
  SELECT *
    FROM PRODUCTS
      WHERE UPCASE(PRODTYPE) IN ('LAPTOP', 'SOFTWARE');
QUIT;


/* 10.7.1  Code Example: Constructing Efficient Logic Conditions #4 */
/* NOTE: More Efficient Code                                        */
PROC SQL;
  SELECT *
    FROM PRODUCTS
      WHERE UPCASE(PRODTYPE) IN ('SOFTWARE', 'LAPTOP');
QUIT;


/* 10.7.2  Code Example: Avoiding UNIONs #1 */
/* NOTE: Less Efficient Code                */
PROC SQL;
  SELECT *
    FROM PRODUCTS
      WHERE UPCASE(PRODTYPE) = 'LAPTOP'

  UNION

  SELECT *
    FROM PRODUCTS
      WHERE UPCASE(PRODTYPE) = 'SOFTWARE';
QUIT;



/* 10.7.2  Code Example: Avoiding UNIONs #2 */
/* NOTE: More Efficient Code                */
PROC SQL;
  SELECT DISTINCT *
    FROM PRODUCTS
      WHERE UPCASE(PRODTYPE) = 'SOFTWARE' OR
            UPCASE(PRODTYPE) = 'LAPTOP';
QUIT;

/*      */

PROC SQL;
  SELECT DISTINCT *
    FROM PRODUCTS
      WHERE UPCASE(PRODTYPE) IN ('SOFTWARE', 'LAPTOP');
QUIT;




/* 10.7.2  Code Example: Avoiding UNIONs #3 */
/* NOTE: Less Efficient Code                */
PROC SQL;
  SELECT *
    FROM PRODUCTS
      WHERE UPCASE(PRODTYPE) = 'LAPTOP'

  UNION ALL

  SELECT *
    FROM PRODUCTS
      WHERE UPCASE(PRODTYPE) = 'SOFTWARE';
QUIT;



