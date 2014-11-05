 /*-------------------------------------------------------------------*/
 /*       Applied Statistics and the SAS Programming Language,        */
 /*                         Fourth Edition                            */
 /*            by Ronald P. Cody and Jeffrey K. Smith                 */
 /*       Copyright(c) 1997, 1991 by Prentice-Hall, Inc.              */
 /*                                  Upper Sadle River, New Jersey    */
 /*                   SAS Publications order # 55984                  */
 /*                        ISBN 0-13-743642-4                         */
 /*-------------------------------------------------------------------*/
 /* Provided with permission from Prentice-Hall, Inc.                 */
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
 /* Attn: Ron Cody and Jeffrey Smith                                  */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  sasbbu@sas.com             */
 /* Use this for subject field:                                       */
 /*     Comments for Ron Cody and Jeffrey Smith                       */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
 /* Date Last Updated:   06OCT00                                      */
 /*-------------------------------------------------------------------*/


***Chapter 1 programs and data;
DATA TEST;  
   INPUT SUBJECT 1-2 GENDER $ 4 EXAM1 6-8 EXAM2 10-12
   HWGRADE $ 14;
DATALINES;
10 M  80  84 A
 7 M  85  89 A
 4 F  90  86 B
20 M  82  85 B
25 F  94  94 A
14 F  88  84 C
;
PROC MEANS DATA=TEST; 
RUN;

PROC MEANS DATA=TEST;
   VAR EXAM1 EXAM2;  
RUN;

PROC MEANS DATA=TEST N MEAN STD STDERR MAXDEC=1;
   VAR EXAM1 EXAM2;
RUN;

DATA EXAMPLE; 
   INPUT SUBJECT GENDER $ EXAM1 EXAM2 
   HWGRADE $;
FINAL = (EXAM1 + EXAM2) / 2; 
IF FINAL GE 0 AND FINAL LT 65 THEN GRADE='F';  
   ELSE IF FINAL GE 65 AND FINAL LT 75 THEN GRADE='C';  
   ELSE IF FINAL GE 75 AND FINAL LT 85 THEN GRADE='B';
   ELSE IF FINAL GE 85 THEN GRADE='A';
DATALINES;  
10 M  80  84 A
 7 M  85  89 A
 4 F  90  86 B
20 M  82  85 B
25 F  94  94 A
14 F  88  84 C
;
PROC SORT DATA=EXAMPLE; 
   BY SUBJECT; 
RUN; 

PROC PRINT DATA=EXAMPLE;  
   TITLE 'Roster in Student Number Order';
   ID SUBJECT;
   VAR EXAM1 EXAM2 FINAL HWGRADE GRADE;
RUN;

PROC MEANS DATA=EXAMPLE N MEAN STD STDERR MAXDEC=1; 
   TITLE 'Descriptive Statistics';
   VAR EXAM1 EXAM2 FINAL;
RUN;

PROC FREQ DATA=EXAMPLE; 
   TABLES GENDER HWGRADE GRADE;
RUN;                   

PROC SORT DATA=EXAMPLE;
   BY GENDER SUBJECT;
RUN;

PROC PRINT DATA=EXAMPLE;
   ID SUBJECT;
   TITLE 'Roster in Student Number Order';
   VAR EXAM1 EXAM2 FINAL HWGRADE GRADE;
RUN;
PROC MEANS DATA=EXAMPLE N MEAN MAXDEC=1; 
RUN;

PROC MEANS DATA=EXAMPLE N MEAN STD MAXDEC=1;
   TITLE 'Descriptive Statistics on Exam Scores';
   VAR EXAM1 EXAM2;
RUN;

PROC FREQ DATA=EXAMPLE;             
   TABLES GENDER HWGRADE GRADE/ NOCUM; 
RUN;

PROC FREQ DATA=EXAMPLE ORDER=FREQ;             
   TABLES GENDER HWGRADE GRADE/ NOCUM; 
RUN;

***Data for problem 1-1;

     ID   AGE GENDER GRADE POINT    COLLEGE ENTRANCE
                       AVERAGE         EXAM SCORE
                       (GPA)           (CSCORE)
    -------------------------------------------------
     1     18   M       3.7              650 
     2     18   F       2.0              490
     3     19   F       3.3              580
     4     23   M       2.8              530
     5     21   M       3.5              640

***Data for problem 1-2;

     Social security     Annual
        number           Salary    Age  Race
     -----------------------------------------
       123874414          28,000    35   W
       646239182          29,500    37   B
       012437652          35,100    40   W
       018451357          26,500    31   W

***Data form problem 1-5;

        ID    RACE    SBP    DBP    HR
    ------------------------------------
        001    W      130     80    60
        002    B      140     90    70
        003    W      120     70    64
        004    W      150     90    76
        005    B      124     86    72

***Chapter 2 programs and data;
DATA HTWT;                  
   INPUT SUBJECT GENDER $ HEIGHT WEIGHT; 
DATALINES;  
1 M 68.5 155
2 F 61.2  99
3 F 63.0 115
4 M 70.0 205
5 M 68.6 170
6 F 65.1 125
7 M 72.4 220
;
PROC MEANS DATA=HTWT; 
   TITLE 'Simple Descriptive Statistics'; 
RUN; 
                                                      
PROC MEANS DATA=HTWT N MEAN MAXDEC=3;
   TITLE 'Simple Descriptive Statistics';
   VAR HEIGHT;
RUN;

PROC UNIVARIATE DATA=HTWT;
   TITLE 'More Descriptive Statistics';
   VAR HEIGHT WEIGHT;
RUN;

PROC UNIVARIATE DATA=HTWT NORMAL PLOT;
   TITLE 'More Descriptive Statistics';
   VAR HEIGHT WEIGHT;
RUN;

 PROC UNIVARIATE DATA=HTWT NORMAL PLOT;
   TITLE 'More Descriptive Statistics';
   VAR HEIGHT WEIGHT;
   ID SUBJECT;
RUN;

Sort the data by GENDER;
PROC SORT DATA=HTWT;
   BY GENDER;
RUN;

*Run PROC MEANS for each value of GENDER;
PROC MEANS DATA=HTWT N MEAN STD MAXDEC=2;
   BY GENDER;  *This is the statement that gives the breakdown;
   VAR HEIGHT WEIGHT;
RUN;

DATA HTWT;                     
   INPUT SUBJECT GENDER $ HEIGHT WEIGHT;
DATALINES;
1 M 68.5 155
2 F 61.2  99
3 F 63.0 115
4 M 70.0 205
5 M 68.6 170
6 F 65.1 125
7 M 72.4 220
;
PROC FREQ DATA=HTWT;
   TITLE 'Using PROC FREQ to Compute Frequencies';
   TABLES GENDER;
RUN;

PROC CHART DATA=HTWT;
   VBAR GENDER;
RUN;

PROC PLOT DATA=HTWT;
   PLOT WEIGHT*HEIGHT;
RUN;

DATA HTWT;                     
   INPUT SUBJECT GENDER $ HEIGHT WEIGHT;
DATALINES;
1 M 68.5 155
2 F 61.2  99
3 F 63.0 115
4 M 70.0 205
5 M 68.6 170
6 F 65.1 125
7 M 72.4 220
;
PROC SORT DATA=HTWT;
   BY GENDER;
RUN;

PROC PLOT DATA=HTWT;
   BY GENDER;
   PLOT WEIGHT*HEIGHT;
RUN;

DATA HTWT;                     
   INPUT SUBJECT GENDER $ HEIGHT WEIGHT;
DATALINES;
1 M 68.5 155
2 F 61.2  99
3 F 63.0 115
4 M 70.0 205
5 M 68.6 170
6 F 65.1 125
7 M 72.4 220
;
PROC SORT DATA=HTWT;
   BY GENDER;
RUN;

PROC PLOT DATA=HTWT;
   BY GENDER;
   PLOT WEIGHT*HEIGHT;
RUN;

ROC PLOT DATA=HTWT;
   PLOT WEIGHT*HEIGHT=GENDER;
RUN;

DATA SCHOOL;
   LENGTH GENDER $ 1 TEACHER $ 5;  
   INPUT SUBJECT GENDER $ TEACHER $ T_AGE PRETEST POSTTEST;
   GAIN = POSTTEST - PRETEST;
DATALINES;
   1        M      JONES      35      67        81
   2        F      JONES      35      98        86
   3        M      JONES      35      52        92
   4        M      BLACK      42      41        74
   5        F      BLACK      42      46        76
   6        M      SMITH      68      38        80
   7        M      SMITH      68      49        71
   8        F      SMITH      68      38        63
   9        M      HAYES      23      71        72
  10        F      HAYES      23      46        92
  11        M      HAYES      23      70        90
  12        F      WONG       47      49        64
  13        M      WONG       47      50        63  
;
PROC MEANS DATA=SCHOOL N MEAN STD MAXDEC=2;
   CLASS TEACHER;
   TITLE 'Means Scores for Each Teacher';
   VAR PRETEST POSTTEST GAIN;
RUN;

PROC MEANS DATA=SCHOOL NOPRINT NWAY;  
   CLASS TEACHER;
   VAR PRETEST POSTTEST GAIN;
   OUTPUT OUT=TEACHSUM  
          MEAN=M_PRE M_POST M_GAIN;
RUN;
*To get a list of what was produced and therefore what
 is contained in the data set TEACHSUM, add the following:;
PROC PRINT DATA=TEACHSUM;
   TITLE 'Listing of Data Set TEACHSUM';
RUN;
*Hey!  This is a good example of why comments
 are useful. ;

PROC MEANS DATA=SCHOOL NOPRINT NWAY;  
   CLASS TEACHER;
   ID T_AGE;
   VAR PRETEST POSTTEST GAIN;
   OUTPUT OUT=TEACHSUM  
          MEAN=M_PRE M_POST M_GAIN;
RUN;

DATA DEMOG;
   LENGTH GENDER $ 1 REGION $ 5;  
   INPUT SUBJ GENDER $ REGION $ HEIGHT WEIGHT;
DATALINES;
01  M  North  70  200
02  M  North  72  220
03  M  South  68  155
04  M  South  74  210
05  F  North  68  130
06  F  North  63  110
07  F  South  65  140
08  F  South  64  108
09  F  South   .  220
10  F  South  67  130
;

PROC MEANS DATA=DEMOG N MEAN STD MAXDEC=2;
   TITLE 'Output from PROC MEANS';
   CLASS GENDER REGION;
   VAR HEIGHT WEIGHT;
RUN;

PROC MEANS DATA=DEMOG NOPRINT;  
   CLASS GENDER REGION;
   VAR HEIGHT WEIGHT;
   OUTPUT OUT=SUMMARY
          MEAN=M_HEIGHT M_WEIGHT;
RUN;

***Add a PROC PRINT to list the observations in SUMMARY;
PROC PRINT DATA=SUMMARY;
   TITLE 'Listing of Data Set SUMMARY';
RUN;

PROC MEANS DATA=DEMOG NOPRINT NWAY;
   CLASS GENDER REGION;
   VAR HEIGHT WEIGHT;
   OUTPUT OUT=SUMMARY 
          MEAN=M_HEIGHT M_WEIGHT;
RUN;

PROC PRINT DATA=SUMMARY;
   TITLE 'Listing of Data Set SUMMARY with NWAY Option';
RUN;

PROC MEANS DATA=DEMOG NOPRINT NWAY;
   CLASS GENDER REGION;
   VAR HEIGHT WEIGHT;
   OUTPUT OUT=SUMMARY 
          N=N_HEIGHT N_WEIGHT
          MEAN=M_HEIGHT M_WEIGHT;
RUN;

PROC PRINT DATA=SUMMARY;
   TITLE1 'Listing of Data Set SUMMARY with NWAY Option';
   TITLE2 'with Requests for N= and MEAN=';
RUN;

PROC MEANS DATA=DEMOG NOPRINT NWAY;
   CLASS GENDER REGION;
   VAR HEIGHT WEIGHT;
   OUTPUT OUT=SUMMARY(DROP=_TYPE_) 
          N=N_HEIGHT N_WEIGHT
          MEAN=M_HEIGHT M_WEIGHT;
RUN;
     
PROC MEANS DATA=DEMOG NOPRINT NWAY;
   CLASS GENDER REGION;
   VAR HEIGHT WEIGHT;
   OUTPUT OUT=SUMMARY(DROP=_TYPE_) 
          MEAN=;
RUN;

PROC MEANS DATA=DEMOG NOPRINT NWAY;
   CLASS GENDER REGION;
   VAR HEIGHT WEIGHT;
   OUTPUT OUT =STATS 
          MEAN=M_HEIGHT M_WEIGHT
          STD =S_HEIGHT S_WEIGHT
          MAX =MAX_HT MAX_WT;
RUN;

PROC SORT DATA=DEMOG;
   BY GENDER REGION;
RUN;

PROC UNIVARIATE DATA=DEMOG NOPRINT;
   BY GENDER REGION;
   VAR HEIGHT WEIGHT;
   OUTPUT OUT=SUM
          N      = N_HT N_WT
          MEDIAN = MED_HT MED_WT
          MEAN   = MEAN_HT MEAN_WT;
RUN;

PROC PRINT DATA=SUM;
   TITLE 'Listing of Data Set SUM';
RUN;

***Data for problem 2-3;
DATA PROB2_3;
   LENGTH GROUP $ 1;
   INPUT X Y Z GROUP $;
DATALINES;
2 4 6 A
3 3 3 B
1 3 7 A
7 5 3 B
1 1 5 B
2 2 4 A
5 5 6 A
;

***Data for problem 2-4;

SUBJECT  DOSE REACT LIVER_WT SPLEEN
-----------------------------------
   1       1    5.4    10.2    8.9
   2       1    5.9     9.8    7.3
   3       1    4.8    12.2    9.1
   4       1    6.9    11.8    8.8
   5       1   15.8    10.9    9.0
   6       2    4.9    13.8    6.6
   7       2    5.0    12.0    7.9
   8       2    6.7    10.5    8.0
   9       2   18.2    11.9    6.9
   10      2    5.5     9.9    9.1

***Data for problem 2-6;

                                   Number
              Target   Number      of phone   Units
Salesperson   company  of visits   calls      sold 
---------------------------------------------------
Brown         American     3         12       28,000
Johnson       VRW          6         14       33,000
Rivera        Texam        2          6        8,000
Brown         Standard     0         22            0
Brown         Knowles      2         19       12,000
Rivera        Metro        4          8       13,000
Rivera        Uniman       8          7       27,000
Johnson       Oldham       3         16        8,000
Johnson       Rondo        2         14        2,000

***Data for problem 2-7;
ID   TYPE   SCORE
-----------------
 1     A      44
 1     B       9
 1     C     203
 2     A      50
 2     B       7
 2     C     188
 3     A      39
 3     B       9
 3     C     234

***Chapter 3 programs and data;
DATA QUEST;
   INPUT ID 1-3 AGE 4-5 GENDER $ 6 RACE $ 7 MARITAL $ 8 EDUC $ 9
         PRES 10 ARMS 11 CITIES 12;
DATALINES;
001091111232
002452222422
003351324442
004271111121
005682132333
006651243425
;
PROC MEANS DATA=QUEST MAXDEC=2 N MEAN STD;
   TITLE 'Questionnaire Analysis';
   VAR AGE;
RUN;

PROC FREQ DATA=QUEST;
   TITLE 'Frequency Counts for Categorical Variables';
   TABLES GENDER RACE MARITAL EDUC PRES ARMS CITIES;
RUN;

DATA QUEST;
   INPUT ID 1-3 AGE 4-5 GENDER $ 6 RACE $ 7 MARITAL $ 8 EDUC $ 9
         PRES 10 ARMS 11 CITIES 12;

    LABEL  MARITAL='Marital Status'
          EDUC='Education Level'
          PRES='President Doing a Good Job'
          ARMS='Arms Budget Increase'
          CITIES='Federal Aid to Cities';

DATALINES;
001091111232
002452222422
003351324442
004271111121
005682132333
006651243425
;
PROC MEANS DATA=QUEST MAXDEC=2 N MEAN STD; 
   TITLE 'Questionnaire Analysis';
   VAR AGE;
RUN;

PROC FREQ DATA=QUEST;
   TITLE 'Frequency Counts for Categorical Variables';
   TABLES GENDER RACE MARITAL EDUC PRES ARMS CITIES;
RUN;

PROC FORMAT;
   VALUE $SEXFMT   '1'='Male' '2'='Female';
   VALUE $RACE     '1'='White'  '2'='African Am.' '3'='Hispanic' 
                   '4'='Other';
   VALUE $OSCAR    '1'='Single' '2'='Married' '3'='Widowed' 
                   '4'='Divorced';
   VALUE $EDUC     '1'='High Sch or Less'
                   '2'='Two Yr. College'
                   '3'='Four Yr. College'
                   '4'='Graduate Degree';
   VALUE LIKERT     1='Str Disagree'
                    2='Disagree'
                    3='Neutral'
                    4='Agree'
                    5='Str Agree';
RUN;

PROC FORMAT;
   VALUE $SEXFMT   '1'='Male' '2'='Female';
   VALUE $RACE     '1'='White'  '2'='African Am.' '3'='Hispanic' 
                   '4'='Other';
   VALUE $OSCAR    '1'='Single' '2'='Married' '3'='Widowed' 
                   '4'='Divorced';
   VALUE $EDUC     '1'='High Sch or Less'
                   '2'='Two Yr. College'
                   '3'='Four Yr. College'
                   '4'='Graduate Degree';
   VALUE LIKERT     1='Str Disagree'
                    2='Disagree'
                    3='Neutral'
                    4='Agree'
                    5='Str Agree';
RUN;

DATA QUEST;
   INPUT ID 1-3 AGE 4-5 GENDER $ 6 RACE $ 7 MARITAL $ 8 EDUC $ 9
         PRES 10 ARMS 11 CITIES 12;
    LABEL  MARITAL='Marital Status'
          EDUC='Education Level'
          PRES='President Doing a Good Job'
          ARMS='Arms Budget Increase'
          CITIES='Federal Aid to Cities';
    FORMAT GENDER $SEXFMT. RACE $RACE. MARITAL $OSCAR.
          EDUC $EDUC. PRES ARMS CITIES LIKERT.;
