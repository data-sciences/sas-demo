/*--------------------------------------------------------------------------------------*/
 /*                 Step-by-Step Basic Statistics Using SAS:  Exercises                 */
 /*                                   by  Larry Hatcher                                 */
 /*               Copyright(c) 2003 by SAS Institute Inc., Cary, NC, USA                */
 /*                                 SAS Publications order # 57322                      */
 /*                                       ISBN 1-59047-149-0                            */
 /*  	             This book sold individually and as part of a set.                    */
 /*-------------------------------------------------------------------------------------*/
 /*                                                                                     */
 /* This material is provided "as is" by SAS Institute Inc.  There                      */
 /* are no warranties, expressed or implied, as to merchantability or                   */
 /* fitness for a particular purpose regarding the materials or code                    */
 /* contained herein. The Institute is not responsible for errors                       */
 /* in this material as it now exists or will exist, nor does the                       */
 /* Institute provide technical support for it.                                         */
 /*                                                                                     */
 /*-------------------------------------------------------------------------------------*/
 /* Questions or problems concerning this material may be                               */
 /* addressed to the author:                                                            */
 /*                                                                                     */
 /* SAS Institute Inc.                                                                  */
 /* Books by Users                                                                      */
 /* Attn: Larry Hatcher                                                                 */
 /* SAS Campus Drive                                                                    */
 /* Cary, NC   27513                                                                    */
 /*                                                                                     */
 /*                                                                                     */
 /* If you prefer, you can send email to:  sasbbu@sas.com                               */
 /* Use this for subject field:                                                         */
 /* 	Comments for Larry Hatcher                                                         */
 /*                                                                                     */
 /*-------------------------------------------------------------------------------------*/
 /* Date Last Updated:  25JUN03                                                         */
 /*-------------------------------------------------------------------------------------*/


