***********************************************************************
This file contains programs and data sets from the book,
"A Step-by-Step Approach to Using the SAS System for Factor Analysis 
and
Structural Equation Modeling" by Larry Hatcher, Ph.D., and Edward J.
Stepanski, Ph.D.

Copyright (C) 1994 by SAS Institute Inc., Cary, NC, USA.

SAS(R) is a registered trademark of SAS Institute Inc.

SAS Institute does not assume responsibility for the accuracy of any
material presented in this file.


/*-------------------------------------------------------------------*/
/* Date Last Updated: 21Jun04                                        */
/*-------------------------------------------------------------------*/


***********************************************************************

--------------------------------------------------------------
CHAPTER 1
--------------------------------------------------------------

/* The following program is found on p. 17 of        */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1     DATA D1;
 2        INPUT    #1    @1   (V1-V6)    (1.)  ;
 3     CARDS;
 4     556754
 5     567343
 6     777222
 7     .
 8     .
 9     .
10     767151
11     455323
12     455544
13     ;
14     PROC FACTOR   DATA=D1
15                   SIMPLE
16                   METHOD=PRIN
17                   PRIORS=ONE
18                   MINEIGEN=1
19                   SCREE
20                   ROTATE=VARIMAX
21                   ROUND
22                   FLAG=.40   ;
23        VAR V1 V2 V3 V4 V5 V6;
24        RUN;


/* The following program is found on p. 33 of        */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */


 1     PROC FACTOR   DATA=D1
 2                   SIMPLE
 3                   METHOD=PRIN
 4                   PRIORS=ONE
 5                   NFACT=2
 6                   ROTATE=VARIMAX
 7                   ROUND
 8                   FLAG=.40
 9                   OUT=D2   ;
10        VAR V1 V2 V3 V4 V5 V6;
11        RUN;
12
13     PROC CORR   DATA=D2;
14        VAR FACTOR1 FACTOR2;
15        WITH V1 V2 V3 V4 V5 V6 FACTOR1 FACTOR2;
16        RUN;


/* The following program is found on p. 43 of        */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1     DATA D1(TYPE=CORR) ;
 2        INPUT   _TYPE_   $
 3                _NAME_   $
 4                V1-V12   ;
 5     CARDS;
 6     N     .    300  300  300  300  300  300  300  300  300  300  300  
300
 7     STD   .   2.48 2.39 2.58 3.12 2.80 3.14 2.92 2.50 2.10 2.14 1.83 
2.26
 8     CORR V1   1.00  .    .    .    .    .    .    .    .    .    .    
.
 9     CORR V2    .69 1.00  .    .    .    .    .    .    .    .    .    
.
10     CORR V3    .60  .79 1.00  .    .    .    .    .    .    .    .    
.
11     CORR V4    .62  .47  .48 1.00  .    .    .    .    .    .    .    
.
12     CORR V5    .03  .04  .16  .09 1.00  .    .    .    .    .    .    
.
13     CORR V6    .05 -.04  .08  .05  .91 1.00  .    .    .    .    .    
.
14     CORR V7    .14  .05  .06  .12  .82  .89 1.00  .    .    .    .    
.
15     CORR V8    .23  .13  .16  .21  .70  .72  .82 1.00  .    .    .    
.
16     CORR V9   -.17 -.07 -.04 -.05 -.33 -.26 -.38 -.45 1.00  .    .    
.
17     CORR V10  -.10 -.08  .07  .15 -.16 -.20 -.27 -.34  .45 1.00  .    
.
18     CORR V11  -.24 -.19 -.26 -.28 -.43 -.37 -.53 -.57  .60  .22 1.00  
.
19     CORR V12  -.11 -.07  .07  .08 -.10 -.13 -.23 -.31  .44  .60  .26 
1.00
20     ;
21     PROC FACTOR   DATA=D1
22                   METHOD=PRIN
23                   PRIORS=ONE
24                   MINEIGEN=1
25                   SCREE
26                   ROTATE=VARIMAX
27                   ROUND
28                   FLAG=.40   ;
29        VAR  V1-V12;
30        RUN;


---------------------------------------------------------
CHAPTER 2
---------------------------------------------------------

/* The following program is found on p. 76 of        */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1     DATA D1;
 2        INPUT    #1    @1   (V1-V6)    (1.)
 3                       @8   (COMMIT)   (2.) ;
 4     CARDS;
 5     776122 24
 6     776111 28
 7     111425  4
 8     .
 9     .
10     .
11     433344 15
12     557332 20
13     655222 13
14     ;
15     PROC FACTOR   DATA=D1
16                   SIMPLE
17                   METHOD=PRIN
18                   PRIORS=SMC
19                   NFACT=2
20                   SCREE
21                   ROTATE=PROMAX
22                   ROUND
23                   FLAG=.40   ;
24        VAR V1 V2 V3 V4 V5 V6;
25        RUN;


/* The following program is found on p. 98 of        */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1     PROC FACTOR   DATA=D1
 2                   SIMPLE
 3                   METHOD=PRIN
 4                   PRIORS=SMC
 5                   NFACT=2
 6                   ROTATE=PROMAX
 7                   ROUND
 8                   FLAG=.40
 9                   OUT=D2 ;