DATALINES;
001091111232
002452222422
003351324442
004271111121
005682132333
006651243425
;
PROC MEANS DATA=QUEST MAXDEC=2 N MEAN STD; 
   TITLE 'Questionnaire Analysis';
   VAR AGE;
RUN;

PROC FREQ DATA=QUEST;
   TITLE 'Frequency Counts for Categorical Variables';
   TABLES GENDER RACE MARITAL EDUC PRES ARMS CITIES;
RUN;

DATA QUEST;
   INPUT ID 1-3 AGE 4-5 GENDER $ 6 RACE $ 7 MARITAL $ 8 EDUC $ 9
         PRES 10 ARMS 11 CITIES 12;
   IF 0 <= AGE <=20 THEN AGEGRP=1;
   IF 20 < AGE <= 40 THEN AGEGRP=2;
   IF 40 < AGE <= 60 THEN AGEGRP=3;
   IF AGE > 60 THEN AGEGRP=4;

   LABEL  MARITAL='MARITAL STATUS'
          EDUC='Education Level'
          PRES='President Doing a Good Job'
          ARMS='Arms Budget Increase'
          CITIES='Federal Aid to Cities'
          AGEGRP='AGE GROUP';
   FORMAT GENDER $SEXFMT. RACE $RACE. MARITAL $OSCAR.
          EDUC $EDUC. PRES ARMS CITIES LIKERT.
          AGEGRP AGEFMT.;
DATALINES;
001091111232
002452222422
003351324442
004271111121
005682132333
006651243425
;
PROC FREQ DATA=QUEST;
   TABLES GENDER -- AGEGRP;
RUN;

PROC FORMAT;
   VALUE AGROUP LOW-20  = '0-20'
                21-40   = '21-40'
                41-60   = '41-60'
                60-HIGH = 'Greater than 60';

   VALUE AGROUP LOW-20  = '0-20'
                21-40   = '21-40'
                41-60   = '41-60'
                60-HIGH = 'Greater than 60'
                .       = 'Did Not Answer'
                OTHER   = 'Out of Range';

DATA ELECT;
   INPUT GENDER $ CANDID $ ;
DATALINES;
M DEWEY
F TRUMAN
M TRUMAN
M DEWEY
F TRUMAN
     (more data lines)
;
PROC FREQ DATA=ELECT;
   TABLES GENDER CANDID
          CANDID*GENDER;
RUN;

DATA CHISQ;
   INPUT GROUP $ OUTCOME $ COUNT;
DATALINES;
CONTROL DEAD 20
CONTROL ALIVE 80
DRUG DEAD 10
DRUG ALIVE 90
;
PROC FREQ DATA=CHISQ;
   TABLES GROUP*OUTCOME / CHISQ;
   WEIGHT COUNT;
RUN;                             

*--------------------------------------------------------------*
| Program to compute Chi-square for any number of 2 x 2 tables |
| where the data lines consist of the cell frequencies.  The   |
| order of the cell counts is upper left, upper right, lower   |
| left, and lower right.  To use this program, substitute your |
| cell frequencies for the sample data lines in this program.  |
*--------------------------------------------------------------*;
DATA CHISQ;
   N + 1;
   DO ROW = 1 TO 2;
      DO COL=1 TO 2;
         INPUT COUNT @;
         OUTPUT;
      END;
   END;
DATALINES;
3 5 8 6
10 20 30 40
;
PROC FREQ DATA=CHISQ;
   BY N;
   TABLES ROW*COL / CHISQ;
   WEIGHT COUNT;
RUN;

*------------------------------------------------------*
| Program Name: MCNEMAR.SAS  in C:\APPLIED             |
| Purpose: To perform Mc'Nemars Chi-square test for    |
|          paired samples                              |
*------------------------------------------------------*;
PROC FORMAT;
   VALUE $OPINION 'P'='Positive'
                  'N'='Negative';
RUN;

DATA MCNEMAR;
   LENGTH BEFORE AFTER $ 1;
   INPUT SUBJECT BEFORE $ AFTER $;
   FORMAT BEFORE AFTER $OPINION.;
DATALINES;
001     P      P
002     P      N
003     N      N
 (more data lines)
100     N      P
;
PROC FREQ DATA=MCNEMAR;
   TITLE "McNemar's Test for Paired Samples";
   TABLES BEFORE*AFTER / AGREE;
RUN;

*Program to compute an Odds Ratio and the 95% CI;
DATA ODDS;
   INPUT OUTCOME $ EXPOSURE $ COUNT;
DATALINES;
CASE 1-YES 50
CASE 2-NO 100
CONTROL 1-YES 20
CONTROL 2-NO 130
;
PROC FREQ DATA=ODDS;
   TITLE 'Program to Compute an Odds Ratio';
   TABLES EXPOSURE*OUTCOME / CHISQ CMH;
   WEIGHT COUNT;
RUN;

*Program to compute a Relative Risk and a 95% CI;
DATA RR;
   LENGTH GROUP $ 9;
   INPUT GROUP $ OUTCOME $ COUNT;
DATALINES;
1-PLACEBO MI 20
1-PLACEBO NO-MI 80
2-ASPIRIN MI 15
2-ASPIRIN NO-MI 135
;
PROC FREQ DATA=RR;
   TITLE 'Program to Compute a Relative Risk';
   TABLES GROUP*OUTCOME / CMH;
   WEIGHT COUNT;
RUN;

*----------------------------------------------------*
|            Chi-square Test for Trend               |
*----------------------------------------------------*;
DATA TREND;
   INPUT RESULT $ GROUP $ COUNT @@;
DATALINES;
FAIL A 10 FAIL B 15 FAIL C 14 FAIL D 25
PASS A 90 PASS B 85 PASS C 86 PASS D 75
;
PROC FREQ DATA=TREND;
   TITLE 'Chi-square Test for Trend';
   TABLES RESULT*GROUP / CHISQ;
   WEIGHT COUNT;
RUN;

*Program to compute a Mantel-Haenszel Chi-square Test
 for Stratified Tables;
DATA ABILITY;
   INPUT GENDER $ RESULTS $ SLEEP $ COUNT;
DATALINES;
BOYS FAIL 1-LOW 20    
BOYS FAIL 2-HIGH 15  
BOYS PASS 1-LOW 100
BOYS PASS 2-HIGH 150  
GIRLS FAIL 1-LOW 30  
GIRLS FAIL 2-HIGH 25
GIRLS PASS 1-LOW 100  
GIRLS PASS 2-HIGH 200
;
PROC FREQ DATA=ABILITY;
   TITLE 'Mantel-Haenszel Chi-square Test';
   TABLES GENDER*SLEEP*RESULTS / ALL;
   WEIGHT COUNT;
RUN;

DATA DIAG2;
   SET DIAG1;
   ARRAY D[*] DX1-DX3;
   DO I = 1 TO 3;
      DX=D[I];
      IF D[I] NE . THEN OUTPUT;
   END;
KEEP ID DX;
RUN;

DATA DIAG1;
   INPUT ID 1-3 DX1 DX2 DX3;
DATALINES;
1      3       4       .
2      1       3       7
3      5       .       .
;
PROC FREQ DATA=DIAG1;
   TABLES DX1-DX3;
RUN;
DATA DIAG2;
   SET DIAG1;
   DX=DX1;
   IF DX NE . THEN OUTPUT;
   DX=DX2;
   IF DX NE . THEN OUTPUT;
   DX=DX3;
   IF DX NE . THEN OUTPUT;
   KEEP ID DX;
RUN;

DATA DIAG2;
   SET DIAG1;
   ARRAY D[*] DX1-DX3;
   DO I = 1 TO 3;
      DX=D[I];
      IF D[I] NE . THEN OUTPUT;
   END;
KEEP ID DX;
RUN;

***Data for problem 3-2;
007M1110
013F2101
137F1001
117 1111
428M3110
017F3101
037M2101

***Data for problem 3-3;
DATA DEMOG;
   INPUT WEIGHT HEIGHT GENDER $;
DATALINES;
155 68 M 
 98 60 F
202 72 M
280 75 M
130 63 F
;

***Data for problem 3-10;
11127 78130 80
1787  82180110
031   62120 78
4261  68130 80
89    58120 76
9948  82178100

***Chapter 4 programs and data;
DATA HOSPITAL;
INPUT @1  ID      3.
      @5  DOB     MMDDYY6. 
      @12 ADMIT   MMDDYY6. 
      @18 DISCHRG MMDDYY6.
      @25 DX      1.  
      @26 FEE     5.;
LEN_STAY = DISCHRG - ADMIT + 1;
AGE = ADMIT - DOB;
DATALINES;
00710218307012008001400400150
00712018307213009002000500200
00909038306611007013700300000
00507058307414008201300900000
00501158208018009601402001500
00506188207017008401400800400
00507038306414008401400800200
;

DATA HOSP;
   INPUT #1 ID1 1-3 DATE1 MMDDYY6.  HR1 10-12 SBP1  13-15 DBP1 16-18
            DX1 19-21 DOCFEE1 22-25 LABFEE1 26-29
         #2 ID2 1-3 DATE2 MMDDYY6. HR2 10-12 SBP2 13-15 DBP2 16-18
            DX2 19-21 DOCFEE2 22-25 LABFEE2 26-29
         #3 ID3 1-3 DATE3 MMDDYY6. HR3 10-12 SBP3 13-15 DBP3 16-18
            DX3 19-21 DOCFEE3 22-25 LABFEE3 26-29
         #4 ID4 1-3 DATE4 MMDDYY6. HR4 10-12 SBP4 13-15 DBP4 16-18
            DX4 19-21 DOCFEE4 22-25 LABFEE4 26-29;
   FORMAT DATE1-DATE4 MMDDYY8.;
DATALINES;
00710218307012008001400400150
00712018307213009002000500200
007
007
00909038306611007013700300000
009
009
009
00507058307414008201300900000
00501158208018009601402001500
00506188207017008401400800400
00507038306414008401400800200
;

DATA PATIENTS;
   INPUT @1  ID     3. 
         @4  DATE   MMDDYY6. 
         @10 HR     3.
         @13 SBP    3. 
         @16 DBP    3.
         @19 DX     3.
         @22 DOCFEE 4.
         @26 LABFEE 4.;
   FORMAT DATE MMDDYY8.;
DATALINES;
00710218307012008001400400150
00712018307213009002000500200
00909038306611007013700300000
00507058307414008201300900000
00501158208018009601402001500
00506188207017008401400800400
00507038306414008401400800200
;
PROC MEANS DATA=PATIENTS NOPRINT NWAY;
   CLASS ID;
   VAR HR -- DBP DOCFEE LABFEE;
   OUTPUT OUT=STATS MEAN=M_HR M_SBP M_DBP M_DOCFEE M_LABFEE;
RUN;

DATA PATIENTS;
   INPUT @1  ID     3. 
         @4  DATE   MMDDYY6. 
         @10 HR     3.
         @13 SBP    3. 
         @16 DBP    3.
         @19 DX     3.
         @22 DOCFEE 4.
         @26 LABFEE 4.;
     FORMAT DATE MMDDYY8. ;

DATALINES;
00710218307012008001400400150
00712018307213009002000500200
00909038306611007013700300000
00507058307414008201300900000
00501158208018009601402001500
00506188207017008401400800400
00507038306414008401400800200
;

PROC SORT DATA=PATIENTS;
   BY ID DATE;
RUN;

DATA RECENT;
   SET PATIENTS;
   BY ID;  
   IF LAST.ID;  
RUN;

PROC FREQ DATA=PATIENTS ORDER=FREQ;
   TITLE 'Diagnoses in Decreasing Frequency Order';
   TABLES DX;
RUN;

DATA DIAG;
   SET PATIENTS;
   BY ID DX;
   IF FIRST.DX;
RUN;

PROC FREQ DATA=DIAG ORDER=FREQ;
   TABLES DX;
RUN;

***Data for problem 4-1;
001 10214611128012288887343
002 09135502028002049088123
005 06064003128103128550000
003 07054411158011139089544

***Data for problem 4-2;
RAT_NO    DOB     DISEASE     DEATH    GROUP
----------------------------------------------
   1    23MAY90   23JUN90     28JUN90    A
   2    21MAY90   27JUN90     05JUL90    A
   3    23MAY90   25JUN90     01JUL90    A
   4    27MAY90   07JUL90     15JUL90    A
   5    22MAY90   29JUN90     22JUL90    B
   6    26MAY90   03JUL90     03AUG90    B
   7    24MAY90   01JUL90     29JUL90    B
   8    29MAY90   15JUL90     18AUG90    B

***Data for problem 4-5;
***Program to create data set BLOOD;
DATA BLOOD;
   LENGTH GROUP $ 1;
   INPUT ID GROUP $ TIME WBC RBC @@;
DATALINES;
1 A 1 8000 4.5  1 A 2 8200 4.8  1 A 3 8400 5.2
1 A 4 8300 5.3  1 A 5 8400 5.5
2 A 1 7800 4.9  2 A 2 7900 5.0
3 B 1 8200 5.4  3 B 2 8300 5.4  3 B 3 8300 5.2
3 B 4 8200 4.9  3 B 5 8300 5.0
4 B 1 8600 5.5
5 A 1 7900 5.2  5 A 2 8000 5.2  5 A 3 8200 5.4 
5 A 4 8400 5.5
;

***Chapter 5 programs and data;
DATA CORR_EG;
   INPUT GENDER $ HEIGHT WEIGHT AGE;
DATALINES;
M 68 155 23
F 61  99 20
F 63 115 21
M 70 205 45
M 69 170  .
F 65 125 30
M 72 220 48
;
PROC CORR DATA=CORR_EG;
   TITLE 'Example of a Correlation Matrix';
   VAR HEIGHT WEIGHT AGE;
RUN;                      

PROC CORR options;
   VAR  list-of-variables;
RUN;

PROC CORR DATA=CORR_EG PEARSON SPEARMAN NOSIMPLE;
   TITLE 'Example of a Correlation Matrix';
   VAR HEIGHT WEIGHT AGE;
RUN;                      

PROC CORR DATA=RESULTS;
   VAR IQ GPA;
   WITH TEST1-TEST10;
RUN;

PROC CORR DATA=CORR_EG NOSIMPLE;
   TITLE 'Example of a Partial Correlation';
   VAR HEIGHT WEIGHT;
   PARTIAL AGE;
RUN;                      

PROC REG DATA=CORR_EG;
   TITLE 'Regression Line for Height-Weight Data';
   MODEL WEIGHT=HEIGHT;
RUN;

PROC PLOT DATA=CORR_EG;
   PLOT WEIGHT*HEIGHT;
RUN;

PROC REG DATA=CORR_EG;
   MODEL WEIGHT = HEIGHT;
   PLOT PREDICTED.*HEIGHT = 'P' WEIGHT*HEIGHT='*' / OVERLAY;
RUN;                                                        

PROC REG DATA=CORR_EG;
   MODEL WEIGHT = HEIGHT;
   PLOT PREDICTED.*HEIGHT = 'P'
        U95M.*HEIGHT='-' L95M.*HEIGHT='-'
        WEIGHT*HEIGHT='*' / OVERLAY;
   PLOT RESIDUAL.*HEIGHT='o';
RUN;                                                    

DATA HEART;
   INPUT DOSE HR;
DATALINES;        
 2        60
 2        58
 4        63
 4        62
 8        67
 8        65
16        70
16        70
32        74
32        73
;
PROC PLOT DATA=HEART;
   PLOT HR*DOSE='o';
RUN;

PROC REG DATA=HEART;
   MODEL HR = DOSE;
RUN;               
      
DATA HEART;
   INPUT DOSE HR;
   LDOSE = LOG(DOSE);
DATALINES;

PROC PLOT DATA=HEART;
   PLOT HR*LDOSE='o';
RUN;

PROC REG DATA=HEART;
   MODEL HR=LDOSE;
RUN;

DATA TEST;
   INPUT ID GROUP $ TIME SCORE;
DATALINES;
1 A 1 2
1 A 2 5
1 A 3 7
2 A 1 4
2 A 2 6
2 A 3 9
3 B 1 8
3 B 2 6
3 B 3 2
4 B 1 8
4 B 2 7
4 B 3 3
;
PROC SORT DATA=TEST;
   BY ID;
RUN;

PROC REG OUTEST=SLOPES DATA=TEST;
   BY ID;
   ID GROUP; ***Note: This ID statement is used so that the
                GROUP variable will be in the SLOPES data set.
                An alternative would be to include it in the
                BY list.;
   MODEL SCORE = TIME / NOPRINT;
RUN;

PROC PRINT DATA=SLOPES;
   TITLE 'Listing of the Data Set SLOPES';
RUN;

PROC TTEST DATA=SLOPES;
   TITLE 'Comparing Slopes Between Groups';
   CLASS GROUP;
   VAR TIME;
RUN;

***Data for problem 5-1;
     X     Y    Z
--------------------
     1     3   15
     7    13    7
     8    12    5
     3     4   14
     4     7   10

***Data for problem 5-2;
     AGE       SYSTOLIC BLOOD PRESSURE
-----------------------------------------
     15             116
     20             120
     25             130
     30             132
     40             150
     50             148

***Data for problem 5-6;
COUNTY    POP     HOSPITAL     FIRE_CO     RURAL
------------------------------------------------
  1        35        1            2         YES
  2        88        5            8          NO
  3         5        0            1         YES
  4        55        3            3         YES
  5        75        4            5          NO
  6       125        5            8          NO
  7       225        7            9         YES
  8       500       10           11          NO


***Chapter 6 programs and data;

DATA RESPONSE;
   INPUT GROUP $ TIME;
DATALINES;
C 80
C 93
C 83
C 89
C 98
T 100
T 103
T 104
T 99
T 102
;
PROC TTEST DATA=RESPONSE;
   TITLE 'T-test Example';
   CLASS GROUP;
   VAR TIME;
