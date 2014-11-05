/* ----------------------------------------------------*/
/* Working with the SAS System                         */
/* by Erik W. Tilanus                                  */
/* pubcode #55190                                      */
/* ----------------------------------------------------*/

*-------------------------------------------------------;
* Title: GAS1
* Description: Calculate fuel consumption of a car. Use list input
* style. Input lines "in stream"
* Chapter: 2
* Figure: 2.2
*-------------------------------------------------------;
TITLE2 'SAMPLE PROGRAM 1';
DATA CARDATA;                  * TEMPORARY DATASET;
INPUT KM LITERS;               * INPUT CONTANS THESE VAR.S;
LABEL KM='ODOMETER READING';
LABEL MILEAGE ='KM PER LITER';
MILEAGE =DIF(KM)/LITERS;       * KM'S BETWEEN FILLUP/LITERS;
CARDS;                         * INPUT RECORDS FOLLOW THIS LINE;
9908 34.2
10227 35.2
10493 27.4
10855 34.8
11212 36.5
11515 30.4
11823 32.4
12150 30
12451 30.8
12812 37.2
13039 22.8
13398 37.3
13836 41.9
14154 32.7
14567 .
14829 25.7
15210 .
15488 28.2
15905 .
16209 29.3
16471 26
16757 28
17102 33.5
17583 48.4
17978 .
18366 .
18661 29.2
18888 22.9
19243 35.2
19437 20
19776 30.6
20089 29.7
20440 .
20694 27.9
20902 23
21158 26.4
21442 30.9
21716 30.6
22043 37.5
22474 46.5
22733 29
23061 37
23321 28.5
23624 34.5
23928 32.8
24264 37.4
24268 .
24482 22.9
24804 35.4
25102 34.0
25427 35.3
25666 24.6
25886 23.9
26219 33.0
26508 30.0
26854 35.2
27194 36.3
27524 37.0
28078 60.1
28446 37.9
PROC PRINT;                       * PRINT SURVEY OF DATA;
PROC MEANS;                       * CALCULATE AVERAGE VALUES;



*-------------------------------------------------------;
* Title: GAS2
* Description: Print description of data set
* Chapter: 2
* Figure: 2.8
*-------------------------------------------------------;
TITLE2 'SAMPLE PROGRAM 1 VARIANT 2';
DATA CARDATA;                  * TEMPORARY DATASET;
INPUT KM LITERS;               * INPUT CONTAINS THESE VAR'S;
LABEL KM='ODOMETER READING';
LABEL MILEAGE ='KM PER LITER';
MILEAGE =DIF(KM)/LITERS;       * KM'S BETWEEN FILLUP/LITERS;
CARDS;                         * INPUT RECORDS FOLLOW THIS LINE;
9908 34.2
10227 35.2
10493 27.4
10855 34.8
11212 36.5
11515 30.4
11823 32.4
12150 30
12451 30.8
12812 37.2
13039 22.8
13398 37.3
13836 41.9
14154 32.7
14567 .
14829 25.7
15210 .
15488 28.2
15905 .
16209 29.3
16471 26
16757 28
17102 33.5
17583 48.4
17978 .
18366 .
18661 29.2
18888 22.9
19243 35.2
19437 20
19776 30.6
20089 29.7
20440 .
20694 27.9
20902 23
21158 26.4
21442 30.9
21716 30.6
22043 37.5
22474 46.5
22733 29
23061 37
23321 28.5
23624 34.5
23928 32.8
24264 37.4
24268 .
24482 22.9
24804 35.4
25102 34.0
25427 35.3
25666 24.6
25886 23.9
26219 33.0
26508 30.0
26854 35.2
27194 36.3
27524 37.0
28078 60.1
28446 37.9
PROC CONTENTS;                    * PRINT DATASET DESCRIPTION;



*-------------------------------------------------------;
* Title: GAS3
* Description: Plot contents of a data set
* Chapter: 2
* Figure: 2.12
*-------------------------------------------------------;
TITLE2 'SAMPLE PROGRAM 1 VARIANT 3';
DATA CARDATA;                  * TEMPORARY DATASET;
INPUT KM LITERS;               * INPUT CONTAINS THESE VAR'S;
LABEL KM='ODOMETER READING';
LABEL MILEAGE ='KM PER LITER';
MILEAGE =DIF(KM)/LITERS;       * KM'S BETWEEN FILLUP/LITERS;
CARDS;                         * INPUT RECORDS FOLLOW THIS LINE;
9908 34.2
10227 35.2
10493 27.4
10855 34.8
11212 36.5
11515 30.4
11823 32.4
12150 30
12451 30.8
12812 37.2
13039 22.8
13398 37.3
13836 41.9
14154 32.7
14567 .
14829 25.7
15210 .
15488 28.2
15905 .
16209 29.3
16471 26
16757 28
17102 33.5
17583 48.4
17978 .
18366 .
18661 29.2
18888 22.9
19243 35.2
19437 20
19776 30.6
20089 29.7
20440 .
20694 27.9
20902 23
21158 26.4
21442 30.9
21716 30.6
22043 37.5
22474 46.5
22733 29
23061 37
23321 28.5
23624 34.5
23928 32.8
24264 37.4
24268 .
24482 22.9
24804 35.4
25102 34.0
25427 35.3
25666 24.6
25886 23.9
26219 33.0
26508 30.0
26854 35.2
27194 36.3
27524 37.0
28078 60.1
28446 37.9
PROC PLOT;
   PLOT MILEAGE*KM;        * PLOT THE DATA;



*-------------------------------------------------------;
* Title: EX4N2
* Description: Read data into SAS data set and print it
* Input data set: none (in stream data records)
* Chapter: 4
* Exercise: 4.3
*-------------------------------------------------------;
* PART A;
DATA WATER;
INPUT @1 CLIENT $8. @9 PREVIOUS 6.
      @15 LAST 6. @21 MONTH $3.
      @24 YEAR 4. @28 INVOICE 5.;
LABEL CLIENT   = 'Client code'
      PREVIOUS = 'Previous reading'
      LAST     = 'Last reading'
      MONTH    = 'Month of reading'
      YEAR     = 'Year of reading'
       INVOICE  = 'Invoice amount';
CARDS;
stevens.004537004819may1994267.38
mchill  012349012439may1994078.15
wallman 009824014348may1994839.82
RUN;
* PART B;
PROC PRINT LABEL;
   ID CLIENT;
   SUM INVOICE;




*-------------------------------------------------------;
* Title: GAS4
* Description: Calculate fuel consumption per interval of
* 5000 km and produce "dressed up" print
* Chapter: 4
* Figure: 4.6
*-------------------------------------------------------;
 /*--------------------------------------------------------------*/
 /* SAMPLE PROGRAM 2: USE OF BY GROUPS                           */
 /*--------------------------------------------------------------*/
TITLE2 'SAMPLE PROGRAM 2';
DATA CARDATA;                  * TEMPORARY DATASET;
INPUT KM LITERS;               * INPUT CONTAINS THESE VAR'S;
LABEL KM='ODOMETER READING';
LABEL MILEAGE ='KM PER LITER';
MILEAGE =DIF(KM)/LITERS;       * KM'S BETWEEN FILLUP/LITERS;
INTERVAL=INT(KM/5000);         * RESULTS PER 5000 KM;
CARDS;                         * INPUT RECORDS FOLLOW THIS LINE;
9908 34.2
10227 35.2
10493 27.4
10855 34.8
11212 36.5
11515 30.4
11823 32.4
12150 30
12451 30.8
12812 37.2
13039 22.8
13398 37.3
13836 41.9
14154 32.7
14567 .
14829 25.7
15210 .
15488 28.2
15905 .
16209 29.3
16471 26
16757 28
17102 33.5
17583 48.4
17978 .
18366 .
18661 29.2
18888 22.9
19243 35.2
19437 20
19776 30.6
20089 29.7
20440 .
20694 27.9
20902 23
21158 26.4
21442 30.9
21716 30.6
22043 37.5
22474 46.5
22733 29
23061 37
23321 28.5
23624 34.5
23928 32.8
24264 37.4
24268 .
24482 22.9
24804 35.4
25102 34.0
25427 35.3
25666 24.6
25886 23.9
26219 33.0
26508 30.0
26854 35.2
27194 36.3
27524 37.0
28078 60.1
28446 37.9
PROC MEANS;                       * CALCULATE MEAN VALUE;
   VAR MILEAGE;                   * OF VARIABLE MILEAGE;
   OUTPUT OUT=ANALYSE MEAN=AVG;   * STORE RESULT IN DS ANALYSIS;
   BY INTERVAL;                   * FOR EACH INTERVAL OF 5000 KM;
DATA RESULT;
   MERGE CARDATA ANALYSE;         * COMBINE THE DATASETS;
   BY INTERVAL;                   * INTERVAL IS MATCHING VARIABLE;
PROC FORMAT;                      * DEFINE LAY-OUT FOR INTERVAL;
   VALUE PER 1='INTERVAL 5000 TO 10000 KM'
             2='INTERVAL 10000 TO 15000 KM'
             3='INTERVAL 15000 TO 20000 KM'
             4='INTERVAL 20000 TO 25000 KM'
             5='INTERVAL 25000 TO 30000 KM';
PROC PRINT LABEL UNIFORM;         * PRINT DATASET RESULT;
   BY INTERVAL;                   * DIVIDE PRINT INTO SECTIONS;
   SUM LITERS;                    * ADD UP LITERS;
   ID KM;
   FORMAT INTERVAL PER.;          * COUPLE LAY-OUT WITH VARIABLE;
VAR LITERS MILEAGE AVG;
PROC CONTENTS DATA=_ALL_ ;



