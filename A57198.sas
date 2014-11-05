

/*------------------------------------------------------------------- */
 /*       Cody's Data Cleaning Techniques Using SAS Software          */
 /*                          by Ron Cody                              */
 /*       Copyright(c) 1999 by SAS Institute Inc., Cary, NC, USA      */
 /*                   SAS Publications order # 57198                  */
 /*                        ISBN 1-58025-600-7                         */
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
 /* Attn: Ron Cody                                                    */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  sasbbu@sas.com             */
 /* Use this for subject field:                                       */
 /*     Comments for Ron Cody                                         */
 /*                                                                   */
 /*-------------------------------------------------------------------*/




Data Sets and Programs from "Cody's Data Cleaning Techniques Using SAS Software"

The following text files and programs are listed in the Appendix:
-----------------------------------------------------------------
Raw data file PATIENTS.TXT
-----------------------------------------------------------------

001M11/11/1998 88140 80  10
002F11/13/1998 84120 78  X0
003X10/21/1998 68190100  31
004F01/01/1999101200120  5A
XX5M05/07/1998 68120 80  10
006 06/15/1999 72102 68  61
007M08/32/1998 88148102   0
   M11/11/1998 90190100   0
008F08/08/1998210        70
009M09/25/1999 86240180  41
010f10/19/1999    40120  10
011M13/13/1998 68300 20  41
012M10/12/98   60122 74   0
013208/23/1999 74108 64  1
014M02/02/1999 22130 90   1
002F11/13/1998 84120 78  X0
003M11/12/1999 58112 74   0
015F           82148 88  31
017F04/05/1999208    84  20
019M06/07/1999 58118 70   0
123M15/12/1999 60        10
321F          900400200  51
020F99/99/9999 10 20  8   0
022M10/10/1999 48114 82  21
023f12/31/1998 22 34 78   0
024F11/09/199876 120 80  10
025M01/01/1999 74102 68  51
027FNOTAVAIL  NA 166106  70
028F03/28/1998 66150 90  30
029M05/15/1998           41
006F07/07/1999 82148 84  10


-----------------------------------------------------------------
Program to create SAS data set PATIENTS
-----------------------------------------------------------------

*----------------------------------------------------------------*
| PROGRAM NAME: PATIENTS.SAS IN C:\CLEANING                      |
| PURPOSE: TO CREATE A SAS DATA SET CALLED PATIENTS              |
| DATE: MAY 29, 1998                                             |
*----------------------------------------------------------------*;
LIBNAME CLEAN "C:\CLEANING";

DATA CLEAN.PATIENTS;
   INFILE "C:\CLEANING\PATIENTS.TXT" PAD;
   INPUT @1  PATNO    $3.
         @4  GENDER   $1.
         @5  VISIT    MMDDYY10.
         @15 HR       3.
         @18 SBP      3.
         @21 DBP      3.
         @24 DX       $3.
         @27 AE       $1.;

   LABEL PATNO   = "Patient Number"
         GENDER  = "Gender"
         VISIT   = "Visit Date"
         HR      = "Heart Rate"
         SBP     = "Systolic Blood Pressure"
         DBP     = "Diastolic Blood Pressure"
         DX      = "Diagnosis Code"
         AE      = "Adverse Event?";

   FORMAT VISIT MMDDYY10.;

RUN;

-----------------------------------------------------------------
Raw data file PATIENTS2.TXT
-----------------------------------------------------------------

00106/12/1998 80130 80
00106/15/1998 78128 78
00201/01/1999 48102 66
00201/10/1999 70112 82
00202/09/1999 74118 78
00310/21/1998 68120 70
00403/12/1998 70102 66
00403/13/1998 70106 68
00504/14/1998 72118 74
00504/14/1998 74120 80
00611/11/1998100180110
00709/01/1998 68138100
00710/01/1998 68140 98


-----------------------------------------------------------------
Program to Create the SAS Data Set PATIENTS2
-----------------------------------------------------------------

LIBNAME CLEAN "C:\CLEANING";

DATA CLEAN.PATIENT2;
   INFILE "C:\CLEANING\PATIENT2.TXT" PAD;
   INPUT @1  PATNO  $3.
         @4  VISIT  MMDDYY10.
         @14 HR      3.
         @17 SBP     3.
         @20 DBP     3.;
   FORMAT VISIT MMDDYY10.;
RUN;

-----------------------------------------------------------------
Program to Create the SAS Data Set AE (Adverse Events)
-----------------------------------------------------------------

LIBNAME CLEAN "C:\CLEANING";

DATA CLEAN.AE;
   INPUT @1  PATNO   $3.
         @4  DATE_AE MMDDYY10.
         @14 A_EVENT $1.;
   LABEL PATNO   = 'Patient ID'
         DATE_AE = 'Date of AE'
         A_EVENT = 'Adverse Event';
   FORMAT DATE_AE MMDDYY10.;
DATALINES;
00111/21/1998W
00112/13/1998Y
00311/18/1998X
00409/18/1998O
00409/19/1998P
01110/10/1998X
01309/25/1998W
00912/25/1998X
02210/01/1998W
02502/09/1999X
;


-----------------------------------------------------------------
Program to Create the SAS Data Set LAB_TEST
-----------------------------------------------------------------

LIBNAME CLEAN "C:\CLEANING";

DATA CLEAN.LAB_TEST;
   INPUT @1  PATNO    $3.
         @4  LAB_DATE DATE9.
         @13 WBC      5.
         @18 RBC      4.;
   LABEL  PATNO    = 'Patient ID'
          LAB_DATE = 'Date of Lab Test'
          WBC      = 'White Blood Cell Count'
          RBC      = 'Red Blood Cell Count';
   FORMAT LAB_DATE MMDDYY10.;
DATALINES;
00115NOV1998 90005.45
00319NOV1998 95005.44
00721OCT1998 82005.23
00422DEC1998110005.55
02501JAN1999 82345.02
02210OCT1998 80005.00
;


-----------------------------------------------------------------
The following programs are located in Chapter 1
-----------------------------------------------------------------
/***************************************************************************
Program 1-1  Writing a program to create the PATIENTS data set
****************************************************************************/
*----------------------------------------------------------------*
| PROGRAM NAME: PATIENTS.SAS IN C:\CLEANING                      |
| PURPOSE: TO CREATE A SAS DATA SET CALLED PATIENTS              |
*----------------------------------------------------------------*;
LIBNAME CLEAN "C:\CLEANING";

DATA CLEAN.PATIENTS;
   INFILE "C:\CLEANING\PATIENTS.TXT" PAD; /* Pad short records */
   INPUT @1  PATNO    $3.                 /* With blanks       */
         @4  GENDER   $1.
         @5  VISIT    MMDDYY10.
         @15 HR       3.
         @18 SBP      3.
         @21 DBP      3.
         @24 DX       $3.
         @27 AE       $1.;

   LABEL PATNO   = "Patient Number"
         GENDER  = "Gender"
         VISIT   = "Visit Date"
         HR      = "Heart Rate"
         SBP     = "Systolic Blood Pressure"
         DBP     = "Diastolic Blood Pressure"
         DX      = "Diagnosis Code"
         AE      = "Adverse Event?";

   FORMAT VISIT MMDDYY10.;

RUN;

/***************************************************************************
Program 1-2  Using PROC FREQ to list all the unique values for character 
Variables
****************************************************************************/
PROC FREQ DATA=CLEAN.PATIENTS;
   TITLE "Frequency Counts for Selected Character Variables";
   TABLES GENDER DX AE / NOCUM NOPERCENT;
RUN;

/***************************************************************************
Program 1-3  Using a DATA _NULL_ Data Step to detect invalid character data
****************************************************************************/
DATA _NULL_;
   INFILE "C:\CLEANING\PATIENTS.TXT" PAD;
   FILE PRINT; ***Send output to the output window;
   TITLE "Listing of Invalid Patient Numbers and Data Values";
   ***Note: We will only input those variables of interest;
   INPUT @1  PATNO    $3.
         @4  GENDER   $1.
         @24 DX       $3.
         @27 AE       $1.;

   ***Check GENDER;
   IF GENDER NOT IN ('F' 'M' ' ') THEN PUT PATNO= GENDER=;
   ***Check DX;
   IF VERIFY(DX,' 0123456789') NE 0 THEN PUT PATNO= DX=;
   ***Check AE;
   IF AE NOT IN ('0' '1' ' ') THEN PUT PATNO= AE=;
RUN;

/***************************************************************************
Program 1-4  Using PROC PRINT to list invalid character values
****************************************************************************/
PROC PRINT DATA=CLEAN.PATIENTS;
   TITLE "LISTING OF INVALID GENDER VALUES";
   WHERE GENDER NOT IN ('M' 'F' ' ');
   ID PATNO;
   VAR GENDER;
RUN;

/***************************************************************************
Program 1-5  Using PROC PRINT to list invalid character data for several 
Variables
****************************************************************************/
PROC PRINT DATA=CLEAN.PATIENTS;
   TITLE "LISTING OF INVALID CHARACTER VALUES";
   WHERE GENDER NOT IN ('M' 'F' ' ')         OR
         VERIFY(DX,' 0123456789') NE 0       OR
         AE NOT IN ('0' '1' ' ');
   ID PATNO;
   VAR GENDER DX AE;
RUN;

/***************************************************************************
Program 1-6  Using a user-defined format and PROC FREQ to list invalid data 
Values
****************************************************************************/
PROC FORMAT;
   VALUE $GENDER 'F','M' = 'Valid'
                 ' '     = 'Missing'
                 OTHER   = 'Miscoded';
   VALUE $DX '001' - '999' = 'Valid'  /* See important note below */
             ' '           = 'Missing'
                 OTHER     = 'Miscoded';
   VALUE $AE '0','1' = 'Valid'
             ' '     = 'Missing'
              OTHER  = 'Miscoded';
RUN;

PROC FREQ DATA=CLEAN.PATIENTS;
   TITLE "Using FORMATS to Identify Invalid Values";
   FORMAT GENDER $GENDER.
          DX     $DX.
          AE     $AE.;
   TABLES GENDER DX AE / NOCUM NOPERCENT MISSING;
RUN;

/***************************************************************************
Program 1-7  Using a user-defined format and a Data Step to list invalid data 
Values
****************************************************************************/
PROC FORMAT;
   VALUE $GENDER 'F','M' = 'Valid'
                 ' '     = 'Missing'
                 OTHER   = 'Miscoded';
   VALUE $DX '001' - '999' = 'Valid'
             ' '           = 'Missing'
                 OTHER     = 'Miscoded';
   VALUE $AE '0','1' = 'Valid'
             ' '     = 'Missing'
              OTHER  = 'Miscoded';
RUN;

DATA _NULL_;
   INFILE "C:\CLEANING\PATIENTS.TXT" PAD;
   FILE PRINT; ***Send output to the output window;
   TITLE "Listing of Invalid Patient Numbers and Data Values";
   ***Note: We will only input those variables of interest;
   INPUT @1  PATNO    $3.
         @4  GENDER   $1.
         @24 DX       $3.
         @27 AE       $1.;

   IF PUT(GENDER,$GENDER.) = 'Miscoded' THEN PUT PATNO= GENDER=;
   IF PUT(DX,$DX.) = 'Miscoded' THEN PUT PATNO= DX=;
   IF PUT(AE,$AE.) = 'Miscoded' THEN PUT PATNO= AE=;
RUN;

/***************************************************************************
Program 1-8  Using a user-defined informat to set invalid data values to missing
****************************************************************************/
*----------------------------------------------------------------*
| PROGRAM NAME: INFORM1.SAS IN C:\CLEANING                       |
| PURPOSE: TO CREATE A SAS DATA SET CALLED PATIENT2              |
|          AND SET ANY INVALID VALUES FOR GENDER AND AE TO       |
|          MISSING, USING A USER DEFINED INFORMAT                |
*----------------------------------------------------------------*;
LIBNAME CLEAN "C:\CLEANING";

PROC FORMAT;
   INVALUE $GEN    'F','M' = _SAME_
                   OTHER   = ' ';
   INVALUE $AE    '0','1' = _SAME_
                   OTHER  = ' ';
RUN;

DATA CLEAN.PATIENT2;
   INFILE "C:\CLEANING\PATIENTS.TXT" PAD;
   INPUT @1  PATNO    $3.
         @4  GENDER   $GEN1.
         @27 AE       $AE1.;

   LABEL PATNO   = "Patient Number"
         GENDER  = "Gender"
         DX      = "Diagnosis Code"
         AE      = "Adverse Event?";

RUN;

PROC PRINT DATA=CLEAN.PATIENT2;
   TITLE "Listing of data set PATIENT2";
   VAR PATNO GENDER AE;
RUN;

/***************************************************************************
Program 1-9  Using a user-defined INFORMAT with the INPUT function
****************************************************************************/
PROC FORMAT;
   INVALUE $GENDER 'F','M' = _SAME_
                    OTHER  = 'ERROR';
   INVALUE $AE      '0','1' = _SAME_
                    OTHER   = 'ERROR';
RUN;

DATA _NULL_;
   FILE PRINT;
   SET CLEAN.PATIENTS;
   IF INPUT (GENDER,$GENDER.) = 'ERROR' THEN
      PUT @1 "Error for Gender for Patient:" PATNO" Value is " GENDER;
   IF INPUT (AE,$AE.) = 'ERROR' THEN
      PUT @1 "Error for AE for Patient:" PATNO" Value is " AE;
RUN;

-----------------------------------------------------------------
The following programs are located in Chapter 2
-----------------------------------------------------------------
/***************************************************************************
Program 2-1  Using PROC MEANS to detect invalid and missing values
****************************************************************************/
LIBNAME CLEAN "C:\CLEANING";
PROC MEANS DATA=CLEAN.PATIENTS N NMISS MIN MAX MAXDEC=3;
   TITLE "Checking Numeric Variables in PATIENTS data set";
   VAR HR SBP DBP;
RUN;

/***************************************************************************
Program 2-2  Using PROC TABULATE to display descriptive data
****************************************************************************/
PROC TABULATE DATA=CLEAN.PATIENTS FORMAT=7.3; 
   TITLE "Statistics for Numeric Variables";
   VAR HR SBP DBP; 
   TABLES HR SBP DBP,
          N*F=7.0 NMISS*F=7.0 MEAN MIN MAX / RTSPACE=18; 
   KEYLABEL N     = 'Number'  
            NMISS = 'Missing'
            MEAN  = 'Mean'
            MIN   = 'Lowest'
            MAX   = 'Highest';
RUN;

/***************************************************************************
Program 2-3  Using PROC UNIVARIATE to look for outliers
****************************************************************************/
PROC UNIVARIATE DATA=CLEAN.PATIENTS PLOT;
   TITLE "Using PROC UNIVARIATE to look for Outliers";
   VAR HR SBP DBP;
