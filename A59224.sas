
/*-------------------------------------------------------------------*/
/*        Carpenter's Complete Guide to the SAS Macro Language,      */
/*                         Second Edition                            */
/*                        by Art Carpenter                           */
/*       Copyright(c) 2004 by SAS Institute Inc., Cary, NC, USA      */
/*                   SAS Publications order # 59224                  */
/*                        ISBN 1-58025-239-7                         */
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
/* addressed to the author:                                          */
/*                                                                   */
/* SAS Institute Inc.                                                */
/* Books by Users                                                    */
/* Attn: Art Carpenter                                               */
/* SAS Campus Drive                                                  */
/* Cary, NC   27513                                                  */
/*                                                                   */
/*                                                                   */
/* If you prefer, you can send email to:  sasbbu@sas.com             */
/* Use this for subject field:                                       */
/*     Comments for Art Carpenter                                    */
/*                                                                   */
/*-------------------------------------------------------------------*/
/* Date Last Updated:   02APR04                                      */
/*-------------------------------------------------------------------*/
/*                                                                   */
/* NOTE FROM ART CARPENTER:                                          */
/* This code is for your use, but may not be resold.                 */
/* Not all code from the book has been included in this text file.   */  
/* I have selected only complete macros and program parts that I     */ 
/* think that you are most likely to need. The remaining code should */ 
/* be fairly easy to reconstruct.                                    */
/*                                                                   */
/* In order to facilitate your search for a particular piece of code,*/
/* Sections and Macro names are offset by three asterisks, for       */ 
/* example the macro %EXIST in Section 7.6.1 could be found by       */ 
/* searching for:                                                    */  
/*    ***7.6.1                                                       */
/*    ***%EXIST                                                      */
/* Please note that some macros, such as %EXIST, can be found in     */ 
/* various forms in more than one section of the book.  Consult      */
/* Appendix 4 to determine in which section(s) a given macro can be  */ 
/* found.                                                            */
/*-------------------------------------------------------------------*;


**********************;
***2.6.1
***
**********************;
data old;
do batch=1 to 3;
  conc=2;
  datadate='02jan97'd;
  datatime = '09:00't;
  output;
end;
format datadate mmddyy10. datatime time5.;
run;

data new;
set old;
if batch = 2 then do;
  conc=2.5;
  datadate="&sysdate"d;
  datatime="&systime"t;
end;
run;

proc print data=new;
title1 'Drug concentration';
title2 "Mod date &sysdate";
run;
**********************;


**********************;
***2.6.3
***
**********************;
* Copy the current version of the COMBINE files
* to COMBTEMP;
proc datasets memtype=data;
   copy in=combine out=combtemp;
quit;
%put SYSERR is  &syserr;
**********************;


**********************;
***2.7.1
***
**********************;
%let cln = Beth;
proc sql noprint;
  select count(*)
    into :nobs
      from clinics(where=(clinname=:"&cln"));
  quit;
%put number of clinics for &cln is &nobs; 
**********************;


**********************;
***2.7.2
***
**********************;
data class;
  input @3 name $ 8. grade $1.;
  cards;
  Billy   B
  Jon     C
  Sally   A
  run;

data school;
  input @3 name $ 8. gradcode $1.;
  cards;
  Billy   Y
  Frank   Y
  Jon     N
  Laura   Y
  Sally   Y
  run;

proc sql noprint;
  select quote(name)
    into :clnames separated by ' '
      from class;
  quit;

data clasgrad;
  set school (where=(name in(&clnames))); 
  run;

proc print data=clasgrad;
  title 'Class Graduate Status';
  run;
**********************;


**********************;
***2.10
***
**********************;
**************************************************;
* The data set, SASCLASS.CLINICS, contains 80    *;
* observations and 20 variables.  The following  *;
* program will be used to complete the first     *;
* exercise in this chapter.                      *; 
**************************************************;
PROC PLOT DATA=SASCLASS.CLINICS;
    PLOT EDU * DOB;
    TITLE1 "YEARS OF EDUCATION COMPARED TO BIRTH DATE";
    RUN;

PROC CHART DATA=SASCLASS.CLINICS;
    VBAR WT / SUMVAR=HT TYPE=MEAN;
    TITLE1 "AVERAGE HEIGHT FOR WEIGHT GROUPS";
    RUN;
**********************;

**********************;
***3.1.1
***%LOOK
**********************;
%LET DSN = CLINICS;

%MACRO LOOK;

PROC CONTENTS DATA=&dsn;
  TITLE "DATA SET &dsn";
  RUN;

PROC PRINT DATA=&dsn (OBS=10);
  RUN;

%MEND LOOK;
**********************;


**********************;
***3.4
***%PGM
**********************;
%macro pgm;
   pgm;
   recall;
   zoom on;
%mend pgm;
**********************;


**********************;
***3.5.2
***%ZPGM
**********************;
option cmdmac;

%macro zpgm / cmd;
   pgm;
   recall;
   zoom on;
%mend zpgm;
**********************;


**********************;
***3.8
***
**********************;
*******************************************************;
**** The class data set, CLINICS,  contains 80     ****;
**** observations and 20 variables.  The following ****;
**** program will be used to complete the first two****;
**** exercises in this chapter.                    ****;
*******************************************************;
                    
PROC PLOT DATA=SASCLASS.CLINICS;
   PLOT EDU * DOB;
   TITLE1 'YEARS OF EDUCATION COMPARED TO BIRTH DATE';
   RUN;

PROC CHART DATA=SASCLASS.CLINICS;
   VBAR WT / SUMVAR=HT TYPE=MEAN;
   TITLE1 'AVERAGE HEIGHT FOR WEIGHT GROUPS';
   RUN;
**********************;


**********************;
***4.2.1
***%LOOK
**********************;
%MACRO LOOK(dsn,obs);
   PROC CONTENTS DATA=&dsn;
     TITLE "DATA SET &dsn";
     RUN;

   PROC PRINT DATA=&dsn (OBS=&obs);
     TITLE2 "FIRST &obs OBSERVATIONS";
     RUN;
%MEND LOOK;
%look(sasclass.clinics,10)
**********************;


**********************;
***4.2.2
***%SORTIT version 1
**********************;
%MACRO SORTIT(DSN,BY1,BY2,BY3);
    PROC SORT DATA=&DSN;
      BY &BY1 &BY2 &BY3;
      RUN;
%MEND SORTIT;
**********************;
 

**********************;
***4.2.2
***%SORTIT version 2
**********************;
%MACRO SORTIT(DSN,BYLIST);
    PROC SORT DATA=&DSN;
      BY &BYLIST;
      RUN;
%MEND SORTIT;
**********************;


**********************;
***4.3.1
***%LOOK
**********************;
%MACRO LOOK(dsn=CLINICS,obs=);

    PROC CONTENTS DATA=&dsn;
         TITLE "DATA SET &dsn";
         RUN;

    PROC PRINT DATA=&dsn (OBS=&obs);
         TITLE2 "FIRST &obs OBSERVATIONS";
         RUN;

%MEND LOOK;
**********************;


**********************;
***4.4.2
***%LOOK
**********************;
%MACRO LOOK(dsn,obs=10);
    PROC CONTENTS DATA=&dsn;
         TITLE "DATA SET &dsn";
         RUN;

    PROC PRINT DATA=&dsn (OBS=&obs);
         TITLE2 "FIRST &obs OBSERVATIONS";
         RUN;
%MEND LOOK;
**********************;


**********************;
***4.6
***
**********************;
********************************************************;
**** The class data set, CLINICS, contains 80       ****;
**** observations and 20 variables.  The following  ****;
**** program will be used to complete exercise 3   ****;
**** in this chapter.                               ****;                 
********************************************************;
                    
PROC PLOT DATA=SASCLASS.CLINICS;
        PLOT EDU * DOB;
        TITLE1 'YEARS OF EDUCATION COMPARED TO BIRTH DATE';
   RUN;
                    
PROC CHART DATA=SASCLASS.CLINICS;
        VBAR WT / SUMVAR=HT TYPE=MEAN;
        TITLE1 'AVERAGE HEIGHT FOR WEIGHT GROUPS';
   RUN; 
**********************;         


**********************;
***5.1.1 a
***%DOBOTH
***%LOOK
***%SORTIT
**********************;
%MACRO DOBOTH;
     %SORTIT(CLINICS,LNAME,FNAME)
     %LOOK(OBS=10)
%MEND DOBOTH;

%MACRO LOOK(dsn=CLINICS,obs=);
     PROC CONTENTS DATA=&dsn;
         TITLE "DATA SET &dsn";
         RUN;
     PROC PRINT DATA=&dsn (OBS=&obs);
      TITLE2 "FIRST &obs OBSERVATIONS";
         RUN;
%MEND LOOK;

%MACRO SORTIT(DSN,BY1,BY2,BY3);
     PROC SORT DATA=&DSN;
         BY &BY1 &BY2 &BY3;
         RUN;
%MEND SORTIT;
**********************;


**********************;
***5.1.1 b
***%DOBOTH
***%LOOK
***%SORTIT
**********************;
%MACRO DOBOTH(d,o,b1,b2,b3);
     %SORTIT(&d,&b1,&b2,&b3) 
     %LOOK(&d,&o) 
%MEND DOBOTH;

%MACRO LOOK(dsn,obs);
     PROC CONTENTS DATA=&dsn; 
         TITLE "DATA SET &dsn";
         RUN;
     PROC PRINT DATA=&dsn (OBS=&obs);
         TITLE2 "FIRST &obs OBSERVATIONS";
         RUN;
%MEND LOOK;

%MACRO SORTIT(DSET,BY1,BY2,BY3);
     PROC SORT DATA=&DSET; 
         BY &BY1 &BY2 &BY3;
         RUN;
%MEND SORTIT;
**********************;


**********************;
***5.2.3
***%TESTIN
**********************;
%macro testin(var,varlist);
   %if &var in &varlist %then 
      %put Found |&var| in |&varlist|;
%mend testin;

%testin(aa, aa bb cc) 
%testin(AA, aa bb cc) 
**********************;


**********************;
***5.3.1
***%DOBOTH
**********************;
%MACRO DOBOTH(dsn,obs,by1,by2,by3);

     %IF &BY1 ^= %THEN %DO;
          PROC SORT DATA=&DSN;
               BY &BY1 &BY2 &BY3;
               RUN;
     %END;

     PROC CONTENTS DATA=&dsn;
          TITLE "DATA SET &dsn";
          RUN;

     PROC PRINT DATA=&dsn
     %IF &OBS>0 %THEN %DO;
          (OBS=&obs);
          TITLE2 "FIRST &obs OBSERVATIONS"
     %END;
          ;
          RUN;
%MEND DOBOTH;
**********************;


**********************;
***5.3.2a
***%ALLYEAR
**********************;
%MACRO ALLYR(START,STOP);
     %DO YEAR = &START %TO &STOP;
          DATA TEMP;
               SET YR&YEAR;
               YEAR = 1900 + &YEAR;
          RUN;
          PROC APPEND BASE=ALLYEAR DATA=TEMP;
          RUN;
     %END;
%MEND ALLYR;
**********************;


**********************;
***5.3.2b
***%ALLYEAR
**********************;
%MACRO ALLYR(START,STOP);
   DATA ALLYEAR;
      SET
      %DO YEAR = &START %TO &STOP;
            YR&YEAR(IN=IN&YEAR)
      %END;;

      YEAR = 1900
      %DO YEAR = &START %TO &STOP;
           + (IN&YEAR*&YEAR)
      %END;;

      RUN;
%MEND ALLYR;
**********************;


**********************;
***5.3.3
***%ALLYEAR
**********************;
%MACRO ALLYR(START,STOP);
     %LET CNT = 0;
     %DO %UNTIL(&YEAR >= &STOP);
          %LET YEAR = %EVAL(&CNT + &START);

          DATA TEMP;
               SET YR&YEAR;
               YEAR = 1900 + &YEAR;
          RUN;

          PROC APPEND BASE=ALLYEAR DATA=TEMP;
          RUN;

          %LET CNT = %EVAL(&CNT + 1);
     %END;
%MEND ALLYR;
**********************;


**********************;
***5.3.4
***%ALLYEAR
**********************;
%MACRO ALLYR(START,STOP);
   %LET YEAR = &START;
   %DO %WHILE(&YEAR <= &STOP);

      DATA TEMP;
         SET YR&YEAR;
         YEAR = 1900 + &YEAR;
         RUN;
      PROC APPEND BASE=ALLYEAR DATA=TEMP;
         RUN;

      %LET YEAR = %EVAL(&YEAR + 1);
   %END;
%MEND ALLYR;
**********************;


**********************;
***5.4.2a
***%ONE
***%TWO
**********************;
%let outside = AAA; 

%macro one;
  %global inone; 
  %let inone = BBB;
%mend one;

%macro two;
  %let intwo = CCC; 
%mend two;

%macro last;
  %one %two
  %put &outside &inone &intwo; 
%mend last;

%last
**********************;


**********************;
***5.4.2b
***%OUTSIDE
***%INSIDE
**********************;
%macro outside;
     %let aa = 5;
     %inside(3)
     %put outside &aa;
%mend outside;

%macro inside(aa);
     %put inside &aa;
%mend inside;

%outside
**********************;


**********************;
***5.4.2c
***%OUTSIDE
***%INSIDE
**********************;
%macro inside(var);
      %let bb = &var;
      %put inside &bb;
%mend inside;

%* This LET statement makes &BB global;
%let bb = 5;
%inside(3)
%put outside &bb;
**********************;


**********************;
***5.4.2d
***%INSIDE
**********************;
%macro inside(var);
      %local bb;
      %let bb = &var;
      %put inside &bb;
%mend inside;

%let bb = 5;
%inside(3)
%put outside &bb;
**********************;


**********************;
***5.4.5
***%DSNPROMPT
**********************;
%macro dsnprompt(lib=sasuser);
%* prompt user to for data set name;
%window verdsn color=white  
  #2 @5 "Specify the data set of interest"   
  #3 @5 "for the library &lib" 
  #4 @5 'Enter Name: '
         dsn 20 ATTR=UNDERLINE REQUIRED=YES ;

%display verdsn; 

proc print data=&lib..&dsn;
run;
%mend dsnprompt;

%dsnprompt(lib=sasclass)
**********************;


**********************;
***5.6.9
***
**********************;
%let a = AAA;
%macro try;
%put &a;
%if  &a   =  AAA  %then %put no quotes;
%if '&a'  = 'AAA' %then %put single quotes;
%if 'AAA' = 'AAA' %then %put exact strings;
%if "&a"  = "AAA" %then %put double quotes;
%if "&a"  = 'AAA' %then %put mixed quotes;
%if "&a"  =  AAA  %then %put quotes on one side only;
%mend;
%try
**********************;


**********************;
***6.2.1a
***%LOOK
**********************;
DATA CONTROL;
     DSNAME='CLINICS';
     NOBS='5';
RUN;
%MACRO LOOK;
     DATA _NULL_;
          SET CONTROL;
          CALL SYMPUT('DSN',DSNAME);
          CALL SYMPUT('OBS',NOBS);
     RUN;
     PROC CONTENTS DATA=&DSN;
     RUN;
     PROC PRINT DATA=&DSN (OBS=&OBS);
     RUN;
%MEND LOOK;
**********************;


**********************;
***6.2.1b
***%PLOTIT
**********************;
%MACRO PLOTIT;
   PROC SORT DATA=CLINICS;
     BY REGION;
   RUN;
   * Count the unique regions and create
   * a macro variable for each value.;
   DATA _NULL_;
     SET CLINICS;
     BY REGION;
     IF FIRST.REGION THEN DO; 
        * Count the regions;
        I+1; 
        * Create char var with count (II).  Allow;
        * up to 99 unique regions;
        II=LEFT(PUT(I,2.)); 
        * Assign value of region to a mac var;
        CALL SYMPUT('REG'||II,REGION); 
        CALL SYMPUT('TOTAL',II); 
     END;
  RUN;

* Do a separate PROC GPLOT step for; 
* each unique region;
%DO I=1 %TO &TOTAL; 
  PROC GPLOT DATA=CLINICS;
     PLOT HT * WT;
     WHERE REGION="&&REG&I"; 
     TITLE1 "Height/Weight for REGION &&REG&I"; 
  RUN;
%END;
%MEND PLOTIT;
**********************;


**********************;
***6.2.1c
***%PLOTIT
**********************;
%MACRO PLOTIT;
   PROC SORT DATA=CLINICS 
             OUT=REGCLN(KEEP=REGION) 
             NODUPKEY;
     BY REGION;
   RUN;
   DATA _NULL_;
     SET REGCLN END=EOF;
     * Count the regions;
     I+1;
     * Create char var with count (II);
     II=LEFT(PUT(I,2.));
     CALL SYMPUT('REG'||II,REGION);
     IF EOF THEN CALL SYMPUT('TOTAL',II);
  RUN;
%DO I=1 %TO &TOTAL;
  PROC GPLOT DATA=CLINICS;
     PLOT HT * WT;
     WHERE REGION="&&REG&I";
     TITLE1 "Height/Weight for REGION &&REG&I";
  RUN;
%END;
%MEND PLOTIT;
**********************;


**********************;
***6.2.1d
***%DOIT
**********************;
* 1993 Water quality data.
*************************************************;
data a1
    (keep=datetime station depth temp ph do cond salinity);
input datetime datetime13. @15 station $3.
      depth temp ph do cond salinity;
label datetime = 'date and time of sample collection'
      station  = 'station'
      depth    = 'water depth (ft)'
      temp     = 'temperature (C)'
      ph       = 'pH'
      do       = 'dissolved oxygen'
      cond     = 'conductivity'
      salinity = 'salinity';
format datetime datetime13.;
datalines;
06FEB93:09:15 TS3 0 13.6 7.9 8.8 20.3 12.1
06FEB93:09:15 TS3 1 13.5 7.9 8.7 20.4 12.2
06FEB93:09:15 TS3 2 13.5 7.88 8.7 22.1 13.3
06FEB93:09:15 TS3 3 14.1 8.05 9 46.2 29.9
06FEB93:09:15 TS3 4 14.2 8.05 8.9 48.1 31.3
10FEB93:11:51 TS3 0 13.9 7.91 9.5 0.57 0.27
10FEB93:11:51 TS3 1 13.9 7.89 9.5 0.57 0.27
10FEB93:11:51 TS3 2 13.9 7.88 9.4 0.57 0.27
10FEB93:11:51 TS3 3 13.8 7.88 9.5 0.57 0.27
10FEB93:11:51 TS3 4 13.8 7.87 9.4 0.56 0.27
16FEB93:07:36 TS3 0 12.9 7.86 9.1 8.8 4.9
16FEB93:07:36 TS3 1 12.9 7.85 9 9.3 5.19
16FEB93:07:36 TS3 2 13 7.85 8.8 9.7 5.4316FEB93:07:36 TS3 3 13 7.86 8.8 9.7 5.43
16FEB93:07:36 TS3 4 13 7.85 8.7 9.3 5.19
20FEB93:09:08 TS3 0 13.1 7.99 9.9 0.78 0.38
20FEB93:09:08 TS3 1 13.1 7.99 9.9 0.78 0.38
20FEB93:09:08 TS3 2 13.1 7.99 9.9 0.76 0.37
20FEB93:09:08 TS3 3 13.1 7.98 9.8 0.76 0.37
20FEB93:09:08 TS3 4 13.1 7.97 9.8 0.75 0.36
02MAR93:12:31 TS3 0 14.9 8.03 10.1 0.83 0.41
02MAR93:12:31 TS3 1 14.9 8.03 10.1 0.83 0.41
02MAR93:12:31 TS3 2 14.9 8.01 10.1 0.82 0.41
02MAR93:12:31 TS3 3 14.9 8.01 10 0.82 0.41
02MAR93:12:31 TS3 4 14.9 8.02 10 0.8 0.39
02MAR93:12:31 TS3 5 14.9 8.02 10 0.8 0.39
07MAR93:08:56 TS3 0 14.4 7.92 8.6 11 6.22
07MAR93:08:56 TS3 1 14.3 7.92 8.7 11 6.22
07MAR93:08:56 TS3 2 14.3 7.92 8.7 11.5 6.53
07MAR93:08:56 TS3 3 14.3 7.91 8.7 11.2 6.35
07MAR93:08:56 TS3 4 14.3 7.9 8.8 11.2 6.35
07MAR93:08:56 TS3 5 14.5 8.06 8.8 36.4 23
15MAR93:14:20 TS3 0 19.7 8.35 10.9 1.3 0.65
15MAR93:14:20 TS3 1 19.6 8.33 10.9 1.28 0.64
15MAR93:14:20 TS3 2 19.6 8.34 11.1 1.3 0.65
15MAR93:14:20 TS3 3 19.6 8.34 11.4 1.3 0.65
15MAR93:14:20 TS3 4 19.7 8.33 11.6 1.43 0.71
27MAR93:13:40 TS3 0 16.9 8.4 9.5 0.85 0.42
27MAR93:13:40 TS3 1 16.9 8.39 9.4 0.85 0.42
27MAR93:13:40 TS3 2 16.9 8.39 9.4 0.85 0.42
27MAR93:13:40 TS3 3 16.9 8.38 9.4 0.83 0.41
27MAR93:13:40 TS3 4 16.9 8.38 9.4 0.84 0.41
27MAR93:13:40 TS3 5 16.9 8.36 9.4 0.84 0.41
01APR93:11:03 TS3 0 19 8.42 10 1.44 0.7
01APR93:11:03 TS3 2 19 8.41 9.9 1.44 0.7
01APR93:11:03 TS3 4 18.9 8.4 9.8 1.41 0.7
01APR93:11:03 TS3 6 18.8 8.39 9.6 1.42 0.7
03APR93:06:22 TS3 0 15.2 7.88 7.9 16.2 9.5
03APR93:06:22 TS3 1 15.2 7.88 7.7 17.1 10
03APR93:06:22 TS3 2 15.2 8.01 8.4 49.2 32.1
03APR93:06:22 TS3 3 15.2 8.03 8.3 50.9 33.4
03APR93:06:22 TS3 4 15.2 8.03 8.3 50.8 33.3
03APR93:06:22 TS3 5 15.2 8.03 8.3 50.5 33.1
06APR93:09:00 TS3 0 15.7 . 8.4 51.4 33.8
06APR93:09:00 TS3 2 15.6 8.14 . 51.5 33.8
06APR93:09:00 TS3 4 . 8.12 . . .
06APR93:09:00 TS3 6 15.6 8.11 8.1 . .
07APR93:09:15 TS3 0 17.1 8.16 8.8 49.8 32.6
07APR93:09:15 TS3 2 17.1 8.16 8.6 49.8 32.6
07APR93:09:15 TS3 4 17.1 8.15 8.6 49.7 32.5
07APR93:09:15 TS3 6 17.1 8.14 8.5 49.8 32.6
22APR93:10:20 TS3 0 17.1 8.22 8.6 48.5 31.6
22APR93:10:20 TS3 2 17.1 8.2 8.6 48.5 31.6
22APR93:10:20 TS3 4 17 8.19 8.5 48.5 31.6
22APR93:10:20 TS3 6 17 8.15 8.1 48.5 31.6
24APR93:12:06 TS3 0 18.8 8.1 8.3 45.5 29.5
24APR93:12:06 TS3 2 18.8 8.09 8.1 45.5 29.5
24APR93:12:06 TS3 4 18.8 8.1 8 45.3 29.3
24APR93:12:06 TS3 6 18.8 8.13 7.8 45.5 29.5
29APR93:12:09 TS3 0 21.8 8.07 7.2 28.2 17.3
29APR93:12:09 TS3 1 21.4 8.15 7.7 35.7 22.5
29APR93:12:09 TS3 2 21.2 8.19 7.7 39.7 25.3
29APR93:12:09 TS3 4 20.7 8.17 7.8 41.8 26.8
29APR93:12:09 TS3 5 19.9 8.16 7.2 41.8 26.8
29APR93:12:09 TS3 6 18.8 8.08 5.9 45.3 29.3
05MAY93:09:24 TS3 0 17.7 8.18 7.9 51 33.5
05MAY93:09:24 TS3 2 17.7 8.18 7.9 50.8 33.3
05MAY93:09:24 TS3 4 17.7 8.17 7.8 51 33.5
05MAY93:09:24 TS3 6 17.7 8.17 7.8 50.8 33.3
15MAY93:11:25 TS3 0 19.6 8.11 7.2 42.8 27.5
15MAY93:11:25 TS3 2 19.3 8.13 7.2 44.9 29
15MAY93:11:25 TS3 4 19.2 8.13 7.2 45.8 29.7
15MAY93:11:25 TS3 6 18.5 8.15 7.5 46.8 30.4
23MAY93:12:06 TS3 0 17.4 8.19 7.8 51.3 33.7
23MAY93:12:06 TS3 2 17.3 8.19 7.8 51.2 33.6
23MAY93:12:06 TS3 4 17.3 8.18 7.7 51.1 33.5
23MAY93:12:06 TS3 6 17.3 8.18 7.7 51.2 33.6
01JUN93:12:00 TS3 0 18.9 8.13 8.8 50.7 33.2
01JUN93:12:00 TS3 2 18.8 8.12 8.8 50.8 33.8
01JUN93:12:00 TS3 4 18.8 8.11 8.7 50.7 33.2
01JUN93:12:00 TS3 6 18.7 8.12 8.6 50.7 33.2
03JUN93:20:08 TS3 0 18.6 8.31 8 52.7 34.7
03JUN93:20:08 TS3 2 18.6 8.31 8 52.6 34.6
03JUN93:20:08 TS3 4 18.5 8.3 8 52.6 34.6
03JUN93:20:08 TS3 6 18.5 8.31 8 52.5 34.6
04JUN93:06:02 TS3 0 19.9 8.08 5.1 50.2 32.9
04JUN93:06:02 TS3 2 19.8 8.07 5 50.4 33
04JUN93:06:02 TS3 4 19.9 8.07 5 50.3 32.9
04JUN93:06:02 TS3 6 19.9 8.07 4.9 50.3 32.9
11JUN93:09:50 TS3 0 23 7.92 3.8 51 33.5
11JUN93:09:50 TS3 2 23 7.92 3.8 51.1 33.5
11JUN93:09:50 TS3 4 22.9 7.92 3.8 50.7 33.2
11JUN93:09:50 TS3 6 22.7 7.92 3.7 51.1 33.5
16JUN93:13:03 TS3 0 22.1 8.16 8.5 52.3 34.4
16JUN93:13:03 TS3 2 22 8.15 8.2 52.1 34.3
16JUN93:13:03 TS3 4 22 8.15 8.1 51.9 34.116JUN93:13:03 TS3 6 22 8.15 8.1 51.7 34
06FEB93:09:43 TS6 0 13.9 8.07 8.8 32.5 20.3
06FEB93:09:43 TS6 1 13.9 8.05 8.7 38.1 24.2
06FEB93:09:43 TS6 2 14 8.06 8.6 44.6 28.8
06FEB93:09:43 TS6 3 14.1 8.06 8.4 45.5 29.4
06FEB93:09:43 TS6 4 14.1 8.04 8.6 49.2 32.1
06FEB93:09:43 TS6 5 14.2 8.06 8.7 50.3 32.9
06FEB93:09:43 TS6 6 14.3 8.06 8.7 51.1 33.5
10FEB93:12:22 TS6 0 14.2 7.96 9.5 0.59 0.29
10FEB93:12:22 TS6 1 14.1 7.94 9.4 0.59 0.29
10FEB93:12:22 TS6 2 13.8 7.92 9.2 0.82 0.4
10FEB93:12:22 TS6 3 13.8 7.88 9.1 1.07 0.53
10FEB93:12:22 TS6 4 13.7 7.86 8.8 1.76 0.89
10FEB93:12:22 TS6 5 13.6 7.78 8.4 3.82 2
16FEB93:08:18 TS6 0 13.6 8.32 9.7 3.4 1.77
16FEB93:08:18 TS6 1 13.6 8.26 9.6 4.39 2.33
16FEB93:08:18 TS6 2 13.6 8.2 9.5 5.34 2.87
16FEB93:08:18 TS6 3 13.5 8.08 9.1 7.97 4.4
16FEB93:08:18 TS6 4 13.6 7.86 8.8 15 8.7
20FEB93:09:50 TS6 0 13.4 8.02 9.7 1.08 0.53
20FEB93:09:50 TS6 1 13.3 7.97 9.7 1.06 0.53
20FEB93:09:50 TS6 2 13.2 7.97 9.7 1.1 0.54
20FEB93:09:50 TS6 3 13.4 7.96 9.5 2.83 1.46
20FEB93:09:50 TS6 4 13.5 7.96 9.3 4.56 2.42
20FEB93:09:50 TS6 5 13.8 7.95 9.2 7.25 3.98
20FEB93:09:50 TS6 6 14.8 8.13 8.4 8.8 4.89
20FEB93:09:50 TS6 7 15.2 8.03 7.6 28.2 17.3
20FEB93:09:50 TS6 7.5 15.2 8.02 7.1 30.6 18.9
02MAR93:14:20 TS6 0 16 8.21 10.9 0.89 0.43
02MAR93:14:20 TS6 1 15.9 8.2 10.8 0.87 0.42
02MAR93:14:20 TS6 2 15.9 8.19 10.7 0.87 0.42
02MAR93:14:20 TS6 2.5 15.9 8.19 10.6 0.88 0.43
07MAR93:10:30 TS6 0 16.2 8.08 9.3 7.61 4.18
07MAR93:10:30 TS6 1 15.8 8.11 9.5 11.7 6.65
07MAR93:10:30 TS6 2 15.3 8.14 10 18.3 10.8
07MAR93:10:30 TS6 3 14.9 8.09 10.4 25.6 15.6
07MAR93:10:30 TS6 4 14.6 8.06 10.7 27.2 16.7
07MAR93:10:30 TS6 5 14.5 8.04 10.5 31.4 19.5
15MAR93:16:43 TS6 0 19.2 8.39 . 0.92 0.45
15MAR93:16:43 TS6 1 19.3 8.38 . 0.92 0.45
15MAR93:16:43 TS6 2 19.3 8.38 . 0.94 0.46
15MAR93:16:43 TS6 3 19.3 8.37 . 0.93 0.45
15MAR93:16:43 TS6 3.5 19.4 8.37 . 0.93 0.45
27MAR93:14:57 TS6 0 18 8.6 11.6 3.71 1.95
27MAR93:14:57 TS6 1 17.6 8.67 12.4 4.75 2.54
27MAR93:14:57 TS6 2 17.4 8.59 11.8 9.24 5.2
27MAR93:14:57 TS6 3 17.3 8.6 11.8 9.89 5.6
27MAR93:14:57 TS6 3.5 17.3 8.59 11.9 10.1 5.7
01APR93:13:40 TS6 0 23.9 9.56 23.3 3.85 2
01APR93:13:40 TS6 1 23.9 9.55 23.6 3.82 2
01APR93:13:40 TS6 2 23.9 9.53 23.1 3.75 2
01APR93:13:40 TS6 3 23.9 9.53 23 3.79 2
03APR93:08:03 TS6 0 16.8 8.2 8.7 10.1 5.7
06APR93:11:08 TS6 0 17 8 8.2 25.6 15.6
06APR93:11:08 TS6 1 16.8 8.06 8.3 33.8 21.2
06APR93:11:08 TS6 2 16.4 8.14 9.2 43.1 27.7
06APR93:11:08 TS6 3 16.3 8.16 9.6 44.5 28.7
06APR93:11:08 TS6 4 16.2 8.17 9.7 46 29.8
06APR93:11:08 TS6 5 16.2 8.17 9.8 46 29.8
07APR93:10:49 TS6 0 18 7.88 7.3 7.4 4.1
07APR93:10:49 TS6 1 17.5 8.13 8.1 49 32
07APR93:10:49 TS6 2 17.5 8.13 8.1 48.9 31.9
07APR93:10:49 TS6 3 17.5 8.12 8.1 49.1 32.1
07APR93:10:49 TS6 4 17.5 8.13 8 49.6 32.4
07APR93:10:49 TS6 5 17.5 8.13 8 49.5 32.4
22APR93:11:45 TS6 0 18.7 7.84 8.4 45.5 29.5
22APR93:11:45 TS6 1 18.3 7.82 8.8 47.5 30.9
22APR93:11:45 TS6 2 18.2 7.92 8.7 48.1 31.3
22APR93:11:45 TS6 3 18.2 7.9 8.7 48.1 31.3
22APR93:11:45 TS6 4 18.2 7.97 8.6 48.1 31.3
24APR93:14:05 TS6 0 21.5 8.28 10.2 45.6 29.5
24APR93:14:05 TS6 1 21.5 8.27 9.9 45.4 29.4
24APR93:14:05 TS6 2 21.3 8.28 9.8 45.4 29.4
24APR93:14:05 TS6 3.5 21.3 8.29 9.7 45.6 29.5
29APR93:13:42 TS6 0 25.7 8.22 8.2 40.2 25.7
29APR93:13:42 TS6 1 25.7 8.21 8.1 40.7 26
29APR93:13:42 TS6 2 25.8 8.2 8.1 40.1 25.6
29APR93:13:42 TS6 3 26.1 8.2 8 40.4 25.7
05MAY93:11:03 TS6 0 18.6 8.19 8.2 50.5 33.1
05MAY93:11:03 TS6 2 18.6 8.19 8.2 50.3 32.9
05MAY93:11:03 TS6 4 18.6 8.18 8.2 50.5 33.1
05MAY93:11:03 TS6 5 18.6 8.18 8.1 50.1 32.8
15MAY93:13:54 TS6 0 23.9 8.1 7 46.2 30
15MAY93:13:54 TS6 1 23.9 8.11 7.2 46.3 30
15MAY93:13:54 TS6 2 24 8.15 7.5 47.3 30.8
15MAY93:13:54 TS6 3 24.1 8.16 7.6 47.5 30.9
23MAY93:15:04 TS6 0 19.8 8.2 8.1 51.3 33.7
23MAY93:15:04 TS6 2 19.8 8.2 8.1 51.7 34
23MAY93:15:04 TS6 4 19.8 8.2 8.1 51.1 33.5
01JUN93:14:07 TS6 0 25.5 8.23 7.8 52.9 34.9
01JUN93:14:07 TS6 1 25.3 8.22 7.7 52.6 34.6
01JUN93:14:07 TS6 2 25.5 8.22 7.7 52.7 34.7
01JUN93:14:07 TS6 3 25.5 8.21 7.6 52.7 34.7
03JUN93:21:20 TS6 0 18.5 8.34 7.9 52.9 34.9
03JUN93:21:20 TS6 2 18.5 8.33 7.8 52.9 34.9
03JUN93:21:20 TS6 4 18.5 8.33 7.8 52.9 34.9
03JUN93:21:20 TS6 6 18.5 8.33 7.7 53 34.9
03JUN93:21:20 TS6 8 18.5 8.33 7.6 52.9 34.9
04JUN93:07:20 TS6 0 18.8 8.05 3.6 52.2 34.4
04JUN93:07:20 TS6 1 18.7 8.05 3.6 52.7 34.7
04JUN93:07:20 TS6 2 18.8 8.04 3.5 51.6 33.9
04JUN93:07:20 TS6 3 18.8 8.04 3.4 51.6 33.9
11JUN93:11:42 TS6 0 26.2 8.1 6.3 53 34.9
11JUN93:11:42 TS6 1 26.1 8.1 6.2 53 34.9
11JUN93:11:42 TS6 2 26.1 8.08 6 52.9 34.9
11JUN93:11:42 TS6 3 26.1 8.08 6 53 34.9
16JUN93:15:00 TS6 0 25.9 8.11 8.3 51.6 33.9
16JUN93:15:00 TS6 2 25.8 8.12 8.3 51.3 33.7
16JUN93:15:00 TS6 4 25.6 8.12 8.2 52.1 34.3
run;
proc sort data=a1;
   by station depth;
   run;

%macro doit;

* Create the macro variables.
* One set for each STATION X DEPTH;
data _null_;
set a1;
by station depth;
length ii $1 dd $2 fn $14;
if first.depth then do;
   i+1;
   ii = left(put(i,2.));
   * Create a character value of the numeric depth;
   dd = trim(left(put(depth,3.)));
   * Construct the filename;
   fn = compress(station || dd || '.dat');
   call symput('i',ii);
   call symput('d'||ii,dd);
   call symput('sta'||ii,station);
   call symput('fn'||ii,fn);
end;
run;

* There will be &i files;
%do j=1 %to &i;
   filename toascii "&&fn&j";
  * print the ascii files;
   data _null_;
   set a1;
   where station="&&sta&j" and depth=&&d&j;
   cnt + 1;
   file toascii;
   if cnt=1 then put '**********  ' "&&fn&j";
   put @1 date mmddyy8. @10 aveday;
   run;
%end;
%mend doit;

%doit
**********************;


**********************;
***6.2.2a
***%LOOK
**********************;
DATA CONTROL;
     MVARNAME='DSN';
     VALUE='CLINICS';
     OUTPUT;
     MVARNAME='OBS';
     VALUE='5';
     OUTPUT;
RUN;
%MACRO LOOK;
     DATA _NULL_;
          SET CONTROL;
          CALL SYMPUT(MVARNAME,VALUE);
     RUN;
     PROC CONTENTS DATA=&DSN;
     RUN;
     PROC PRINT DATA=&DSN (OBS=&OBS);
     RUN;
%MEND LOOK;
**********************;


**********************;
***6.2.2b
***%LOOK
**********************;
DATA CONTROL;
     MVARNAME='DSN';
     VALUE='CLINICS';
     OUTPUT;
     MVARNAME='OBS';
     VALUE='5';
     OUTPUT;
RUN;DATA _NULL_;
        SET CONTROL;
        CALL SYMPUT(MVARNAME,VALUE);
RUN;
%MACRO LOOK(DAT,CNT);
        PROC CONTENTS DATA=&&&DAT;
        RUN;
        PROC PRINT DATA=&&&DAT (OBS=&&&CNT);
        RUN;
%MEND LOOK;
%LOOK(DSN,OBS)
**********************;


**********************;
***6.2.2c
***%LISTFAM
**********************;
data relation;
length relation name $8;
family = 'MC24';
relation='mom'; name='Sally'; f_origin='AL06'; output;
relation='dad'; name='Fred';  f_origin='MC22'; output;
relation='son'; name='Clint'; f_origin='MC24'; output;

family = 'MC25';
relation='mom'; name='Jane';      f_origin='BA06'; output;
relation='dad'; name='Clint';     f_origin='MC24'; output;
relation='daughter'; name='Laura';f_origin='MC25'; output;
run;

data reunion;
length mother father son daughter $8;
father='Donald'; mother='Susan'; son='Kyle '; daughter='     '; output;
father='Fred  '; mother='Sally'; son='Clint'; daughter='     '; output;
father='Clint '; mother='Jane '; son='     '; daughter='Laura'; output;
father='Fred  '; mother='Sally'; son='John '; daughter='Rose '; output;
run;


%macro listfam(famcode);
data _null_;
set relation(where=(family="&famcode"));
* Create one macro var for each observation.
* Use RELATION to name the macro var and NAME for its value;
call symput(relation,name);
run;

proc print data=reunion(where=(mother="&mom" & father="&dad"));
title "Same Mother and Father as Family &famcode";
run;


%mend listfam;
%listfam(MC24)
**********************;


**********************;
***6.4.3a
***
**********************;
data demo;
 dname = 'clinics';
 amp   = '&dsn';
 * unquoted arguments;
 a1 = symget(dname);
 a2 = resolve(dname);
 a3 = symget(dsn);
 a4 = resolve(dsn);
 a5 = symget(amp);
 a6 = resolve(amp);
 put / a1= a2= a3= a4= a5= a6=;

 * Using a single quote
 b1 = symget('dname');
 b2 = resolve('dname');
 b3 = symget('dsn');
 b4 = resolve('dsn');
 b5 = symget('amp');
 b6 = resolve('amp');
 put / b1= b2= b3= b4= b5= b6=; 

 * Single quote with &;
 c1 = symget('&dsn');
 c2 = resolve('&dsn');
 c3 = symget('&amp');
 c4 = resolve('&amp');
 put / c1= c2= c3= c4=;

 * Double quote with &;
 d1 = symget("&dsn");
 d2 = resolve("&dsn");
 d3 = symget("&amp");
 d4 = resolve("&amp");
 put / d1= d2= d3= d4=;

 * Quoted triple ampersand;
 e1 = resolve('&&&dsn');
 put / e1= ;
 run;
**********************;


**********************;
***6.4.3b
***
**********************;
%let sumplots=;
data _null_;
   set sashelp.vcatalg(where=(libname='WORK' 
                        and memname='GSEG'
                        and objname =: "HR_KM";  
   call symput('sumplots', 
        trim(resolve('&sumplots'))|| 
                     ' '||trim(objname));  
   run;
**********************;


**********************;
***6.5.1
***
**********************;
%let dsn = sasclass.clinics;
proc sql noprint;
select count(*)
  into :nobs 
    from &dsn; 
quit;
**********************;


**********************;
***6.5.2
***
**********************;
proc sql noprint;
select lname, dob 
   into :lastnames separated by ',', 
   :dobirths separated by ',' 
      from sasclass.clinics(where=(lname=:'S')); 
%let numobs=&sqlobs; 
quit;
%put lastnames are &lastnames;
%put dobirths are &dobirths;
%put number of obs &numobs;
**********************;


**********************;
***6.5.3a
***%VARLIST
**********************;
%macro varlist(dsn);
* Determine the list of variables in this 
* base data set;
proc contents data= &dsn 
              out= cont noprint; 
   run;

* Collect the variable names;
proc sql noprint;
   select distinct name 
      into :varname1-:varname999
         from cont; 
   quit;

%do i = 1 %to &sqlobs; 
   %put &i &&varname&i;
%end;
%mend varlist;

%varlist(sasclass.clinics)
**********************;

**********************;
***6.5.3b
***
**********************;
proc sql noprint;
select distinct clinname, count(*) 
    into :name1-:name999, 
         :cnt1-:cnt999
        from sasclass.clinics 
            group by clinname;
quit;
**********************;


**********************;
***6.5.3c
***
**********************;
proc summary data=sasclass.clinics noprint nway;
   class clinname;
   var dob;
   output out=cnt n=count;
   run;
data _null_;
   set cnt;
   i+1;
   ii=left(put(i,best12.));
   call symput('name'||ii,clinname);
   call symput('cnt'||ii,left(put(_freq_,best12.)));
   call symput('namecnt',ii);
   run;
**********************;


**********************;
***6.5.4
***%VARLIST2
**********************;
%macro varlist2(lib,dsn);

* Collect the variable names;
proc sql noprint;
select distinct name into :varname1-:varname999
   from dictionary.columns 
      where (libname=upcase("&lib") & 
             memname=upcase("&DSN"));
quit;

%do i = 1 %to &sqlobs;
   %put &i &&varname&i;
%end;
%mend varlist2;

%varlist2(sasclass,clinics)
**********************;


**********************;
***6.5.5
***
**********************;
proc sql noprint;
select lname into :lastnames separated by ',' 
   from sasclass.clinics(where=(lname=:'S'));
%let numobs=&sqlobs;
quit;
%put _user_;
**********************;


**********************;
***6.6.2a
***%PUTIT
**********************;
%macro putit(jj);
   %put in putit &jj;
%mend putit;

data a;
do i = 1 to 4;
   call execute('%putit('||i||')');
   put i= '********';
end;
run;
**********************;


**********************;
***6.6.2b
***%PUTIT
**********************;
%macro putit(jj);
%put in putit &jj;
data a&jj;
   x=&jj;
   run;
%mend putit;

data a;
   do i = 1 to 4;
      call execute('%putit('||i||')');
      put i= '********';
   end;
   run;
**********************;


**********************;
***6.6.3
***
**********************;
%macro test;
data _null_;
   put 'calling symput'; 
   call symput('x3',100); 
   run;

%put ready to compile NEW; 

data new;
   %put compiling NEW; 
   put 'executing NEW'; 
   y = &x3; 
   run;

proc print data=new;
   run;
%mend test;

data _null_;
   call execute('%test'); 
   run;
**********************;


**********************;
***7.1.3a
***%EXIST
**********************;
%macro exist(dsn);
%global exist;
%if &dsn ne %then %str(
   data _null_;
   if 0 then set &dsn;
   stop;
   run;
);
%if &syserr=0 %then %let exist=yes;
%else %do;
   %let exist=no;
   %put PREVIOUS ERROR USED TO CHECK FOR PRESENCE ;
   %put OF DATASET & IS NOT A PROBLEM;
%end;
%mend exist;
**********************;


**********************;
***7.1.3b
***
**********************;
data _null_;
   call symput('ttl',"Tom's Truck");
   run;

proc print data=sashelp.class;
title1 "&ttl";
title2 &ttl;
run;

proc print data=sashelp.class;
title1 "%bquote(&ttl)";
title2 %bquote(&ttl);
run;

%macro ppriintit(txt);
proc print data=sashelp.class;
title1 "&txt";
title2 &txt;
run;
%mend pprintit;

%pprintit(&ttl)

%pprintit(%bquote(&ttl))
**********************;


**********************;
***7.1.3c
***%ISITQUOTED
**********************;
%macro isitquoted(var);
   %if &var ne %then %put &var;
%mend isitquoted;
**********************;


**********************;
***7.1.6
***
**********************;
%let city = miami;
%let oth = %nrstr(&city); 
%let unq = %unquote(&oth); 

%put &city &oth &unq;
**********************; 


**********************;
***7.2.1
***
**********************;
%LET SRCH = TALL;
%LET X=LONG TALL SALLEY;
%LET Y=%INDEX(&X,&SRCH);
%PUT &SRCH CAN BE FOUND AT POSITION &Y;
**********************;


**********************;
***7.2.3
***%CNTVAR
**********************;
%Macro cntvar;
     %global cnt;
     %let I = 1;
     %do %until(%scan(&keyfld,&I,%str( ))=%str());
        %global var&I;
        %let var&I = %scan(&keyfld,&I,%str( ));
        %let I = %eval(&I + 1);
     %end;
     %let cnt = %eval(&I-1);
%mend cntvar;
**********************;


**********************;
***7.3.2a
***%CHKWT
**********************;
%macro chkwt(wt1, wt2);
   %if &wt1 > &wt2 %then %let note = heavier;
   %else %let note = lighter;
   %put First weight is &note.  &wt1 &wt2;
%mend chkwt;

%chkwt(1,2)
%chkwt(2,1)
%chkwt(2.1,2.2)
%chkwt(10.0,9.9)
**********************;


**********************;
***7.3.2b
***%wordcnt
**********************;
%macro wordcnt(string);
%local string wcnt;
%* The word count is stored in wcnt;
%let wcnt=0; 
%do %until(%qscan(&string,&wcnt+1,%str( ))=%str());
   %let wcnt=%eval(&wcnt+1);
%end;
&wcnt
%mend wordcnt;

%* example:;
%put count is %wordcnt(aa bb cc);
**********************;


**********************;
***7.3.3
***%FIGUREIT
**********************;
%macro figureit(a,b);
  %let y=%sysevalf(&a+&b);
  %put The result with SYSEVALF is: &y;
  %put  Type BOOLEAN is: %sysevalf(&a +&b, boolean);
  %put  Type CEIL is: %sysevalf(&a +&b, ceil);
  %put  Type FLOOR is: %sysevalf(&a +&b, floor);
  %put  Type INTEGER is: %sysevalf(&a +&b, int);
%mend figureit;

%figureit(100,1.597)
**********************;


**********************;
***7.4.1
***
**********************;
%let seed=9876;
%let rand=0  ;
%put seed is &seed pseudo random number is &rand;
%syscall ranuni(seed,rand);
%put seed is &seed pseudo random number is &rand;
**********************;


**********************;
***7.4.2a
***
**********************;
data _null_;
   today = put(date(),worddate18.);
   call symput('dtnull',today);
   run;

title1 "Using Automatic Macro Variable SYSDATE &sysdate";
title2 "Date from a DATA _NULL_ &dtnull";
title3 "Using SYSFUNC %sysfunc(date(),worddate18.)";
title4 "Using SYSFUNC %sysfunc(left(%qsysfunc(date(),worddate18.)))";
**********************;


**********************;
***7.4.2b
***%DELFILE
**********************;
%macro delfile(filrf);
  %* Establish the fileref;
  %let rc=%sysfunc(filename(filrf,f:\junk\biomass.raw));

  %* Delete the file if it exists;
  %if &rc = 0 and %sysfunc(fexist(&filrf)) %then 
         %let rc=%sysfunc(fdelete(&filrf));
  %else %put File Not Found;

  %* Clear the fileref;
  %let rc=%sysfunc(filename(filrf));
%mend delfile;

%delfile(myfile)
**********************;


**********************;
***7.4.2c
***%ENGCHNG
**********************;
%macro engchng(engine,dsn);
* engine - output engine for this &dsn
* dsn    - name of data set to copy
*;

* Create a libref for the stated Engine;
libname dbmsout clear;
libname dbmsout &engine "%sysfunc(pathname(sasuser))";

* Copy the SAS data set using the alternate engine;
proc datasets;
  copy in=sasuser out=dbmsout;
    select &dsn;
  run;

%mend engchng;

***************************************************;
%engchng(v6,classwt)  * convert to alt. engine;
**********************;


**********************;
***7.4.2d
***%PATTERN
**********************;
%macro pattern(dsn,pievar);
%local g i j nslice;

* Determine the number of unique values of the
* variable that will be used to determine the slices;
proc sql noprint;
select count(distinct &pievar) into :nslice 
   from &dsn;
   run;

%do j = 1 %to &nslice;
   %* Create &nslice pattern statements;
   %let i=%sysevalf(255/(&nslice+1)*&j,floor);  
   %let g=%sysfunc(putn(&i,hex2.)); 
   pattern&j v=psolid c=gray&g r=1; 
%end;
%mend pattern;

data slices;
do slice = 1 to 10;
   output slices;
end;
run;

%pattern(slices,slice)  * set up the pattern statements;

title 'Pie diagram of slices showing gray scale';
footnote;

goptions reset=all border htext=1.5 ftext=simplex;
goptions dev=win;

proc gchart data=slices;
   pie slice / type=percent
               slice=arrow
               noheading
               midpoints=1 to 10;
   run;
   quit;
**********************;


**********************;
***7.5.1a
***%EXIST
**********************;
%macro exist(dsn);
   %global exist;
   %if &dsn ne %then %do;
      * An unknown data set causes a
      * compile error that is reflected
      * in the SYSERR macro variable;
      data _null_;
         stop;
         set &dsn;
         run;
   %end;
   %if &syserr=0 %then %let exist=YES;
   %else %let exist=NO;
%mend exist;
**********************;


**********************;
***7.5.2a
***%EXIST
**********************;
%macro exist(dsn);
%global exist;
%* Check if &DSN has been created;
%if %sysfunc(exist(&dsn)) %then 
      %let exist=YES;
%else %let exist=NO;
%mend exist;
**********************; 


**********************;
***7.5.2b
***%EXIST
**********************; 
%macro exist(dsn);
    %* The following sysfunc call results
    %* in a non-zero value when the data
    %* set exists;    %sysfunc(exist(&dsn))
%mend exist;
**********************;


**********************;
***7.6.1a
***%EXIST
**********************;
%macro exist(dsn);
   %sysfunc(exist(&dsn))
%mend exist;
**********************;


**********************;***7.6.1b
***%FACT
**********************;
%macro fact(n);
  %sysfunc(gamma(%eval(&n+1)))
%mend fact;
**********************;


**********************;
***7.6.1c
***%FACT
**********************;
%macro fact(n);
  %sysfunc(gamma(%sysevalf(&n+1,int)))
%mend fact;
**********************;


**********************;
***7.6.1d
***%FACT
**********************;
%macro fact(n);
  %sysfunc(fact(&n))
%mend fact;
**********************;  


**********************;
***7.6.1e
***%COMB
**********************;
%macro comb(n,r);
  %sysfunc(comb(&n,&r))
%mend comb;
**********************;


**********************;
***7.6.1f
***%CURRDATE
**********************;
%macro currdate;
%trim(%left(%qsysfunc(date(),worddate18.)))
%mend currdate;
**********************;


**********************;
***7.6.1g
***%DB2DATE
**********************;
%macro db2date;
%bquote(')%sysfunc(date(),yymmddd10.)%bquote(-00.00.00')
%mend db2date;

proc sql;
 connect to odbc (&db2j);
 create table sincemidnight 
   as select * from connection to odbc (
     select *
      from mydba.hospital1
       where proddate > %db2date
       for fetch only);
 %put &sqlxmsg;
 disconnect from odbc;
 quit;
**********************;


**********************;
***7.6.1h
***%FUZZRNGE
**********************;
%macro fuzzrnge(var,base,disp);
(%eval(&base-&disp) le &var & &var le %eval(&base+&disp))
%mend fuzzrnge;
**********************;     


**********************;
***7.6.1i
***%SLEEP
**********************;
%macro sleep(time=5);
   %local rc;
   %let rc = %sysfunc(sleep(&time));
%mend sleep;

%sleep(time=60)
**********************;


**********************;
***7.6.1j
***%SLEEP
**********************;
%macro sleep(time=5,unit=seconds);
   %* Units can be seconds, minutes, or hours;
   %local sleeptime rc;

   %if &unit eq %then unit=seconds;
   %if %upcase(&unit)=SECONDS %then %let sleeptime=&time;
   %else %if %upcase(&unit)=MINUTES %then 
                                       %let sleeptime=%sysevalf(&time*60);
   %else %if %upcase(&unit)=HOURS   %then 
                                       %let sleeptime=%sysevalf(&time*60*60);

   %let rc = %sysfunc(sleep(&sleeptime));
%mend sleep;

%sleep(time=1,unit=minutes)
**********************;


**********************;
***7.6.1j
***%WAKEUPAT
**********************;
%macro wakeupat(time=);
   %local rc;
   %let rc = %sysfunc(sleep(
               %sysevalf(%sysevalf("&time"dt)-
                  %sysfunc(datetime()))));
%mend wakeupat;

%wakeupat(time=07nov2003:18:54:00)
**********************;


**********************;
***7.6.1k
***%LISTLAST
**********************;
%macro listlast(list);
   %sysfunc(reverse(%scan(%sysfunc(reverse(&list)),1,%str( ))))
%mend listlast;
**********************;


**********************;
***7.6.1l
***%LISTLAST
**********************;
%macro listlast(list);
   %scan(&list,-1,%str( ))
%mend listlast;
**********************;
 

**********************;
***7.6.1m
***%INDEXW
**********************;
%macro indexw(list,wrd);
   %sysfunc(indexw(&list,&wrd))
%mend indexw;
**********************;


**********************;
***7.6.1n
***%RGBHEX
**********************;
%macro RGBHex(rr,gg,bb);
%sysfunc(compress(CX
    %sysfunc(putn(%sysfunc(round(&rr)),hex2.))
    %sysfunc(putn(%sysfunc(round(&gg)),hex2.))
    %sysfunc(putn(%sysfunc(round(&bb)),hex2.))))
%mend RGBHex;
**********************;


**********************;
***7.6.2a
***%ADDYEARS
**********************;
%macro AddYears(base,add);
     intnx('month',&base,&add*12) + (day(&base) - 1)
%mend;
**********************;


**********************;
***7.6.2b
***%EOW
**********************;
/*************************************************** 
Macro EOW               Garth Helf   24 October 2003 
Create new variable in a data step containing week 
ending date for a SAS date variable.  Argument we_day 
is day the week ends:  
     1=Saturday (default) to 7=Friday. 
****************************************************/ 
%macro eow(dayvar, eowvar, 
           eowformt=date., we_day=1);
