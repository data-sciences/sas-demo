***********************************************************************
This file contains all programs and data sets from the book, "SAS
Software Solutions: Basic Data Processing" by Thomas Miron.

Copyright (C) 1993 by SAS Institute Inc., Cary, NC, USA.

SAS(R) is a registered trademark of SAS Institute Inc. 

SAS Institute does not assume responsibility for the accuracy of any
material presented in this file.

***********************************************************************

---------
CHAPTER 1
---------

/* Program 1 taken from p. 15 of SAS Software Solutions  */

DATA SALES;

   LENGTH NAME $ 20;

   INPUT NAME $ CUSTNUM $ AMOUNT;

CARDS;
Thomas 30450 3670.45
Thomas 40990 958.89
Thomas 30450 1730.45
Thomas 35118 7236.03
Wu 87764 9761.00
Wu 74410 756.00
Walters 11833 5723.12
Christopherson 45280 3812.78
Christopherson 45280 1339.00
Christopherson 45280 123.78
;

RUN;

TITLE 'Sales List';

PROC PRINT DATA=SALES;
   SUM AMOUNT;
RUN;



---------
CHAPTER 2
---------

/* Program 2, taken from p. 24 of SAS Software Solutions  */

FILENAME PATDATA 'c:\clinic\visits.dat';

LIBNAME MYLIB 'c:\sasdata';

DATA MYLIB.PATIENTS;

   FORMAT VISITDAY DATE7.;

   INFILE PATDATA;

   INPUT
         @1   VISITDAY  MMDDYY8.
         @10  PATIENTS  3.
         @15  CATEGORY  $6.
   ;

RUN;

TITLE 'Patient Count';

PROC PRINT DATA=MYLIB.PATIENTS;
   SUM PATIENTS;
RUN;



---------
CHAPTER 3
---------

/* PAYMENTS.JULAUG data set from p. 32 of SAS Software Solutions  */
    
       OBS        DATE    CUSTNUM    CUSTNAME                PAYMENT

         1    08/12/93     83020     EXCLUSIVE PRINTS        1340.32
         2    07/01/93     91109     SOUTHEAST SUPPLY        7645.01
         3    06/28/93     84404     HANSEN DEVELOPMENT      3901.56
         4    08/11/93     87811     B & B DESIGN             765.00
         5    08/26/93     88028     SUNTECH SOLAR            112.37
         6    08/21/93     90016     HOLMES ASSOC.           5010.96
         7    07/30/93     93719     CHAVEZ PUBLISHING       2654.25
         8    08/31/93     89953     THE HOLWELL GROUP      10276.45
         9    08/22/93     85611     EL CENTRO SERVICES       652.00
        10    08/11/93     88338     BAKER CREATIVE          1246.46
        11    07/06/93     90901     SHELLY & KEATS INC.      912.10




/* Program 3 from p. 33 of SAS Software Solutions */

PROC FSEDIT DATA=PAYMENTS.JULAUG;
RUN;



---------
CHAPTER 4
---------

/* SALEDEPT.SALES data set from p. 44 of SAS Software Solutions */
                                                  
              OBS       DATE    CUSTNUM    REGION     AMOUNT

                1    11FEB93    991234      WEST     1733.33
                2    22JAN93    967456      WEST     1304.50
                3    09FEB93    058111      EAST     1086.54
                4    15FEB93    991234      WEST     2245.93
                5    19FEB93    958111      WEST      750.12
                6    05FEB93    910023      WEST      809.66
                7    05JAN93    030912      EAST     2141.89
                8    25JAN93    091234      EAST      934.81
                9    02MAR93    058111      EAST     1930.83
               10    10MAR93    010023      EAST     2505.77
               11    19JAN93    922010      WEST     1996.44
               12    07FEB93    078810      EAST      769.48
               13    31DEC92    991234      WEST     1580.69
               14    22MAR93    978810      WEST     1517.64
               15    14JAN93    958111      WEST      543.76
               16    12JAN93    991234      WEST     2548.00
               17    07FEB93    922010      WEST     1655.32
               18    30MAR93    091234      EAST     2460.98
               19    26MAR93    910023      WEST     1356.79
               20    20MAR93    091234      EAST      524.77
               21    26JAN93    067456      EAST      386.67
               22    03JAN93    922010      WEST      915.82
               23    10FEB93    991234      WEST      936.08
               24    30JAN93    091234      EAST     1218.94
               25    12MAR93    022010      EAST      691.98
               26    26FEB93    991234      WEST     2927.13
               27    27MAR93    991234      WEST     1626.77
               28    15FEB93    991234      WEST     1002.52
               29    19MAR93    910023      WEST     2608.15
               30    25FEB93    911003      WEST     1244.20



/*  Program 4 from p. 45 of SAS Software Solutions  */

PROC SORT DATA=SALEDEPT.SALES;
   BY REGION AMOUNT;
RUN;

TITLE 'Regional Sales';

PROC PRINT DATA=SALEDEPT.SALES;
   BY REGION;
   FORMAT AMOUNT DOLLAR11.2;
   VAR CUSTNUM AMOUNT;
   SUM AMOUNT;
RUN;



---------
CHAPTER 5
---------

/*  QCDATA.REJECTS data set from p. 56 of SAS Software Solutions  */

                            OBS    HOUR    LINE

                              1      0       1
                              2      0       2
                              3      1       3
                              4      2       3
                              5      3       1
                              6      3       2
                              7      3       3
                              8      4       3
                              9      5       1
                             10      8       1
                             11      9       3
                             12     10       1
                             13     10       2
                             14     10       3
                             15     11       2
                             16     11       3
                             17     12       3
                             18     13       1
                             19     13       3
                             20     14       1
                             21     15       2
                             22     15       3
                             23     16       2
                             24     17       1
                             25     18       1
                             26     18       3
                             27     19       2
                             28     19       3
                             29     20       1
                             30     20       2
                             31     22       1
                             32     22       2
                             33     23       3