RUN;

PROC FORMAT;
    VALUE GRPFMT 0='CONTROL' 1='TREATMENT';
RUN;

DATA RANDOM;
   INPUT SUBJ NAME $20.;
   GROUP=RANUNI(0);
DATALINES;
1 CODY
2 SMITH
3 HELM
4 GREGORY
(more data lines)
;
PROC RANK DATA=RANDOM GROUPS=2 OUT=SPLIT;
   VAR GROUP;
RUN;

PROC SORT DATA=SPLIT;
   BY NAME;
RUN;

PROC PRINT DATA=SPLIT;
   TITLE 'Subject Group Assignments';
   ID NAME;
   VAR SUBJ GROUP;
   FORMAT GROUP GRPFMT.;
RUN;

DATA TUMOR;
   INPUT GROUP $ MASS @@;
DATALINES;
A 3.1 A 2.2 A 1.7 A 2.7 A 2.5
B 0.0 B 0.0 B 1.0 B 2.3
;
PROC NPAR1WAY DATA=TUMOR WILCOXON;
   TITLE 'Nonparametric Test to Compare Tumor Masses';
   CLASS GROUP;
   VAR MASS;
   EXACT WILCOXON;
RUN;                  

DATA PAIRED;
   INPUT CTIME TTIME;
   DIFF = TTIME - CTIME;
DATALINES;
90 95
87 92
100 104
80 89
95 101
90 105
;
PROC MEANS DATA=PAIRED N MEAN STDERR T PRT;
   TITLE 'Paired T-test Example';
   VAR DIFF;
RUN;                           

***Data fro problem 6-1;
          Aspirin        Tylenol
          (Relief time in minutes)
          ----------------------
             40             35
             42             37
             48             42
             35             22
             62             38
             35             29

***Data for problem 6-3;
      Subject      Drug A   Drug B
      ----------------------------
          1         20        18
          2         40        36
          3         30        30
          4         45        46
          5         19        15
          6         27        22
          7         32        29
          8         26        25

***Chapter 7 programs and data;

DATA READING;
   INPUT GROUP $ WORDS @@;
DATALINES;
X 700   X 850   X 820   X 640   X 920
Y 480   Y 460   Y 500   Y 570   Y 580
Z 500   Z 550   Z 480   Z 600   Z 610
;
PROC ANOVA DATA=READING;
   TITLE 'Analysis of Reading Data';
   CLASS GROUP;
   MODEL WORDS = GROUP;
   MEANS GROUP;
RUN;

GLM DATA=READING;    
   TITLE 'Analysis of Reading Data - Planned Comparions';
   CLASS GROUP;
   MODEL WORDS = GROUP;
   CONTRAST 'X VS. Y AND Z' GROUP  -2 1 1;
   CONTRAST 'METHOD Y VS Z' GROUP   0 1 -1;
RUN;

DATA TWOWAY;
   INPUT GROUP $ GENDER $ WORDS @@;
   ***Note: double trailing @@ added to make data
      more compact;
DATALINES;
X M 700  X M 850  X M 820  X M 640  X M 920
Y M 480  Y M 460  Y M 500  Y M 570  Y M 580
Z M 500  Z M 550  Z M 480  Z M 600  Z M 610
X F 900  X F 880  X F 899  X F 780  X F 899
Y F 590  Y F 540  Y F 560  Y F 570  Y F 555
Z F 520  Z F 660  Z F 525  Z F 610  Z F 645
;
PROC ANOVA DATA=TWOWAY;
   TITLE 'Analysis of Reading Data';
   CLASS GROUP GENDER;
   MODEL WORDS = GROUP|GENDER;
   MEANS GROUP|GENDER / DUNCAN;
RUN;

DATA RITALIN;
   DO GROUP = 'NORMAL','HYPER ';
      DO DRUG = 'PLACEBO','RITALIN';
         DO SUBJ = 1 TO 4;
            INPUT ACTIVITY @;
            OUTPUT;
         END;
      END;
   END;
DATALINES;
50 45 55 52  67 60 58 65  70 72 68 75  51 57 48 55
;
PROC ANOVA DATA=RITALIN;
    TITLE 'Activity Study';
    CLASS GROUP DRUG;
    MODEL ACTIVITY = GROUP|DRUG;
    MEANS GROUP|DRUG; 
RUN; 
 
PROC MEANS DATA=RITALIN NWAY NOPRINT;
   CLASS GROUP DRUG;
   VAR ACTIVITY;
   OUTPUT OUT=MEANS MEAN=;
RUN;

PROC PLOT DATA=MEANS;
   PLOT ACTIVITY*DRUG=GROUP;
RUN;

PROC SORT DATA=RITALIN;
  BY GROUP;
RUN;

PROC TTEST DATA=RITALIN; 
   BY GROUP;
   CLASS DRUG;
   VAR ACTIVITY;
RUN;

PROC ANOVA DATA=RITALIN;
   TITLE 'One-way ANOVA Ritalin Study';
   CLASS COND;
   MODEL ACTIVITY = COND;
   MEANS COND / DUNCAN;
RUN;

PROC GLM DATA=RITALIN;
   CLASS GROUP DRUG;
   MODEL ACTIVITY = GROUP|DRUG;
   CONTRAST 'Hyperactive only' DRUG 1 -1
                               GROUP*DRUG 1 -1 0 0;
   CONTRAST 'Normals only'     DRUG 1 -1
                               GROUP*DRUG 0 0 1 -1;
RUN;

PROC GLM DATA=RITALIN;
   TITLE 'One-way ANOVA Ritalin Study';
   CLASS COND;
   MODEL ACTIVITY = COND;
   CONTRAST 'Hyperactive only' COND 1 -1 0 0;
   CONTRAST 'Normals only'     COND 0 0 1 -1;
RUN;

***Note: in the data below, V is Vanilla and C is Chocolate;
DATA PUDDING;     
   INPUT SWEET FLAVOR $ RATING @@;
DATALINES;
1 V 9  1 V 7  1 V 8  1 V 7
2 V 8  2 V 7  2 V 8
3 V 6  3 V 5  3 V 7
1 C 9  1 C 9  1 C 7  1 C 7  1 C 8
2 C 8  2 C 7  2 C 6  2 C 8
3 C 4  3 C 5  3 C 6  3 C 4  3 C 4
;
PROC GLM DATA=PUDDING;
   TITLE 'Pudding Taste Evaluation';
   TITLE3 'Two-way ANOVA - Unbalanced Design';
   TITLE5 '---------------------------------';
   CLASS SWEET FLAVOR;
   MODEL RATING = SWEET|FLAVOR;
   MEANS SWEET|FLAVOR;
   LSMEANS SWEET|FLAVOR / PDIFF;
RUN;

DATA COVAR;
   LENGTH GROUP $ 1;
   INPUT GROUP MATH IQ @@;
DATALINES;
A 260 105  A 325 115  A 300 122  A 400 125  A 390 138
B 325 126  B 440 135  B 425 142  B 500 140  B 600 160
;
PROC CORR DATA=COVAR NOSIMPLE;
   TITLE 'Covariate Example';
   VAR MATH IQ;
RUN;

PROC TTEST DATA=COVAR;
   CLASS GROUP;
   VAR IQ MATH;
RUN;

PROC GLM DATA=COVAR;
   CLASS GROUP;
   MODEL MATH = IQ GROUP IQ*GROUP;
RUN;

PROC GLM DATA=COVAR;
   CLASS GROUP;
   MODEL MATH = IQ GROUP;
   LSMEANS GROUP;
RUN;
 
***Data for problem 7-1;
                            Brand
               A              N              T
          -----------------------------------------
               8              4              12
               10             7              8
 Wear time     9              5              10
 in months     11             5              10
               10             6              11
               10             7              9
               8              6              9
               12             4              12

***Data for problem 7-2;
                        Brand
                   W      |       P
                ----------|-----------
                   67     |      75
                   72     |      76
          New      74     |      80
                   82     |      72
                   81     |      73
   Age -------------------------------------
                   46     |      63
                   44     |      62
          Old      45     |      66
                   51     |      62
                   43     |      60

***Data for problem 7-3;
                        Brand
                   C       |       P
            ---------------|----------------
                   7       |       9
                   6       |       8
                   6       |       9
       <20         5       |       9
                   6       |       8
  Age --------------------------------------
                   9       |       6
                   8       |       7
                   8       |       6
       >=20        9       |       6
                   7       |       5
                   8       |       
                   8       |

***Data for problem 7-6;
      Math Scores and Ages for Groups A, B, and C
    ------------------------------------------------
     Group A             Group B             Group C
 ---------------     ---------------     ---------------
 Math Score  Age     Math Score  Age     Math Score  Age
     90       16         92       18         97       18
     88       15         88       13         92       17
     72       12         76       12         88       16
     82       14         78       14         92       17
     65       12         90       17         99       17
     74       13         68       12         82       14

***Chapter 8 programs and data;

DATA PAIN;
   INPUT SUBJ @;  
   DO DRUG = 1 to 4;  
      INPUT PAIN @;  
      OUTPUT;  
   END;  
DATALINES;
1 5 9 6 11
2 7 12 8 9
3 11 12 10 14
4 3 8 5 8
;            

DATA PAIN;
   SUBJ+1;
   DO DRUG=1 TO 4;
      INPUT PAIN @;
      OUTPUT;
   END;
DATALINES;
5 9 6 11
7 12 8 9
11 12 10 14
3 8 5 8
;

PROC ANOVA DATA=PAIN;
   TITLE 'One-way Repeated Measures ANOVA';
   CLASS SUBJ DRUG;
   MODEL PAIN = SUBJ DRUG;
   MEANS DRUG / DUNCAN;   
RUN;

DATA REPEAT1;
   INPUT PAIN1-PAIN4;
DATALINES;
5 9 6 11
7 12 8 9
11 12 10 14
3 8 5 8
;
PROC ANOVA DATA=REPEAT1;
   TITLE 'One-way ANOVA Using the REPEATED Statement';
   MODEL PAIN1-PAIN4 = / NOUNI;
   REPEATED DRUG 4 (1 2 3 4);
RUN;

PROC ANOVA DATA=REPEAT1;
   TITLE 'One-way ANOVA Using the Repeated Statement';
   MODEL PAIN1-PAIN4 = / NOUNI;
   REPEATED DRUG 4 CONTRAST(1)/ NOM SUMMARY;
   REPEATED DRUG 4 CONTRAST(2)/ NOM SUMMARY;
   REPEATED DRUG 4 CONTRAST(3)/ NOM SUMMARY;
RUN;

DATA PREPOST;
   INPUT SUBJ GROUP $ PRETEST POSTEST;
   DIFF = POSTEST-PRETEST;
DATALINES;
1 C 80 83
2 C 85 86
3 C 83 88
4 T 82 94
5 T 87 93
6 T 84 98
;
PROC TTEST DATA=PREPOST;
   TITLE 'T-test on Difference Scores';
   CLASS GROUP;
   VAR DIFF;
RUN;

PROC ANOVA DATA=PREPOST;
   TITLE1 'Two-way ANOVA with a Repeated Measure on One Factor';
   CLASS GROUP;
   MODEL PRETEST POSTEST = GROUP / NOUNI;
   REPEATED TIME  2 (0 1);
   MEANS GROUP;
RUN;

DATA TWOWAY;
   SET PREPOST;  
   TIME = 'PRE ';  
   SCORE = PRETEST;  
   OUTPUT;  
   TIME = 'POST';  
   SCORE = POSTEST;  
   OUTPUT;  
   DROP PRETEST POSTEST DIFF; 
RUN;

PROC ANOVA DATA=TWOWAY;
   TITLE 'Two-way ANOVA with TIME as a Repeated Measure';
   CLASS SUBJ GROUP TIME;
   MODEL SCORE = GROUP SUBJ(GROUP) TIME
                 GROUP*TIME TIME*SUBJ(GROUP);
   MEANS GROUP|TIME;
   TEST H=GROUP               E=SUBJ(GROUP);
   TEST H=TIME GROUP*TIME     E=TIME*SUBJ(GROUP);
RUN;

PROC MEANS DATA=TWOWAY NOPRINT NWAY;
   CLASS GROUP TIME;
   VAR SCORE;
   OUTPUT OUT=INTER
          MEAN=;
RUN;

DATA SLEEP;
   INPUT SUBJ TREAT $ TIME $ REACT;
DATALINES;
1 CONT AM 65
1 DRUG AM 70
1 CONT PM 55
1 DRUG PM 60
2 CONT AM 72
2 DRUG AM 78
2 CONT PM 64
2 DRUG PM 68
3 CONT AM 90
3 DRUG AM 97
3 CONT PM 80
3 DRUG PM 85
;

PROC ANOVA DATA=SLEEP;
   CLASS SUBJ TREAT TIME;
   MODEL REACT = SUBJ|TREAT|TIME;
   MEANS TREAT|TIME;
   TEST H=TREAT       E=SUBJ*TREAT;
   TEST H=TIME        E=SUBJ*TIME;
   TEST H=TREAT*TIME  E=SUBJ*TREAT*TIME;
RUN;

DATA SLEEP;
   SUBJ+1;
   DO TIME=1 to 2;  
      DO TREAT=1 TO 2;
         INPUT REACT @;  
         OUTPUT;
      END;
   END;
DATALINES;
65 70 55 60
72 78 64 68
90 97 80 85
;
PROC ANOVA DATA=SLEEP;
   CLASS SUBJ TREAT TIME;
   MODEL REACT = SUBJ|TREAT|TIME;
   MEANS TREAT|TIME;
   TEST H=TREAT       E=SUBJ*TREAT;
   TEST H=TIME        E=SUBJ*TIME;
   TEST H=TREAT*TIME  E=SUBJ*TREAT*TIME;
RUN;

PROC FORMAT;
   VALUE FTREAT 1='Control' 2='Drug';
   VALUE FTIME 1='AM' 2='PM';
RUN;

DATA SLEEP;
   SUBJ+1;
   DO TIME=1 TO 2;
      DO TREAT=1 TO 2;
         INPUT REACT @;
         OUTPUT;
      END;
   END;
   FORMAT TREAT FTREAT. TIME FTIME.;
DATALINES;
65 70 55 60
72 78 64 68
90 97 80 85
;
PROC ANOVA DATA=SLEEP;
   CLASS SUBJ TREAT TIME;
   MODEL REACT = SUBJ|TREAT|TIME;
   MEANS TREAT|TIME;
   TEST H=TREAT       E=SUBJ*TREAT;
   TEST H=TIME        E=SUBJ*TIME;
   TEST H=TREAT*TIME  E=SUBJ*TREAT*TIME;
RUN;

DATA REPEAT2;
   INPUT REACT1-REACT4;
DATALINES;
65 70 55 60
72 78 64 68
90 97 80 85
;
PROC ANOVA DATA=REPEAT2;
   MODEL REACT1-REACT4 = / NOUNI;
   REPEATED TIME 2 , TREAT 2  / NOM;
RUN;

DATA COFFEE;
   INPUT SUBJ BRAND $ GENDER $ SCORE_B SCORE_D;
DATALINES;
1  A M 7 8
2  A M 6 7
3  A M 6 8
4  A F 5 7
5  A F 4 7
6  A F 4 6
7  B M 4 6
8  B M 3 5
9  B M 3 5
10 B F 3 4
11 B F 4 4
12 B F 2 3
13 C M 8 9
14 C M 6 9
15 C M 5 8
16 C F 6 9
17 C F 6 9
18 C F 7 8
;
PROC ANOVA DATA=COFFEE;
   TITLE 'Coffee Study';
   CLASS BRAND GENDER;
   MODEL SCORE_B SCORE_D = BRAND|GENDER / NOUNI;
   REPEATED MEAL;
   MEANS BRAND|GENDER;
RUN;

PROC ANOVA DATA=COFFEE;
   CLASS SUBJ BRAND GENDER MEAL;
   MODEL SCORE = BRAND GENDER BRAND*GENDER SUBJ(BRAND GENDER)
                 MEAL BRAND*MEAL GENDER*MEAL BRAND*GENDER*MEAL
                 MEAL*SUBJ(BRAND GENDER);
   MEANS BRAND|GENDER / DUNCAN E=SUBJ(BRAND GENDER);
   MEANS MEAL BRAND*MEAL GENDER*MEAL BRAND*GENDER*MEAL;
*-----------------------------------------------------------*
| The following TEST statements are needed to obtain the    |
| correct F and p-values:                                   |
*-----------------------------------------------------------*;
TEST H=BRAND GENDER BRAND*GENDER 
     E=SUBJ(BRAND GENDER);
TEST H=MEAL BRAND*MEAL GENDER*MEAL BRAND*GENDER*MEAL
     E=MEAL*SUBJ(BRAND GENDER);
RUN;

DATA READ_1;
   INPUT SUBJ SES $ READ1-READ6;
   LABEL READ1 = 'SPRING YR 1'
         READ2 = 'FALL YR 1'
         READ3 = 'SPRING YR 2'
         READ4 = 'FALL YR 2'
         READ5 = 'SPRING YR 3' 
         READ6 = 'FALL YR 3';
DATALINES;
1 HIGH 61 50 60 55 59 62
2 HIGH 64 55 62 57 63 63
3 HIGH 59 49 58 52 60 58
4 HIGH 63 59 65 64 67 70
5 HIGH 62 51 61 56 60 63
6 LOW  57 42 56 46 54 50
7 LOW  61 47 58 48 59 55
8 LOW  55 40 55 46 57 52
9 LOW  59 44 61 50 63 60
10 LOW 58 44 56 49 55 49
;
PROC ANOVA DATA=READ_1;
   TITLE 'Reading Comprehension Analysis';
   CLASS SES;
   MODEL READ1-READ6 = SES / NOUNI;
   REPEATED YEAR 3, SEASON 2;
   MEANS SES;
RUN;