&eowvar=intnx("week.&we_day", &dayvar, 0,"end");
format &eowvar &eowformt; 
%mend eow;
**********************;


**********************;
***7.6.3a
***%PERM
**********************;
%macro perm(n,r);
   %if &r ne %then %sysfunc(perm(&n,&r));
   %else %sysfunc(perm(&n));
%mend perm;
%mend eow;
**********************;


**********************;
***7.6.3b
***%PERM
**********************;
%macro perm(n,r);
   %* Check for improper values;
   %*   N & R must be positive integers;
   %*   N must be > R when R is provided;
   %* Calculate the factorial when R is not provided;
   %if %sysevalf(%sysevalf(&n,int) ne &n) or
       %sysevalf(&n < 1) or
      (&r ne %str() & %sysevalf(%sysevalf(&r,int) ne &r)) or
      (&r ne %str() & %sysevalf(&r < 1)) or
      (&r ne %str() & %sysevalf(&r > &n)) %then .;
   %else %if &r ne %then %sysfunc(perm(&n,&r));
   %else %sysfunc(perm(&n));
%mend perm;
**********************;


**********************;
***7.6.3c
***%SYMCHECK
**********************;
%macro symcheck(mvname);
   %* Determine if a specific macro variable 
   %* has been defined.;
   %local yesno fetchrc dsnid rc mvname;
   %let yesno  = NO;
   %let dsnid  = %sysfunc(open(sashelp.vmacro 
                    (where=(name=%upcase("&mvname"))),i));
   %let fetchrc = %sysfunc(fetch(&dsnid,noset)); 
   %if &fetchrc eq 0 %then %let yesno=YES;
   %let rc = %sysfunc(close(&dsnid)); 
   &yesno