10        VAR V1-V6 ;
11        RUN;
12
13     PROC CORR   DATA=D2;
14        VAR COMMIT FACTOR1 FACTOR2;
15        RUN;


/* The following program is found on p. 102 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1     PROC FACTOR   DATA=D1
 2                   SIMPLE
 3                   METHOD=PRIN
 4                   PRIORS=SMC
 5                   NFACT=2
 6                   ROTATE=PROMAX
 7                   ROUND
 8                   FLAG=.40
 9                   OUT=D2 ;
10        VAR V1-V6 ;
11        RUN;
12
13
14     DATA D3;
15        SET D2;
16
17     INVEST  = (V1 + V2 + V3);
18     ALTERN  = (V4 + V5 + V6);
19
20     PROC CORR   DATA=D3;
21        VAR COMMIT FACTOR1 FACTOR2 INVEST ALTERN;
22        RUN;

/* The following program is found on p. 110 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1     PROC FACTOR   DATA=D1
 2                   SIMPLE
 3                   METHOD=ML
 4                   PRIORS=SMC
 5                   NFACT=1
 6                   SCREE
 7                   ROTATE=PROMAX
 8                   ROUND
 9                   FLAG=.40   ;
10        VAR VALUES ABILIT ASSESS STRAT EXPER ORGCHAR RESOCCU
11            RESEMPL GOALS BARRIER MOTIVAT RESUMES LETREC
12            DIRECT APPLIC IDENEMP CARDEV AGENCY FAIRS
13            ADVERT COUNS UNADV NETWORK INTERV SALARY ;
14        RUN;


---------------------------------------------------------
CHAPTER 3
---------------------------------------------------------

/* The following program is found on p. 135 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1     DATA D1;
 2        INPUT    #1    @1   (V1-V6)    (1.)  ;
 3     CARDS;
 4     556754
 5     567343
 6     777222
 7     .
 8     .
 9     .
10     767151
11     455323
12     455544
13     ;
14     PROC CORR   DATA=D1   ALPHA   NOMISS;
15        VAR V1 V2 V3 V4;
16        RUN;


---------------------------------------------------------
CHAPTER 4
---------------------------------------------------------

/* The following program is found on p. 164 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

/* ERRATA:                                           */

/* The correlation matrix on page 164 contains one   */
/* error:  the book incorrectly reports that the     */
/* correlation between V1 and V6 is -.6929;          */
/* the correct correlation is actually -.6129        */

/* The following program contains the corrected      */
/* correlation matrix.                               */

     DATA D1(TYPE=CORR) ;
        INPUT _TYPE_ $ _NAME_ $ V1-V6 ;
           LABEL
               V1 ='COMMITMENT'
               V2 ='SATISFACTION'
               V3 ='REWARDS'
               V4 ='COSTS'
               V5 ='INVESTMENTS'
               V6 ='ALTERNATIVES' ;
     CARDS;
     N      .    240     240     240     240     240     240
     STD    .  2.3192  1.7744  1.2525  1.4086  1.5575  1.8701
     CORR  V1  1.0000   .       .       .       .       .
     CORR  V2   .6742  1.0000   .       .       .       .
     CORR  V3   .5501   .6721  1.0000   .       .       .
     CORR  V4  -.3499  -.5717  -.4405  1.0000   .       .
     CORR  V5   .6444   .5234   .5346  -.1854  1.0000   .
     CORR  V6  -.6129  -.4952  -.4061   .3525  -.3934  1.0000
     ;
     PROC CALIS   COVARIANCE CORR RESIDUAL MODIFICATION ;
        LINEQS
           V1 = PV1V2 V2 + PV1V5 V5 + PV1V6 V6 + E1,
           V2 = PV2V3 V3 + PV2V4 V4            + E2;
        STD
           E1 = VARE1,
           E2 = VARE2,
           V3 = VARV3,
           V4 = VARV4,
           V5 = VARV5,
           V6 = VARV6;
        COV
           V3 V4 = CV3V4,
           V3 V5 = CV3V5,
           V3 V6 = CV3V6,
           V4 V5 = CV4V5,
           V4 V6 = CV4V6,
           V5 V6 = CV5V6;
        VAR  V1 V2 V3 V4 V5 V6 ;
        RUN;




/* The following program is found on p. 212 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */


20     PROC CALIS   COVARIANCE CORR RESIDUAL MODIFICATION ;
21        LINEQS
22           V1 = PV1V2 V2 + PV1V5 V5 + PV1V6 V6 + E1,
23           V2 = PV2V3 V3 + PV2V4 V4 + PV2V5 V5 + E2;
24        STD
25           E1 = VARE1,
26           E2 = VARE2,
27           V3 = VARV3,
28           V4 = VARV4,
29           V5 = VARV5,
30           V6 = VARV6;
31        COV
32           V3 V4 = CV3V4,
33           V3 V5 = CV3V5,
34           V3 V6 = CV3V6,
35           V4 V5 = CV4V5,
36           V4 V6 = CV4V6,
37           V5 V6 = CV5V6;
38        VAR  V1 V2 V3 V4 V5 V6 ;
39        RUN;

