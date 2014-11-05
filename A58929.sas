/*-------------------------------------------------------------------*/
/*        A Step-by-Step Approach to Using the SAS System for        */
/*      Univariate and Multivariate Statistics, Second Edition       */
/*      by  Norm O'Rourke, Larry Hatcher, and Edward Stepanski       */
/*      Copyright(c) 2005 by SAS Institute Inc., Cary, NC, USA       */                   
/*                                                                   */
/*                        ISBN 1-59047-417-1                         */
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
/* SAS Press                                                         */
/* Attn: O'Rourke, Hatcher, and Stepanski                            */
/* SAS Campus Drive                                                  */
/* Cary, NC   27513                                                  */
/*                                                                   */
/*                                                                   */
/* If you prefer, you can send email to:  saspress@sas.com           */
/* Use this for subject field:                                       */
/* Comments for O'Rourke, Hatcher, and Stepanski                     */
/*                                                                   */
/*-------------------------------------------------------------------*/


--------------------------
CHAPTER 2
--------------------------

/* The following program is found on pp. 23-24 of       */
/* A Step-by-Step Approach to Using the SAS System      */
/* for Univariate and Multivariate Statistics, 2nd Ed.   */

DATA D1;
INPUT PARTICIPANT GREVERBAL GREMATH;

DATALINES;
1 520 490
2 610 590
3 470 450
4 410 390
5 510 460
6 580 350
;
RUN;

 
PROC MEANS   DATA=D1;
   VAR  GREVERBAL  GREMATH;
RUN;


-----------------------------
CHAPTER 3
-----------------------------

/* The following program is found on p. 36 of           */
/* A Step-by-Step Approach to Using the SAS System      */
/* for Univariate and Multivariate Statistics, 2nd Ed.   */

DATA D1;
    INPUT   #1   @1   Q1      1.
  @2   Q2      1.
  @3   Q3      1.
  @4   Q4      1.
  @5   Q5      1.
  @6   Q6      1.
  @7   Q7      1.
     @9   AGE     2.
     @12  IQ      3.
  @16  NUMBER  2.  ;
DATALINES;
2234243 22  98  1
3424325 20 105  2
3242424 32  90  3
3242323  9 119  4
3232143  8 101  5
3242242 24 104  6
4343525 16 110  7
3232324 12  95  8
1322424 41  85  9
5433224 19 107 10
;
RUN;

PROC MEANS   DATA=D1;
RUN;
 

/* The following data set is found on p. 50 of        */
/* A Step-by-Step Approach to Using the SAS System    */
/* for Univariate and Multivariate Statistics, 2nd Ed. */
/* It is used with the program on p. 79.              */

DATA D1(TYPE=CORR) ;
   INPUT _TYPE_ $ _NAME_ $ V1-V6 ;
   LABEL
      V1 ='COMMITMENT'
      V2 ='SATISFACTION'
      V3 ='REWARDS'
      V4 ='COSTS'
      V5 ='INVESTMENTS'
      V6 ='ALTERNATIVES' ;
DATALINES;
N      .    240     240     240     240     240     240
STD    .   2.3192  1.7744  1.2525  1.4086  1.5575  1.8701
CORR  V1   1.0000   .       .       .       .       .
CORR  V2    .6742  1.0000   .       .       .       .
CORR  V3    .5501   .6721  1.0000   .       .       .
CORR  V4   -.3499  -.5717  -.4405  1.0000   .       .
CORR  V5    .6444   .5234   .5346  -.1854  1.0000   .
CORR  V6   -.6929  -.4952  -.4061   .3525  -.3934  1.0000
;
RUN;


-----------------------------
CHAPTER 4
-----------------------------

/* The following program is found on p. 79  of         */
/* A Step-by-Step Approach to Using the SAS System for */
/* Univariate and Multivariate Statistics, 2nd Ed.     */