*-------------------------------------------------------;
* Title: IFSTMNT
* Description: Use of IF statements and AND and OR
* operators in the condition. The program tries to select
* flight data from a data set. (created in the step)
* Chapter: 6
* Figure: 6.5
*-------------------------------------------------------;
TITLE2 'IF STATEMENTS WITH AND AND OR OPERATORS';
DATA ONE TWO THREE FOUR FIVE;
  INPUT FLIGHTNR $ FLDATE:DATE7. CAP PASS;
  LIST;
  IF FLIGHTNR = 'KL631' THEN OUTPUT ONE;
  IF FLIGHTNR = 'KL631' AND FLDATE='15MAY91'D THEN OUTPUT TWO;
  IF FLIGHTNR = 'KL631' AND FLDATE='15MAY91'D OR FLDATE='22MAY91'D
     THEN OUTPUT THREE;
  IF FLIGHTNR = 'KL631' AND FLDATE='15MAY91'D OR '22MAY91'D
     THEN OUTPUT FOUR;
  IF FLIGHTNR = 'KL631' AND (FLDATE='15MAY91'D OR FLDATE='22MAY91'D)
     THEN OUTPUT FIVE;
  FORMAT FLDATE DATE7.;
CARDS;
KL519 12MAY91 124 112
KL519 15MAY91 124 124
KL519 22MAY91 168 138
KL631 13MAY91 289 254
KL631 15MAY91 289 212
KL631 22MAY91 212 164
KL632 15MAY91 289 234
KL632 22MAY91 212 199
PROC PRINT DATA=ONE;
PROC PRINT DATA=TWO;
PROC PRINT DATA=THREE;
PROC PRINT DATA=FOUR;
  FORMAT FLDATE 7.;
PROC PRINT DATA=FIVE;



*-------------------------------------------------------;
* Title: DOLOOP
* Description: Shows the working of the DO-END group
* Chapter: 6
* Figure: 6.7
*-------------------------------------------------------;
DATA DOLOOP1;
  DO X = 0 TO 10;
    Y = X**2;
    OUTPUT;
  END;
DATA DOLOOP2;
  DO WHILE (X LE 10);
    Y = X**2;
    OUTPUT;
    X+1;
  END;
DATA DOLOOP3;
  DO UNTIL (X GT 10);
    Y = X**2;
    OUTPUT;
    X+1;
  END;
PROC PRINT;



*-------------------------------------------------------;
* Title: EX6N3
* Description: Basic manipulations in the DATA step
* Input data set: input file  WEATHER.DAT
* Chapter: 6
* Exercise: 6.3
*-------------------------------------------------------;
* PART A;
FILENAME DD1 'WEATHER.DAT';
DATA STATS;
   INFILE DD1;
   INPUT @1 STATE $2 @3 MONTH $3. @6 RAINFALL 5.
         @11 MAXTEMP 5.1 @16 MINTEMP 5.1
         @21 AVETEMP 6.2;

* PART B;
   RANGE=MAXTEMP-MINTEMP;


* PART C;
* Be careful: rainfall was specified in millimeters;
   IF RAINFALL / 10 LT 5
      THEN MODE = 'DRY';
      ELSE MODE = 'WET';

* PART D;
   IF AVETEMP GT 23 AND MAXTEMP GT 30
      THEN CLIMATE = 'TROPICAL';
      ELSE DO;
         IF AVETEMP GT 18 AND AVETEMP LT 23
            AND MINTEMP GT 15 AND MAXTEMP LT 30
            THEN CLIMATE = 'HOT';
            ELSE DO;
               IF AVETEMP GT 10 AND AVETEMP LT 18
                  THEN CLIMATE = 'MILD';
                  ELSE DO;
                    IF MINTEMP GT 0 AND MAXTEMP LT 15
                       THEN CLIMATE = 'COOL';
                       ELSE DO;
                          IF MINTEMP LT 0 OR MAXTEMP LT 5
                             THEN CLIMATE = 'COLD';
                       END;
                  END;
            END;
      END;



*-------------------------------------------------------;
* Title: EX7N2
* Description: Basic DATA step processing
* Input data set: input file  ENGINE.DAT
* Chapter: 7
* Exercise: 7.2
*-------------------------------------------------------;
FILENAME INPTF 'ENGINE.DAT';

* PART A,G;
DATA  EXCEPT  PROFIT(KEEP=NET_REV);

* PART A,F,G;
   INFILE INPTF END=LAST; * Points to input file;
   INPUT @1 DATE MMDDYY8.
         @9 REP 2.
         @11 PROD 4.
         @15 DEFECT 4.
         @19 MACHINE $1.;

* PART A;
   IF DEFECT/PROD GE .1 THEN OUTPUT EXCEPT;

* PART B;
   IF PROD LE 0 THEN LIST;

* PART C;
   TOT_REP+REP;

* PART D,E (REPEATED);
   IF MACHINE='A' THEN DO;
      A_REP+REP;
      PROFIT_A+(PROD-DEFECT)*.55;
      LOSS_A+DEFECT*.23;
   END;
   IF MACHINE='B' THEN DO;
      B_REP+REP;
      PROFIT_B+(PROD-DEFECT)*.35;
      LOSS_B+DEFECT*.21;
   END;
   IF MACHINE='C' THEN DO;
      C_REP+REP;
      PROFIT_C+(PROD-DEFECT)*.19;
      LOSS_C+DEFECT*.11;
   END;

* PART F;
   IF LAST THEN DO;
      NET_REV = PROFIT_A + PROFIT_B +
                PROFIT_C - LOSS_A - VER_B - LOSS_C;
      LOSS_PRC = (LOSS_A + LOSS_B + LOSS_C) /
                (PROFIT_A + PROFIT_B + PROFIT_C)*100;

* PART G;
      OUTPUT PROFIT;
   END;



*-------------------------------------------------------;
* Title: EX8N2
* Description: Exercises with SET and MERGE statements
* Input data set: CANDIDAT ELECTION
* Chapter: 8
* Exercise: 8.2
*-------------------------------------------------------;
LIBNAME GEN '.GENERAL.SASLIB';

* PART A;
PROC SORT DATA=GEN.CANDIDAT OUT=CANDIDAT;
   BY NAME;
PROC SORT DATA=GEN.ELECTION OUT=ELECTION;
   BY NAME;
DATA A;
   MERGE ELECTION(IN=E) CANDIDAT;
      BY NAME;
      IF E;
PROC PRINT;
   VAR NAME PARTY STATE YEAR;
   TITLE 'Winner of the election with party and state';

* PART B;
PROC SORT DATA=ELECTION OUT=ELECT2;
   BY LOSER YEAR;
DATA B;
   MERGE ELECTION ELECT2(IN=IN_2 DROP=NAME RENAME=(LOSER=NAME));
   BY NAME YEAR;
   IF LAST.NAME THEN DO;
      IF IN_2 THEN RESULT='LOSER  ' ;
              ELSE RESULT='WINNER';
      OUTPUT;
   END;
PROC PRINT;
   VAR NAME YEAR RESULT;
   TITLE 'Last election and result for per cantidate';
RUN;

* PART C;
DATA C;
   MERGE CANDIDAT ELECTION(IN=E);
   BY NAME;
   IF FIRST.NAME THEN COUNT=0;
   COUNT+E; *E is numeric variable, value 0 or 1!;
   IF LAST.NAME THEN OUTPUT;
PROC PRINT;
   VAR  NAME COUNT;
   TITLE 'Number of times that each candicate won';
RUN;

* PART D;
DATA LOSER;
   SET ELECTION(DROP=NAME RENAME=(LOSER=NAME));
* This is just another way to acomplish the same as in part B;
PROC SORT;
   BY NAME;
DATA D;
   MERGE LOSER(IN=L) ELECTION(IN=E);
   BY NAME;
   IF L AND E;
PROC PRINT;
   VAR NAME;
   TITLE 'Candidates that both won and lost';
RUN;



*-------------------------------------------------------;
* Title: MERGERPT
* Description: Illustrates the disastrous effect of repeated BY values
* in a MERGE and indicates a possible evarsion.
* Input data set: none
* Chapter: 8
* Figure: 8.2 - 8.5
*-------------------------------------------------------;
 /*------------------------------------------------------*/
 /* MERGE WITH REPEAT OF BY VALUES                       */
 /*------------------------------------------------------*/
DATA JOBS;
   INPUT TASK $;
CARDS;
A
A
B
PROC PRINT;
TITLE 'DATA SET WERK';
RUN;
DATA NORMS;
   INPUT TASK $ SUBTASK $ DURATION;
CARDS;
A  A1  10
A  A2   5
B  B1  20
B  B2  15
B  B3  10
PROC PRINT;
TITLE 'DATA SET NORMS';
RUN;
DATA WRONGTOT;
   MERGE JOBS NORMS;
   BY TASK;
   TOT_MIN + DURATION;
RUN;
PROC PRINT;
TITLE 'WRONG CALCULATION';
RUN;
DATA TOTNORM (KEEP = TASK MINUTES);
   SET NORMS;
   BY TASK;
   IF FIRST.TASK THEN MINUTES = 0;
   MINUTES + DURATION;
   IF LAST.TASK THEN OUTPUT;
RUN;
PROC PRINT;
TITLE 'TOTAL TIME PER TASK';
RUN;
DATA CORRECTT;
   MERGE JOBS TOTNORM;
   BY TASK;
   TOT_MIN + MINUTES;
RUN;
PROC PRINT;
TITLE 'CORRECT TOTAL JOBTIME';
RUN;