/*  Program 5 from p. 57 of SAS Software Solutions  */

PROC FREQ DATA=QCDATA.REJECTS;
   TITLE 'Mold Reject Count';
   TABLE LINE;
RUN;



---------
CHAPTER 6
---------

/*  ACCOUNT.EQUIPMNT data set from p. 64 of SAS Software Solutions  */



                   OBS     DEPT      EQUIP       AMOUNT

                     1    MARKET     PRINTER    1933.55
                     2    MARKET     PC         2485.17
                     3    MARKET     DISK       1431.80
                     4    MARKET     PRINTER    2372.60
                     5    MARKET     PC         3960.88
                     6    MARKET     DISK       1165.10
                     7    MARKET     MEMORY      357.00
                     8    MANUFAC    PC         2056.59
                     9    MANUFAC    DISK        504.94
                    10    ADMIN      PC         2133.54
                    11    ADMIN      DISK        693.33
                    12    ADMIN      MEMORY      435.00
                    13    MARKET     PRINTER    1295.51
                    14    MARKET     PC         2264.53
                    15    ADMIN      PRINTER    1462.26
                    16    ADMIN      DISK        927.08
                    17    ADMIN      MEMORY      353.00
                    18    MANUFAC    PRINTER    2331.88
                    19    MANUFAC    PC         3048.02
                    20    MANUFAC    MEMORY      544.00
                    21    MANUFAC    PRINTER    1609.84
                    22    MANUFAC    PC         5849.14
                    23    MANUFAC    DISK        541.68
                    24    MARKET     PRINTER     823.54
                    25    MARKET     PC         4365.36
                    26    MARKET     DISK        677.05
                    27    MARKET     MEMORY      340.00
                    28    MARKET     PRINTER    2451.09
                    29    MARKET     DISK       1442.65
                    30    MARKET     MEMORY      394.00
                    31    ADMIN      PRINTER    1593.22
                    32    ADMIN      PC         4697.41
                    33    ADMIN      DISK        944.09
                    34    ADMIN      MEMORY      397.00
                    35    MANUFAC    PC         5944.24
                    36    MANUFAC    DISK       1281.90
                    37    MANUFAC    MEMORY      488.00


/*  Program 6 from p. 66 of SAS Software Solutions  */

PROC MEANS DATA=ACCOUNT.EQUIPMNT SUM;
   TITLE 'Departmental Equipment Purchases';
   CLASS DEPT EQUIP;
   VAR AMOUNT;
RUN;



---------
CHAPTER 7
---------

/*  AGDEPT.YIELDS data set from pp. 74-75 of SAS Software Solutions  */

                     OBS    COUNTY       PLOT    YIELD

                       1    SAUK          101     181
                       2    SAUK          102     176
                       3    SAUK          103      85
                       4    SAUK          104     106
                       5    SAUK          105     149
                       6    SAUK          106     187
                       7    SAUK          107     186
                       8    SAUK          108     162
                       9    SAUK          109     126
                      10    SAUK          110     107
                      11    ST. CROIX     101      87
                      12    ST. CROIX     102     179
                      13    ST. CROIX     103      96
                      14    ST. CROIX     104     127
                      15    ST. CROIX     105     154
                      16    ST. CROIX     106      86
                      17    ST. CROIX     107     107
                      18    ST. CROIX     108     139
                      19    ST. CROIX     109     148
                      20    ST. CROIX     110     177
                      21    DANE          101     162
                      22    DANE          102      91
                      23    DANE          103     166
                      24    DANE          104     136
                      25    DANE          105      97
                      26    DANE          106      90
                      27    DANE          107      91
                      28    DANE          108     104
                      29    DANE          109      91
                      30    DANE          110     114
                      31    COLUMBIA      101     174
                      32    COLUMBIA      102     189
                      33    COLUMBIA      103     117
                      34    COLUMBIA      104     164
                      35    COLUMBIA      105     135
                      36    COLUMBIA      106     139
                      37    COLUMBIA      107     167
                      38    COLUMBIA      108     123
                      39    COLUMBIA      109      93
                      40    COLUMBIA      110     167
                      41    CLARK         101      90
                      42    CLARK         102     140
                      43    CLARK         103     165
                      44    CLARK         104     118
                      45    CLARK         105      88
                      46    CLARK         106     185
                      47    CLARK         107     144
                      48    CLARK         108     123
                      49    CLARK         109      93
                      50    CLARK         110     134


/*  Program 7 from p. 76 of SAS Software Solutions  */

PROC MEANS DATA=AGDEPT.YIELDS MEAN MAXDEC=1;
   TITLE 'Average County Yields';
   WHERE COUNTY IN('SAUK', 'DANE', 'COLUMBIA');
   CLASS COUNTY;
   VAR YIELD;
RUN;



---------
CHAPTER 8
---------