DATA D1;
   INFILE 'A:/VOLUNTEER.DAT' ;
   INPUT   #1   @1    Q1-Q7        1.
                @9    AGE          2.
                @12   IQ           3.
                @16   NUMBER       2.
                @19   SEX         $1.
           #2   @1    GREVERBAL    3.
                @5    GREMATH      3.  ;
 
   DATA D2;
      SET D1;
 
   Q3 = 6 - Q3;
   Q6 = 6 - Q6;
   RESPONSE = (Q1 + Q2 + Q3) / 3;
   TRUST    = (Q4 + Q5 + Q6) / 3;
   SHOULD   =  Q7;
 
   PROC MEANS   DATA=D2;
   RUN;
 
   DATA D3;
      SET D2;
      IF SEX = 'F';
 
   PROC MEANS   DATA=D3;
   RUN;
 
   DATA D4;
      SET D2;
      IF SEX = 'M';
 
   PROC MEANS   DATA=D4;
   RUN;




/* The following program is found on p. 82 of          */
/* A Step-by-Step Approach to Using the SAS System for */
/* Univariate and Multivariate Statistics, 2nd Ed.     */

DATA  A;
   INPUT  #1   @1   NAME      $7.
               @10  GREVERBAL  3.
               @14  GREMATH    3.  ;
 
DATALINES;
John     520 500
Sally    610 640
Miguel   490 470
Mats     550 560
;
RUN;
      
DATA  B;
   INPUT  #1   @1   NAME      $7.
               @11  GREVERBAL  3.
               @15  GREMATH    3.  ;
 
DATALINES;
Susan     710 650
Jiri      450 400
Cheri     570 600
Zdeno     680 700
;
RUN;
    
DATA  C;
   SET  A  B;
     
PROC PRINT  DATA=C
RUN;


/* The following program is found on p. 86  of         */
/* A Step-by-Step Approach to Using the SAS System for */
/* Univariate and Multivariate Statistics, 2nd Ed.     */

DATA  D;
   INPUT  #1   @1  NAME       $9.
               @10 SOCSEC      9.
               @20 GREVERBAL   4.
               @23 GREMATH     4.  ;
  
DATALINES;
John     232882121 520 500
Sally    222773454 610 640
Miguel   211447653 490 470
Mats     222671234 550 560
;
RUN;
   
 
DATA  E;
   INPUT  #1  @1   NAME    $9.
              @10  SOCSEC   9. 
              @20  GPA      4.  ;
 
DATALINES;
John     232882121 2.70 
Sally    222773454 3.25
Miguel   211447653 2.20
Mats     222671234 2.50
;
RUN;
 
PROC SORT  DATA=D;
   BY  SOCSEC;
RUN;
 
PROC SORT  DATA=E;
   BY  SOCSEC;
RUN;

DATA  F;
   MERGE  D  E;
   BY  SOCSEC;
RUN;

PROC PRINT  DATA=F;
RUN;


-----------------------------
CHAPTER 5
-----------------------------

/* The following program is found on p. 92 of          */
/* A Step-by-Step Approach to Using the SAS System for */
/* Univariate and Multivariate Statistics, 2nd Ed.     */

DATA D1;
   INPUT   #1   @1   RESNEEDY   1.
                @3   SEX       $1.
                @5   CLASS      1.   ;
DATALINES;
5 F 1
4 M 1
5 F 1
  F 1
4 F 1
4 F 2
1 F 2
4 F 2
1 F 3
5 M
4 F 4
4 M 4
3 F
4 F 5
;
RUN;
 
PROC MEANS   DATA=D1;
   VAR RESNEEDY CLASS;
RUN;
PROC FREQ   DATA=D1;
   TABLES SEX CLASS RESNEEDY;
RUN;
PROC PRINT   DATA=D1;
   VAR RESNEEDY SEX CLASS;
RUN;


/* The following program is found on pp. 104-105 of    */
/* A Step-by-Step Approach to Using the SAS System for */
/* Univariate and Multivariate Statistics, 2nd Ed.     */

DATA D1;
   INPUT   #1   @1   PARTICIPANT  2.
                @4   AGE          2.   ;