*----------------------------------------------------------*
| Alternative Program for reading in the data for the      |
| reading experiment with all the data for one subject on  |
| one line.                                                |
*----------------------------------------------------------*;
DATA READ_3;
   DO SES = 'HIGH','LOW';  
      SUBJ = 0;  
      DO N = 1 TO 5;  
        SUBJ + 1;  
        DO YEAR = 1 TO 3;  
            DO SEASON = 'SPRING','FALL';  
               INPUT SCORE @;  
               OUTPUT;  
            END;
         END;
      END;
   END;
   DROP N;  
DATALINES;
61 50 60 55 59 62
64 55 62 57 63 63
59 49 58 52 60 58
63 59 65 64 67 70
62 51 61 56 60 63
57 42 56 46 54 50
61 47 58 48 59 55
55 40 55 46 57 52
59 44 61 50 63 60
58 44 56 49 55 49
;
PROC ANOVA DATA=READ_3;
   TITLE 'Reading Comprehension Analysis';
   CLASS SUBJ SES YEAR SEASON;
   MODEL SCORE = SES SUBJ(SES)
             YEAR SES*YEAR YEAR*SUBJ(SES)
             SEASON SES*SEASON SEASON*SUBJ(SES)
             YEAR*SEASON SES*YEAR*SEASON YEAR*SEASON*SUBJ(SES);
   MEANS YEAR / DUNCAN E=YEAR*SUBJ(SES);
   MEANS SES SEASON SES*YEAR SES*SEASON YEAR*SEASON
         SES*YEAR*SEASON;
   TEST H=SES                   E=SUBJ(SES);
   TEST H=YEAR SES*YEAR         E=YEAR*SUBJ(SES);
   TEST H=SEASON SES*SEASON     E=SEASON*SUBJ(SES);
   TEST H=YEAR*SEASON SES*YEAR*SEASON
                                E=YEAR*SEASON*SUBJ(SES);
RUN;

***Data for problem 8-1;
11836
21747
31767
41846
12635
22534
32546
42436
13988
23877
33978
43887

***Data for problem 8-2;
00118
00126
00138
00145
00215
00226
00235
00244
00317
00324
00336
00344
00417
00425
00437
00443

***data for problem 8-3;
0018685
0025654
0037464
0047573

***Data for problem 8-4;
          RATNO      DISTAL      PROXIMAL
     ---------------------------------------
            1          34          38
 Normal     2          28          38
            3          38          48
            4          32          38
--------------------------------------------
            5          44          42
 Diabetic   6          52          48
            7          46          46
            8          54          50

***Chapter 9 programs and data;
DATA REGRESSN;
   INPUT ID DOSAGE EXERCISE LOSS;
DATALINES;
   1        100         0         -4
   2        100         0          0
   3        100         5         -7
   4        100         5         -6
   5        100        10         -2
   6        100        10        -14
   7        200         0         -5
   8        200         0         -2
   9        200         5         -5
  10        200         5         -8
  11        200        10         -9
  12        200        10         -9
  13        300         0          1
  14        300         0          0
  15        300         5         -3
  16        300         5         -3
  17        300        10         -8
  18        300        10        -12
  19        400         0         -5
  20        400         0         -4
  21        400         5         -4
  22        400         5         -6
  23        400        10         -9
  24        400        10         -7 
;
PROC REG DATA=REGRESSN;
   TITLE 'Weight Loss Experiment - Regression Example';
   MODEL LOSS = DOSAGE EXERCISE / P R;
RUN;
QUIT;

DATA NONEXP;
   INPUT ID ACH6 ACH5 APT ATT INCOME;
DATALINES;
 1      7.5      6.6      104      60      67    
 2      6.9      6.0      116      58      29     
 3      7.2      6.0      130      63      36     
 4      6.8      5.9      110      74      84     
 5      6.7      6.1      114      55      33     
 6      6.6      6.3      108      52      21     
 7      7.1      5.2      103      48      19     
 8      6.5      4.4       92      42      30     
 9      7.2      4.9      136      57      32     
10      6.2      5.1      105      49      23     
11      6.5      4.6       98      54      57     
12      5.8      4.3       91      56      29
13      6.7      4.8      100      49      30     
14      5.5      4.2       98      43      36
15      5.3      4.3      101      52      31     
16      4.7      4.4       84      41      33
17      4.9      3.9       96      50      20
18      4.8      4.1       99      52      34
19      4.7      3.8      106      47      30
20      4.6      3.6       89      58      27 
;
PROC REG DATA=NONEXP;
   TITLE 'Nonexperimental Design Example';
   MODEL  ACH6  =  ACH5  APT ATT  INCOME /
                   SELECTION = FORWARD;
   MODEL  ACH6  =  ACH5  APT ATT  INCOME /
                   SELECTION = MAXR;
RUN;
QUIT;
  
PROC REG DATA=NONEXP;
   MODEL ACH6 = INCOME ATT APT ACH5 / SELECTION=RSQUARE;
   MODEL ACH5 = INCOME ATT APT / SELECTION=RSQUARE;
RUN;

PROC CORR DATA=NONEXP NOSIMPLE;
   VAR APT ATT ACH5 ACH6 INCOME;
RUN;

*----------------------------------------------------*
| Program Name: LOGISTIC.SAS  in C:\APPLIED          |
| Purpose: To demonstrate logistic regression        |
| Date: June 6, 1996                                 |
*----------------------------------------------------*;
PROC FORMAT;
   VALUE AGEGROUP 0 = '>=20 and <=65'
                  1 = '<20 or >65';
   VALUE VISION   0 = 'No Problem'
                  1 = 'Some Problem';
   VALUE YES_NO   0 = 'No'
                  1 = 'Yes';

RUN;

DATA LOGISTIC;
Note: INFILE removed and DATALINES substituted;
   INPUT ACCIDENT AGE VISION DRIVE_ED;
   ***Note: No missing ages;
   IF AGE < 20 OR AGE > 65 THEN AGEGROUP = 1;
   ELSE AGEGROUP=0;
   IF AGE < 20 THEN YOUNG = 1;
   ELSE YOUNG = 0;
   IF AGE > 65 THEN OLD = 1;
   ELSE OLD = 0;

   LABEL ACCIDENT = 'Accident in Last Year?'
         AGE      = 'Age of Driver'
         VISION   = 'Vision Problem?'
         DRIVE_ED = 'Driver Education?';

   FORMAT ACCIDENT
          DRIVE_ED
          YOUNG
          OLD        YES_NO.
          AGEGROUP   AGEGROUP.
          VISION     VISION.;
DATALINES;
    1           17         1           1
    1           44         0           0
    1           48         1           0
    1           55         0           0
    1           75         1           1
    0           35         0           1
    0           42         1           1
    0           57         0           0 
    0           28         0           1
    0           20         0           1
    0           38         1           0
    0           45         0           1
    0           47         1           1
    0           52         0           0
    0           55         0           1
    1           68         1           0
    1           18         1           0
    1           68         0           0
    1           48         1           1
    1           17         0           0
    1           70         1           1
    1           72         1           0
    1           35         0           1
    1           19         1           0
    1           62         1           0
    0           39         1           1
    0           40         1           1
    0           55         0           0 
    0           68         0           1
    0           25         1           0
    0           17         0           0
    0           45         0           1
    0           44         0           1
    0           67         0           0
    0           55         0           1
    1           61         1           0
    1           19         1           0
    1           69         0           0
    1           23         1           1
    1           19         0           0
    1           72         1           1
    1           74         1           0
    1           31         0           1
    1           16         1           0
    1           61         1           0
;

PROC LOGISTIC DATA=LOGISTIC DESCENDING;
   TITLE 'Predicting Accidents Using Logistic Regression';
   MODEL ACCIDENT = AGE VISION DRIVE_ED /
                    SELECTION = FORWARD
                    CTABLE PPROB=(0 to 1 by .1)
                    LACKFIT
                    RISKLIMITS;
RUN;
QUIT;

OPTIONS PS=30;
PROC CHART DATA=LOGISTIC;
   TITLE 'Distribution of Ages by Accident Status';
   VBAR AGE / MIDPOINTS=10 TO 90 BY 10
              GROUP=ACCIDENT;
 RUN;

PROC LOGISTIC DATA=LOGISTIC DESCENDING;
   TITLE 'Predicting Accidents Using Logistic Regression';
   MODEL ACCIDENT = AGEGROUP VISION DRIVE_ED /
                    SELECTION = FORWARD
                    CTABLE PPROB=(0 to 1 by .1)
                    LACKFIT
                    RISKLIMITS
                    OUTROC=ROC;
RUN;
QUIT;

OPTIONS LS=64 PS=32;
PROC PLOT DATA=ROC;
   TITLE 'ROC Curve';
   PLOT _SENSIT_ * _1MSPEC_ = 'o';
   LABEL _SENSIT_ = 'Sensitivity'
         _1MSPEC_ = '1 - Specificity';
RUN;

PROC LOGISTIC DATA=LOGISTIC DESCENDING;
   TITLE 'Predicting Accidents Using Logistic Regression';
   TITLE 'Using Two Dummy Variables (YOUNG and OLD) for AGE';
   MODEL ACCIDENT = YOUNG OLD VISION DRIVE_ED /
                    SELECTION = FORWARD
                    CTABLE PPROB=(0 to 1 by .1)
                    LACKFIT
                    RISKLIMITS
                    OUTROC=ROC;
RUN;
QUIT;

***Data for problem 9-1;
YIELD    LIGHT    WATER    |   YIELD    LIGHT    WATER
---------------------------|--------------------------
  12       1        1      |     20       2        2
   9       1        1      |     16       2        2
   8       1        1      |     16       2        2
  13       1        2      |     18       3        1
  15       1        2      |     25       3        1
  14       1        2      |     20       3        1
  16       2        1      |     25       3        2
  14       2        1      |     27       3        2
  12       2        1      |     29       3        2

***Data for problem 9-2;
     BOOKS     STUDENT ENROLLMENT  DEGREE    AREA
 (in millions)   (in thousands)             (acres)
---------------------------------------------------
       4               5             3        20
       5               8             3        40
      10              40             3       100        
       1               4             2        50
      .5               2             1       300
       2               8             1       400
       7              30             3        40
       4              20             2       200
       1              10             2         5
       1              12             1       100

***Data for problem 9-3;
GPA  HS GPA    COLLEGE BOARD  IQ TEST
-------------------------------------
3.9    3.8         680         130
3.9    3.9         720         110
3.8    3.8         650         120
3.1    3.5         620         125
2.9    2.7         480         110
2.7    2.5         440         100
2.2    2.5         500         115
2.1    1.9         380         105
1.9    2.2         380         110
1.4    2.4         400         110

***Data for problem 9-7;
Accident in  Drinking    Previous
Past Year    Problem     Accident
---------------------------------
    1           0           1
    1           1           1
    1           1           1
    1           0           0
    1           1           1
    0           0           1
    0           1           0
    0           1           0
    0           0           1
    0           0           0
    0           1           0
    0           0           1
    0           1           0
    0           0           0
    0           0           0
    1           1           0
    1           0           1
    1           1           1
    1           1           1
    1           0           1
    1           1           1
    1           1           0
    1           0           1
    1           1           0
    1           1           1
    0           1           1
    0           1           1
    0           0           1
    0           0           1
    0           1           0
    0           0           0
    0           0           1
    0           1           0
    0           0           0
    0           0           0
    1           1           1
    1           1           0
    1           0           1
    1           1           1
    1           1           0
    1           1           1
    1           1           0
    1           1           1
    1           1           1
    1           1           1

***Chapter 10 programs and data;
*------------------------------------------------------------*
| Program Name: FACTOR.SAS  in C:\APPLIED                    |
| Purpose: To perform a factor analysis on psycological Data |
*------------------------------------------------------------*; 
PROC FORMAT;
   VALUE LIKERT 
      1 = 'V. Strong Dis.'
      2 = 'Strongly Dis.'
      3 = 'Disagree'
      4 = 'No Opinion'
      5 = 'Agree'
      6 = 'Strongly Agree'
      7 = 'V. Strong Agree';
RUN;

DATA FACTOR;
   ***Note: INFILE replaced by DATALINES;
   INPUT SUBJ 1-2 @3 (QUES1-QUES6)(1.);
 LABEL    QUES1='Feel Blue'
         QUES2='People Stare at Me'
         QUES3='People Follow Me'
         QUES4='Basically Happy'
         QUES5='People Want to Hurt Me'
         QUES6='Enjoy Going to Parties';
DATALINES;
 1723456
 2632132
 3367363
 4222534
 5342423
 6634232
 7123722
 8332343
 9211625
10623222
11354233
12676262
13511262
14211615
15121717
;
PROC FACTOR DATA=FACTOR PREPLOT PLOT ROTATE=VARIMAX 
            NFACTORS=2 OUT=FACT SCREE;
    TITLE 'Example of Factor Analysis';
    VAR QUES1-QUES6;
RUN;

PROC FACTOR DATA=FACTOR ROTATE=PROMAX 
            NFACTORS=2;
    TITLE 'Example of Factor Analysis - Oblique Rotation';
    VAR QUES1-QUES6;
RUN;

PROC FACTOR DATA=FACTOR PREPLOT PLOT ROTATE=VARIMAX 
            NFACTORS=2 OUT=FACT SCREE;
    TITLE 'Example of Factor Analysis';
    VAR QUES1-QUES6;
    PRIORS SMC;  ***This is the new line;
RUN;

DATA FACTOR;
   INFILE 'C:\APPLIED\FACTOR.DTA' PAD;
   INPUT SUBJ 1-2 @3 (QUES1-QUES6)(1.);
   ***Reverse the scores for questions 4 and 6;
   QUES4 = 8 - QUES4;
   QUES6 = 8 - QUES6;

LABEL    QUES1='Feel Blue'
         QUES2='People Stare at Me'
         QUES3='People Follow Me'
         QUES4='Basically Happy'
         QUES5='People Want to Hurt Me'
         QUES6='Enjoy Going to Parties';
RUN;

PROC PRINT  DATA=FACT NOOBS;
   TITLE 'Output Data Set (FACT) Created by PROC FACTOR';
   TITLE2 'Questions 4 and 6 Reversed';
RUN;

***Chapter 11 programs and data;

*----------------------------------------------------------*
| Program Name: SCORE1.SAS  in C:\APPLIED                  |
| Purpose: To score a five item multiple choice exam.      |
| Data: The first line is the answer key, remaining lines  |
|       contain the student responses                      |
| Date: July 23, 1996                                      |
*----------------------------------------------------------*;   
DATA SCORE;
   ARRAY ANS[5] $ 1 ANS1-ANS5; ***Student answers;
   ARRAY KEY[5] $ 1 KEY1-KEY5; ***Answer key;
   ARRAY S[5] 3 S1-S5; ***Score array 1=right,0=wrong;
   RETAIN KEY1-KEY5; 

   ***Read the answer key;
   IF _N_ = 1 THEN INPUT (KEY1-KEY5)($1.); 

   ***Read student responses;
   INPUT @1 ID 1-9  
         @11 (ANS1-ANS5)($1.);

   ***Score the test;
   DO I = 1 TO 5;  
      S[I] = KEY[I] EQ ANS[I];  
   END;

   ***Compute Raw and Percentage scores;
   RAW = SUM (OF S1-S5);  
   PERCENT = 100*RAW / 5;  

   KEEP ID RAW PERCENT;

   LABEL ID = 'Social Security Number'
         RAW = 'Raw Score'
         PERCENT  = 'Percent Score';
DATALINES;
ABCDE
123456789 ABCDE
035469871 BBBBB
111222333 ABCBE
212121212 CCCDE
867564733 ABCDA
876543211 DADDE
987876765 ABEEE
;
PROC SORT DATA=SCORE;
   BY ID;
RUN;

PROC PRINT DATA=SCORE LABEL;
   TITLE 'Listing of SCORE data set';
   ID ID;
   VAR RAW PERCENT;
   FORMAT ID SSN11.;
RUN;

*-------------------------------------------------------------*
| Program Name: SCORE2.SAS  in C:\APPLIED                     |
| Purpose: To score a multiple-choice exam with an arbitrary  |
|          number of items                                    |
| Data: The first line is the answer key, remaining lines     |
|       contain the student responses                         |
|       Data in file C:\APPLIED\TEST.DTA                      |
| Date: July 23, 1996                                         |
*-------------------------------------------------------------*;   

%LET NUMBER = 5; ***The number of items on the test; 

DATA SCORE;
   INFILE 'C:\APPLIED\TEST.DTA';  
   ARRAY ANS[&NUMBER] $ 1 ANS1-ANS&NUMBER; ***Student answers;
   ARRAY KEY[&NUMBER] $ 1 KEY1-KEY&NUMBER; ***Answer key;
   ARRAY S[&NUMBER] 3 S1-S&NUMBER; ***Score array 1=right,0=wrong;
   RETAIN KEY1-KEY&NUMBER;
    IF _N_ = 1 THEN INPUT (KEY1-KEY&NUMBER)($1.);
    INPUT @1 ID 1-9
         @11 (ANS1-ANS&NUMBER)($1.);
    DO I = 1 TO &NUMBER;
      S[I] = KEY[I] EQ ANS[I];
   END;
    RAW = SUM (OF S1-S&NUMBER);
   PERCENT = 100*RAW / &NUMBER;

   KEEP ANS1-ANS&NUMBER ID RAW PERCENT;
       
   LABEL ID = 'Social Security Number'
         RAW = 'Raw Score'
         PERCENT  = 'Percent Score';
RUN;

PROC SORT DATA=SCORE;  
   BY ID;
RUN;

PROC PRINT DATA=SCORE LABEL;  
   TITLE 'Listing of SCORE data set';
   ID ID;
   VAR RAW PERCENT;
   FORMAT ID SSN11.;
RUN;

PROC MEANS DATA=SCORE MAXDEC=2 N MEAN STD RANGE MIN MAX;
   TITLE 'Class Statistics';
   VAR RAW PERCENT;
RUN;

PROC CHART DATA=SCORE;  
   TITLE 'Histogram of Student Scores';
   VBAR PERCENT / MIDPOINTS=50 TO 100 BY 5;
RUN;

PROC FREQ DATA=SCORE;  
   TITLE 'Frequency Distribution of Student Answers';
   TABLES ANS1-ANS&NUMBER / NOCUM;