%mend symcheck;
**********************;


**********************;
***7.6.3d
***%SYMCHECK
**********************;
%macro symcheck(mvname);
   %* Determine if a specific macro variable
   %* has been defined.;
   %local fetchrc dsnid rc mvname;
   %let dsnid=%sysfunc(open(sashelp.vmacro
                         (where=(name=%upcase("&mvname"))),i));
   %let fetchrc = %sysfunc(fetch(&dsnid,noset));
   %let rc = %sysfunc(close(&dsnid));
   not(&fetchrc) 
%mend symcheck;
**********************;


**********************;
***7.6.3e
***%REVSCAN
**********************;
%macro revscan(list, word);
   %local wcnt wnum;
   %let wcnt=0;
   %let wnum=0;
   %* Determine the word number in a list of words;
   %do %while(%scan(&list,%eval(&wcnt+1),%str( )) ne %str());
      %let wcnt = %eval(&wcnt+1);
      %if %upcase(%scan(&list,&wcnt,%str( )))=%upcase(&word) %then
         %let wnum=&wcnt;
   %end;
   &wnum
%mend revscan;
**********************;


**********************;
***7.6.3f
***%REPEAT
**********************;
%macro repeat(char,times);
  %let char = %quote(&char);
  %if &char eq %then %let char = %str( );
  %sysfunc(repeat(&char,&times-1))
%mend;
**********************;


**********************;
***7.6.3g
***%MIXEDCASE
**********************;
%macro mixedcase(string);
%local word cnt mixed;
%let string = %lowcase(&string);
%let mixed =;
%let cnt = 1;
%do %while(%scan(&string,&cnt,%str( )) ne %str());
   %let word = %scan(&string,&cnt,%str( )); 
   %let mixed = &mixed %upcase(%substr(&word,1,1));
   %if %length(&word) > 1 %then 
         %let mixed = &mixed%substr(&word,2);
   %let cnt = %eval(&cnt + 1);
%end;
&mixed
%mend mixedcase;
**********************;


**********************;
***7.6.3h
***%COLONCMPR
**********************;
%macro coloncmpr(left,op,right);
 %local width;

 %if &op = %str() %then %let op==;

 %* determine shorter of left and right;
 %let width = %sysfunc(min(%length(&left),%length(&right)));
 %upcase(%qsubstr(&left,1,&width) &op %qsubstr(&right,1,&width))
%mend coloncmpr;

%macro tryit;
%let a = smith;
%let b = s;
%if %coloncmpr(&a,=,&b) %then %put comparison is true;
%mend tryit;

%tryit
**********************;


**********************;
***8.2.4
***
**********************;
INIT:
   * Specify a macro var used for SCL in edit screens;
   call symput('scrntype','DE');

   * Create a libref for the log used
   * by this Data Entry userid;
   userid = symget('userid');
   tst = symget('tst');
   path = compress('h:\studyx\phase2\'
          ||tst||'datprep\d_entry\'
          ||userid);
   call libname('delog',path);
   control enter;
   cursor subject;
return;
**********************;


**********************;
***8.3.2
***
**********************;
%macro datastmp(var1,var2,var3,var4);

* determine the number of vars;
%do i = 1 %to 4;
   %if &&var&i ne %then %let varcnt = &i;
%end;

fseinit:
   scrntype=symget('scrntype');
   if scrntype in ('CLN', 'PED') then do;
      control enter;

   . . . . ordinary SCL not shown . . . .
return;

init:
   if scrntype='DE' or word(1)='ADD' then do;
   %do i = 1 %to &varcnt;
      unprotect &&var&i;
      &&var&i = symget("&&var&i");
      protect &&var&i;
   %end;
   end;
return;

. . . . ordinary SCL not shown . . . .

%mend datastmp;
**********************;


**********************;
***9.2.2a
***DBDIR
**********************;
data datamgt.dbdir;
INPUT @1 DSN $
      @10 PAGE $
      @19 KEYVAR $27.
      ;
datalines;
DEMOG    1        SUBJECT                     *
MEDHIS   2        SUBJECT MEDHISNO SEQNO      *
PHYSEXAM 3        SUBJECT VISIT REPEATN SEQNO *
VITALS   4        SUBJECT VISIT SEQNO REPEATN *
run;
**********************;


**********************;
***9.2.2b
***VRDIR
**********************;
data datamgt.vrdir;
  INPUT @1 DSN $
        @10 VAR $
        @19 PG $
        @21 LABEL $40.
        @62 VARTYPE $
        ;
datalines;
ALL      SUBJECT  $ Patient number                           $8
ALL      PTINIT   $ Patient initials                         $8
DEMOG    DOB      8 Date of birth                            8
DEMOG    SEX      $ Sex                                      $8
MEDHIS   MEDHISNO 8 Medical History Number                   8
MEDHIS   MHDT     8 Date of medical history                  8
PHYSEXAM PHDT     8 Date physical examination performed      8
PHYSEXAM WT       $ Weight                                   $8
run;
**********************;


**********************;
***9.2.2c
***FLDDIR
**********************;
data datamgt.flddir;
INPUT @1 DSN $
      @10 VAR $
      @19 CHKTYPE $
      @30 CHKTEXT $25.
      ;
datalines;
DEMOG    CENTRE   notmiss                              *
DEMOG    RACE     list       ('1','2','3','4','5','6') *
MEDHIS   MHDT     format     date7.                    *
run;
**********************;


**********************;
***9.2.3a
***
**********************;
data _null_;
   set datamgt.dbdir end=eof;
   i+1;  
   ii=left(put(i,3.));  
   call symput('livedb'|| w ii,trim(dsn));  
   call symput('keys'||ii,keyvar);  
   if eof then call symput('livecnt',ii);  
   run;
**********************;


**********************;
***9.2.3b
***
**********************;
data _null_;
   set datamgt.vrdir end=eof;
   i+1;
   ii=left(put(i,3.));
   call symput('vdsn'||ii,dsn);  
   call symput('var'||ii,var);  
   call symput('label'||ii,label);  
   call symput('vtyp'||ii,vartype);  
   if eof then call symput('varcnt',ii);
   run;
**********************;  


**********************;
***9.2.3c
***
**********************;   
* Create a list of data set attributes;
proc sql noprint;
   select dsn,var,label,vartype
      into :vdsn1-:vdsn999,
           :var1-:var999,
           :label1-:label999,
           :vtyp1-:vtyp999
         from datamgt.vrdir;
   quit;
        %let varcnt = &sqlobs; 
**********************; 


**********************;
***9.3.2
***
**********************;
%do jj = 1 %to &livecnt;
   proc fsedit data=livedb.&&livedb&jj 
               screen=appls.descrn.&&livedb&jj...screen;
     run;
%end;
**********************; 


**********************;
***9.3.3
***%CHKDUP
**********************;
%macro chkdup;
%do jj = 1 %to &livecnt;   
  %nw(&&keys&jj,wordvar=key,wordcnt=keycnt) 
  * Sort the data sets for the 
  * key variables;
  proc sort data=livedb.&&livedb&jj out=base;
     by &&keys&jj;
     run;

  * Check for duplicate key values;
  %let dupp = 0;
  data dupp; set base;
     by &&keys&jj;
     * determine if this is a dup obs;
     if not (first.&&key&keycnt and last.&&key&keycnt);  
     call symput('dupp','1');
     run;

  %if &dupp %then %do;
  * Duplicate key variables were found;
       proc print data=dupp;
       id &&keys&jj;
       title1 "&&livedb&jj";
       title2 "DUPLICATE KEYFIELDS in LIVE Data set";
       run;
     %end;
%end;  * end the DSN do loop;
%mend chkdup;


**********************;
***9.3.4a
***%BLDLIVE
**********************;
%macro bldlive;
%do jj = 1 %to &livecnt; 
  * One data step for each data set;
  data livedb.&&livedb&jj(keep= 
    %* Build the var list to keep for this DB;
    %do kk = 1 %to &varcnt; 
      %if &&livedb&jj=&&vdsn&kk or &&vdsn&kk=ALL 
              %then &&var&kk;
    %end;
      );
    * Use length to define variable attributes;
    length
      %do kk = 1 %to &varcnt;
         %if &&livedb&jj=&&vdsn&kk or &&vdsn&kk=ALL 
              %then &&var&kk &&vtyp&kk;
      %end;
      ;
    * Define the variable labels;
    label 
      %do kk = 1 %to &varcnt;
         %if &&livedb&jj=&&vdsn&kk or &&vdsn&kk=ALL 
                    %then &&var&kk = "&&label&kk";
      %end;
      ;
    stop;
    run;         
%end;
%mend bldlive;
**********************;


**********************;
***9.3.4b
***
**********************;
. . . . code not shown . . . .

%do jj = 1 %to &livecnt;
   %* Perform checks if dsn present;
      %if %exists(livedb.&&livedb&jj) %then %do;
      %put * Field error check for &&livedb&jj **************;
      * Build macro vars that will be used to;
      * construct the tests;
      %let fldcnt = 0;
      data _null_;
         set datamgt.flddir
        (where=(dsn="&&livedb&jj")) end=eof; 
         i+1;
         ii=left(put(i,3.));
         call symput('fvar'||ii,trim(var)); 
         call symput('ftyp'||ii,trim(chktype));
         call symput('ftxt'||ii,trim(chktext));
         if eof then call symput('fldcnt',ii); 
         run;

      %if &fldcnt gt 0 %then %do;

* Perform field and intra field checks;
data temperr(keep= status &&keys&jj dsn var 
                   count msg text value chkdate);
  set datamgt.&&livedb&jj;
  by &&keys&jj;

  * Date these field check problems ;
  * were first detected);
  retain chkdate %sysfunc(today());
  format chkdate date9.;

  * Count the number of times this ;
  * problem has been detected;
  * Status will be controlled by the ;
  * manager - initialize to NEW;
  length status $12;
  retain count 1 status 'NEW';

  * Specify various lengths to the ;
  * data set variables;
  * VALUE is only given a length of 15;
  * this can cause some truncation (in display);
  length dsn var $8 value $15 text msg $100;

  * Place the name of the data set into;
  * a data variable;
  retain dsn "&&livedb&jj";

  %* Build the Field and Intra Observation;
  %* Field error checks;
  %do i = 1 %to &fldcnt;
     %if %upcase(&&ftyp&i) = LIST %then %do;
        if &&fvar&i not in&&ftxt&i then do; 
           var = "&&fvar&i";
           msg = 'Value is not on list';
           text = "&&ftxt&i";
           value = &&fvar&i;
           output temperr;
        end;
     %end;
**********************;   


**********************;
***9.4.1a
***%BLDDEMOG
**********************;
%macro blddemog;
  * Create the KEEP for DEMOG;
  data livedb.demog(keep= 
    %* Build the var list to keep for this DB;
    %do kk = 1 %to &varcnt; 
      %if &&vdsn&kk=DEMOG 
    or &&vdsn&kk=ALL %then &&var&kk;
    %end;
     );
    * Use length to define variable attributes;
    length 
      %do kk = 1 %to &varcnt;
         %if &&vdsn&kk=DEMOG or &&vdsn&kk=ALL 
                 %then &&var&kk &&vtyp&kk;
      %end;
      ;
    * Define the variable labels;
    label 
      %do kk = 1 %to &varcnt;
         %if &&vdsn&kk=DEMOG or &&vdsn&kk=ALL 
                 %then &&var&kk = "&&label&kk";
      %end;
      ;
    stop;
    run;         