DATALINES;
 1 72
 2 69
 3 75
 4 71
 5 71
 6 73
 7 70
 8 67
 9 71
10 72
11 73
12 68
13 69
14 70
15 70
16 71
17 74
18 72
;
RUN;
PROC UNIVARIATE   DATA=D1   NORMAL   PLOT;
   VAR AGE;
   ID PARTICIPANT;
RUN;


-----------------------------
CHAPTER 6
-----------------------------

/* The following program is found on p. 131 of         */
/* A Step-by-Step Approach to Using the SAS System for */
/* Univariate and Multivariate Statistics, 2nd Ed.     */


DATA D1;
   INPUT   #1   @1   COMMITMENT   2.
                @4   SATISFACTION 2.
                @7   INVESTMENT   2.
                @10  ALTERNATIVES 2.   ;
DATALINES;
20 20 28 21
10 12  5 31
30 33 24 11
 8 10 15 36
22 18 33 16
31 29 33 12
 6 10 12 29
11 12  6 30
25 23 34 12
10  7 14 32
31 36 25  5
 5  4 18 30
31 28 23  6
 4  6 14 29
36 33 29  6
22 21 14 17
15 17 10 25
19 16 16 22
12 14 18 27
24 21 33 16
;
RUN;

PROC GPLOT   DATA=D1;
   PLOT COMMITMENT*SATISFACTION;
RUN;
 

/* The following program is found on p. 141 of         */
/* A Step-by-Step Approach to Using the SAS System for */
/* Univariate and Multivariate Statistics, 2nd Ed.     */

DATA D1;
   INPUT   #1   @1   TEST1   2.
                @4   TEST2   2.  ;
DATALINES;
 1  2
 2  3
 3  1
 4  5
 5  4
 6  6
 7  7
 8  9
 9 10
10  8
;
RUN;
 
PROC CORR   DATA=D1   SPEARMAN;
   VAR TEST1 TEST2;
RUN;    


/* The following program is found on p. 148 of         */
/* A Step-by-Step Approach to Using the SAS System for */
/* Univariate and Multivariate Statistics, 2nd Ed.     */

DATA D1;
   INPUT   PREFERENCE  $
           SCHOOL      $
           NUMBER   ;
                
DATALINES;
IBM   ARTS        30
IBM   BUSINESS   100
IBM   EDUCATION   20
MAC   ARTS        60
MAC   BUSINESS    40
MAC   EDUCATIO   120
;
RUN;

PROC FREQ   DATA=D1;
   TABLES   PREFERENCE*SCHOOL   /   ALL;
   WEIGHT   NUMBER;
RUN;


---------------------------------------------
CHAPTER 7
---------------------------------------------

/* The following program is found on p. 161 of           */
/* A Step-by-Step Approach to Using the SAS System       */
/* for Univariate and Multivariate Statistics, 2nd Ed.   */

DATA D1;
   INPUT    #1    @1   (V1-V6)    (1.)  ;

DATALINES;
556754
567343
777222
665243
666665
353324
767153
666656
334333
567232
445332
555232
546264
436663
265454
757774
635171
667777
657375
545554
557231
666222
656111
464555
465771
142441
675334
665131
666443
244342
464452
654665
775221
657333
666664
545333
353434
666676
667461
544444
666443
676556
676444
676222
545111
777443
566443
767151
455323
455544
;
RUN;

PROC CORR   DATA=D1   ALPHA   NOMISS;
   VAR V1 V2 V3 V4;
RUN;


-----------------------------
CHAPTER 8
-----------------------------

/* The following program is found on p. 174 of         */
/* A Step-by-Step Approach to Using the SAS System for */
/* Univariate and Multivariate Statistics, 2nd Ed.     */

DATA D1;
   INPUT  #1  @1  REWGRP  1.
              @3  COMMIT  2.  ;
DATALINES;
1 12
1 10
1 15
1 13
1 16
1  9
1 13
1 14
1 15
1 13
2 25
2 22
2 27
2 24
2 22
2 20
2 24
2 23
2 22
2 24
;
RUN;