/* The following program is found on p. 239 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1     DATA D1(TYPE=CORR) ;
 2       INPUT _TYPE_ $ _NAME_ $ V1-V7;
 3       LABEL
 4          V1 ='REPORT'
 5          V2 ='EXPECTED_OUTCOMES'
 6          V3 ='FEMINIST'
 7          V4 ='SERIOUSNESS'
 8          V5 ='MARKETABILITY'
 9          V6 ='AGE'
10          V7 ='NORMS' ;
11     CARDS;
12     N      .    202     202     202     202     202     202     202
13     STD    .  2.0355  1.4500  0.4393  2.1873  2.7433  4.0513  1.0552
14     CORR  V1  1.0000   .       .       .       .       .       .
15     CORR  V2   .4815  1.0000   .       .       .       .       .
16     CORR  V3  -.0306   .0014  1.0000   .       .       .       .
17     CORR  V4   .1458   .1683   .1148  1.0000   .       .       .
18     CORR  V5   .0479   .1939   .0128   .0599  1.0000   .       .
19     CORR  V6  -.0302  -.1165   .1479   .1061  -.0998  1.0000   .
20     CORR  V7   .3952   .3700   .0512   .2486   .1275   .0606  1.0000
21     ;
22     PROC CALIS   COVARIANCE CORR RESIDUAL MODIFICATION ;
23        LINEQS
24           V1 = PV1V2 V2 + PV1V3 V3 + PV1V7 V7                       + E1,
25           V2 = PV2V3 V3 + PV2V4 V4 + PV2V5 V5 + PV2V6 V6 + PV2V7 V7 + E2;
26        STD
27           E1 = VARE1,
28           E2 = VARE2,
29           V3 = VARV3,
30           V4 = VARV4,
31           V5 = VARV5,
32           V6 = VARV6,
33           V7 = VARV7;
34        COV
35           V3 V4 = CV3V4,
36           V3 V5 = CV3V5,
37           V3 V6 = CV3V6,
38           V3 V7 = CV2V7,
39           V4 V5 = CV4V5,
40           V4 V6 = CV4V6,
41           V4 V7 = CV4V7,
42           V5 V6 = CV5V6,
43           V5 V7 = CV5V7,
44           V6 V7 = CV6V7;
45        VAR  V1 V2 V3 V4 V5 V6 V7 ;


---------------------------------------------------------
CHAPTER 5
---------------------------------------------------------


/* The following program is found on p. 274 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

/* ERRATA:                                           */

/* The correlation matrix on page 274 contains       */
/* three errors:                                     */

/* 1) The book incorrectly reports that the          */
/* standard deviation for V5 is 1.926; the correct   */
/* standard deviation is actually 1.929.             */

/* 2) The book incorrectly reports that the          */
/* correlation between V10 and V13 is -.033; the     */
/* correct correlation is actually -.003.            */

/* 3) The book incorrectly reports that the          */
/* correlation between V16 and V19 is -.803; the     */
/* correct correlation is actually -.083.            */

/* The following program contains the corrected      */
/* correlation matrix.                               */

DATA D1(TYPE=CORR);
   INPUT _TYPE_ $ _NAME_ $ V1-V19;
CARDS;
N      .    240   240   240   240   240   240   240   240   240   240   
240   240   240   240   240   240   240   240   240
STD    .  2.486 2.909 2.724 2.926 1.929 2.113 2.056 1.417 1.408 1.724 
2.595 2.691 2.360 2.102 2.219 1.874 2.001 1.966 2.185
CORR  V1  1.000  .     .     .     .     .     .     .     .     .     
.     .     .     .     .     .     .     .     .
CORR  V2   .734 1.000  .     .     .     .     .     .     .     .     
.     .     .     .     .     .     .     .     .
CORR  V3   .819  .786 1.000  .     .     .     .     .     .     .     
.     .     .     .     .     .     .     .     .
CORR  V4   .672  .732  .751 1.000  .     .     .     .     .     .     
.     .     .     .     .     .     .     .     .
CORR  V5   .514  .362  .496  .471 1.000  .     .     .     .     .     
.     .     .     .     .     .     .     .     .
CORR  V6   .534  .346  .452  .452  .713 1.000  .     .     .     .     
.     .     .     .     .     .     .     .     .
CORR  V7   .522  .345  .507  .546  .720  .764 1.000  .     .     .     
.     .     .     .     .     .     .     .     .
CORR  V8   .346  .293  .341  .294  .337  .375  .285 1.000  .     .     
.     .     .     .     .     .     .     .     .
CORR  V9   .209  .147  .167  .214  .251  .306  .357  .390 1.000  .     
.     .     .     .     .     .     .     .     .
CORR V10   .349  .241  .287  .236  .282  .351  .304  .506  .492 1.000  
.     .     .     .     .     .     .     .     .
CORR V11   .051  .082  .005 -.038 -.161 -.166 -.117 -.091 -.055 -.063 
1.000  .     .     .     .     .     .     .     .
CORR V12  -.040  .013 -.057 -.090 -.189 -.150 -.190 -.102 -.036 -.018  
.714 1.000  .     .     .     .     .     .     .
CORR V13  -.029 -.012 -.066 -.023 -.110 -.101 -.083 -.043  .055 -.003  
.379  .403 1.000  .     .     .     .     .     .
CORR V14   .559  .428  .581  .485  .433  .451  .470  .305  .345  .333  
.003 -.005  .043 1.000  .     .     .     .     .
CORR V15   .434  .322  .454  .424  .472  .418  .415  .205  .231  .241 -
.037  .007 -.062  .595 1.000  .     .     .     .
CORR V16   .375  .326  .431  .311  .253  .256  .225  .157  .151  .140  
.093  .022  .054  .457  .410 1.000  .     .     .
CORR V17  -.141 -.075 -.145 -.275 -.300 -.282 -.305 -.198 -.200 -.188  
.226  .216  .051 -.220 -.256 -.065 1.000  .     .
CORR V18  -.135 -.184 -.154 -.266 -.192 -.184 -.204 -.158 -.133 -.243  
.132  .119  .107 -.144 -.149 -.074  .529 1.000  .
CORR V19  -.167 -.142 -.145 -.327 -.234 -.209 -.251 -.288 -.298 -.220  
.147  .142  .076 -.179 -.202 -.083  .460  .572 1.000
;
PROC CALIS  COVARIANCE  CORR  RESIDUAL  MODIFICATION  ;
LINEQS
   V1 = LV1F1 F1 + E1,
   V2 = LV2F1 F1 + E2,
   V3 = LV3F1 F1 + E3,
   V4 = LV4F1 F1 + E4,
   V5 = LV5F2 F2 + E5,
   V6 = LV6F2 F2 + E6,
   V7 = LV7F2 F2 + E7,
   V8 = LV8F3 F3 + E8,
   V9 = LV9F3 F3 + E9,
   V10 = LV10F3 F3 + E10,
   V11 = LV11F4 F4 + E11,
   V12 = LV12F4 F4 + E12,
   V13 = LV13F4 F4 + E13,
   V14 = LV14F5 F5 + E14,
   V15 = LV15F5 F5 + E15,
   V16 = LV16F5 F5 + E16,
   V17 = LV17F6 F6 + E17,
   V18 = LV18F6 F6 + E18,
   V19 = LV19F6 F6 + E19;