RUN;

*-------------------------------------------------------------*
| Program Name: SCORE2.SAS  in C:\APPLIED                     |
| Purpose: To score a multiple-choice exam with an arbitrary  |
|          number of items                                    |
| Data: The first line is the answer key, remaining lines     |
|       contain the student responses                         |
|       Data in file C:\APPLIED\TEST.DTA                      |
| Date: July 23, 1996                                         |
*-------------------------------------------------------------*;   

%LET NUMBER = 5; ***The number of items on the test; 

DATA SCORE;
   INFILE 'C:\APPLIED\TEST.DTA';  
   ARRAY ANS[&NUMBER] $ 1 ANS1-ANS&NUMBER; ***Student answers;
   ARRAY KEY[&NUMBER] $ 1 KEY1-KEY&NUMBER; ***Answer key;
   ARRAY S[&NUMBER] 3 S1-S&NUMBER; ***Score array 1=right,0=wrong;
   RETAIN KEY1-KEY&NUMBER;

   IF _N_ = 1 THEN INPUT (KEY1-KEY&NUMBER)($1.);

   INPUT @1 ID 1-9
         @11 (ANS1-ANS&NUMBER)($1.);

   DO I = 1 TO &NUMBER;
      S[I] = KEY[I] EQ ANS[I];
   END;

   RAW = SUM (OF S1-S&NUMBER);
   PERCENT = 100*RAW / &NUMBER;

   KEEP ANS1-ANS&NUMBER ID RAW PERCENT;
       
   LABEL ID = 'Social Security Number'
         RAW = 'Raw Score'
         PERCENT  = 'Percent Score';
RUN;

PROC SORT DATA=SCORE;  
   BY ID;
RUN;

PROC PRINT DATA=SCORE LABEL;  
   TITLE 'Listing of SCORE data set';
   ID ID;
   VAR RAW PERCENT;
   FORMAT ID SSN11.;
RUN;

PROC MEANS DATA=SCORE MAXDEC=2 N MEAN STD RANGE MIN MAX;
   TITLE 'Class Statistics';
   VAR RAW PERCENT;
RUN;

PROC CHART DATA=SCORE;  
   TITLE 'Histogram of Student Scores';
   VBAR PERCENT / MIDPOINTS=50 TO 100 BY 5;
RUN;

PROC FREQ DATA=SCORE;  
   TITLE 'Frequency Distribution of Student Answers';
   TABLES ANS1-ANS&NUMBER / NOCUM;
RUN;

*-------------------------------------------------------------*
| Program Name: SCORE3.SAS  in C:\APPLIED                     |
| Purpose: To score a multiple-choice exam with an arbitrary  |
|          number of items and compute item statistics        |
| Data: The first line is the answer key, remaining lines     |
|       contain the student responses.  Data is located in    |
|       file  C:\APPLIED\TEST.DTA                             |   
| Date: July 23, 1996                                         |
*-------------------------------------------------------------*;   

OPTIONS LS=64 PS=59 NOCENTER;

PROC FORMAT;  
   PICTURE PCT LOW-<0=' ' 0-HIGH='00000%';
RUN;

%LET NUMBER = 5; ***The number of items on the test;

DATA SCORE;
   INFILE 'C:\APPLIED\TEST.DTA';
   ARRAY ANS[&NUMBER] $ 2 ANS1-ANS&NUMBER; ***Student answers;
   ARRAY KEY[&NUMBER] $ 1 KEY1-KEY&NUMBER; ***Answer key;
   ARRAY S[&NUMBER] 3 S1-S&NUMBER; ***Score array 1=right,0=wrong;
   RETAIN KEY1-KEY&NUMBER;

   IF _N_ = 1 THEN INPUT (KEY1-KEY&NUMBER)($1.);

   INPUT @1 ID 1-9 
         @11 (ANS1-ANS&NUMBER)($1.);

   DO I = 1 TO &NUMBER;
      IF KEY[I] EQ ANS[I] THEN DO;
         S[I] = 1;
         SUBSTR(ANS[I],2,1) = '*'; ***Place an asterisk next
                                           to correct answer;
      END;
      ELSE S[I] = 0;
   END;
           
   RAW = SUM (OF S1-S&NUMBER);
   PERCENT = 100*RAW / &NUMBER;

   KEEP ANS1-ANS&NUMBER ID RAW PERCENT;

   LABEL ID = 'Social Security Number'
         RAW = 'Raw Score'
         PERCENT  = 'Percent Score';
RUN;

DATA TEMP;  
   SET SCORE;
   ARRAY ANS[*] $ 2 ANS1-ANS&NUMBER;
   DO QUESTION=1 TO &NUMBER;
      CHOICE=ANS[QUESTION];
      OUTPUT;
   END;
   KEEP QUESTION CHOICE PERCENT;
RUN;

PROC TABULATE DATA=TEMP;
   TITLE 'Item Analysis Using PROC TABULATE';
   CLASS QUESTION CHOICE;
   VAR PERCENT;
   TABLE QUESTION*CHOICE,
      PERCENT=' '*(PCTN<CHOICE>*F=PCT. MEAN*F=PCT.
      STD*F=10.2)   / RTS=20 MISSTEXT=' ';
   KEYLABEL ALL='Total' MEAN='Mean Score' PCTN='FREQ'
            STD='Standard Deviation';                   
RUN;

*-------------------------------------------------------------*
| Program Name: SCORE4.SAS  in C:\APPLIED                     |
| Purpose: To score a multiple-choice exam with an arbitrary  |
|          number of items                                    |
| Data: The first line is the answer key, remaining lines     |
|       contain the student responses                         |
|       Data in file C:\APPLIED\TEST.DTA                      |
| Date: July 23, 1996                                         |
*-------------------------------------------------------------*;

%LET NUMBER = 5; ***The number of items on the test;

DATA SCORE;
   INFILE 'C:\APPLIED\TEST.DTA';
   ARRAY ANS[&NUMBER] $ 1 ANS1-ANS&NUMBER; ***Student answers;
   ARRAY KEY[&NUMBER] $ 1 KEY1-KEY&NUMBER; ***Answer key;
   ARRAY S[&NUMBER] S1-S&NUMBER; ***Score array 1=right,0=wrong;
   RETAIN KEY1-KEY&NUMBER;

   IF _N_ = 1 THEN INPUT (KEY1-KEY&NUMBER)($1.);

   INPUT @1 ID 1-9
         @11 (ANS1-ANS&NUMBER)($1.);

   DO I = 1 TO &NUMBER;
      S[I] = KEY[I] EQ ANS[I];
   END;

   RAW = SUM (OF S1-S&NUMBER);
   PERCENT = 100*RAW / &NUMBER;

   KEEP ANS1-ANS&NUMBER S1-S&NUMBER KEY1-Key&NUMBER
        ID RAW PERCENT;
   ***Note: ANS1-ANSn, S1-Sn, KEY1-KEYn
            are needed later on;
   LABEL ID = 'Social Security Number'
         RAW = 'Raw Score'
         PERCENT  = 'Percent Score';
RUN;

*--------------------------------------------------------*
| You may want to include the procedures in Section C    |
| which print student rosters, histograms, and class     |
| statistics.                                            |
*--------------------------------------------------------*;

***Section to prepare data sets for PROC TABULATE;

***Write correlation coefficients to a data set;
PROC CORR DATA=SCORE NOSIMPLE NOPRINT
          OUTP=CORROUT(WHERE = (_TYPE_='CORR'));
   VAR S1-S&NUMBER;
   WITH RAW;
RUN;

***Reshape the data set;
DATA CORR;
   SET CORROUT;
   ARRAY S[*] 3 S1-S&NUMBER;
   DO I=1 TO &NUMBER;
      CORR=S[I];
      OUTPUT;
   END;
   KEEP I CORR;
RUN;

***Compute quartiles;
PROC RANK DATA=SCORE GROUPS=4 OUT=QUART(DROP=PERCENT ID);
   RANKS QUARTILE;
   VAR RAW;
RUN;