/*  Complete WEATHER.PRECIP data set.  Partial data set appears  */
/*  on p. 82 of SAS Software Solutions.                          */

                         OBS       DATE    PERCIP

                           1    01JAN91     0.80
                           2    03JAN91     0.28
                           3    08JAN91     0.99
                           4    10JAN91     0.11
                           5    11JAN91     0.76
                           6    14JAN91     0.24
                           7    23JAN91     0.93
                           8    24JAN91     0.40
                           9    27JAN91     0.35
                          10    29JAN91     0.56
                          11    07FEB91     0.86
                          12    08FEB91     0.72
                          13    12FEB91     0.82
                          14    18FEB91     0.76
                          15    21FEB91     0.34
                          16    02MAR91     1.23
                          17    04MAR91     0.53
                          18    15MAR91     0.68
                          19    19MAR91     0.89
                          20    20MAR91     0.22
                          21    21MAR91     0.06
                          22    23MAR91     0.82
                          23    30MAR91     0.71
                          24    08APR91     0.46
                          25    09APR91     0.33
                          26    11APR91     0.97
                          27    13APR91     0.12
                          28    24APR91     0.11
                          29    29APR91     0.69
                          30    30APR91     0.73
                          31    01MAY91     0.85
                          32    07MAY91     0.65
                          33    11MAY91     0.32
                          34    16MAY91     0.80
                          35    23MAY91     0.17
                          36    01JUN91     0.43
                          37    06JUN91     0.43
                          38    07JUN91     0.89
                          39    09JUN91     0.44
                          40    11JUN91     0.78
                          41    19JUN91     0.98
                          42    22JUN91     0.89
                          43    29JUN91     0.02
                          44    01JUL91     0.79
                          45    12JUL91     0.51
                          46    14JUL91     0.27
                          47    04AUG91     0.42
                          48    07AUG91     0.82
                          49    11AUG91     0.57
                          50    17AUG91     0.03
                          51    20AUG91     0.62
                          52    27AUG91     0.68
                          53    30AUG91     0.88
                          54    01SEP91     0.83
                          55    02SEP91     0.74
                          56    03SEP91     0.70
                          57    05SEP91     0.57
                          58    06SEP91     0.34
                          59    16SEP91     0.64
                          60    17SEP91     0.25
                          61    18SEP91     0.02
                          62    19SEP91     0.08
                          63    20SEP91     0.16
                          64    02OCT91     0.67
                          65    06OCT91     0.69
                          66    07OCT91     0.09
                          67    08OCT91     0.31
                          68    12OCT91     0.57
                          69    16OCT91     0.78
                          70    20OCT91     0.28
                          71    31OCT91     0.70
                          72    02NOV91     0.56
                          73    03NOV91     0.53
                          74    08NOV91     0.42
                          75    13NOV91     0.20
                          76    15NOV91     0.68
                          77    25NOV91     0.23
                          78    28NOV91     0.50
                          79    29NOV91     0.91
                          80    30NOV91     0.74
                          81    03DEC91     0.90
                          82    17DEC91     0.24
                          83    18DEC91     0.78
                          84    30DEC91     0.30



/*  Program 8 from p. 84 of SAS Software Solutions  */

PROC MEANS DATA=WEATHER.PRECIP SUM MAXDEC=2;
   TITLE 'Monthly Precipitation';
   FORMAT DATE MONYY5.;
   CLASS DATE;
   VAR PRECIP;
RUN;

 


---------
CHAPTER 9
---------

/* SCORES.MATH8 data set from pp. 92-93 of SAS Software Solutions */

   OBS   SCHOOL           SCORE

     1   NORTH            95
     2   NORTH            79
     3   NORTH            53
     4   NORTH            76
     5   NORTH            67
     6   NORTH            90
     7   NORTH            86
     8   NORTH            71
     9   NORTH            75
    10   NORTH            73
    11   NORTH            70
    12   NORTH            58
    13   NORTH            96
    14   CENTRAL          84
    15   CENTRAL          58
    16   CENTRAL          55
    17   CENTRAL          55
    18   CENTRAL          78
    19   CENTRAL          76
    20   CENTRAL          80
    21   CENTRAL          66
    22   CENTRAL          54
    23   CENTRAL          76
    24   CENTRAL          84
    25   CENTRAL          90
    26   CENTRAL          81
    27   CENTRAL          99
    28   CENTRAL          66
    29   CENTRAL          69
    30   CENTRAL          87
    31   CENTRAL          53
    32   CENTRAL          76
    33   CENTRAL          67
    34   CENTRAL          65
    35   CENTRAL          85
    36   CENTRAL          85
    37   CENTRAL          51
    38   RIVERSIDE        68
    39   RIVERSIDE        78
    40   RIVERSIDE        98
    41   RIVERSIDE        72
    42   RIVERSIDE        84
    43   RIVERSIDE        62
    44   RIVERSIDE        80
    45   RIVERSIDE        99
    46   RIVERSIDE        59
    47   RIVERSIDE        76
    48   RIVERSIDE        90
    49   RIVERSIDE        74
    50   RIVERSIDE        92
    51   RIVERSIDE        85
    52   RIVERSIDE        82
    53   RIVERSIDE        62
    54   RIVERSIDE        69
    55   RIVERSIDE        83
    56   RIVERSIDE        64
    57   RIVERSIDE        82
    58   RIVERSIDE        79


/*  Program 9 from p. 95 of SAS Software Solutions  */

PROC FORMAT;
  VALUE SCRFMT
       0-74   = 'Below Average'
       75-85  = 'Average'
       86-100 = 'Above Average';
RUN;

PROC SORT DATA=SCORES.MATH8;
   BY SCHOOL;
RUN;

PROC FREQ DATA=SCORES.MATH8;
    TITLE '8th Grade Math Test Results';
    FORMAT SCORE SCRFMT.;
    BY SCHOOL;
    TABLE SCORE;
RUN;



----------
CHAPTER 10
----------

/*  RESULTS.EX91102 data set from p. 102 of SAS Software Solutions  */

                           OBS    COUNT    HOUR

                             1     118       1
                             2     165       2
                             3     234       3
                             4     310       4
                             5     347       5
                             6     355       6
                             7     404       7
                             8     479       8
                             9     519       9
                            10     536      10