PROC TTEST   DATA=D1   ALPHA=.05;
   CLASS REWGRP;
   VAR COMMIT;
RUN;


/* The following program is found on pp. 184-185 of    */
/* A Step-by-Step Approach to Using the SAS System for */
/* Univariate and Multivariate Statistics, 2nd Ed.     */

DATA D1;
   INPUT  #1  @1  REWGRP  1.
              @3  COMMIT  2.  ;
DATALINES;
1 23
1 22
1 25
1 19
1 24
1 20
1 22
1 22
1 23
1 27
2 25
2 22
2 27
2 24
2 22
2 20
2 24
2 23
2 22
2 24
;
RUN;

PROC TTEST   DATA=D1   ALPHA=.05;
   CLASS REWGRP;
   VAR COMMIT;
RUN;


/* The following program is found on p. 199 of         */
/* A Step-by-Step Approach to Using the SAS System for */
/* Univariate and Multivariate Statistics, 2nd Ed.     */

DATA D1;
   INPUT   #1   @1   LOW   2.
                @4   HIGH  2.   ;
 
DATALINES;
 9 20
 9 22
10 23
11 23
12 24
12 25
14 26
15 28
17 29
19 31
;
RUN;
PROC MEANS   DATA=D1;
   VAR LOW HIGH;
RUN;

PROC TTEST   DATA=D1   H0=0   ALPHA=.05;   
   PAIRED HIGH*LOW;
RUN;


/* The following program is found on p. 206 of         */
/* A Step-by-Step Approach to Using the SAS System for */
/* Univariate and Multivariate Statistics, 2nd Ed.     */

DATA D1;
   INPUT   #1   @1   PRETEST   2.
                @4   POSTTEST  2.   ;
   
DATALINES;
34 55
35 49
39 59
41 63
43 62
44 68
44 69
52 72
55 75
57 78
;
RUN;

PROC MEANS   DATA=D1;
   VAR PRETEST POSTTEST;
RUN;

PROC TTEST   DATA=D1   
     H0=0   
     ALPHA=.05;   
     PAIRED POSTTEST*PRETEST;
RUN;


-----------------------------
CHAPTER 9
-----------------------------

/* The following program is found on p. 216 of         */
/* A Step-by-Step Approach to Using the SAS System for */
/* Univariate and Multivariate Statistics, 2nd Ed.     */

DATA D1;
   INPUT  #1  @1  REWARDGROUP  1.
              @3  COMMITMENT  2.  ;
DATALINES;
1 13
1 06
1 12
1 04
1 09
1 08
2 33
2 29
2 35
2 34
2 28
2 27
3 36
3 32
3 31
3 32
3 35
3 34
;
RUN;
                 
PROC GLM DATA=D1;
   CLASS REWARDGROUP;
   MODEL COMMITMENT = REWARDGROUP;
   MEANS REWARDGROUP / TUKEY;
   MEANS REWARDGROUP;
RUN;


/* The following data set is found on p. 228 of        */
/* A Step-by-Step Approach to Using the SAS System for */
/* Univariate and Multivariate Statistics, 2nd Ed.     */

DATALINES;
1 15
1 17
1 10
1 19
1 16
1 18
2 14
2 17
2 16
2 18
2 11
2 12
3 17
3 20
3 14
3 16
3 16
3 17
;
RUN;


--------------------------------------------
CHAPTER 10
---------------------------------------------

/* The following program is found on p. 252 of           */
/* A Step-by-Step Approach to Using the SAS System       */
/* for Univariate and Multivariate Statistics, 2nd Ed.   */

DATA D1;
   INPUT  #1  @1  COSTGRP  1.
              @3  REWGRP   1.
              @5  COMMIT   2.  ;