***Create ITEM variable and reshape again;
DATA TAB;
   SET QUART;
   LENGTH ITEM $ 5 QUARTILE CORRECT I 3 CHOICE $ 1;
   ARRAY S[*][ S1-S&NUMBER;
   ARRAY ANS[*][ $ 1 ANS1-ANS&NUMBER;
   ARRAY KEY[*][ $ 1 KEY1-KEY&NUMBER;
   QUARTILE=QUARTILE+1;
   DO I = 1 TO &NUMBER;
      ITEM = RIGHT(PUT(I,3.)) || " " || KEY[I];
      CORRECT = S[I];
      CHOICE = ANS[I];
      OUTPUT;
   END;
   KEEP I ITEM QUARTILE CORRECT CHOICE;
RUN;

PROC SORT DATA=TAB;
   BY I;
RUN;

***Combine correlations and quartile information;
DATA BOTH;
   MERGE CORR TAB;
   BY I;
RUN;

***Print out a pretty table;
OPTIONS LS=72;
PROC TABULATE FORMAT=7.2 DATA=BOTH ORDER=INTERNAL NOSEPS;
   TITLE 'Item Statistics';
   LABEL QUARTILE = 'Quartile'
         CHOICE   = 'Choices';
   CLASS ITEM QUARTILE CHOICE;
   VAR CORRECT CORR;
   TABLE ITEM='#  Key'*F=6.,
   CHOICE*(PCTN<CHOICE>)*F=3. CORRECT=' '*MEAN='Diff.'*F=PERCENT5.2
      CORR=' '*MEAN='Corr.'*F=5.2
      CORRECT=' '*QUARTILE*MEAN='Prop. Correct'*F=PERCENT7.2 /
      RTS=8;
   KEYLABEL PCTN='%' ;
RUN;

PROC CORR DATA=SCORE NOSIMPLE ALPHA;
   TITLE 'Coefficient Alpha from Data Set SCORE';
   VAR S1-S5;
RUN;

DATA KAPPA;
   INPUT SUBJECT RATER_1 $ RATER_2 $ @@;
DATALINES;
1 N N  2 X X  3 X X  4 X N  5 N X  
6 N N  7 N N  8 X N  9 X X  10 N N
;
PROC FREQ DATA=KAPPA;
   TITLE 'Coefficient Kappa Calculation';
   TABLE RATER_1 * RATER_2 / NOCUM NOPERCENT KAPPA;
RUN;

***Data for problem 11-1;
Student Data

Social Security #      Responses to Five Items
-----------------------------------------------
123-45-6789             B C D A A
001-44-5559             A B C D E
012-12-1234             B C C A B
135-63-2837             C B D A A
005-00-9999             E C E C E
789-78-7878             B C D A A

***Data for problem 11-2;
Rater 1   Rater 2           Rater 1   Rater 2
-----------------           -----------------
   C        C                  C         X
   X        X                  C         C
   X        X                  X         X
   C        X                  C         C
   X        C                  C         C
   X        X                  X         X
   X        X                  C         C

***Chapter 12 programs and data;
DATA QUEST;
   INPUT ID GENDER $ AGE HEIGHT WEIGHT;
DATALINES;
1 M 23 68 155
2 F . 61 102
3   M  55  70     202
;

1,M,23,68,155
2,F,.,61,102
3,  M, 55, 70,    202

DATA HTWT;
   INFILE 'A:SURVEY.DTA' DLM=',';
   INPUT ID GENDER $ AGE HEIGHT WEIGHT;
RUN;

1,"M",23,68,155
2,F,,61,102
3,  M, 55, 70,    202

DATA HTWT;
   INFILE 'A:SURVEY.DTA' DSD;
   INPUT ID GENDER $ AGE HEIGHT WEIGHT;
RUN;

DATA INFORM;
   INFORMAT DOB VISIT MMDDYY8.;
   INPUT ID DOB VISIT DX;
DATALINES;
1 10/21/46 6/5/89 256.20
2 9/15/44 4/23/89 232.0
   etc.
DATA FORM;
   INPUT ID DOB : MMDDYY8. VISIT : MMDDYY8. DX;
DATALINES;
1 10/21/46 6/5/89 256.20
2 9/15/44 4/23/89 232.0
   etc.

*Example with an INFORMAT statement;
DATA LONGNAME;
   INFORMAT LAST $20.;
   INPUT ID LAST SCORE;
DATALINES;
1 STEVENSON 89
2 CODY 100
3 SMITH 55
4 GETTLEFINGER 92
    etc.

*Example with INPUT informats;
DATA LONGNAME;
   INPUT ID LAST : $20. SCORE;
DATALINES;
1 STEVENSON 89
2 CODY 100
3 SMITH 55
4 GETTLEFINGER 92
    etc.

DATA FIRSTLST;
   INPUT ID NAME & $30. SCORE1 SCORE2;
DATALINES;
1 RON CODY  97 98
2 JEFF SMITH  57 58
   etc.
DATA COL;
   INPUT ID 1-3 GENDER $ 4 HEIGHT 5-6 WEIGHT 7-11;
DATALINES;
001M68155.5
2  F61 99.0
  3M  233.5
(more data lines)
DATA COL;
   INPUT ID       1-3 
         GENDER $   4 
         HEIGHT   5-6 
         WEIGHT   7-11;
DATALINES;
001M68155.5
2  F61 99.0
  3M  233.5
(more data lines)

DATA POINT;
   INPUT @1 ID 3.
         @4 GENDER $1.
         @9 AGE 2.
         @11 HEIGHT 2.
         @15 V_DATE MMDDYY6.;
DATA COLUMN;
   INPUT #1 ID 1-3 AGE 5-6 HEIGHT 10-11 WEIGHT 15-17
         #2 SBP 5-7 DBP 8-10;
DATALINES;
001 56   72   202
    140080
002 45   70   170
    130070
;
DATA QUEST;
   INPUT YEAR 79-80 @;  *** HOLD THE LINE;
   IF YEAR = 89 THEN INPUT @1 (QUES1-QUES10)(1.);
   ELSE IF YEAR = 90 THEN INPUT @1 (QUES1-QUES5)(1.)
      @6 QUES5B 1. @7 (QUES6-QUES10)(1.);
DATALINES;

DATA XYDATA;
   INPUT X Y @@;
DATALINES;
1 2 7 9 3 4 10 12
15 18 23 67
;       
Example 1-A.

***Traditional INPUT Method;
DATA EX1A;
   INPUT GROUP $ X @@;
DATALINES;
C 20 C 25 C 23 C 27 C 30
T 40 T 42 T 35
;
PROC TTEST DATA=EX1A;
   CLASS GROUP;
   VAR X;
RUN;

Example 1-B                EXAMPLE 1-C

DATA EX1B;                 DATA EX1C;
   GROUP='C';                 DO GROUP='C','T';
   DO I=1 TO 5;                  INPUT N;
      INPUT X @;                 DO I=1 TO N;
      OUTPUT;                       INPUT X @;
   END;                             OUTPUT;
   GROUP='T';                    END;
   DO I=1 TO 3;               END;
      INPUT X @;              DROP N I;
      OUTPUT;              DATALINES;
   END;                    5
   DROP I;                 20 25 23 27 30
DATALINES                  3
20 25 23 27 30             40 42 35
40 42 35                   ;
;                          PROC TTEST DATA=EX1C;
PROC TTEST DATA=EX1B;         CLASS GROUP;
   CLASS GROUP;               VAR X;
   VAR X;                  RUN;           
RUN;           

***Reading the Data with Tags;
DATA EX1D;
   RETAIN GROUP;
   INPUT DUMMY $ @@;
   IF DUMMY='C' OR DUMMY='T' THEN GROUP=DUMMY;
   ELSE DO;
      X=INPUT (DUMMY,5.0);
      OUTPUT;
   END;
   DROP DUMMY;
DATALINES;
C 20 25 23 27 30
T 40 42 35
;
PROC TTEST DATA=EX1D;
   CLASS GROUP;
   VAR X;
RUN;                            

***First Method of Reading ANOVA Data with Tags;
DATA EX2A;
   DO GENDER='M','F';
       DO GROUP='A','B','C';
         INPUT DUMMY $ @;
         DO WHILE (DUMMY NE '#');
            SCORE=INPUT(DUMMY,6.0);
            OUTPUT;
            INPUT DUMMY $ @;
         END;
      END;
   END;
   DROP DUMMY;
DATALINES;
20 30 40 20 50 # 70 80 90
# 90 90 80 90 # 25 30 45 30
65 72 # 70 90 90 80 85 # 20 20 30 #
;
PROC GLM DATA=EX2A;
   etc.

***More Elegant Method for Unbalanced ANOVA Design;
DATA EX2B;
   RETAIN GROUP GENDER;
   INPUT DUMMY $ @@;
   IF VERIFY (DUMMY,'ABCMF ') = 0 THEN DO;
      GROUP = SUBSTR (DUMMY,1,1);
      GENDER = SUBSTR (DUMMY,2,1);
      DELETE;
   END;
   ELSE SCORE = INPUT (DUMMY,6.);
   DROP DUMMY;
DATALINES;
AM 20 30 40 20 50
BM 70 80 90
CM 90 80 80 90
AF 25 30 45 30 65 72
BF 70 90 90 80 85
CF 20 20 30
;
PROC GLM DATA=EX2B;
   etc.

***Data for problem 12-1;
Group    Score
-----------------
  P        77
  P        76
  P        74
  P        72
  P        78
  D        80
  D        84
  D        88
  D        87
  D        90

P 77 P 76 P 74 P 72 P 78
D 80 D 84 D 88 D 87 D 90

77 76 74 72 78
80 84 88 87 90

***Data for problem 12-2;
1,3,5,7
2,4,6,8
9,8,7,6

***Data for problem 12-3;
1,,"HELLO",7
2,4,TEXT,8
9,,,6

***Data for problem 12-4;
1 10/01/96 V075 $102.45
2      02/05/97    X123456789  $3,123
3  07/07/96     V4568
4     11/11/96    A123     $777.

***Data for problem 12-5;
A12 X 111213
A13 W 102030

***Data for problem 12-7;
123M     102146111196111396  130 8668134 8872136 8870
456F     010150122596020597  220110822101028424012084

*Data for problem 12-8;
01 2345
  AAAX
02 9876
  BBBY

***Data for problem 12-9;
1 2  3 4  5 6  7 8
11 12   13 14
21 22  23 24  25 26  27 28

***Data for problem 12-10;
00168155   1
00272201   1
0034570170 2
0045562 90 2

***Chapter 13 programs and data;
DATA EX1;
   INPUT GROUP $ X Y Z;
DATALINES;
CONTROL 12 17 19
TREAT 23 25 29
CONTROL 19 18 16
TREAT 22 22 29
;
PROC MEANS DATA=EX1 N MEAN STD STDERR MAXDEC=2;
   TITLE 'MEANS FOR EACH GROUP';
   CLASS GROUP;
   VAR X Y Z;
RUN;

DATA TEST;
   INPUT AUTHOR $10. TITLE $40.;
DATALINES;
SMITH    The Use of the ; in Writing
FIELD    Commentary on Smith's Book
;

DATA TEST;
   INPUT AUTHOR $10. TITLE $40.;
DATALINES4;
SMITH     The Use of the ; in Writing
FIELD     Commentary on Smith's Book
;;;;

*-----------------------------------------------*
| Personal Computer or UNIX Example             |
| Reading ASCII data from an External Data File |
*-----------------------------------------------*;
DATA EX2A;
   INFILE 'B:MYDATA';
   ****This INFILE statement tells the program that
       our INPUT data is located in the file MYDATA 
       on a floppy diskette in the B drive;
   INPUT GROUP $ X Y Z;
RUN;

PROC MEANS DATA=EX2A N MEAN STD STDERR MAXDEC=2 ;
   VAR X Y Z;
RUN;

***Data file MYDATA;
CONTROL 12 17 19
TREAT 23 25 29
CONTROL 19 18 16
TREAT 22 22 29

DATA EX2B;
   FILENAME GEORGE 'B:MYDATA';
   INFILE GEORGE;
   ****This INFILE statement tells the program that
       our INPUT data is located in the file MYDATA 
       on a floppy diskette in the B drive;
   INPUT GROUP $ X Y Z;
RUN;

PROC MEANS DATA=EX2B N MEAN STD STDERR MAXDEC=2 ;
   VAR X Y Z;
RUN;

//JOBNAME JOB (ACCT,BIN),'RON CODY'
//   EXEC SAS
//SAS.GEORGE DD DSN=ABC.MYDATA,DISP=SHR
//SAS.SYSIN DD *
DATA EX2C;
   INFILE GEORGE;
   ***This INFILE statement tells the program that the 
      file ABC.MYDATA contains our external data file 
     (Assume it is catalogued);
   INPUT GROUP $ X Y Z;
RUN;

PROC MEANS DATA=EX2C N MEAN STD STDERR MAXDEC=2 ;
   VAR X Y Z;
RUN;

CMS FILEDEF GEORGE DISK MYDATA DATA B;
***The file MYDATA DATA is on the B minidisk;
DATA EX2D;
   INFILE GEORGE;
   ***This INFILE statement tells the program that the 
      data is located in the file with FILENAME MYDATA, 
      FILETYPE DATA, and FILEMODE B.;
   INPUT GROUP $ X Y Z;
RUN;

PROC MEANS DATA=EX2D N MEAN STD STDERR MAXDEC=2 ;
   VAR X Y Z;
RUN;

DATA EX2E;
   IF TESTEND NE 1 THEN INFILE 'B:OSCAR' END=TESTEND;
   ELSE INFILE 'C:\DATA\BIGBIRD.TXT';
   INPUT GROUP $ X Y Z;
RUN;

PROC MEANS DATA=EX2E N MEAN STD STDERR MAXDEC=2;
   VAR X Y Z;
RUN;

CONTROL 1 2 3
TREAT 4 5 
CONTROL 6 7 8
TREAT 8 9 10

DATA EX2F; 
   INFILE 'B:MYDATA' MISSOVER;
   INPUT GROUP $ X Y Z;
RUN;

PROC MEANS DATA=EX2F N MEAN STD STDERR MAXDEC=2 ;
   VAR X Y Z;
RUN;

DATA EX2G; 
   INFILE 'C:\DATA\MYDATA.TXT' PAD;
   INPUT GROUP $ 1
         X       2-3
         Y       4-5
         Z       6-7;
RUN;

PROC MEANS DATA=EX2G N MEAN STD STDERR MAXDEC=2 ;
   VAR X Y Z;
RUN;

DATA EX2H;
   INFILE DATALINES MISSOVER; 
   INPUT X Y Z;
DATALINES;
1 2 3
4 5
6 7 8
;
PROC MEANS DATA=EX2H;
 etc.

DATA EX3A;
   ***This program reads a raw data file, creates a new 
      variable, and writes the new data set to another file;
   INFILE 'C:MYDATA';   ***Input file;
   FILE 'A:NEWDATA';    ***Output file;
   INPUT GROUP $ X Y Z;
   TOTAL = SUM (OF X Y Z);
   PUT GROUP $ 1-10 @12 (X Y Z TOTAL)(5.);
RUN;

***Data file MYDATA;
CONTROL       12   17   19   48
TREAT         23   25   29   77
CONTROL       19   18   16   53
TREAT         22   22   29   73

*-----------------------------------------------------------*
| This program reads data following the datalines statement |
| and creates a permanent SAS data set in a subdirectory    |
| called  C:\SASDATA                                        |
*-----------------------------------------------------------*;
LIBNAME FELIX 'C:\SASDATA';

DATA FELIX.EX4A;
   INPUT GROUP $ X Y Z;
DATALINES;
CONTROL 12 17 19
TREAT 23 25 29
CONTROL 19 18 16
TREAT 22 22 29
;

LIBNAME ABC 'C:\SASDATA';

PROC MEANS DATA=ABC.EX4A N MEAN STD STDERR MAXDEC=3;
   VAR X Y Z;
RUN;

//GROUCH JOB (1234567,BIN),'OSCAR THE'
//   EXEC SAS
//SAS.ABC DD DSN=OLS.A123.S456.CODY,DISP=SHR
//SAS.SYSIN DD *
PROC MEANS DATA=ABC.EX4A N MEAN STD STDERR MAXDEC=3;
   VAR X Y Z;
/*
//

LIBNAME SUGI 'C:\SASDATA';
PROC CONTENTS DATA=SUGI.EX4A POSITION;
RUN;

LIBNAME FELIX 'C:\SASDATA';
OPTIONS FMTSEARCH=(FELIX);
***We will place the permanent SAS data sets and the
   formats in C:\SASDATA;
PROC FORMAT LIBRARY=FELIX;
   VALUE $XGROUP 'TREAT'='TREATMENT GRP' 
                 'CONTROL'='CONTROL GRP';
RUN;

DATA FELIX.EX4A;
   INPUT GROUP $ X Y Z;
   FORMAT GROUP $XGROUP.;
DATALINES;
CONTROL 12 17 19
TREAT 23 25 29
CONTROL 19 18 16
TREAT 22 22 29
;
     
LIBNAME C 'C:\SASDATA';
OPTIONS FMTSEARCH=(C);
***Tell the program to look in C:\SASDATA for user
   defined formats;
PROC PRINT DATA=C.EX4A;
RUN;

Inefficient Way:

LIBNAME INDATA 'C:\MYDATA';
DATA TEMP;
   SET INDATA.STATS;
RUN;

PROC PRINT;
   VAR X Y Z;
RUN;

Efficient Way;

LIBNAME INDATA 'C:\MYDATA';
PROC PRINT DATA=INDATA.STATS;
   VAR X Y Z;
RUN;

Inefficient Way: (If all you want is the quiz average)

DATA QUIZ;
   INPUT @1 (QUIZ1-QUIZ10)(3.);
   QUIZAVE = MEAN (OF QUIZ1-QUIZ10);
DATALINES;

Efficient Way:

DATA QUIZ;
   INPUT @1 (QUIZ1-QUIZ10)(3.);
   QUIZAVE = MEAN (OF QUIZ1-QUIZ10);
   DROP (QUIZ1-QUIZ10);
DATALINES;

Inefficient Way:

DATA NEW;
   SET OLD;
DROP X1-X20 A B;
etc.

Efficient Way:

DATA NEW;
   SET OLD(DROP=X1-X20 A B);
etc.

Inefficient Way:

PROC SORT DATA=MYDATA;
   BY DAY;
RUN;
etc.
PROC SORT DATA=MYDATA;
   BY DAY HOUR;
RUN;
etc.

Efficient Way:

PROC SORT DATA=MYDATA;
   BY DAY HOUR;
RUN;
etc.

Inefficient Way:

PROC SORT DATA=MYDATA;
   BY DAY;
RUN;

PROC MEANS DATA=MYDATA N MEAN NWAY;
   BY DAY;
   VAR ... ;
RUN;


Efficient Way:

PROC MEANS DATA=MYDATA N MEAN NWAY;
   CLASS DAY;
   VAR ... ;
RUN;

Inefficient Way:

DATA ALPHA;
   SET BETA;
   IF X GE 20;
RUN;

Efficient Way:

DATA ALPHA;
   SET BETA;
   WHERE X GE 20;
RUN;

or

DATA ALPHA;
   SET BETA(WHERE=(X GE 20));
RUN;
     
Inefficient Way:

DATA TEMP DATA=MYDATA;
   SET OLD;
   WHERE AGE GE 65;
RUN; 

PROC MEANS DATA=MYDATA N MEAN STD;
   VAR ... ;
RUN;

Efficient Way:

PROC MEANS DATA=MYDATA N MEAN STD;
   WHERE AGE GE 65;
   VAR ... ;
RUN;

or

PROC MEANS DATA=MYDATA(WHERE=(AGE GE 65)) N MEAN STD;
   VAR ... ;
RUN;

Inefficient Way:

DATA SURVY;
   INPUT ID AGE HEIGHT WEIGHT;
   IF 0 LE AGE LT 20 THEN AGEGRP=1;
   IF 20 LE AGE LT 30 THEN AGEGRP=2;
   IF 30 LE AGE LT 40 THEN AGEGRP=3;
   IF AGE GE 40 THEN AGEGRP=4;
RUN;

Efficient Way:

DATA SURVY;
   INPUT ID AGE HEIGHT WEIGHT;
   IF 0 LE AGE LT 20 THEN AGEGRP=1;
   ELSE IF 20 LE AGE LT 30 THEN AGEGRP=2;
   ELSE IF 30 LE AGE LT 40 THEN AGEGRP=3;
   ELSE IF AGE GE 40 THEN AGEGRP=4;
RUN;
 
Inefficient Way: (Most of the subjects are over 65)

DATA SURVEY;
   SET OLD;
   IF 0 LE AGE LT 20 THEN AGEGRP=1;
   ELSE IF 20 LE AGE LT 30 THEN AGEGRP=2;
   ELSE IF 30 LE AGE LT 40 THEN AGEGRP=3;
   ELSE IF AGE GE 40 THEN AGEGRP=4;
RUN;

Efficient Way: (Most of the subjects are over 65)

DATA SURVEY;
   SET OLD;
   IF AGE GE 40 THEN AGEGRP=4;
   ELSE IF 30 LE AGE LT 40 THEN AGEGRP=3;
   ELSE IF 20 LE AGE LT 30 THEN AGEGRP=2;
   ELSE IF 0 LE AGE LT 20 THEN AGEGRP=1;
RUN;

Inefficient Way:

LIBNAME C 'C:\MYDATA';
PROC MEANS DATA=C.INDATA;
   CLASS RACE GENDER;
   VAR ... ;
RUN;

Efficient Way:

LIBNAME C 'C:\MYDATA';
PROC MEANS DATA=C.INDATA NWAY;
   CLASS RACE GENDER;
   VAR ... ;
   OUTPUT OUT=C.SUMMARY MEAN= ;
RUN;

Inefficient Way:

DATA TEMP;
   SET OLD;
   FILE 'ERRORS';
   IF AGE GT 110 THEN PUT ID= AGE= ;
RUN;

Efficient Way:

DATA _NULL_;
   SET OLD;
   FILE 'ERRORS';
   IF AGE GT 110 THEN PUT ID= AGE= ;
RUN;

Inefficient Way:

DATA COMBINE;
   SET BIGFILE NEWFILE;
RUN;

Efficient Way:

PROC APPEND BASE=BIGFILE DATA=NEWFILE;
RUN;

***Data for problem 13-1;
1 56  64 130  80
2 44  72 180      Note: No DBP recorded for
3 64  78 140  88  this ID (short record)

***Data for problem 13-5;
***DATA step to create MILTON;
DATA MILTON;
   INPUT X Y A B C Z;
DATALINES;
1 2 3 4 5 6
11 22 33 44 55 66
;

***Chapter 14 programs and data;
DATA WOMEN;
   SET ALL;
   IF GENDER = 'F';
RUN;

DATA OLDWOMEN;
   SET ALL;
   IF GENDER = 'F' AND AGE > 65;
RUN;

PROC FREQ DATA=ALL;
   WHERE GENDER = 'F';
   TABLES RACE INCOME;
RUN;

PROC TTEST DATA=data_set_name;
   WHERE GROUP='A' OR GROUP='B';
   CLASS GROUP;
   VAR ...;
RUN;

DATA ALLDATA;
  SET MEN WOMEN;
RUN;

   SS       NAME
-------------------
123-45-6789 CODY
987-65-4321 SMITH
111-22-3333 GREGORY         Master Data
222-33-4444 HAMER
777-66-5555 CHAMBLISS

    SS      SCORE
-------------------
123-45-6789 100
987-65-4321 67              Test Data
222-33-4444 92

ROC SORT DATA=MASTER;
   BY SS;
RUN;

PROC SORT DATA=TEST;
   BY SS;
RUN;
DATA BOTH;
   MERGE MASTER TEST;
      BY SS;
   FORMAT SS SSN11.;
RUN;

DATA BOTH;
   MERGE MASTER TEST (IN=FRODO);
      BY SS;
   IF FRODO;
   FORMAT SS SSN11.;
RUN;

DATA BOTH;
   MERGE MASTER (IN=BILBO) TEST (IN=FRODO);
      BY SS;
   IF BILBO AND FRODO;
   FORMAT SS SSN11.;
RUN;

D Year  WBC
-------------
1 1940 6000
2 1940 8000
3 1940 9000       Data set WORKER
1 1941 6500
2 1941 8500
3 1941 8900

Year Exposure
-------------
1940 200
1941 150          Data set EXP
1942 100
1943 80

PROC SORT DATA=WORKER;
   BY YEAR;
RUN;

PROC SORT DATA=EXP;
   BY YEAR;
RUN;

DATA COMBINE;
   MERGE WORKER (IN=INWORK) EXP;
      BY YEAR;
   IF INWORK;
RUN;

Year   Work     Exposure
--------------------------
1940   MIXER      190
1940   SPREADER   200
1941   MIXER      140
1941   SPREADER   150          Data set EXP
1942   MIXER       90
1942   SPREADER   100
1943   MIXER       70
1943   SPREADER    80

D  Year  Work      WBC
---------------------------
1  1940  MIXER    6000
2  1940  SPREADER 8000
3  1940  MIXER    9000         Data set WORKER
1  1941  MIXER    6500
2  1941  MIXER    8500
3  1941  SPREADER 8900

PROC SORT DATA=WORKER;
   BY YEAR WORK;
RUN;

PROC SORT DATA=EXP;
   BY YEAR WORK;
RUN;

DATA COMBINE;
   MERGE WORKER (IN=INWORK) EXP;
      BY YEAR WORK;
   IF INWORK;
RUN;

PART_NO  Price
---------------
   1      19
   4      23             MASTER data set
   6      22
   7      45   

ART_NO  Price
---------------
   4      24             UPDATE data set
   5      37
   7       .

DATA NEWMASTR;
   UPDATE MASTER UPDATE;
      BY PART_NO;
RUN;

***Data for problem 14-1;
ID   Gender  Age   Vault   Floor   P_BAR 
----------------------------------------
 3      M     8     7.5      7.2    6.5
 5      F    14     7.9      8.2    6.8
 2      F    10     5.6      5.7    5.8
 7      M     9     5.4      5.9    6.1
 6      F    15     8.2      8.2    7.9
        
***Data for problem 14-2;
File for 1996 (DATA96)        File for 1997 (DATA97)
----------------------        ----------------------
ID   Height   Weight          ID   Height   Weight
 2     68       155            7     72       202
 1     63       102            5     78       220
 4     61       111            3     66       105

***Data for problem 14-4;
ID    Income     L_NAME
-----------------------
 3       A       Klein
 7       B       Cesar
 8       A       Solanchick
 1       B       Warlock
 5       A       Cassidy
 2       B       Volick
      
***Data for problem 14-5;
Income Range   Gender   Financial Plan
--------------------------------------
      A           M          W
      A           F          X
      B           M          Y
      B           F          Z

***Chapter 15 programs and data;
*-------------------------------------------------------------*
| Example 1: Converting 999 to missing without using an array |
*-------------------------------------------------------------*;
DATA MISSING;
   SET OLD;
   IF A = 999 THEN A = .;
   IF B = 999 THEN B = .;
   IF C = 999 THEN C = .;
   IF D = 999 THEN D = .;
   IF E = 999 THEN E = .;
RUN;

*------------------------------------------------------*
| Example 1: Converting 999 to missing using an array  |
*------------------------------------------------------*;
DATA MISSING;
   SET OLD;
   ARRAY X[5] A B C D E;

   DO I = 1 TO 5;
      IF X[I] = 999 THEN X[I] = .;
   END;

   DROP I;
RUN;

*-----------------------------------------------------------*
| Example 2: Converting 999 to Missing for all numeric vars |
*-----------------------------------------------------------*;
DATA ALLNUMS;
   SET ALL;
   ARRAY PRESTON[*] _NUMERIC_ ;

   DO I = 1 TO DIM(PRESTON);
      IF PRESTON[I] = 999 THEN
         PRESTON[I] = .;
   END;

   DROP I;
RUN;

*-----------------------------------------------------------*
| Example 3: Converting 'N/A' to Missing for character vars |
*-----------------------------------------------------------*;
DATA NOTAPPLY;
   SET OLD;
   IF S1 = 'N/A' THEN S1 = ' ';
   IF S2 = 'N/A' THEN S2 = ' ';
   IF S3 = 'N/A' THEN S3 = ' ';
   IF X  = 'N/A' THEN X  = ' ';
   IF Y  = 'N/A' THEN Y  = ' ';
   IF Z  = 'N/A' THEN Z  = ' ';
RUN;

*-----------------------------------------------------------*
| Example 3: Converting 'N/A' to Missing for character vars |
*-----------------------------------------------------------*;
DATA NOTAPPLY;
   SET OLD;
   ARRAY RUSSELL[*] $ S1-S3 X Y Z;

   DO J = 1 TO DIM(RUSSELL);
      IF RUSSELL[J] = 'N/A' THEN
         RUSSELL[J] = ' ';
   END;

   DROP J;
RUN;

*---------------------------------------------------*
| Example 4: Metric conversion without using arrays |
*---------------------------------------------------*;
DATA CONVERT;
   INPUT HT1-HT3 WT1-WT5;
   HTCM1 = 2.54 * HT1;
   HTCM2 = 2.54 * HT2;
   HTCM3 = 2.54 * HT3;
   WTKG1 = WT1 / 2.2;
   WTKG2 = WT2 / 2.2;
   WTKG3 = WT3 / 2.2;
   WTKG4 = WT4 / 2.2;
   WTKG5 = WT5 / 2.2;
DATALINES;
(data goes here)
RUN;

*-------------------------------------------*
| Example 4: Metric conversion using arrays |
*-------------------------------------------*;
DATA CONVERT;
   ARRAY HT[3];
   ARRAY HTCM[3];
   ARRAY WT[5];
   ARRAY WTKG[5];
   *** Yes, we know the variable 
       names are missing, read on;

   DO I = 1 TO 5;
      IF I LE 3 THEN 
         HTCM[I] = 2.54 * HT[I];
      WTKG[I] = WT[I] / 2.2;
   END;

DATALINES;
(data goes here)
RUN;

*-------------------------------------------------------------*
| Example 5: Using a temporary array to determine the number  |
|   of tests passed                                           |
*-------------------------------------------------------------*;
DATA PASSING;

   ARRAY PASS[5] _TEMPORARY_ (65 70 65 80 75);
   ARRAY SCORE[5];

   INPUT ID $ SCORE[*];
   PASS_NUM = 0;

   DO I = 1 TO 5;
      IF SCORE[I] GE PASS[I] THEN
         PASS_NUM + 1;
   END;

   DROP I;
DATALINES;
001 64 69 68 82 74
002 80 80 80 60 80
;
PROC PRINT DATA=PASSING;
   TITLE 'Passing Data Set';
   ID ID;
   VAR PASS_NUM SCORE1-SCORE5;
RUN;

*----------------------------------------------------*
| Example 6: Using a temporary array to score a test |
*----------------------------------------------------*;
DATA SCORE;

   ARRAY KEY[10] $ 1 _TEMPORARY_;
   ARRAY ANS[10] $ 1;
   ARRAY SCORE[10] _TEMPORARY_;

   IF _N_ = 1 THEN 
      DO I = 1 TO 10;
         INPUT KEY[I] @;
      END;

   INPUT ID $ @5(ANS1-ANS10)($1.);
   RAWSCORE = 0;

   DO I = 1 TO 10;
      SCORE[I]=ANS[I] EQ KEY[I];
      RAWSCORE + SCORE[I];
   END;

   PERCENT = 100*RAWSCORE/10;
   DROP I;
DATALINES;
A B C D E E D C B A
001 ABCDEABCDE
002 AAAAABBBBB
;
PROC PRINT;
   TITLE 'SCORE Data Set';
   ID ID;
   VAR RAWSCORE PERCENT;
RUN;

*------------------------------------------------*
| Example 8: Converting plain text to morse code |
*------------------------------------------------*;
DATA _NULL_;
   FILE PRINT;
   ARRAY M[65:90] $ 4 _TEMPORARY_

  ('.-' '-...' '-.-.' '-..' '.'   
   '..-.' '--.' '....' '..' '.---'
   '-.-' '.-..' '--' '-.' '---' 
   '.--.' '--.-' '.-.' '...' '-'
   '..-' '...-' '.--' '-..-' '-.--'
   '--..');

   INPUT LETTER $1. @@;
   LETTER = UPCASE(LETTER);

   IF LETTER EQ ' ' THEN DO;
      PUT ' ' @;
      RETURN;
   END;

   MORSE = M[RANK(LETTER)];
   PUT MORSE @;
DATALINES;
This is a test
;

*---------------------------------------------------*
| Example 9: demonstrating the older implicit array |
*---------------------------------------------------*;
DATA OLDARRAY;
   ARRAY MOZART(I) A B C D E;
   INPUT A B C D E;
   DO I = 1 TO 5;
      IF MOZART = 999 THEN
         MOZART = .;
   END;
DROP I;
DATALINES;
(data lines)
;

*----------------------------------------------------*
| Example 10: Demonstrating the Older Implicit ARRAY |
*----------------------------------------------------*;
DATA OLDARRAY;
   ARRAY MOZART A B C D E;
   INPUT A B C D E;
   DO OVER MOZART;
      IF MOZART = 999 THEN
         MOZART = .;
   END;
DATALINES;
(data lines)
;

***Data for problem 15-1;
DATA PROB15_1;
   INPUT (HT1-HT5)(2.) (WT1-WT5)(3.);
   DENS1 = WT1 / HT1**2;
   DENS2 = WT2 / HT2**2;
   DENS3 = WT3 / HT3**2;
   DENS4 = WT4 / HT4**2;
   DENS5 = WT5 / HT5**2;
DATALINES;
6862727074150090208230240
64  68  70140   150   170
;

***Data for problem 15-2;
DATA OLDMISS;
   INPUT A B C X1-X3 Y1-Y3;
   IF A=999 THEN A=.;
   IF B=999 THEN B=.;
   IF C=999 THEN C=.;
   IF X1=999 THEN X1=.;
   IF X2=999 THEN X2=.;
   IF X3=999 THEN X3=.;
   IF Y1=777 THEN Y1=.;
   IF Y2=777 THEN Y2=.;
   IF Y3=777 THEN Y3=.;
DATALINES;
1 2 3 4 5 6 7 8 9
999 4 999 999 5 999 777 7 7
;

***Data for problem 15-3;
***Program to create the data set SPEED;
DATA SPEED;
   INPUT X1-X5 Y1-Y3;
DATALINES;
1 2 3 4 5 6 7 8 
11 22 33 44 55 66 77 88
;

***Data for problem 15-4;
DATA PROB15_4;
   LENGTH C1-C5 $ 2;
   INPUT C1-C5 $ X1-X5 Y1-Y5;
   IF C1 = 'NA' THEN C1 = ' ';
   IF C2 = 'NA' THEN C2 = ' ';
   IF C3 = 'NA' THEN C3 = ' ';
   IF C4 = 'NA' THEN C4 = ' ';
   IF C5 = 'NA' THEN C5 = ' ';
   IF X1 = 999 OR Y1 = 999 THEN DO;
      X1 = .; Y1 = .;
   END;
   IF X2 = 999 OR Y2 = 999 THEN DO;
      X2 = .; Y2 = .;
   END;
   IF X3 = 999 OR Y3 = 999 THEN DO;
      X3 = .; Y3 = .;
   END;
   IF X4 = 999 OR Y4 = 999 THEN DO;
      X4 = .; Y4 = .;
   END;
   IF X5 = 999 OR Y5 = 999 THEN DO;
      X5 = .; Y5 = .;
   END;
DATALINES;
AA BB CC DD EE 1 2 3 4 5 6 7 8 9 10
NA XX NA YY NA 999 2 3 4 999 999 4 5 6 7
;

***Chapter 16 programs and data;
    Data set DIAGNOSE

ID     DX1     DX2     DX3
--------------------------
01      3      4
02      1      2      3
03      4      5
04      7

*-----------------------------------------------------------*
| Example 1A: Creating multiple observations from a single  |
|    observation without using an  array                    |
*-----------------------------------------------------------*;
DATA NEW_DX;
   SET DIAGNOSE;
   DX = DX1;
   IF DX NE . THEN OUTPUT;
   DX = DX2;
   IF DX NE . THEN OUTPUT;
   DX = DX3;
   IF DX NE . THEN OUTPUT;
   KEEP ID DX;
RUN;

*----------------------------------------------------------*
| Example 1B: Creating multiple observations from a single |
|    observation using an array                            |
*----------------------------------------------------------*;
DATA NEW_DX;
   SET DIAGNOSE;
   ARRAY DXARRAY[3] DX1 - DX3;

   DO I = 1 TO 3;
      DX = DXARRAY[I];
      IF DX NE . THEN OUTPUT;
   END;

   KEEP ID DX;
RUN;

PROC FREQ DATA=NEW_DX;
   TABLES DX / NOCUM;
RUN;

    Data Set ONEPER
 ID     S1     S2     S3
-----------------------
01      3      4      5
02      7      8      9
03      6      5      4

*----------------------------------------------------------*
| Example 2:  Creating multiple observations from a single |
|    observation using an array                            |
*----------------------------------------------------------*;
DATA MANYPER;
   SET ONEPER;
   ARRAY S[3];

   DO TIME = 1 TO 3;
      SCORE = S[TIME];
      OUTPUT;
   END;

   KEEP ID TIME SCORE;
RUN;

        Data Set WT_ONE

ID   WT1  WT2  WT3  WT4  WT5  WT6
---------------------------------
01   155  158  162  149  148  147
02   110  112  114  107  108  109

*-----------------------------------------------------------*
| Example 3: Using a multi-dimensional array to restructure | 
|    a data set                                             |
*-----------------------------------------------------------*;
DATA WT_MANY;
   SET WT_ONE;

   ARRAY WTS [2,3] WT1-WT6;

   DO COND = 1 TO 2;
      DO TIME = 1 TO 3;
         WEIGHT = WTS[COND,TIME];
         OUTPUT;
      END;
   END;

   DROP WT1-WT6;

RUN;

*-----------------------------------------------------------*
| Example 4A: Creating a data set with one observation per  |
|    subject from a data set with multiple observations per |
|    subject. (Caution: This program will not work if there |
|    are any missing time values.)                          |
*-----------------------------------------------------------*;
PROC SORT DATA=MANYPER;
   BY ID TIME;
RUN;

DATA ONEPER;
   ARRAY S[3] S1-S3;
   RETAIN S1-S3;
   SET MANYPER;
   BY ID;
   S[TIME] = SCORE;
   IF LAST.ID THEN OUTPUT;
   KEEP ID S1-S3;
RUN;

  Data set MANYPER2

ID     Time     Score
---------------------
01       1       3
01       2       4
01       3       5
02       1       7
02       3       9
03       1       6
03       2       5
03       3       4

*-----------------------------------------------------------*
| Example 4B: Creating a data set with one observation per  |
|    subject from a data set with multiple observations per |
|    subject (corrected version)                            |
*-----------------------------------------------------------*;
PROC SORT DATA=MANYPER2;
   BY ID TIME;
RUN;

DATA ONEPER;
   ARRAY S[3] S1-S3;
   RETAIN S1-S3;
   SET MANYPER2;
   BY ID;
   IF FIRST.ID THEN DO I = 1 TO  3;
      S[I] = .;
      END;
   S[TIME] = SCORE;
   IF LAST.ID THEN OUTPUT;
   KEEP ID S1-S3;
RUN;

*------------------------------------------------------------*
| Example 5: Creating a data set with one observation per    |
|     subject from a data set with multiple observations per |
|     subject using a Multi-dimensional array                |
*------------------------------------------------------------*;
PROC SORT DATA=WT_MANY;
   BY ID COND TIME;
RUN;

DATA WT_ONE;
   ARRAY WT[2,3] WT1-WT6;
   RETAIN WT1-WT6;
   SET WT_MANY;
   BY ID;
   IF FIRST.ID THEN
   DO I = 1 TO  2;
      DO J = 1 TO 3;
         WT[I,J] = .;
      END;
   END;
   WT[COND,TIME] = WEIGHT;
   IF LAST.ID THEN OUTPUT;
   KEEP ID WT1-WT6;
RUN;

PROC PRINT DATA=WT_ONE;
   TITLE 'WT_ONE Again';
RUN;

***Data for problem 16-1;
ID   X1   X2   X3   X4   X5   Y1   Y2   Y3   Y4   Y5
01    4    5    4    7    3    1    7    3    6    8
02    8    7    8    6    7    5    4    3    5    6
DATA FROG;
   INPUT ID X1-X5 Y1-Y5;
DATALINES;
01  4  5  4  7  3  1  7  3  6  8
02  8  7  8  6  7  5  4  3  5  6
;

***Data for problem 16-2;
ID  STATE1  STATE2  STATE3  STATE4  STATE5  
1     NY      NJ      PA      TX      GA
2     NJ      NY      CA      XX      XX
3     PA      XX      XX      XX      XX

DATA STATE;
   INFORMAT STATE1-STATE5 $ 2;
   INPUT ID STATE1-STATE5;
DATALINES;
1  NY   NJ   PA   TX   GA
2  NJ   NY   CA   XX   XX
3  PA   XX   XX   XX   XX
;   

***Data for problem 16-3;
DATA OLDFASH;
   SET BLAH;
   ARRAY JUNK(J) X1-X5 Y1-Y5 Z1-Z5;
   DO OVER JUNK;
      IF JUNK = 999 THEN JUNK=.;
      END;
   DROP J;
RUN;

***Chapter 17 programs and data;
DATA FUNC_EG;
   INPUT ID SEX $ LOS HEIGHT WEIGHT;
   LOGLOS = LOG(LOS);
DATALINES;
1 M 5 68 155
2 F 100 62 98
3 M 20 72 220
;

DATA EASYWAY;
   INPUT (X1-X100)(2.);
   IF N(OF X1-X100) GE 75 THEN 
      AVE = MEAN(OF X1-X100);
DATALINES;
(lines of data)
;

DATA SHUFFLE;
   INPUT NAME : $20.;
   X = RANUNI(0);
DATALINES;
CODY
SMITH
MARTIN
LAVERY
THAYER
;
PROC SORT DATA=SHUFFLE;
   BY X;
RUN;

PROC PRINT DATA=SHUFFLE;
   TITLE 'Names in Random Order';
   VAR NAME;
RUN;                             
     
DATA DATES;
   INPUT ID 1-3 MONTH 4-5 DAY 10-11 YEAR 79-80;
   DATE = MDY(MONTH,DAY,YEAR);
   DROP MONTH DAY YEAR;
   FORMAT DATE MMDDYY8.;
DATALINES;
(data lines)
;

PROC FORMAT;
   VALUE DAYWK 1='SUN' 2='MON' 3='TUE' 4='WED' 5='THU'
               6='FRI' 7='SAT';
   VALUE MONTH 1='JAN' 2='FEB' 3='MAR' 4='APR' 5='MAY' 6='JUN'
               7='JUL' 8='AUG' 9='SEP' 10='OCT' 11='NOV' 12='DEC';
RUN;

DATA HOSP;
   INPUT @1 ADMIT MMDDYY6. etc. ;
   DAY = WEEKDAY(ADMIT);
   MONTH = MONTH(ADMIT);
   FORMAT ADMIT MMDDYY8. DAY DAYWK. MONTH MONTH.;
DATALINES;
(data lines)
;
PROC CHART DATA=HOSP;
   VBAR DAY / DISCRETE;
   VBAR MONTH / DISCRETE;
RUN;                                                          

PROC FORMAT;
   VALUE AGEGRP LOW-20='1' 21-40='2' 41-60='3' 61-HIGH='4';
RUN;

DATA PUTEG;
   INPUT AGE @@;
   AGE4 = PUT (AGE,AGEGRP.);
DATALINES;
5 10 15 20 25 30 66 68 99
;
     
DATA FREEFORM;
   INPUT TEST $ @@;
   RETAIN GROUP;
   IF TEST = 'A' OR TEST='B' THEN DO;
      GROUP = TEST;
      DELETE;
      RETURN;
   END;
   ELSE SCORE = INPUT (TEST,5.);
   DROP TEST;
DATALINES;
A 45 55 B 87 A 44 23 B 88 99
;
PROC PRINT DATA=FREEFORM;
   TITLE 'Listing of Data Set FREEFORM';
RUN;

Data set ORIG looks like this:

SUBJ   TIME   X
-----------------
 1       1    4
 1       2    6
 2       1    7
 2       2    2
 etc.

DATA LAGEG;
   SET ORIG;
   ***Note: Data Set ORIG is Sorted by SUBJ and TIME;
   DIFF = X - LAG(X);
   IF TIME=2 THEN OUTPUT;
RUN;     

***data for problem 17-1;
DATA HOSP;
   INFORMAT ID $3. GENDER $1. DOB DOS MMDDYY8.;
   INPUT ID GENDER DOB DOS LOS SBP DBP HP;
   FORMAT DOB DOS MMDDYY10.;
DATALINES;
1 M 10/21/46 3/17/97 3 130 90 68
2 F 11/1/55 3/1/97 5 120 70 72
3 M 6/6/90 1/1/97 100 102 64 88
4 F 12/21/20 2/12/97 10 180 110 86
;

***Data for problem 17-2;
DATA MANY;
   INPUT X1-X5 Y1-Y5;
DATALINES;
1 2 3 4 5   6 7 8 9 10
3 . 5 . 7   5 . . . 15
9 8 . . .   4 4 4 4 1
;

***Data for problem 17-5;
DATA MIXED;
   INPUT X Y A $ B $;
DATALINES;
1 2 3 4
5 6 7 8
;

***Chapter 18 programs and data;
DATA EXAMPLE1;
   INPUT GROUP $ @10 STRING $3.;
   LEFT  = 'X    '; *X AND 4 BLANKS;
   RIGHT = '    X'; *4 BLANKS AND X;
   C1 = SUBSTR(GROUP,1,2);
   C2 = REPEAT(GROUP,1);
   LGROUP = LENGTH(GROUP);
   LSTRING = LENGTH(STRING);
   LLEFT = LENGTH(LEFT);
   LRIGHT = LENGTH(RIGHT);
   LC1 = LENGTH(C1);
   LC2 = LENGTH(C2);
DATALINES;
ABCDEFGH 123
XXX        4
Y        5
;
PROC CONTENTS DATA=EXAMPLE1 POSITION;
   TITLE 'Output from PROC CONTENTS';
RUN;

PROC PRINT DATA=EXAMPLE1 NOOBS;
   TITLE 'Listing of Example 1';
RUN;

DATA EXAMPLE2;
   INPUT #1 @1  NAME    $20.
         #2 @1  ADDRESS $30.
         #3 @1  CITY    $15.
            @20 STATE    $2.
            @25 ZIP      $5.;
   NAME = COMPBL(NAME);
   ADDRESS = COMPBL(ADDRESS);
   CITY = COMPBL(CITY);
DATALINES;
RON CODY
89 LAZY BROOK ROAD
FLEMINGTON         NJ   08822
BILL     BROWN
28   CATHY   STREET
NORTH   CITY       NY   11518
;
PROC PRINT DATA=EXAMPLE2;
   TITLE 'Example 2';
   ID NAME;
   VAR ADDRESS CITY STATE ZIP;
RUN;

DATA EXAMPLE3;
   INPUT PHONE $ 1-15;
   PHONE1 = COMPRESS(PHONE);
   PHONE2 = COMPRESS(PHONE,'(-) ');
DATALINES;
(908)235-4490
(201) 555-77 99
;
PROC PRINT DATA=EXAMPLE3;
   TITLE 'Listing of Example 3';
RUN;

DATA EXAMPLE4;
   INPUT ID $ 1-4 ANSWER $ 5-9;
   P = VERIFY(ANSWER,'ABCDE');
   OK = P EQ 0;
DATALINES;
001 ACBED
002 ABXDE
003 12CCE
004 ABC E
;
PROC PRINT DATA=EXAMPLE4 NOOBS;
   TITLE 'Listing of Example 4';
RUN;

DATA EXAMPLE5;
   INPUT STRING $3.;
DATALINES;
ABC
EBX
aBC
VBD
;

DATA _NULL_;
   SET EXAMPLE5;
   FILE PRINT;
   CHECK = ' ABCDE';
   IF VERIFY(STRING,CHECK) NE 0 THEN
      PUT 'Error in Record ' _N_  STRING=;
RUN;

DATA EXAMPLE6;
   INPUT ID $ 1-9;
   LENGTH STATE $ 2;
   STATE = SUBSTR(ID,1,2);
   NUM = INPUT(SUBSTR(ID,7,3),3.);
DATALINES;
NYXXXX123
NJ1234567
;
PROC PRINT DATA=EXAMPLE6 NOOBS;
   TITLE 'LISTING OF EXAMPLE 6';
RUN;

DATA EXAMPLE7;
   INPUT SBP DBP @@;
   LENGTH SBP_CHK DBP_CHK $ 4;
   SBP_CHK = PUT(SBP,3.);
   DBP_CHK = PUT(DBP,3.);
   IF SBP GT 160 THEN SUBSTR(SBP_CHK,4,1) = '*';
   IF DBP GT 90  THEN SUBSTR(DBP_CHK,4,1) = '*';
DATALINES;
120 80 180 92 200 110
;
PROC PRINT DATA=EXAMPLE7 NOOBS;
   TITLE 'Listing of Example 7';
RUN;

DATA EXAMPLE8;
   INPUT SBP DBP @@;
   LENGTH SBP_CHK DBP_CHK $ 4;
   SBP_CHK = PUT(SBP,3.);
   DBP_CHK = PUT(DBP,3.);
   IF SBP GT 160 THEN SBP_CHK = SUBSTR(SBP_CHK,1,3) || '*';
   IF DBP GT  90 THEN DBP_CHK = TRIM(DBP_CHK) || '*';
DATALINES;
120 80 180 92 200 110
;
PROC PRINT DATA=EXAMPLE8 NOOBS;
   TITLE 'Listing of Example 8';
RUN;

DATA EXAMPLE9;
   INPUT STRING $ 1-5;
DATALINES;
12345
8 642
;
DATA UNPACK;
   SET EXAMPLE9;
   ARRAY X[5];
   DO J = 1 TO 5;
      X[J] = INPUT(SUBSTR(STRING,J,1),1.);
   END;
   DROP J;
RUN;

PROC PRINT DATA=UNPACK NOOBS;
   TITLE 'Listing of UNPACK';
RUN;

DATA EX_10; 
   INPUT LONG_STR $ 1-80;
   ARRAY PIECES[5] $ 10   
      PIECE1-PIECE5;
   DO I = 1 TO 5;
      PIECES[I] = SCAN(LONG_STR,I,',;.! ');
   END;
   DROP LONG_STR I;
DATALINES4;
THIS LINE,CONTAINS!FIVE.WORDS
ABCDEFGHIJKL XXX;YYY
;;;;
PROC PRINT DATA=EX_10 NOOBS;
   TITLE 'Listing of Example 10';
RUN;

DATA EX_11;
   INPUT STRING $ 1-10;
   FIRST = INDEX(STRING,'XYZ');
   FIRST_C = INDEXC(STRING,'X','Y','Z');
DATALINES;
ABCXYZ1234
1234567890
ABCX1Y2Z39
ABCZZZXYZ3
;
PROC PRINT DATA=EX_11 NOOBS;
   TITLE 'Listing of Example 11';
RUN;

DATA EX_12;
   LENGTH A B C D E $ 1;
   INPUT A B C D E X Y;
DATALINES;
M f P p D 1 2
m f m F M 3 4
;
DATA UPPER;
   SET EX_12;
   ARRAY ALL_C[*] _CHARACTER_;
   DO I = 1 TO DIM(ALL_C);
      ALL_C[I] = UPCASE(ALL_C[I]);
   END;
   DROP I;
RUN;

PROC PRINT DATA=UPPER NOOBS;
   TITLE 'Listing of UPPER';
RUN;

DATA EX_13;
   INPUT QUES : $1. @@;
   QUES = TRANSLATE(QUES,'ABCDE','12345');
DATALINES;
1 4 3 2 5
5 3 4 2 1
;
PROC PRINT DATA=EX_13 NOOBS;
   TITLE 'LISTING OF EXAMPLE 13';
RUN;

DATA EX_14;
   LENGTH CHAR $ 1;
   INPUT CHAR @@;
   X = INPUT(TRANSLATE(UPCASE(CHAR),'01','NY'),1.);
DATALINES;
N Y n y A B 0 1
;
PROC PRINT DATA=EX_14 NOOBS;
   TITLE 'Listing of Example 14';
RUN;

DATA CONVERT;
   INPUT @1 ADDRESS $20. ;
   *** Convert Street, Avenue, and Boulevard to
       their abbreviations;
   ADDRESS = TRANWRD (ADDRESS,'Street','St.');
   ADDRESS = TRANWRD (ADDRESS,'Avenue','Ave.');
   ADDRESS = TRANWRD (ADDRESS,'Road','Rd.');
DATALINES;
89 Lazy Brook Road 
123 River Rd.
12 Main Street
;
PROC PRINT DATA=CONVERT;
   TITLE 'Listing of Data Set CONVERT';
RUN;

DATA EX_15;
   INPUT PART1 $ 1-3 PART2 $ 5-6 PART3 $ 8-11;
   SS = PART1 || '-' || PART2 || '-' || PART3; 
   KEEP SS;
DATALINES;
123:45:6789                                 
;
PROC PRINT DATA=EX_15;
   TITLE 'Listing of Data Set EX_15';
RUN;

DATA EX_16;
   LENGTH NAME1-NAME3 $ 10;
   INPUT NAME1-NAME3;
   S1 = SOUNDEX(NAME1);
   S2 = SOUNDEX(NAME2);
   S3 = SOUNDEX(NAME3);
DATALINES;
cody Kody cadi
cline klein clana
smith smythE adams
;
PROC PRINT DATA=EX_16 NOOBS;
   TITLE 'Listing of Example 16';
RUN;

***Data for problem 18-1;
DATA CHAR1;
   INPUT STRING1 $1.
         STRING2 $5.
         STRING3 $8.
         (C1-C5)($1.);
DATALINES;
XABCDE12345678YNYNY
YBBBBB12V56876yn YY
ZCCKCC123-/. ,WYNYN
;

***Data for problem 18-4;
DATA PHONE;
   INPUT CHAR_NUM $20.;
DATALINES;
(908)235-4490
(800) 555 - 1 2 1 2
203/222-4444
;
     
***Data for problem 18-5;
DATA EXPER;
   INPUT ID    $ 1-5
         GROUP $ 7
         DOSE  $ 9-12;
DATALINES;
1NY23 A HIGH
3NJ99 B HIGH
2NY89 A LOW
5NJ23 B LOW
;

***Data for problem 18-7;
DATA ONE;
   INPUT @1  GENDER  $1.
         @2  DOB     MMDDYY8.
         @10 NAME    $11.
         @21 STATUS  $1.;
   FORMAT DOB MMDDYY8.;
DATALINES;
M10/21/46CADY       A
F11/11/50CLINE      B
M11/11/52SMITH      A
F10/10/80OPPENHEIMERB
M04/04/60JOSE       A
;
DATA TWO;
   INPUT @1  GENDER  $1.
         @2  DOB     MMDDYY8.
         @10 NAME    $11.
         @21 WEIGHT  3.;
   FORMAT DOB MMDDYY8.;
DATALINES;
M10/21/46CODY       160
F11/11/50CLEIN      102
F11/11/52SMITH      101
F10/10/80OPPENHAIMER120
M02/07/60JOSA       220
;

***Chapter 19 programs and data;
DATA TEST;
   INPUT HR SBP DBP;
DATALINES;
80 160 100
70 150 90
60 140 80
;
PROC MEANS NOPRINT DATA=TEST;
   VAR HR SBP DBP;
   OUTPUT OUT=MOUT(DROP=_TYPE_ _FREQ_)
          MEAN=MHR MSBP MDBP;
RUN;

DATA NEW (DROP=MHR MSBP MDBP);
   SET TEST;
   IF _N_ = 1 THEN SET MOUT;
   HRPER=100*HR/MHR;
   SBPPER=100*SBP/MSBP;
   DBPPER=100*DBP/MDBP;
RUN;

PROC PRINT DATA=NEW NOOBS;
   TITLE 'Listing of Data Set NEW';
RUN;                                          

DATA TEST; 
   INPUT GROUP $ HR SBP DBP @@; 
DATALINES; 
A 80 160 100 A 70 150 90 A 60 140 80 
B 90 200 180 B 80 180 140 B 70 140 80 
; 
PROC SORT DATA=TEST; 
   BY GROUP;
RUN;

PROC MEANS DATA=TEST NOPRINT NWAY;
   CLASS GROUP;
   VAR HR SBP DBP;
   OUTPUT OUT=MOUT(DROP=_TYPE_ _FREQ_)
          MEAN=MHR MSBP MDBP;
RUN;

DATA NEW (DROP=MHR MSBP MDBP);
   MERGE TEST MOUT;
      BY GROUP;
   HRPER=100*HR/MHR;
   SBPPER=100*SBP/MSBP;
   DBPPER=100*DBP/MDBP;
RUN;

PROC PRINT NOOBS;
   TITLE 'Listing of Data Set NEW';
RUN;                                          

ATA ORIG;
  INPUT SUBJ TIME DBP SBP;
DATALINES;
1 1 70 120
1 2 80 130
1 3 84 136
2 1 82 132
2 2 84 138
2 3 92 144
;
PROC MEANS DATA=ORIG NOPRINT NWAY;
   CLASS TIME;
   VAR SBP DBP;
   OUTPUT OUT=MEANOUT MEAN= STDERR=SE_SBP SE_DBP;
RUN;

DATA TMP;
   SET MEANOUT;
   SBPHI=SBP+SE_SBP;
   SBPLO=SBP-SE_SBP;
   DBPHI=DBP+SE_DBP;
   DBPLO=DBP-SE_DBP;
RUN;

PROC PLOT DATA=TMP;
   PLOT SBP*TIME='o' SBPHI*TIME='-' SBPLO*TIME='-' / OVERLAY BOX;
   PLOT DBP*TIME='o' DBPHI*TIME='-' DBPLO*TIME='-' / OVERLAY BOX;
   TITLE 'Plot of Mean Blood Pressures at Each Time';
   TITLE2 'Error bars represent +- 1 standard error';
RUN;

DATA TEST;
   %LET LIST=ONE TWO THREE;
   INPUT &LIST FOUR;
DATALINES;
1 2 3 4
4 5 6 6
;
PROC FREQ DATA=TEST;
   TABLES &LIST;
RUN;                    

DATA ICD;
   INPUT ID YEAR ICD;
DATALINES;
001 1950 450
002 1950 440
003 1951 460
004 1950 450
005 1951 300
;
PROC FREQ DATA=ICD;
   TABLES YEAR*ICD / OUT=ICDFREQ NOPRINT;
   ***Data set ICDFREQ contains the counts 
   for each CODE in each YEAR;
RUN;

PROC FREQ DATA=ICD;
   TABLES YEAR / OUT=TOTAL NOPRINT;
   ***Data set ICD contains the total number 
   of obs for each YEAR;
RUN;

DATA RELATIVE;
   MERGE ICDFREQ TOTAL (RENAME=(COUNT=TOT_CNT));
   ***We need to rename COUNT in one of the two data sets
      so that we can have both values in data set RELATIVE;
   BY YEAR;
   RELATIVE=100*COUNT/TOT_CNT;
   DROP PERCENT;
RUN;

PROC PRINT DATA=RELATIVE;
   TITLE 'Relative Frequencies of ICD Codes by Year';
RUN;                                                                  

ICDFREQ data set

YEAR    ICD    COUNT    PERCENT

1950    440      1         20
1950    450      2         40
1951    300      1         20
1951    460      1         20

PROC FORMAT;
   VALUE SYMPTOM 1='ALCOHOL' 2='INK' 3='SULPHUR' 4='IRON' 5='TIN'
                 6='COPPER'  7='DDT' 8='CARBON' 9='SO2' 10='NO2';
RUN;

DATA SENSI;
   INPUT ID 1-4 (CHEM1-CHEM10)(1.);
   ARRAY CHEM[*] CHEM1-CHEM10;
   DO I=1 TO 10;
      IF CHEM[I]=1 THEN DO;
         SYMPTOM=I;
         OUTPUT;
      END;
   END;
   KEEP ID SYMPTOM;
   FORMAT SYMPTOM SYMPTOM.;
DATALINES;
00011010101010
00021000010000
00031100000000
00041001001111
00051000010010
;
PROC FREQ DATA=SENSI ORDER=FREQ;
   TABLES SYMPTOM;
RUN;                            

ID    Symptom
--------------
 1    ALCOHOL
 1    SULPHUR
 1    TIN
 1    DDT
 1    SO2
 2    ALCOHOL
 2    COPPER
 3    ALCOHOL
 3    INK
 4    ALCOHOL
 4    IRON
 4    DDT
 4    CARBON
 4    SO2
 4    NO2
 5    ALCOHOL
 5    COPPER
 5    SO2

*---------------------------------------*
| Program to compute a moving average   |
*---------------------------------------*;
DATA MOVING;
   INPUT COST @@;
   DAY+1;
   COST1=LAG(COST);
   COST2=LAG2(COST);
   IF _N_ GE 3 THEN MOV_AVE = MEAN (OF COST COST1 COST2);
   DROP COST1 COST2;
DATALINES;
1 2 3 4 . 6 8 12 8
;
PROC PRINT DATA=MOVING NOOBS;
   TITLE 'Listing of Data Set MOVING';
RUN;                                                   

DATA NEVER;
   INPUT X @@;
   IF X GT 3 THEN X_LAG = LAG(X);
DATALINES;
5 7 2 1 4
;

*---------------------------------------*
| Program to Sort within an Observation |
*---------------------------------------*;
DATA TEST;
   INPUT ID L1-L5;
DATALINES;
1 1 2 3 4 5
2 1 3 5 2 4
3 . 7 9 . .
;
DATA NEW;
   SET TEST;
   ARRAY L[5] L1-L5;
   LOOP: FLAG=0;   
   DO I=1 TO 4;  
      IF L[I+1] GT L[I] THEN DO;  
         HOLD=L[I];
         L[I]=L[I+1];
         L[I+1]=HOLD;
         FLAG=1;
      END;
   END;
   IF FLAG=1 THEN GO TO LOOP;
   DROP I FLAG HOLD;
RUN;

DATA NEW;
   SET TEST;
   ARRAY L[5] L1-L5;
   FLAG = 1;
   DO UNTIL (FLAG = 0);
      FLAG = 0;
      DO I = 1 TO 4;
         IF L[I+1] GT L[I] THEN DO;
            HOLD = L[I];
            L[I] = L[I+1];
            L[I+1] = HOLD;
            FLAG = 1;
         END;
      END;
   END;
   DROP I FLAG HOLD;
RUN;

*-------------------------------------------------------*
| Assume that data set SCORE (see Chapter 11) contains  |
| variables S1-S5 which are the scored responses for    |
| each of the 5 items on a test.   S=1 for a correct    |
| answer, S=0 for an incorrect response                 |
*-------------------------------------------------------*;
PROC MEANS NOPRINT DATA=SCORE;
   VAR S1-S5 RAW;
   OUTPUT OUT=VAROUT VAR=VS1-VS5 VRAW;
RUN;

DATA _NULL_;  
   FILE PRINT;  
   SET VAROUT;
   SUMVAR = SUM (OF VS1-VS5);  
   KR20 = (5/4)*(1-SUMVAR/VRAW);  
   PUT KR20= ;   
RUN;