/*  RESULTS.EX91103 data set from p. 103 of SAS Software Solutions  */

                           OBS    COUNT    HOUR

                             1     220       1
                             2     287       2
                             3     334       3
                             4     387       4
                             5     415       5
                             6     486       6
                             7     494       7
                             8     584       8
                             9     644       9
                            10     706      10



/*  RESULTS.EX91104 data set from p. 103 of SAS Software Solutions  */

                           OBS    COUNT    HOUR

                             1      88       1
                             2     135       2
                             3     234       3
                             4     271       4
                             5     293       5
                             6     373       6
                             7     388       7
                             8     487       8
                             9     560       9
                            10     586      10

 

/*  Program 10 from p. 105 of SAS Software Solutions  */

DATA RESULTS.ALLEXPER;

   SET RESULTS.EX91102(IN=IN102)
       RESULTS.EX91103(IN=IN103)
       RESULTS.EX91104(IN=IN104);

   SELECT;
      WHEN (IN102 = 1) EXPER = 'FROM102';
      WHEN (IN103 = 1) EXPER = 'FROM103';
      WHEN (IN104 = 1) EXPER = 'FROM104';
   END;

RUN;

PROC PRINT DATA=RESULTS.ALLEXPER;
   TITLE 'Bacteria Growth';
   TITLE2 'Experimental Results';
RUN;



----------
CHAPTER 11
----------

/*  SDEPT.SHIPLOG data set from p. 112 of SAS Software Solutions  */

             OBS    SHIPDATE    CUSTNUM    ORDERNUM     AMOUNT

               1    14JUL93      81883       54880     1684.49
               2    01AUG93      22090       54881     4871.26
               3    18JUL93      81883       54882     2226.68
               4    27JUL93      76341       54884      981.37
               5    18JUL93      81883       54894     1266.57
               6    18JUL93      81883       54895     8598.95
               7    15JUL93      76341       54902     5138.64
               8    19JUL93      81883       54903      602.92
               9    17JUL93      97123       54905     3489.04
              10    09JUL93      76341       54906     4292.98
              11    03AUG93      76341       54908     6281.53
              12    27JUL93      97123       54909     6669.70
              13    04AUG93      97123       54911     9453.24
              14    15JUL93      76341       54916     9598.68
              15    05AUG93      76341       54919     2041.23
              16    19JUL93      22090       54920     2012.79
              17    27JUL93      22090       54926     4806.97
              18    30JUL93      76341       54927     2870.91
              19    01AUG93      76341       54929     5942.01
              20    08JUL93      22090       54930     4876.46
              21    11JUL93      76341       54932     5362.34
              22    13JUL93      81883       54933     4492.34
              23    17JUL93      97123       54935     8005.08
              24    02AUG93      81883       54936     7086.81
              25    03AUG93      97123       54937     1667.25
              26    31JUL93      97123       54938     3915.88





/*  Program 11 from p. 113 of SAS Software Solutions  */

DATA SDEPT.SHIPLOG;
   SET SDEPT.SHIPLOG;
   IF ORDERNUM='54895' THEN SHIPDATE=SHIPDATE+7;
RUN;

PROC PRINT DATA=SDEPT.SHIPLOG;
   TITLE 'Corrected Shipped Orders';
RUN;




----------
CHAPTER 12
----------

/*  SLEUTH.BOOKS data set from pp. 120-121 of SAS Software Solutions  */

    OBS    AUTHOR                     TITLE

      1    ALLBEURY, TED              THE LANTERN NETWORK
      2    ALLBEURY, TED              THE LANTERN NETWORK
      3    BARNES, LINDA              THE SNAKE TATTOO
      4    BOYER, RICK                THE DAISY DUCKS
      5    BOYER, RICK                THE DAISY DUCKS
      6    BURKE, JAMES LEE           NEON RAIN
      7    BURNS, REX                 THE KILLING ZONE
      8    CAMPBELL, ROBERT           HIP-DEEP IN ALLIGATORS
      9    CAUNITZ, WILLIAM J.        BLACK SAND
     10    COLLINS, MICHAEL           CASTRATO
     11    DOBYNS, STEPHEN            SARATOGA HEADHUNTER
     12    FREEMANTLE, BRIAN          THE CHOICE OF EDDIE FRANKS
     13    FRIEDMAN, BRUCE JAY        THE DICK
     14    GAULT, WILLIAM CAMPBELL    THE CHICANO WAR
     15    GILBERT, MICHAEL           PAINT, GOLD & BLOOD
     16    GILBERT, MICHAEL           TROUBLE
     17    GRAY, MALCOLM              A MATTER OF RECORD
     18    HEALY, JEREMIAH            THE STAKED GOAT
     19    HILLERMAN, TONY            COYOTE WAITS
     20    HILLERMAN, TONY            TALKING GOD
     21    KENNEALY, JERRY            POLO ANYONE
     22    KNOTT, FREDERICK           DIAL "M" FOR MURDER
     23    LATHEN, EMMA               SOMETHING IN THE AIR
     24    LEWIS, ROY HARLEY          MIRACLES TAKE A LITTLE LONGER
     25    LINDSEY, DAVID L.          HEAT FROM ANOTHER SUN
     26    LUTZ, JOHN                 RIDE THE LIGHTNING
     27    LUTZ, JOHN                 SHADOWTOWN
     28    LUTZ, JOHN                 SHADOWTOWN
     29    LYONS, ARTHUR              OTHER PEOPLE'S MONEY
     30    MARSHALL, WILLIAM          HEAD FIRST
     31    MARSHALL, WILLIAM          THE FAR AWAY MAN
     32    MARSHALL, WILLIAM          WHISPER
     33    MAXWELL, A.E.              JUST ENOUGH LIGHT TO KILL
     34    MAXWELL, THOMAS            KISS ME ONCE
     35    MILNE, JOHN                THE MOODY MAN
     36    MULLER, MARCIA             THERE'S SOMETHING IN A SUNDAY
     37    Mac LEOD, CHARLOTTE        THE SILVER GHOST
     38    Mc BRIDE, BILL (ED.)       IDENTIFICATION OF FIRST EDITIONS
     39    Mc DONALD, JOHN D.         A KEY TO THE SUITE
     40    Mc DONALD, JOHN D.         NO DEADLY DRUG
     41    OLIVER, ANTHONY            COVER-UP
     42    PARKER, ROBERT B.          PALE KINGS AND PRINCES
     43    PARRISH, FRANK             DEATH IN THE RAIN
     44    RISENHOOVER, C.C.          CHILD STALKER
     45    SANGSTER, JIMMY            SNOWBALL
     46    SIMON, ROGER L.            RAISING THE DEAD
     47    SINGER, SHELLY             SPIT IN THE OCEAN
     48    SPENCER, ROSS H.           DEATH WORE GLOVES
     49    STARK, RICHARD             THE MOURNER
     50    TURNBULL, PETER            CONDITION PURPLE
     51    UHNAK, DOROTHY             VICTIMS
     52    UHNAK, DOROTHY             VICTIMS
     53    VACHSS, ANDREW             HARD CANDY
     54    WALKER, WALTER             THE IMMEDIATE PROSPECT OF BEING HANGED
     55    WALKER, WALTER             THE IMMEDIATE PROSPECT OF BEING HANGED
     56    WALKER, WALTER             THE TWO DUDE DEFENSE
     57    WESTLAKE, DONALD           SACRED MONSTER
     58    WILLEFORD, CHARLES         THE WAY WE DIE NOW





