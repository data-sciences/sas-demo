/*-----------------------------------------------------------------*/
/* The SAS Workbook                                                */
/* by Ron Cody                                                     */
/*                                                                 */
/* SAS Publications order # 55473                                  */
/* ISBN 1-55544-757-0                                              */
/* Copyright 1995 by SAS Institute Inc., Cary, NC, USA             */
/*                                                                 */
/* SAS Institute does not assume responsibility for the accuracy   */
/* of any material presented in this file.                         */
/*-----------------------------------------------------------------*/

/* page 205 of The SAS Workbook */

/* BASKET.DTA Data File Description */

                                Starting
Variable        Description      Column    Length    Type
------------------------------------------------------------------
  ID            Employee ID        1         3       Char
  GENDER        Gender             5         1       Char (M or F)
  HEIGHT        Height in inches   7         2       Numeric
  DATE          Date of game      10         8       MM/DD/YY
  POINTS        Number of points  19         2       Numeric


/* pages 205-206 of The SAS Workbook */

/* Listing of Raw Data from BASKET.DTA */

         1         2
12345678901234567890
--------------------
001 M 72 12/01/95 10
001 M 72 12/03/95 12
001 M 72 12/10/95  8
002 F 68 10/21/95 14
003 M 74 12/12/95 20
003 M 74 12/16/95 22
004 M 74 11/12/95  6
004 M 74 11/15/95  8
005 F 67 12/12/95 10
005 F 67 12/15/95 18
006 M 69 10/30/95  2
006 M 69 11/04/95  6
006 M 69 11/06/95  8
007 M 69 11/11/95  9
007 M 69 11/16/95  7

/* page 206 of The SAS Workbook */

/* BASKETBA.DTA Data File Description */

                                Starting
Variable        Description      Column    Length    Type
------------------------------------------------------------------
  ID            Employee ID        1         3       Char
  GENDER        Gender             5         1       Char (M or F)
  HEIGHT        Height in inches   7         2       Numeric
  DATE          Date of game      10         8       MM/DD/YY
  POINTS        Number of points  19         2       Numeric


/* Listing of Raw Data from BASKETBA.DTA */

         1         2
12345678901234567890
--------------------
001 M 72 12/01/95 10
001      12/03/95 12
001      12/10/95  8
002 F 68 10/21/95 14
003 M 74 12/12/95 20
003      12/16/95 22
004      11/12/95  6
004      11/15/95  8
005 F 67 12/12/95 10
005      12/15/95 18
006 M 69 10/30/95  2
006      11/04/95  6
006      11/06/95  8
007      11/11/95  9
007      11/16/95  7

/* page 207 of The SAS Workbook */

/* CARS.DTA Data File Description */

                                Starting
Variable        Description      Column    Length    Type
----------------------------------------------------------
SIZE            Car Size           1          9      Char
MANUFACT        Manufacturer      11          9      Char
MODEL           Model             22          9      Char
MILEAGE         Gas Mileage       38          2      Numeric
RELIABLE        Reliability       50          1      Numeric

/* Listing of Raw Data from CARS.DTA */

         1         2         3         4         5
12345678901234567890123456789012345678901234567890
--------------------------------------------------
SMALL     CHEVROLET  GEO PRIZM       33          5
SMALL     HONDA      CIVIC           29          5
SMALL     TOYOTA     COROLLA         30          5
SMALL     FORD       ESCORT          27          3
SMALL     DODGE      COLT            34
COMPACT   FORD       TEMPO           24          1
COMPACT   CHRYSLER   LE BARON        23          3
COMPACT   BUICK      SKYLARK         21          3
COMPACT   PLYMOUTH   ACCLAIM         24          3
COMPACT   CHEVROLET  CORSICA         25          2
COMPACT   PONTIAC    SUNBIRD         24          1
MID-SIZED TOYOTA     CAMRY           24          5
MID-SIZED HONDA      ACCORD          26          5
MID-SIZED FORD       TAURUS          20          3


/* page 208 of The SAS Workbook */

/* CLIN_X.DTA Data File Description */


                                   Starting
Variable   Description              Column    Length   Format   Codes
---------------------------------------------------------------------------
 ID        Patient ID                 1          3     Char
 VISIT     Date of Visit              4          6     MMDDYY
 DX        Diagnosis                 10          2     Char      (see list)
 HR        Heart Rate                12          3     Numeric
 SBP       Systolic Blood Pressure   15          3     Numeric
 DBP       Diastolic Blood Pressure  18          3     Numeric
 RX_1      Treatment 1               21          1     Char      (see list)
 RX_2      Treatment 2               22          1     Char      (see list)

   DX Codes:                            RX Codes:

01      Cold                         1     Immunization
02      Flu                          2     Casting
03      Fracture                     3     Beta Blocker
04      Routine Physical             4     ACE Inhibitor
05      Heart Problem                5     Antihistamine
06      Lung Disorder                6     Ibuprofen
07      Abdominal Pain               7     Aspirin
08      Laceration                   8     Antibiotic
09      URI
10      Lyme Disease
11      Ear Ache

/* pages 208-209 of The SAS Workbook */

/* Listing of Raw Data from CLIN_X.DTA */

         1         2         3
123456789012345678901234567890
------------------------------
7770901941108809806468
04505189404086180092
033010594090841280788
0451021950508821012034
033090995020681200706
033101095070721220748
0451031950508418010234
009123195030881340882
033051894010881280786
17706069504058120074
045122195060781500808
00909099507078128082
1770818951008213008086
4450919950308814408826
77709129507086100062
0091015950106612208257
0781101950509019011073
033101095100581200708

/* page 209 of The SAS Workbook */

/* CLINICAL.DTA Data File Description */


                              Starting
Variable   Description         Column    Length   Format   Codes
----------------------------------------------------------------------
ID         Subject ID             1         3     Char
GENDER     Gender                 4         1     Char     M,F
DOB        Date of Birth          5         6     MMDDYY
VISIT      Visit Date            11         6     MMDDYY
PRIM_DX    Primary DX Code       17         2     Char     (see list)
SEC_DX     Secondary DX Code     19         2     Char         "
HR         Heart Rate            21         3     Numeric
SBP        Systolic Blood Pres.  24         3     Numeric
DBP        Diastolic Blood Pres. 27         3     Numeric
VITAMINS   Pt. Taking Vitamins?  30         1     Char     1=Yes, 0=No
PREGNANT   Is PT Pregnant?       31         1     Char     1=Yes, 0=No

DX Codes:

01      Cold                         07      Abdominal Pain
02      Flu                          08      Laceration
03      Fracture                     09      Immunization
04      Routine Physical             10      Lyme Disease
05      Heart Problem                11      Ear Ache
06      Lung Disorder

/* page 210 of The SAS Workbook */

/* Listing of Raw Data from CLINICAL.DTA */

         1         2         3         4
1234567890123456789012345678901234567890
----------------------------------------
123M102146051595010506213607610
278F11015505159504  06810406400
444F07086505169501  07812806211
756M122562061195070906615009600
811F030475060195050608816607400
193F10105908159504  07011206811
   M10159502159604  08009805410
978M062894070295040908809806210
586M120409051895050608616209610
919F09069306209511  09205805010
529M07135008099510  05811407600
324F01011075119506  08620010010
012F100908760195030809018409800
812M10116710109508  06613408210
338M07289007129511  08210607010
959F121565111195070908817609810
007F04196402069504  07410606411
291M080975060395011106813208600
984F12237905159502  07409606201
669M02287707079509  06214009000
999F01019502019401  08018810200
229F06188009189509  07410406010
885M091085101595110908811408400
178M030491071695010908810206800
   F010190010696050607012008000
966F040591081695010909205403610
782M060710051895050608822018000
374M05068807229504  08312007000
285F06077009119511  08416009600
884M07121609119505  07819014000
258M08098211189504  07214409800
733F090978030495070207412007011
449M10103110189501           10
941F101070101995030408819011001

/* pages 211-212 of The SAS Workbook */ 

/* Program to Create the SAS Data Set CLINICAL */

*--------------------------------------------------------------------* 
| Program Name: CLINICAL.SAS in subdirectory C:\WORKBOOK             | 
| Purpose: To Create a Permanent SAS data set called CLINICAL from   | 
|          the raw data file CLINICAL.DTA along with permanent       |
|          formats.  Both the SAS data set and permanent formats are |
|          to be stored in the subdirectory C:\WORKBOOK              |
*--------------------------------------------------------------------* ; 

LIBNAME WORKBOOK 'C:\WORKBOOK';

OPTIONS PAGENO=1 NOCENTER FMTSEARCH=(WORKBOOK); 

FILENAME CLIN 'C:\WORKBOOK\CLINICAL.DTA';

PROC FORMAT LIBRARY=WORKBOOK;
   VALUE $GENDER 'M' = 'Male'
                 'F' = 'Female';
   VALUE $DXCODES '01' = 'Cold'
                  '02' = 'Flu'
                  '03' = 'Fracture'
                  '04' = 'Routine Physical'
                  '05' = 'Heart Problem'
                  '06' = 'Lung Disorder'
                  '07' = 'Abdominal Pain'
                  '08' = 'Laceration'
                  '09' = 'Immunization'
                  '10' = 'Lyme disease'
                  '11' = 'Ear Ache';
   VALUE $YESNO  '0' = 'No'
                 '1' = 'Yes';