*-------------------------------------------------------;
* Title: DIYPGM1
* Description: Print and combine order listings from a DIY
* shop.
* Input data set: DEPT1 DEPT2 DEPT3
* Chapter: 8
* Figure: 8.2 - 8.5
*-------------------------------------------------------;
LIBNAME GEN '.GENERAL.SASLIB';
PROC PRINT DATA=GEN.DEPT1;
PROC PRINT DATA=GEN.DEPT2;
PROC PRINT DATA=GEN.DEPT3;
PROC SORT DATA=GEN.DEPT1 OUT=DEPT1;
BY ART_NBR;
PROC SORT DATA=GEN.DEPT2 OUT=DEPT2;
BY ART_NBR;
PROC SORT DATA=GEN.DEPT3 OUT=DEPT3;
BY ART_NBR;
DATA SORT_TOT;
SET DEPT1 DEPT2 DEPT3;
BY ART_NBR;
PROC PRINT;
RUN;



*-------------------------------------------------------;
* Title: DIYPGM2
* Description: Combine order lists with product description.
* Input data set: SORT_TOT (created inDIYPGM1) ART_DES
* Chapter: 8
* Figure: 8.10
*-------------------------------------------------------;
LIBNAME GEN '.GENERAL.SASLIB';
DATA ORDER;
   MERGE SORT_TOT GEN.ART_DES;
   BY ART_NBR;
   VAT = .175 * PRICE;
   AMOUNT = QUANTITY * (PRICE + VAT);
RUN;
PROC PRINT;
   SUM AMOUNT;
RUN;



*-------------------------------------------------------;
* Title: DIYPGM3
* Description: Update the article description file with new
* articles and prices
* Input data set: ART_DES ART_UPD
* Chapter: 8
* Figure: 8.12
*-------------------------------------------------------;
LIBNAME GEN '.GENERAL.SASLIB';
PROC PRINT DATA=GEN.ART_UPD;
PROC SORT  DATA=GEN.ART_DES OUT=ART_DES;
BY ART_NBR;
PROC SORT  DATA=GEN.ART_UPD OUT=ART_UPD;
BY ART_NBR;
DATA NART_DES;
   UPDATE ART_DES ART_UPD;
   BY ART_NBR;
RUN;
PROC PRINT;
RUN;



*-------------------------------------------------------;
* Title: DIYPGM4
* Description: Demonstration of FIRST. and LAST.
* Input data set: ORDER
* Chapter: 8
* Figure: 8.12
*-------------------------------------------------------;
LIBNAME GEN '.GENERAL.SASLIB';
DATA SUMMARY(KEEP=ART_CAT ITEMS);
        SET GEN.ORDER;
        BY ART_CAT NOTSORTED;
        IF FIRST.ART_CAT THEN ITEMS=0;
        ITEMS + 1;
        IF LAST.ART_CAT THEN OUTPUT;
PROC PRINT;



*-------------------------------------------------------;
* Title: EX8N2
* Description: Exercises with SET and MERGE statements
* Input data set: CANDIDAT ELECTION
* Chapter: 8
* Exercise: 8.2
*-------------------------------------------------------;
LIBNAME GEN '.GENERAL.SASLIB';

* PART A;
PROC SORT DATA=GEN.CANDIDAT OUT=CANDIDAT;
   BY NAME;
PROC SORT DATA=GEN.ELECTION OUT=ELECTION;
   BY NAME;
DATA A;
   MERGE ELECTION(IN=E) CANDIDAT;
      BY NAME;
      IF E;
PROC PRINT;
   VAR NAME PARTY STATE YEAR;
   TITLE 'Winner of the election with party and state';

* PART B;
PROC SORT DATA=ELECTION OUT=ELECT2;
   BY LOSER YEAR;
DATA B;
   MERGE ELECTION ELECT2(IN=IN_2 DROP=NAME RENAME=(LOSER=NAME));
   BY NAME YEAR;
   IF LAST.NAME THEN DO;
      IF IN_2 THEN RESULT='LOSER  ' ;
              ELSE RESULT='WINNER';
      OUTPUT;
   END;
PROC PRINT;
   VAR NAME YEAR RESULT;
   TITLE 'Last election and result for per cantidate';
RUN;

* PART C;
DATA C;
   MERGE CANDIDAT ELECTION(IN=E);
   BY NAME;
   IF FIRST.NAME THEN COUNT=0;
   COUNT+E; *E is numeric variable, value 0 or 1!;
   IF LAST.NAME THEN OUTPUT;
PROC PRINT;
   VAR  NAME COUNT;
   TITLE 'Number of times that each candicate won';
RUN;

* PART D;
DATA LOSER;
   SET ELECTION(DROP=NAME RENAME=(LOSER=NAME));
* This is just another way to acomplish the same as in part B;
PROC SORT;
   BY NAME;
DATA D;
   MERGE LOSER(IN=L) ELECTION(IN=E);
   BY NAME;
   IF L AND E;
PROC PRINT;
   VAR NAME;
   TITLE 'Candidates that both won and lost';
RUN;



*-------------------------------------------------------;
* Title: SINUS
* Description: Create print of sinus curve, illustrate FILE and
* PUT statements
* Input data set: none
* Chapter: 9
* Figure: 9.10
*-------------------------------------------------------;
 /*----------------------------------------------------*/
 /* CREATION OF A SINUS CURVE                          */
 /*----------------------------------------------------*/
 TITLE2 'SAMPLE PROGRAM CHAPT 9: SINUS CURVE';
DATA _NULL_;                * NO CREATION OF DATA SET;
  FILE PRINT N=PS;          * KEEP WHOLE PAGE IN OUTPUT BUFFER;
  C=1;
  DO UNTIL (C=72);          * 72 COLUMNS OUTPUT REQUIRED;
    ARC=2*3.14*C/72;        * CONVERT C TO RADIANS 72 = 2 PI;
    SIN=SIN(ARC);           * SINUS FUNCTON;
    L=ROUND(20-15*SIN);     * POSITION ON THE PAGE;
    PUT #L @C '*';          * WRITE POINT OF SINUS CURVE;
    PUT #20 @C '-';         * WRITE BASE LINE;
    C+1;                    * NEXT COLUMN. SUM STATEMENT;
  END;
PUT _PAGE_;



*-------------------------------------------------------;
* Title: EX9N2
* Description: Creation of a telephone directory
* Input data set: DEPARTMENT PHONE (not included)
* Chapter: 9
* Exercise: 9.2
*-------------------------------------------------------;
LIBNAME F1 'DEPTDATA.SASLIB';
LIBNAME F2 'FONEDATE.SASLIIB';

* Sort and copy to WORK;
PROC SORT DATA=F1.DEPTMENT OUT=DEPTMENT;
   BY NAME;
PROC SORT DATA=F2.PHONE OUT=PHONE;
   BY NAME;
DATA _NULL_;
   MERGE DEPTMENT(KEEP= DEPTCODE NAME)
         PHONE(KEEP= FONENBR NAME);
   BY NAME;         * matching variable  ;
   RETAIN L 5;      * initial value = first line of
                      names from top of page;
   RETAIN C 1;      * initial value: first column;
   LENGTH BEG $3 INIT $1 LAGINIT $1;
   FILE PRINT N=PS HEADER=PAGEHD;
   BEG=SUBSTR(NAME,1,3);
   INIT=SUBSTR(NAME,1,1);
   LAGINIT=LAG(SUBSTR(NAME,1,1));
   IF INIT NE LAGINIT THEN DO;
      * This signals start of new first character;
      IF L GT 47 THEN LINK NEWCOL;
      * NEWCOL starts new column;
      IF L=5 AND C=1 THEN PUT #2 @90 INIT;
      * This is a new page, print first character;
      * in upper right corner;
      IF L GT 5 THEN L+3; * Skip three lines;
      PUT #L @C INIT; * print new first character;
      L+2;
   END;
   IF L=5 AND C=1
      THEN PUT #2 @90 BEG;
      ELSE PUT #2 @96 BEG;
   * This way you have always the last name in the
   * upper right hand corner of the page;
   PUT #L @C NAME @C+20 DEPTCODE @C+30 FONENBR;
   L+1;
   IF L=56 THEN LINK NEWCOL;
RETURN; * This ends the main program;
NEWCOL: * Subroutine to start a new column or page;
   C+40; L=5;
   IF C GT 81 THEN DO;
      PUT _PAGE_;
      C=1;
   END;
RETURN;
PAGEHD: * Subroutine to print page header;
   DO C=1, 41, 81;
      PUT #3 @C 'NAME' @C+20 'DEPTMENT'
             @C+30 'TEL.NR';
   END;
RETURN;



*-------------------------------------------------------;
* Title: MEANS
* Description: Calculate descriptive statistics from data
* about processing at a supermarket checkout
* Input data set: REG
* Chapter: 11
* Figure: 11.2
*-------------------------------------------------------;
LIBNAME F1 '.GENERAL.SASLIB' DISP=SHR;
TITLE2 'PROC MEANS EXAMPLE';
DATA REG;SET F1.REG;
PROC MEANS DATA=GEN.REG MEAN STD SKEWNESS MIN MAX STDERR MAXDEC=2;
   VAR DURATION;
PROC SORT DATA=GEN.REG OUT=REG;
   BY CHECKOUT;
PROC MEANS DATA=REG NOPRINT;
   VAR DURATION;
   OUTPUT OUT=RESULT MEAN=MEANDUR;
   BY CHECKOUT;
PROC PRINT;
ID CHECKOUT;



*-------------------------------------------------------;
* Title: CHART
* Description: Create several styles of bar and pie charts
* Input data set: TURNOVER TURNOV_2 ORDER
* Chapter: 11
* Figure: 11.2
*-------------------------------------------------------;
TITLE2 'EXAMPLES PROC CHART';
LIBNAME F1 '.GENERAL.SASLIB' DISP=SHR;
PROC CHART DATA=F1.TURNOVER;
  VBAR YEAR;
  VBAR YEAR/SUMVAR=PROFIT;