/*  Program 12 from p. 122 of SAS Software Solutions  */

DATA LASTONE;
   SET SLEUTH.BOOKS;
      BY AUTHOR;
   IF FIRST.AUTHOR=1 AND LAST.AUTHOR=1;
RUN;

TITLE 'Only One Book Left by These Authors';

PROC PRINT DATA=LASTONE;
RUN;




----------
CHAPTER 13
----------

/*  REDCLIFF.VISITS data set from p. 130 of SAS Software Solutions  */



                           OBS    MONTH    COUNT

                             1     JAN       152
                             2     FEB       140
                             3     MAR       278
                             4     APR       876
                             5     MAY      2578
                             6     JUN      5870
                             7     JUL      6563
                             8     AUG      6832
                             9     SEP      5027
                            10     OCT      2197
                            11     NOV       317
                            12     DEC       182




 /*  Program 13 from p. 132 of SAS Software Solutions  */

PROC FREQ DATA=REDCLIFF.VISITS ORDER=DATA;
   TITLE 'Percentage of Redcliff Visitors By Month';
   WEIGHT COUNT;
   TABLE MONTH;
RUN;




----------
CHAPTER 14
----------

/*  Complete AGLAB.GROW1 data set, which appears in part   */
/*  on p. 141 of SAS Software Solutions                    */

                 OBS    TRAIL    SOL1    SOL2    GROWRATE

                   1      1       0.0     0.0      0.13
                   2      2       0.0     0.0      0.40
                   3      3       0.0     0.0      0.22
                   4      1       0.0     0.1      0.30
                   5      2       0.0     0.1      0.24
                   6      3       0.0     0.1      0.88
                   7      1       0.0     0.2      0.57
                   8      2       0.0     0.2      0.06
                   9      3       0.0     0.2      0.26
                  10      1       0.0     0.3      0.43
                  11      2       0.0     0.3      0.85
                  12      3       0.0     0.3      0.72
                  13      1       0.0     0.4      0.87
                  14      2       0.0     0.4      0.83
                  15      3       0.0     0.4      0.61
                  16      1       0.0     0.5      0.32
                  17      2       0.0     0.5      0.04
                  18      3       0.0     0.5      0.59
                  19      1       0.1     0.0      0.11
                  20      2       0.1     0.0      0.64
                  21      3       0.1     0.0      0.85
                  22      1       0.1     0.1      0.71
                  23      2       0.1     0.1      0.36
                  24      3       0.1     0.1      0.34
                  25      1       0.1     0.2      0.31
                  26      2       0.1     0.2      0.28
                  27      3       0.1     0.2      0.23
                  28      1       0.1     0.3      0.33
                  29      2       0.1     0.3      0.31
                  30      3       0.1     0.3      0.95
                  31      1       0.1     0.4      0.94
                  32      2       0.1     0.4      0.35
                  33      3       0.1     0.4      0.79
                  34      1       0.1     0.5      0.29
                  35      2       0.1     0.5      0.26
                  36      3       0.1     0.5      0.64
                  37      1       0.2     0.0      0.98
                  38      2       0.2     0.0      0.38
                  39      3       0.2     0.0      0.44
                  40      1       0.2     0.1      0.12
                  41      2       0.2     0.1      0.34
                  42      3       0.2     0.1      0.40
                  43      1       0.2     0.2      0.99
                  44      2       0.2     0.2      0.55
                  45      3       0.2     0.2      0.28
                  46      1       0.2     0.3      0.56
                  47      2       0.2     0.3      0.12
                  48      3       0.2     0.3      0.45
                  49      1       0.2     0.4      0.48
                  50      2       0.2     0.4      0.48
                  51      3       0.2     0.4      0.49
                  52      1       0.2     0.5      0.17
                  53      2       0.2     0.5      0.80
                  54      3       0.2     0.5      0.56
                  55      1       0.3     0.0      0.06
                  56      2       0.3     0.0      0.74
                  57      3       0.3     0.0      0.39
                  58      1       0.3     0.1      0.32
                  59      2       0.3     0.1      0.29
                  60      3       0.3     0.1      0.54
                  61      1       0.3     0.2      0.96
                  62      2       0.3     0.2      0.14
                  63      3       0.3     0.2      0.21
                  64      1       0.3     0.3      0.87
                  65      2       0.3     0.3      0.46
                  66      3       0.3     0.3      0.56
                  67      1       0.3     0.4      0.79
                  68      2       0.3     0.4      0.91
                  69      3       0.3     0.4      0.33
                  70      1       0.3     0.5      0.39
                  71      2       0.3     0.5      0.63
                  72      3       0.3     0.5      0.54
                  73      1       0.4     0.0      0.82
                  74      2       0.4     0.0      0.63
                  75      3       0.4     0.0      0.51
                  76      1       0.4     0.1      0.79
                  77      2       0.4     0.1      0.87
                  78      3       0.4     0.1      0.97
                  79      1       0.4     0.2      0.19
                  80      2       0.4     0.2      0.20
                  81      3       0.4     0.2      0.68
                  82      1       0.4     0.3      0.30
                  83      2       0.4     0.3      0.24
                  84      3       0.4     0.3      0.18
                  85      1       0.4     0.4      0.10
                  86      2       0.4     0.4      0.93
                  87      3       0.4     0.4      0.06
                  88      1       0.4     0.5      0.21
                  89      2       0.4     0.5      0.81
                  90      3       0.4     0.5      0.68
                  91      1       0.5     0.0      0.68
                  92      2       0.5     0.0      0.04
                  93      3       0.5     0.0      0.91
                  94      1       0.5     0.1      0.43
                  95      2       0.5     0.1      0.59
                  96      3       0.5     0.1      0.85
                  97      1       0.5     0.2      0.60
                  98      2       0.5     0.2      0.59
                  99      3       0.5     0.2      0.30
                 100      1       0.5     0.3      0.57
                 101      2       0.5     0.3      0.66
                 102      3       0.5     0.3      0.69
                 103      1       0.5     0.4      0.74
                 104      2       0.5     0.4      0.83
                 105      3       0.5     0.4      0.94
                 106      1       0.5     0.5      0.48
                 107      2       0.5     0.5      0.48
                 108      3       0.5     0.5      0.70




