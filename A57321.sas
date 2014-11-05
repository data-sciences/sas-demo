 /*-------------------------------------------------------------------------------------*/
 /*               Step-by-Step Basic Statistics Using SAS: Student Guide                */
 /*                                  by  Larry Hatcher                                  */
 /*               Copyright(c) 2003 by SAS Institute Inc., Cary, NC, USA                */
 /*                           SAS Publications order # 57321                            */
 /*                                  ISBN 1-59047-148-2                                 */
 /*  	      	   This book is sold individually and as part of a set.                    */
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
 /* Questions or problems concerning this material may be                               
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


/* Chapter 3,"Tutorial: Writing and Submitting SAS Programs"

OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT  TEST1  TEST2;
DATALINES;
2 3
2 2
3 3
3 4
4 3
4 4
5 3
5 4
;
PROC MEANS  DATA=D1;
TITLE1 'type your name here';			
RUN;



/*  Chapter 4, "Data Input"								*/	
 
OPTIONS  LS=80  PS=60;
DATA D1;
INPUT  SUB_NUM;
       Q1
       Q2
       Q3
       POL_PRTY  $
       SEX  $
       AGE
       DONATION;
DATALINES;
01 7 6 5 D F 32 1000
02 2 2 3 R M  .    0
03 3 4 3 . M 45  100
04 6 6 5 . F 20    .
05 5 4 5 D F 31    0
06 2 3 1 R M 54    0
07 2 1 3 . M 21  250
08 3 3 3 R M 43    .
09 5 4 5 D F 32  100
10 3 2 . R F 18    0
11 3 6 4 R M 21   50
;
PROC MEANS DATA=D1;
   VAR  Q1  Q2  Q3  AGE  DONATION;
   TITLE1 'JOHN DOE';
RUN;
PROC FREQ DATA=D1;
   TABLES  POL_PRTY  SEX;
RUN;
PROC PRINT DATA=D1;
RUN;