%mend blddemog;
**********************;


**********************;
***9.4.1b
***
**********************;
filename temptxt 'c:\temp\temptext.txt';  

data _null_;
   set datamgt.vrdir end=eof;
   array nam {1000} $8 _temporary_; 
   array typ {1000} $2 _temporary_;
   array lbl {1000} $40 _temporary_;
   if dsn in('DEMOG', 'ALL') then do;
      i+1;
      *Save this variables information;
      nam{i} = var;
      typ{i} = vartype;
      lbl{i} = label;
   end;
   if eof then do;
      * Write the DATA step statements;
      file temptxt;  

      * Write the DATA statement with the KEEP=;
      put 'data livedb.demog(keep='; 
      do j = 1 to i; 
         put '     ' nam{j};
      end;
      put '     );';

      * Write the LENGTH statement;
      put 'Length ';
      do j = 1 to i;
         put '     ' nam{j} typ{j};
      end;
      put '     ;';

      * Write the LABEL statement;
      put 'Label ';
      do j=1 to i;
         put '     ' nam{j} ' = "' lbl{j} '"';
      end;
      put '     ;';
      put 'run;';
   end;
   run;

%include temptxt;
**********************;


**********************;
***9.4.2a
***%CHKDSN
**********************; 
%macro chkdsn(dsn,keys);  
  %nw(&keys,wordvar=key,wordcnt=keycnt)  
  * Sort the data sets for the 
  * key variables;
  proc sort data=livedb.&dsn out=base;
     by &keys; 
     run;

     * Check for duplicate key values;
     %let dupp = 0;
     data dupp; set base;
     by &keys;
     * determine if this is a dup obs;
     if not (first.&&key&keycnt and last.&&key&keycnt);
     call symput('dupp','1');
     run;

     %if &dupp %then %do;
     * Duplicate key variables were found;
       proc print data=dupp;
       id &keys;
       title1 "&dsn";
       title2 "DUPLICATE KEYFIELDS in LIVE Data set";
       run;
     %end;
%mend chkdsn;
**********************;


**********************;
***9.4.2b
***%BLDDSN
**********************; 
%macro blddsn(dsn);  
  * One data step for each data set;
  data work.&dsn(keep=
    %* Build the var list to keep for this DB;
    %do kk = 1 %to &varcnt;
      %if &dsn=&&vdsn&kk 
            or &&vdsn&kk=ALL %then &&var&kk;
    %end;
      );
    * Use length to define variable attributes;
    length
      %do kk = 1 %to &varcnt;
         %if &dsn=&&vdsn&kk
            or &&vdsn&kk=ALL %then &&var&kk &&vtyp&kk;
      %end;
      ;
    * Define the variable labels;
    label
      %do kk = 1 %to &varcnt;
         %if &dsn=&&vdsn&kk
            or &&vdsn&kk=ALL %then &&var&kk = "&&label&kk";
      %end;
      ;
    stop;
    run;
%mend blddsn;
**********************;


**********************;
***9.4.3
***%USELIST
**********************;
%macro uselist(dsn);
* Create lists of data set attributes;
proc sql noprint;  
   select var,label,vartype  
      into :varlist separated by ' ', 
           :lbllist separated by ',', 
           :typlist separated by ' '
         from datamgt.vrdir
                                        (where=(dsn in('ALL',%upcase("&dsn"))));  
   quit;

* One data step for each data set;
data work.&dsn(keep= &varlist);
   * Use length to define variable attributes;
   length
      %do kk = 1 %to &sqlobs;
         %scan(&varlist,&kk) %scan(&typlist,&kk) 
      %end;
      ;
   * Define the variable labels;
   label
      %do kk = 1 %to &sqlobs;
         %scan(&varlist,&kk)="%scan(&lbllist,&kk,str(,))" 
      %end;
      ;
   stop;
   run;
   */  *;
%mend uselist;

%uselist(demog)
**********************;


**********************;
***9.5.2
***%LOOK
**********************;
%macro look(dsn);
   %local maxn;
   * Determine the next available title;
   proc sql noprint; 
      select max(number) 
         into :maxn 
            from sashelp.vtitle 
               where type='T'; 
      quit;

   title%eval(&maxn+1) "Listing of &dsn";
   proc print data=&dsn;
      run; 
   title%eval(&maxn+1);
%mend look;
**********************;


**********************;
***10.1.1
***%CATCOPY
**********************;
* Copy catalogs from the TEST to the PRODUCTION
* areas.;

options nomprint nomlogic nosymbolgen;

%macro catcopy(test,prod);
* test  - libref for the test area
* prod  - libref for the production area
*;

* Determine catalogs in TEST area;
data _null_;
set sashelp.vscatlg(where=(libname="%upcase(&test)"));
length ii $2;

* Select only some of the catalog members;
if memname in: ('DE', 'ED', 'PH');

i+1;
ii=left(put(i,2.));
call symput('cname'||ii,memname);
call symput('catcnt', ii);
run;

proc datasets ;
copy in=&test out=&prod memtype=catalog;
select
  %do i = 1 %to &catcnt;      
&&cname&i
  %end;
;
quit;
%mend catcopy;

%catcopy(appls,work)
**********************;


**********************;
***10.1.2
***%DUMPIT
**********************;
%MACRO DUMPIT (CNTOUT);
 %* Create a local counter; 
 %LOCAL CWJ;

 %DO CWJ=1 %TO &NUMOBS;

  %* Fileref to identify the file to list;
  FILENAME DUMP&CWJ "&&INVAR&CWJ" DISP=SHR;

  * Read and write the first &CNTOUT records;
  DATA _NULL_; 
    INFILE DUMP&CWJ END=DONE;
    * Read the next record;
    INPUT;
    INCNT+1;
    IF INCNT LE &CNTOUT THEN LIST;
    IF DONE THEN DO;
       FILE PRINT;
       PUT //@10 "TOTAL RECORDS FOR &&INVAR&CWJ IS "
             +2 INCNT COMMA9. ;
    END;
  RUN;

  FILENAME DUMP&CWJ CLEAR;

 %END;
%MEND DUMPIT; * The Macro definition ends;

* Read the control file and establish macro variables;
DATA DUMPIT; 
 INFILE CARDS END=DONE;
 INPUT FILENAM $25.;
 CNT+1;
 NEWNAME=TRIM(FILENAM);
 * The macro variable INVARi contains the ith file name;
 CALL SYMPUT ('INVAR'!!TRIM(LEFT(PUT(CNT,3.))),NEWNAME);
 * Store the number of files to read;
 IF DONE THEN CALL SYMPUT('NUMOBS',CNT);
CARDS;
PNB7.QSAM.BANK.RECON
PNB7.QSAM.CHECKS
PNB7.QSAM.CHKNMBR
PNB7.QSAM.CKTOHIST
PNB7.QSAM.DRAIN
PNB7.QSAM.RECON
PNB7.BDAM.BDAMCKNO
PNB7.BDAM.VCHRCKNO
PNB7.QSAM.CS2V3120.CARDIN
PNB7.QSAM.CASVCHCK
PNB7.QSAM.CASVOUCH
PNB7.QSAM.VCHR3120.CARDIN
PNB7.QSAM.VOUCHERS
TAX7.JACKSON
;;;

TITLE "CITY OF DALLAS - ECI (FINSYS), JOBNAME IS &SYSJOBID";
TITLE2 "LIST OF FILES TO DUMP &CNTOUT RECORDS";
PROC PRINT data=dumpit;
RUN;

* Pass the number of records to dump from each file;
%DUMPIT (25);
**********************;


**********************;
***10.1.3a
***%UPDATE
**********************;/*****************************************************
SYNTAX:
  %update(string_var)
EXAMPLES:
  %update(all)
  %update(timestr)
This macro updates some or all of the following date/time
string macro variables:
  &timestr
  &todaystr
  &nowstr *******************************************************/

%macro update(string);
%global timestr todaystr nowstr;
  %if &string=all %then %do;
    %let string=nowstr;
  %end;
  data _null_;
    %if &string=todaystr or &string=nowstr %then %do;
      call symput('todaystr',put(today(),worddate.));
    %end;
    %if &string=timestr or &string=nowstr %then %do;
      call symput('timestr',put(time(),HHMM.));
    %end;
    %if &string=nowstr %then %do;
      %let nowstr=&timestr&todaystr;
    %end;
  run;
%mend update;
**********************;


**********************;
***10.1.3b
***%UPDATE2
**********************;
%macro update2(string);
  %global timestr todaystr nowstr;
  %let string = %lowcase(&string);
  %if &string=all %then %let string=nowstr;

  %if &string=todaystr or &string=nowstr %then
    %let todaystr = %left(%qsysfunc(today(),worddate.));
  %if &string=timestr or &string=nowstr %then
    %let timestr = %left(%sysfunc(time(),HHMM.));

  %if &string=nowstr %then %let nowstr=&timestr&todaystr;
%mend update2;
**********************;


**********************;
***10.1.4
***%CHKCOPY
**********************;
%macro chkcopy;
* Copy the current version of the COMBINE files
* to COMBTEMP;
proc datasets memtype=data;
   copy in=combine out=combtemp;
   quit;
%if &syserr ge 5 %then %do;
  data _null_;
     put '***************************';
     put '***************************';
     put '***************************';
     put '*** combine copy failure **';     put 'One of the data sets may be in use.';
     put '***************************';
     put '***************************';
     put '***************************';
     abort abend;
     run;
  * When aborted (inside this macro do block) nothing else 
  * should execute in this job including the following 
  * message;
  %put JOB ABORTED!!!! 
  %put this message should never be written!!;
%end;         
%mend chkcopy;
**********************;


**********************;
***10.1.5a
***%CMBNSUBJ
**********************;
%macro cmbnsubj;

* Determine the subjects, make a macro var for each;
* DECNTRL.INxxxxxx data sets have one obs per subject;
data _null_;
  set sashelp.vtable(keep=libname memname); 
  where libname='DECNTRL' & memname=:'IN'; 
  length ii $3 subject $6;
  i+1;
  ii=left(put(i,3.));
  subject=substr(memname,3);
  call symput('subj'||ii,subject); 
  call symput('subjcnt',ii);
  run;

proc datasets library=work;
  delete subjstat;

  * Combine the subject control files;
  %do i = 1 %to &subjcnt;
     append base=subjstat data=decntrl.in&&subj&i;
  %end;
  quit;
%mend cmbnsubj;
**********************;


**********************;
***10.1.5b
***%CMBNSUBJ
**********************;
%macro cmbnsubj;

* Determine the subjects, make a macro var for each;
* DECNTRL.INxxxxxx data sets have one obs per subject;

* Create a list of all data sets in the libref DECNTRL;
* ALLCONT will have one observation for each variable in 
* each data set;
proc contents data=decntrl._all_
              out=allcont(keep=memname)
              noprint;
run;

* Eliminate duplicate observations;
proc sort data=allcont nodupkey;
  by memname;
  run;

data _null_;
set allcont; 
where memname=:'IN'; 
length ii $3 subject $6;
i+1;
ii=left(put(i,3.));
subject=substr(memname,3);
call symput('subj'||ii,subject); 
call symput('subjcnt',ii); 
run;

proc datasets library=work;
delete subjstat;

* Combine the subject control files;
%do i = 1 %to &subjcnt;
   append base=subjstat data=decntrl.in&&subj&i; 
%end;
quit;
%mend cmbnsubj;
**********************;


**********************;
***10.1.5c
***%CMBNSUBJ
**********************;
%macro cmbnsubj;

* Determine the subjects, make a macro var for each;
* DECNTRL.INxxxxxx data sets have one obs per subject;

* Create a list of all data sets in the libref DECNTRL;
%let depath = %sysfunc(pathname(decntrl)); 

x "dir &depath\in*.sd2 /o:n /b > d:\junk\dirhold.txt"; 

data null;
infile 'd:\junk\dirhold.txt' length=len;
input @;
input memname $varying12. len; 
length ii $3 subject $6;
i+1;
ii=left(put(i,3.));
subject=substr(memname,3,len-6);
call symput('subj'||ii,subject); 
call symput('subjcnt',ii); 
run;

proc datasets library=work;
delete subjstat;

* Combine the subject control files;
%do i = 1 %to &subjcnt;
   append base=subjstat data=decntrl.in&&subj&i; 
%end;
quit;
%mend cmbnsubj;
**********************;


**********************;
***10.1.6
***%MAKEDIR
**********************;
%macro makedir(newdir);
  * Make sure that the directory exists;
  %let rc = %sysfunc(fileexist(&newdir)); 
  %if &rc=0 %then %do;
     %* Make the directory;
     %sysexec  md &newdir; 
  %end;
%mend makedir;

%makedir(c:\tempzzz)
**********************;


**********************;
***10.1.7a
***%MAKERUNBAT
**********************;
%macro makerunbat;
   options noxwait; 
   x dir "&path\*.sas" /o:n /b > c:\temp\pgmlist.txt; 

   data _null_;
      length sasloc path $75 excmd $150;      retain sasloc "&sasloc" path "&path";

      * Determine the names of the sas programs;
      infile 'c:\temp\pgmlist.txt' length=len; 
      input @;
      input saspgm $varying35. len;

      * Write out the batchfile;
      file "&path\runbat.bat"; 

      * Build the executable command; 
      excmd = '"'||trim(sasloc)||'" -sysin "'
                 ||trim(path)||'\'||saspgm||'"';
      put excmd;
   run;

%mend makerunbat;

%let path = C:\My Documents\macro2; 
%let sasloc = C:\Program Files\SAS Institute\SAS\V8\sas.exe;
%makerunbat
**********************;


**********************;
***10.1.7b
***%MAKERUNBAT2
**********************;
%macro makerunbat2;
   options noxwait;
   x dir "&path\*.sas" /o:n /b > c:\temp\pgmlist.txt;

   data _null_;
      length sasloc path $75 excmd $150;
      retain sasloc "&sasloc" path "&path";

      * Determine the names of the sas programs;
      infile 'c:\temp\pgmlist.txt' length=len;
      input @;
      input saspgm $varying35. len;

      if _n_=1 then do; 
         * Write out the batchfile name;
         file "&path\runbat.bat"; 

         * Build the executable command;
         excmd = '"'||trim(sasloc) 
                    ||'" -sysin "c:\temp\masterpgm.sas"';         put excmd;
      end;

      * Write out the Master INC program;
      file "c:\temp\masterpgm.sas"; 

      * Build the executable command;
      excmd = '%inc "'||trim(path)||'\'||saspgm||'";';
      put excmd;
   run;

%mend makerunbat2;

%let path = C:\My Documents\macro2;
%let sasloc = C:\Program Files\SAS Institute\SAS\V8\sas.exe;
%makerunbat2
**********************;


**********************;
***10.2.1
***%TF
**********************;
/*________________________________________________________________
|                                                                 |
|                              TF                                          |
|                                                                                     |
|                                                                                     |
| TF macro allows Titles or Footnotes to be specified in any            |
| combination of LEFT, CENTRED or RIGHT aligned in one line.            |
| The user can optionally stop the output page number from being        |
| overwritten.  Specifying SLINE in the LEFT parameter will                |
| print a solid line the width of the page.                               |
|                                                                                     |
|               |        |                                            |
| Parameter     | Default| Description                                  |
|                |            |                                                       |
| TF=         | TITLE   | OPTIONAL:  Parameter which defines if texts|
|                |        | are TITLEs or FOOTNOTEs.                           |
|           |        |                                            |
| N=            | 1             | OPTIONAL:  Title/Footnote number.  SAS                |
|               |               | currently allows up to 10 titles/footnotes.|
|               |               |                                            |
| Left=         |       | OPTIONAL:  Text to be left aligned.  If you|
|               |       | specify SLINE then a solid line will be       |
|               |               | drawn the width of the linesize.              |
|               |               |                                               |
| Centre=       |               | OPTIONAL:  Text to be centred on the page.    |
|               |               |                                               |
| Right=        |       | OPTIONAL:  Text to be right aligned.                  |
|               |               |                                               |
| PNum=         | NO            | OPTIONAL:  Used when TF is a TITLE, and if    |       
|               |               | set to YES it stops right aligned title1   |
|               |        | from overwriting the automatic page number.|
|               |               | NB: Use OPTIONS NUMBER to start page          |
|               |               | numbering.                                    |
|                |        |                                            |
|                                                                 |
| Usage         : See documentation in the software library.          |
|                                                                                          |
| Written by    : David Shannon, V1.0, Spring 97, Engine 6.10+          |
|         david@schweiz.demon.co.uk                                                |
|              David Shannon, V1.1, 09SEP1997, Engine 6.12.             |
|              (Reduced to LS-2 allowing paging macros to work).        |
| References    : SAS Language, Version 6, SAS Institute.               |
|               : SAS Guide to Macro Processing, Version 6, SAS Inst. |
|_______________________________________________________________ */;
      
%Macro TF(TF=T,N=1,Left=,Centre=,Right=,PNum=No);
%Local ERRCOD1 ERRCOD2 GAP3 LWAS;
Options NoMprint NoMlogic NoSymbolgen;

%******************************************************************;
%* Determine if TF is title or footnote (defaults to TITLE)       *;

%If %Upcase(%Substr(&TF,1,1))=F %Then %Do; %Let TF=FOOTNOTE; %End;
%Else %Do; %Let TF=TITLE; %End;

%******************************************************************;
%* Ensure that Title and Number parameters are valid.             *;
 
Data _null_;
     Length N $2 Pnum $3;
     N=symget('N');
     If N not in('1' '2' '3' '4' '5' '6' '7' '8' '9' '10') then
        Do;
           PUT "ERROR: Valid &TF lines are integers from 1 to
           10.";Put;
           Call Symput('ERRCODE','1');
        End;
     PNum=Upcase(Symget('PNum'));
     If substr(PNum,1,1) not in ('N','Y') then
        Do;
           Call Symput('PNUM','NO');
           PUT "WARNING: Invalid NUMBER option specified";
           PUT "Defaulted to NO.";PUT;
        End;
Run;
%If &ERRCOD1=1 %Then %Goto EOM;

%******************************************************************;
%* If pnum is set to no then stop page numbering                  *;

%If (%Upcase(%Substr(&pnum,1,1))=N AND &TF=TITLE) %Then
%Do;
    Options NoNumber;
%End;

%******************************************************************;
%* Determine FROM and TO positions of texts and spaces            *;

Data _null_;
Set  SASHELP.VOPTION(Where=(optname='LINESIZE'));
     Length to1 from2 to2 from3 gap1 gap2 settn 8.;
     settn=(input(setting,??best.)-3);
     If Upcase("&LEFT")="SLINE" Then
     Do;
        %Let lwas=&left; 
        Call symput('LEFT',Left(Repeat('_',settn))); 
     End;
     Left=Trim(Symget(Resolve('Left')));
     Centre=Trim(Symget('Centre'));
     Right=Trim(Symget('Right'));

     If Left^="" Then
     Do;
        To1=Length(Trim(left));
     End;
     Else Do;
        To1=0;
     End;

     If Centre^="" Then
     Do;
        From2=Floor( Floor(settn/2) - Length(Trim(centre))/2);
        To2=(from2 + Length(Trim(centre)))-1;
     End;
     Else Do;
        From2=Floor(settn/2);
        To2=Floor(settn/2)+1;
       Call Symput('Centre',repeat(byte(32),1));
     End;

     If Right^="" Then
     Do;
        From3=( settn+1 - Length(Trim(right))-1);
        If (%Eval(&N)=1 AND upcase(substr("&Pnum",1,1))='Y') then
              From3=from3-4;
     End;
     Else Do;
        From3=settn+1;
     End;

     gap1=( (from2) - (to1) -1 );
     gap2=( (from3) - (to2) -1 );

     If gap1 gt 0 then Call Symput('Gap1', repeat(byte(32),gap1));
     Else %let gap1=;; 
     If gap2 gt 0 then Call Symput('Gap2', repeat(byte(32),gap2));
     Else %let gap2=;; 

     %If %Upcase(&PNum)=YES %Then Call Symput('Gap3', repeat(byte(32),3));
     %Else Call Symput('Gap3',repeat(byte(32),1));;

     If ((to1 ge from2) AND centre ne '') then
     Do;
        PUT "ERROR: Centre aligned text will overwrite left aligned text.";
        PUT "ERROR: Either shorten text or increase linesize";
        Call Symput ('ERRCOD2','1');
     End;

     If ((to2 ge from3) AND right  ne '') then
     Do;
        PUT "ERROR: Right aligned text will overwrite centre aligned text.";
        PUT "ERROR: Either shorten text or increase linesize";
        Call Symput ('ERRCOD2','1');
     End;
Run;

%****************************************************************;
%* Check for error status, if true jump to end of macro         *;

%If &ERRCOD2=1 %then %Goto EOM;

%****************************************************************;
%* Create Title/Footnote                                        *;

%If %Upcase(&LWAS)=SLINE %Then
%Do;
    &TF&N " &LEFT ";
%End;
%Else %Do;
    &TF&N " &LEFT&GAP1&CENTRE&GAP2&RIGHT&GAP3.";
%End;
%EOM:
Options Mprint Mlogic Symbolgen;
%Mend TF;


***10.2.2
***%REPORT
**********************;
%macro report(dsn);
proc summary data =&dsn nway; 
   class tpcorder sysname bldgname grpname;
   output out=calllist;
   run;

data _null_;
   set calllist end=eof;
   numcall+1;
   * Build macro variable(s) to hold WHERE clause;
   call symput('call'||left(put(numcall,3.)), 
      "tpcorder='"||tpcorder||
      "'and sysname= '"||sysname||
      "'and bldgname='"||bldgname||
      "'and grpname= '"||grpname||"'");
   if eof then call symput('numcalls',left(put(numcall,3.)));
   run;

%do i = 1 %to &numcalls;
   options nobyline pageno=1;
   proc report data=&dsn nowindows headline;
      by tpcorder sysname bldgname grpname;
      where &&call&i;
      run;
%end;
%mend report;
**********************;


**********************;
***10.2.3a
***
**********************;
proc sql;
   reset noprint;
   select max(number) into :t
      from dictionary.titles
         where type='T';
   quit;
**********************;


**********************;
***10.2.3b
***
**********************;
data _null_;
   set sashelp.vtitle(keep=type number
                      where=(type='T'));
   retain max 0;
   max = max(max,number);
   call symput('t',left(put(max,2.)));
   run;
**********************;


**********************;
***10.3.1a
***%STOREOPT
**********************;
%macro storeopt(oplist);
%local len i tem;
%if &oplist ne %then %do;
   %let oplist = %cmpres(&oplist);
   %global &oplist; 
   %let len = %length(&oplist); 
   %* Establish a var with opt names quoted;
   %let tem = ; 
   %do i = 1 %to &len; 
      %if %substr(&oplist,&i,1) = %str( ) %then %do;
         %* Add quotes around the words in the list;
         %let tem = &tem%str(%', %'); 
      %end;
      %else %let tem =&tem%UPCASE(%substr(&oplist,&i,1)); 
   %end;
   %let tem = %bquote(%str(%')&tem%str(%')); 

   * Retrieve the current option settings;
   data _null_;
      set sashelp.voption;
      if optname in:(%UNQUOTE(&tem)) then do; 
         call symput(optname,left(trim(setting)));
      end;
      run;