/*  Program 14 from p. 142 of SAS Software Solutions  */

PROC TABULATE DATA=AGLAB.GROW1 FORMAT=4.2;
   TITLE 'Growth Rate Table';
   LABEL SOL1='Solution 1 Concentration'
         SOL2='Solution 2 Concentration';
   CLASS SOL1 SOL2;
   VAR GROWRATE;
   TABLE SOL1, SOL2*GROWRATE=' '*MEAN=' ';
RUN;



----------
CHAPTER 15
----------

/*  AUTODIV.CLAIMS data set from p. 151 of SAS Software Solutions  */

            OBS       DATE    CATEGORY      REGION     AMOUNT

              1    04JAN93    INJURY        NORTH     14454.19
              2    09JAN93    NON-INJURY    SOUTH      6362.79
              3    09JAN93    INJURY        NORTH     10681.64
              4    10JAN93    INJURY        SOUTH     10780.58
              5    12JAN93    NON-INJURY    NORTH      8375.73
              6    19JAN93    NON-INJURY    WEST       7838.12
              7    23FEB93    INJURY        SOUTH      7797.22
              8    26FEB93    INJURY        SOUTH      3743.85
              9    27FEB93    NON-INJURY    NORTH      9515.27
             10    01MAR93    NON-INJURY    WEST       7830.25
             11    04MAR93    NON-INJURY    WEST      10066.23
             12    15MAR93    NON-INJURY    EAST       2917.64
             13    19MAR93    INJURY        EAST       6447.74
             14    07APR93    INJURY        SOUTH     16679.13
             15    15APR93    INJURY        WEST      18963.10
             16    17APR93    INJURY        EAST       5248.55
             17    21APR93    NON-INJURY    EAST       3785.98
             18    24APR93    INJURY        SOUTH      9060.88
             19    28APR93    INJURY        EAST      16837.60
             20    28APR93    INJURY        NORTH     19551.32
             21    03MAY93    NON-INJURY    SOUTH      7846.33
             22    11MAY93    NON-INJURY    SOUTH     11434.47
             23    14MAY93    NON-INJURY    SOUTH      9140.13
             24    18MAY93    NON-INJURY    EAST      11231.73
             25    20MAY93    NON-INJURY    SOUTH     11462.81
             26    21MAY93    NON-INJURY    SOUTH     19748.66
             27    27MAY93    NON-INJURY    NORTH     11269.33
             28    08JUN93    INJURY        SOUTH     18264.37
             29    10JUN93    NON-INJURY    WEST       1026.76
             30    12JUN93    NON-INJURY    WEST       3015.00
             31    14JUN93    NON-INJURY    EAST       5814.65
             32    16JUN93    NON-INJURY    WEST       1468.71
             33    29JUN93    NON-INJURY    SOUTH     12661.89
             34    01JUL93    NON-INJURY    SOUTH      3179.99
             35    02JUL93    NON-INJURY    EAST       5544.70
             36    03JUL93    NON-INJURY    NORTH      8191.58
             37    11JUL93    NON-INJURY    NORTH      1573.88
             38    14JUL93    NON-INJURY    EAST      18539.09
             39    16JUL93    NON-INJURY    WEST       7135.95
             40    20JUL93    NON-INJURY    SOUTH      9984.92
             41    28JUL93    NON-INJURY    WEST      15822.52
             42    03AUG93    INJURY        EAST      16533.09
             43    11AUG93    NON-INJURY    NORTH      4628.15
             44    18AUG93    NON-INJURY    EAST      10137.39
             45    28AUG93    NON-INJURY    WEST       7422.62
             46    28AUG93    NON-INJURY    SOUTH     16091.38
             47    08SEP93    NON-INJURY    SOUTH      6281.82
             48    08SEP93    NON-INJURY    NORTH     14135.71
             49    17SEP93    NON-INJURY    NORTH      9515.56
             50    27SEP93    NON-INJURY    EAST      19511.68
             51    29SEP93    NON-INJURY    WEST       6643.65
             52    05OCT93    NON-INJURY    NORTH     19770.49
             53    11OCT93    NON-INJURY    WEST       9971.64
             54    19OCT93    NON-INJURY    WEST       3284.94
             55    05NOV93    NON-INJURY    WEST       5913.21
             56    14NOV93    INJURY        WEST      13966.44
             57    29NOV93    INJURY        NORTH     19225.54
             58    30NOV93    NON-INJURY    WEST       2024.45
             59    04DEC93    NON-INJURY    NORTH     19829.24
             60    05DEC93    NON-INJURY    SOUTH     15316.09
             61    08DEC93    NON-INJURY    SOUTH      7823.31
             62    14DEC93    NON-INJURY    EAST       5279.15
             63    19DEC93    NON-INJURY    SOUTH      5350.47
             64    23DEC93    NON-INJURY    EAST       1129.14
             65    24DEC93    NON-INJURY    SOUTH     17991.21