/* Exercise 3.1: Computing Mean Height, Weight, and Age 

OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT  SUB_NUM
          HEIGHT
          WEIGHT
          AGE ;
DATALINES;
1 64 140 20
2 68 170 28
3 74 210 20
4 60 110 32
5 64 130 22
6 68 170 23
7 65 140 22
8 65 140 22
9 68 160 22
;
PROC MEANS DATA=D1;
   VAR  HEIGHT  WEIGHT  AGE;
   TITLE1 'JANE DOE';
RUN;



/* Exercise 3.2: Computing Mean Age, IQ, and Income

OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT  AGE
          IQ
          INCOME;
DATALINES;
36 110 25000
28 105 29000
55  99 58000
44 102 45000
46 108 51000
39  90 46000
29 100 31000
40  92 43000
32 105 31000
;
PROC MEANS DATA=D1;
VAR  AGE  IQ  INCOME;
TITLE1 ' type your name here ';
RUN;



/* Exercise 4.1: Creating and Analyzing a Data/
/* Set Containing LAT Test Scores
 
OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT   SUB_NUM
           LAT_V
           LAT_M
           SEX  $
           TEST_1
           TEST_2
           TEST_3 ;
DATALINES;
01 510 520 F 89 92 92
02 530   . M 88 75 89
03 620 600 F 95 90 88
04   . 490 F 80  . 78
05 650 600 M 97 95 96
06 550 510 F 76 70 78
07 420 480 . 88 81 85
08 400 410 M 90 88 88
09 590 610 F 90 92 95
;
PROC MEANS DATA=D1;
   VAR  LAT_V  LAT_M  TEST_1  TEST_2  TEST_3;
   TITLE1 'JOHN DOE';
RUN;
PROC FREQ DATA=D1;
   TABLES SEX;
RUN;
PROC PRINT DATA=D1;
RUN;



/* Exercise 5.1: Using PROC FREQ to Analyze LAT Data 

OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT   SUB_NUM
           LAT_V
           LAT_M
           LAT_A
           MAJOR  $ ;
DATALINES;
01   540   540   540   A
02   510   560   550   A
03   500   520   530   A
04   490   550   530   A
05   520   510   510   A
06   520   500   530   A
07   510   470   520   E
08   530   490   520   B
09   500   460   480   B
10   490   480   500   E
11   510   470   470   B
12   500   450   490   E
13   500   460   540   E
14   480   440   490   B
15   490   430   460   B
16   480   450   480   E
17   470   440   470   E
18   460   450   480   B
;
PROC FREQ DATA=D1;
   TABLES  LAT_V;
   TITLE1 'JOHN DOE';
   RUN; 
 


/* Exercise 6.1:  Using PROC CHART to Create Bar Charts from LAT Data

OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT   SUB_NUM
           LAT_V
           LAT_M
           LAT_A
           MAJOR  $ ;
DATALINES;
01   540   540   540   A
02   510   560   550   A
03   500   520   530   A
04   490   550   530   A
05   520   510   510   A
06   520   500   530   A
07   510   470   520   E
08   530   490   520   B
09   500   460   480   B
10   490   480   500   E
11   510   470   470   B
12   500   450   490   E
13   500   460   540   E
14   480   440   490   B
15   490   430   460   B
16   480   450   480   E
17   470   440   470   E
18   460   450   480   B
;

PROC CHART  DATA=D1;
   VBAR  LAT_V  /  DISCRETE;
   TITLE1  'JOHN DOE';
RUN;

PROC CHART  DATA=D1;
   VBAR  MAJOR  /  SUMVAR=LAT_V  TYPE=MEAN;
   TITLE1  'JOHN DOE';
RUN; 



/* Exercise 7.1: Using PROC UNIVARIATE to Identify Normal, Skewed, and Bimodal
Distributions
	
OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT   SUB_NUM
           LAT_V
           LAT_M
           LAT_A
           MAJOR  $ ;
DATALINES;
01   540   540   540   A
02   510   560   550   A
03   500   520   530   A
04   490   550   530   A
05   520   510   510   A
06   520   500   530   A
07   510   470   520   E
08   530   490   520   B
09   500   460   480   B
10   490   480   500   E
11   510   470   470   B
12   500   450   490   E
13   500   460   540   E
14   480   440   490   B
15   490   430   460   B
16   480   450   480   E
17   470   440   470   E
18   460   450   480   B
;

PROC UNIVARIATE  DATA=D1  PLOT  NORMAL;
   VAR  LAT_V  LAT_M  LAT_A;
   TITLE1  'JOHN DOE';
RUN; 
 


/* Exercise 8.1: Working with an Academic Development Questionnaire 

OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT  SUB_NUM
          Q1
          Q2
          Q3
          Q4
          SEX  $
          AGE
          CLASS;
DATALINES;
01  6 . 2 7 F 20 1
02  3 2 7 2 M 26 1
03  7 7 1 7 M 19 1
04  5 6 . 5 F 23 2
05  6 7 1 6 M 21 2
06  3 2 6 3 F 25 2
07  5 6 2 5 F 25 3
08  5 6 1 5 F 23 3
09  7 7 1 6 M 31 3
10  5 4 1 4 M 25 4
11  4 5 3 5 F 42 4
12  7 6 1 6 F 38 4
;
PROC PRINT  DATA=D1;
   TITLE1  'JOHN DOE';
RUN;
DATA D2;
   SET D1;

   Q3 = 8 - Q3;

   DEVEL = (Q1 + Q2 + Q3 + Q4) / 4;

   AGE2 = .;
   IF AGE LT 30 THEN AGE2 = 0;
   ELSE IF AGE GE 30 THEN AGE2 = 1;

   CLASS2 = '  .';
   IF CLASS = 1 THEN CLASS2 = 'FRE';
   IF CLASS = 2 THEN CLASS2 = 'SOP';
   IF CLASS = 3 THEN CLASS2 = 'JUN';
   IF CLASS = 4 THEN CLASS2 = 'SEN';

PROC PRINT  DATA=D2;
RUN; 



/* Exercise 9.1: Satisfaction with Academic 
Development and the Social Environment Among College Students                                

OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT  SUB_NUM
          NAME  $
          ACADEM
          SOCIAL;
DATALINES;
01  Fred      25   34
02  Susan     16   30
03  Marsha     4   42
04  Charles   12   24
05  Paul      28   39
06  Cindy     15   29
07  Jack      21   27
08  Cathy      8   36
09  George    23   21
10  John       6   32
11  Marie     10   19
12  Emmett    19   33
;
PROC MEANS DATA=D1  VARDEF=N  N  MEAN  STD  MIN  MAX;
   VAR  ACADEM  SOCIAL;
   TITLE1  'JOHN DOE';
RUN;
DATA D2;
   SET D1;
   ACADEM_Z = (ACADEM - 15.58) / 7.45;
   SOCIAL_Z = (SOCIAL - 30.50) / 6.68;

PROC PRINT DATA=D2;
   VAR  NAME  ACADEM  SOCIAL  ACADEM_Z  SOCIAL_Z;
   TITLE 'JOHN DOE';
RUN;

PROC MEANS DATA=D2  VARDEF=N  N  MEAN  STD  MIN  MAX;
   VAR  ACADEM_Z  SOCIAL_Z;
   TITLE1  'JOHN DOE';
RUN;



/* Exercise 10.1: Correlational Study of Drinkingand Driving Behavior

OPTIONS  LS=80  PS=60 ;
DATA D1;
   INPUT  SUB_NUM
          MC_T1
          PC_T1
          DD_T1
          DD_T2;
DATALINES;
01  24  8 1 3
02  12 12 3 4
03   4  4 4 5
04  16 12 2 2
05  28  . 1 1
06   8 16 3 3
07  12  8 3 5
08   8  8 5 6
09  16 16 4 4
10  16 16 4 5
11  12 12 4 6
12  20 16 5 2
13  28 24 5 3
14  20 20 5 5
15  20 24 6 4
16  16 20 6 6
17  16 16 6 7
18   4 12 6 8
19  24 28 7 5
20  20 24 7 6
21   4 20 8 8
;

PROC PLOT  DATA=D1;
   PLOT  DD_T2*MC_T1;
   TITLE1 'JOHN DOE';
RUN;

PROC CORR  DATA=D1;
   VAR  MC_T1  PC_T1  DD_T1  DD_T2;
   TITLE1 'JOHN DOE';
RUN; 



/* Exercise 11.1: Predicting Current Drinking and Driving Behavior from Previous Behavior

OPTIONS  LS=80  PS=60 ;
DATA D1;
   INPUT  SUB_NUM
          MC_T1
          PC_T1
          DD_T1
          DD_T2;
DATALINES;
01  24  8 1 3
02  12 12 3 4
03   4  4 4 5
04  16 12 2 2
05  28  . 1 1
06   8 16 3 3
07  12  8 3 5
08   8  8 5 6
09  16 16 4 4
10  16 16 4 5
11  12 12 4 6
12  20 16 5 2
13  28 24 5 3
14  20 20 5 5
15  20 24 6 4
16  16 20 6 6
17  16 16 6 7
18   4 12 6 8
19  24 28 7 5
20  20 24 7 6
21   4 20 8 8
;

PROC PLOT  DATA=D1;
   PLOT  DD_T2*DD_T1;
   TITLE1 'JOHN DOE';
RUN;

PROC REG  DATA=D1;
   MODEL  DD_T2=DD_T1  /  STB  P;
   TITLE1 'JOHN DOE';
RUN; 



/* Exercise 12.1: Answering SAT Reading Comprehension Questions Without the Passages

OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT  SUB_NUM
          SCORE;
DATALINES;
01  49
02  46
03  51
04  53
05  55
06  50
07  43
08  53
09  49
10  51
11  49
12  47
13  57
14  51
15  47
16  45
17  45
;
PROC TTEST  DATA=D1  H0=20  ALPHA=0.05;
   VAR SCORE;
   TITLE1  'JANE DOE';
RUN; 



/* Exercise 13.1: Sex Differences in Sexual Jealousy

OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT  SUB_NUM
          SEX  $
          DISTRESS;
DATALINES;
01  M  22
02  M  25
03  M  23
04  M  24
05  M  20
06  M  28
07  M  27
08  M  23
09  M  23
10  M  24
11  M  26
12  M  26
13  M  25
14  M  21
15  M  22
16  M  23
17  M  24
18  M  25
19  F  22
20  F  22
21  F  25
22  F  18
23  F  23
24  F  24
25  F  19
26  F  20
27  F  20
28  F  20
29  F  21
30  F  21
31  F  21
32  F  19
33  F  19
34  F  22
35  F  23
36  F  21
;

PROC TTEST  DATA=D1  ALPHA=0.05;
   CLASS  SEX;
   VAR DISTRESS;
   TITLE1  'JANE DOE';
RUN; 



/* Exercise 14.1: Perceived Problem Seriousness as a Function of Time of Day

OPTIONS  LS=80  PS=60;
DATA D1  ;
   INPUT  SUB_NUM
          AFTNOON  
          MORNING;
DATALINES;
01  16  13
02  14  14
03  12   9
04  16  12
05  13  12
06  11  13
07  17  13
08  10  10
09  14  11
10  15  11
11  14   8
12  13  11
13  15  11
14  13   8
15  13  10
16  11  10
;
PROC MEANS  DATA=D1;
   VAR  AFTNOON  MORNING;
   TITLE1  'JOHN DOE';
RUN;

PROC TTEST  DATA=D1  H0=0  ALPHA=0.05;
   PAIRED  AFTNOON*MORNING;
RUN; 


 
/* Exercise 15.1: The Effect of Misleading Suggestions On the Creation of False Memories  

OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT  SUB_NUM
          NUM_EXP  $
          CONFID     ;
DATALINES;
01  0_EXP  1.00
02  0_EXP  1.25
03  0_EXP  2.00
04  0_EXP  1.75
05  0_EXP  2.75
06  0_EXP  3.25
07  0_EXP  4.50
08  2_EXP  2.75
09  2_EXP  3.00
10  2_EXP  4.00
11  2_EXP  5.50
12  2_EXP  5.50
13  2_EXP  6.25
14  2_EXP  6.75
15  4_EXP  4.75
16  4_EXP  3.00
17  4_EXP  4.75
18  4_EXP  5.75
19  4_EXP  7.00
20  4_EXP  6.00
21  4_EXP  3.00
;

PROC GLM  DATA=D1;
   CLASS  NUM_EXP;
   MODEL  CONFID = NUM_EXP;
   MEANS  NUM_EXP;
   MEANS  NUM_EXP / TUKEY  CLDIFF  ALPHA=0.05;
   TITLE1  'JOHN DOE';
RUN;
QUIT; 



/* Exercise 16.1: The Effects of Misleading Suggestions and Pre-Event Instructions on the 
Creation of False Memories

OPTIONS LS=80  PS=60;
DATA D1;
   INPUT  SUB_NUM
          INSTRUCT  $
          NUM_EXP   $
          CONFID      ;
DATALINES;
01  W  0_EXP 1.50
02  W  0_EXP 1.25
03  W  0_EXP 2.00
04  W  0_EXP 1.75
05  W  2_EXP 1.50
06  W  2_EXP 2.00
07  W  2_EXP 1.25
08  W  2_EXP 1.50
09  W  4_EXP 1.50
10  W  4_EXP 1.75
11  W  4_EXP 2.00
12  W  4_EXP 1.50
13  N  0_EXP 2.50
14  N  0_EXP 2.50
15  N  0_EXP 2.00
16  N  0_EXP 3.00
17  N  2_EXP 5.00
18  N  2_EXP 5.50
19  N  2_EXP 4.00
20  N  2_EXP 4.75
21  N  4_EXP 5.50
22  N  4_EXP 5.75
23  N  4_EXP 5.75
24  N  4_EXP 5.25
;

PROC GLM  DATA=D1;
   CLASS  INSTRUCT  NUM_EXP;
   MODEL  CONFID = INSTRUCT  NUM_EXP 
          INSTRUCT*NUM_EXP;
   MEANS  INSTRUCT  NUM_EXP  INSTRUCT*NUM_EXP;
   MEANS  INSTRUCT  NUM_EXP /  TUKEY  CLDIFF  
          ALPHA=0.05;
   TITLE1 'JANE DOE';
RUN;
QUIT; 



/* Exercise 17.1: The Relationship Between Sex of Children and Marital Disruption

OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT  STATUS    $
          SEX       $
          NUMBER;
DATALINES;
I  BB  34
I  BG  26
I  GG  15
S  BB  14
S  BG  22
S  GG  36
;
PROC FREQ  DATA=D1;
   TABLES  STATUS*SEX  /  ALL;
   WEIGHT  NUMBER;
   TITLE1 'JOHN DOE';
RUN;


 