DATALINES;
1 1 08 
1 1 13
1 1 07
1 1 14
1 1 07
1 2 19
1 2 17
1 2 20
1 2 25
1 2 16
1 3 31
1 3 24
1 3 37
1 3 30
1 3 32
2 1 09
2 1 14
2 1 05
2 1 14
2 1 16
2 2 22
2 2 18
2 2 20
2 2 19       
2 2 21
2 3 24
2 3 33
2 3 24
2 3 26
2 3 31
;
RUN;

PROC GLM DATA=D1;
   CLASS REWGRP COSTGRP;
   MODEL COMMIT = REWGRP COSTGRP REWGRP*COSTGRP;
   MEANS REWGRP COSTGRP / TUKEY;
   MEANS REWGRP COSTGRP REWGRP*COSTGRP;
RUN;


/* The following data set is found on p. 260-261 of         */
/* A Step-by-Step Approach to Using the SAS System      */
/* for Univariate and Multivariate Statistics, 2nd Ed.  */

DATALINES;
1 1 08 
1 1 13
1 1 04
1 1 11
1 1 05
1 2 17
1 2 12
1 2 20
1 2 14
1 2 16
1 3 31
1 3 24
1 3 37
1 3 30
1 3 32
2 1 16
2 1 10
2 1 25
2 1 15
2 1 14
2 2 21
2 2 13
2 2 16
2 2 12       
2 2 17
2 3 18
2 3 23
2 3 19
2 3 18
2 3 18
;
 

/* The following data set is found on p. 268 of         */
/* A Step-by-Step Approach to Using the SAS System      */
/* for Univariate and Multivariate Statistics, 2nd Ed.  */

PROC GLM DATA=D1;
   CLASS REWGRP COSTGRP;
   MODEL COMMIT = REWGRP COSTGRP REWGRP*COSTGRP;
   MEANS REWGRP COSTGRP / TUKEY;
   MEANS REWGRP COSTGRP REWGRP*COSTGRP;
RUN;

PROC SORT DATA=D1;
   BY COSTGRP;
RUN;

PROC GLM DATA=D1;
   CLASS REWGRP;
   MODEL COMMIT = REWGRP;
   MEANS REWGRP / TUKEY;
   MEANS REWGRP;
   BY COSTGRP;
RUN;


---------------------------------------------
CHAPTER 11
---------------------------------------------

/* The following program is found on p. 286 of          */
/* A Step-by-Step Approach to Using the SAS System      */
/* for Univariate and Multivariate Statistics, 2nd Ed.  */

DATA D1;
   INPUT  #1  @1  REWGRP  1.
              @3  COMMIT  2.
              @6  SATIS   2.
              @9  STAY    2. ;
DATALINES;
1 13 10 14
1 06 10 08
1 12 12 15
1 04 10 13
1 09 05 07
1 08 05 12
2 33 30 36
2 29 25 29
2 35 30 30
2 34 28 26
2 28 30 26
2 27 26 25
3 36 30 28
3 32 32 29
3 31 31 27
3 32 36 36
3 35 30 33
3 34 30 32
;         
RUN;

PROC GLM DATA=D1;
   CLASS REWGRP;
   MODEL COMMIT SATIS STAY = REWGRP;
   MEANS REWGRP / TUKEY;
   MEANS REWGRP;
   MANOVA H = REWGRP / MSTAT = exact;
RUN;


/* The following data set is found on p. 294 of        */
/* A Step-by-Step Approach to Using the SAS System     */
/* for Univariate and Multivariate Statistics, 2nd Ed. */

DATALINES;
1 16 19 18
1 18 15 17
1 18 14 14
1 16 20 10
1 15 13 17
1 12 15 11
2 16 20 13
2 18 14 16
2 13 10 14
2 17 13 19
2 14 18 15
2 19 16 18
3 20 18 16
3 18 15 19
3 13 14 17
3 12 16 15
3 16 17 18
3 14 19 15
;         
RUN;


---------------------------------------------
CHAPTER 12
---------------------------------------------

/* The following program is found on p. 305-306 of     */
/* A Step-by-Step Approach to Using the SAS System     */
/* for Univariate and Multivariate Statistics, 2nd Ed. */