/*  Program 15 from p. 152-153 of SAS Software Solutions  */

PROC SORT DATA=MYLIB.CLAIMS;
   BY CATEGORY DESCENDING AMOUNT;
RUN;

DATA _NULL_;

   TITLE 'Claim Category Report';
   FILE PRINT LL=LINELEFT;

   SET MYLIB.CLAIMS;
       BY CATEGORY;

   IF FIRST.CATEGORY = 1 THEN DO;
      IF LINELEFT < 8 THEN PUT _PAGE_;
      LINK CAT_HDR;
      CAT_SUM = 0;
      CAT_CNT = 0;
   END;

   CAT_SUM + AMOUNT;
   CAT_CNT + 1;

   IF LINELEFT < 3 THEN DO;
      PUT _PAGE_;
      LINK CAT_HDR;
   END;

   PUT @15 AMOUNT 9.2
       @28 DATE MMDDYY8.
       @41 REGION;

   IF LAST.CATEGORY = 1 THEN LINK SUM_CAT;

   RETURN;

   CAT_HDR:
      PUT / /
          @1 CATEGORY
          @17 'Amount'
          /
          @1  'Claims'
          @16 'of Claim'
          @30 'Date'
          @40 'Region'
          /
          @16 '========'
          @28 '========'
          @40 '======';
   RETURN;

   SUM_CAT:
      PUT @1  'Count: ' CAT_CNT
          @13  '==========='
          /
          @11  CAT_SUM DOLLAR13.2;
   RETURN;

RUN;




----------
CHAPTER 16
----------

/*  PERFORM.CAPUTIL data set from p. 168 of SAS Software Solutions  */



                          OBS    HOUR    UTILIZE

                            1      0        20
                            2      1        24
                            3      2        25
                            4      3        29
                            5      4        27
                            6      5        37
                            7      6        42
                            8      7        48
                            9      8        67
                           10      9        93
                           11     10        96
                           12     11        95
                           13     12        77
                           14     13        93
                           15     14        92
                           16     15        80
                           17     16        81
                           18     17        72
                           19     18        38
                           20     19        31 
                           21     20        28
                           22     21        28
                           23     22        23
                           24     23        21



/*  Program 16 from p. 169 of SAS Software Solutions  */

GOPTIONS DEVICE=HP7440 ROTATE=LANDSCAPE;

PATTERN VALUE=SOLID;

AXIS1 LABEL=(HEIGHT=3 PCT FONT=SWISS 'Percent');
AXIS2 LABEL=(HEIGHT=3 PCT FONT=SWISS 'Hour of the Day');

PROC GCHART DATA=PERFORM.CAPUTIL;
   TITLE FONT=SWISS HEIGHT=5 PCT 'System Utilization';
   VBAR HOUR /
     SUMVAR=UTILIZE
     DISCRETE
     RAXIS=AXIS1
     MAXIS=AXIS2
   ;

RUN;                        




----------
CHAPTER 17
----------

/*  EXPENSES.UTILITY data set from p. 182 of SAS Software Solutions  */


                      OBS    MONTH      GAS      ELEC

                        1     JAN     122.34    56.76
                        2     FEB     114.08    55.23
                        3     MAR      98.25    49.61
                        4     APR      77.67    43.98
                        5     MAY      48.01    40.77
                        6     JUN      39.80    39.07
                        7     JUL      37.91    39.82
                        8     AUG      38.47    39.74
                        9     SEP      41.35    40.27
                       10     OCT      68.50    45.34
                       11     NOV      97.72    48.99
                       12     DEC     108.83    53.70



/*  Program 17 from p. 184 of SAS Software Solutions  */


DATA UTLTEMP;
   KEEP MONTH TYPE AMOUNT;
   SET EXPENSES.UTILITY;

   TYPE = 'E';
   AMOUNT = ELEC;
   OUTPUT;

   TYPE = 'G';
   AMOUNT = GAS;
   OUTPUT;