RUN;

/***************************************************************************
Program 2-4  Adding an ID statement to PROC UNIVARIATE
****************************************************************************/
/**************************************************************\
| The ODS statement is valid for V7 and above                  |
| Note that the name EXTREMEOBS may change in future releases  |
| Use ODS TRACE ON; before the PROC and ODS TRACE OFF; after   |
| the PROC to obtain a list of output object names (found in   |
| the SAS Log).                                                |
\**************************************************************/

ODS SELECT EXTREMEOBS;

PROC UNIVARIATE DATA=CLEAN.PATIENTS PLOT;
   TITLE "Using PROC UNIVARIATE to look for Outliers";
   ID PATNO;
   VAR HR SBP DBP;
RUN;

/***************************************************************************
Program 2-5  Using a WHERE statement with PROC PRINT to list out-of-range data
****************************************************************************/
PROC PRINT DATA=CLEAN.PATIENTS;
   WHERE (HR NOT BETWEEN 40 AND 100 AND HR IS NOT MISSING)      OR
         (SBP NOT BETWEEN 80 AND 200 AND SBP IS NOT MISSING)    OR
         (DBP NOT BETWEEN 60 AND 120 AND DBP IS NOT MISSING);
   TITLE "Out-of-range Values for Numeric Variables";
   ID PATNO;
   VAR HR SBP DBP;
RUN;

/***************************************************************************
Program 2-6  Using a DATA _NULL_ Data Step to list out-of-range data values
****************************************************************************/
DATA _NULL_;
   INFILE "C:\CLEANING\PATIENTS.TXT" PAD;
   FILE PRINT; ***Send output to the output window;
   TITLE "Listing of Patient Numbers and Invalid Data Values";
   ***Note: We will only input those variables of interest;
   INPUT @1  PATNO    $3.
         @15 HR        3.
         @18 SBP       3.
         @21 DBP       3.;
   ***Check HR;
   IF (HR LT 40 AND HR NE .) OR HR GT 100 THEN PUT PATNO= HR=;
   ***Check SBP;
   IF (SBP LT 80 AND SBP NE .) OR SBP GT 200 THEN PUT PATNO= SBP=;
   ***Check DBP;
   IF (DBP LT 60 AND DBP NE .) OR DBP GT 120 THEN PUT PATNO= DBP=;
RUN;

/***************************************************************************
Program 2-7  Writing a macro to list out-of-range data values
****************************************************************************/
*---------------------------------------------------------------*
| Program Name: RANGE.SAS  in C:\CLEANING                       |
| Purpose: Macro that takes lower and upper limits for a        |
|          numeric variable, and an ID variable to print out    |
|          an exception report to the output window             |
| Arguments: DSN    - Data set name                             |
|            VAR    - Numeric variable to test                  |
|            LOW    - Lowest valid value                        |
|            HIGH   - Highest valid value                       |
|            IDVAR  - ID variable to print in the exception     |
|                     report                                    |
| Example: %RANGE(CLEAN.PATIENTS,HR,40,100,PATNO)               |
*---------------------------------------------------------------*;

%MACRO RANGE(DSN,VAR,LOW,HIGH,IDVAR);

   TITLE "Listing of Invalid Patient Numbers and Data Values";
   DATA _NULL_;
      SET &DSN(KEEP=&IDVAR &VAR);
      FILE PRINT;
      IF (&VAR LT &LOW AND &VAR NE .) OR &VAR GT &HIGH THEN
         PUT "&IDVAR:" &IDVAR  @18 "Variable:&VAR"
                               @38 "Value:" &VAR
                               @50 "out-of-range";
   RUN;

%MEND RANGE;

/***************************************************************************
Program 2-8  Detecting out-of-range values using user-defined formats
****************************************************************************/
PROC FORMAT;
   VALUE HR_CK  40-100, . = 'OK';
   VALUE SBP_CK 80-200, . = 'OK';
   VALUE DBP_CK 60-120, . = 'OK';
RUN;

DATA _NULL_;
   INFILE "C:\CLEANING\PATIENTS.TXT" PAD;
   FILE PRINT; ***Send output to the output window;
   TITLE "Listing of Invalid Patient Numbers and Data Values";
   ***Note: We will only input those variables of interest;
   INPUT @1  PATNO    $3.
         @15 HR        3.
         @18 SBP       3.
         @21 DBP       3.;
   IF PUT(HR,HR_CK.)   NE 'OK' THEN PUT PATNO= HR=;
   IF PUT(SBP,SBP_CK.) NE 'OK' THEN PUT PATNO= SBP=;
   IF PUT(DBP,DBP_CK.) NE 'OK' THEN PUT PATNO= DBP=;
RUN;

/***************************************************************************
Program 2-9  Modifying the Previous Program to Detect Invalid (Character) Data 
Values
****************************************************************************/
DATA _NULL_;
   INFILE "C:\CLEANING\PATIENTS.TXT" PAD;
   FILE PRINT; ***Send output to the output window;
   TITLE "Listing of Invalid Patient Numbers and Data Values";
   ***Note: We will only input those variables of interest;
   INPUT @1  PATNO    $3.
         @15 HR        3.
         @18 SBP       3.
         @21 DBP       3.;
   IF PUT(HR,HR_CK.)   NE 'OK' OR _ERROR_ GT 0 THEN PUT PATNO= HR=;
   IF PUT(SBP,SBP_CK.) NE 'OK' OR _ERROR_ GT 0 THEN PUT PATNO= SBP=;
   IF PUT(DBP,DBP_CK.) NE 'OK' OR _ERROR_ GT 0 THEN PUT PATNO= DBP=;
   IF _ERROR_ GT 0 THEN
      PUT PATNO= "had one or more invalid character values";
   ***Set the Error flag back to 0;
   _ERROR_ = 0;
RUN;

/***************************************************************************
Program 2-10  Using User-Defined INFORMATS to Detect Out-of-Range Data Values
****************************************************************************/
PROC FORMAT;
   INVALUE HR_CK  40-100, . = 9999;
   INVALUE SBP_CK 80-200, . = 9999;
   INVALUE DBP_CK 60-120, . = 9999;
RUN;

DATA _NULL_;
   INFILE "C:\CLEANING\PATIENTS.TXT" PAD;
   FILE PRINT; ***Send output to the output window;
   TITLE "Listing of Invalid Patient Numbers and Data Values";
   ***Note: We will only input those variables of interest;
   INPUT @1  PATNO    $3.
         @15 HR        HR_CK3.
         @18 SBP       SBP_CK3.
         @21 DBP       DBP_CK3.;
   IF HR NE 9999 THEN PUT PATNO= HR=;
   IF SBP NE 9999 THEN PUT PATNO= SBP=;
   IF DBP NE 9999 THEN PUT PATNO= DBP=;
RUN;

/***************************************************************************
Program 2-11  Modifying the Previous Program to Detect Invalid (character) Data 
Values
****************************************************************************/
PROC FORMAT;
   INVALUE HR_CK (UPCASE)
                  40 - 100, .  = 9999
                 'A' - 'Z'     = 8888;
   INVALUE SBP_CK (UPCASE)
                  80 - 200, .  = 9999
                  'A' - 'Z'    = 8888;
   INVALUE DBP_CK (UPCASE) 
                  60 - 120, .  = 9999
                  'A' - 'Z'    = 8888;
RUN;

DATA _NULL_;
   INFILE "C:\CLEANING\PATIENTS.TXT" PAD;
   FILE PRINT; ***Send output to the output window;
   TITLE "Listing of Invalid Patient Numbers and Data Values";
   ***Note: We will only input those variables of interest;
   INPUT @1  PATNO    $3.
         @15 HR        HR_CK3.
         @18 SBP       SBP_CK3.
         @21 DBP       DBP_CK3.;
   IF HR = 8888 THEN PUT PATNO= "Invalid character value for HR";
   ELSE IF HR NE 9999 THEN PUT PATNO= HR=;

   IF SBP = 8888 THEN PUT PATNO= "Invalid character value for SBP";
   ELSE IF SBP NE 9999 THEN PUT PATNO= SBP=;

   IF DBP = 8888 THEN PUT PATNO= "Invalid character value for DBP";
   ELSE IF DBP NE 9999 THEN PUT PATNO= DBP=;

RUN;

/***************************************************************************
Program 2-12 Program to print the top and bottom "n" percent of data values, 
using PROC UNIVARIATE
****************************************************************************/
***Solution using PROC UNIVARIATE and Percentiles;

LIBNAME CLEAN "C:\CLEANING";
***The two macro variables that follow define the lower and upper   
   percentile cut points;

***Change the value in the line below to the percentile cut-off
   you want;
%LET LOW_PER=20; 

***Compute the upper cut-off value;
%LET UP_PER= %EVAL(100 - &LOW_PER); 

***Choose a variable to operate on;
%LET VAR = HR; 

PROC UNIVARIATE DATA=CLEAN.PATIENTS NOPRINT; 
   VAR &VAR;
   ID PATNO;
   OUTPUT OUT=TMP PCTLPTS=&LOW_PER &UP_PER PCTLPRE = L_;  
RUN;

DATA HILO;
   SET CLEAN.PATIENTS(KEEP=PATNO &VAR); 
   ***Bring in upper and lower cutoffs for variable;
   IF _N_ = 1 THEN SET TMP; 
   IF &VAR LE L_&LOW_PER THEN DO;
      RANGE = 'LOW ';
      OUTPUT;
   END;
   ELSE IF &VAR GE L_&UP_PER THEN DO;
      RANGE = 'HIGH';
      OUTPUT;
   END;
RUN;

PROC SORT DATA=HILO(WHERE=(&VAR NE .)); 
   BY DESCENDING RANGE &VAR;
RUN;

PROC PRINT DATA=HILO;
   TITLE "High and Low Values For Variables";
   ID PATNO;
   VAR RANGE &VAR;
RUN;

/***************************************************************************
Program 2-13  Creating a macro to list the highest and lowest "n" percent of the 
data, using PROC UNIVARIATE
****************************************************************************/
*---------------------------------------------------------------*
| Program Name: HILOWPER.SAS  in C:\CLEANING                    |
| Purpose: To list the n percent highest and lowest values for  |
|          a selected variable.                                 |
| Arguments: DSN    - Data set name                             |
|            VAR     - Numeric variable to test                 |
|            PERCENT - Upper and Lower percentile cutoff        |
|            IDVAR   - ID variable to print in the report       |
| Example: %HILOWPER(CLEAN.PATIENTS,SBP,20,PATNO)               |
*---------------------------------------------------------------*;
%MACRO HILOWPER(DSN,VAR,PERCENT,IDVAR);

   ***Compute upper percentile cutoff;
   %LET UP_PER = %EVAL(100 - &PERCENT);

   PROC UNIVARIATE DATA=&DSN NOPRINT;
      VAR &VAR;
      ID &IDVAR;
      OUTPUT OUT=TMP PCTLPTS=&PERCENT &UP_PER PCTLPRE = L_;
   RUN;

   DATA HILO;
      SET &DSN(KEEP=&IDVAR &VAR);
      IF _N_ = 1 THEN SET TMP;
      IF &VAR LE L_&PERCENT THEN DO;
         RANGE = 'LOW ';
         OUTPUT;
      END;
      ELSE IF &VAR GE L_&UP_PER THEN DO;
         RANGE = 'HIGH';
         OUTPUT;
      END;
   RUN;

   PROC SORT DATA=HILO(WHERE=(&VAR NE .));
      BY DESCENDING RANGE &VAR;
   RUN;

   PROC PRINT DATA=HILO;
      TITLE "Low And High Values For Variables";
      ID &IDVAR;
      VAR RANGE &VAR;
   RUN;

   PROC DATASETS LIBRARY=WORK NOLIST;
     DELETE TMP;
     DELETE HILO;
   RUN;
   QUIT;

%MEND HILOWPER ;