%end;
%mend storeopt;

%storeopt(linesize pagesize obs mlogic date)
**********************;


**********************;
***10.3.1b
***%HOLDOPT
**********************; 
/*********************************************************/
/* Macro: HoldOpt */
/* Programmer: Pete Lund */
/* Date: September 2000 */
/* Purpose: Holds the value of a SAS option in a macro */
/* variable. The value can then be used to reset options */
/* to a current value if changed. */
/* */
/* Parameters: */
/* OptName   the name of the option to check */
/* OptValue   the name of the macro variable that will */
/* hold the current value of the option */
/* The default name is made up of the word */
/* "Hold" and the option name. For */
/* example, if OptName=Notes, OptValue */
/* would equal HoldNotes */
/* Display   Display current value to the log (Y/N) */
/* The default is N */
/* */
/*********************************************************/
%macro HoldOpt(
          OptName=,    /* Option to hold value   */ 
          OptValue=XX, /* Macro var name to hold value*/ 
          Display=N);  /* Display value to the log */

%if %substr(&sysver,1,1) eq 6 
   and ((%length(&OptName) gt 4 and &OptValue=XX)
      or %length(&OptValue) gt 4) %then %do; 
   %put WARNING: Default variable name of Hold&OptName is too long for V&sysver..;
   %put WARNING: Please specify a shorter name with the OptValue= macro parameter.;
   %goto Quit;
%end;
%if &OptValue eq XX %then %let OptValue = Hold&OptName; 
%global &OptValue; 
%let &OptValue = %sysfunc(getoption(&OptName)); 
%if &Display eq Y %then
   %put The current value of &OptName is &&&OptValue;
%Quit:
%mend;
**********************;


**********************;
***10.3.2a
***%FMTSRCH
**********************;
%macro fmtsrch(lib,add);
   %* Check to see if a libref is in the format search path
   %* lib   libref to check
   %* add   If &add is not null, then add the libref, if
   %*       it is not already in the fmtsearch value;

   %* Macro returns.
   %* &add is null
   %*    0  if &lib is not on path
   %*    >0 if &lib is on path
   %* &add is not null
   %*    Option statement to add &lib if it is not on path
   %*    null if &lib is on path;

   %local optval insrch;

   %* Determine if the library is on the fmt search path;
   %let optval = %sysfunc(getoption(fmtsearch)); 
   %let insrch = %index(&optval,%upcase(&lib)); 

   %if &add ne %then %do; 
      %* Add &lib to format search, 
      %* if it is not already on the path;
      %if &insrch = 0 %then %do; 
         %* Remove the trailing close parenthesis;
         %let optval = 
               %substr(&optval,1,%eval(%length(&optval)-1));
         %* Add the library;
         options fmtsearch=&optval &lib);   
      %end;
   %end;
   %else &insrch; 
%mend fmtsrch;
**********************;


**********************;
***10.3.2b
***%MKFMT
**********************;
%macro mkfmt(lib=, dsn=, fmtname=, from=, too=);

   %* When the fmt name is unspecified,
   %* use the incoming var name (FROM) as the format name;
   %if &fmtname= %then %let fmtname=&from;  

   * Eliminate duplicate values of &from;
   proc sort data=&dsn(keep=&from &too)
             out=temp
             nodupkey;
      by &from;
      run;

   data control(keep=fmtname start label type);  
      set temp(rename=(&from=start &too=label))
      length type $1 fmtname $8;
      retain fmtname "&fmtname" type ' ';

      * Determine the format type;
      If _n_=1 then type = vtype(start);  
      run;

   proc format
         %if &lib ne %then library=&lib;  
         cntlin=control;
      run;

   %if &lib ne %then %fmtsrch(&lib,1); 
%mend mkfmt;
**********************;


**********************;
***10.3.3
***%MKLIB
**********************;
%macro mklib(lname=, engine=default, lloc=);
%* Establish a libref
%* lname    new libref name
%* engine   engine type (optional)
%* lloc     path or location
%*             may be an existing libref
%*;

%local rc;
%* Clear libref if it exists;
%if %sysfunc(libref(&lname))=0 %then
      %sysfunc(libname(&lname)); 

%* Determine if &lloc already is a libref;
%if %sysfunc(libref(&lloc))=0 %then 
      %let lloc = %sysfunc(pathname(&lloc)); 
%let rc = %sysfunc(libname(&lname,&lloc,&engine)); 
%put &rc %sysfunc(sysmsg());

%mend mklib;
**********************;


**********************;
***10.4.5
***
**********************;
*** A series of program fragments.;
*clear the default graph catalog;
proc datasets library=work mt=cat nolist;
  delete gseg;
  quit;

goptions nodisplay;
proc gplot data=pltdat ;
   plot hrplt*Q=pltvar/
       skipmiss nolegend
       vaxis=axis1
       name = "H&&cmod&i&&regim&i"
       des  = "&&model&i &&regim&i";
   run;
   quit;

* create macro variable containing a list of the plots;
data _null_;
   set sashelp.vcatalg;
   where libname = 'WORK' 
     and memname = 'GSEG' 
     and objname =: "H&&cmod&i";
   length sumplots $20000;
   retain sumplots ' ';
   sumplots = trim(sumplots)||' '||trim(objname);
   call symput('sumplots', trim(left(sumplots)));
   run;

filename webloc "&drive\&project\hazardratios\HR&&cmod&i";
* Wrap the various graphs with html;
goptions dev=webframe display gsfname=webloc;
proc greplay igout=gseg nofs; 
   replay &sumplots;
   run; 
   quit;
**********************;


**********************;
***10.4.6
***
**********************;
data prep2;
   set prep1; 
   length grpref mylink $150 crptgrp $3;
   crptgrp= trim(left(put(rptgrp,3.)));
   myLink = "\\&project\hazardratios\hr"||
          trim(crptgrp)||'\index.html';
   grpref=  "<a HREF="||trim(myLink)||
          '>'||trim(crptgrp)||'</a>';
   label grpref = 'Report Group';
   run;

* Define location and index name for the new index;
ods html path="&drive\&project\&outloc" (url=none) 
         body="&indexname..html"; 
ods listing close;

proc print data=prep2 label noobs;
   var grpref groupdesc;
   title1 "&title  Control File: &indsn";
   run;  
ods html close;
**********************;


**********************;
***11.1.1
***%SAS2RAW
**********************;
* sas2raw.sas
*
* Convert a SAS data set to a RAW or flat text file.  Include 
* SAS statements on the flat file as documentation.
*;

* LIB  LIBREF OF THE DATA BASE (data base name) e.g. BENTHIC;
*      This argument can be used to control the path.
* MEM  NAME OF DATA SET AND RAW FILE (member name) 
*      e.g. FULLBEN;
* The raw file will have the same name as the data set.
*;
%MACRO SAS2RAW(lib, mem);

* The libref for incoming data is &lib ;
libname &lib   "d:\training\sas\&lib";
* New text file written to the fileref ddout;
filename ddout "d:\junk\&mem..raw ";

*  DETERMINE LENGTHS AND FORMATS OF THE VARIABLES;
PROC CONTENTS DATA=&lib..&mem 
              OUT=A1 NOPRINT;
   RUN;

PROC SORT DATA=A1; BY NPOS;
   RUN;

* MANY NUMERIC VARIABLES DO NOT HAVE FORMATS AND THE RAW FILE;
* WILL BE TOO WIDE IF WE JUST USE A LENGTH OF 8;
* Count the number of numeric variables;
DATA _NULL_; SET A1 END=EOF;
   IF TYPE=1 THEN NNUM + 1;
   IF EOF THEN CALL SYMPUT('NNUM',LEFT(PUT(NNUM,3.)));
   RUN;


%if &nnum > 0 %then %do;
* DETERMINE HOW MANY DIGITS ARE NEEDED FOR EACH NUMERIC VARIABLE;
* D STORES THE MAXIMUM NUMBER OF DIGITS NEEDED FOR EACH;
DATA M2; SET &lib..&mem (KEEP=_NUMERIC_) END=EOF;
ARRAY _D  DIGIT1 - DIGIT&NNUM;
ARRAY _N  NUMERIC_;
KEEP DIGIT1 - DIGIT&NNUM;
RETAIN DIGIT1 - DIGIT&NNUM;
IF _N_ = 1 THEN  DO OVER _D; _D=1; END;
DO OVER _D;
     _NUMBER = _N;
     _D1 = LENGTH(LEFT(PUT(_NUMBER,BEST16.)));
     _D2 = _D;
      * NUMBER OF DIGITS NEEDED;
     _D = MAX(_D1, _D2);
END;
IF EOF THEN OUTPUT;
RUN;
%end;


*** THIS SECTION DOES NOT WRITE DATA, ONLY THE PUT STATEMENT;
* MAKE THE PUT STATEMENT AND SET IT ASIDE.;
* It will serve as documentation as well as the PUT statement;
DATA _NULL_; SET A1 END=EOF;
RETAIN _TOT 0 _COL 1;
FILE DDOUT NOPRINT lrecl=250;
IF _N_ = 1 THEN DO;
     %if &nnum > 0 %then SET M2;;
     TOT = NPOS;
END;
%if &nnum > 0 %then %do;
ARRAY _D (NNUM) DIGIT1 - DIGIT&NNUM; 
* TYPE=1 FOR NUMERIC VARS;
IF TYPE=1 THEN DO;
     NNUM + 1;
     DIGIT = _D;
     * TAKE THE FORMATTED LENGTH INTO CONSIDERATION;
     LENGTH = MAX(FORMATL, FORMATD, DIGIT);
END;
%end;
TOT = _TOT + LENGTH + 1;
CHAR = '               ';
* SPECIAL HANDLING IS REQUIRED WHEN FORMATS ARE USED.
* CHAR IS USED TO STORE THE FORMAT;
IF FORMAT ^= ' ' | FORMATL>0 | FORMATD >0 THEN DO;
    * BUILD THE FORMAT FOR THIS VARIABLE;
    CHAR = TRIM(FORMAT);
    IF FORMATL>0 THEN CHAR=TRIM(CHAR)||TRIM(LEFT(PUT(FORMATL,3.)));
    CHAR= TRIM(CHAR)||'.';
    IF FORMATD>0 THEN CHAR=TRIM(CHAR)||TRIM(LEFT(PUT(FORMATD,3.)));
END;
IF TYPE = 2 & FORMAT = ' ' THEN CHAR = '$';
* _COL IS THE STARTING COLUMN;
IF _N_ = 1 THEN _COL = 1;
IF _N_ = 1 THEN PUT '/* *** */ PUT      @' _COL NAME CHAR;
ELSE            PUT '/* *** */    @' _COL NAME CHAR;
COL = _COL + LENGTH + 1;
IF EOF THEN DO;
     PUT '/* *** */ ;' ;
     CALL SYMPUT('LRECL',_TOT);
END;
RUN;

* Write out the flat file using the PUT statement in DDOUT;
DATA _NULL_; SET &dsn..&mem;
FILE DDOUT NOPRINT MOD lrecl=250; 
%INCLUDE DDOUT; 
run;
%MEND sas2raw;

****************************************************;

 %SAS2RAW(sasclass,ca88air)    run; 
**********************;


**********************;
***11.1.2
***%DELIM
**********************;
%delim(vitals,log)
* delim.sas
*
* Convert a SAS data set to a comma delimited flat file.;
*
* Presented at PharmaSUG April, 1997
* by Susan Haviar
*;
data vitals;
input value $10. target $8. nums err mini maxi;
cards;
Diastolic Baseline 8 64.5 59 74
Diastolic 0.25 hrs 8 66.6 57 72
Diastolic 0.50 hrs 8 62.9 51 70
Diastolic 1 hrs    8 69.5 57 88
Diastolic 2 hrs    8 69.8 53 83
run;


%macro delim(dsn,oout);

   filename &oout "d:\junk\&dsn..txt";

   proc contents data=&dsn 
                 out=_temp_(keep=name npos)
                 noprint;
      run;

   proc sort data=_temp_;
      by npos;
      run;

   data _null_;
   set _temp_ end=eof;
   call symput('var'||left(put(_n_,5.)),name);
   if eof then call symput('total',left(put(_n_,8.)));
   run;

   data _null_;
   file &oout noprint;
   set &dsn;
   put
      %do i=1 %to &total; 
         &&var&i +(-1)',' 
      %end;
      +(-1)' '; 
   run;
%mend delim;

%delim(vitals,outfile)
**********************;


**********************;
***11.2.1
***%TOPPCNT
**********************;
%macro toppcnt(dsn,idvar,pcnt);
***********************************************************;
* CREATE TABLE PCNT FOR INDICATING &PCNT OF Ids  *;
***********************************************************;

PROC SQL NOPRINT;
      SELECT
            COUNT(DISTINCT &IDVAR) *&PCNT INTO :IDPCNT
FROM
      &dsn;      ****<-- Number of obs in &dsn is unknown;

***********************************************************;
*             SORT ON DESCENDING &IDVAR                   *;
***********************************************************;

PROC SORT DATA= &dsn OUT=ITEMS;
BY DESCENDING &IDVAR;
RUN;

***********************************************************;
*   KEEP TOP % USING GLOBAL MACRO VARIABLE                *;
***********************************************************;

DATA TOPITEMS;
SET ITEMS(OBS=%sysevalf(&IDPCNT,ceil));  **<-- Reflects the % ;
RUN;
%mend toppcnt;

%toppcnt(sasclass.biomass,bmtotl,.25);
**********************;


**********************;
***11.2.2
***%SELPCNT
**********************;
%macro selpcnt(dsn,idvar,pcnt);

* Sort the incoming data set in descending order;
proc sort data=&dsn
          out=items;
   by descending &idvar;
   run;

* Read the first IDPCNT observations from ITEMS;
data topitems;
   idpcnt = nobs*&pcnt;
   do point = 1 to idpcnt;
      set items point=point nobs=nobs;
      output;
   end;
   stop;
   run;
%mend selpcnt;

%selpcnt(sasclass.biomass,bmtotl,.25);
**********************;


**********************;
***11.2.3a
***%RAND_WO
**********************;
%macro rand_wo(dsn,pcnt=0);

* Randomly select an approximate percentage of
* observations from a data set.
*
* Sample WITHOUT replacement;
*       any given observation can be selected only once
*       all observations have equal probability of selection.
*;

* Randomly select observations from &DSN;
data rand_wo;
   set &dsn;
   if ranuni(0) le &pcnt then output;
   run;
%mend rand_wo;
**********************;


**********************;
***11.2.3b
***%RAND_WO
**********************;
%macro rand_wo(dsn=,pcnt=0);
   %local obscnt;
   %let obscnt = %obscnt(&dsn);  
   %put obs count is &obscnt;

   * Randomly select observations from &DSN;
   data rand_wo(drop=cnt totl);
      * Calculate the number of obs to read;
      totl = ceil(&pcnt*&obscnt); 
      array obsno {&obscnt} _temporary_;  

      do until(cnt=totl);
         point = ceil(ranuni(0)*&obscnt);  
         if obsno{point} ne 1 then do;  
            * This obs has not been selected before;
            set &dsn point=point; 
            output;
            obsno{point}=1; 
            cnt+1;
         end;
      end;
      stop;
      run;
%mend rand_wo;
**********************;


**********************;
***11.2.3c
***%RAND_W
**********************;
%macro rand_w(dsn,numobs=0,pcnt=0);

* Randomly select either a specified number of
* observations or a percentage from a data set.
*
* Sample WITH replacement;
*       any observation can be selected any number of
*       times.

* When NUMOBS is specified create a subset of exactly
* that many observations (ignore PCNT).
* When PCNT is specified (and NUMOBS is not)
* calculate NUMOBS using PCNT*total number in DSN.
*;

* Randomly select &NUMOBS observations from &DSN;
data rand_w;
retain numobs .;
drop numobs i;

* Create a variable (NUMOBS) to hold number of obs
* to write to RAND_W;
%if &pcnt ne 0 and &numobs=0 %then %do; 
   * Use the percent to calculate a number of obs;
   numobs = round(nobs*&pcnt);
%end;
%else %do;
   numobs = &numobs; 
%end;

* Loop through the SET statement NUMOBS times;
do i = 1 to numobs;
   * Determine the next observation to read;
   point = ceil(ranuni(0)*nobs);

   * Read and output the selected observation;
   set &dsn point=point nobs=nobs  ;
   output;
end;
stop;
run;
%mend rand_w;
**********************;


**********************;
***11.2.4a
***%MAKECSV
**********************;
%macro makecsv(dsn,list,reg,miss,no=no);
options &no.mprint &no.mlogic &no.symbolgen;
%*  LIST   one or more blank separated clinic numbers;
%*         Blank to get all companies;
%*  REG    Region of interest
%*  MISS   are observations with missing weights allowed?
%*           ok       missing ok
%*           <other>  nonmissing only;

%local qlist wclause; 

%* Quote the words in the list and separate 
%* them with commas;
%let qlist =
     %str(%')%sysfunc(tranwrd(&list,%str( ),%str(',')))%str(%');

%* Build the WHERE clause;
%if &miss=ok %then %let wclause = wt ge .;  
%else wt ne .;
%if &reg ne %then %let wclause = &wclause & region="&reg"; 
%if %bquote(&list) ne  %then 
      %let wclause = &wclause & clinnum in(&qlist);  

data _null_;
   set &dsn(where=(%unquote(&wclause)));  
   file "c:\temp\makecsv.csv" dlm=',';
   if _n_=1 then put 'clinicnumber,clinicname,region,weight';
   put clinnum clinname region wt;
   run;
%mend makecsv;
**********************;


**********************;
***11.2.4b
***%FINDOUTLIERS
**********************;
%macro findoutliers(dsn=,prefix=,value=,op=ge, logicop=or);
%local i wclause;
proc contents data=&dsn noprint
              out=contdsn;
   run;

data _null_;
   set contdsn;
   if name =: %upcase("&prefix");
   cnt+1;
   charcnt= left(put(cnt,4.));
   call symput('var'||charcnt,trim(name)); 
   call symput('varcnt',charcnt); 
   run;

%if varcnt ge 1 %then %do;
   %let wclause= &var1 &op &value; 
   %if varcnt gt 1 %then %do i = 2 %to &varcnt;
      %* Build the where clause; 
      %let wclause = &wclause &logicop &&var&i &op &value;
   %end;

   data outliers;
      set &dsn(where=(&wclause)); 
      run;
%end;
%mend findoutliers;
**********************;


**********************;
***11.3
***%EXIST
**********************;
%macro exist(dsn);
%global exist;

%if %sysfunc(exist(&dsn)) %then %let exist=YES;
%else %let exist=NO;
%mend exist; 
**********************;            


**********************;
***11.4.1a
***
**********************;
*** create the transposed data set; 
proc transpose data=temp3 out=temp4 ; by group2 year &spvar ;
var mean ;
id group1 ; 
run ;
 
*** what variable names did proc transpose create? 
    the table VARLIST will contain just the variable 
    names of interest;
proc sql noprint ;
create table varlist as
select name
  from sashelp.vcolumn 
    where libname='WORK'
      and memtype='DATA'
      and memname='TEMP4'
      and not(name in ('GROUP2' 'YEAR' "%upcase(&spvar)" 
                      '_NAME_' '_LABEL_')) ;
quit ;

*** write short files of code to be included later that will
    create a space-delimited variable list ;
data _null_ ;
set varlist end=e ;
file 'temp2.sas' lrecl=70 ;
if _n_=1 then put '%let varlist= ' @ ; 
put name @ ;
if e then put ';' ;
run ;

%include 'temp2.sas' / source ; 
**********************;           


**********************;
***11.4.1b
***
**********************;
data _null_;
length name $32 str $500;
set temp4;
array allc {*}_character_; 
array alln {*}_numeric_; 
if dim(allc) then do i=1 to dim(allc); 
   call vname(allc{i},name); 
   * Exclude vars we know we do not want;
   if name not in('_NAME_' '_LABEL_' 'NAME' 'STR'
                 'GROUP2' 'YEAR' "%upcase(&spvar)" ) then
       str = trim(str)||' '||trim(name); 
end;
if dim(alln) then do i=1 to dim(alln);
   call vname(alln{i},name);
   str = trim(str)||' '||trim(name);
end;
call symput('varlist',str); 
stop; 
run; 
**********************;          


**********************;
***11.4.1c
***%GETVARS
**********************;
%Macro GetVars(Dset) ;
   %Local VarList ;
   /* open dataset */
   %Let FID = %SysFunc(Open(&Dset)) ; 
   /* If accessable, process contents of dataset */
   %If &FID %Then %Do ;
      %Do I=1 %To %SysFunc(ATTRN(&FID,NVARS)) ; 
        %Let VarList=                           &VarList %SysFunc(VarName(&FID,&I)); 
      %End ;
      /* close dataset when complete */
      %Let FID = %SysFunc(Close(&FID)) ;  
   %End ;
   &VarList 
%Mend ;  
**********************;        


**********************;
***11.4.1d
***%BUILDVARLIST
**********************;
/*----------------------------------------------------------
  NOTICE:
    This program is copyrighted by Michael Bramley, 2003. 
    All rights to this source code are retained. You may use
    and/or distribute this program as long as it 
    remains unaltered in any fashion or in any media.
    
  SYNOPSIS:
    This program contains a SAS macro function that will
    return a variable list from the specified dataset, where
    each variable name matches the "pattern", as described below.
    Note that within this macro and the following article
    "pattern" is defined to be a regular expression, as per
    SAS documentation. Moreover, each variable name is
    returned only once (even if it matches more than one pattern).

    For a thorough exposition of this macro, please refer to my
    SUGI 27 (37-27) article: Combining Pattern-Matching And File
    I/O Functions: A SAS® Macro To Generate A Unique Variable
    Name List.

  Report any bugs, unexpected results, inconsistent behaviour
    or desired new behaviour to Michael Bramley
    (mbramley@cinci.rr.com) with the subject line of 
    BUILDVARLIST SAS MACRO.


  FILE: BuildVarList.sas

  AUTHOR: Michael Bramley
  WRITTEN: January 4, 2001
  UPDATED: March 8, 2003

  MACRO CALL:
    %BuildVarList( Dset, Type, Patterns )

  WHERE:
    Dset     = SAS data set to obtain variable information from,
    Type     = Type of variables to include in list 
              (N=numeric only, C=character only,
               or blank for all types),
    Patterns = |-separated list of zero or more patterns to use
               for selecting variable names (see below).

  NOTES:
1.      This is a Macro Function, which means that it has a 
       return value of blank or a list of variable names 
       matching the pattern(s). As such, it can be used anywhere
       you would place a list of variable names, with the caveat
       that said usage includes blanks (in the case of no 
       variable names being returned).

2.      Specifying Type=N or C and blank for Patterns will result
       in a list of all numeric or character variables,
       respectively, similar to the _Numeric_ or _Character
       keywords in a datastep or Proc.

3.      Leaving the Type and Patterns blank will cause the macro
       to return a list of all variable names in the dataset. 

4.      Case is only respected if the pattern is quoted, for
       example, 'VAR' matches all variable names beginning with
       uppercase VAR.

5.      If more than one pattern is desired, then Patterns should
       be of the form:
       pattern-1|pattern-2|...|pattern-n. 
       The macro will process each pattern separately. Each
       pattern may be an expression containing (optionally)
       a prefix, asterisk, and/or suffix. The following case
       insensitive examples should help:

       Ex.1: DK*A will return all variable names that begin with
             DK and end with A,
       Ex.2: DK (or DK*) will return all variable names that 
             begin with DK,
       Ex.3: *A will return all variable names that end with
             A--the asterisk is required for this example.

  EXAMPLE:
    %Let MyVars = %BuildVar(TestData,,VAR) ;

    This assigns to the macro variable MyVar the value of a 
    space delimited list of all variable names that match the
    pattern "VAR*", regardless of type, where * may be 
    expanded into 0 to n characters. 
------------------------------------------------------------*/