RUN;

GOPTIONS DEVICE=HP7440 ROTATE=LANDSCAPE;

PATTERN1 VALUE=SOLID COLOR=BLACK;
PATTERN2 VALUE=EMPTY COLOR=BLACK;

AXIS1 LABEL=(HEIGHT=5 PCT FONT=SWISS 'Total Cost')
      VALUE=(HEIGHT=4 PCT FONT=SWISS);
AXIS2 LABEL=(HEIGHT=5 PCT FONT=SWISS 'Month')
      VALUE=(HEIGHT=2.5 PCT FONT=SWISS);

LEGEND1 LABEL=(HEIGHT=5 PCT FONT=SWISS 'Source:')
        VALUE=(HEIGHT=5 PCT FONT=SWISS 'Electric'
               HEIGHT=5 PCT FONT=SWISS 'Gas');

PROC GCHART DATA=UTLTEMP;

   TITLE HEIGHT=8 PCT FONT=SWISS 'Utility Costs';
   FORMAT AMOUNT DOLLAR5.;

   VBAR MONTH /
      SUBGROUP=TYPE
      SUMVAR=AMOUNT
      RAXIS=AXIS1
      MAXIS=AXIS2
      LEGEND=LEGEND1
      MIDPOINTS = 'JAN' 'FEB' 'MAR' 'APR' 'MAY' 'JUN'
                  'JUL' 'AUG' 'SEP' 'OCT' 'NOV' 'DEC'
   ;

RUN;




----------
CHAPTER 18
----------

/*  ACCOUNT.QTRPROF data set from p. 196 of SAS Software Solutions  */

                 OBS    QTR    DIRECT    RETAIL    MANUFAC

                  1      1       256        98       1034
                  2      2       101       -40        452
                  3      3       124        23        601
                  4      4       212        76        929



/*  Program 18 from pp. 197-198 of SAS Software Solutions  */


DATA PROFTEMP;

   KEEP QTR DIVISION PROFIT;
   SET ACCOUNT.QTRPROF;

   DIVISION = 'D';
   PROFIT= DIRECT;
   OUTPUT;

   DIVISION = 'R';
   PROFIT= RETAIL;
   OUTPUT;

   DIVISION = 'M';
   PROFIT= MANUFAC;
   OUTPUT;

RUN;

GOPTIONS DEVICE=HP7440 ROTATE=LANDSCAPE;

AXIS1 LABEL=(HEIGHT=4 PCT FONT=SWISS 'Net Profit')
      VALUE=(HEIGHT=3 PCT FONT=SWISS);
AXIS2 LABEL=(HEIGHT=4 PCT FONT=SWISS 'Quarter')
      VALUE=(HEIGHT=3 PCT FONT=SWISS);
AXIS3 LABEL=(HEIGHT=4 PCT FONT=SWISS 'Division')
      VALUE=(HEIGHT=3 PCT FONT=SWISS);

PATTERN1 VALUE=SOLID COLOR=BLACK;

PROC GCHART DATA=PROFTEMP;

   TITLE HEIGHT=6 PCT FONT=SWISS 'Quarterly Profits';
   TITLE2 HEIGHT=4 PCT FONT=SWISS
          '(in thousands of dollars)';
   FOOTNOTE HEIGHT=3 PCT FONT=ZAPF
    'D=Direct Marketing   M=Manufacturing   R=Retail';

   FORMAT PROFIT DOLLAR5.;

   VBAR DIVISION /
      GROUP=QTR
      SUMVAR=PROFIT
      RAXIS=AXIS1
      GAXIS=AXIS2
      MAXIS=AXIS3
   ;

RUN;



----------
CHAPTER 19
----------

/*  DNRFISH.PHOSTEST data set from p. 210 of SAS Software Solutions  */

                             OBS    YEAR     PHOS     COUNT 
                               1    1978    0.1130      54
                               2    1979    0.1280      50
                               3    1980    0.0900      56
                               4    1981    0.0770      62
                               5    1982    0.0820      58
                               6    1983    0.0780      60
                               7    1984    0.0740      63
                               8    1985    0.0610      65
                               9    1986    0.0590      72
                              10    1987    0.0530      75
                              11    1988    0.0520      74
                              12    1989    0.0700      70
                              13    1990    0.0560      74
                              14    1991    0.0480      75
                              15    1992    0.0440      78
                              16    1993    0.0511      75



/*  Program 19 from p. 211 of SAS Software Solutions  */

PROC SORT DATA=DNRFISH.PHOSTEST OUT=PHOSTEMP;
   BY PHOS;
RUN;

GOPTIONS DEVICE=HP7440 ROTATE=LANDSCAPE;

AXIS1 LABEL=(HEIGHT=4 PCT FONT=SWISS 'Fish Count')
      VALUE=(HEIGHT=3 PCT FONT=SWISS);

AXIS2 LABEL=(HEIGHT=4 PCT FONT=SWISS
            'P Concentration mg/L')
      VALUE=(HEIGHT=3 PCT FONT=SWISS);

SYMBOL1 INTERPOL=JOIN LINE=1 VALUE=NONE;

PROC GPLOT DATA=PHOSTEMP;

   TITLE HEIGHT=5 PCT FONT=SWISS
     'Walleye Pike Count v. Phosphorous Concentration';
   TITLE2 HEIGHT=4 PCT FONT=SWISS
     'Data from 1978 to 1993';

   PLOT COUNT*PHOS /
       VAXIS=AXIS1
       HAXIS=AXIS2
   ;

RUN;
                               





