/* Chapter 5, "Creating Frequency Tables"

OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT  SUB_NUM
          POL_PRTY  $
          SEX       $
          AGE
          DONATION
          Q1
          Q2
          Q3
          Q4 ;
DATALINES;
01 D M 47  400 4 3 6 2
02 R M 36  800 4 6 6 6
03 I F 52  200 1 3 7 2
04 R M 47  300 3 2 5 3
05 D F 42  300 4 4 5 6
06 R F 44 1200 2 2 5 5
07 D M 44  200 6 2 3 6
08 D M 50  400 4 3 6 2
09 R F 49 2000 3 1 6 2
10 D F 33  500 3 4 7 1
11 R M 49  700 7 2 6 7
12 D F 59  600 4 2 5 6
13 D M 38  300 4 1 2 6
14 I M 55  100 5 5 6 5
15 I F 52    0 5 2 6 5
16 D F 48  100 6 3 4 6
17 R F 47 1500 2 1 6 2
18 D M 49  500 4 1 6 2
19 D F 43 1000 5 2 7 3
20 D F 44  300 4 3 5 7
21 I F 38  100 5 2 4 1
22 D F 47  200 3 7 1 4
;


 
/ Chapter 6, "Creating Graphs"

OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT  SUB_NUM
   POL_PRTY  $
   SEX       $
   AGE
   DONATION
   Q1
   Q2
   Q3
   Q4 ;
DATALINES;
01 D M 47  400 4 3 6 2
02 R M 36  800 4 6 6 6
03 I F 52  200 1 3 7 2
04 R M 47  300 3 2 5 3
05 D F 42  300 4 4 5 6
06 R F 44 1200 2 2 5 5
07 D M 44  200 6 2 3 6
08 D M 50  400 4 3 6 2
09 R F 49 2000 3 1 6 2
10 D F 33  500 3 4 7 1
11 R M 49  700 7 2 6 7
12 D F 59  600 4 2 5 6
13 D M 38  300 4 1 2 6
14 I M 55  100 5 5 6 5
15 I F 52    0 5 2 6 5
16 D F 48  100 6 3 4 6
17 R F 47 1500 2 1 6 2
18 D M 49  500 4 1 6 2
19 D F 43 1000 5 2 7 3
20 D F 44  300 4 3 5 7
21 I F 38  100 5 2 4 1
22 D F 47  200 3 7 1 4
;
PROC CHART  DATA=D1;
   VBAR  POL_PRTY;
   TITLE1  'JANE DOE';
RUN;

 
  
/* Chapter 7, "Measures of Central Tendency and Variability"
 
OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT  SUB_NUM
          POL_PRTY  $
          SEX       $
          AGE
          DONATION
          Q1
          Q2
          Q3
          Q4 ;
DATALINES;
01 D M 47  400 4 3 6 2
02 R M 36  800 4 6 6 6
03 I F 52  200 1 3 7 2
04 R M 47  300 3 2 5 3
05 D F 42  300 4 4 5 6
06 R F 44 1200 2 2 5 5
07 D M 44  200 6 2 3 6
08 D M 50  400 4 3 6 2
09 R F 49 2000 3 1 6 2
10 D F 33  500 3 4 7 1
11 R M 49  700 7 2 6 7
12 D F 59  600 4 2 5 6
13 D M 38  300 4 1 2 6
14 I M 55  100 5 5 6 5
15 I F 52    0 5 2 6 5
16 D F 48  100 6 3 4 6
17 R F 47 1500 2 1 6 2
18 D M 49  500 4 1 6 2
19 D F 43 1000 5 2 7 3
20 D F 44  300 4 3 5 7
21 I F 38  100 5 2 4 1
22 D F 47  200 3 7 1 4
;
PROC UNIVARIATE DATA=D1  PLOT  NORMAL;
   VAR AGE;
   TITLE1  'JANE DOE';
RUN;



/* Chapter 8, "Creating and Modifying Variables and Data Sets
  
OPTIONS  LS=80  PS=60;
DATA D1;
INPUT  SUB_NUM
       Q1
       Q2
       Q3
       Q4
       Q5
       SEX  $
       AGE
       MAJOR;
DATALINES;
1  6  5  5  2  6   F   22   1
2  2  1  2  5  2   M   25   1
3  5  .  4  3  6   M   30   1
4  5  6  6  .  6   F   41   2
5  4  4  5  2  5   M   22   2
6  5  6  6  2  6   F   20   2
7  5  5  6  1  5   F   21   3
8  2  3  1  5  2   F   25   3
9  4  5  4  2  5   M   23   3
;
PROC PRINT  DATA=D1;
   TITLE1  'JANE DOE';
RUN;
     
DATA D2;
   SET D1;
 
   Q4 = 7 - Q4;
   ACH_MOT = (Q1 + Q2 + Q3 + Q4 + Q5) / 5;
 
   AGE2 = .;
   IF AGE LT 25 THEN AGE2 = 0;
   IF AGE GE 25 THEN AGE2 = 1;
      
   SEX2 = .;
   IF SEX = 'F' THEN SEX2 = 0;
   IF SEX = 'M' THEN SEX2 = 1;
       
   MAJOR2 = '  .';
   IF MAJOR = 1 THEN MAJOR2 = 'A&S';
   IF MAJOR = 2 THEN MAJOR2 = 'BUS';
   IF MAJOR = 3 THEN MAJOR2 = 'EDU';
 
PROC PRINT  DATA=D2;
     TITLE1 'JANE DOE';
RUN;
 
DATA D3;
SET D2;
IF MAJOR2 = 'A&S';
PROC MEANS  DATA=D3;
   TITLE1  'JANE DOE--ARTS AND SCIENCES MAJORS';
RUN;
       
DATA D4;
   SET D2;
   IF MAJOR2 = 'BUS';
PROC MEANS  DATA=D4;
   TITLE1  'JANE DOE--BUSINESS MAJORS';
RUN;
 
DATA D5;
   SET D2;
   IF MAJOR2 = 'EDU';
PROC MEANS  DATA=D5;
   TITLE1  'JANE DOE--EDUCATION MAJORS';
RUN;
    
DATA D6;
   SET D2;
   IF Q1 NE . AND
      Q2 NE . AND
      Q3 NE . AND
      Q4 NE . AND
      Q5 NE . ;
 
PROC PRINT DATA=D6;
   TITLE1 'JANE DOE';
RUN;



/* Chapter 9, "z Scores"
 
OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT  SUB_NUM
          NAME  $
          FREN
          GEOL;
DATALINES;
01  Fred      50   90
02  Susan     46  165
03  Marsha    45  170
04  Charles   41  110
05  Paul      39  130
06  Cindy     38  150
07  Jack      37  140
08  Cathy     35  120
09  George    34  155
10  John      31  180
11  Marie     29  135
12  Emmett    25  200
;
 
PROC MEANS DATA=D1  VARDEF=N  N  MEAN  STD  MIN  MAX;
   VAR  FREN  GEOL;
   TITLE1  'JANE DOE';
RUN;

DATA D2;
   SET D1;
   FREN_Z = (FREN - 37.50) / 7.01;
   GEOL_Z = (GEOL - 145.42) / 29.75;

PROC PRINT DATA=D2;
   VAR  NAME  FREN  GEOL  FREN_Z  GEOL_Z;
   TITLE 'JANE DOE';
RUN;

PROC MEANS DATA=D2  VARDEF=N  N  MEAN  STD  MIN  MAX;
   VAR  FREN_Z  GEOL_Z;
   TITLE1  'JANE DOE';
RUN;


 
/* Chapter 10, "Bivariate Correlation"
  
OPTIONS  LS=80  PS=60;
DATA D1;
INPUT  SUB_NUM
       KG_LOST
       MOTIVAT
       EXERCISE
       CALORIES
       IQ
DATALINES;
01  2.60   5  0  2400  100
02  1.00   5  0  2000  120
03  1.80  10  2  1600  130
04  2.65  10  5  2400  140
05  3.70  10  4  2000  130
06  2.25  15  4  2000  110
07  3.00  15  2  2200  110
08  4.40  15  3  1400  120
09  5.35  15  2  2000  110
10  3.25  20  1  1600   90
11  4.35  20  5  1800  150
12  5.60  20  3  2200  120
13  6.44  20  6  1200   90
14  4.80  25  1  1600  140
15  5.75  25  4  1800  130
16  6.90  25  5  1400  140
17  7.75  25  .  1400  100
18  5.90  30  4  1600  100
19  7.20  30  5  2000  150
20  8.20  30  2  1200  110
21  7.80  35  4  1600  130
22  9.00  35  6  1600  120
;

 
 
/* Chapter 11, "Bivariate Regression"
             
OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT  SUB_NUM
          KG_LOST
          MOTIVAT
          EXERCISE
          CALORIES
          IQ;
DATALINES;
01  2.60   5  0  2400  100
02  1.00   5  0  2000  120
03  1.80  10  2  1600  130
04  2.65  10  5  2400  140
05  3.70  10  4  2000  130
06  2.25  15  4  2000  110
07  3.00  15  2  2200  110
08  4.40  15  3  1400  120
09  5.35  15  2  2000  110
10  3.25  20  1  1600   90
11  4.35  20  5  1800  150
12  5.60  20  3  2200  120
13  6.44  20  6  1200   90
14  4.80  25  1  1600  140
15  5.75  25  4  1800  130
16  6.90  25  5  1400  140
17  7.75  25  .  1400  100
18  5.90  30  4  1600  100
19  7.20  30  5  2000  150
20  8.20  30  2  1200  110
21  7.80  35  4  1600  130
22  9.00  35  6  1600  120
;
PROC REG  DATA=D1;
   MODEL  KG_LOST = MOTIVAT  /  STB  P;
   TITLE1 'JANE DOE';
RUN;
 

 
/* Chapter 12, "Single-Sample t Test"
    
OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT  SUB_NUM
          RECALL;
DATALINES;
01  31
02  34
03  26
04  36
05  31
06  30
07  29
08  30
09  34
10  28
11  28
12  30
13  33
;
PROC TTEST  DATA=D1  H0=25  ALPHA=0.05;
   VAR RECALL;
   TITLE1  'JOHN DOE';
RUN;



/* Chapter 13, "Independent-Samples t Test"
 
OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT  SUB_NUM
          VIDGRP  $
          AGGRESS;
DATALINES;
01  PUN  3
02  PUN  6
03  PUN  4
04  PUN  8
05  PUN  7
06  PUN  0
07  PUN  5
08  PUN  2
09  PUN  4
10  PUN  5
11  PUN  6
12  PUN  1
13  PUN  2
14  PUN  3
15  PUN  4
16  PUN  5
17  PUN  3
18  PUN  4
19  REW  8
20  REW  9
21  REW  5
22  REW 10
23  REW  7
24  REW  7
25  REW  5
26  REW  3
27  REW  4
28  REW 11
29  REW  6
30  REW  6
31  REW  9
32  REW  8
33  REW  6
34  REW  7
35  REW  7
36  REW 10
;
PROC TTEST  DATA=D1  ALPHA=0.05;
   CLASS  VIDGRP;
   VAR AGGRESS;
   TITLE1  'JANE DOE';
RUN;



/* Chapter 14, "Paired-Samples t Test"

OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT  SUB_NUM
          EMOTION
          SEXUAL;
DATALINES;
01  21  18
02  24  19
03  23  21
04  27  24
05  25  25
06  24  21
07  26  22
08  25  21
09  28  21
10  20  19
11  22  20
12  27  23
13  26  23
14  23  22
15  22  19
16  22  20
17  23  20
;
PROC MEANS  DATA=D1;
   VAR  EMOTION  SEXUAL;
   TITLE1  'JANE DOE';
RUN;
PROC TTEST  DATA=D1  H0=0  ALPHA=0.05;
   PAIRED  EMOTION*SEXUAL;
RUN;



/* Chapter 15, "One-Way ANOVA with One Between-Subjects Factor"

OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT  SUB_NUM
          MOD_AGGR  $
          SUB_AGGR;
DATALINES;
01  L  07
02  L  17
03  L  14
04  L  11
05  L  11
06  L  20
07  L  08
08  L  15
09  M  08
10  M  20
11  M  11
12  M  15
13  M  16
14  M  16
15  M  12
16  M  21
17  H  14
18  H  10
19  H  17
20  H  18
21  H  20
22  H  21
23  H  14
24  H  23
;
PROC GLM  DATA=D1;
   CLASS  MOD_AGGR;
   MODEL  SUB_AGGR = MOD_AGGR;
   MEANS  MOD_AGGR;
   MEANS  MOD_AGGR / TUKEY  CLDIFF  ALPHA=0.05;
   TITLE1 'JOHN DOE';
RUN;
QUIT;



/* Chapter 16, "Factorial ANOVA with Two Between-Subjects Factors"

OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT  SUB_NUM
          CONSEQ    $
          MOD_AGGR  $
          SUB_AGGR;
DATALINES;
01 MR L 10
02 MR L  8
03 MR L 12
04 MR L 10
05 MR L  9
06 MR M 14
07 MR M 15
08 MR M 17
09 MR M 16
10 MR M 16
11 MR H 18
12 MR H 20
13 MR H 20
14 MR H 23
15 MR H 21
16 MP L  9
17 MP L  8
18 MP L  7
19 MP L 11
20 MP L 10
21 MP M 10
22 MP M 12
23 MP M 13
24 MP M  9
25 MP M  9
26 MP H 11
27 MP H 12
28 MP H  9
29 MP H 13
30 MP H 11
;
PROC GLM DATA=D1;
   CLASS  CONSEQ  MOD_AGGR;
   MODEL  SUB_AGGR = CONSEQ  MOD_AGGR  CONSEQ*MOD_AGGR;
   MEANS  CONSEQ  MOD_AGGR  CONSEQ*MOD_AGGR;
   MEANS  CONSEQ  MOD_AGGR / TUKEY  CLDIFF  ALPHA=0.05;
   TITLE1 'JANE DOE';
RUN;
QUIT;



/* Chapter 17, "Chi-Square Test of Independence"

OPTIONS  LS=80  PS=60;
DATA D1;
   INPUT   PREF     $
           SCHOOL   $
           NUMBER   ;
DATALINES;
IBM   ARTS    40
IBM   BUS     75
IBM   ED      68
MAC   ARTS    50
MAC   BUS     65
MAC   ED      72
;
PROC FREQ   DATA=D1;
   TABLES   PREF*SCHOOL   /   ALL;
   WEIGHT   NUMBER;
   TITLE1  'JANE DOE';
RUN;   
 