RUN;

DATA WORKBOOK.CLINICAL;
   INFILE CLIN;
   INPUT   @1   ID        $3.
           @4   GENDER    $1.
           @5   DOB       MMDDYY6.
           @11  VISIT     MMDDYY6.
           @17  PRIM_DX   $2.
           @19  SEC_DX    $2.
           @21  HR        3.
           @24  SBP       3.
           @27  DBP       3.
           @30  VITAMINS  $1.
           @31  PREGNANT  $1.;

   LABEL   ID       = 'Pt. Number'
           GENDER   = 'Gender'
           DOB      = 'Date of Birth'
           VISIT    = 'Visit Date'
           PRIM_DX  = 'Primary DX'
           SEC_DX   = 'Secondary DX'
           HR       = 'Heart Rate'
           SBP      = 'Systolic Blood Pressure'
           DBP      = 'Diastolic Blood Pressure'
           VITAMINS = 'Pt. Taking Vitamins?'
           PREGNANT = 'Is Pt. Pregnant?';

   FORMAT PRIM_DX SEC_DX $DXCODES.
          DOB VISIT MMDDYY8.
          GENDER $GENDER.
          VITAMINS PREGNANT $YESNO.;

RUN;

/* page 212 of The SAS Workbook */

/* CPR.DTA Data File Description */

                                   Starting
Variable   Description              Column    Length   Format   Codes
---------------------------------------------------------------------------
SUBJECT    Subject number             1         3      Numeric
V_FIB      Ventricular Fibrillation   4         1      Numeric  1=Yes, 0=No
RESP       Pt on Respirator?          5         1      Numeric  1=Yes, 0=No
AGEGROUP   Age greater than 70?       6         1      Numeric  1=Yes, 0=No
SURVIVE    Did patient Survive?       7         1      Numeric  1=Yes, 0=No


/* page 213 of The SAS Workbook */

/* Listing of Raw Data from File CPR.DTA */

         1
1234567890
----------
0011001
0021111
0031110
0040010
0050010
0060110
0070011
0081001
0090000
0101011
0110000
0120101
0130100
0141111
0150101
0161001
0170011
0180010
0190110
0201011
0210110
0220010
0231110
0240001
0251011
0261110
0270110
0280110
0291100
0300100
0310001
0320010
0330001
0340100
0350010
0360001

/* page 214 of The SAS Workbook */

/* DEMOG1.DTA and DEMOG2.DTA Data File Descriptions */

                             Starting
Variable   Description        Column    Length    Type      Codes
----------------------------------------------------------------------------
ID         Subject ID           1          3      Char
DOB        Date of Birth        4          6      MMDDYY
GENDER     Gender              10          1      Char      M=Male, F=Female
STATE      State of Residence  11          2      Char
EMPLOYED   Employed?           13          1      Char      1=Yes, 0=No

/* Listing of Raw Data from DEMOG1.DTA */

         1         2         3         4         5         6
123456789012345678901234567890123456789012345678901234567890
------------------------------------------------------------
178102146MNJ1
982110166FNY0
723030452MNJ1
258101074FNY1
139122550FNJ0
145010444MNY1

/* Listing of Raw Data from DEMOG2.DTA */

         1         2         3         4         5         6
123456789012345678901234567890123456789012345678901234567890
------------------------------------------------------------
559110168FNY0
714010244MNH0
934052890FNJ0
569112850FNY1

/* page 215 of The SAS Workbook */

/* DIALYSIS.DTA Data File Description */


                                Starting
Variable  Description            Column   Length  Type      Codes
----------------------------------------------------------------------------
ID        Subject ID                1         3    Char
GENDER    Gender                    4         1    Char     M=Male, F=Female
DOB       Date of Birth             5         8    MM/DD/YY
VISIT     Visit Number             13         1    Numeric
HR        Heart Rate               14         3    Numeric
SBP       Systolic Blood Pressure  17         3    Numeric
DBP       Diastolic Blood Pressure 20         3    Numeric

/* Listing of Raw Data from DIALYSIS.DTA */

         1         2         3
123456789012345678901234567890
------------------------------
001M10/21/461080140080
001         2082142084
001         3078138078
002F11/17/221066120070
003F04/04/181084150090
003         2088152102
004M12/21/101072120074
004         2070122076
004         3078128078
005F08/02/311092180110
006         1076180112
006         2080178090