DATA REP;
   INPUT #1 @1    ID         2.
            @5    PRE        2.
            @9    POST       2.
            @13   FOLLOWUP   2. ;
DATALINES;
01  08  10  10
02  10  13  12
03  07  10  12
04  06  09  10
05  07  08  09
06  11  15  14
07  08  10  09
08  05  08  08
09  12  11  12
10  09  12  12
11  10  14  13
12  07  12  11
13  08  08  09
14  13  14  14
15  11  11  12
16  07  08  07
17  09  08  10
18  08  13  14
19  10  12  12


/* The following program is found on p. 310 of         */
/* A Step-by-Step Approach to Using the SAS System     */
/* for Univariate and Multivariate Statistics, 2nd Ed. */

PROC MEANS  DATA=REP;
RUN;

PROC GLM  DATA=REP;
   MODEL PRE POST FOLLOWUP =  / NOUNI;
   REPEATED TIME 3 CONTRAST (1) / SUMMARY;
RUN;


---------------------------------------------
CHAPTER 13
---------------------------------------------

/* The following program is found on pp. 337-338 of    */
/* A Step-by-Step Approach to Using the SAS System     */
/* for Univariate and Multivariate Statistics, 2nd Ed. */

DATA MIXED;
INPUT #1 @1    PARTICIPANT   2.
         @5    GROUP         1.
         @10   PRE           2.
         @15   POST          2.
         @20   FOLLOWUP      2. ;
DATALINES;
01  1    08   10   10
02  1    10   13   12
03  1    07   10   12
04  1    06   09   10
05  1    07   08   09
06  1    11   15   14
07  1    08   10   09
08  1    05   08   08
09  1    12   11   12
10  1    09   12   12
11  2    10   14   13
12  2    07   12   11
13  2    08   08   09
14  2    13   14   14
15  2    11   11   12
16  2    07   08   07
17  2    09   08   10
18  2    08   13   14
19  2    10   12   12
20  2    06   09   10
;
RUN;


/* The following program is found on p. 341 of         */
/* A Step-by-Step Approach to Using the SAS System     */
/* for Univariate and Multivariate Statistics, 2nd Ed. */

PROC GLM  DATA=MIXED;
   CLASS GROUP;
   MODEL PRE POST FOLLOWUP = GROUP / NOUNI;
   REPEATED TIME 3 CONTRAST (1) / SUMMARY;
RUN;


/* The following program is found on p. 355 of          */
/* A Step-by-Step Approach to Using the SAS System      */
/* for Univariate and Multivariate Statistics, 2nd Ed.  */

DATA CONTROL;
   SET MIXED;
   IF GROUP=1 THEN OUTPUT;
RUN;

DATA EXP;
   SET MIXED;
   IF GROUP=2 THEN OUTPUT;
RUN;

PROC GLM  DATA=CONTROL;
   MODEL PRE POST FOLLOWUP =  / NOUNI;
   REPEATED TIME 3 CONTRAST (1) / SUMMARY;
RUN;

PROC GLM  DATA=EXP;
   MODEL PRE POST FOLLOWUP =  / NOUNI;
   REPEATED TIME 3 CONTRAST (1) / SUMMARY;
RUN;


/* The following program is found on p. 360 of         */
/* A Step-by-Step Approach to Using the SAS System     */
/* for Univariate and Multivariate Statistics, 2nd Ed. */

PROC GLM DATA=MIXED;
   CLASS GROUP;
   MODEL PRE = GROUP ;
RUN;

PROC GLM DATA=MIXED;
   CLASS GROUP;
   MODEL POST = GROUP ;
RUN;

PROC GLM DATA=MIXED;
   CLASS GROUP;
   MODEL FOLLOWUP = GROUP ;
RUN;


---------------------------------------------
CHAPTER 14
---------------------------------------------

/* The following program is found on p. 406-407 of     */
/* A Step-by-Step Approach to Using the SAS System     */
/* for Univariate and Multivariate Statistics, 2nd Ed. */
/* The full data set is included here, as well as      */
/* at the end of this file (in material for            */
/* Appendix B: "Data Sets").                           */