%Macro BuildVarList( Dset, Type, Patterns ) ;
   /*
     Define local macro variables:
       VarList = list of variables matching pattern(s)
       VarName = name of current variable
       CurPat  = current pattern being used
       FID     = File IDentifier (for FILE I/O functions)
       RX      = Regular expression ID - SAS says "do not PUT..."
   */
   %Local VarList VarName CurPat FID RX I J ;

   /*
     Check Access to SAS data set.
   */
   %Let FID = %SysFunc( Open( &Dset ) ) ;
   %If Not &FID %Then %Do ;
       %Put ERROR: BuildVarList could not access &Dset.. ;
       %Go To Exit ;
   %End ;

   /*
     Check Type and Patterns. Default Type=NC to allow
     all variable types if none
     specified, otherwise validate Type.
   */
   %Let Type = %UpCase( &Type ) ;

   %If "&Type" EQ "" %Then
       %Let Type = NC ;
   %Else
       %If Not %Index( NC, &Type ) %Then %Do ;
           %Put ERROR: BuildVarList found invalid variable type of &Type.. Must be blank, N, or C. ;
           %Go To Exit ;
       %End ;

   /* 
     If Version 6.xx engine, ensure that the Patterns parameter
     is uppercase.
   */
   %If %Index( %SysFunc( AttrC( &FID, ENGINE) ), V6 ) %Then
       %Let Patterns = %UpCase( &Patterns ) ;

   /*
     If no Patterns specified, default to : to match all
     variables in data set.
   */
   %If "&Patterns" EQ "" %Then
       %Let Patterns = : ;

   /*
     BuildVarList Macro Main Processing Block: process
     patterns (separated by | <an or bar>) to generate
     variable list by calling SAS regular expression routines.

     NOTE: As some regular expressions may begin with SAS
           arithmetic operators, for example, + or *,
           it is imperative to quote them so that the SAS %Eval 
           function is not invoked in the %Do %While Loop.
   */
   %Let I = 1 ;
   %Let CurPat = %Scan( &Patterns, &I, | ) ;

   %Do %While( "&CurPat" NE "" ) ;
       %Let RX = %SysFunc( RXParse( &CurPat ) ) ;
       /*
       If pattern accepted by parser, then process variables
       in SAS data set.
       */
       %If &RX %Then %Do ;
           %Do J = 1 %To %SysFunc( AttrN( &FID, NVARS ) ) ;
               /*
               If Type matches, check variable name against
               pattern and add the variable name to the list
               (if it is not already included).
               */
               %If %Index( &Type, %SysFunc( VarType( &FID, &J ) ) ) %Then %Do ;
                   %Let VarName = %SysFunc( VarName( &FID, &J ) ) ;
                   %If %SysFunc( RXMatch( &RX, &VarName ) ) And
                       Not %Index( &VarList, &VarName ) %Then 
                           %Let VarList = &VarList &VarName ;
               %End ;
           %End ;

           %SysCall RXFree( RX ) ;
   %End ;
   %Else 
       %Put WARNING: BuildVarList detected an invalid pattern ("&CurPat")...ignoring. ;

      %Let I = %Eval( &I + 1 ) ;
      %Let CurPat = %Scan( &Patterns, &I, | ) ;
   %End ;
   /*
     Did any variable names match any of the pattern(s) ?
   */
   %If Not %Length( &VarList ) %Then
       %Put WARNING: BuildVarList found no variable names in &Dset matching specified pattern(s). ;
%Exit:
   %If &FID %Then
       %Let RX = %SysFunc( Close( &FID ) ) ;

   &VarList
%Mend BuildVarList ;

/*
  Include a test data set...(ignore the warnings...)
*/
Data Test1 ;
   Length Var1-Var6 4 ;
   Length Var1RT Var2RT Var3RT Var4RT T1 - T10 4 ;
   Length Var1A Var1b Var1C VarRT T1R T2R T3R  $10 ;
Run ;

/*
  Test the BuildVarList macro function...
*/
%Put Character Only = %BuildVarList( Test1, C ) ;
%Put Numeric   Only = %BuildVarList( Test1, N ) ;
%Put  All Variables = %BuildVarList( Test1 ) ;
%Put Var* Variables = %BuildVarList( Test1, , Var ) ;
%Put VAR* Variables = %BuildVarList( Test1, , 'VAR' ) ;

*** End of BuildVarList Macro ;
**********************;


**********************;
***11.4.2
***
**********************;
proc sql noprint;
   select distinct loc 
    into :loclist separated by ' '
    from samdat 
    order by loc; 
   quit;
**********************;


**********************;
***11.4.3a
***
**********************;
*determine the list of key vars;
data _null_;
* count the number of keyvars
* save each for later;
str="&keyfld"; 
do I = 1 to 6;
 key = scan(str,i,' ');
 if key ne ' ' then do;
  ii=left(put(i,1.));
  call symput('key'||ii, 
       trim(left(key)));
  call symput('keycnt',ii);
 end;
end;
run;
**********************;


**********************;
***11.4.3b
***
**********************;
%Macro keylist(keyfld);
%local I;
%global keycnt;
%let I = 1; 
%do %until (%scan(&keyfld,&I,%str( )) = %str()); 
   %global key&I;
   %let key&I = %scan(&keyfld,&I,%str( )); 
   %let I = %eval(&I + 1); 
%end;
%let keycnt = %eval(&I-1);
%mend keylist;
**********************;


**********************;
***11.4.4a
***%NW
**********************;
* nw.sas
*
* Counts the number of words in a string.
*
* Called by the macros CSTR and QSTR.
*
***********************************************;

%macro nw(string);

%local count word;
%global nw word1;

%let count=1; 

%let word=%qscan(&string,&count,%str( )); 
%let word1=&word;

%do %while(&word ne);
   %let count=%sysevalf(&count + 1); 
   %let word=%qscan(&string,&count,%str( )); 
   %global word&count;
   %let word&count=&word; 
%end;

%* nw  is the number of words;
%let nw=%eval(&count-1); 
%put %str(&nw);
%mend nw;
**********************;


**********************;
***11.4.4b
***%WORDCOUNT
**********************;                       
%macro wordcount(list);
   %* Count the number of words in &LIST;
   %local count;
   %let count=0;
   %do %while(%qscan(&list,&count+1,%str( )) ne %str());
      %let count = %eval(&count+1); 
   %end;
   &count
%mend wordcount;
**********************;


**********************;
***11.4.5a
***%CSTR
**********************;
* cstr.sas
*
* Puts commas into a character string
* e.g aa bb will become
*     aa,bb
*
*************************************;

%macro cstr(instring= , numx=2);

%* Count the number of words in the string;
%* Save the value in the macro variable NW;
%nw(&instring);

%global wrd&numx;  

%if &nw>0 %then %do;
   %let front=%str();  
   %let back=%str(,);  
   %do i=1 %to &nw;
      %* MID is the ith word;
      %let mid=%scan(&instring,&i);  

      %* The new string is stored in WRD and is built here;
      %if &i=1 %then %do;
         %let wrd=%str(&front&mid&back);  
      %end;
      %else %if &i>1 %then %do;
         %let wrd=%str(&wrd&front&mid&back);  
      %end;
   %end;

   %* Subtract 1 to eliminate the trailing comma;
   %let long=%eval(%length(&wrd)-1); 

   %* Save the new string in the macro var WRD&NUMX;
   %let wrd&numx=%substr(&wrd,1,&long); 
%end;

%*put %str(wrd&numx is &&wrd&numx);

%mend cstr;
**********************; 


**********************;
***11.4.5b
***%CSTR2
**********************;          
%macro cstr2(instring= , numx=2);

%* Count the number of words in the string;
%* Save the value in the macro variable NW;
%* Save the individual words in WORDi;
%nw(&instring)

%global wrd&numx;
%local wrd front back i; 

%let wrd&numx=; 

%if &nw>0 %then %do;
   %let front=%str();
   %let back=%str(,);
   %do i=1 %to &nw;
      %* From the NW macro &&word&i is the ith word;

      %* The new string is stored in WRD&numx and is 
      %* built here;
      %let wrd&numx=&&wrd&numx&front&&word&i;
      %* If this is not the last word add the separator;
      %if &i < &nw %then %let wrd&numx=&&wrd&numx&back;
   %end;
%end;
%mend cstr2;
**********************;


**********************;
***11.4.5c
***%CSTR3
**********************; 
%macro cstr3(list);
   %* Return a list of words as a comma separated list;
   %local clist count;
   %let count=0;  
   %let clist=; 
   %do %while(%qscan(&list,&count+1 ,%str( )) ne %str() );
      %let count = %eval(&count+1);
      %if &count >1 %then %let clist = &clist,;
      %let clist =&clist%qscan(&list,&count,%str( )); 
   %end;
   &clist 
%mend cstr3;
**********************;


**********************;
***11.4.6
***%QSTR
**********************;
* qstr.sas
*
* Put quotes around words in a character string 
* and then separate them with commas.
*
* e.g aa bb will become
*     'aa','bb'
*
***********************************;

%macro qstr(instring= , numx=1);

%* Count the number of words in the string;
%nw(&instring); 

%global wrd&numx; 

%if &nw>0 %then %do;
   %let front=%str(%'); 
   %let back=%str(%',); 
   %do i=1 %to &nw;
      %* Select the ith word;
      %let mid=%scan(&instring,&i);
      %if &i=1 %then %do;
         %* initialize the var used to hold the new string;
         %let wrd=%str(&front&mid&back);  
      %end;
      %else %if &i>1 %then %do;
         %* Build the new string;
         %let wrd=%str(&wrd&front&mid&back);
      %end;
   %end;

   %* Substract 1 to eliminate the trailing comma;
   %let long=%eval(%length(&wrd)-1);

   %* Save the new sting in the macro variable WRD&NUMX;
   %let wrd&numx=%substr(&wrd,1,&long); 
%end;

%*put %str(wrd&numx is &&wrd&numx);

%mend qstr; 
**********************;     


**********************;
***11.4.7
***%VAREXIST
**********************;
%macro varexist(dsn,varlist);
   %local dsid i ok var num rc;
   %let dsid=%sysfunc(open(&dsn,i));  
   %let i=1;
   %let ok=1;
   %let var = %scan(&varlist,&i);  
   %do %while(&var ne );
      %let num = %sysfunc(varnum(&dsid,&var));  
      %if &num=0 %then %let ok = 0; 
      %let i = %eval(&i+1); 
      %let var = %scan(&varlist,&i); 
   %end;
   %let rc = %sysfunc(close(&dsid)); 
   &ok 
%mend varexist;

%macro doit;
   %let list= name age sex gg;
   %if %varexist(sashelp.class,&list) %then %put all are on data set;
   %else %put missing var;
%mend doit;
%doit
**********************;


**********************;
***11.4.8
***%DISTINCTLIST
**********************;
%macro DistinctList(list);
   %local dlist i;
   %* Select the first word;
   %let dlist = %scan(&list,1,%str( ));  
   %let i=2;  
   %do %while(%scan(&list,&i,%str( )) ne %str());  
      %* There is another word. 
      %* Has it already been selected?;      %if %index(&dlist,%scan(&list,&i,%str( )))=0  %then %do;
         %* First occurence of this word add it to the list;
         %let dlist = &dlist %scan(&list,&i,%str( )); 
      %end;
      %* Increment counter to get the next word;
      %let i = %eval(&i+1); 
   %end;
   &dlist 
%mend distinctlist; 
**********************;    


**********************;
***11.4.9
***%INDVAR
**********************;
/****************************************************************
SYNTAX:
%indvar(datasetname,classvar,prefix_for_ind_var,basevar=)

This macro creates a series of indicator variables from a class-
variable and adds them to the dataset. The class-variable MUST be 
restricted to positive integers or zero. The prefix_for_ind_var is 
used as the prefix for names of the indicator variables.

A macro variable named prefix_for_ind_var is also created as a string.  
This string contains the names of all of the newly created indicator 
variables.  The names are separated by a space. By default 
(basevar=min), the indicator variable associated with the minimum 
value of the class-variable is excluded from this list (the indicator 
variable is still included on the data set).  Setting basevar=none 
excludes no names from the list.  A specific name can be excluded by 
setting basevar=x, where x is a value taken on by the class-variable.

EXAMPLE:
Consider a data set where the variable class takes on the 
values 1, 2 and 4.
             
  %indvar(&syslast,class,c)
             
Variables c1 c2 and c4 with values 0 or 1 are added to the data set.  
(c3 is always 0 since class is never 3 and therefore c3 is not created). 
Moreover the macro variable c equals "c2 c4" (c1 is omitted
since by default basevar=min and 1 is the minimum value of class).
If instead %indvar(&syslast,class,c,basevar=2) was called, c2 would be 
omitted from the macro variable. 
Basevar=none includes all.
****************************************************************/

%macro indvar(dataset,byvar,prefix,basevar=min);
%local item list value min;
%global &prefix;

  /* generate list */
  PROC SQL NOPRINT;
    SELECT DISTINCT &byvar INTO :list SEPARATED BY ' '
    FROM &dataset
    ORDER BY &byvar;
    SELECT min(&byvar) INTO :min
    FROM &dataset;
  QUIT;

  /* create variables */
  %LET item=1;
  %LET value = %scan(&list, &item) ;
  /* in other words: element no. &item in &list = &value */
  %LET &prefix= ; /* turns into a list of "all" ind variables */

  data &dataset;
    set &dataset;
    %IF &basevar=min %THEN %LET basevar=&min;; 
    %do %while( %quote(&value) ^= ) ;
      IF &byvar=&value THEN &prefix&value=1; ELSE &prefix&value=0;
      %IF %quote(&value)^=%quote(&basevar) %THEN 
        %LET &prefix=&&&prefix &prefix&value;; 
      %LET item = %eval( &item +1) ; 
      %let value = %scan( &list, &item );
    %end;
  run;
%put macro indvar created macro variable &prefix = &&&prefix;
%mend indvar;

data simple;
i=.; output;
i=0; output;
do i= 1 to 3,5;
 output;
end;
run;

%indvar(simple,i,ind,basevar= 2  )

proc print data=simple;
title 'A Simple data set when basevar is 2';
run;
**********************;


**********************;
***11.5.1
***%OBSCNT
**********************;
%macro obscnt(dsn); 
%local nobs;
%let nobs=.;

%* Open the data set of interest;
%let dsnid = %sysfunc(open(&dsn)); 

%* If the open was successful get the;
%* number of observations and CLOSE &dsn;
%if &dsnid %then %do; 
     %let nobs=%sysfunc(attrn(&dsnid,nlobs));
     %let rc  =%sysfunc(close(&dsnid)); 
%end;
%else %do; 
     %put Unable to open &dsn - %sysfunc(sysmsg());
%end;

%* Return the number of observations;
&nobs 
%mend obscnt;
**********************;


**********************;
***11.5.2
***%TESTPRT
**********************;
/************************************************************************ 
* Program: TestPrt.SAS                                                          * 
* Language:SAS 6.12/MACRO                                                  * 
*                                                                               * 
* Purpose:      This macro prints samples of the last dataset created for       * 
*               program testing                                                 * 
*                                                                                  * 
* Protocol:     %let test = 1;  *** Turn macro on;                         * 
*               %let obs = 10;  *** Print first 10 obs from dataset;       * 
*                                                                                  * *          %testPrt(&obs)  *** First &obs is printed;                    * 
*                                                                                  * 
* Author:       Jerry Kagan                                                     *
*               Kagan Associates, Inc.                                          *
*                                                                               *
*               jerrykagan@msn.com                                         *
*                                                                                  *
* Date:         29Jun1993                                                       *
*                                                                                  *
* Revisions:                                                                    *
* 21Feb97 JBK Modified to use new sysfunc for simplicity and efficiency *
**************************************************************************/ 
              
%macro TestPrt(obs); 
  %if &test %then 
  %do; 
    %let _dsid = %sysfunc(open(&syslast));
    %if &_dsid %then %do; 
      %let _nobs = %sysfunc(attrn(&_dsid,NOBS)); 
      %let _nvar = %sysfunc(attrn(&_dsid,NVARS)); 
      %let _rc = %sysfunc(close(&_dsid)); 
    %end; 
                                                                              
    proc print data=&syslast (obs=&obs) uniform; 
    %if &obs < &_nobs %then %do; 
      title1 "&syslast (Created with &_nobs observation(s) " 
        "& &_nvar variable(s), first &obs printed)"; 
    %end; 
    %else %do; 
      title1 "&syslast (Created with &_nobs observation(s) " 
        "& &_nvar variable(s), all printed)"; 
    %end; 
    run; 
  %end; 
%mend TestPrt; 
**********************;


**********************;
***11.5.3
***%NUMOBS
**********************;
%macro numobs(dsn);
%global numobs; 
data _null_;
   call symput('numobs',left(put(dsnobs,5.))); 
   stop; 
   set &dsn nobs=dsnobs; 
   run;
%mend numobs;
**********************;


**********************;
***11.5.4
***%COUNTER
**********************;
/*--------------------------------------------------------------
|                          COUNTER                               |
|                          ---------                            |
| The number of observations contained in the input dataset,    | 
| after completion of the datastep, is stored in the macro      | 
| variable.                                                     |
|                                                               |
|---------------------------------------------------------------|
| Parameter| Default|Description                                |
|---------------------------------------------------------------|
| DATA     | _Last_ |Optional:  Data source to count number of  |
|          |        |           observations.                   |
| INTO     | Counter|Optional:  Macro variable to store number  |
|          |        |           of observations.                |
|---------------------------------------------------------------|
| Usage         : %COUNTER(NEWDAT,NOOBS);                           |
|                       ^      ^                                |
|                       |      - Macro variable to store count  |
|                       - Dataset name                          |
|                                                               |
| Note(s)       : Datasets may be empty, but must have at least one |
|                 variable, and therefore must exist.               |
|                                                               |
| Written by    : David Shannon, V1, 14/4/97, V6.10+             |
| Bugs to       : David@schweiz.demon.co.uk                      |
|References: Getting Started With the SQL Procedure, S.I., 1994.|
--------------------------------------------------------------*/;

%MACRO Counter(data,into);

%***************************************************************;
%* Define local macro variables(those only referred to locally)*;

%Local DATA INTO;

%***************************************************************;
%* Set defaults if not provided in positional macro call.      *;

%If &DATA EQ %Then %Let DATA=_last_;
%If &INTO EQ %Then %Let INTO=COUNTER;

%***************************************************************;
%* Make output variable global,                                *;
%* hence can be referred to outside this macro.                *;

%Global &INTO;
              
%***************************************************************;
%* Count observations,                                         *;
%* store result in the global macro variable                   *;

Proc Sql Noprint;
     Select count(*) into:&INTO
     From &DATA;
Quit;

%PUT Counted &&&INTO observations.;
%PUT Stored in macro variable &INTO..   ;

%MEND Counter ;
**********************;

**********************;
***12.3.2
***%LEFT
**********************;
%macro left(text);
%*********************************************************************;
%*                                                                   *;
%*  MACRO: LEFT                                                      *;
%*                                                                   *;
%*  USAGE: 1) %left(argument)                                        *;
%*                                                                   *;
%*  DESCRIPTION:                                                     *;
%*    This macro returns the argument passed to it without any       *;
%*    leading blanks in an unquoted form. The syntax for its use     *;
%*    is similar to that of native macro functions.                  *;
%*                                                                   *;
%*    Eg. %let macvar=%left(&argtext)                                *;
%*                                                                   *;
%*  NOTES:                                                           *;
%*    The %VERIFY macro is used to determine the first non-blank     *;
%*    character position.                                            *;
%*                                                                   *;
%*********************************************************************;
%local i;
%if %length(&text)=0 %then %let text=%str( );
%let i=%verify(&text,%str( ));
%if &i  %then %substr(&text,&i);
%mend;
**********************;


**********************;
***12.3.3
***%CMPRES
**********************;
%macro cmpres(text);
%*********************************************************************;
%*                                                                   *;
%*  MACRO: CMPRES                                                    *;
%*                                                                   *;
%*  USAGE: 1) %cmpres(argument)                                      *;
%*                                                                   *;
%*  DESCRIPTION:                                                     *;
%*    This macro returns the argument passed to it in an unquoted    *;
%*    form with multiple blanks compressed to single blanks and also *;
%*    with leading and trailing blanks removed.                      *;
%*                                                                   *;
%*    Eg. %let macvar=%cmpres(&argtext)                              *;
%*                                                                   *;
%*  NOTES:                                                           *;
%*    The %LEFT and %TRIM macros in the autocall library are used    *;
%*    in this macro.                                                 *;
%*                                                                   *;
%*********************************************************************;
%local i;
%let i=%index(&text,%str(  ));
%do %while(&i^=0);
  %let text=%qsubstr(&text,1,&i)%qleft(%qsubstr(&text,&i+1));
  %let i=%index(&text,%str(  ));
%end;
%left(%qtrim(&text))
%mend;
**********************;


**********************;
***12.3.4
***%LOWCASE
**********************;
%macro lowcase(string);
%*********************************************************************;
%*                                                                   *;
%*  MACRO: LOWCASE                                                   *;
%*                                                                   *;
%*  USAGE: 1) %lowcase(argument)                                     *;
%*                                                                   *;
%*  DESCRIPTION:                                                     *;
%*    This macro returns the argument passed to it unchanged         *;
%*    except that all upper-case alphabetic characters are changed   *;
%*    to their lower-case equivalents.                               *;
%*                                                                   *;
%*  E.g.:          %let macvar=%lowcase(SAS Institute Inc.);        %*;
%*  The variable macvar gets the value "sas institute inc."          *;
%*                                                                   *;
%*  NOTES:                                                           *;
%*    Although the argument to the %UPCASE macro function may        *;
%*    contain commas, the argument to %LOWCASE may not, unless       *;
%*    they are quoted.  Because %LOWCASE is a macro, not a function, *;
%*    it interprets a comma as the end of a parameter.               *;
%*                                                                   *;
%*********************************************************************;
%local i length c index result;
%let length = %length(&string);
%do i = 1 %to &length;
   %let c = %substr(&string,&i,1);
   %if &c eq %then %let c = %str( );
   %else %do;
      %let index = %index(ABCDEFGHIJKLMNOPQRSTUVWXYZ,&c);
      %if &index gt 0 %then
           %let c = %substr(abcdefghijklmnopqrstuvwxyz,&index,1);
      %end;
   %let result = &result.&c;
   %end;