PROC CHART DATA=F1.TURNOV_2;
  VBAR YEAR/SUBGROUP=CAT SUMVAR=TURNOVER;
  VBAR YEAR/GROUP=CAT SUMVAR=TURNOVER;
  VBAR CAT/GROUP=YEAR SUMVAR=TURNOVER;
  HBAR YEAR/SUBGROUP=CAT SUMVAR=TURNOVER;
DATA A B;
  SET F1.TURNOV_2;
  IF YEAR GE '91/92';             * REMOVE OLD INFO;
  IF CAT NE 'BEER' THEN OUTPUT B;
  OUTPUT A;
PROC CHART DATA=A;
  PIE CAT/SUMVAR=TURNOVER;
PROC CHART DATA=B;
  BLOCK YEAR/GROUP=CAT SUMVAR=TURNOVER;
PROC CHART DATA=F1.ORDER  LPI=5.42;
  STAR ART_CAT;



*-------------------------------------------------------;
* Title: MEANSUM
* Description: Calculate more extensive statistics from data
* about processing at a supermarket checkout, incl. classification
* Input data set: REG
* Chapter: 11
* Figure: 11.7
*-------------------------------------------------------;
LIBNAME GEN '.GENERAL.SASLIB' DISP=SHR;
TITLE2 'MEANS AND SUMMARY';
PROC MEANS DATA=GEN.REG ALPHA=.1 FW=8 MAXDEC=3 MEAN CLM;
CLASS TIME COUNTER;
VAR DURATION;
OUTPUT OUT=OUTMEANS SUM(DURATION)=TOT_BUSY
       MEAN(DURATION)=C_O_TIME;
FORMAT TIME HOUR.;
FORMAT TOT_BUSY MMSS. C_O_TIME MMSS.;
RUN;
PROC SUMMARY DATA=GEN.REG;
CLASS TIME COUNTER;
VAR DURATION;
OUTPUT OUT=OUTMEANS SUM(DURATION)=TOT_BUSY
MEAN(DURATION)=C_O_TIME;
FORMAT TIME HOUR.;
FORMAT TOT_BUSY MMSS. C_O_TIME MMSS.;
RUN;
PROC PRINT;
RUN;



*-------------------------------------------------------;
* Title: FREQ
* Description: Create descriptive tables from data
* about processing at a supermarket checkout
* Input data set: REG
* Chapter: 11
* Figure: 11.9
*-------------------------------------------------------;
 /*--------------------------------------------------*/
 /* PROC FREQ EXAMPLE                                */
 /*--------------------------------------------------*/
LIBNAME GEN '.GENERAL.SASLIB' DISP=SHR;
TITLE2 'PROC FREQ EXAMPLE  ';
PROC FREQ DATA=GEN.REG;
   TABLE TIME;
   TABLE CHECKOUT;
   TABLE TIME*CHECKOUT;
   TABLE TIME*CHECKOUT/LIST;
   TABLE CHECKOUT*TIME/OUT=FREQOUT NOPRINT;
   FORMAT TIME HOUR.;
PROC PRINT DATA=FREQOUT;



*-------------------------------------------------------;
* Title: EX11N1
* Description: Exercises with PROC MEANS and FREQ
* Input data set: HOUSES
* Chapter: 11
* Exercise: 11.1
*-------------------------------------------------------;
LIBNAME REALEST '.GENERAL.SASLIB';

* PART A;
PROC MEANS DATA=REALEST.HOUSES
   MEAN MIN MAX;
   VAR PRICE;

* PART B;
PROC FREQ DATA=REALEST.HOUSES;
   TABLE TYPE;

* PART C;
PROC FREQ DATA=REALEST.HOUSES;
   TABLE TYPE*ROOMS/ NOFREQ NOROW NOCOL;

* PART D;
PROC SORT DATA=REALEST.HOUSES OUT = HOUSES;
   BY TYPE FIREPL;
PROC MEANS DATA=HOUSES NOPRINT;
   VAR PRICE;
   BY TYPE FIREPL;
   OUTPUT OUT=PRICE MEAN=MEAN_PR;
PROC FREQ DATA= HOUSES;
   TABLE TYPE*FIREPL / OUT=FIRE;
DATA RESULT;
   MERGE PRICE FIRE;
   BY TYPE;
PROC PRINT;

* PART E;
PROC SORT DATA=REALEST.HOUSES OUT=HOUSES;
   BY TYPE FIREPL;
PROC MEANS MEAN N NOPRINT;
   VAR PRICE;
   BY TYPE FIREPL;
   OUTPUT OUT=MEANDATA N=COUNT MEAN=MEAN_PR;
RUN;



*-------------------------------------------------------;
* Title: TABULATE
* Description: Create summary statistics in table, based on
* turn-over figures of a liquor wholesaler
* Input data set: TURNOV_2
* Chapter: 12
* Figure: 12.4
*-------------------------------------------------------;
LIBNAME IN '.GENERAL.SASLIB' DISP=SHR;
PROC PRINT DATA=IN.TURN_OV2;
   VAR YEAR CAT TURNOVER;
TITLE2 'EXAMPLE PROC TABULATE';
PROC TABULATE DATA=IN.TURNOV_2  ;
   CLASS YEAR CAT;
   VAR TURNOVER;
   TABLE YEAR,CAT*TURNOVER*(SUM PCTSUM);
PROC TABULATE DATA=IN.TURNOV_2   FORMAT=6.;
   CLASS YEAR CAT;
   VAR TURNOVER;
   TABLE YEAR ALL,CAT='ARTICLE CATEGORY'*TURNOVER=' '*
         (SUM PCTSUM<CAT>*F=6.1) ALL*TURNOVER*SUM/
         BOX='TURNOVER SUMMARY' RTS=7;
   KEYLABEL SUM='TURN-OVER IN USD X 1000'
            PCTSUM='PERCENTAGE OF TURN-OVER';



*-------------------------------------------------------;
* Title: EX12N1
* Description: PROC TABULATE exercise
* Input data set: HOUSES
* Chapter: 12
* Exercise: 12.1
*-------------------------------------------------------;
LIBNAME REALEST '.GENERAL.SASLIB';

PROC FORMAT;
   VALUE GAR
      0='No garage'
      1='Garage present';
   VALUE FP
      0='No fireplace'
      1='Fireplace present';
PROC TABULATE DATA=REALEST.HOUSES;
   CLASS TYPE ROOMS GARAGE FIREPL;
   VAR PRICE;
   TABLE TYPE*ROOMS,GARAGE*PRICE*MEAN FIREPL*N;
   FORMAT GARAGE GAR.;
   FORMAT FIREPL FP.;
   KEYLABEL N='Quantity' MEAN = 'Average price';



*-------------------------------------------------------;
* Title: PLOT
* Description: Create graphical overviews of profit and turnover
* Input data set: TURNOVER TURNOV_2
* Chapter: 13
* Figure: 13.3
*-------------------------------------------------------;
TITLE2 'EXAMPLES PROC PLOT';
LIBNAME F1 '.GENERAL.SASLIB' DISP=SHR;
PROC PLOT DATA=F1.TURNOVER;
   PLOT PROFIT*YEAR/VREF=100;
   PLOT WATER*YEAR='M' ORANGE*YEAR='S' COLA*YEAR='C' BEER*YEAR='B' /
        OVERLAY;
   LABEL WATER='TURNOVER IN USD X 1000';
PROC PLOT DATA=F1.TURNOVER HPERCENT=100 33 33 33    VPERCENT=50;
   PLOT PROFIT*YEAR/VREF=100;
   PLOT WATER*YEAR='M' ORANGE*YEAR='S' COLA*YEAR='C';
   LABEL WATER='TURNOVER IN USD X 1000';
PROC PLOT DATA=F1.TURNOV_2;
   PLOT TURNOVER*YEAR $ CAT;
RUN;



*-------------------------------------------------------;
* Title: EX13N1
* Description: PROC PLOT / CHART exercises
* Input data set: STATS
* Chapter: 13
* Exercise: 13.1
*-------------------------------------------------------;
LIBNAME INPUT '.GENERAL.SASLIB';

* PART A;
PROC SORT DATA=INPUT.STATS;
   BY STATE;
PROC PLOT;
   PLOT MAXTEMP*MONTH='+' MINTEMP*MONTH='-'
        / OVERLAY HAXIS='JAN' 'FEB' 'MAR' 'APR' 'MAY'
          'JUN' 'JUL' 'AUG' 'SEP' 'OCT' 'NOV' 'DEC';
BY STATE;

* PART B;
PROC CHART;
  VBAR CLIMATE/MIDPOINTS='TROPICAL' 'HOT'
                         'MILD' 'COOL' 'COLD';

* PART C;
PROC CHART;
   PIE CLIMATE/TYPE=PCT;
RUN;
QUIT;



*-------------------------------------------------------;
* Title: CALLEXEC
* Description: Create separate output files with airline passenger
* data from one master file and a file with selected flights
* Note: FILENAME statement is in MVS format.
* Input data set: FLTDATA FLTEXEC
* Chapter: 14
* Figure: 14.12
*-------------------------------------------------------;
%MACRO DOALLOC(FLIGHT);
   FILENAME &FLIGHT "TILANE.&FLIGHT..DATA" DISP=NEW SPACE=(TRK,(1,1));
   DATA _NULL_;
      SET FLT.FLTDATA;
      IF AIRLINE||FLTNBR="&FLIGHT" THEN
         DO;
            FILE &FLIGHT NOPRINT;
            PUT AIRLINE FLTNBR +1 FLDTE DATE7. +1 CAP PAX;
         END;
   RUN;
%MEND;
LIBNAME FLT '.GENERAL.SASLIB';
LIBNAME GEN '.GENERAL.SASLIB';
DATA _NULL_;
   SET GEN.FLTEXEC;
   CALL EXECUTE('%DOALLOC('||AIRLINE||FLTNBR||')');
RUN;