STD
   F1 = 1,
   F2 = 1,
   F3 = 1,
   F4 = 1,
   F5 = 1,
   F6 = 1,
   E1-E19 = VARE1-VARE19;
COV
   F1 F2 = CF1F2,
   F1 F3 = CF1F3,
   F1 F4 = CF1F4,
   F1 F5 = CF1F5,
   F1 F6 = CF1F6,
   F2 F3 = CF2F3,
   F2 F4 = CF2F4,
   F2 F5 = CF2F5,
   F2 F6 = CF2F6,
   F3 F4 = CF3F4,
   F3 F5 = CF3F5,
   F3 F6 = CF3F6,
   F4 F5 = CF4F5,
   F4 F6 = CF4F6,
   F5 F6 = CF5F6;
VAR  V1-V19;
RUN;

---------------------------------------------------------
CHAPTER 6
---------------------------------------------------------

/* The following program is found on p. 358 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1     PROC CALIS  COVARIANCE  CORR  RESIDUAL  MODIFICATION ;
 2        LINEQS
 3           V1  = LV1F1  F1 + E1,
 4           V2  = LV2F1  F1 + E2,
 5           V3  =        F1 + E3,
 6           V5  = LV5F2  F2 + E5,
 7           V6  = LV6F2  F2 + E6,
 8           V7  =        F2 + E7,
 9           V8  = LV8F3  F3 + E8,
10           V9  = LV9F3  F3 + E9,
11           V10 =        F3 + E10,
12           V11 = LV11F4 F4 + E11,
13           V12 =        F4 + E12,
14           V13 = LV13F4 F4 + E13,
15           V14 =        F5 + E14,
16           V15 = LV15F5 F5 + E15,
17           V16 = LV16F5 F5 + E16,
18           V17 = LV17F6 F6 + E17,
19           V18 =        F6 + E18,
20           V19 = LV19F6 F6 + E19,
21           F1  = PF1F2 F2 + PF1F5 F5 + PF1F6 F6 + D1,
22           F2  = PF2F3 F3 + PF2F4 F4            + D2;
23        STD
24           E1-E3  = VARE1-VARE3,
25           E5-E19 = VARE5-VARE19,
26           F3-F6  = VARF3-VARF6,
27           D1-D2  = VARD1-VARD2;
28        COV
29           F3 F4 = CF3F4,
30           F3 F5 = CF3F5,
31           F3 F6 = CF3F6,
32           F4 F5 = CF4F5,
33           F4 F6 = CF4F6,
34           F5 F6 = CF5F6;
35        VAR  V1 V2 V3 V5-V19 ;
36        RUN;


/* The following program is found on p. 387 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

1     PROC CALIS  COVARIANCE  CORR  RESIDUAL  MODIFICATION ;
2        LINEQS
3           V1  = LV1F1  F1 + E1,
4           V2  = LV2F1  F1 + E2,
5           V3  = LV3F1  F1 + E3,
6           V5  = LV5F2  F2 + E5,
7           V6  = LV6F2  F2 + E6,
8           V7  = LV7F2  F2 + E7,
9     	    V8  = LV8F3  F3 + E8,
10          V9  = LV9F3  F3 + E9,
11          V10 = LV10F3 F3 + E10,
12          V11 = LV11F4 F4 + E11,
13          V12 = LV12F4 F4 + E12,
14          V13 = LV13F4 F4 + E13,
15          V14 = LV14F5 F5 + E14,
16          V15 = LV15F5 F5 + E15,
17          V16 = LV16F5 F5 + E16,
18          V17 = LV17F6 F6 + E17,
19          V18 = LV18F6 F6 + E18,
20          V19 = LV19F6 F6 + E19;
21       STD
22          F1 = 1,
23          F2 = 1,
24          F3 = 1,
25          F4 = 1,
26          F5 = 1,
27          F6 = 1,
28          E1-E3  = VARE1-VARE3,
29          E5-E19 = VARE5-VARE19;
30       COV
31          F1 F2 = 0,
32          F1 F3 = 0,
33          F1 F4 = 0,
34          F1 F5 = 0,
35          F1 F6 = 0,
36          F2 F3 = 0,
37          F2 F4 = 0,
38          F2 F5 = 0,
39          F2 F6 = 0,
40          F3 F4 = 0,
41          F3 F5 = 0,
42          F3 F6 = 0,
43          F4 F5 = 0,
44          F4 F6 = 0,
45          F5 F6 = 0;
46       VAR  V1 V2 V3 V5-V19 ;
47       RUN;


/* The following program is found on p. 398 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1     PROC CALIS  COVARIANCE  CORR  RESIDUAL  MODIFICATION ;
 2        LINEQS
 3           V1  = LV1F1  F1 + E1,
 4           V2  = LV2F1  F1 + E2,
 5           V3  =        F1 + E3,
 6           V5  = LV5F2  F2 + E5,
 7           V6  = LV6F2  F2 + E6,
 8           V7  =        F2 + E7,
 9           V8  = LV8F3  F3 + E8,
10           V9  = LV9F3  F3 + E9,
11           V10 =        F3 + E10,
12           V11 = LV11F4 F4 + E11,
13           V12 =        F4 + E12,
14           V13 = LV13F4 F4 + E13,
15           V14 =        F5 + E14,
16           V15 = LV15F5 F5 + E15,
17           V16 = LV16F5 F5 + E16,
18           V17 = LV17F6 F6 + E17,
19           V18 =        F6 + E18,
20           V19 = LV19F6 F6 + E19,
21           F1  = PF1F2 F2 + PF1F5 F5              + D1,
22           F2  = PF2F3 F3 + PF2F4 F4              + D2;
23        STD
24           E1-E3  = VARE1-VARE3,
25           E5-E19 = VARE5=VARE19,
26           F3-F6  = VARF3-VARF6,
27           D1-D2  = VARD1-VARD2;
28        COV
29           F3 F4 = CF3F4,
30           F3 F5 = CF3F5,
31           F3 F6 = CF3F6,
32           F4 F5 = CF4F5,
33           F4 F6 = CF4F6,
34           F5 F6 = CF5F6;
35        VAR  V1 V2 V3 V5-V19 ;
36        RUN;

/* The following program is found on p. 426 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1     PROC CALIS  COVARIANCE  CORR  RESIDUAL  MODIFICATION ;
 2        LINEQS
 3           V1  = LV1F1  F1 + E1,
 4           V2  = LV2F1  F1 + E2,
 5           V3  = LV3F1  F1 + E3,
 6           V11 = LV11F4 F4 + E11,
 7           V12 = LV12F4 F4 + E12,
 8           V13 = LV13F4 F4 + E13,
 9           V14 = LV14F5 F5 + E14,
10           V15 = LV15F5 F5 + E15,
11           V16 = LV16F5 F5 + E16,
12           V17 = LV17F6 F6 + E17,
13           V18 = LV18F6 F6 + E18,
14           V19 = LV19F6 F6 + E19;
15        STD
16           V5 = VARV5,
17           V8 = VARV8,
18           F1 = 1,
19           F4 = 1,
20           F5 = 1,
21           F6 = 1,
22           E1-E3 = VARE1-VARE3,
23           E11-E19 = VARE11-VARE19;
24        COV
25           F1 V5 = CF1V5,
26           F1 V8 = CF1V8,
27           F1 F4 = CF1F4,
28           F1 F5 = CF1F5,
29           F1 F6 = CF1F6,
30           V5 V8 = CV5V8,
31           V5 F4 = CV5F4,
32           V5 F5 = CV5F5,
33           V5 F6 = CV5F6,
34           V8 F4 = CV8F4,
35           V8 F5 = CV8F5,
36           V8 F6 = CV8F6,
37           F4 F5 = CF4F5,
38           F4 F6 = CF4F6,
39           F5 F6 = CF5F6;
40        VAR  V1-V3 V11-V19;
41        RUN;

/* The following program is found on p. 429 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1     PROC CALIS  COVARIANCE  CORR  RESIDUAL  MODIFICATION ;
 2        LINEQS
 3           V1  = LV1F1  F1 + E1,
 4           V2  = LV2F1  F1 + E2,
 5           V3  =        F1 + E3,
 6           V11 = LV11F4 F4 + E11,
 7           V12 =        F4 + E12,
 8           V13 = LV13F4 F4 + E13,
 9           V14 =        F5 + E14,
10           V15 = LV15F5 F5 + E15,
11           V16 = LV16F5 F5 + E16,
12           V17 = LV17F6 F6 + E17,
13           V18 =        F6 + E18,
14           V19 = LV19F6 F6 + E19,
15           F1  = PF1V5 V5 + PF1F5 F5 + PF1F6 F6 + D1,
16           V5  = PV5V8 V8 + PV5F4 F4            + E5;
17        STD
18           V8  = VARV8,
19           E1-E3   = VARE1-VARE3,
20           E5  = VARE5,
21           E11-E19 = VARE11-VARE19,
22           F4-F6  = VARF4-VARF6,
23           D1  = VARD1;
24        COV
25           V8 F4 = CV8F4,
26           V8 F5 = CV8F5,
27           V8 F6 = CV8F6,
28           F4 F5 = CF4F5,
29           F4 F6 = CF4F6,
30           F5 F6 = CF5F6;
31        VAR  V1 V2 V3 V5 V8 V11-V19 ;
32        RUN;

/* The following program is found on p. 433 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1     PROC CALIS  COVARIANCE  CORR  RESIDUAL  MODIFICATION ;
 2        LINEQS
 3           V1  = LV1F1  F1 + E1,
 4           V2  = LV2F1  F1 + E2,
 5           V3  = LV3F1  F1 + E3,
 6           V4  = LV4F2  F2 + E4,
 7           V5  = LV5F2  F2 + E5,
 8           V6  = LV6F2  F2 + E6,
 9           V7  = LV7F3  F3 + E7,
10           V8  = LV8F3  F3 + E8,
11           V9  = LV9F3  F3 + E9,
12           V10 = LV10F3 F3 + E10,
13           V11 = LV11F4 F4 + E11,
14           V12 = LV12F4 F4 + E12,
15           V13 = LV13F4 F4 + E13,
16           V14 = LV14F5 F5 + E14,
17           V15 = LV15F5 F5 + E15,
18           V16 = LV16F5 F5 + E16,
19           V17 = LV17F5 F5 + E17;
20        STD
21           E1-E17 = VARE1-VARE17,
22           F1 = 1,
23           F2 = 1,
24           F3 = 1,
25           F4 = 1,
26           F5 = 1;
27        COV
28           F1 F2 = CF1F2,
29           F1 F3 = CF1F3,
30           F1 F4 = CF1F4,
31           F1 F5 = CF1F5,
32           F2 F3 = CF2F3,
33           F2 F4 = CF2F4,
34           F2 F5 = CF2F5,
35           F3 F4 = CF3F4,
36           F3 F5 = CF3F5,
37           F4 F5 = CF4F5;
38        VAR  V1-V17 ;
39        RUN;

/* The following program is found on p. 435 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1     PROC CALIS  COVARIANCE  CORR  RESIDUAL  MODIFICATION ;
 2        LINEQS
 3           V1  = LV1F1  F1 + E1,
 4           V2  =        F1 + E2,
 5           V3  = LV3F1  F1 + E3,
 6           V4  = LV4F2  F2 + E4,
 7           V5  = LV5F2  F2 + E5,
 8           V6  =        F2 + E6,
 9           V7  = LV7F3  F3 + E7,
10           V8  =        F3 + E8,
11           V9  = LV9F3  F3 + E9,
12           V10 = LV10F3 F3 + E10,
13           V11 =        F4 + E11,
14           V12 = LV12F4 F4 + E12,
15           V13 = LV13F4 F4 + E13,
16           V14 =        F5 + E14,
17           V15 = LV15F5 F5 + E15,
18           V16 = LV16F5 F5 + E16,
19           F1  = PF1F2 F2 + PF1F3 F3 + PF1F5 F5 + D1,
20           F2  = PF2F3 F3 + PF2F4 F4 + PF2F5 F5 + D2;
21        STD
22           E1-E16 = VARE1-VARE16,
23           F3 = VARF3,
24           F4 = VARF4,
25           F5 = VARF5,
26           D1 = VARD1,
27           D2 = VARD2;
28        COV
29           F3 F4 = CF3F4,
30           F3 F5 = CF3F5,
31           F4 F5 = CF4F5;
32        VAR  V1-V16 ;
33        RUN;

---------------------------------------------------------
APPENDIX A.1
---------------------------------------------------------

/* The following program is found on p. 443 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

//SMITH JOB IPSYC,SMITH
          // EXEC SAS
          DATA D1;
             INPUT  SUBJECT  SATV  SATM;
          CARDS;
          1 520 490
          2 610 590
          3 470 450
          4 410 390
          5 510 460
          6 580 350
          ;
          PROC MEANS   DATA=D1;
             VAR  SATV  SATM;
             RUN;
          /*EOF


---------------------------------------------------------
APPENDIX A.2
---------------------------------------------------------

/* The following program is found on p. 456 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */


1       DATA D1;
 2          INPUT   #1   @1   (V1)      (1.)
 3                       @2   (V2)      (1.)
 4                       @3   (V3)      (1.)
 5                       @4   (V4)      (1.)
 6                       @5   (V5)      (1.)
 7                       @6   (V6)      (1.)
 8                       @7   (V7)      (1.)
 9                       @9   (AGE)     (2.)
10                       @12  (IQ)      (3.)
11                       @16  (NUMBER)  (2.)  ;
12       CARDS;
13       2234243 22  98  1
14       3424325 20 105  2
15       3242424 32  90  3
16       3242323  9 119  4
17       3232143  8 101  5
18       3242242 24 104  6
19       4343525 16 110  7
20       3232324 12  95  8
21       1322424 41  85  9
22       5433224 19 107 10
23       ;
24
25       PROC MEANS   DATA=D1;
26          RUN;

/* The following program is found on p. 464 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */


        2234243 22  98  1 M
        520 490
        3424325 20 105  2 M
        440 410
        3242424 32  90  3 F
        390 420
        3242323  9 119  4 F

        3232143  8 101  5 F

        3242242 24 104  6 M
        330 340
        4343525 16 110  7 F

        3232324 12  95  8 M

        1322424 41  85  9 M
        380 410
        5433224 19 107 10 F
        640 590