/***************************************************************************
Program 2-14 Creating a macro to list the highest and lowest "n" percent of the 
data, using PROC RANK
****************************************************************************/
*----------------------------------------------------------------*
| Macro Name: HI_LOW_P                                           |
| Purpose: To list the upper and lower n% of values              |
| Arguments: DSN     - Data set name (one- or two-level          |
|            VAR     - Variable to test                          |
|            PERCENT - Upper and lower n%                        |
|            IDVAR   - ID variable                               |
| Example: %HI_LOW_P(CLEAN.PATIENTS,SBP,20,PATNO)                |
*----------------------------------------------------------------*;

%MACRO HI_LOW_P(DSN,VAR,PERCENT,IDVAR);
   ***Compute number of groups for PROC RANK;
   %LET GRP = %SYSEVALF(100 / &PERCENT,FLOOR); 
   ***Value of the highest GROUP from PROC RANK, equal to the
      number of groups - 1;
   %LET TOP = %EVAL(&GRP - 1); 

   PROC FORMAT; 
      VALUE RNK 0='Low' &TOP='High';
   RUN;

   PROC RANK DATA=&DSN OUT=NEW GROUPS=&GRP; 
      VAR &VAR;
      RANKS RANGE; 
   RUN;

   ***Sort and keep top and bottom n%;
   PROC SORT DATA=NEW (WHERE=(RANGE IN (0,&TOP))); 
      BY  &VAR;
   RUN;

   ***Produce the report;
   PROC PRINT DATA=NEW; 
      TITLE "Upper and Lower &PERCENT.% Values for %UPCASE(&VAR)";
      ID &IDVAR;
      VAR RANGE &VAR;
      FORMAT RANGE RNK.;
   RUN;

   PROC DATASETS LIBRARY=WORK NOLIST; 
      DELETE NEW;
   RUN;
   QUIT;

%MEND HI_LOW_P;

/***************************************************************************
Program 2-15  Creating a macro to list the top and bottom "n" data values, using 
PROC RANK
****************************************************************************/
*----------------------------------------------------------------*
| Macro Name: HI_LOW_N                                           |
| Purpose: To list N highest and lowest values (approximately)   |
| Arguments: DSN     - Data set name (one- or two-level          |
|            VAR     - Variable to test                          |
|            N       - Number of highest and lowest values       |
|            IDVAR   - ID variable                               |
| Example: %HI_LOW_N(CLEAN.PATIENTS,SBP,10,PATNO)                |
*----------------------------------------------------------------*;
%MACRO HI_LOW_N(DSN,VAR,N,IDVAR);
   ***Find the number of observations in data set;
   %LET DSID = %SYSFUNC(OPEN(&DSN)); 
   %LET N_OBS = %SYSFUNC(ATTRN(&DSID,NOBS));
   %LET RETURN = %SYSFUNC(CLOSE(&DSID));

   ***Compute number of groups, from N and N_OBS;
   %LET GRP = %SYSEVALF(&N_OBS / &N,FLOOR); 
   ***Continue as in the macro based on percents;
   %LET TOP = %EVAL(&GRP - 1);

   PROC FORMAT;
      VALUE RNK 0='Low' &TOP='High';
   RUN;

   PROC RANK DATA=&DSN OUT=NEW GROUPS=&GRP;
      VAR &VAR;
      RANKS RANGE;
   RUN;

   ***Sort and keep top and bottom n%;
   PROC SORT DATA=NEW (WHERE=(RANGE IN (0,&TOP)));
      BY  &VAR;
   RUN;

   ***Produce the report;
   PROC PRINT DATA=NEW;
     TITLE "Approximate Highest And Lowest &N Values for %UPCASE(&VAR)";
      ID &IDVAR;
      VAR RANGE &VAR;
      FORMAT RANGE RNK.;
   RUN;

   PROC DATASETS LIBRARY=WORK NOLIST;
      DELETE NEW;
   RUN;
   QUIT;

%MEND HI_LOW_N;

/***************************************************************************
Program 2-16  Determining the number of nonmissing observations in a data set
****************************************************************************/
***Find the number of nonmissing observations in data set;
PROC MEANS DATA=&DSN NOPRINT;
   VAR &VAR;
   OUTPUT OUT=TMP N=NONMISS;
RUN;

DATA _NULL_;
   SET TMP;
   ***Assign the value of NONMISS to the macro variable N_OBS;
   CALL SYMPUT("N_OBS",NONMISS); 
RUN;

/***************************************************************************
Program 2-17  Listing the highest and lowest "n' values, using PROC SORT
****************************************************************************/
LIBNAME CLEAN "C:\CLEANING";
%LET VAR = HR;  ***Assign values to two macro variables;
%LET IDVAR = PATNO;

PROC SORT DATA=CLEAN.PATIENTS(KEEP=&IDVAR &VAR     
                              WHERE=(&VAR NE .))
                              OUT=TMP;
   BY &VAR;
RUN;

DATA _NULL_;
   TITLE "Ten Highest and Ten Lowest Values for &VAR";
   SET TMP NOBS=NUM_OBS; 
   HIGH = NUM_OBS - 9; 
   FILE PRINT;

   IF _N_ LE 10 THEN DO; 
      IF _N_ = 1 THEN PUT / "Ten Lowest Values" ;
      PUT "&IDVAR = " &IDVAR @15 &VAR;
   END;

   IF _N_ GE HIGH THEN DO; 
      IF _N_ = HIGH THEN PUT / "Ten Highest Values" ;
      PUT "&IDVAR = " &IDVAR @15 &VAR;
   END;

RUN;

/***************************************************************************
Program 2-18  Creating a macro to list the "n" highest and lowest data values, 
using PROCC SORT
****************************************************************************/
*------------------------------------------------------------------*
| Program Name: TEN.SAS  in C:\CLEANING                            |
| Purpose: To list the 10 highest and lowest data values for       |
|          a variable in a SAS data set using Data Step processing |                                             | Arguments: DSN    - Data set name                                |
|            VAR    - Numeric variable to be checked               |
|            IDVAR  - ID variable name                             |
|                                                                  |
| Example: %TEN(CLEAN.PATIENTS,HR,PATNO)                           |
*------------------------------------------------------------------*;

%MACRO TEN(DSN,VAR,IDVAR);

   PROC SORT DATA=&DSN(KEEP=&IDVAR &VAR 
                             WHERE=(&VAR NE .))
                             OUT=TMP;
      BY &VAR;
   RUN;

   DATA _NULL_;
      TITLE "Ten Highest and Ten Lowest Values for %UPCASE(&VAR)";
      SET TMP NOBS=NUM_OBS;
      HIGH = NUM_OBS - 9;
      FILE PRINT;

      IF _N_ LE 10 THEN DO;
         IF _N_ = 1 THEN PUT / "Ten Lowest Values" ;
         PUT "&IDVAR = " &IDVAR @15 "&VAR = " &VAR;
      END;

      IF _N_ GE HIGH THEN DO;
         IF _N_ = HIGH THEN PUT / "Ten Highest Values" ;
         PUT "&IDVAR = " &IDVAR @15 "&VAR = " &VAR;
      END;

   RUN;

%MEND TEN;

/***************************************************************************
Program 2-19  Detecting outliers based on the standard deviation
****************************************************************************/

Cody's Data Cleaning Techniques
corrected program 2-19


LIBNAME CLEAN "C:\CLEANING";
***Output means and standard deviations to a data set;
PROC MEANS DATA=CLEAN.PATIENTS NOPRINT;
   VAR HR SBP DBP;
   OUTPUT OUT=MEANS(DROP=_TYPE_ _FREQ_)
          MEAN=M_HR M_SBP M_DBP
          STD=S_HR S_SBP S_DBP;
RUN;

%LET N_SD = 2; 
*** The number of standard deviations to list;


DATA _NULL_;
   FILE PRINT;
   TITLE "Statistics for Numeric Variables";
   SET CLEAN.PATIENTS;
   ***Bring in the means and standard deviations;
   IF _N_ = 1 THEN SET MEANS;
   ARRAY RAW[3] HR SBP DBP;
   ARRAY _MEAN[3] M_HR M_SBP M_DBP;
   ARRAY _STD[3] S_HR S_SBP S_DBP;

   DO I = 1 TO DIM(RAW);
      IF RAW[I] LT _MEAN[I] - &N_SD*_STD[I] AND RAW[I] NE .
      OR RAW[I] GT _MEAN[I] + &N_SD*_STD[I] THEN PUT PATNO= RAW[I]=;
   END;
RUN;

/***************************************************************************
Program 2-20  Detecting outliers based on a trimmed mean
****************************************************************************/
PROC RANK DATA=CLEAN.PATIENTS OUT=TMP GROUPS=4;
   VAR HR;
   RANKS R_HR;
RUN;

PROC MEANS DATA=TMP NOPRINT;
   WHERE R_HR IN (1,2);  ***The middle 50%;
   VAR HR;
   OUTPUT OUT=MEANS(DROP=_TYPE_ _FREQ_)
          MEAN=M_HR
          STD=S_HR;
RUN;

DATA _NULL_;
   TITLE "Outliers Based on Trimmed Standard Deviation";
   FILE PRINT;

   %LET N_SD = 5.25; 
   ***The value of 5.25 computed from the trimmed mean is 
      approximately equivalent to the 2 standard deviations
      you used before, computed from all the data. Set this
      value approximately 2.65 times larger than the number
      of standard deviations you would compute from untrimmed data;

   SET CLEAN.PATIENTS;
   IF _N_ = 1 THEN SET MEANS;
   IF HR LT M_HR - &N_SD*S_HR AND HR NE .
      OR HR GT M_HR + &N_SD*S_HR THEN PUT PATNO= HR=;
RUN;

/***************************************************************************
Program 2-21  Creating a macro to detect outliers based on a standard deviation
****************************************************************************/
*------------------------------------------------------------------*
| Program Name: SD_ALL.SAS  in C:\CLEANING                         |
| Purpose: To identify outliers based on n standard deviations     |
|          from the mean.                                          |                                             | Arguments: DSN    - Data set name                                |
|            VAR    - Numeric variable to be checked               |
|            IDVAR  - ID variable name                             |
|            N_SD   - The number of standard deviation units for   |
|                     declaring an outlier                         |
|                                                                  |
| Example: %SD_ALL(CLEAN.PATIENTS,HR,PATNO,2)                      |
*------------------------------------------------------------------*;
%MACRO SD_ALL(DSN,VAR,IDVAR,N_SD);

   TITLE1 "Outliers for Variable &VAR Data Set &DSN";
   TITLE2 "Based on &N_SD Standard Deviations";

   PROC MEANS DATA=&DSN NOPRINT;
   VAR &VAR ;
   OUTPUT OUT=MEANS(DROP=_TYPE_ _FREQ_)
          MEAN=M
          STD=S;
   RUN;

   DATA _NULL_;
      FILE PRINT;
      SET &DSN;
      IF _N_ = 1 THEN SET MEANS;
         IF &VAR LT M - &N_SD*S AND &VAR NE .
         OR &VAR GT M + &N_SD*S THEN PUT &IDVAR= &VAR=;
   RUN;

   PROC DATASETS LIBRARY=WORK NOLIST;
      DELETE MEANS;
   RUN;
   QUIT;

%MEND SD_ALL;

/***************************************************************************
Program 2-22  Creating a macro to detect outliers based on a trimmed mean
****************************************************************************/
*-------------------------------------------------------------------*
| Program Name: SD_TRIM.SAS  in C:\CLEANING                         |
| Purpose: To identify outliers based on n standard deviations      |
|          from the mean, computed from the middle 50% of the data. |                                             | Arguments: DSN    - Data set name                                 |
|            VAR    - Numeric variable to be checked                |
|            IDVAR  - ID variable name                              |
|            N_SD   - The number of standard deviation units you    |
|                     would specify if the data values were not     |
|                     trimmed.                                      |
|                                                                   |
| EXAMPLE: %SD_TRIM(CLEAN.PATIENTS,HR,PATNO,2)                      |
*-------------------------------------------------------------------*;
%MACRO SD_TRIM(DSN,VAR,IDVAR,N_SD);

   TITLE1 "Outliers for Variable &VAR Data Set &DSN";
   TITLE2 "Based on &N_SD Standard Deviations Estimated from Trimmed  (50%)Data";

  PROC RANK DATA=&DSN OUT=TMP GROUPS=4;
      VAR &VAR;
      RANKS R;
   RUN;

   PROC MEANS DATA=TMP NOPRINT;
      WHERE R IN (1,2);  ***The middle 50%;
      VAR &VAR;
      OUTPUT OUT=MEANS(DROP=_TYPE_ _FREQ_)
             MEAN=M
             STD=S;
   RUN;

   DATA _NULL_;
      FILE PRINT;
      SET &DSN;
      IF _N_ = 1 THEN SET MEANS;
      IF &VAR LT M - &N_SD*S*2.65 AND &VAR NE .
         OR &VAR GT M + &N_SD*S*2.65 THEN PUT &IDVAR= &VAR=;  
   RUN;

   PROC DATASETS LIBRARY=WORK NOLIST;
      DELETE MEANS;
      DELETE TMP;
   RUN;
   QUIT;

%MEND SD_TRIM;

-----------------------------------------------------------------
Data step to create SAS data set TRIM
-----------------------------------------------------------------

DATA TRIM;
   INPUT X @@;
   PATNO + 1;
DATALINES;
1.02 1.06 1.23 2.00 1.09 1.15 1.23 1.33 1.99 1.11
1.45 156  4.88 2.11 1.54 1.64 1.73 1.19 1.21 1.29
;

/***************************************************************************
Program 2-23  Detecting outliers based on the inter-quartile range
****************************************************************************/
*-------------------------------------------------------------------*
| Program Name: INTER_Q.SAS  in C:\CLEANING                         |
| Purpose: To identify outliers based on n interquartile ranges     |
| Arguments: DSN    - Data set name                                 |
|            VAR    - Numeric variable to be checked                |
|            IDVAR  - ID variable name                              |
|            N_IQR  - The number of interquartile ranges above or   |
|                     below the upper and lower hinge (75th and     |
|                     25th percentile points) to declare a value    |
|                     an outlier.                                   |
|                                                                   |
| Example: %INTER_Q(CLEAN.PATIENTS,HR,PATNO,2)                      |
*-------------------------------------------------------------------*;
%MACRO INTER_Q(DSN,VAR,IDVAR,N_IQR);
   PROC UNIVARIATE DATA=&DSN NOPRINT;
      VAR &VAR;
      OUTPUT OUT=TMP Q3=UPPER Q1=LOWER QRANGE=IQR; 
   RUN;

   DATA _NULL_;
      TITLE "Outliers Based on &N_IQR Interquartile Ranges";
      FILE PRINT;
      SET &DSN;
      IF _N_ = 1 THEN SET TMP;
      IF &VAR LT LOWER - &N_IQR*IQR AND &VAR NE .
         OR &VAR GT UPPER + &N_IQR*IQR THEN PUT &IDVAR= &VAR=;  (2)
   RUN;

   PROC DATASETS LIBRARY=WORK NOLIST;
      DELETE TMP;
   RUN;
   QUIT;

%MEND INTER_Q;

/***************************************************************************
Program 2-24  Writing a program to summarize data errors on several variables
****************************************************************************/
*---------------------------------------------------------------*
| PROGRAM NAME: ERRORSN.SAS  IN C:\CLEANING                     |
| PURPOSE: Accumulates errors for numeric variables in a SAS    |
|          data set for later reporting.                        |
|          This macro can be called several times with a        |
|          different variable each time. The resulting errors   |
|          are accumulated in a temporary SAS data set called   |
|          errors.                                              |
| ARGUMENTS: DSN    - SAS data set name (assigned with a %LET)  |
|            IDVAR  - Id variable (assigned with a %LET)        |
|                                                               |
|            VAR    - The variable name to test                 |
|            LOW    - Lowest valid value                        |
|            HIGH   - Highest valid value                       |
|            M      - Missing value flag.  If=1 count missing   |
|                     values as invalid, =0, missing values OK  |
|                                                               |
| EXAMPLE: %LET DSN = CLEAN.PATIENTS;                           |
|          %LET IDVAR = PATNO;                                  |
|          %ERRORSN(HR,40,100,1)                                |
|          %ERRORSN(SBP,80,200,0)                               |
|          %ERRORSN(DBP,60,120,0)                               |
|          Test the numeric variables HR, SBP, and DBP in data  |
|          set CLEAN.PATIENTS for data outside the ranges       |
|          40 10 100, 80 to 200, and 60 to 120 respectively.    |
|          The ID variable is PATNO and missing values are to   |
|          be flagged as invalid for HR but not for SBP or DBP. |
*---------------------------------------------------------------*;
LIBNAME CLEAN "C:\CLEANING";

%LET DSN=CLEAN.PATIENTS;  ***Define Data set name and; 
%LET IDVAR=PATNO;         ***ID variable;

%MACRO ERRORSN(VAR,LOW,HIGH,M); 

   DATA TMP;
      SET &DSN(KEEP=&IDVAR &VAR); 
      LENGTH REASON $ 10 VARIABLE $ 8; 
      VARIABLE = "&VAR";  
      VALUE = &VAR; 
      IF &VAR LT &LOW AND &VAR NE . THEN DO; 
         REASON='LOW';
         OUTPUT;
      END;
      ELSE IF &VAR EQ . AND &M THEN DO; 
         REASON='MISSING';
         OUTPUT;
      END;
      ELSE IF &VAR GT &HIGH THEN DO; 
         REASON='HIGH';
         OUTPUT;
      END;
      DROP &VAR;
   RUN;

   PROC APPEND BASE=ERRORS DATA=TMP; 
   RUN;
   TITLE "Listing Of Errors In Data Set &DATA ";

%MEND ERRORSN;

***Error Reporting Macro - to be run after ERRORSN has been called
   as may times as desired for each numeric variable to be tested;

%MACRO E_REPORT; 
   PROC SORT DATA=ERRORS; 
      BY &IDVAR;
   RUN;

   PROC PRINT DATA=ERRORS; 
      TITLE "Error Report for Data Set &DSN";
      ID &IDVAR;
      VAR VARIABLE VALUE REASON;
   RUN;

   PROC DATASETS LIBRARY=WORK NOLIST; 
      DELETE ERRORS;
      DELETE TMP;
   RUN;
   QUIT;

%MEND E_REPORT;

-----------------------------------------------------------------
The following programs are located in Chapter 3
-----------------------------------------------------------------
/***************************************************************************
Program 3-1  Counting missing and non-missing values for numeric and character 
Variables
****************************************************************************/
LIBNAME CLEAN "C:\CLEANING";

TITLE "Missing Value Check for the PATIENTS data set";

PROC MEANS DATA=CLEAN.PATIENTS N NMISS;
RUN;

PROC FORMAT;
   VALUE $MISSCNT ' '   = 'MISSING'
                  OTHER = 'NONMISSING';
RUN;

PROC FREQ DATA=CLEAN.PATIENTS;
   TABLES _CHARACTER_ / NOCUM MISSING;
   FORMAT _CHARACTER_ $MISSCNT.;
RUN;

/***************************************************************************
Program 3-2  Writing a simple Data Step to list missing data values and an ID 
Variable
****************************************************************************/
DATA _NULL_;
   INFILE "C:\CLEANING\PATIENTS.TXT" PAD;
   FILE PRINT; ***Send output to the output window;
   TITLE "Listing of Missing Values";
   ***Note: We will only input those variables of interest;
    INPUT @1  PATNO    $3.
        @5  VISIT    MMDDYY10.
        @15 HR       3.
        @27 AE       $1.;
   IF VISIT = .  THEN PUT "Missing or invalid visit date for ID " PATNO;
   IF HR    = .  THEN PUT "Missing or invalid HR for ID " PATNO;
   IF AE    = ' ' THEN PUT "Missing or invalid AE for ID " PATNO;
RUN;

/***************************************************************************
Program 3-3  Attempting to locate a missing or invalid patient ID by listing the 
two previous ID's 
****************************************************************************/
DATA _NULL_;
   SET CLEAN.PATIENTS;
   ***Be sure to run this on the unsorted data set;
   FILE PRINT;
   TITLE "Listing of Missing Patient Numbers";
   PREV_ID = LAG(PATNO);
   PREV2_ID = LAG2(PATNO);
   IF PATNO = ' ' THEN PUT "Missing Patient ID. Two previous ID's are:"
      PREV2_ID "and " PREV_ID / @5 "Missing Record is number " _N_;
   ELSE IF INPUT(PATNO,?? 3.)  = . THEN
      PUT "Invalid Patient ID:" PATNO +(-1)". Two previous ID's are:"
      PREV2_ID "and " PREV_ID / @5 "Missing Record is number " _N_;
RUN;

/***************************************************************************
Program 3-4  Using PROC PRINT to list data for missing or invalid patient ID's
****************************************************************************/
PROC PRINT DATA=CLEAN.PATIENTS;
   TITLE "Data Listing for Patients with Missing or Invalid ID's";
   WHERE PATNO = ' ' OR INPUT(PATNO,3.) = .;
RUN;

/***************************************************************************
Program 3-5  Listing and counting missing values for selected variables
****************************************************************************/
DATA _NULL_;
   INFILE "C:\CLEANING\PATIENTS.TXT" PAD END=LAST;
   FILE PRINT; ***Send output to the output window;
   TITLE "Listing of Missing Values";
   ***Note: We will only input those variables of interest;
    INPUT @1  PATNO    $3.
        @5  VISIT    MMDDYY10.
        @15 HR       3.
        @27 AE       $1.;
   IF VISIT = . THEN DO;
      PUT "Missing or invalid visit date for ID " PATNO;
      N_VISIT + 1;
   END;
   IF HR    = . THEN DO;
      PUT "Missing or invalid HR for ID " PATNO;
      N_HR + 1;
   END;
   IF AE    = ' ' THEN DO;
      PUT "Missing or invalid AE for ID " PATNO;
      N_AE + 1;
   END;

   IF LAST THEN
           PUT // "Summary of missing values" /
           25*'-' /
           "Number of missing dates = " N_VISIT /
           "Number of missing HR's = " N_HR /
           "Number of missing adverse events = " N_AE;
RUN;

/***************************************************************************
Program 3-6  Listing the number of nonmissing and missing values, the minimum 
and maximum value for all numeric variables
****************************************************************************/
PROC TABULATE DATA=CLEAN.PATIENTS FORMAT=8.;
   TITLE "Missing Values, Low and High Values for Numeric Variables";
   VAR HR SBP DBP;
   TABLE HR SBP DBP,
         N NMISS MIN MAX / RTSPACE=26;
   KEYLABEL N       = 'Number'
            NMISS   = 'Number Missing'
            MIN     = 'Lowest Value'
            MAX     = 'Highest Value';
RUN;

/***************************************************************************
Program 3-7  Using PROC TABULATE to count missing values for character variables
****************************************************************************/
PROC FORMAT;
   VALUE $MISSCH ' ' = 'Missing'
                 OTHER = 'Nonmissing';
RUN;

PROC TABULATE DATA=CLEAN.PATIENTS MISSING FORMAT=8.;
   CLASS PATNO DX AE;
   TABLE PATNO DX AE,
         N / RTSPACE=26;
   FORMAT PATNO DX AE $MISSCH.;
   KEYLABEL N     = 'Number';
RUN;

/***************************************************************************
Program 3-8  Writing a macro to count the number of missing and non-missing 
observations for all numeric and character variables in a data set
****************************************************************************/
*----------------------------------------------------------------*
| Program Name: AUTOMISS.SAS  in C:\CLEANING                     |
| Purpose: Macro to list the number of missing and nonmissing    |
|          variables in a SAS data set                           |
| Arguments: DSNAME =  SAS data set name (one or two level)      |
| Example: %AUTOMISS(CLEAN.PATIENTS)                             |
*----------------------------------------------------------------*;

%MACRO AUTOMISS(DSNAME);

   %***Single level data set name;
   %IF %INDEX(&DSNAME,.) = 0 %THEN %DO; 
      %LET LIB = WORK;
      %LET DSN = %UPCASE(&DSNAME);
   %END;

   %***Two level data set name;
   %ELSE %DO; 
      %LET LIB = %UPCASE(%SCAN(&DSNAME,1,"."));
      %LET DSN = %UPCASE(%SCAN(&DSNAME,2,"."));
   %END;

   %*Note: it is important for the libname and Data set name to
     be in upper case;

   %* Initialize macro variables to null;
   %LET NVARLIST=;
   %LET CVARLIST=;
 
   TITLE1 "Number of Missing and Nonmissing Values from &DSNAME";
   %* Get list of numeric variables;
   PROC SQL NOPRINT;
      SELECT NAME INTO :NVARLIST SEPARATED BY " "  
      FROM DICTIONARY.COLUMNS  
      WHERE LIBNAME = "&LIB" AND MEMNAME = "&DSN" AND TYPE = "num";  

   %* Get list of character variables;
   SELECT NAME INTO :CVARLIST SEPARATED BY " "  
      FROM DICTIONARY.COLUMNS
      WHERE LIBNAME = "&LIB" AND MEMNAME = "&DSN" AND TYPE = "char"; 
   QUIT;

   PROC FORMAT; 
      VALUE $MISSCH " " = "Missing"
                    OTHER = "Nonmissing";
   RUN;

   PROC TABULATE DATA=&LIB..&DSN MISSING FORMAT=8.; 

      %* If there are any numeric variables, do the following;
      %IF &NVARLIST NE %THEN %DO;
         VAR &NVARLIST;
         TITLE2 "for Numeric Variables";
         TABLE &NVARLIST,
            N NMISS MIN MAX / RTSPACE=26;
      %END;

      %* If there are any character variables, do the following;
      %IF &CVARLIST NE %THEN %DO;
         CLASS &CVARLIST;
         TITLE2 "for Character Variables";
         TABLE &CVARLIST,
            N / RTSPACE=26;
         FORMAT &CVARLIST $MISSCH.;
       %END;

      KEYLABEL N     = "Number"
      NMISS = "Number Missing"
      MIN   = "Lowest Value"
      MAX   = "Highest Value";
   RUN;

%MEND AUTOMISS;

/***************************************************************************
Program 3-9  Identifying all numeric variables equal to a fixed value (such as 
999)
****************************************************************************/
*----------------------------------------------------------------*
| Program Name: FIND_X.SAS  in C:\CLEANING                       |
| Purpose: Identifies any specified value for all numeric vars   |
*----------------------------------------------------------------*;
***Create test data set;
DATA TEST;
   INPUT X Y A $ X1-X3 Z $;
DATALINES;
1 2 X 3 4 5 Y
2 999 Y 999 1 999 J
999 999 R 999 999 999 X
1 2 3 4 5 6 7
;
***Program to detect the specified values;
DATA _NULL_;
   SET TEST;
   FILE PRINT;
   ARRAY NUMS[*] _NUMERIC_;  
   LENGTH VARNAME $ 8;
   DO __I = 1 TO DIM(NUMS); 
      IF NUMS[__I] = 999 THEN DO;
         CALL VNAME(NUMS[__I],VARNAME); 
         PUT "Value of 999 found for variable " VARNAME
             "in observation " _N_;
      END;
   END;
   DROP __I;
RUN;

/***************************************************************************
Program 3-10 Creating a macro version of Program 3-9
****************************************************************************/
*----------------------------------------------------------------*
| Macro Name: FIND_X.SAS  in C:\CLEANING                         |
| Purpose: Identifies any specified value for all numeric vars   |
| Calling Arguments: DSN   SAS Data Set Name                     |
|                    NUM   Numeric value to search for           |
| Example:  To find variable values of 999 in data set TEST, use |           |           %FIND_X(TEST,999)                                    |
*----------------------------------------------------------------*;
%MACRO FIND_X(DSN,NUM);
   DATA _NULL_;
      SET &DSN;
      FILE PRINT;
      LENGTH VARNAME $ 8;
      ARRAY NUMS[*] _NUMERIC_;
      DO __I = 1 TO DIM(NUMS);
         IF NUMS[__I] = &NUM THEN DO;
            CALL VNAME(NUMS[__I],VARNAME);
            PUT "Value of &NUM found for variable " VARNAME
                "in observation " _N_;
         END;
      END;
      DROP __I;
   RUN;
%MEND FIND_X;

/***************************************************************************
Program 3-11  Identifying variables with specified numeric values and counting 
the number of times the value appears 
****************************************************************************/
DATA NUM_999;
   SET TEST;
   FILE PRINT;
   ARRAY NUMS[*] _NUMERIC_;
   LENGTH VARNAME $ 8;
   DO __I = 1 TO DIM(NUMS);
      IF NUMS[__I] = 999 THEN DO;
         CALL VNAME(NUMS[__I],VARNAME);
         OUTPUT;
      END;
   END;
   KEEP VARNAME;
RUN;

PROC FREQ DATA=NUM_999;
   TABLES VARNAME / NOCUM NOPERCENT;
RUN;

-----------------------------------------------------------------
The following programs are located in Chapter 4
-----------------------------------------------------------------
/***************************************************************************
Program 4-1  Checking that a date is within a specified interval (Data Step 
approach)
****************************************************************************/
LIBNAME CLEAN "C:\CLEANING";

DATA _NULL_;
   TITLE "Dates Before June 1, 1998 or After October 15, 1999";
   FILE PRINT;
   SET CLEAN.PATIENTS(KEEP=VISIT PATNO);
   IF VISIT LT '01JUN1998'D AND VISIT NE . OR
      VISIT GT '15OCT1999'D THEN PUT PATNO= VISIT= MMDDYY10.;
RUN;

/***************************************************************************
Program 4-2 Checking that a date is within a specified interval (using PROC 
PRINT and a WHERE statement)
****************************************************************************/
PROC PRINT DATA=CLEAN.PATIENTS;
   TITLE "Dates Before June 1, 1998 or After October 15, 1999";
   WHERE VISIT NOT BETWEEN '01JUN1998'D AND '15OCT1999'D AND VISIT NE .;
   ID PATNO;
   VAR VISIT;
   FORMAT VISIT DATE9.;
RUN;

/***************************************************************************
Program 4-3  Reading dates with the MMDDYY10. INFORMAT
****************************************************************************/
DATA DATES;
   INFILE "C:\CLEANING\PATIENTS.TXT" PAD;
   INPUT @5 VISIT MMDDYY10.;
   FORMAT VISIT MMDDYY10.;
RUN;

/***************************************************************************
Program 4-4  Listing missing and invalid dates by reading the date twice, once 
with a date informat and the second time as character data
****************************************************************************/
DATA _NULL_;
   FILE PRINT;
   TITLE "Listing of Missing and Invalid Dates";
   INFILE "C:\CLEANING\PATIENTS.TXT" PAD;
   INPUT @1 PATNO $3.
         @5 VISIT MMDDYY10.
         @5 V_DATE $CHAR10.;
   FORMAT VISIT MMDDYY10.;
   IF VISIT = . THEN PUT PATNO= V_DATE=;
RUN;

/***************************************************************************
Program 4-5  Listing missing and invalid dates by reading the date as a 
character variable and converting to a SAS date with the INPUT function
****************************************************************************/
DATA _NULL_;
   FILE PRINT;
   TITLE "Listing of Missing and Invalid Dates";
   INFILE "C:\CLEANING\PATIENTS.TXT" PAD;
   INPUT @1 PATNO $3.
         @5 V_DATE $CHAR10.;
   VISIT = INPUT(V_DATE,MMDDYY10.);
   FORMAT VISIT MMDDYY10.;
   IF VISIT = . THEN PUT PATNO= V_DATE=;
RUN;

/***************************************************************************
Program 4-6  Removing the missing values from the invalid date listing
****************************************************************************/
DATA _NULL_;
   FILE PRINT;
   INFILE "C:\CLEANING\PATIENTS.TXT" PAD;
   INPUT @1 PATNO $3.
         @5 V_DATE $CHAR10.;
   VISIT = INPUT(V_DATE,MMDDYY10.);
   FORMAT VISIT MMDDYY10.;
   IF VISIT = . AND V_DATE NE ' ' THEN PUT PATNO= V_DATE=;  
RUN;

/***************************************************************************
Program 4-7  Demonstrating the MDY function to read dates in non-standard form
****************************************************************************/
***Sample program to read non-standard dates;
DATA NONSTAND;
   INPUT PATNO $ 1-3 MONTH 6-7 DAY 13-14 YEAR 20-23;
   DATE = MDY(MONTH,DAY,YEAR);
   FORMAT DATE MMDDYY10.;
DATALINES;
001  05     23     1998
006  11     01     1998
123  14     03     1998
137  10            1946
;
PROC PRINT DATA=NONSTAND;
   TITLE "Listing of Data Set NONSTAND";
   ID PATNO;
RUN;

/***************************************************************************
Program 4-8  Removing missing values from the error listing
****************************************************************************/
DATA _NULL_;
   FILE PRINT;
   TITLE "Invalid Date Values";
   INPUT PATNO $ 1-3 MONTH 6-7 DAY 13-14 YEAR 20-23;
   DATE = MDY(MONTH,DAY,YEAR);
   C_DATE = PUT(MONTH,Z2.) || '/' ||
            PUT(DAY,Z2.) || '/' ||
            PUT(YEAR,4.);
   ***Note: the Z2. Format includes leading zeros;
   FORMAT DATE MMDDYY10.;
   IF C_DATE NE ' ' AND DATE = . THEN PUT PATNO= C_DATE=;
DATALINES;
001  05     23     1998
006  11     01     1998
123  14     03     1998
137  10            1946
;

/***************************************************************************
Program 4-9  Creating a SAS date when the day of the month is missing
****************************************************************************/
DATA NO_DAY;
   INPUT @1 DATE1 MONYY7. @8 MONTH 2. @10 YEAR 4.;
   DATE2 = MDY(MONTH,15,YEAR);
   FORMAT DATE1 DATE2 MMDDYY10.;
DATALINES;
JAN98  011998
OCT1998101998
;
PROC PRINT DATA=NO_DAY;
   TITLE "Listing of Data Set NO_DAY";
RUN;

/***************************************************************************
Program 4-10  Substituting the 15th of the month when the date of the month is 
Missing
****************************************************************************/
DATA MISS_DAY;
   INPUT @1  PATNO  $3.
         @4  MONTH   2.
         @6  DAY     2.
         @8  YEAR    4.;
   IF DAY NE . THEN DATE = MDY(MONTH,DAY,YEAR);
   ELSE DATE = MDY(MONTH,15,YEAR);
   FORMAT DATE MMDDYY10.;
DATELINES;
00110211998
00205  1998
00344  1998
;
PROC PRINT DATA=MISS_DAY;
   TITLE "Listing of Data Set MISS_DAY";
RUN;

/***************************************************************************
Program 4-11  Suspending error checking for known invalid dates, using the ?? 
informat modifier
****************************************************************************/
DATA DATES;
   INFILE "C:\CLEANING\PATIENTS.TXT" PAD;
   INPUT @5 VISIT ?? MMDDYY10.;
   FORMAT VISIT MMDDYY10.;
RUN;

/***************************************************************************
Program 4-12  Demonstrating the ?? informat modifier with the INPUT function
****************************************************************************/
DATA _NULL_;
   FILE PRINT;
   INFILE "C:\CLEANING\PATIENTS.TXT" PAD;
   INPUT @1 PATNO $3.
         @5 V_DATE $CHAR10.;
   VISIT = INPUT(V_DATE,?? MMDDYY10.);
   FORMAT VISIT MMDDYY10.;
   IF VISIT = . THEN PUT PATNO= V_DATE=;
RUN;

-----------------------------------------------------------------
The following programs are located in Chapter 5
-----------------------------------------------------------------
/***************************************************************************
Program 5-1  Demonstrating the NODUPKEY option of PROC SORT
****************************************************************************/
PROC SORT DATA=CLEAN.PATIENTS OUT=SINGLE NODUPKEY;
   BY PATNO;
RUN;

PROC PRINT DATA=SINGLE;
   TITLE "Data Set SINGLE - Duplicated ID's Removed from PATIENTS";
   ID PATNO;
RUN;

/***************************************************************************
Program 5-2  Demonstrating the NODUP option of PROC SORT
****************************************************************************/
PROC SORT DATA=CLEAN.PATIENTS OUT=SINGLE NODUP;
   BY _ALL_;
RUN;

/***************************************************************************
Program 5-3 Demonstrating a "feature" of the NODUP option
****************************************************************************/
DATA MULTIPLE;
   INPUT PATNO $ X Y;
DATALINES;
001 1 2
006 1 2
009 1 2
001 3 4
001 1 2
009 1 2
001 1 2
;
PROC SORT DATA=MULTIPLE OUT=SINGLE NODUP;
   BY PATNO;
RUN;
PROC PRINT DATA=SINGLE;
   TITLE "Listing of Data Set SINGLE";
RUN;

/***************************************************************************
Program 5-4  Identifying duplicate ID's
****************************************************************************/
PROC SORT DATA=CLEAN.PATIENTS OUT=TMP; 
   BY PATNO;
RUN;

DATA DUP;
   SET TMP;
   BY PATNO; 
   IF FIRST.PATNO AND LAST.PATNO THEN DELETE; 
RUN;

PROC PRINT DTA=DUP;
   TITLE "Listing of Duplicates from Data Set CLEAN.PATIENTS";
   ID PATNO;
RUN;

/***************************************************************************
Program 5-5  Creating the SAS data set, PATIENTS2 (a data set containing 
multiple visits for each patient)
****************************************************************************/
LIBNAME CLEAN "C:\CLEANING";

DATA CLEAN.PATIENT2;
   INFILE "C:\CLEANING\PATIENT2.TXT" PAD;
   INPUT @1  PATNO  $3.
         @4  VISIT  MMDDYY10.
         @14 HR      3.
         @17 SBP     3.
         @20 DBP     3.;
   FORMAT VISIT MMDDYY10.;
RUN;

/***************************************************************************
Program 5-6  Identifying patient ID's with duplicate visit dates
****************************************************************************/
PROC SORT DATA=CLEAN.PATIENT2 OUT=TMP; 
   BY PATNO VISIT;
RUN;

DATA DUP;
   SET TMP;
   BY PATNO VISIT; 
   IF FIRST.VISIT AND LAST.VISIT THEN DELETE; 
RUN;

PROC PRINT DTA=DUP;
   TITLE "Listing of Duplicates from Data Set CLEAN.PATIENT2";
   ID PATNO;
RUN;

/***************************************************************************
Program 5-7  Using PROC FREQ and an output data set to identify duplicate ID's
****************************************************************************/
PROC FREQ DATA=CLEAN.PATIENTS NOPRINT; 
   TABLES PATNO / OUT=DUP_NO(KEEP=PATNO COUNT
                             WHERE=(COUNT GT 1)); 
RUN;

PROC SORT DATA=CLEAN.PATIENTS OUT=TMP;
   BY PATNO;
RUN;


PROC SORT DATA=DUP_NO;
   BY PATNO;
RUN;

DATA DUP;
   MERGE TMP DUP_NO(IN=YES_DUP DROP=COUNT); 
   BY PATNO;
   IF YES_DUP; 
RUN;

PROC PRINT DATA=DUP;
   TITLE "Listing of Data Set DUP";
RUN;

/***************************************************************************
Program 5-8  Producing a list of duplicate patient numbers, using PROC FREQ
****************************************************************************/
PROC FREQ DATA=CLEAN.PATIENTS NOPRINT;
   TABLES PATNO / OUT=DUP_NO(KEEP=PATNO COUNT
                             WHERE=(COUNT GT 1));
RUN;

DATA _NULL_;
   TITLE "Patients with Duplicate Observations";
   FILE PRINT;
   SET DUP_NO;
   PUT "Patient number " PATNO "has " COUNT "observation(s).";
RUN;

/***************************************************************************
Program 5-9  Using SQL to create a list of duplicates
****************************************************************************/
PROC SQL NOPRINT;
   SELECT QUOTE(PATNO) 
      INTO :DUP_LIST SEPARATED BY " "  
      FROM DUP_NO;
QUIT;

PROC PRINT DATA=CLEAN.PATIENTS;
   WHERE PATNO IN (&DUP_LIST); 
   TITLE "Duplicates Selected Using SQL and a Macro Variable";
RUN;

/***************************************************************************
Program 5-10  Using SQL to create a list of duplicates (in sorted order)
****************************************************************************/
PROC SQL NOPRINT;
   SELECT QUOTE(PATNO)
      INTO :DUP_LIST SEPARATED BY " "
      FROM DUP_NO;
QUIT;

DATA TMP;
   SET CLEAN.PATIENTS;
   WHERE PATNO IN (&DUP_LIST);
RUN;

PROC SORT DATA=TMP;
   BY PATNO;
RUN;

PROC PRINT DATA=TMP;
   TITLE "Duplicates Selected Using SQL and a Macro Variable";
RUN;

/***************************************************************************
Program 5-11  Using a Data Step to list all ID's for subjects who do not have 
exactly two observations
****************************************************************************/
PROC SORT DATA=CLEAN.PATIENT2(KEEP=PATNO) OUT=TMP;
   BY PATNO;
RUN;

DATA _NULL_;
   TITLE "Patient ID's for Patients with Other than Two Observations";
   FILE PRINT;
   SET TMP;  
   BY PATNO; 
   IF FIRST.PATNO THEN N = 1; 
   ELSE N + 1; 
   IF LAST.PATNO AND N NE 2 THEN PUT  
      "Patient number " PATNO "has " N "observation(s)."; 
RUN;

/***************************************************************************
Program 5-12 Using PROC FREQ to list all ID's for subjects who do not have 
exactly two observations
****************************************************************************/
PROC FREQ DATA=CLEAN.PATIENT2 NOPRINT; 
   TABLES PATNO / OUT=DUP_NO(KEEP=PATNO COUNT
                             WHERE=(COUNT NE 2)); 
RUN;

DATA _NULL_;
   TITLE "Patient ID's for Patients with Other than Two Observations";
   FILE PRINT;
   SET DUP_NO;
   PUT "Patient number " PATNO "has " COUNT "observation(s)."; 
RUN;

-----------------------------------------------------------------
The following programs are located in Chapter 6
-----------------------------------------------------------------
/***************************************************************************
Program 6-1  Creating two test data sets for Chapter 6 examples
****************************************************************************/
DATA ONE;
   INPUT PATNO X Y;
DATALINES;
1 69 79
2 56 .
3 66 99
5 98 87
12 13 14
;
DATA TWO;
   INPUT PATNO Z;
DATALINES;
1 56
3 67
4 88
5 98
13 99
;

/***************************************************************************
Program 6-2  Identifying ID's not in each of two data sets
****************************************************************************/
PROC SORT DATA=ONE; 
   BY PATNO;
RUN;

PROC SORT DATA=TWO; 
   BY PATNO;
RUN;

DATA _NULL_;
   FILE PRINT;
   TITLE "Listing of Missing ID's";
   MERGE ONE(IN=INONE)
         TWO(IN=INTWO)  END=LAST; 
   BY PATNO; 

   IF NOT INONE THEN DO; 
      PUT "ID " PATNO "is not in data set ONE";
      N + 1;
   END;

   ELSE IF NOT INTWO THEN DO; 
      PUT "ID " PATNO "is not in data set TWO";
      N + 1;
   END;

   IF LAST AND N EQ 0 THEN
      PUT "All ID's Match in Both Files";  

RUN;

/***************************************************************************
Program 6-3  Creating a third data set for testing purposes
****************************************************************************/
DATA THREE;
   INPUT PATNO GENDER $ @@;
DATALINES;
1 M 2 F 3 M 5 F 6 M 12 M 13 M
;

/***************************************************************************
Program 6-4  Checking for an ID in each of three data sets (long way)
****************************************************************************/
PROC SORT DATA=ONE(KEEP=PATNO) OUT=TMP1;
   BY PATNO;
RUN;

PROC SORT DATA=TWO(KEEP=PATNO) OUT=TMP2;
   BY PATNO;
RUN;

PROC SORT DATA=THREE(KEEP=PATNO) OUT=TMP3;
   BY PATNO;
RUN;

DATA _NULL_;
   FILE PRINT;
   TITLE "Listing of Missing ID's and Data Set Names";
   MERGE TMP1(IN=IN1)
         TMP2(IN=IN2)
         TMP3(IN=IN3)  END=LAST;
   BY PATNO;

   IF NOT IN1 THEN DO;
      PUT "ID " PATNO "missing from data set ONE";
      N + 1;
   END;

IF NOT IN2 THEN DO;
      PUT "ID " PATNO "missing from data set TWO";
      N + 1;
   END;

   IF NOT IN3 THEN DO;
      PUT "ID " PATNO "missing from data set THREE";
      N + 1;
   END;

   IF LAST AND N EQ 0 THEN
      PUT "All ID's Match in All Files";

RUN;

/***************************************************************************
Program 6-5  Creating a macro to check for an ID in each of "n" files (simple 
way)
****************************************************************************/
*-----------------------------------------------------------------*
| Program Name: ID_SIMP.SAS  in C:\CLEANING                       |
| Purpose: Simple version of the macro to test if an ID exits in  |
|          each of up to 10 data sets                             |
| Arguments: ID     - Name of the ID variable                     |
|            DSNn   - Name of the nth data set                    |
| Example:  %ID_SIMP(PATNO,ONE,TWO,THREE)                         |
*-----------------------------------------------------------------*;
%MACRO ID_SIMP(ID,DSN1,DSN2,DSN3,DSN4,DSN5,
                  DSN6,DSN7,DSN8,DSN9,DSN10);
   TITLE "Report of ID's Not in All Data Sets";

***Sorting section;
   %DO I = 1 %TO 10; 
      %IF &&DSN&I NE %THEN %DO; /* If non null argument */  
         %LET N_DATA = &I; 
         PROC SORT DATA = &&DSN&I(KEEP=&ID) OUT=TMP&I; 
            BY &ID;
         RUN;
      %END;
      %ELSE %LET I = 10;  /* Stop the loop when DSNn is null */  
   %END;

   ***Create MERGE statements;
   DATA _NULL_;
      FILE PRINT;
      MERGE

      %DO I = 1 %TO &N_DATA; 
         &&DSN&I(IN=IN&I)
      %END;

      END=LAST; 
      ***End MERGE statement;

      BY &ID;

      ***Error reporting section;
      %DO I = 1 %TO &N_DATA; 
         IF NOT IN&I THEN DO;
            PUT "ID " &ID "Missing from data set &&DSN&I";
            N + 1;
         END;
      %END;

      IF LAST AND N EQ 0 THEN DO; 
         PUT "All ID's Match in All Files";
         STOP;
      END;


   RUN;

%MEND ID_SIMP;

/***************************************************************************
Program 6-6  Writing a more general macro to handle any number of data sets
****************************************************************************/
*----------------------------------------------------------------*
| Program Name: CHECK_ID.SAS  in C:\CLEANING                     |
| Purpose: Macro which checks if an ID exists in each of n files |
| Arguments: The name of the ID variable, followed by as many    |
|            data sets names as desired, separated by BLANKS     |
| Example: %CHECK_ID(PATNO,ONE TWO THREE)                        |
*----------------------------------------------------------------*;
%MACRO CHECK_ID(ID,DS_LIST); 
   %LET STOP = 999;  /* Initialize stop at a large value */
   %DO I = 1 %TO &STOP;
      %LET DSN = %SCAN(&DS_LIST,&I);  /* Break up list 
                                         into data set names */
      %IF &DSN NE %THEN  /* If non null argument */  
      %DO;
         %LET N = &I;    /* the number of data sets */
         PROC SORT DATA=&DSN(KEEP=&ID) OUT=TMP&I;
            BY &ID;
         RUN;
      %END;
      %ELSE %LET I = &STOP;  /* Set index to max so loop stops */
   %END;

   DATA _NULL_;
      FILE PRINT;
      MERGE

      %DO I = 1 %TO &N;
         TMP&I(IN=IN&I)
      %END;

      END=LAST;
      BY &ID;

      %DO I = 1 %TO &N;
         %LET DSN = %SCAN(&DS_LIST,&I);
         IF NOT IN&I THEN DO;
            PUT "ID " &ID "missing from data set &DSN";
            NN + 1;
         END;
      %END;

      IF LAST AND NN EQ 0 THEN DO;
         PUT "All ID's Match in All Files";
         STOP;
      END;

      RUN;

%MEND CHECK_ID;

/***************************************************************************
Program 6-7  Verifying that patients with an adverse event of "X" in data set 
 (AE) have an entry in data set LAB_TEST
****************************************************************************/
PROC SORT DATA=CLEAN.AE OUT=AE_X;  
   WHERE A_EVENT = 'X'; 
   BY PATNO;
RUN;

PROC SORT DATA=CLEAN.LAB_TEST(KEEP=PATNO LAB_DATE) OUT=LAB;
   BY PATNO;
RUN;

DATA MISSING;
   MERGE AE_X
         LAB(IN=IN_LAB); 
   BY PATNO;
   IF NOT IN_LAB; 
RUN;

PROC PRINT DATA=MISSING LABEL;
   TITLE "Patients with AE of X who are missing Lab Test Entry";
   ID PATNO;
   VAR DATE_AE A_EVENT;
RUN;

/***************************************************************************
Program 6-8  Adding the condition that the lab test must follow the adverse 
Event
****************************************************************************/
TITLE  "Patients with AE of X who are Missing Lab Test Entry";
TITLE2 "or the Date of the Lab Test is Earlier than the AE Date";
TITLE3 "-------------------------------------------------------";

DATA _NULL_;
   FILE PRINT;
   MERGE AE_X(IN=IN_AE)
         LAB(IN=IN_LAB);
   BY PATNO;
   IF NOT IN_LAB THEN PUT
      "No Lab Test for Patient " PATNO "With Adverse Event X";
   ELSE IF IN_AE AND LAB_DATE EQ . THEN PUT  
      "Date of Lab Test is Missing for Patient "
      PATNO /
      "Date of AE is " DATE_AE /;
   ELSE IF IN_AE AND LAB_DATE LT DATE_AE THEN PUT  
      "Date of Lab Test is Earlier than Date of AE for Patient "
      PATNO /
      "  Date of AE is " DATE_AE " Date of Lab Test is " LAB_DATE /;
RUN;

-----------------------------------------------------------------
The following programs are located in Chapter 7
-----------------------------------------------------------------

/***************************************************************************
Program 7-1  Creating data sets ONE and TWO from two raw data files
****************************************************************************/
DATA ONE;
   INFILE "C:\CLEANING\FILE_1" PAD;
   INPUT @1  PATNO  3.
         @4  GENDER $1.
         @5  DOB    MMDDYY8.
         @13 SBP    3.
         @16 DBP    3.;
   FORMAT DOB MMDDYY10.;
RUN;
        
DATA TWO;
   INFILE "C:\CLEANING\FILE_2" PAD;
   INPUT @1  PATNO  3.
         @4  GENDER $1.
         @5  DOB    MMDDYY8.
         @13 SBP    3.
         @16 DBP    3.;
FORMAT DOB MMDDYY10.;
RUN;

/***************************************************************************
Program 7-2  Running PROC COMPARE
****************************************************************************/
PROC COMPARE BASE=ONE COMPARE=TWO;
   TITLE "Using PROC COMPARE to Compare Two Data Sets";
RUN;

/***************************************************************************
Program 7-3  Using PROC COMPARE to compare two data records
****************************************************************************/
DATA ONE;
   INFILE "C:\CLEANING\FILE_1" PAD;
   INPUT STRING $CHAR18.;
RUN;

DATA TWO;
   INFILE "C:\CLEANING\FILE_2" PAD;
   INPUT STRING $CHAR18.;
RUN;

PROC COMPARE BASE=ONE COMPARE=TWO BRIEF;
   TITLE "Treating Each Line as a String";
RUN;

/***************************************************************************
Program 7-4  Using PROC COMPARE with an ID variable
****************************************************************************/
PROC COMPARE BASE=ONE COMPARE=TWO;
   TITLE "Using PROC COMPARE to Compare Two Data Sets";
   ID PATNO;
RUN;

/***************************************************************************
Program 7-5  Running PROC COMPARE on two data sets of different length
****************************************************************************/
PROC COMPARE BASE=ONE_B COMPARE=TWO_B;
   TITLE "Comparing Two Data Sets with Different ID Values";
   ID PATNO;
RUN;

/***************************************************************************
Program 7-6  Creating two test data sets, DEMOG and OLDDEMOG
****************************************************************************/
***Program to create data sets DEMOG and OLDDEMOG;
DATA DEMOG;
   INPUT  @1  PATNO  3.
          @4  GENDER $1.
          @5  DOB    MMDDYY10.
          @15 HEIGHT 2.;
   FORMAT DOB MMDDYY10.;
DATALINES;
001M10/21/194668
003F11/11/105062
004M04/05/193072
006F05/13/196863
;
DATA OLDDEMOG;
   INPUT @1  PATNO  3.
         @4  DOB    MMDDYY8.
         @12 GENDER $1.
         @13 WEIGHT 3.;
   FORMAT DOB MMDDYY10.;
DATALINES;
00110211946M155
00201011950F102
00404051930F101
00511111945M200
00605131966F133
;

/***************************************************************************
Program 7-7  Comparing two data sets that contain different variables
****************************************************************************/
PROC COMPARE BASE=OLDDEMOG COMPARE=DEMOG BRIEF;
   TITLE "Comparing demographic information between two data sets";
   ID PATNO;
RUN;

/***************************************************************************
Program 7-8  Adding a VAR statement to PROC COMPARE
****************************************************************************/
PROC COMPARE BASE=OLDDEMOG COMPARE=DEMOG BRIEF;
   TITLE "Comparing demographic information between two data sets";
   ID PATNO;
   VAR GENDER;
RUN;

-----------------------------------------------------------------
The following programs are located in Chapter 8
-----------------------------------------------------------------

/***************************************************************************
Program 8-1  Demonstrating a simple SQL query
****************************************************************************/
PROC SQL;
   SELECT X
   FROM ONE
   WHERE X GT 100;
QUIT;

/***************************************************************************
Program 8-2  Using SQL to look for invalid character values
****************************************************************************/
LIBNAME CLEAN "C:\CLEANING";
***Checking for invalid character data;
PROC SQL;
   TITLE "Checking for invalid character data";
   SELECT PATNO,
          GENDER,
          DX,
          AE
   FROM CLEAN.PATIENTS
   WHERE GENDER NOT IN ('M','F')           OR
         VERIFY(DX,'0123456789 ') NE 0     OR
         AE NOT IN ('0','1');
QUIT;

/***************************************************************************
Program 8-3  Using SQL to list invalid character data: missing values not 
flagged as errors
****************************************************************************/
PROC SQL;
   TITLE "Checking for invalid character data";
   TITLE2 "Missing values not flagged as errors";
   SELECT PATNO,
          GENDER,
          DX,
          AE
   FROM CLEAN.PATIENTS
   WHERE GENDER NOT IN ('M','F',' ')       OR
         VERIFY(DX,'0123456789 ') NE 0     OR
         AE NOT IN ('0','1',' ');
QUIT;

/***************************************************************************
Program 8-4  Using SQL to check for out of range numeric values
****************************************************************************/
PROC SQL;
   TITLE "Checking for out of range numeric values";
   SELECT PATNO,
          HR,
          SBP,
          DBP
   FROM CLEAN.PATIENTS
   WHERE HR  NOT BETWEEN 40 AND 100       OR
         SBP NOT BETWEEN 80 AND 200       OR
         DBP NOT BETWEEN 60 AND 120;
QUIT;

/***************************************************************************
Program 8-5  Using SQL to check for out-of-range values, based on the standard 
Deviation
****************************************************************************/
PROC SQL;
   SELECT PATNO,
          SBP
   FROM CLEAN.PATIENTS
   HAVING SBP NOT BETWEEN MEAN(SBP) - 2 * STD(SBP) AND
      MEAN(SBP) + 2 * STD(SBP)                     AND
      SBP IS NOT MISSING;
QUIT;

/***************************************************************************
Program 8-6  Converting Program 8-5 into a macro
****************************************************************************/
%MACRO RANGESTD(DSN,VARNAME);
   PROC SQL;
      SELECT PATNO,
             &VARNAME
      FROM &DSN
      HAVING &VARNAME NOT BETWEEN MEAN(&VARNAME) - 2 * STD(&VARNAME) AND
         MEAN(&VARNAME) + 2 * STD(&VARNAME)                          AND
         &VARNAME IS NOT MISSING;
   QUIT;
%MEND RANGESTD;

/***************************************************************************
Program 8-7  Using SQL to list missing values
****************************************************************************/
PROC SQL;
   SELECT *
   FROM CLEAN.PATIENTS
   WHERE PATNO   IS MISSING OR
         GENDER  IS MISSING OR
         VISIT   IS MISSING OR
         HR      IS MISSING OR
         SBP     IS MISSING OR
         DBP     IS MISSING OR
         DX      IS MISSING OR
         AE      IS MISSING;
   QUIT;

/***************************************************************************
Program 8-8  Using SQL to perform range checks on dates
****************************************************************************/
PROC SQL;
   TITLE "Dates Before June 1, 1998 or After October 15, 1999";
   SELECT PATNO,
          VISIT
   FROM CLEAN.PATIENTS
   WHERE VISIT NOT BETWEEN '01JUN1998'D AND '15OCT1999'D AND
         VISIT IS NOT MISSING;
QUIT;

/***************************************************************************
Program 8-9  Using SQL to list duplicate patient numbers
****************************************************************************/
PROC SQL;
   TITLE "Duplicate Patient Numbers";
   SELECT PATNO,
          VISIT
      FROM CLEAN.PATIENTS
      GROUP BY PATNO
      HAVING COUNT(PATNO) GT 1;
QUIT;

/***************************************************************************
Program 8-10  Using SQL to list patients who do not have two visits
****************************************************************************/
TITLE "Listing of Patients Who do Not Have Two Visits";
PROC SQL;
   SELECT PATNO,
          VISIT
      FROM CLEAN.PATIENT2
      GROUP BY PATNO
      HAVING COUNT(PATNO) NE 2;
QUIT;

/***************************************************************************
Program 8-11  Creating two data sets for testing purposes
****************************************************************************/
DATA ONE;
   INPUT PATNO X Y;
DATALINES;
1 69 79
2 56 .
3 66 99
5 98 87
12 13 14
;
DATA TWO;
   INPUT PATNO Z;
DATALINES;
1 56
3 67
4 88
5 98
13 99
;

/***************************************************************************
Program 8-12  Using SQL to look for ID's that are not in each of two files
****************************************************************************/
PROC SQL;
   TITLE "Patient Numbers Not in Both Files";
   SELECT ONE.PATNO AS ID_ONE,
          TWO.PATNO AS ID_TWO
   FROM ONE FULL JOIN TWO
   ON ONE.PATNO EQ TWO.PATNO
   WHERE ONE.PATNO IS MISSING OR TWO.PATNO IS MISSING;
QUIT;

/***************************************************************************
Program 8-13  Using SQL to demonstrate more complicated multi-file rules
****************************************************************************/
PROC SQL;
   TITLE1 "Patients with an AE of X who did not have a";
   TITLE2 "Labtest or where the Date of the Test is Prior";
   TITLE3 "to the Date of the Visit";
   SELECT AE.PATNO AS AE_PATNO LABEL="AE Patient Number",
          A_EVENT,
          DATE_AE,
          LAB_TEST.PATNO AS LABPATNO LABEL="LAB Patient Number",
          LAB_DATE
   FROM CLEAN.AE LEFT JOIN CLEAN.LAB_TEST
   ON AE.PATNO=LAB_TEST.PATNO
   WHERE A_EVENT = 'X'        AND
         LAB_DATE LT DATE_AE;
   QUIT;

/***************************************************************************
Program 8-14 Example of LEFT, RIGHT, and FULL Joins
****************************************************************************/
PROC SQL;
   TITLE "Left Join";
   SELECT ONE.PATNO AS ONE_ID,
          TWO.PATNO AS TWO_ID
   FROM ONE LEFT JOIN TWO
   ON ONE.PATNO EQ TWO.PATNO;


   TITLE "Right Join";
   SELECT ONE.PATNO AS ONE_ID,
          TWO.PATNO AS TWO_ID
   FROM ONE RIGHT JOIN TWO
   ON ONE.PATNO EQ TWO.PATNO;

   TITLE "Full Join";
   SELECT ONE.PATNO AS ONE_ID,
          TWO.PATNO AS TWO_ID
   FROM ONE FULL JOIN TWO
   ON ONE.PATNO EQ TWO.PATNO;
QUIT;

-----------------------------------------------------------------
The following programs are located in Chapter 9
-----------------------------------------------------------------

/***************************************************************************
Program 9-1  Program to create a simple validation data set
****************************************************************************/
DATA VALID;
   INFILE "C:\CLEANING\VALID1.TXT" MISSOVER;
   INPUT VARNAME : $32. MIN MAX; 
   VARNAME = UPCASE(VARNAME);
RUN;

/***************************************************************************
Program 9-2  Program to restructure the Patients data set and produce an 
exceptions report
****************************************************************************/
***Restructure Patients;
DATA PAT;
   SET CLEAN.PATIENTS;
   ***Make room for variable names up to 32 characters;
   LENGTH VARNAME $ 32;
   ***Array to contain all numeric variables;
   ARRAY NUMS[*] _NUMERIC_;  

DO I = 1 TO DIM(NUMS); 
      CALL VNAME(NUMS[I],VARNAME); 
      VARNAME = UPCASE(VARNAME); 
      VALUE = NUMS[I]; 
      OUTPUT; 
   END;
   KEEP PATNO VARNAME VALUE;
RUN;

PROC SORT DATA=PAT;
   BY VARNAME;
RUN;

PROC SORT DATA=VALID;
   BY VARNAME;
RUN;

DATA VERIFY;
   MERGE PAT(IN=IN_PAT)
         VALID(IN=IN_VALID);
   BY VARNAME;
   IF IN_PAT AND IN_VALID AND
      (VALUE LT MIN OR VALUE GT MAX); 
RUN;

PROC SORT DATA=VERIFY;
   BY PATNO VARNAME;
RUN;

PROC PRINT DATA=VERIFY;
   TITLE "Exceptions Report";
   ID PATNO;
   VAR VARNAME VALUE;
RUN;

/***************************************************************************
Program 9-3  Creating a new validation data set, containing missing value 
Instructions
****************************************************************************/
PROC FORMAT;
   INVALUE $MISS(UPCASE DEFAULT=1) 'Y' = 'Y'
                                   OTHER = 'N';
RUN;

***Create a validation data set from the raw data;
DATA VALID;
   INFILE "C:\CLEANING\VALID2.TXT" MISSOVER; 
   LENGTH VARNAME $ 32 MISS_OK $ 1;
   INPUT VARNAME $ MIN MAX MISS_OK : $MISS.;
   ***Make sure all variable names are in upper-case so they
      will match the variable names in the data set to be checked;
   VARNAME = UPCASE(VARNAME);
RUN;

/***************************************************************************
Program 9-4  Validating a data set with a macro containing missing value 
Instructions
****************************************************************************/
*------------------------------------------------------------------*
| Program Name: VALID_NUM.SAS  in C:\CLEANING                      |
| Purpose: Macro that takes an ID variable, a SAS data set to be   |
|          validated, and a validation data file, and prints an    |
|          exception report to the output device.                  |
|          This macro is for numeric variable range checking only. |
| Arguments: ID      - ID variable                                 |
|            DATASET - SAS data set to be validated                |
|            VALID_FILE - Validation data file                     |
|                         Each line of this file contains the name |
|                         of a numeric variable, the minimum value,| 
|                         the maximum value, and a missing value   |
|                         indicator ('Y' missing values OK, 'N'    |
|                         missing values not OK), all separated by |
|                         at least one blank.                      |
| Example: %VALID_NUM(PATNO,CLEAN.PATIENTS,C:\CLEANING\VALID2.TXT) |               *------------------------------------------------------------------*;
%MACRO VALID_NUM (ID,          /* ID Variable                   */
                  DATASET,     /* Data Set To Be Validated      */
                  VALID_FILE,  /* Validation Data Set           */
                 );

   ***Note: For pre-version 7, substitute a shorter name
      for several variables;

   ***Create the validation data set;
   PROC FORMAT;
      INVALUE $MISS(UPCASE DEFAULT=1) 'Y' = 'Y'
                                    OTHER = 'N';
   RUN;

   DATA VALID;
      INFILE "&VALID_FILE" MISSOVER;
      LENGTH VARNAME $ 32 MISS_OK $ 1;
      INPUT VARNAME $ MIN MAX MISS_OK : $MISS.;
      VARNAME = UPCASE(VARNAME);
   RUN;

   ***Restructure &DATASET;
   DATA PAT;
      SET &DATASET;
      LENGTH VARNAME $ 32;
      ARRAY NUMS[*] _NUMERIC_;
      N_NUMS = DIM(NUMS);
      DO I = 1 TO N_NUMS;
         CALL VNAME(NUMS[I],VARNAME);
         VARNAME = UPCASE(VARNAME);
         VALUE = NUMS[I];
         OUTPUT;
      END;
      KEEP PATNO VARNAME VALUE;
   RUN;

   PROC SORT DATA=PAT;
      BY VARNAME PATNO;
   RUN;

   PROC SORT DATA=VALID;
      BY VARNAME;
   RUN;

   ***Merge the validation data set and the restructured SAS data set;
   DATA VERIFY;
      MERGE PAT(IN=IN_PAT) VALID(IN=IN_VALID);
      BY VARNAME;
      IF (IN_PAT AND IN_VALID)   AND
         (VALUE LT MIN OR VALUE GT MAX)  AND
         NOT(VALUE = . AND MISS_OK EQ 'Y');
   RUN;

   PROC SORT DATA=VERIFY;
      BY PATNO VARNAME;
   RUN;

   ***Reporting section;
   OPTIONS NODATE NONUMBER;
   TITLE;

   DATA _NULL_;
      FILE PRINT HEADER = REPORT_HEAD;
      SET VERIFY;
      BY PATNO;

      IF VALUE = . THEN PUT
         @1  PATNO
         @18 VARNAME
         @39 "Missing";

      ELSE IF VALUE GT . AND VALUE LT MIN THEN PUT
         @1  PATNO
         @18 VARNAME
         @29 VALUE
         @39 "Below Minimum ("  MIN  +(-1) ")";

      ELSE IF VALUE GT MAX THEN PUT
         @1  PATNO
         @18 VARNAME
         @29 VALUE
         @39 "Above Maximum ("  MAX  +(-1) ")";

      IF LAST.PATNO THEN PUT ;
      RETURN;

      REPORT_HEAD:
         PUT @1 "Exceptions Report For Data Set &DATASET" /
                "Using Validation Data File &VALID_FILE"  //
             @1  "Patient ID"
             @18 "Variable"
             @29 "Value"
             @39 "Reason" /
             @1  60*"-";
   RUN;

   ***CLEANUP TEMPORARY DATA SETS;
   PROC DATASETS LIBRARY=WORK NOLIST;
      DELETE PAT;
      DELETE VERIFY;
   RUN;
   QUIT;

%MEND VALID_NUM;

/***************************************************************************
Program 9-5  Creating a test data set for character validation
****************************************************************************/
DATA TEST_CHAR;
   ***If there is a short record, set all variables to missing
      using the MISSOVER INFILE option.  DATALINES is a special
      file reference that allows INFILE options to be used with
      data following a DATALINES statement, rather than an external
      file;
   INFILE DATALINES MISSOVER;
   LENGTH PATNO $ 3 CODE $ 2 GENDER  AE $ 1;
   INPUT PATNO CODE GENDER AE;
DATALINES;
001 A M 0
002 AB F 1
003 BA F .
004 . . .
005 X Y Z
006 AC M 0
;

/***************************************************************************
Program 9-6  Creating a validation data set (C_VALID) for character variables
****************************************************************************/
PROC FORMAT;
   INVALUE $MISS(UPCASE DEFAULT=1) 'Y' = 'Y'
                                   OTHER = 'N';
RUN;

DATA C_VALID;
   LENGTH VARNAME $ 32 VALUES_LIST $ 200 MISS_OK $ 1;
   INFILE "C:\CLEANING\VALID_C.TXT" MISSOVER;
   INPUT VARNAME VALUES_LIST & $200. MISS_OK : $MISS.; 
RUN;

/***************************************************************************
Program 9-7  Writing the program to validate character variables
****************************************************************************/
***Restructure TEST_CHAR;
DATA PAT;
   SET TEST_CHAR;
   ARRAY CHARS[*] _CHARACTER_;
   LENGTH VARNAME $ 32;
   N_CHARS = DIM(CHARS);
   DO I = 1 TO N_CHARS;
      CALL VNAME(CHARS[I],VARNAME);
      VARNAME = UPCASE(VARNAME);
      VALUE = CHARS[I];
      OUTPUT;
   END;
   KEEP PATNO VARNAME VALUE;
RUN;

PROC SORT DATA=PAT;
   BY VARNAME;
RUN;

PROC SORT DATA=C_VALID;
   BY VARNAME;
RUN;

DATA VERIFY;
   MERGE PAT(IN=IN_PAT) C_VALID(IN=IN_C_VALID);
   BY VARNAME;
   IF (IN_PAT AND IN_C_VALID); 

   LENGTH TOKEN $ 8;

   ***Obviously bad values;
   IF VERIFY (VALUE,VALUES_LIST) NE 0     OR
      VALUE = ' ' AND MISS_OK NE 'Y' THEN DO; 
      OUTPUT;
      RETURN;
   END;

   FLAG = 0;
   DO I = 1 TO 99;
      TOKEN = SCAN(VALUES_LIST,I," ");  
      IF VALUE = TOKEN THEN FLAG + 1;
      IF TOKEN = ' ' OR FLAG > 0 THEN LEAVE;
   END;

   IF FLAG = 0 THEN OUTPUT;
   DROP I TOKEN;
RUN;

PROC SORT DATA=VERIFY;
   BY PATNO VARNAME;
RUN;

***REPORTING SECTION;
   OPTIONS NODATE NONUMBER;
   TITLE;

   DATA _NULL_;
      FILE PRINT HEADER = REPORT_HEAD;
      SET VERIFY;
      BY PATNO;

      IF VALUE = ' ' THEN PUT
         @1  PATNO
         @18 VARNAME
         @39 "Missing";

      ELSE  PUT
         @1  PATNO
         @18 VARNAME
         @29 VALUE
         @39 "Not Valid";

      IF LAST.PATNO THEN PUT ;
      RETURN;

REPORT_HEAD:
         PUT @1 "Exceptions Report For Data Set TEST_CHAR" /
                "Using Validation Data Set VALID_C"  //
             @1  "Patient ID"
             @18 "Variable"
             @29 "Value"
             @39 "Reason" /
             @1  60*"-";
   RUN;

/***************************************************************************
Program 9-8  Writing a macro to check for invalid character values
****************************************************************************/
*------------------------------------------------------------------*
| Program Name: VALID_CHAR in C:\CLEANING                          |
| Purpose: This macro takes an ID variable, a SAS data set to      |
|          be validated, and a validation data file and checks     |
|          for invalid character values and prints an exception    |
|          report.                                                 |
| Arguments: ID         - ID variable name                         |
|            DATASET    - SAS data set to be validated             |
|            VALID_FILE - Validation data file                     |
|                         Each line of this file contains the name |
|                         of a character variable, a list of valid |
|                         values, separated by spaces, and a 'Y'   |
|                         (missing values OK) or an 'N' (missing   |
|                         values not OK), separated from the list  |
|                         of valid values by 2 or more spaces.     |
| Example: %VALID_CHAR(PATNO,TEST_CHAR,C:\CLEANING\VALID_C.TXT)    |
*------------------------------------------------------------------*;
%MACRO VALID_CHAR (ID,         /* ID Variable                */
                  DATASET,     /* Data Set To Be Validated   */
                  VALID_FILE,  /* Validation Data File       */
                  );

   ***Note: For pre-version 7, substitute a shorter name
      for VALID_FILE;

   ***Create Validation Data Set;
   PROC FORMAT;
      INVALUE $MISS(UPCASE DEFAULT=1) 'Y' = 'Y'
                                      OTHER = 'N';
   RUN;

   PROC FORMAT;
      INVALUE $MISS(UPCASE DEFAULT=1) 'Y' = 'Y'
                                    OTHER = 'N';
   RUN;

   DATA VALID;
      LENGTH VARNAME $ 32 VALUES_LIST $ 200 MISS_OK $ 1;
      INFILE "&VALID_FILE" MISSOVER;
      INPUT VARNAME VALUES_LIST & $200. MISS_OK : $MISS.;
   RUN;

   ***Restructure &DATASET;
   DATA PAT;
      SET &DATASET;
      ARRAY CHARS[*] _CHARACTER_;
      LENGTH VARNAME $ 32;
      N_CHARS = DIM(CHARS);
      DO I = 1 TO N_CHARS;
         CALL VNAME(CHARS[I],VARNAME);
         VARNAME = UPCASE(VARNAME);
         VALUE = CHARS[I];
         OUTPUT;
      END;
      KEEP &ID VARNAME VALUE;
   RUN;

   PROC SORT DATA=PAT;
      BY VARNAME;
   RUN;

   PROC SORT DATA=VALID;
      BY VARNAME;
   RUN;

   DATA VERIFY;
      MERGE PAT(IN=IN_PAT) VALID(IN=IN_VALID);
      BY VARNAME;
      IF (IN_PAT AND IN_VALID);

      LENGTH TOKEN $ 8;

      ***obviously bad values;
      IF VERIFY (VALUE,VALUES_LIST) NE 0     OR
         VALUE = ' ' AND MISS_OK NE 'Y' THEN DO;
         OUTPUT;
         RETURN;
      END;

      FLAG = 0;
      DO I = 1 TO 99;
         TOKEN = SCAN(VALUES_LIST,I," ");
         IF VALUE = TOKEN THEN FLAG + 1;
         IF TOKEN = ' '  OR FLAG > 0 THEN LEAVE;
      END;

      IF FLAG = 0 THEN OUTPUT;
      DROP I TOKEN;
   RUN;

   PROC SORT DATA=VERIFY;
      BY &ID VARNAME;
   RUN;

   ***Reporting section;
   OPTIONS NODATE NONUMBER;
   TITLE;

   DATA _NULL_;
      FILE PRINT HEADER = REPORT_HEAD;
      SET VERIFY;
      BY &ID;

      IF VALUE = ' ' THEN PUT
         @1  &ID
         @18 VARNAME
         @39 "Missing";

      ELSE  PUT
         @1  &ID
         @18 VARNAME
         @29 VALUE
         @39 "Not Valid";

      IF LAST.&ID THEN PUT ;
      RETURN;

      REPORT_HEAD:
         PUT @1 "Exceptions Report For Data Set &DATASET" /
                "Using Validation Data File &VALID_FILE"  //
             @1  "Patient ID"
             @18 "Variable"
             @29 "Value"
             @39 "Reason" /
             @1  60*"-";
   RUN;

   PROC DATASETS LIBRARY=WORK;
      DELETE PAT VALID;
   RUN;
   QUIT;

%MEND VALID_CHAR;

/***************************************************************************
Program 9-9  Writing a macro to check for discrete character values and 
character ranges
****************************************************************************/
*------------------------------------------------------------------*
| Program Name: RANGE.SAS  in C:\CLEANING                          |
| Purpose: This macro takes an ID variable, a SAS data set to be   |
|          validated, and a validation data file and checks for    |
|          discrete character values or character ranges for       |
|          valid data, and prints an exception report.             |
| Arguments: ID         - ID variable name                         |
|            DATASET    - SAS data set to be validated             |
|            VALID_FILE - Validation data file containing variable |
|                         names, discrete valid character values   |
|                         and/or ranges, and a missing value flag, |
|                         'Y' means missing values are OK.         |
| Example: %RANGE(PATNO,TEST_CHAR,C:\CLEANING\VALID_RANGE.TXT)     |
*------------------------------------------------------------------*;
%MACRO RANGE(ID,          /* ID Variable                */
             DATASET,     /* Data Set To Be Validated   */
             VALID_FILE,  /* Validation Data File       */
            );

   PROC FORMAT;
      INVALUE $MISS(UPCASE DEFAULT=1) 'Y' = 'Y'
                                    OTHER = 'N';
   RUN;

   DATA C_VALID;
      LENGTH VARNAME $ 32 VALUES_LIST $ 200 MISS_OK $ 1 WORD $ 17;
      INFILE "&VALID_FILE" MISSOVER;
      INPUT VARNAME VALUES_LIST & $200. MISS_OK : $MISS.;
      ***Separate VALUES_LIST into individual values and ranges;
      
      ***Array to store up to ten ranges.  The first dimension of
         the array tells which range it is, the second dimension
         takes on the value 1 for the lower range and 2, for the 
         upper range.  You may want to increase the length for
         each of the ranges to a larger number. ;

      ARRAY RANGES[10,2] $ 8 R1-R20; 

      ***Compute the number of ranges in the string;
      N_OF_RANGES = LENGTH(VALUES_LIST) - 
                    LENGTH(COMPRESS(VALUES_LIST,"-")); 

       ***Break list into "words";
      N_RANGE = 0;
      DO I = 1 TO 200 UNTIL (WORD = " ");  
         WORD = SCAN(VALUES_LIST,I," ");
         IF INDEX(WORD,'-') NE 0 THEN DO; 
            ***Range found, scan again to get lower and
            upper values;
            N_RANGE + 1;
            RANGES[N_RANGE,1] = SCAN(WORD,1,"-");
            RANGES[N_RANGE,2] = SCAN(WORD,2,"-");
         END;
      END;
   
      ***When all finished finding ranges, substitute blanks for dashes;
      VALUES_LIST = TRANSLATE(VALUES_LIST," ","-");

      KEEP VALUES_LIST R1-R20 VARNAME N_OF_RANGES MISS_OK ;
   RUN;

   ***Restructure TEST_CHAR;
   DATA PAT;
      SET TEST_CHAR;
      ARRAY CHARS[*] _CHARACTER_;
      LENGTH VARNAME $ 32;
      N_CHARS = DIM(CHARS);
      DO I = 1 TO N_CHARS;
         CALL VNAME(CHARS[I],VARNAME);
         VARNAME = UPCASE(VARNAME);
         VALUE = CHARS[I];
         OUTPUT;
      END;
      KEEP PATNO VARNAME VALUE;
   RUN;

   PROC SORT DATA=PAT;
      BY VARNAME;
   RUN;

   PROC SORT DATA=C_VALID;
      BY VARNAME;
   RUN;

   DATA VERIFY;
      ARRAY RANGES[10,2] $ 8 R1-R20;
      MERGE PAT(IN=IN_PAT) C_VALID(IN=IN_C_VALID);
      BY VARNAME;
      IF (IN_PAT AND IN_C_VALID);

      LENGTH TOKEN $ 8;

      ***Obviously bad values;
      IF (VERIFY (VALUE,VALUES_LIST) NE 0 AND N_OF_RANGES = 0)    OR
         VALUE = ' ' AND MISS_OK NE 'Y' THEN DO;
         OUTPUT;
         RETURN;
      END;

      ***Checking for discrete values;
      FLAG = 0;  /* FLAG INCREMENTED IF A DISCRETE MATCH FOUND */
      DO I = 1 TO 99;
         TOKEN = SCAN(VALUES_LIST,I);
         IF VALUE = TOKEN THEN FLAG + 1;
         IF TOKEN = ' '  OR FLAG > 0 THEN LEAVE;
      END;

      ***Checking for ranges;
      ***R_FLAG incremented if in one of the ranges; 
      R_FLAG = 0;  
      ***Lower and upper range values already checked above;
      IF N_OF_RANGES > 0 THEN DO I = 1 TO N_OF_RANGES;
      IF VALUE > RANGES[I,1] AND VALUE < RANGES[I,2] THEN DO;
            R_FLAG + 1;
            LEAVE;
         END;
      END;

      IF FLAG = 0 AND R_FLAG = 0 THEN OUTPUT;

      DROP I TOKEN;
   RUN;

   PROC SORT DATA=VERIFY;
      BY PATNO VARNAME;
   RUN;

   ***Reporting section;
   OPTIONS NODATE NONUMBER;
   TITLE;

   DATA _NULL_;
      FILE PRINT HEADER = REPORT_HEAD;
      SET VERIFY;
      BY PATNO;

      IF VALUE = ' ' THEN PUT
         @1  PATNO
         @18 VARNAME
         @39 "Missing";

      ELSE  PUT
         @1  PATNO
         @18 VARNAME
         @29 VALUE
         @39 "Not Valid";

      IF LAST.PATNO THEN PUT ;
      RETURN;

      REPORT_HEAD:
         PUT @1 "Exceptions Report For Data Set TEST_CHAR" /
                "Using Validation Data Set VALID_C"  //
             @1  "Patient ID"
             @18 "Variable"
             @29 "Value"
             @39 "Reason" /
             @1  60*"-";
   RUN;

   PROC DATASETS LIBRARY=WORK NOLIST;
      DELETE PAT  C_VALID;
   RUN;
   QUIT;

%MEND RANGE;

/***************************************************************************
Program 9-10  Creating a macro to validate both numeric and character data, 
including character ranges, with a single validation data file 
****************************************************************************/
*--------------------------------------------------------------------*
| Program Name: VALID_ALL.SAS  in C:\CLEANING                        |
| Purpose: This macro takes an ID variable, a SAS data set to be     |
|          validated, and a validation data file and checks for      |
|          discrete character values or character ranges for         |
|          character variables and valid ranges for numeric data     |
|          and prints an exception report.                           |
| Arguments: ID         - ID variable name                           |
|            DATASET    - SAS data set to be validated               |
|            VALID_FILE - Validation data file containing variable   |
|                         names, discrete values and/or ranges for   |
|                         character variables, minimum and maximum   |
|                         values for numeric variables, and a        |
|                         missing value flag 'Y' means missing       |
|                         values are OK.                             |
| Example: %VALID_ALL(PATNO,CLEAN.PATIENTS,C:\CLEANING\VALID_ALL.TXT)|
*--------------------------------------------------------------------*;
%MACRO VALID_ALL(ID,        /* ID Variable              */
                 DATASET,   /* Data Set to be validated */
                 VALID_FILE /* Validation Data File     */
                 );

   ***Get a list of variable names and type (numeric or character);
   PROC CONTENTS NOPRINT DATA=&DATASET 
                 OUT=NAMETYPE(KEEP=NAME TYPE); 
   RUN;

   ***find number of observations in data set TYPE and assign 
      to a macro variable;

   %LET DSID = %SYSFUNC(OPEN(NAMETYPE)); 
   %LET NUM_OBS = %SYSFUNC(ATTRN(&DSID,NOBS));
   %LET RC = %SYSFUNC(CLOSE(&DSID));

   ***Place the variable names and types in a single observation,
      using NAMES1-NAMESn and TYPE_VAR1-TYPE_VARn to hold the 
      variable names and types, respectively;

DATA XTYPE; 
      SET NAMETYPE END=LAST;
      NAME = UPCASE(NAME);
      ARRAY NAMES[&NUM_OBS] $ 32;
      ARRAY TYPE_VAR[&NUM_OBS];
      RETAIN  NAMES1-NAMES&NUM_OBS  TYPE_VAR1-TYPE_VAR&NUM_OBS;
      NAMES[_N_] = NAME;
      TYPE_VAR[_N_] = TYPE;
      IF LAST THEN OUTPUT;
      KEEP NAMES1-NAMES&NUM_OBS TYPE_VAR1-TYPE_VAR&NUM_OBS;
   RUN;

   ***Turn the validation data file into a SAS data set;
   PROC FORMAT;
      INVALUE $MISS(UPCASE DEFAULT=1) 'Y' = 'Y'
                                      OTHER = 'N';
   RUN;

   ***Need to distinguish lines with numeric ranges from ones
      with character values and ranges.  Use the variable type
      from the one observation data set (XTYPE) above;

   DATA VALID;
      ARRAY NAMES[&NUM_OBS] $ 32;
      ARRAY TYPE_VAR[&NUM_OBS];
      LENGTH VARNAME $ 32 VALUES_LIST $ 200 MISS_OK $ 1 WORD $ 17;
      INFILE "&VALID_FILE" MISSOVER;
      IF _N_ = 1 THEN SET XTYPE; 
      INPUT VARNAME @;  
      VARNAME = UPCASE(VARNAME);

      ***Find VARNAME in NAMES array and determine TYPE;
      DO I = 1 TO &NUM_OBS;
         IF VARNAME = NAMES[I] THEN DO;
            IF TYPE_VAR[I] = 1 THEN DO;
               INPUT MIN MAX MISS_OK : $MISS.;
               TYPE = 'N';
            END;

         ELSE IF TYPE_VAR[I] = 2 THEN DO;
            INPUT VALUES_LIST & $200. MISS_OK : $MISS.;
            ***Separate VALUES_LIST into individual 
               values and ranges;
            ARRAY RANGES[10,2] $ 8 R1-R20;
            N_OF_RANGES = LENGTH(VALUES_LIST) -
                          LENGTH(COMPRESS(VALUES_LIST,"-"));

               ***Break list into "words";
            N_RANGE = 0;
            DO I = 1 TO 200 UNTIL (WORD = " ");
               WORD = SCAN(VALUES_LIST,I," ");
               IF INDEX(WORD,'-') NE 0 THEN DO;
                  ***Range found, scan again to get lower and
                  upper values;
                  N_RANGE + 1;
                  RANGES[N_RANGE,1] = SCAN(WORD,1,"-");
                  RANGES[N_RANGE,2] = SCAN(WORD,2,"-");
                END;
             END;

            TYPE = 'C';
         END;

         OUTPUT;
         LEAVE;
      END;
   END;
   KEEP VARNAME MIN MAX MISS_OK VALUES_LIST TYPE 
           R1-R20  N_OF_RANGES;
   RUN;

   ***Restructure data set to be validated.  Need separate
      variable to hold numeric and character values;
   DATA PAT;
      SET &DATASET;
      ARRAY CHARS[*] _CHARACTER_;  
      ARRAY NUMS[*] _NUMERIC_;  

      LENGTH VARNAME $ 32;
      N_CHARS = DIM(CHARS);
      N_NUMS = DIM(NUMS);
   
      DO I = 1 TO N_CHARS; 
         CALL VNAME(CHARS[I],VARNAME);
         VARNAME = UPCASE(VARNAME);
         C_VALUE = CHARS[I]; 
         OUTPUT;
      END;

      DO I = 1 TO N_NUMS; 
         CALL VNAME(NUMS[I],VARNAME);
         VARNAME = UPCASE(VARNAME);
         N_VALUE = NUMS[I]; 
         C_VALUE = " ";
         OUTPUT;
      END;

      KEEP PATNO VARNAME C_VALUE N_VALUE;
   RUN;

   PROC SORT DATA=PAT;
      BY VARNAME;
   RUN;

   PROC SORT DATA=VALID;
      BY VARNAME;
   RUN;

   DATA VERIFY;
      ARRAY RANGES[10,2] $ 8 R1-R20;
      MERGE PAT(IN=IN_PAT) VALID(IN=IN_VALID);
      BY VARNAME;
      IF NOT(IN_PAT AND IN_VALID) THEN DELETE;

      LENGTH TOKEN $ 8;

      ***Character variable section;
      IF TYPE = 'C' THEN DO;

***Obviously bad values;
         IF (VERIFY (C_VALUE,VALUES_LIST) NE 0 AND N_OF_RANGES = 0) OR
            C_VALUE = ' ' AND MISS_OK = 'N' THEN DO;
            OUTPUT;
            RETURN;
         END;

         ***Checking for discrete values;
         FLAG = 0;
         DO I = 1 TO 99;
            TOKEN = SCAN(VALUES_LIST,I);
            IF C_VALUE = TOKEN THEN FLAG + 1;
            IF TOKEN = ' '  OR FLAG > 0 THEN LEAVE;
         END;

         ***Checking for ranges;
         R_FLAG = 0;
         IF N_OF_RANGES > 0 THEN DO I = 1 TO N_OF_RANGES;
            IF C_VALUE > RANGES[I,1] AND 
               C_VALUE < RANGES[I,2] THEN DO;
               R_FLAG + 1;
               LEAVE;
            END;
         END;

         IF FLAG = 0 AND R_FLAG = 0 THEN OUTPUT;

      END;  
      ***of character section;

      ***Numeric variable section;
      IF TYPE = 'N' THEN DO;
         IF   (N_VALUE LT MIN OR N_VALUE GT MAX)  AND
            NOT(N_VALUE = . AND MISS_OK EQ 'Y') THEN OUTPUT;
      END; 
      ***of numeric section;

      DROP VALUES_LIST TOKEN I FLAG;
      RUN;

   PROC SORT DATA=VERIFY;
      BY PATNO VARNAME;
   RUN;

   ***Reporting section;
   OPTIONS NODATE NONUMBER;
   TITLE;

   DATA _NULL_;
      FILE PRINT HEADER = REPORT_HEAD;
      SET VERIFY;
      BY PATNO;

      ***Numeric variables;
      IF TYPE = 'N' THEN DO;
      IF N_VALUE = . THEN PUT
         @1  PATNO
         @18 VARNAME
         @39 "Missing";

      ELSE IF N_VALUE GT . AND N_VALUE LT MIN THEN PUT
         @1  PATNO
         @18 VARNAME
         @29 N_VALUE
         @39 "Below Minimum ("  MIN  +(-1) ")";

      ELSE IF N_VALUE GT MAX THEN PUT
         @1  PATNO
         @18 VARNAME
         @29 N_VALUE
         @39 "Above Maximum ("  MAX  +(-1) ")";

      IF LAST.PATNO THEN PUT ;
      END; 
      ***End of numeric report;

      ***Character report;
      IF TYPE = 'C' THEN DO;
      IF C_VALUE = ' ' THEN PUT
         @1  PATNO
         @18 VARNAME
         @39 "Missing";

      ELSE  PUT
         @1  PATNO
         @18 VARNAME
         @29 C_VALUE
         @39 "Not Valid";

      IF LAST.PATNO THEN PUT ;
      END;
      ***end of character report;

      RETURN;

      REPORT_HEAD:
         PUT @1 "Exceptions Report For Data Set &DATASET" /
                "Using Validation Data File &VALID_FILE"  //
             @1  "Patient ID"
             @18 "Variable"
             @29 "Value"
             @39 "Reason" / 
             @1  60*"-";
   RUN;

   ***Cleanup temporary data sets;
   PROC DATASETS LIBRARY=WORK NOLIST;
      DELETE PAT;
      DELETE VERIFY;
      DELETE NAMETYPE;
   RUN;
   QUIT;

RUN;

%MEND VALID_ALL;