*-------------------------------------------------------;
* Title: EX14N9
* Description: Macro to make plot with reference lines
* based on mean and STD
* Input data set: none
* Chapter: 14
* Exercise: 14.9
*-------------------------------------------------------;

%MACRO PLOTREF(DATA, YVAR, XVAR);
   PROC MEANS NOPRINT DATA=&DATA;
      VAR &YVAR;
      OUTPUT  MEAN=MEAN STD=STD;
   DATA _NULL_;
      SET;
      CALL SYMPUT('MEAN',LEFT(PUT(MEAN,8.)));
      CALL SYMPUT('LOW',LEFT(PUT(MEAN-STD,8.)));
      CALL SYMPUT('HIGH',LEFT(PUT(MEAN+STD,8.)));
   PROC PLOT DATA=&DATA;
      PLOT &YVAR*&XVAR/VREF=&MEAN &LOW &HIGH;
%MEND PLOTREF;



*-------------------------------------------------------;
* Title: MMIND
* Description: Implements the Mastermind game in SAS software
* Input data set: none
* Chapter: 15
* Figure: 15.4
*-------------------------------------------------------;
PROC FORMAT ;
VALUE CODEFMT 1='=' 2='!' OTHER=' ';
RUN;
DATA _NULL_;
ARRAY ANSWER {5,8};
ARRAY SCORE {5} $5;
ARRAY CODE {4};
RETAIN TRY 0 POINT;
* GENERATE THE RANDOM CIPHERS;
DO N=1 TO 4;
   DO UNTIL (M NE CODE{1} AND M NE CODE{2}
             AND M NE CODE{3} AND M NE CODE{4} AND M LT 10);
      M=INT(UNIFORM(0)*10);
   END;
   CODE{N} = M;
END;
WINDOW M_MIND
  GROUP=GUESS
  #2 @3 "THIS IS ATTEMPT" +1 TRY 3. PROTECT=YES
  #4 @3 "TYPE YOUR GUESS:"
     @25 ANSWER{1,1} 1. REQUIRED=YES ATTR  =UNDERLINE
     @28 ANSWER{1,2} 1. REQUIRED=YES ATTR  =UNDERLINE
     @31 ANSWER{1,3} 1. REQUIRED=YES ATTR  =UNDERLINE
     @34 ANSWER{1,4} 1. REQUIRED=YES ATTR  =UNDERLINE
  #6 @3 "THESE WERE YOUR LAST 4 GUESSES:"
  #8 @25 ANSWER{2,1} 1. PROTECT=YES
     @28 ANSWER{2,2} 1. PROTECT=YES
     @31 ANSWER{2,3} 1. PROTECT=YES
     @34 ANSWER{2,4} 1. PROTECT=YES
     @40 SCORE {2} PROTECT=YES
  #9 @25 ANSWER{3,1} 1. PROTECT=YES
     @28 ANSWER{3,2} 1. PROTECT=YES
     @31 ANSWER{3,3} 1. PROTECT=YES
     @34 ANSWER{3,4} 1. PROTECT=YES
     @40 SCORE {3} PROTECT=YES
 #10 @25 ANSWER{4,1} 1. PROTECT=YES
     @28 ANSWER{4,2} 1. PROTECT=YES
     @31 ANSWER{4,3} 1. PROTECT=YES
     @34 ANSWER{4,4} 1. PROTECT=YES
     @40 SCORE {4} PROTECT=YES
 #11 @25 ANSWER{5,1} 1. PROTECT=YES
     @28 ANSWER{5,2} 1. PROTECT=YES
     @31 ANSWER{5,3} 1. PROTECT=YES
     @34 ANSWER{5,4} 1. PROTECT=YES
     @40 SCORE {5} PROTECT=YES
   GROUP=SCORE
 #14 @3 "GUESSED IN "
         TRY 2. PROTECT=YES
         +1 "ATTEMPTS"
 ;
TRY=0;
POINT=0;
_MSG_="GUESS THE CODE. GOOD LUCK! - PF3 FOR EXIT";
DO UNTIL (POINT = 8);
   * SHIFT THE ANSWERS AND SCORE ONE LINE IN THE ARRAY;
   DO N=5 TO 2 BY -1;
      DO M=1 TO 8;
         ANSWER{N,M} = ANSWER{N-1,M};
         SCORE{N} = SCORE{N-1};
      END;
   END;
   * CLEAR FIRST LINE OF ARRAY'S;
   DO M=1 TO 8;
      ANSWER{1,M} = .;
   END;
      SCORE{1} =' ';
   TRY + 1;
   DISPLAY M_MIND.GUESS BLANK;
   DO N=1 TO 4;
     DO M=1 TO 4;
       IF CODE{N} = ANSWER{1,M} THEN
          IF M=N THEN ANSWER{1,M+4} = 2;
          ELSE ANSWER{1,M+4} = 1;
     END;
   END;
   POINT = SUM(OF ANSWER5 -- ANSWER8);
   DO N=5 TO 8;
      SCORE{1}=TRIM(SCORE{1})||PUT(ANSWER{1,N},CODEFMT.);
   END;
END;
DISPLAY M_MIND.SCORE        ;
RUN;



*-------------------------------------------------------;
* Title: EX15N2
* Description: Create window for user selections
* Input data set: none
* Chapter: 15
* Exercise: 15.2
*-------------------------------------------------------;

DATA OPTION;
   ARRAY ACTION {8 } $1;
   ARRAY CNTRY  {10} $2;
   ARRAY OPTION {8 } $15
      ('POPULATION ','AREA','CURRENCY',
       'NAT. PRODUCT','GOVERN.BUDGET',
       'OFF. INTEREST %','TAX %','NAT. INCOME');
   WINDOW CHOICE
      #2 @2 ACTION{1} ATTR=UNDERLINE
         +1 OPTION{1} PROTECT=YES
         +2 ACTION{2} ATTR=UNDERLINE
         +1 OPTION{2} PROTECT=YES
         +2 ACTION{3} ATTR=UNDERLINE
         +1 OPTION{3} PROTECT=YES
         +2 ACTION{4} ATTR=UNDERLINE
         +1 OPTION{4} PROTECT=YES
      #3 @2 ACTION{5} ATTR=UNDERLINE
         +1 OPTION{5} PROTECT=YES
         +2 ACTION{6} ATTR=UNDERLINE
         +1 OPTION{6} PROTECT=YES
         +2 ACTION{7} ATTR=UNDERLINE
         +1 OPTION{7} PROTECT=YES
         +2 ACTION{8} ATTR=UNDERLINE
         +1 OPTION{8} PROTECT=YES
      #5 @5 CNTRY{1} ATTR=UNDERLINE
         +5 CNTRY{2} ATTR=UNDERLINE
         +5 CNTRY{3} ATTR=UNDERLINE
         +5 CNTRY{4} ATTR=UNDERLINE
         +5 CNTRY{5} ATTR=UNDERLINE
      #6 @5 CNTRY{6} ATTR=UNDERLINE
         +5 CNTRY{7} ATTR=UNDERLINE
         +5 CNTRY{8} ATTR=UNDERLINE
         +5 CNTRY{9} ATTR=UNDERLINE
         +5 CNTRY{10} ATTR=UNDERLINE;
   DISPLAY CHOICE;
   * Shift specified countries to begin of array;
   CNTR_SP = 0; * counts specified countries;
   DO X = 1 TO DIM(CNTRY);
      IF CNTRY{X} NE ' ' THEN DO;
         * Country specified in this location;
         CNTR_SP +1;
         * Shift it to first free location;
         CNTRY{CNTR_SP} = CNTRY{X};
     END;
   END;
   DO X=CNTR_SP+1 TO DIM(CNTRY);
      * Clean the remainder of the array;
      CNTRY{X} = ' ';
   END;
   * Generate observations for chosen options;
   DO X=1 TO DIM(ACTION);
      IF ACTION{X} NE ' ' THEN DO;
         SELECT = OPTION{X};
         OUTPUT;
      END;
   END;
   STOP; * Don't display window again;
RUN;



*-------------------------------------------------------;
* Title: BINSRCH
* Description: Binary search routine
* Input data set: ISBNINDX (not included)
* Chapter: 16
* Figure: 16.2
*-------------------------------------------------------;
LIBNAME LIBR 'TILANE.LIBRARY.SASLIB' DISP=SHR;
%LET ISBN=155544381-8;
DATA SELECT;
BASE=1;
TOP=NOBS;
   POINT=INT((TOP+BASE)/2);
DO WHILE (TOP-BASE > 2);
   SET LIBR.ISBNINDX POINT=POINT NOBS=NOBS;
   PUT BASE= TOP= POINT=;
   IF ISBN = "&ISBN" THEN LEAVE;
   IF ISBN < "&ISBN" THEN BASE = POINT +1;
   IF ISBN > "&ISBN" THEN TOP = POINT -1;
   POINT=INT((TOP+BASE)/2);
END;
   PUT BASE= TOP= POINT=;
DO N=MAX(1,POINT-1) TO MIN(NOBS,POINT+1);
   SET LIBR.ISBNINDX POINT=N;
   IF ISBN NE "&ISBN" THEN CONTINUE;
   OUTPUT;
   LEAVE;
END;
STOP;
RUN;



*-------------------------------------------------------;
* Title: MODIFY
* Description: Update the article description file of the
* DIY shop with a modify statement and an index.
* Input data set: ART_DES ART_UPD
* Chapter: 16
* Figure: 16.4
*-------------------------------------------------------;
LIBNAME GEN '.GENERAL.SASLIB';
DATA ART_DES(INDEX=(ART_NBR));
   SET GEN.ART_DES;
   OUTPUT;
RUN;
DATA ART_DES;
   MODIFY ART_DES GEN.ART_UPD;
   BY ART_NBR;
   IF _IORC_=%SYSRC(_DSENMR) THEN OUTPUT;
   IF _IORC_=0 THEN REPLACE;