&result
%mend;
**********************;


**********************;
***12.3.5
***%TRIM
**********************;
%macro trim(value);
%*******************************************************;
%*                                                     *;
%*  MACRO: TRIM                                        *;
%*                                                     *;
%*  USAGE: 1) %trim(argument)                          *;
%*                                                     *;
%*  DESCRIPTION:                                       *;
%*    This macro returns the argument passed to it     *;
%*    without any trailing blanks in an unquoted form. *;
%*    The syntax for its use is similar to that of     *;
%*    native macro functions.                          *;
%*                                                     *;
%*    Eg. %let macvar=%trim(&argtext)                  *;
%*                                                     *;
%*  NOTES:                                             *;
%*    None.                                            *;
%*                                                     *;
%*******************************************************;
  %local i;
  %do i=%length(&value) %to 1 %by -1; 
    %if %qsubstr(&value,&i,1)^=%str( ) %then %goto trimmed; 
  %end;
  %trimmed: %if &i>0 %then %substr(&value,1,&i); 
%mend;
**********************;


**********************;
***13.1.2
***%SUMS
**********************;
%macro sums(prefix, suffix, stopnum);
  &&prefix&&&suffix=sum(of &prefix.1-&&prefix&&&stopnum);
%mend sums;

%let total=4;
%let numtreat=3;

data freqpref;
drop i;
array lst {&numtreat} pref1 - pref&numtreat;
do body = 1 to 5;
  do i = 1 to &numtreat;
     lst{i} = int(ranuni(9999)*10);
  end;
  output;
end;
run;

data freqbody;
drop i;
array lst {&numtreat} body1 - body&numtreat;
do body = 1 to 5;
  do i = 1 to &numtreat;
     lst{i} = int(ranuni(9999)*5);
  end;
  output;
end;
run;

data event;
drop i;
array lst {&numtreat} event1-event&numtreat;
do body = 1 to 5;
  do i = 1 to &numtreat;
     lst{i} = int(ranuni(9999)*3);
  end;
  output;
end;
run;

%let total=4;
%let numtreat=3;
%sums(pref,  total, numtreat)

data counts(drop=j);
  merge freqpref freqbody event;
  by body;
  array zeroes{*} _numeric_;
  do j=1 to dim(zeroes);
    if zeroes{j}=. then zeroes{j}=0;
  end;
  %sums(pref,  total, numtreat)
  %sums(body,  total, numtreat)
  %sums(event, total, numtreat)
run;

proc print data=counts;
id body;
title1 'Counts and Totals';
run;
**********************;


**********************;
***13.1.3
***%GETKEYS
**********************;
%macro getkeys(inlib ,indsn );
* getkeys.sas
* 25Jun97 - ROSmith
* macro to get the key variables for selected library & member.
* assumes that the global macros for the databases & keys are created.
* Outputs a macro variable KEYVARS.
*;

%do k = 1 %to &&&inlib.cnt;
   %if %upcase(&indsn ) = %upcase(&&&inlib.db&k ) %then
        %let KEYVARS = &&KEYS&k;
%end;

%mend getkeys;
**********************;


**********************;
***13.1.4a
***%SMARTPERM
**********************;
%macro smartperm(n,r);
   %local perm val; 
   %let perm=1; 
   %let val= &n; 
   %do %while(&val > %eval(&n - &r));  
      %let perm = %eval(&perm*&val);  
      %let val = %eval(&val-1);  
   %end;
   &perm  
%mend smartperm;
**********************;


**********************;
***13.1.4b
***%SMARTPERM2
**********************;
%macro smartperm2(n,r);
   %local perm val;
   %let perm=1;
   %do val = &n %to %eval(&n - &r + 1) %by -1;
      %let perm = %eval(&perm*&val);
   %end;
   &perm 
%mend smartperm2;
**********************;


**********************;
***13.1.5
***%SYMCHK
**********************;
%macro symchk(name);

%if %nrquote(&&&name)=%nrstr(&)&name %then
    %let yesno=NO;

%else %let yesno=YES;

&yesno
%mend symchk;

%put 'Does &tmp exist? ' %symchk(tmp);
**********************;


**********************;
***13.1.6a
***
**********************;
proc sql noprint;
   select distinct NAME
      into :maclist separated by ' '
         from dictionary.macros
            where upcase(SCOPE) eq 'GLOBAL' 
                and NAME NE 'maclist';
   quit;

%symdel &maclist maclist;
**********************;


**********************;
***13.1.6b
***%DELVARS
**********************;
%macro delvars;
%local maclist;
proc sql noprint;
   select distinct NAME
      into :maclist separated by ' '
         from dictionary.macros
            where upcase(SCOPE) eq 'GLOBAL';
   quit;

%symdel &maclist;
%mend delvars;
**********************;


**********************;
***13.1.6c
***%DELVARS
**********************;
%macro delvars(mlist);
   %unquote(%nrstr(%symdel) &mlist);
%mend delvars;
**********************;


**********************;
***13.1.6d
***%DELVARS
**********************;
%macro delvars;
  data vars;
    set sashelp.vmacro;
  run;
  data _null_;
    set vars;
    if scope='GLOBAL' then
      call execute('%symdel '||trim(left(name))||';');
   end;
  run;
%mend delvars;
**********************;


**********************;
***13.2.2
***%DBVAL
**********************;
data _null_;
set counts (keep=body  pref1 pref2 body1 body2);
array vlist {4} pref1 pref2 body1 body2;
length name $8 ii jj $2;
i+1;
ii = trim(left(put(i,2.)));
call symput('rowcnt',ii);
if i=1 then call symput('colcnt','4');

* Store values for this row;
rowname = 'r'||ii||'c';

* Step through the values for this observation;
do j = 1 to 4;
   jj= left(put(j,2.));

   * Save the value for this row and column;
   call symput(trim(compress(rowname))||jj,vlist{j});

   * Save the variable name;
   call vname(vlist(j),name);
   if i=1 then call symput('vname'||jj,name);
end;
run;


%let rr = 4;
%let cc = 3;
%put Row &rr and col &cc (%cmpres(&&vname&cc)) is %left(&&r&rr.c&cc);

%macro dbval(maxrow,maxcol);
   %put row  col  value;
   %do row = 1 %to &maxrow;
      %do col = 1 %to &maxcol;
         %put &row    &col    %left(&&r&row.c&col);
      %end;
   %end;
%mend dbval;

%dbval(&rowcnt, &colcnt)
**********************;


**********************;
***13.2.3
***%MATRIXPRINT
**********************;
DATA dbdir;
   length dsn $8 page $1 keyvar $30 RPTTYPE $1;
   input  @4 DSN $  @15 PAGE $   KEYVAR $20 47 @50 RPTTYPE $;
   datalines;
   DEMOG      1    SUBJECT                       D
   MEDHIS     2    SUBJECT MEDHISNO SEQNO        D
   PHYSEXAM   3    SUBJECT VISIT REPEATN SEQNO   E
   VITALS     4    SUBJECT VISIT SEQNO REPEATN   R
   run;

* Print a series of data sets using a BY list;
%macro matrixprint(control,varlist);
   %local vcnt i;
   %let vcnt=0;
   %* Count and save the variable names in VARLIST;  
   %do %while(%scan(&varlist,%eval(&vcnt+1),%str( )) ne %str());
      %let vcnt = %eval(&vcnt+1);  
      %local var&vcnt; 
      %let var&vcnt = %trim(%left(%qscan(&varlist,&vcnt,%str( ))));
   %end;

   * Save all the selected data set values in macro;
   * vars                                          ;
   data _null_;  
      set &control(keep=&varlist);
      rownum=left(put(_n_,6.));
      %do i = 1 %to &vcnt;
         call symput("&&var&i"||rownum,&&var&i);  
      %end;
      call symput('rowcnt',rownum);  
      run;
   %do i = 1 %to &rowcnt;
      proc print data=&&&var1&i(where=(&var4="&&&var4&i")); 
         by &&&var2&i;  
         run;
   %end;

%mend matrixprint;

%matrixprint(dbdir,dsn keyvar page rpttype)
**********************;

 
**********************;
***13.2.4a
***%SYMBOLSYNC
**********************;
%macro symbolsync(dsn,dosevar);
%local dose j doselist numdose;
%local symbols linetype;

%let symbols  = dot circle square diamond;  
%let linetype = 1 2 33 6; 

goptions reset=symbol;

proc sql noprint;
   select count (distinct &dosevar) into: numdose, 
          distinct &dosevar into: doselist separated by ' '
      from &dsn;
   quit;

%do j=1 %to &numdose;  

   %let dose=%scan(&doselist, &j);  

   symbol&j v=%scan(&symbols, &dose)  
            l=%scan(&linetype,&dose) 
             i=j c=black f= ;
%end;
%mend symbolsync;     

data drug;
  input dose time result @@;
 datalines;
  3 1 10 3 2 20 2 1 23 3 3 30 3 4 40 3 5 45 
  2 2 31 2 3 35 2 4 17 4 1 40 4 2 32 4 3 18
  4 4 24 4 5 16 1 1 30 1 2 40 1 3 20 1 4 30
  1 5 35 2 5 13
run;

* Demonstrate that dot is not used when dose 
* level 1 is not present;
data drug;
  set drug;
  where dose in (2,3,4);
run;

%symbolsync(drug,dose)

proc gplot data=drug;
   plot result*time=dose;
run;
**********************;

 
**********************;
***13.2.4b
***%SYMBOLSYNC2
**********************;
%macro symbolsync2(dsn,dosevar);
%local dose j doselist numdose;
%local allcodes symbols linetype;

%let allcodes = a1 b1 b2 c; 
%let symbols  = dot circle square diamond;
%let linetype = 1 2 33 6;

goptions reset=symbol;

proc sql noprint;
   select count (distinct &dosevar) into: numdose, 
          distinct &dosevar into: doselist separated by ' '
      from &dsn;
   quit;

%do j=1 %to &numdose;

   %let dose=%revscan(&allcodes,%scan(&doselist,&j)); 

   symbol&j v=%scan(&symbols, &dose) 
            l=%scan(&linetype,&dose) 
            i=j c=black f= ;
%end;
%mend symbolsync2;     


data drug;
  input dose $ time result @@;
 datalines;
  b2 1 10 b2 2 20 b1 1 23 b2 3 30 b2 4 40 b2 5 45 
  b1 2 31 b1 3 35 b1 4 17 c  1 40 c  2 32 c  3 18
  C  4 24 c  5 16 a1 1 30 a1 2 40 a1 3 20 a1 4 30
  A1 5 35 b1 5 13
run;

* Demonstrate that dot is not used when dose 
* level 1 (dose='A1') is not present;
data drug;
  set drug;
  where dose in ('b1','b2','c');
run;

%symbolsync2(drug,dose)

proc gplot data=drug;
   plot result*time=dose;
run;
**********************;


**********************;
***13.3.5a
***%TRYIT %INSIDE
**********************;
%let a = global_var; 

%macro tryit;
   %let at = var_local_to_tryit; 
   %inside
%mend tryit;

%macro inside;
   %let b=var_on_the_inside_table;
   %put **All Current Vars;
   %put _user_;
%mend inside;

%tryit
%put **** Open code Macro vars;
%put _user_;
**********************;


**********************;
***13.3.5b
***%TRYIT
**********************;
%macro tryit;
   *%let dattype = ae;
   %let dattype = demog;
   *%let dattype = meds;
   **********************;

   %put data type is &dattype;
%mend tryit;
**********************;


**********************;
***13.3.5c
***QUIZ
**********************;
%macro abc;
   *%put in abc;
%mend abc;

%macro doit;
   *%abc 
   %put here;
   *%let x = %abc; 
   %put value of x is &x;
%mend doit;
%doit   * run doit;
**********************;

**********************;
***13.3.5d
***%WORDCNT
**********************; 
%macro wrdcnt(string);
%let cnt=0;
%do %while(%scan(&string,&cnt+1,%str( )) ne %str());
   %let cnt = %eval(&cnt+1);
%end;
&cnt
%mend wrdcnt;
**********************;

**********************;
***13.3.5e
***%CHECKIT
**********************;
%macro checkit(val);
   %if -5 le &val le 0 %then %put &val is in neg range (-5 to 0);
   %if 1 le &val le 5 %then %put &val is in pos range (1 to 5);
%mend checkit;
**********************;


**********************;
***13.4.1
***%DEMO
**********************;
%macro demo(a=1, b=2)/parmbuff; 
%put buffer holds &syspbuff; 
%put var A is &a; 
%put var B is &b; 
%mend demo;

%demo(a=aa) 
**********************;


**********************;
***13.4.2a
***%IN
**********************;
%macro in() / parmbuff; 
  %let parms = %qsubstr(&syspbuff,2,%length(&syspbuff)-2); 

  %let var = %scan(&parms,1,%str(,)); 

  %let numparms = %eval(%length(&parms) -
                        %length(%sysfunc(compress(&parms,%str(,)))));

  %let infunc = &var eq %scan(&parms,2,%str(,));

  %do i = 3 %to (&numparms + 1); 
    %let thisparm = %scan(&parms,&i,%str(,)); 
    %let infunc = &infunc or &var eq &thisparm; 
  %end;

  (&infunc) 
%mend;
**********************;