DATA D1;
   INPUT   #1    @1   COMMITMENT      2.
                 @4   SATISFACTION    2.
                 @7   REWARD          2.
                 @10  COST            2.
                 @13  INVESTMENT      2.
                 @16  ALTERNATIVES    2.   ;

   IF REWARD NE . AND COST   NE . AND INVESTMENT NE . AND
      ALTERNATIVES NE . AND COMMITMENT NE . ;

DATALINES;
34 30 25 13 25 12
32 27 27 14 32 13
34 23 24 21 30 14
26 26 22 18 27 19
 4 17 25 10 11 34
31 26 30 22 31 13
22 29 31 18 27 14
32 29 27  9 31  8
33 36 31 14 28 13
36 32 26 14 19 12
19 24 22 23 23  4
36 35 31 14 34  4
30 30 30 20 30 23
35 21 22 20 24 19
36 27 33  7 31  4
35 31 30 20 29  8
 4 20 20 22 14 28
36 35 29 14 34  8
36 32 28 14 28 15
19 18 17 25 18 20
20 30 26 20 23 28
36 34 31 21 32 18
29 27 24 19 19 13
 9 36 30  5 18 24
28 24 27 15 22 20
10 26 24 24 27 27
34 31 29  9 29 17
 7 12 16 26 20 33
35 36 33 13 27 16
36 33 30  5 29 13
 6 19 27 21 24 26
35  . 30 18 24 21
35 34 32 18 28 16
24 24 23 17 17 20
36 24 31 14 30 20
28 24 19 24 24 17
33 33 28 16 19 11
 5 12  9 15 11 32
21 24 20 24 22 14
16  9 12 30  . 15
36 34 32  6 20  9
29 27 27 20 30 21
 .  7 12 23 13 26
34 34 32 20 31 13
35 27 23 21 31 18
25 26 29  7 23 18
36 25 25 16 29 11
36 32 28 13 15  5
32 29 30 21 32 22
30 32 33 16 34  9
;
RUN;

PROC CORR   DATA=D1;
   VAR  COMMITMENT  REWARD  COST  INVESTMENT  ALTERNATIVES;
RUN; 


---------------------------------------------
CHAPTER 15
---------------------------------------------

/* The following program is found on p. 444 of         */
/* A Step-by-Step Approach to Using the SAS System     */
/* for Univariate and Multivariate Statistics, 2nd Ed. */
/* The full data set is included here, as well as      */
/* at the end of this file (in material for            */
/* Appendix B: "Data Sets").                           */

DATA D1;
   INPUT    #1    @1   (V1-V6)    (1.)  ;

DATALINES;
556754
567343
777222
665243
666665
353324
767153
666656
334333
567232
445332
555232
546264
436663
265454
757774
635171
667777
657375
545554
557231
666222
656111
464555
465771
142441
675334
665131
666443
244342
464452
654665
775221
657333
666664
545333
353434
666676
667461
544444
666443
676556
676444
676222
545111
777443
566443
767151
455323
455544
;
RUN;

PROC FACTOR   DATA=D1
              SIMPLE 
              METHOD=PRIN
              PRIORS=ONE
              MINEIGEN=1
              SCREE
              ROTATE=VARIMAX
              ROUND
              FLAG=.40   ;
   VAR V1 V2 V3 V4 V5 V6;
RUN;
 


/* The following program is found on p. 470 of         */
/* A Step-by-Step Approach to Using the SAS System     */
/* for Univariate and Multivariate Statistics, 2nd Ed. */

DATA D1(TYPE=CORR)  ;
   INPUT   _TYPE_   $
           _NAME_   $
           V1-V12   ;