RUN;
PROC PRINT;
RUN;




*-------------------------------------------------------;
* Title: DIYREPT
* Description: Create report about order of DIY shop with
* PROC REPORT.
* Input data set: ORDER
* Chapter: 17
* Figure: 17.25
*-------------------------------------------------------;
LIBNAME GEN '.GENERAL.SASLIB';
PROC REPORT LS=75         SPLIT="/" CENTER DATA=GEN.ORDER;
COLUMN  ART_CAT ART_NBR DESCRIPT QUANTITY PRICE PR_INC AMNT_EX AMNT_IN;

DEFINE  ART_CAT / ORDER FORMAT= $8. WIDTH=8   SPACING=2   LEFT "Departm."
;
DEFINE  ART_NBR / ORDER FORMAT= BEST9. WIDTH=9   SPACING=2   RIGHT
"ART_NBR" ;
DEFINE  DESCRIPT / DISPLAY FORMAT= $10. WIDTH=10  SPACING=2   LEFT
"Descript." ;
DEFINE  QUANTITY / DISPLAY FORMAT= BEST6. WIDTH=6   SPACING=2   RIGHT
"Quant." ;
DEFINE  PRICE / DISPLAY FORMAT= 6.2 WIDTH=6   SPACING=2   RIGHT
"Price ex VAT" ;
DEFINE  PR_INC / COMPUTED FORMAT= 7.2 WIDTH=7   SPACING=2   RIGHT
"Price inc VAT" ;
DEFINE  AMNT_EX / COMPUTED FORMAT= 7.2 WIDTH=7   SPACING=2   RIGHT
"Amount ex VAT" ;
DEFINE  AMNT_IN / COMPUTED FORMAT= 7.2 WIDTH=7   SPACING=2   RIGHT
"Amount inc VAT" ;

COMPUTE  PR_INC;
IF PRICE NE . THEN PR_INC = ROUND(PRICE * 1.175,0.01);
ENDCOMP;

COMPUTE  AMNT_EX;
IF QUANTITY NE . THEN DO;
AMNT_EX = QUANTITY * PRICE;
TOT_EX = SUM(TOT_EX,AMNT_EX);
END;
ENDCOMP;

COMPUTE  AMNT_IN;
IF QUANTITY NE . THEN DO;
AMNT_IN = QUANTITY * PR_INC;
TOT_IN = SUM(TOT_IN,AMNT_IN);
ORD_AMNT + AMNT_IN;
N+1;
END;
ENDCOMP;

BREAK AFTER ART_CAT / SKIP ;
BREAK BEFORE ART_CAT / SUPPRESS ;

COMPUTE AFTER ART_CAT ;
LINE @1 8*'-' 50*' ' 7*'-' '  ' 7*'-';
LINE @1 ART_CAT $8. @59 TOT_EX 7.2 @68 TOT_IN 7.2;
ENDCOMP;

COMPUTE BEFORE ART_CAT ;
TOT_EX = 0;
TOT_IN = 0;
ENDCOMP;

RBREAK AFTER / ;

COMPUTE AFTER;
  LINE 72*'=';
  LINE 'Total items ordered:' +1 N 3.;
  LINE 'Total order amount incl. VAT:' +1 ORD_AMNT 7.2;
  LINE 72*'=';
ENDCOMP;



*-------------------------------------------------------;
* Title: COPGM
* Description: PROC REPORT analysis of occupancy of checkouts
* Input data set: REG
* Chapter: 17
* Figure: 17.32
*-------------------------------------------------------;
LIBNAME GEN '.GENERAL.SASLIB';
PROC REPORT LS=76  PS=24  SPLIT="/" CENTER DATA=GEN.REG;
COLUMN  TIME ( CHECKOUT,( DURATION ) );

DEFINE  TIME / GROUP FORMAT= hour3. WIDTH=3
        SPACING=0 RIGHT "TIME" ;
DEFINE  CHECKOUT / ACROSS FORMAT= BEST5. WIDTH=5
        SPACING=1 RIGHT "CHECKOUT" ;
DEFINE  DURATION / SUM FORMAT= MMSS5. WIDTH=5
        SPACING=2 RIGHT "Durat" ;



*-------------------------------------------------------;
* Title: FMTLIB
* Description: Print the contents of user-defined formats
* Input data set: FORMATS catalog
* Chapter: 18
* Figure: 18.2
*-------------------------------------------------------;
LIBNAME GEN '.GENERAL.SASLIB';
PROC FORMAT LIB=GEN FMTLIB;
SELECT AGEGRP EXCEPT CREDIT FEVER PHONE;
PROC FORMAT CNTLOUT=TEST LIB=GEN;
SELECT AGEGRP;
RUN;
PROC PRINT;
RUN;



*-------------------------------------------------------;
* Title: EX18N2
* Description: PROC TRANSPOSE for separation between
* data storage and data presentation
* Input data set: PROJECT
* Chapter: 18
* Exercise: 18.2
*-------------------------------------------------------;

LIBNAME PROJ '.GENERAL.SASLIB';
PROC SORT DATA=PROJ.PROJECT OUT=PROJECT;
   BY PROJECT;
DATA INTERIM(DROP=TOT);
   SET;
   BY PROJECT;
   OUTPUT; * Write the original observation;
   IF FIRST.PROJECT THEN TOT=0;
   TOT + WEEKS;
   IF LAST.PROJECT THEN DO;
      WEEKS=TOT;
      DEPT='TOT';
      OUTPUT; * Write extra observation with total;
   END;
PROC TRANSPOSE;
   BY PROJECT;
   VAR WEEKS;
   ID DEPT;
PROC PRINT;
   VAR PROJECT A B C D TOT;



*-------------------------------------------------------;
* Title: TRANSPOS
* Description: Create a distance table
* Input data set: none
* Chapter: 18
* Figure: 18.6
*-------------------------------------------------------;
DATA DISTANCE;
INPUT FROM $15. TO  $15. MILE;
CARDS;
NEW YORK       TORONTO        495
NEW YORK       BOSTON         215
BOSTON         TORONTO        582
WASHINGTON     NEW YORK       236
WASHINGTON     BOSTON         443
WASHINGTON     TORONTO        494
RUN;
PROC PRINT;
TITLE 'INPUT DISTANCE TABLE';
RUN;
DATA EXPAND(DROP=TEMP);
   SET DISTANCE;
   * FIRST WRITE THE ORIGINAL OBSERVATION;
   OUTPUT;
   * EXCHANGE FROM AND TO, USING A TEMPORARY VARIABLE;
   TEMP = FROM;
   FROM = TO;
   TO = TEMP;
   OUTPUT;
   * GENERATE OBSERVATION TO ITSELF;
   TO = FROM;
   MILE=.;
   OUTPUT;
   FROM = TEMP;
   TO = TEMP;
   OUTPUT;
RUN;
PROC PRINT;
TITLE 'INTERMEDIATE RESULT AFTER EXPANSION';
RUN;
PROC SORT NODUPLICATES;
BY FROM TO;
PROC TRANSPOSE OUT=TABLE(DROP=_NAME_);
  ID TO;
  IDLABEL TO;
  VAR MILE;
  BY FROM;
RUN;
PROC PRINT LABEL NOOBS SPLIT='*';
TITLE 'FINAL RESULT';
RUN;



*-------------------------------------------------------;
* Title: COMPARE
* Description: Compare two data sets and report differences
* Input data set: ART_DES NART_DES
* Chapter: 18
* Figure: 18.8
*-------------------------------------------------------;
LIBNAME GEN '.GENERAL.SASLIB';
PROC COMPARE DATA=GEN.ART_DES COMPARE=GEN.NART_DES OUT=DIFFER;
ID ART_NBR;
RUN;
PROC PRINT;



*-------------------------------------------------------;
* Title: DATAVIEW
* Description: Create DATA  step VIEW to read TSV input file
* Input data set: TSVFILE.DAT (sequential TSV file)
* Chapter: 18
* Figure: 18.11
*-------------------------------------------------------;

DATA VERTICAL(KEEP=PRODUCT COUNTRY MONTH TARGET)/VIEW=VERTICAL;
* Define some variables and attributes;
LENGTH PRODUCT $8 COUNTRY $2;
ARRAY PERIOD {24} _TEMPORARY_;
RETAIN PERIOD;
FORMAT MONTH MONYY.;
* TAB separated file, therefore delimiter option;
INFILE EXCEL DELIMITER='05'x MISSOVER;
* First line contains the periods;
IF _N_ = 1 THEN
   INPUT DUMMY1 $ DUMMY2 $
         PERIOD{ 1}:MONYY. PERIOD{ 2}:MONYY. PERIOD{ 3}:MONYY.
         PERIOD{ 4}:MONYY. PERIOD{ 5}:MONYY. PERIOD{ 6}:MONYY.
         PERIOD{ 7}:MONYY. PERIOD{ 8}:MONYY. PERIOD{ 9}:MONYY.
         PERIOD{10}:MONYY. PERIOD{11}:MONYY. PERIOD{12}:MONYY.
         PERIOD{13}:MONYY. PERIOD{14}:MONYY. PERIOD{15}:MONYY.
         PERIOD{16}:MONYY. PERIOD{17}:MONYY. PERIOD{18}:MONYY.
         PERIOD{19}:MONYY. PERIOD{20}:MONYY. PERIOD{21}:MONYY.
         PERIOD{22}:MONYY. PERIOD{23}:MONYY. PERIOD{24}:MONYY.
         ;
* Next lines contain the product country and target;
ELSE DO;
   INPUT PRODUCT COUNTRY @;
   DO N=3 TO 26;
      IF PERIOD {N-2} NE . THEN DO;
        MONTH = PERIOD{N-2};
        INPUT TARGET @ ;
        OUTPUT;
      END;
      ELSE LEAVE;
   END;