**********************;
***13.4.2b
***%ORLIST
**********************;
%macro ORlist() / pbuff;
   %local datvar i parm orlist;
   %let datvar = %qscan(&syspbuff,1,%str(%(,));
   %let i = 1;
   %do %while(%qscan(&syspbuff,&i+1,%str(,%(%))) ne %str());
      %let parm = %qscan(&syspbuff,&i+1,%str(,%(%)));
      %if &i=1 %then %let orlist = &datvar=&parm;
      %else %let orlist = &orlist or &datvar=&parm;
      %let i = %eval(&i + 1);
   %end;
   &orlist
%mend orlist;
**********************;


**********************;
***13.5
***%FACT
**********************;
%macro fact(n);
  %if &n > 1 %then %eval(&n * %fact(%eval(&n-1))); 
  %else 1; 
%mend fact;
**********************;


**********************;
***13.6
***%CNTMALES
**********************;
%macro cntmales;
   %local cntmales; 
   data malesonly;
      set sasclass.clinics end=eof;
      if sex='M' then cnt+1;
      if eof then call symput('cntmales',left(put(cnt,3.)));
%mend cntmales;

%cntmales
title "Number of Males is &cntmales";
proc print data=malesonly;
   run;
**********************;


**********************;
***A1.2.1
***
**********************;
LIBNAME SASCLASS 'd:training\sas\sasclass';
                    
%let dsn = clinics;
%let var1 = edu;
%let var2 = dob;
%let type = mean;
                    
PROC PLOT DATA=SASCLASS.&dsn;
      PLOT &var1 * &var2;
      TITLE1 'YEARS OF EDUCATION COMPARED TO BIRTH DATE';
RUN;

PROC CHART DATA=SASCLASS.&dsn;
      VBAR WT / SUMVAR=HT TYPE=&type;
      TITLE1 'AVERAGE HEIGHT FOR WEIGHT GROUPS';
RUN;
**********************;


**********************;
***A1.2.3
***
**********************;
%let dsn=clinic;
%let lib=sasuser;
%let i=3;
%let dsn3 = studydrg;
%let b=dsn;

%put '&lib&dsn ' &lib&dsn;
%put '&lib.&dsn ' &lib.&dsn;
%put '&lib..&dsn ' &lib..&dsn;

%put '&dsn&i ' &dsn&i;
%put '&&dsn&i ' &&dsn&i;
%put '&dsn.&i ' &dsn.&i;

%put '&&bb ' &&bb;
%put '&&&b ' &&&b;

* Extra credit;
%put '&dsn..&&dsn&i ' &dsn..&&dsn&i;
**********************;


**********************;
***A1.3.1 A1.3.2
***
**********************;
LIBNAME SASCLASS 'd:training\sas\sasclass'; 
                    
%let dsn = clinics;
%let var1 = edu;
%let var2 = dob;
%let type = mean;


options mlogic mprint symbolgen;
%macro plotit;
PROC PLOT DATA=SASCLASS.&dsn;
      PLOT &var1 * &var2;
      TITLE1 'YEARS OF EDUCATION COMPARED TO BIRTH DATE';
RUN;

PROC CHART DATA=SASCLASS.&dsn;
      VBAR WT / SUMVAR=HT TYPE=&type;
      TITLE1 'AVERAGE HEIGHT FOR WEIGHT GROUPS';
RUN;
%mend plotit;
%plotit
**********************;


**********************;
***A1.4.3
***
**********************;
LIBNAME SASCLASS 'd:training\sas\sasclass';

options mlogic mprint symbolgen;
%macro plotit(var1, var2, dsn=);
PROC PLOT DATA=SASCLASS.&dsn;
      PLOT &var1 * &var2;
      TITLE1 'YEARS OF EDUCATION COMPARED TO BIRTH DATE';
RUN;

PROC CHART DATA=SASCLASS.&dsn;
      VBAR WT / SUMVAR=HT TYPE=MEAN;
      TITLE1 'AVERAGE HEIGHT FOR WEIGHT GROUPS';
RUN;
%mend plotit;
%plotit(edu,dob,dsn=clinics)
**********************;


**********************;
***A1.5.2
***%LOOP1 %LOOP2 %LOOP3
**********************;
%macro loop1;
  %do cnt = 1 %to 10;
     %put This is Test &cnt;
  %end;
%mend loop1;

%macro loop2;
  %let cnt=1;
  %do %while(&cnt <= 10);
     %put This is Test &cnt;
     %let cnt = %eval(&cnt + 1);
  %end;
%mend loop2;

%macro loop3;
  %let cnt=1;
  %do %until(&cnt > 10);
     %put This is Test &cnt;
     %let cnt = %eval(&cnt + 1);
  %end;
%mend loop3;

%put loop1; %loop1
%put loop2; %loop2
%put loop3; %loop3
**********************;


**********************;
***A1.5.6
***%GENPROC
**********************;
%macro genproc(proc,dsn,varlst);
   proc &proc data=&dsn;
      var &varlst;
      title1 "&proc Procedure for &varlst";
   run;
%mend genproc;

%genproc(means,sasclass.clinics, edu ht wt)
%genproc(univariate,sasclass.clinics, edu ht wt)
**********************;


**********************;
***A1.5.7
***%MYMEANS
**********************;
%macro mymeans(dsn, varlst, statlst, 
              outdsn, print=noprint);
proc means data=&dsn &statlst 
  %if &outdsn = %then print; 
  %else &print;; 

var &varlst;
%if &outdsn ne %then %do;
  output out=&outdsn mean= max= / autoname;
%end; ?
run;
%mend mymeans;

* print selected stats (no output data set);
%mymeans(class.clinics, ht wt, mean stderr) 

* no printed stats (output data set only);
%mymeans(sasclass.clinics, ht wt,,outstat) 
proc print data=outstat;
run;

* printed stats & an output data set ;
%mymeans(sasclass.clinics, ht wt,sum max,outstat,print=print)
**********************;


**********************;
***A1.5.10
***%ALLYEAR
**********************;%MACRO ALLYR(START,STOP);
   %LOCAL YEAR YR;
   %LET YEAR = &START;
   %DO %WHILE(&YEAR <= &STOP);
      %IF &YEAR <= 20 %THEN 
            %LET YR =%EVAL(2000 + &YEAR);
      %ELSE %LET YR= %EVAL(1900 + &YEAR);
      DATA TEMP;
         SET YR&YEAR;
         RETAIN YEAR &YR;
         RUN;
      PROC APPEND BASE=ALLYEAR DATA=TEMP;
         RUN;

      %LET YEAR = %EVAL(&YEAR + 1);
   %END;
%MEND ALLYR;

data yr19 yr20 yr21;
x=19; output yr19;
x=20; output yr20;
x=21; output yr21;
run;
%allyr(19,21)
**********************;


**********************;
***A1.6.2
***%PLOTIT
**********************;
libname sasclass 'd:\training\sas\sasclass';

%MACRO PLOTIT;
   PROC SORT DATA=SASCLASS.CLINICS OUT=CLINICS;
      BY REGION;
      RUN;
   DATA _NULL_;
      SET CLINICS;
      BY REGION;
      IF FIRST.REGION THEN DO;
         I+1;
         II=LEFT(PUT(I,2.));
         CALL SYMPUT('REG'||II,REGION); 
         CALL SYMPUT('TOTAL',II); 
      END;
      RUN;

   data
     %* Build the names of the new data sets;
     %do i = 1 %to &total; 
       reg&i
     %end;
     ;
     set clinics;
     %do i = 1 %to &total;
       %* Build the output statements;
       %if &i=1 %then if region='1' then output reg1;
       %else else if region="&i" then output reg&i;
         ;
      %end;

   * Plot the &total regions one at a time;
   %DO I=1 %TO &TOTAL; 
      PROC GPLOT DATA=reg&i;
         PLOT HT * WT;
         TITLE1 "Height/Weight for REGION &I";
      RUN;
   %END;
%MEND PLOTIT;

%plotit
**********************;


**********************;
***A1.6.3
***%PLOTIT
**********************;
libname sasclass 'd:\training\sas\sasclass';

%MACRO PLOTIT;
   PROC SORT DATA=SASCLASS.CLINICS OUT=CLINICS;
      BY REGION;
      RUN;
   DATA _NULL_;
      SET CLINICS;
      BY REGION;
      IF FIRST.REGION THEN DO;
         I+1;
         II=LEFT(PUT(I,2.));
         CALL SYMPUT('REG'||II,REGION);
         CALL SYMPUT('TOTAL',II);
      END;
      RUN;

   data  %do i = 1 %to &total; r&&reg&i %end;; 
      set clinics;
      %* Build the &total output statements;
      %do i = 1 %to &total;
         %if &i>1 %then else;
         if region="&&reg&i" then output r&&reg&i;
      %end;
   run;

%DO I=1 %TO &TOTAL;
 PROC GPLOT DATA=r&&reg&i;
  PLOT HT * WT;
  TITLE1 "Height/Weight for REGION &&REG&I";
  RUN;
 %END;
%MEND PLOTIT;

%plotit
**********************;


**********************;
***A1.6.4
***%ALLCHAR
**********************;
%macro allchar(dsn);
* Determine the numeric vars in &dsn;
proc contents data=&dsn out=cont noprint;
run;

* Create the macro variables for each numeric var;
data _null_;;
set cont(keep=name type format formatl formatd label);
length fmt $15;
where  type=1;

* Count the numeric vars and save the total number;
i+1;
ii=left(put(i,3.));
call symput('n',ii);

* create a format string;
fmt = 'best.';
if format ne ' ' then fmt = trim(format)
    ||trim(left(put(formatl,3.)))
    ||'.'||left(put(formatd,3.));
fmt = compress(fmt);
call symput('fmt'||ii,fmt);

* Save the variable name;
call symput('name'||ii,name);

* Save the label for this variable;
if label = ' ' then label = name;
call symput('label'||ii,label);
run;

* Establish a data set with only character variables;
* &n       number of numeric variables in &dsn;
* __aa&i   temporary var to hold numeric values;
* &&name&i name of the variable to covert from numeric;
*
* The numeric value of &name1 is stored in __aa1
* by renaming the variable in the SET statement.  __aa1
* is then converted to character and stored in the
* 'new' variable &name1 in the data set CHARONLY.
* ;
data charonly (drop=
   %* Drop the temp. vars used to hold numeric values;
   %do i=1 %to &n;
      __aa&i
   %end;
    );
length
   %* Establish the vars as character;
   %do i=1 %to &n;
      &&name&i
   %end;
    $8;

set &dsn (rename=(
   %* Rename the incoming numeric var to a temp name;
   %* This allows the reuse of the variables name;
   %do i=1 %to &n;
      &&name&i=__aa&i
   %end;
   ));

   * Convert the numeric values to character;
   %do i=1 %to &n;
      &&name&i = left(put(__aa&i,&&fmt&i));
      label &&name&i = "&&label&i";
   %end;
run;

proc contents data=charonly;
proc print data=charonly;
run;
%mend allchar;

%allchar(sasclass.biomass)
**********************;


**********************;
***A1.7.4
***%COUNT
**********************;
* Count the number of words in a string
* see p256 in SAS Guide to Macro Processing;

%macro count(string,parm);
   %local word; 
   %if &parm= %then %let parm = %str( ); 
   %let count=1;
   %let word = %qscan(&string,&count,&parm); 
   %do %while(&word ne);
      %let count = %eval(&count+1);
      %let word = %qscan(&string,&count,&parm);
   %end;
   %put word count for |&string| is %eval(&count-1);
%mend count;

%count(this is a short string) 
%count(%nrstr(this*&is*a*string),%str(*))
**********************;


**********************;
***A1.7.5a***%NAMEONLY
**********************;
%macro nameonly(dsn);
%local len col name;

%let len = %length(&dsn);
%let col = %index(&dsn,.);
%let name = %substr(&dsn,%eval(&col+1),%eval(&len-&col));
&name
%mend nameonly;

%put name is %nameonly(sasclass.biomass);
**********************;


**********************;
***A1.7.5b (Extra Credit)
***%NAMEONLY
**********************;
%macro nameonly(dsn);
   %scan(&dsn,2,.)
%mend nameonly;
**********************;


**********************;
***A1.7.6
***%REVSCAN
**********************;
%macro revscan(list, word);
   %local wcnt wnum;
   %let wcnt=0;
   %let wnum=0;
   %* Determine the word number in a list of words;
   %do %while(%scan(&list,%eval(&wcnt+1),%str( )) ne %str() & &wnum=0);
      %let wcnt = %eval(&wcnt+1);
      %if %upcase(%scan(&list,&wcnt,%str( )))=%upcase(&word) %then
         %let wnum=&wcnt;
   %end;
   &wnum
%mend revscan;

%put %revscan(aa a bb cc a dd,a);
**********************;


**********************;
***A1.13
***
**********************;
%macro abc;
   A%put in abc;
%mend abc;

%macro doit;
   *%abc  
   %put here; 
   B%let x = %abc; 
   %put value of x is &x;
%mend doit;
**********************;


**********************;
***A5.1
***BIOMASS.SAS
**********************;
*************************************************;
* biomass.sas;
*
* Create the benthos biomass data set.
*************************************************;
                    
data sasclass.biomass;
input @1  STATION $
      @12 DATE DATE7.
           @20 BMPOLY
           @25 BMCRUS
           @31 BMMOL
           @36 BMOTHR
           @41 BMTOTL ;
                    
format date date7.;
                    
label 
BMCRUS  = 'CRUSTACEAN BIOMASS (GM WET WEIGHT)'
BMMOL   = 'MOLLUSC BIOMASS (GM WET WEIGHT)  '
BMOTHR  = 'OTHER BIOMASS (GM WET WEIGHT)    '
BMPOLY  = 'POLYCHAETE BIOMASS (GM WET WEIGHT)'
BMTOTL  = 'TOTAL BIOMASS (GM WET WEIGHT)    '
DATE    = 'DATE                                 '
STATION = 'STATION ID                           ';
                    
datalines;
DL-25             18JUN85 0.4   0.03    0.17    0.02    0.62
DL-60             17JUN85 0.51  0.09    0.14    0.08    0.82
D1100-25   18JUN85 0.28 0.02    0.01    4.61    4.92
D1100-60          17JUN85 0.36  0.05    0.32    0.47    1.2
D1900-25          18JUN85 0.03  0.02    0.11    1.06    1.22
D1900-60          17JUN85 0.54  0.11    0.03    4.18    4.86
D3200-60          17JUN85 0.52  0.14    0.04    0.05    0.75
D3350-25          18JUN85 0.18  0.02    0.11    0          0.31
D6700-25          18JUN85 0.51  0.06    0.03    0.01    0.61
D6700-60          17JUN85 0.32  0.14    0.04    0.22    0.72
D700-25   18JUN85 0.23  0.03    0.02    0.07    0.35
D700-60   17JUN85 1.11  0.32    0.07    0.02    1.52
DL-25     10JUL85 0.92  0.09    0.1     0.03    1.14
DL-60             09JUL85 0.29  0.14    0.03    0.06    0.52
D1100-25   10JUL85 0.14 0.05    0.05    4.79    5.03
D1100-60          09JUL85 0.88  0.07    0.01    0.01    0.97
D1900-25   10JUL85 0.35 0.05    0.05    1.82    2.27
D1900-60   09JUL85 0.87 0.08    0.42    3.35    4.72
D3200-60          09JUL85 0.22  0.1     0.08    0.01    0.41
D3350-25   10JUL85 0.36 0.06    0.01    0.02    0.45
D6700-25   10JUL85 1.84 0.02    0.11    0.05    2.02
D6700-60   09JUL85 0.47 0.19    0.06    0.06    0.78
D700-25           10JUL85 1.46  0.19    0.12    0.38    2.15
D700-60           09JUL85 0.48  0.18    0.02    0.11    0.79
DL-25             05AUG85 0.92  0.08    0.09    0.02    1.11
DL-60             02AUG85 0.4   0.1     0.59    0.5     1.59
D1100-25          05AUG85 0.18  0.02    0.36    2.33    2.89
D1100-60   02AUG85 0.39 0.12    0.03    0.01    0.55
D1900-25          05AUG85 1.23  0.06    0.04    2.15    3.48
D1900-60          02AUG85 0.56  0.07    0.02    0.11    0.76
D3200-60   02AUG85 0.39 0.11    0.05    0.02    0.57
D3350-25          05AUG85 0.45  44.82   0.02    0.16    45.45
D6700-25   05AUG85 1.13 0.01    0.11    0.04    1.29
D6700-60   02AUG85 0.43 0.15    1.1     0.01    1.69
D700-25    05AUG85 0.31 0.02    0.26    0.03    0.62
D700-60    02AUG85 0.38 0.07    0.12    1.87    2.44
DL-25     26AUG85 0.57  0.01    0.14    0.04    0.76
DL-60      27AUG85 0.46 0.05    0.5     0.18    1.19
D1100-25   26AUG85 0.63 0.02    0.04    0.03    0.72
D1100-60   27AUG85 0.57 0.04    0.09    0.31    1.01
D1900-25   26AUG85 0.26 0.03    0.01    3.89    4.19
D1900-60   27AUG85 0.73 0.07    0.06    0.09    0.95
D3200-60   27AUG85 0.46 0.07    0.02    0.01    0.56
D3350-25   26AUG85 0.57 0.02    0.05    0.05    0.69
D6700-25          26AUG85 0.87  0.01    0.03    0.02    0.93
D6700-60   27AUG85 0.69 0.07    0.03    0.01    0.8
D700-25    26AUG85 0.48 0.19    0.53    0.62    1.82
D700-60           27AUG85 0.25  0.09    0.07    0.01    0.42
run;
**********************;


**********************;
***A5.2
***CA88AIR.SAS
**********************;
*************************************************;
* ca88air.sas
*
* create the SAS data set CA88AIR;
*************************************************;

data sasclass.ca88air;
input @1  O3
      @6  CO
      @11 NO3
      @17 SO4
      @22 TEM
      @28 HUM
      @34 DATE
      @40 STATION $3.
      @44 MONTH
 ;
format date date7.;
datalines;
1.58 1.35 10.96 3.18 54.9  59.5  10241 AZU 1
2.77 1.25 12.73 2.96 60.2  58.5  10272 AZU 2
3.59 1.26 15.5  6.11 62.8  58    10301 AZU 3
3.48 1.05 15.01 4.69 63.4  72.75 10332 AZU 4
4.53 0.95 19.69 6.06 67.6  70    10362 AZU 5
3.8  0.93 17.48 7.68 69    74.75 10393 AZU 6
4.84 0.97 19.32 9.41 76.5  79.5  10423 AZU 7
4.33 1.3  18.06 8.84 74.5  78.75 10454 AZU 8
3.95 1.46 17.36 7.95 72.9  75.75 10485 AZU 9
3.18 1.76 22.81 8.93 70.1  76.25 10515 AZU 10
2.18 1.71 14.22 5.59 60    70.75 10546 AZU 11
1.9  0.99 8.7   2.58 54.6  56.5  10576 AZU 12
0.78 1.36 5     2.78 51.9  .     10241 LIV 1
0.89 1.28 8.13  3.7  56.5  .     10272 LIV 2
1.64 0.98 3.58  3.63 59.1  .     10301 LIV 3
2.89 0.94 3.28  3.28 59    .     10332 LIV 4
2.75 0.89 2.6   2.6  59.9  .     10362 LIV 5
2.56 0.84 2.95  2.71 62.7  .     10393 LIV 6
2.66 0.88 3.74  3.72 65.1  .     10423 LIV 7
2.34 0.88 4.63  3.59 65.41 .     10454 LIV 8
2.7  1.06 4.18  3.9  62.1  .     10485 LIV 9
1.88 1.14 6.03  3.99 59.6  .     10515 LIV 10
1.31 1.08 1.94  2.38 54.5  .     10546 LIV 11
1.28 1.45 4.85  2.38 49.8  .     10576 LIV 12
1.28 2.44 4.34  4.25 50.6  77.75 10241 SFO 1
1.38 2.58 4.6   5.98 54.5  70.75 10272 SFO 2
1.6  2.05 1.56  4.83 56.5  68    10301 SFO 3
2.39 1.76 1.93  4.84 58.1  68    10332 SFO 4
2.35 1.58 1.82  3.5  59.5  69.5  10362 SFO 5
1.79 1.6  1.2   4.11 62.5  70    10393 SFO 6
1.65 1.85 4.25  4.31 65.3  72.75 10423 SFO 7
1.58 1.64 1.84  4.63 65    72.75 10454 SFO 8
1.83 2.01 3.08  5.03 63.1  75.25 10485 SFO 9
1.62 2.14 1.81  4.58 61.4  80.25 10515 SFO 10
1.43 2.02 1.33  4.11 56.5  78    10546 SFO 11
0.9  2.21 8.23  6.33 50.4  74.75 10576 SFO 12
run;
**********************;


**********************;
***A5.3
***CLINICS.SAS
**********************;
*************************************************;
* clinics.sas;
*
* Create the clinics data set.
*************************************************;
data sasclass.clinics;
infile cards missover;
input clinnum  $ 1-6
      clinname $ 7-33
      region   $ 34-35
      lname    $ 36-45
      fname    $ 46-51
      ssn      $ 52-60
      / @1
      sex      $ 1
      dob        mmddyy8.
      death      mmddyy8.
      race     $ 18
      edu        19-20
      wt         21-23
      ht         24-25
      exam       mmddyy8.
      symp     $ 34-35
      dt_diag    mmddyy8.
      diag     $ 44
      admit      mmddyy8.
      proced   $ 53
      disch      mmddyy8.;

format dob death exam dt_diag admit disch date9.;

label clinnum  = 'clinic number'
      clinname = 'clinic name'
      region   = 'region'
      lname    = 'last name'
      fname    = 'first name'
      ssn      = 'social security number'
      sex      = 'patient sex'
      dob      = 'date of birth'
      death    = 'date of death'
      race     = 'race'
      edu      = 'years of education'
      wt       = 'weight in pounds'
      ht       = 'height in inches'
      exam     = 'examination date'
      symp     = 'symptom code'
      dt_diag  = 'date of diagnosis'
      diag     = 'diagnosis code'
      admit    = 'admit date'
      proced   = 'procedure code'
      disch    = 'discharge date'
      ;
datalines;
031234Bethesda Pioneer Hospital   3Smith     Mike  123456789
M03/18/52        1161627102/13/870102/14/87202/14/87302/15/87
036321Naval Memorial Hospital     3Jones     Sarah 043667543
F07/02/46        3141056407/01/830607/03/83207/05/83307/10/83
024477New York General Hospital   2Maxwell   Linda 135798642
F05/20/53        3141056407/01/830607/03/83207/05/83307/10/83
065742Kansas Metropolitan         7Marshall  Robert489012567
M03/11/53        1121556711/02/8702
108531Seattle Medical Complex    10James     Debra 563457897
F06/19/4208/03/851171636304/22/830505/03/83607/27/85208/03/85
014321Vermont Treatment Center    1Lawless   Henry 075312468
M09/17/60        1101957411/02/860411/05/86311/05/86311/19/86
095277San Francisco Bay General   9Chu       David 784567256
M06/18/51        5161476810/10/830410/10/833
043320Miami Bay Medical Center    4Halfner   John  589012773
M03/02/47        2171556709/14/850209/14/852
051345Battle Creek Hospital       5Cranberry David 153675389
M11/21/3104/13/861132156810/28/851010/29/85510/29/85204/13/86
063901Dallas Memorial Hospital    6Simpson   Donna 373167532
F04/18/3305/21/871151876305/12/870405/12/87305/12/87205/21/87
093785Sacramento Medical Complex  9Wright    Sarah 674892109
F10/21/48        2121776509/10/8306
024477New York General Hospital   2Little    Sandra376245789
F08/01/50        1121096307/01/830607/03/83207/05/83307/07/83
043320Miami Bay Medical Center    4Johnson   Randal537890152
M08/29/56        11820173
057312Indiana Help Center         5Henderson Robert932456132
M02/25/57        2161587208/15/831008/15/832        3
082287Denver Security Hospital    8Adamson   Joan  011553218
F                2161587208/15/831008/15/832        3
033476Mississippi Health Center   4Rodgers   Carl  327654213
M11/15/48        1131797212/20/84
066789Austin Medical Hospital     6Alexander Mark  743567875
M01/15/30        1121757009/15/88
026789Geneva Memorial Hospital    2Long      Margot531895634
F02/28/49        4141156408/15/860108/21/86708/21/86308/21/86
054367Michigan Medical Center     5Cranston  Rhonda287463500
F01/03/3704/13/881121606203/28/881003/28/88503/28/88204/13/88
094789San Diego Memorial Hospital 9Dandy     Martin578901234
M05/21/37        11218570
084890Montana Municipal Hospital  8Wills     Norma 425617894
F05/10/51        1121626802/20/840302/20/841        2
033476Mississippi Health Center   4Cordoba   Juan  327654213
M06/06/67        3151336805/07/840905/09/84
108531Seattle Medical Complex    10Robertson Adam  743787764
M04/07/4208/03/871121776904/29/850505/03/85603/29/87208/03/87
063742Houston General             6King      Doug  467901234
M08/15/34        2122406811/12/881011/12/885
038362Philadelphia Hospital       3Marksman  Joan  634792254
F09/28/63        41411265
031234Bethesda Pioneer Hospital   3Candle    Sid   468729812
M10/15/17        1101957411/02/860411/05/86311/05/86311/19/86
046789Tampa Treatment Complex     4Baron     Roger 189456372
M01/29/37        1101607006/15/8510
011234Boston National Medical     1Nabers    David 345751123
M11/03/21        1101957411/02/860411/05/86311/05/86311/19/86
023910New York Metro Medical Ctr  2Harbor    Samuel091550932
M01/14/50        3141056405/27/830605/28/832
063742Houston General             6Davidson  Mitch 524189532
M02/26/39        2162016905/12/8705        2
059372Ohio Medical Hospital       5Karson    Shawn 297854321
F03/05/60        217 9862        04
023910New York Metro Medical Ctr  2Harbor    Samuel091550932
M01/14/50        3141056407/01/830607/03/83207/05/83307/10/83
049060Atlanta General Hospital    4Adams     Mary  079932455
F08/12/51        2171556709/14/850209/14/852
107211Portland General           10Holmes    Donald315674321
M06/21/40        1121776904/29/850505/03/85603/29/87208/03/87
063901Dallas Memorial Hospital    6Simpson   Donna 373167532
F04/18/3305/21/871151876305/12/870405/12/87305/12/87205/21/87
095277San Francisco Bay General   9Marks     Gerald638956732
M03/03/47        1102156709/02/82
065742Kansas Metropolitan         7Chang     Joseph539873164
M08/20/58        5181476501/18/860302/03/86102/03/86102/07/86
036321Naval Memorial Hospital     3Masters   Martha029874182
F08/20/58        2171556709/14/850209/14/852
095277San Francisco Bay General   9Marks     Gerald638956732
M03/03/47        1102156709/02/821009/03/82509/05/82309/08/82
049060Atlanta General Hospital    4Rymes     Carol 680162534
F10/05/57        1151316604/01/850204/01/852
031234Bethesda Pioneer Hospital   3Henry     Louis 467189564
M04/19/53        1161627102/13/870102/14/87202/14/87302/15/87
036321Naval Memorial Hospital     3Stubs     Mark  319085647
M06/11/47        3141056407/01/830607/03/83207/05/83307/10/83
024477New York General Hospital   2Haddock   Linda 219075362
F04/04/51        3141056407/01/830607/03/83207/05/83307/10/83
065742Kansas Metropolitan         7Uno       Robert389036754
M03/21/44        1121556711/02/8702
108531Seattle Medical Complex    10Manley    Debra 366781237
F01/19/4208/03/851171636304/22/830505/03/83607/27/85208/03/85
014321Vermont Treatment Center    1Mercy     Ronald190473627
M09/27/60        1101957411/02/860411/05/86311/05/86311/19/86
095277San Francisco Bay General   9Chang     Tim   198356256
M02/18/51        5161476810/10/830410/10/833
043320Miami Bay Medical Center    4Most      Mat   109267433
M03/02/47        2171556709/14/850209/14/852
051345Battle Creek Hospital       5Rose      Mary  299816743
F11/01/3104/13/861132156810/28/851010/29/85510/29/85204/13/86
063901Dallas Memorial Hospital    6Nolan     Terrie298456241
F10/18/3307/21/871151876305/12/870405/12/87305/12/87207/21/87
093785Sacramento Medical Complex  9Tanner    Heidi 456178349
F08/08/45        2121776509/10/8306
024477New York General Hospital   2Saunders  Liz   468045789
F03/01/49        1121096307/01/830607/03/83207/05/83307/07/83
043320Miami Bay Medical Center    4Jackson   Ted   339984672
M12/29/56        11820173
057312Indiana Help Center         5Pope      Robert832456132
M02/05/57        2161587208/15/831008/15/832        3
082287Denver Security Hospital    8Olsen     June  743873218
F                2161587208/15/831008/15/832        3
033476Mississippi Health Center   4Maxim     Kurt  468721213
M10/15/40        1131797212/20/84
066789Austin Medical Hospital     6Banner    John  368267875
M01/25/32        1121757009/15/88
026789Geneva Memorial Hospital    2Ingram    Marcia367895634
F02/13/48        4141156408/15/860108/21/86708/21/86308/21/86
054367Michigan Medical Center     5Moon      Rachel375363500
F01/23/3706/13/881121606203/28/881003/28/88505/28/88206/13/88
094789San Diego Memorial Hospital 9Thomas    Daniel486301234
M05/23/38        11218570
084890Montana Municipal Hospital  8East      Jody  086317894
F10/10/51        1121626802/20/840302/20/841        2
033476Mississippi Health Center   4Perez     Mathew578254213
M07/06/57        3151336805/07/840905/09/84
108531Seattle Medical Complex    10Reilly    Arthur476587764
M05/17/4209/03/871121776904/29/850505/03/85608/29/87209/03/87
063742Houston General             6Antler    Peter 489745234
M01/15/34        2122406811/12/881011/12/885
038362Philadelphia Hospital       3Upston    Betty 784793254
F09/13/63        41411265
031234Bethesda Pioneer Hospital   3Panda     Merv  387549812
M10/11/19        1101957411/02/860411/05/86311/05/86311/19/86
046789Tampa Treatment Complex     4East      Clint 842576372
M01/26/37        1101607006/15/8510
011234Boston National Medical     1Taber     Lee   479451123
M11/05/24        1101957411/02/860411/05/86311/05/86311/19/86
023910New York Metro Medical Ctr  2Leader    Zac   075345932
M01/15/50        3141056405/27/830605/28/832
063742Houston General             6Ronson    Gerald474223532
M02/27/49        2162016905/12/8705        2
059372Ohio Medical Hospital       5Carlile   Patsy 578854321
F03/15/55        217 9862        04
023910New York Metro Medical Ctr  2Atwood    Teddy 066425632
M02/14/50        3141056407/01/830607/03/83207/05/83307/10/83
049060Atlanta General Hospital    4Batell    Mary  310967555
F01/12/37        2171556709/14/850209/14/852
107211Portland General           10Hermit    Oliver471094671
M06/23/38        1121776904/29/850505/03/85603/29/87208/03/87
063901Dallas Memorial Hospital    6Temple    Linda 691487532
F04/18/4305/21/871151876305/12/870405/12/87305/12/87205/21/87
095277San Francisco Bay General   9Block     Will  549014532
M03/12/51        1102156709/02/82
065742Kansas Metropolitan         7Chou      John  310986734
M05/15/58        5181476501/18/860302/03/86102/03/86102/07/86
036321Naval Memorial Hospital     3Herbal    Tammy 041090882
F08/23/46        2171556709/14/850209/14/852
095277San Francisco Bay General   9Mann      Steven489956732
M03/27/43        1102156709/02/821009/03/82509/05/82309/08/82
049060Atlanta General Hospital    4Rumor     Stacy 409825614
F12/05/52        1151316604/01/850204/01/852
run;
**********************;