DATALINES;
N     .    300  300  300  300  300  300  300  300  300  300  300  300
STD   .   2.48 2.39 2.58 3.12 2.80 3.14 2.92 2.50 2.10 2.14 1.83 2.26
CORR V1   1.00  .    .    .    .    .    .    .    .    .    .    .
CORR V2    .69 1.00  .    .    .    .    .    .    .    .    .    .
CORR V3    .60  .79 1.00  .    .    .    .    .    .    .    .    .
CORR V4    .62  .47  .48 1.00  .    .    .    .    .    .    .    .
CORR V5    .03  .04  .16  .09 1.00  .    .    .    .    .    .    .
CORR V6    .05 -.04  .08  .05  .91 1.00  .    .    .    .    .    .
CORR V7    .14  .05  .06  .12  .82  .89 1.00  .    .    .    .    .   
CORR V8    .23  .13  .16  .21  .70  .72  .82 1.00  .    .    .    .
CORR V9   -.17 -.07 -.04 -.05 -.33 -.26 -.38 -.45 1.00  .    .    .
CORR V10  -.10 -.08  .07  .15 -.16 -.20 -.27 -.34  .45 1.00  .    .
CORR V11  -.24 -.19 -.26 -.28 -.43 -.37 -.53 -.57  .60  .22 1.00  .
CORR V12  -.11 -.07  .07  .08 -.10 -.13 -.23 -.31  .44  .60  .26 1.00
;

PROC FACTOR   DATA=D1
              METHOD=PRIN
              PRIORS=ONE
              MINEIGEN=1
              SCREE
              ROTATE=VARIMAX
              ROUND
              FLAG=.40   ;
   VAR  V1-V12;
RUN;


---------------------------------------------
APPENDIX B: DATA SETS
---------------------------------------------

/* The following data set is found on pp. 492-293 of       */
/* A Step-by-Step Approach to Using the SAS System, 2nd Ed. */
/* for Univariate and Multivariate Statistics.             */
/* It is used in Chapter 7.                                */

DATALINES;
556754
567343
777222
665243
666665
353324
767153
666656
334333
567232
445332
555232
546264
436663
265454
757774
635171
667777
657375
545554
557231
666222
656111
464555
465771
142441
675334
665131
666443
244342
464452
654665
775221
657333
666664
545333
353434
666676
667461
544444
666443
676556
676444
676222
545111
777443
566443
767151
455323
455544
;
RUN;

 
/* The following data set is found on pp. 493-494 of  */
/* A Step-by-Step Approach to Using the SAS System    */
/* for Univariate and Multivariate Statistics, 2nd Ed. */
/* It is used in Chapters 14 and 15.                  */

DATALINES;
34 30 25 13 25 12
32 27 27 14 32 13
34 23 24 21 30 14
26 26 22 18 27 19
 4 17 25 10 11 34
31 26 30 22 31 13
22 29 31 18 27 14
32 29 27  9 31  8 
33 36 31 14 28 13
36 32 26 14 19 12
19 24 22 23 23  4
36 35 32 14 34  4
30 30 30 20 30 23
35 21 22 20 24 19
36 27 33  7 31  4
35 31 30 20 29  8
 4 20 20 22 14 28
36 35 29 14 34  8
36 32 28 14 28 15
19 18 17 25 18 20
20 30 26 20 23 28
36 34 31 21 32 18
29 27 24 19 19 13
 9 36 30  5 18 24
28 24 27 15 22 20
10 26 24 24 27 27
34 31 29  9 29 17
 7 12 16 26 20 33
35 36 33 13 27 16
36 33 30  5 29 13
 6 19 27 21 24 26
35  . 30 18 24 21
35 34 32 18 28 16
24 24 23 17 17 20
36 24 31 14 30 20
28 24 19 24 24 17
33 33 28 16 19 11
 5 12  9 15 11 32
21 24 20 24 22 14
16  9 12 30  . 15
36 34 32  6 20  9
29 27 27 20 30 21
 .  7 12 23 13 26
34 34 32 20 31 13
35 27 23 21 31 18
25 26 29  7 23 18
36 25 25 16 29 11
36 32 28 13 15  5
32 29 30 21 32 22
30 32 33 16 34  9
; 
RUN;