/* The following program is found on p. 469 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

    1        DATA D1;
    2           INPUT   #1   @1   (V1-V7)   (1.);
    3        CARDS;
    4        0010000
    5        1011111
    6        0001001
    7        0010000
    8        1100000
    9        ;
   10        PROC FREQ    DATA=D1;
   11           TABLES V1-V7;
   12           RUN;


/* The following program is found on p. 471 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1        DATA D1(TYPE=CORR) ;
 2          INPUT _TYPE_ $ _NAME_ $ V1-V6 ;
 3          LABEL
 4             V1 ='COMMITMENT'
 5             V2 ='SATISFACTION'
 6             V3 ='REWARDS'
 7             V4 ='COSTS'
 8             V5 ='INVESTMENTS'
 9             V6 ='ALTERNATIVES' ;
10        CARDS;
11        N      .    240     240     240     240     240     240
12        STD    .  2.3192  1.7744  1.2525  1.4086  1.5575  1.8701
13        CORR  V1  1.0000   .       .       .       .       .
14        CORR  V2   .6742  1.0000   .       .       .       .
15        CORR  V3   .5501   .6721  1.0000   .       .       .
16        CORR  V4  -.3499  -.5717  -.4405  1.0000   .       .
17        CORR  V5   .6444   .5234   .5346  -.1854  1.0000   .
18        CORR  V6  -.6929  -.4952  -.4061   .3525  -.3934  1.0000
19        ;

/* The following program is found on p. 474 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1        DATA D1(TYPE=COV) ;
 2          INPUT _TYPE_ $ _NAME_ $ V1-V6 ;
 3          LABEL
 4             V1 ='COMMITMENT'
 5             V2 ='SATISFACTION'
 6             V3 ='REWARDS'
 7             V4 ='COSTS'
 8             V5 ='INVESTMENTS'
 9             V6 ='ALTERNATIVES' ;
10        CARDS;
11        N      .    240     240     240     240     240     240
12        COV   V1 11.1284   .       .       .       .       .
13        COV   V2  5.6742  9.0054   .       .       .       .
14        COV   V3  4.5501  3.6721  6.8773   .       .       .
15        COV   V4 -3.3499 -5.5717 -2.4405 10.9936   .       .
16        COV   V5  7.6444  2.5234  3.5346 -4.1854  7.1185   .
17        COV   V6 -8.6329 -3.4952 -6.4061  4.3525 -5.3934  9.2144
18        ;


---------------------------------------------------------
APPENDIX A.3
---------------------------------------------------------

/* The following program is found on p. 504 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1   DATA D1;
 2      INFILE ÕVOLUNTEER.DATÕ ;
 3      INPUT   #1   @1   (V1-V7)   (1.)
 4                   @9   (AGE)     (2.)
 5                   @12  (IQ)      (3.)
 6                   @16  (NUMBER)  (2.)
 7                   @19  (SEX)     ($1.)
 8              #2   @1   (SATV)    (3.)
 9                   @5   (SATM)    (3.)  ;
10
11      DATA D2;
12         SET D1;
13
14      V3 = 6 - V3;
15      V6 = 6 - V6;
16      RESPONS = (V1 + V2 + V3) / 3;
17      TRUST   = (V4 + V5 + V6) / 3;
18      SHOULD = V7;
19
20      PROC MEANS   DATA=D2;
21         RUN;
22
23      DATA D3;
24         SET D2;
25         IF SEX = 'F';
26
27      PROC MEANS   DATA=D3;
28         RUN;
29
30      DATA D4;
31         SET D2;
32         IF SEX = 'M';
33
34      PROC MEANS   DATA=D4;
35         RUN;

/* The following program is found on p. 508 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1     DATA  A;
 2        INPUT  #1   @1  (NAME)  ($7.)
 3                    @10 (SATV)  (3.)
 4                    @14 (SATM)  (3.)  ;
 5     CARDS;
 6     John     520 500
 7     Sally    610 640
 8     Fred     490 470
 9     Emma     550 560
10     ;
11
12     DATA  B;
13        INPUT  #1   @1  (NAME)  ($7.)
14                    @11 (SATV)  (3.)
15                    @15 (SATM)  (3.)  ;
16     CARDS;
17     Susan     710 650
18     James     450 400
19     Cheri     570 600
20     Will      680 700
21     ;
22
23     DATA  C;
24        SET  A  B;
25
26     PROC PRINT  DATA=C
27        RUN;

/* The following program is found on p. 512 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1     DATA  D;
 2        INPUT  #1   @1  (NAME)   ($7.)
 3                    @9  (SOCSEC) (9.)
 4                    @19 (SATV)   (3.)
 5                    @23 (SATM)   (3.)  ;
 6     CARDS;
 7     John     232882121 520 500
 8     Sally    222773454 610 640
 9     Fred     211447653 490 470
10     Emma     222671234 550 560
11     ;
12
13
14     DATA  E;
15        INPUT  #1  @1   (NAME)   ($7.)
16                   @9   (SOCSEC) (9.)
17                   @19  (GPA)    (4.)  ;
18     CARDS;
19     John     232882121 2.70
20     Sally    222773454 3.25
21     Fred     211447653 2.20
22     Emma     222671234 2.50
23     ;
24
25     PROC SORT  DATA=D;
26        BY  SOCSEC;
27        RUN;
28
29     PROC SORT  DATA=E;
30        BY  SOCSEC;
31        RUN;
32
33     DATA  F;
34        MERGE  D  E;
35        BY  SOCSEC;
36        RUN;
37
38     PROC PRINT  DATA=F;
39        RUN;

---------------------------------------------------------
APPENDIX A.4
---------------------------------------------------------

/* The following program is found on p. 518 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1        DATA D1;
 2           INPUT   #1   @1   (RESNEEDY)   (1.)
 3                        @3   (SEX)        ($1.)
 4                        @5   (CLASS)      (1.)   ;
 5        CARDS;
 6        5 F 1
 7        4 M 1
 8        5 F 1
 9          F 1
10        4 F 1
11        4 F 2
12        1 F 2
13        4 F 2
14        1 F 3
15        5 M
16        4 F 4
17        4 M 4
18        3 F
19        4 F 5
20        ;
21        PROC MEANS   DATA=D1;
22           VAR RESNEEDY CLASS;
23           RUN;
24        PROC FREQ   DATA=D1;
25           TABLES SEX CLASS RESNEEDY;
26           RUN;
27        PROC PRINT   DATA=D1;
28           VAR RESNEEDY SEX CLASS;
29           RUN;

/* The following program is found on p. 533 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1           DATA D1;
 2              INPUT   #1   @1   (SUBJECT)   (2.)
 3                           @4   (AGE)       (2.)   ;
 4           CARDS;
 5            1 72
 6            2 69
 7            3 75
 8            4 71
 9            5 71
10            6 73
11            7 70
12            8 67
13            9 71
14           10 72
15           11 73
16           12 68
17           13 69
18           14 70
19           15 70
20           16 71
21           17 74
22           18 72
23           ;
24           PROC UNIVARIATE   DATA=D1   NORMAL   PLOT;
25              VAR AGE;
26              ID SUBJECT;
27              RUN;

---------------------------------------------------------
APPENDIX A.5
---------------------------------------------------------

/* The following program is found on p. 553 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

 1     DATA D1;
 2        INPUT   #1   @1   (COMMIT)   (2.)
 3                     @4   (SATIS)    (2.)
 4                     @7   (INVEST)   (2.)
 5                     @10  (ALTERN)   (2.)   ;
 6     CARDS;
 7     20 20 28 21
 8     10 12  5 31
 9     30 33 24 11
10      8 10 15 36
11     22 18 33 16
12     31 29 33 12
13      6 10 12 29
14     11 12  6 30
15     25 23 34 12
16     10  7 14 32
17     31 36 25  5
18      5  4 18 30
19     31 28 23  6
20      4  6 14 29
21     36 33 29  6
22     22 21 14 17
23     15 17 10 25
24     19 16 16 22
25     12 14 18 27
26     24 21 33 16
27     ;
28     PROC PLOT   DATA=D1;
29        PLOT COMMIT*SATIS;
30        RUN;


---------------------------------------------------------
APPENDIX B
---------------------------------------------------------

/* The following program is found on p. 565 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

DATA D1;
   INPUT   #1  @1  (V1-V6)   (1.) ;
CARDS;
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


/* 10Jun04 - The data set that appears below has been */
/* corrected. If you analyze the data set provided    */
/* here, your results should match the SAS Output     */
/* that appears in Chapter 2.  Changed 5th data line  */
/* from 551664 4 to 551666 4.                         */


 
/* The following program is found on p. 567 of       */
/* "A Step-by-Step Approach to Using the SAS System  */
/* for Factor Analysis and Structural Equation       */
/* Modeling."                                        */

DATA D1;
   INPUT   #1  @1  (V1-V6)   (1.)
               @8  (COMMIT)  (2.) ;
CARDS;
776122 24
776111 28
111425  4
222633 24
551666  4
666524  4
633112 24
766212 23
454444 17
111332  8
444343 21
556212 20
543332 11
677222 27
666234 15
557322  6
555221 18
544111 17
424232 28
445435 13
767232 13
444422  8
653211 15
555323 16
655123 17
221121 11
666421 20
454332  9
655321 25
444332 12
433222 27
777314 16
555212  7
443221  4
243334 11
666111 15
423412 11
555222 18
223332  8
333335 13
445433 22
444323 12
455556 22
444112 17
334445 12
444321 16
655222 15
433344 15
557332 20
655222 13
;