END;
RUN;

FILENAME EXCEL 'TSVFILE.DAT';
PROC PRINT DATA=VERTICAL;
RUN;



*-------------------------------------------------------;
* Title: EX18N2
* Description: PROC TRANSPOSE for separation between
* data storage and data presentation
* Input data set: PROJECT
* Chapter: 18
* Exercise: 18.2
*-------------------------------------------------------;

LIBNAME PROJ '.GENERAL.SASLIB';
PROC SORT DATA=PROJ.PROJECT OUT=PROJECT;
   BY PROJECT;
DATA INTERIM(DROP=TOT);
   SET;
   BY PROJECT;
   OUTPUT; * Write the original observation;
   IF FIRST.PROJECT THEN TOT=0;
   TOT + WEEKS;
   IF LAST.PROJECT THEN DO;
      WEEKS=TOT;
      DEPT='TOT';
      OUTPUT; * Write extra observation with total;
   END;
PROC TRANSPOSE;
   BY PROJECT;
   VAR WEEKS;
   ID DEPT;
PROC PRINT;
   VAR PROJECT A B C D TOT;



*-------------------------------------------------------;
* Title: FSBROWSE
* Description: Print observations according to FSBROWSE
* screen lay-out
* Input data set: HOUSES
* Chapter: 19
* Figure: 19.8
*-------------------------------------------------------;
* Allocate library and temporary file;
* The form '&TEMP' is an IBM/MVS form;
LIBNAME GEN '.GENERAL.SASLIB';
FILENAME TEMP '&TEMP';
* Send output to the temporary file;
PROC PRINTTO PRINT=TEMP;
RUN;
* Print the screens left aligned in the file;
OPTIONS NOCENTER;
PROC FSBROWSE DATA=GEN.HOUSES
              SCREEN=GEN.SCREEN.HOUSES
              PRINTALL;
RUN;
* Reset output routing;
PROC PRINTTO;
RUN;
 * Reset pagenumber to 1;
OPTIONS PAGENO=1;
* Read the temporary file back in and print;
DATA  _NULL_;
        INFILE TEMP LENGTH=L;
        FILE   PRINT N=PS;
        * First a dummy INPUT statement to determine;
        * the length of the record;
        INPUT @;
        * Position 1 contains the printer control character;
        * The actual line starts at position 2 and is L-1 long;
        L = L-1;
        INPUT @1 N_PAGE 1. @2 LINE $VARYING65. L;
        * With ANSI printer control a 1 in the first;
        * position of a line means start of a new page;
        IF N_PAGE THEN DO;
                PAGENBR + 1;
                N=0;
                * The 5th output page will initiate a new page;
                IF PAGENBR = 5 THEN DO;
                        PUT _PAGE_;
                        PAGENBR=1;
                END;
                RETURN;
        END;
        N+1;
        * Page 1 and 3 are in the top half;
        * Page 2 and 4 are in the lower half.
        * The MOD function shifts the row pointer 25 lines;
        ROW = MOD(PAGENBR+1,2)*25 + N;
        * For page 3 and 4 the column pointer should shift;
        * to position 65;
        COLUMN = (PAGENBR GE 3)*65 + 1;
        PUT #ROW @COLUMN LINE $CHAR65. @;
RUN;



*-------------------------------------------------------;
* Title: GPLOT
* Description: Plot with more plotlines and legend
* Input data set: BANKNOTE
* Chapter: 20
* Figure: 20.10
*-------------------------------------------------------;
LIBNAME GEN '.GENERAL.SASLIB';
PROC GPLOT DATA=GEN.BANKNOTE;
   PLOT QUANTITY*YEAR=BILL/
        HAXIS=AXIS1 LEGEND=LEGEND1;
   SYMBOL1 I=JOIN V=NONE L=2 C=BLACK;
   SYMBOL2 I=JOIN V=NONE L=14 C=BLACK;
   SYMBOL3 I=JOIN V=NONE L=33 C=BLACK;
   SYMBOL4 I=JOIN V=NONE L=8 C=BLACK;
   SYMBOL5 I=JOIN V=NONE L=43 C=BLACK;
   SYMBOL6 I=JOIN V=NONE L=3 C=BLACK;
   SYMBOL7 I=JOIN V=NONE L=1 C=BLACK;
   AXIS1 VALUE=(A=45 F=SIMPLEX H=.8) LABEL=NONE
         ORDER=(1976 TO 1992 BY 2);
   LEGEND1 LABEL=(F=SCRIPT H=1.3 J=C "Quantity"
           J=C "in millions") ACROSS=4 DOWN=2 FRAME;
   TITLE F=SCRIPT H=1.5
      "Banknote circulation in the Netherlands";




*-------------------------------------------------------;
* Title: GCHART
* Description: VBAR charts about share of banknotes
* Input data set: BANKNOTE
* Chapter: 20
* Figure: 20.13
*-------------------------------------------------------;
LIBNAME GEN '.GENERAL.SASLIB';
PROC GCHART DATA=GEN.BANKNOTE(WHERE=(YEAR > 1980));
   VBAR YEAR / SUMVAR = AMOUNT
      SUBGROUP=BILL DISCRETE;
   PATTERN1 C=BLACK V=EMPTY;
   PATTERN2 C=BLACK V=SOLID;
   PATTERN3 C=BLACK V=L1;
   PATTERN4 C=BLACK V=R3;
   PATTERN5 C=BLACK V=X3;
   PATTERN6 C=BLACK V=R5;
   PATTERN7 C=BLACK V=L4;
RUN;



*-------------------------------------------------------;
* Title: GPIECHRT
* Description: PIEchart with EXPLODE and PATTERNs
* Input data set: BANKNOTE
* Chapter: 20
* Figure: 20.15
*-------------------------------------------------------;
LIBNAME GEN '.GENERAL.SASLIB';
PROC GCHART DATA=GEN.BANKNOTE(WHERE=(YEAR=1991));
   PIE BILL/SUMVAR=AMOUNT DISCRETE
       OTHER=0 EXPLODE=5 250 SLICE=ARROW
       NOHEADING VALUE=NONE;
   PATTERN1 C=BLACK V=SOLID;
   PATTERN2 C=BLACK V=EMPTY;
   PATTERN3 C=BLACK V=P1N0;
   PATTERN4 C=BLACK V=P3N30;
   PATTERN5 C=BLACK V=P3X0;
   PATTERN6 C=BLACK V=P5N90;
   PATTERN7 C=BLACK V=P4N150;
RUN;



*-------------------------------------------------------;
* Title: EX4N1
* Description: Exercise chapter 4 nr. 1
* Input data set: input file  SOURCE.DAT
* Chapter: 20
* Figure: 20.20
*-------------------------------------------------------;
FILENAME F1 'SOURCE.DAT';
* PART A;
DATA SALES;
   INFILE F1;
   INPUT @1 SALESREP $15. @16 DEPT $8.
         @24 PRICE 6.;

* PART B;
PROC PRINT;

* PART C;
PROC PRINT;
   ID SALESREP;
   VAR PRICE;

* PART D;
PROC SORT;
   BY SALESREP DESCENDING PRICE;
PROC PRINT;
   BY SALESREP;

* PART E;
PROC CONTENTS DATA=SALES;



*-------------------------------------------------------;
* Title: ANNOTATE
* Description: Creating pictures with ANNOTATEs
* Input data set: none
* Chapter: 20
* Figure: 20.20
*-------------------------------------------------------;

DATA ANNOSET;
   * define the environment;
   LENGTH FUNCTION COLOR $8;
   LENGTH XSYS YSYS HSYS $1;
   XSYS='3';              * cošrdinates in % of screen;
   YSYS='3';              * 0,0 (bottomleft) - 100,100;
   HSYS='3';              * al other measures also on ;
                          * this scale;

   FUNCTION='MOVE';       * move hot spot ;
   X=50;Y=50;             * centre of circle;
   OUTPUT;

   FUNCTION='PIE';        * draw circle segment;
   ANGLE=0;               * start angle;
   ROTATE=360;            * rotation angle - whole circle;
   SIZE=40;               * radius;
   LINE=0;                * draw arc only;
   COLOR='GREEN';
   OUTPUT;

   FUNCTION='MOVE';       * move hot spot;
   X=25;Y=25;             * bottomleft corner of rectangle;
   OUTPUT;

   FUNCTION='DRAW';       * draw line to next X,Y;
   SIZE=1;                * line size;
   LINE=1;                * straight line;
   COLOR='RED';
   X=75;                  * Y remains unchanged (25);
   OUTPUT;                * bottom;
   Y=75;                  * X remains unchanged (75);
   OUTPUT;                * right side;
   X=25;                  * Y remains unchanged (75);
   OUTPUT;                * top;
   Y=25;                  * back to where we started;
   OUTPUT;                * rectangle complete;

   FUNCTION='LABEL';      * write the text;
   X=50;Y=50;             * start coordinates;
   STYLE='TITALIC';       * font;
   SIZE=8;                * character size;
   TEXT='Label text';     * on default position centered;
   COLOR='BLUE';          * at "hot spot";
   OUTPUT;
RUN;
PROC GANNO ANNO=ANNOSET;
RUN;



*-------------------------------------------------------;
* Title: GPLOTANN
* Description: Combining GPLOT with ANNOTATE
* Input data set: BANKNOTE
* Chapter: 20
* Figure: 20.24
*-------------------------------------------------------;

LIBNAME GEN '.GENERAL.SASLIB'         ;
GOPTIONS ROTATE BORDER HSIZE=10 VSIZE=6.7;
DATA BANKNOTE;
SET GEN.BANKNOTE;
QUANTITY=QUANTITY/1000000; * COUNT IN MILLIONS;
RUN;
DATA ANNO;
SET BANKNOTE;
BY BILL NOTSORTED;
IF _N_=1 THEN DO;
   %DCLANNO
   %SYSTEM(2,2,4)
END;
IF LAST.BILL THEN DO;
   SELECT (BILL);
     WHEN (5) DO;
  %LABEL(YEAR,QUANTITY,LEFT(PUT(BILL,4.)),BLACK,0,0,.7,TRIPLEX,9)
     END;

     WHEN (10) DO;
   %LABEL(YEAR,QUANTITY,LEFT(PUT(BILL,4.)),BLACK,0,0,.7,TRIPLEX,3)
     END;

     WHEN (25) DO;
   %LABEL(YEAR,QUANTITY,LEFT(PUT(BILL,4.)),BLACK,0,0,.7,TRIPLEX,6)
     END;

     WHEN (50) DO;
   %LABEL(YEAR,QUANTITY,LEFT(PUT(BILL,4.)),BLACK,0,0,.7,TRIPLEX,6)
     END;

     WHEN (100) DO;
   %LABEL(YEAR,QUANTITY,LEFT(PUT(BILL,4.)),BLACK,0,0,.7,TRIPLEX,6)
     END;

  WHEN (250) DO;
   %LABEL(YEAR,QUANTITY,LEFT(PUT(BILL,4.)),BLACK,0,0,.7,TRIPLEX,3)
     END;

     WHEN (1000) DO;
   %LABEL(YEAR,QUANTITY,LEFT(PUT(BILL,4.)),BLACK,0,0,.7,TRIPLEX,6)
     END;
  END;
END;
RUN;
PROC PRINT;
PROC GPLOT DATA=BANKNOTE ANNO=ANNO;
PLOT QUANTITY*YEAR=BILL  /HAXIS = AXIS1 NOLEGEND;
TITLE1 F=TRIPLEX H=1.5  'BANKNOTE CIRCULATION IN THE NETHERLANDS';
TITLE2 F=TRIPLEX H=1   'Quantity in millions';
SYMBOL1 I=JOIN V=NONE L=2  C=BLACK;
SYMBOL2 I=JOIN V=NONE L=14 C=BLACK;
SYMBOL3 I=JOIN V=NONE L=33 C=BLACK;
SYMBOL4 I=JOIN V=NONE L=8  C=BLACK;
SYMBOL5 I=JOIN V=NONE L=43 C=BLACK;
SYMBOL6 I=JOIN V=NONE L=3  C=BLACK;
SYMBOL7 I=JOIN V=NONE L=1  C=BLACK;
AXIS  VALUE=(A=45 F=SIMPLEX H=.8) ORDER=(1976 TO 1992 BY 2)
      LABEL=NONE;
RUN;
QUIT;



*-------------------------------------------------------;
* Title: BINSRCHM.SAS
* Description: Binary search macro on multiple key variables
* Input data set: none
* Chapter: Appendix E
*-------------------------------------------------------;
%MACRO BINSET(SET=,VAR=,KEY=,OUTPUT=YES);
   BASE=1;
   TOP=N_OBS;
   DROP BASE TOP;
   DO WHILE (TOP-BASE GE 2);
      POINTER=INT((TOP+BASE)/2);
      SET &SET POINT=POINTER NOBS=N_OBS;

      %LET NVAR=1;
      %DO %WHILE (%SCAN(&VAR,&NVAR,%STR( )) NE );
      SELECT;
         WHEN (
            %SCAN(&VAR,&NVAR,%STR( )) LT
            %SCAN(&KEY,&NVAR,%STR( ))
              ) BASE=POINTER+1;
         WHEN (
            %SCAN(&VAR,&NVAR,%STR( )) GT
            %SCAN(&KEY,&NVAR,%STR( ))
              ) TOP=POINTER-1;
         OTHERWISE DO;
         %LET NVAR=%EVAL(&NVAR+1);
      %END;

      TOP=BASE;

      %DO N=1 %TO ((&NVAR-1)*2);
         END;
      %END;

      END;

   DO UNTIL (
      %DO N=1 %TO %EVAL(&NVAR-1);
         %SCAN(&VAR,&N,%STR( )) NE
         %SCAN(&KEY,&N,%STR( ))  OR
      %END;
      POINTER=0
      );

      POINTER + (-1);
      IF POINTER GT 0 THEN
         SET &SET  POINT=POINTER;
   END;

   POINTER+1;

   DO UNTIL (
      %DO N=1 %TO %EVAL(&NVAR-1);
         %SCAN(&VAR,&N,%STR( )) NE
         %SCAN(&KEY,&N,%STR( )) OR
      %END;
      POINTER GT N_OBS
      );
      SET &SET POINT=POINTER;

      IF
         %DO N=1 %TO %EVAL(&NVAR-1);
            %SCAN(&VAR,&N,%STR( )) =
            %SCAN(&KEY,&N,%STR( ))
            %IF &N LE &NVAR-2 %THEN AND;
         %END;
         THEN DO;

            LINK TAIL;
            %IF %UPCASE(&OUTPUT)=YES %THEN
               OUTPUT %STR(;);

         END;
      POINTER+1;
   END;
   STOP;
   RETURN;
   TAIL:

%MEND BINSET;



*-------------------------------------------------------;
* Title: ISOYRWK.SAS
* Description: Macro to calculate ISO week numbers
* Input data set: none
* Chapter: Appendix F
*-------------------------------------------------------;
%MACRO ISOYRWK( DATE, SEP );
%IF &SEP EQ %STR() %THEN %LET SEP= '/' ;

PUT( YEAR(&DATE)
     -
     (INTNX( 'WEEK1.2',
             INTNX('WEEK1.6', MDY(1,1,YEAR(&DATE)),0),
             1) GT &DATE)
     +
     (INTNX( 'WEEK1.2',
             INTNX('WEEK1.6', MDY(1,1,YEAR(&DATE)+1),0),
             1) LE &DATE)
     , 4.)

|| &SEP ||

PUT(
   (INTNX( 'WEEK1.2',
           INTNX('WEEK1.6', MDY(1,1,YEAR(&DATE)),0),
           1) GT &DATE)
   *
   INTCK( 'WEEK1.2',
          INTNX( 'WEEK1.2',
                 INTNX('WEEK1.6',MDY(1,1,YEAR(&DATE)-1),0),
                 1),
          &DATE)
   +
   (INTNX( 'WEEK1.2',
           INTNX('WEEK1.6', MDY(1,1,YEAR(&DATE)),0),
           1) LE &DATE)
   *
   INTCK( 'WEEK1.2',
          INTNX( 'WEEK1.2',
                  INTNX('WEEK1.6',MDY(1,1,YEAR(&DATE)),0),
                  1),
          &DATE)
   -
   (INTNX( 'WEEK1.2',
           INTNX('WEEK1.6', MDY(1,1,YEAR(&DATE)+1),0),
           1) LE &DATE)
   * 52
+1,
Z2.)
%MEND ;



*-------------------------------------------------------;
* Title: TERNARY.SAS
* Description: Macros to create ternary diagrams
* Input data set: none
* Chapter: Appendix G
* Figure: -
*-------------------------------------------------------;
%MACRO TERNARY(SIZE,STEP);
%IF &STEP NE %THEN %LET STEP=%EVAL(100/&STEP);
             %ELSE %LET STEP=10;

LENGTH FUNCTION COLOR STYLE $8;
LENGTH XSYS YSYS HSYS WHEN POS $1;
XSYS='5'; YSYS='5'; HSYS='4'; COLOR='BLACK';
RETAIN XSYS YSYS HSYS COLOR;

GOPTIONS HSIZE=&SIZE VSIZE=&SIZE;
FUNCTION='MOVE'; X=5;Y=5; OUTPUT;  * start at lower left;
FUNCTION='DRAW'; SIZE=1;LINE=1;
X=50;Y=45*SQRT(3)+5;OUTPUT;        * top;
X=95 ;Y=5;OUTPUT;                  * lower right;
X=5;Y=5;OUTPUT;                    * back to lower left;

DO N=&STEP TO 100-&STEP BY &STEP;
M=.45*N; O=M*SQRT(3); L=PUT(N,2.);
FUNCTION='MOVE'; X=5+.9*N; Y=5; OUTPUT;
FUNCTION='DRAW'; X=M+50; Y=45*SQRT(3)-O+5;
   SIZE=1; LINE=2; OUTPUT;
FUNCTION='LABEL'; X=M+52; Y=45*SQRT(3)-O+7;
   ANGLE=-60;ROTATE=0; TEXT=L; POS='2';
   STYLE='SIMPLEX'; SIZE=MIN(1,&STEP/10); OUTPUT;
FUNCTION='MOVE'; X=5+.9*N; Y=5; OUTPUT;
FUNCTION='DRAW'; X=M+5; Y=O+5;SIZE=1; OUTPUT;
FUNCTION='LABEL'; X=95-.9*N; Y=3; ANGLE=0; ROTATE=0;
   SIZE=MIN(1,&STEP/10); OUTPUT;
FUNCTION='MOVE'; X=M+5; Y=O+5; OUTPUT;
FUNCTION='DRAW'; X=95-M; Y=O+5;SIZE=1; OUTPUT;
FUNCTION='LABEL'; X=M+3; Y=O+7; ANGLE=60; ROTATE=0;
   SIZE=MIN(1,&STEP/10); OUTPUT;
END;
%MEND;

%MACRO TERN_X_Y(LEFT,RIGHT,STYLE);
   %IF %UPCASE(&STYLE) EQ BOLD %THEN %DO;
      FUNCTION='PIE'; COLOR='BLACK';
      LINE=0;ROTATE=360;SIZE=.1;STYLE='SOLID';
   %END;
   %ELSE FUNCTION='POINT';
   X=5+.9*(.5*&LEFT+&RIGHT);
   Y=5+.45*&LEFT*SQRT(3);
   OUTPUT;
%MEND;
