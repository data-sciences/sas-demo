*Programs used in this book;
options nonumber nodate nocenter;

*raw data file patients.txt to follow
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
;

*Program 1-1;
*----------------------------------------------------------*
|PROGRAM NAME: PATIENTS.SAS in C:\BOOKS\CLEAN              |
|PURPOSE: To create a SAS data set called PATIENTS         |
*----------------------------------------------------------*;
libname clean "c:\books\clean";

data clean.patients;
   infile "c:\books\clean\patients.txt" 
          lrecl=30 truncover; /* take care of problems
                                 with short records */

   input @1  Patno    $3. @4  gender   $1.
         @5  Visit    mmddyy10.
         @15 HR       3.
         @18 SBP      3.
         @21 DBP      3.
         @24 Dx       $3.
         @27 AE       $1.;

   LABEL Patno   = "Patient Number"
         Gender  = "Gender"
         Visit   = "Visit Date"
         HR      = "Heart Rate"
         SBP     = "Systolic Blood Pressure"
         DBP     = "Diastolic Blood Pressure"
         Dx      = "Diagnosis Code"
         AE      = "Adverse Event?";
    format visit mmddyy10.;
run;

*Program 1-2;
title "Frequency Counts for Selected Character Variables";
proc freq data=clean.patients;
   tables Gender Dx AE / nocum nopercent;
run;

*Program 1-3;
title "Frequency Counts for Selected Character Variables";
proc freq data=clean.patients(drop=Patno);
   tables _character_ / nocum nopercent;
run;

*Program 1-4;
title "Listing of invalid patient numbers and data values";
data _null_;
   set clean.patients;
   file print; ***send output to the output window;
   ***check Gender;
   if Gender not in ('F' 'M' ' ') then put Patno= Gender=;
   ***check Dx;
   if verify(trim(Dx),'0123456789') and not missing(Dx) 
      then put Patno= Dx=;
 /***********************************************
   SAS 9 alternative:
   if notdigit(trim(Dx)) and not missing(Dx) 
      then put Patno= Dx=;
   ************************************************/
   ***check AE;
   if AE not in ('0' '1' ' ') then put Patno= AE=;
run;

*Program 1-5;
title "Listing of invalid gender values";
proc print data=clean.patients;
   where Gender not in ('M' 'F' ' ');
   id Patno;
   var Gender;
run;

*Program 1-6;
title "Listing of invalid character values";
proc print data=clean.patients;
   where Gender not in ('M' 'F' ' ')            or
         notdigit(trim(Dx)) and not missing(Dx) or
         ae not in ('0' '1' ' ');
   id Patno;
   var Gender Dx AE;
run;

*Program 1-7;
proc format;
   value $gender 'F','M' = 'Valid'
                 ' '     = 'Missing'
                 other   = 'Miscoded';

   value $ae '0','1' = 'Valid'
             ' '     = 'Missing'
              other  = 'Miscoded';
run;

title "Using formats to identify invalid values";
proc freq data=clean.patients;
   format Gender $gender.
          AE     $ae.;
   tables gender ae / nocum nopercent missing;
run;

*Program 1-8;
proc format;
   value $gender 'F','M' = 'Valid'
                 ' '     = 'Missing'
                 other   = 'Miscoded';

   value $ae '0','1' = 'Valid'
             ' '     = 'Missing'
              other  = 'Miscoded';
run;

title "Listing of invalid patient numbers and data values";
data _null_;
   set clean.patients(keep=Patno Gender AE);
   file print; ***send output to the output window;
   if put(Gender,$gender.) = 'Miscoded' then put Patno= Gender=;
   if put(AE,$ae.) = 'Miscoded' then put Patno= AE=;
run;

*Program 1-9;
*----------------------------------------------------------------*
| Purpose: To create a SAS data set called PATIENTS_FILTERED     |
|          and set any invalid values for Gender and AE to       |
|          missing, using a user-defined informat                |
*---------------------------------------------------------------*;
libname clean "c:\books\clean";

proc format;
   invalue $gen    'F','M' = _same_
                   other   = ' ';
   invalue $ae    '0','1' = _same_
                   other  = ' ';
run;

data clean.patients_filtered;
   infile "c:\books\clean\patients.txt" truncover;
   input @1  Patno    $3.
         @4  Gender   $gen1.
         @27 AE       $ae1.;

   label Patno   = "Patient Number"
         Gender  = "Gender"
         AE      = "adverse event?";
run;

title "Listing of data set PATIENTS_FILTERED";
proc print data=clean.patients_filtered;
   var Patno Gender AE;
run;

*Program 1-10;
proc format;
   invalue $gender 'F','M' = _same_
                    other  = 'Error';
   invalue $ae      '0','1' = _same_
                    other   = 'Error';
run;

title "Listing of invalid character values";
data _null_;
   file print;
   set clean.patients;
   if input (Gender,$gender.) = 'Error' then
      put @1 "Error for Gender for patient:" Patno" value is " Gender;
   if input (AE,$ae.) = 'Error' then
      put @1 "Error for AE for patient:" Patno" value is " AE;
run;

*Program 2-1;
libname clean "c:\books\clean";

title "Checking numeric variables in the patients data set";
proc means data=clean.patients n nmiss min max maxdec=3;
   var hr sbp dbp;
run;

*Program 2-2;
title "Statistics for numeric variables";
proc tabulate data=clean.patients format=7.3;
   var HR SBP DBP;
   tables HR SBP DBP,
          n*f=7.0 nmiss*f=7.0 mean min max / rtspace=18;
   keylabel n     = 'Number'
            nmiss = 'Missing'
            mean  = 'Mean'
            min   = 'Lowest'
            max   = 'Highest'; 
run;

*Program 2-3;
title "Using PROC UNIVARIATE to Look for Outliers";
proc univariate data=clean.patients plot;
   id Patno;
   var HR SBP DBP;
run;

*Program 2-4;
ods select extremeobs;

proc univariate data=clean.patients;
   title "using proc univariate to look for outliers";
   id Patno;
   var HR SBP DBP;
run;

*Program 2-5;
ODS select extremeobs;
title "The 10 highest and lowest observations for DBP";
proc Univariate data=clean.patients nextrobs=10;
   id Patno;
   var DBP;
run;

*Program 2-6;
ODS select extremevalues;
title "The 10 highest and lowest values for DBP";
proc Univariate data=clean.patients nextrvals=10;
   id Patno;
   var DBP;
run;

*Program 2-7;
libname clean "c:\books\clean";
proc univariate data=clean.patients noprint;
   var HR;
   id Patno;
   output out=tmp pctlpts=10 90 pctlpre = L_;   
run;

data hilo;
   set clean.patients(keep=Patno HR);   
   ***Bring in upper and lower cutoffs for variable;
   if _n_ = 1 then set tmp;   
   if HR le L_10 and not missing(HR) then do;
      Range = 'Low ';
      output;
   end;
   else if HR ge L_90 then do;
      Range = 'High';
      output;
   end;
run;

proc sort data=hilo;
   by HR;   
run;
title "Top and Bottom 10% for Variable HR";
proc print data=hilo;
   id Patno;
   var Range HR;
run; 

*Program 2-8;
options mprint;
*---------------------------------------------------------------*
| Program Name: HILOWPER.SAS  in c:\books\clean                 |
| Purpose: To list the n percent highest and lowest values for  |
|          a selected variable.                                 |
| Arguments: Dsn    - Data set name                             |
|            Var     - Numeric variable to test                 |
|            Percent - Upper and Lower percentile cutoff        |
|            Idvar   - ID variable to print in the report       |
| Example: %hilowper(Dsn=clean.patients,                        |
|                    Var=SBP,                                   |
|                    Percent=10,                                |
|                    Idvar=Patno)                               |
*---------------------------------------------------------------*;

%macro hilowper(Dsn=,     /* Data set name                     */
                Var=,     /* Variable to test                  */
                Percent=, /* Upper and lower percentile cutoff */
                Idvar=    /* ID variable                       */);

   ***Compute upper percentile cutoff;
   %let Up_per = %eval(100 - &Percent);

   proc univariate data=&Dsn noprint;
      var &Var;
      id &Idvar;
      output out=tmp pctlpts=&Percent &Up_per pctlpre = L_;
   run;

   data hilo;
      set &Dsn(keep=&Idvar &Var);
      if _n_ = 1 then set tmp;
      if &Var le L_&percent and not missing(&Var) then do;
         range = 'Low ';
         output;
      end;
      else if &Var ge L_&Up_per then do;
         range = 'High';
         output;
      end;
   run;

   proc sort data=hilo;
      by &Var;
   run;
   
   title "Low and High Values for Variables";
   proc print data=hilo;
      id &Idvar;
      var Range &Var;
   run;

   proc datasets library=work nolist;
     delete tmp hilo;
   run;
   quit;

%mend hilowper ;

%hilowper(Dsn=clean.patients,
          Var=SBP,
          Percent=10,
          Idvar=Patno)

*Program 2-9;
*----------------------------------------------------------------*
| Macro Name: top_bottom_nPercent                                |
| Purpose: To list the upper and lower n% of values              |
| Arguments: Dsn     - Data set name (one- or two-level          |
|            Var     - Variable to test                          |
|            Percent - Upper and lower n%                        |
|            Idvar   - ID variable                               |
| Example: %top_bottom_nPercent(Dsn=clean.patients,              |
                                Var=SBP,                         |
                                Percent=10,                      |
                                Idvar=Patno)                     |
*----------------------------------------------------------------*;

%macro top_bottom_nPercent
   (Dsn=,
    Var=,
    Percent=,
    Idvar=);
   %let Bottom = %eval(&Percent - 1);
   %let Top = %eval(100 - &Percent);

   proc format;
      value rnk 0 - &Bottom = 'Low' 
               &top - 99    = 'High';
   run;

   proc rank data=&dsn(keep=&Var &Idvar) 
             out=new(where=(&var is not missing)) 
             groups=100;
      var &Var;
      ranks Range; 
   run;

   ***Sort and keep top and bottom n%;
   proc sort data=new(where=(Range le &Bottom or
                             Range ge &Top));
      by  &Var;
   run;
   
   ***Produce the report;
   proc print data=new;
   title "Upper and Lower &PERCENT.% Values for %upcase(&Var)";
      id &Idvar;
      var Range &Var;
      format Range rnk.;
   run;
 
   proc datasets library=work nolist;
      delete new;
   run;
   quit;

%mend top_bottom_nPercent;

options mprint;
%top_bottom_nPercent(Dsn=clean.patients,
                     Var=SBP,
                     Percent=10,
                     Idvar=Patno)

*Program 2-10;
proc sort data=clean.patients(keep=Patno HR 
          where=(HR is not missing)) out=tmp;
   by HR;
run;
data _null_;
   set tmp nobs=Num_obs;
   call symputx('Num',Num_obs);
   stop;
run;

%let High = %eval(&Num - 9);

title "Ten Highest and Ten Lowest Values for HR";
data _null_;
   set tmp(obs=10)         /* lowest values */
       tmp(firstobs=&High) /* highest values */;
   file print;
   if _n_ le 10 then do;
      if _n_ = 1 then put / "Ten Lowest Values" ;
      put "Patno = " Patno @15 "Value = " HR;
   end;
   else if _n_ ge 11 then do;
      if _n_ = 11 then put / "Ten Highest Values" ;
      put "Patno = " Patno @15 "Value = " HR;
   end;
run;

*Program 2-11;
*----------------------------------------------------------------*
| Macro Name: highlow                                            |
| Purpose: To list the "n" highest and lowest values             |
| Arguments: Dsn     - Data set name (one- or two-level          |
|            Var     - Variable to list                          |
|            Idvar   - ID variable                               |
|            n       - Number of values to list                  |
| Example: %highlow(Dsn=clean.patients,                          |
|                   Var=SBP,                                     |
|                   Idvar=Patno,                                 |
|                   n=7)                                         |
*----------------------------------------------------------------*;

%macro highlow(Dsn=,     /* Data set name          */
               Var=,     /* Variable to list       */
               Idvar=,   /* ID Variable            */
               n=        /* Number of high and low
                            values to list         */);
   proc sort data=&Dsn(keep=&Idvar &Var 
             where=(&Var is not missing)) out=tmp;
      by &Var;
   run;
   data _null_;
      set tmp nobs=Num_obs;
      call symput('Num',Num_obs);
      stop;
   run;

   %let High = %eval(&Num - &n + 1);

   title "&n Highest and Lowest Values for &Var";
   data _null_;
      set tmp(obs=&n)         /* lowest values */
          tmp(firstobs=&High) /* highest values */;
      file print;
      if _n_ le &n then do;
         if _n_ = 1 then put / "&n Lowest Values" ;
         put "&Idvar = " &Idvar @15 "Value = " &Var;
      end;
      else if _n_ ge %eval(&n + 1) then do;
         if _n_ = %eval(&n + 1) then put / "&n Highest Values" ;
         put "&Idvar = " &Idvar @15 "Value = " &Var;
      end;
   run;
   proc datasets library=work nolist;
      delete tmp;
   run;
   quit;
%mend highlow;

%highlow(Dsn=clean.patients,
         Var=HR,
         Idvar=Patno,
         n=7)

*Program 2-12;
title "Out-of-range values for numeric variables";
proc print data=clean.patients;
   where (HR not between 40 and 100 and HR is not missing)      or
         (SBP not between 80 and 200 and SBP is not missing)    or
         (DBP not between 60 and 120 and DBP is not missing);
   id Patno;
   var HR SBP DBP;
run;

*Program 2-13;
title "Listing of patient numbers and invalid data values";
data _null_;
   file print; ***send output to the output window;
   set clean.patients(keep=Patno HR SBP DBP);
   ***Check HR;
   if (HR lt 40 and not missing(HR)) or HR gt 100 then 
      put Patno= HR=;
   ***Check SBP;
   if (SBP lt 80 and not missing(SBP)) or SBP gt 200 then 
      put Patno= SBP=;
   ***Check DBP;
   if (DBP lt 60 and not missing(HR)) or DBP gt 120 then 
      put Patno= DBP=;
run;

*Program 2-14;
title "Listing of patient numbers and invalid data values";
data _null_;
   infile "c:\books\clean\patients.txt" truncover;
   file print; ***send output to the output window;
   ***Note: we will only input those variables of interest;
   input @1  Patno    $3.
         @15 HR        3.
         @18 SBP       3.
         @21 DBP       3.;
   ***Check HR;
   if (HR lt 40 and not missing(HR)) or HR gt 100 then 
      put Patno= HR=;
   ***Check SBP;
   if (SBP lt 80 and not missing(SBP)) or SBP gt 200 then 
      put Patno= SBP=;
   ***Check DBP;
   if (DBP lt 60 and not missing(HR)) or DBP gt 120 then 
      put Patno= DBP=;
   if _error_ eq 1 then
      put Patno= "had one or more invalid character values" /
          HR= SBP= DBP=;
run;

*Program 2-15;
title "Listing of Invalid and Out-of-Range Values";
data _null_;
   file print; ***send output to the output window;
   infile "c:\books\clean\patients.txt" truncover;
   file print; ***send output to the output window;
   ***Note: we will only input those variables of interest;
   input @1  Patno    $3.
         @15 C_HR     $3.
         @18 C_SBP    $3.
         @21 C_DBP    $3.;
   ***Check HR;
   if not missing(c_HR) then do;
      if notdigit(trim(C_HR))then put Patno= 
      "has an invalid value for HR of " C_HR;
      else do;
         HR = input(C_HR,8.);
         if HR lt 40 or HR gt 100 then put Patno= HR=;
      end;
   end;
   ***Check SBP;
   if not missing (C_SBP) then do;
      if notdigit(trim(C_SBP)) then put Patno= 
      "has an invalid value of SBP of " C_SBP;
      else do;
         SBP = input(C_SBP,8.);
         if SBP lt 80 or SBP gt 200 then put Patno= SBP=;
      end;
   end;
   ***Check DBP;
   if not missing(C_DBP) then do;
      if notdigit(trim(C_DBP)) then put Patno= 
      "has an invalid value for DBP of " C_DBP;
      else do;
         DBP = input(C_DBP,8.);
         if DBP lt 60 or DBP gt 120 then put Patno= DBP=;
      end;
   end;
   drop C_: ;
run;

*Program 2-16;
*---------------------------------------------------------------*
| Program Name: RANGE.SAS  in c:\books\clean                    |
| Purpose: Macro that takes lower and upper limits for a        |
|          numeric variable and an ID variable to print out     |
|          an exception report to the Output window.            |
| Arguments: Dsn    - Data set name                             |
|            Var    - Numeric variable to test                  |
|            Low    - Lowest valid value                        |
|            High   - Highest valid value                       |
|            Idvar  - ID variable to print in the exception     |
|                     report                                    |
| Example: %range(Dsn=CLEAN.PATIENTS,                           |
|                 Var=HR,                                       |
|                 Low=40,                                       |
|                 High=100,                                     |
|                 Idvar=Patno)                                  |
*---------------------------------------------------------------*;

%macro range(Dsn=    /* Data set name               */,
             Var=    /* Variable you want to check  */,
             Low=    /* Low value                   */,
             High=   /* High value                  */,
             Idvar=  /* ID variable                 */);

   title "Listing of Invalid Patient Numbers and Data Values";
   data _null_;
      set &Dsn(keep=&Idvar &Var);
      file print;
      if (&Var lt &Low and not missing(&Var)) or &Var gt &High then
         put "&Idvar:" &Idvar  @18 "Variable:&VAR"
                               @38 "Value:" &Var
                               @50 "out-of-range";
   run;

%mend range;

options mprint;
%range(dsn=clean.patients,
       var=HR,
       low=40,
       high=100,
       idvar=Patno)

*Program 2-17;
*---------------------------------------------------------------*
| PROGRAM NAME: ERRORS.SAS  in c:\books\clean                   |
| PURPOSE: Accumulates errors for numeric variables in a SAS    |
|          data set for later reporting.                        |
|          This macro can be called several times with a        |
|          different variable each time. The resulting errors   |
|          are accumulated in a temporary SAS data set called   |
|          errors.                                              |
| ARGUMENTS: Dsn=    - SAS data set name (assigned with a %LET) |
|            Idvar=  - Id variable (assigned with a %LET)       |
|                                                               |
|            Var     = The variable name to test                |
|            Low     = Lowest valid value                       |
|            High    = Highest valid value                      |
|            Missing = IGNORE (default) Ignore mising values    |
|                     ERROR Missing values flagged as errors    |
|                                                               |
| EXAMPLE: %let Dsn = clean.patients;                           |
|          %let Idvar = Patno;                                  |
|                                                               |
|          %errors(Var=HR, Low=40, High=100, Missing=error)     |
|          %errors(Var=SBP, Low=80, High=200, Missing=ignore)   |
|          %errors(Var=DBP, Low=60, High=120)                   |
|          Test the numeric variables HR, SBP, and DBP in data  |
|          set clean.patients for data outside the ranges       |
|          40 to 100, 80 to 200, and 60 to 120 respectively.    |
|          The ID variable is PATNO and missing values are to   |
|          be flagged as invalid for HR but not for SBP or DBP. |
*---------------------------------------------------------------*:
%macro errors(Var=,    /* Variable to test     */
              Low=,    /* Low value            */
              High=,   /* High value           */
              Missing=ignore 
                       /* How to treat missing values         */
                       /* Ignore is the default.  To flag     */
                       /* missing values as errors set        */
                       /* Missing=error                       */);
data tmp;
   set &dsn(keep=&Idvar &Var);
   length Reason $ 10 Variable $ 32;
   Variable = "&Var";
   Value = &Var;
   if &Var lt &Low and not missing(&Var) then do;
      Reason='Low';
      output;
   end;
   %if %upcase(&Missing) ne IGNORE %then %do;
   else if missing(&Var) then do;
      Reason='Missing';
      output;
   end;
   %end;

   else if &Var gt &High then do;
        Reason='High';
      output;
      end;
      drop &Var;
   run;
   proc append base=errors data=tmp;
   run;

%mend errors;

***Error Reporting Macro - to be run after ERRORS has been called
   as many times as desired for each numeric variable to be tested;

%macro report;
   proc sort data=errors;
      by &Idvar;
   run;

   
   proc print data=errors;
      title "Error Report for Data Set &Dsn";
      id &Idvar;
      var Variable Value Reason;
   run;

   proc datasets library=work nolist;
      delete errors;
      delete tmp;
   run;
   quit;

%mend report;

***Set two macro variables;
%let dsn=clean.patients; 
%let Idvar = Patno;

%errors(Var=HR, Low=40, High=100, Missing=error)
%errors(Var=SBP, Low=80, High=200, Missing=ignore)
%errors(Var=DBP, Low=60, High=120)

***Generate the report;
%report

*Program 2-18;
proc format;
   value hr_ck  40-100, . = 'OK';
   value sbp_ck 80-200, . = 'OK';
   value dbp_ck 60-120, . = 'OK';
run;

title "Listing of patient numbers and invalid data values";
data _null_;
   set clean.patients(keep=Patno HR SBP DBP);
   file print; ***send output to the output window;
   ***note: we will only input those variables of interest;
   if put(HR,hr_ck.)   ne 'OK' then put Patno= HR=;
   if put(SBP,sbp_ck.) ne 'OK' then put Patno= SBP=;
   if put(DBP,dbp_ck.) ne 'OK' then put Patno= DBP=;
run;

*Program 2-19;
proc format;
   invalue hr_ck  40-100 = _same_
                  other  = .;
   invalue sbp_ck 80-200 = _same_
                  other  = .;
   invalue dbp_ck 60-120 = _same_
                  other  = .;
run;

data valid_numerics;
   infile "c:\books\clean\patients.txt" truncover;
   file print; ***send output to the output window;
   ***Note: we will only input those variables of interest;
   input @1  Patno    $3.
         @15 HR        hr_ck3.
         @18 SBP       sbp_ck3.
         @21 DBP       dbp_ck3.;
run;

title "Using User-Defined Informats to Filter Invalid Values";
proc print data=valid_numerics;
   id Patno;
run;

*Program 2-20;
libname clean "c:\books\clean";
***Output means and standard deviations to a data set;
proc means data=clean.patients noprint;
   var HR;
   output out=means(drop=_type_ _freq_)
          mean=M_HR
          std=S_HR;
run;

title "Outliers for HR Based on 2 Standard Deviations";
data _null_;
   file print;
   set clean.patients(keep=Patno HR);
   ***bring in the means and standard deviations;
   if _n_ = 1 then set means;
   if HR lt M_HR - 2*S_HR and not missing(HR) or
      HR gt M_HR + 2*S_HR then put Patno= HR=;
run;
         
*Program 2-21;
proc rank data=clean.patients(keep=Patno HR) out=tmp groups=5;
   var HR;
   ranks R_HR;
run;

title "First 20 Observations in Data Set TMP";
proc print data=tmp(obs=20);
run;

proc means data=tmp noprint;
   where R_HR not in (0,4);
   *Trimming the top and bottom 20%;
   var HR;
   output out=means(drop=_type_ _freq_)
          mean=M_HR
          std=S_HR;
run;

proc means data=tmp noprint;
   where R_HR not in (0,4);  ***the middle 80%;
   var HR;
   output out=means(drop=_type_ _freq_)
          mean=M_HR
          std=S_HR;
run;

title "Listing of data set MEANS";
proc print data=means noobs;
run;

*Program  2-22;
proc rank data=clean.patients(keep=Patno HR) out=tmp groups=5;
   var HR;
   ranks R_HR;
run;

proc means data=tmp noprint;
   where R_HR not in (0,4);  ***the middle 60%;
   var HR;
   output out=means(drop=_type_ _freq_)
          mean=M_HR
          std=S_HR;
run;

title "Outliers Based on Trimmed Statistics";

%let N_sd = 2;
%let Mult = 2.12;
   
data _null_;
   file print;

   set clean.patients;
   if _n_ = 1 then set means;
   if HR lt M_HR - &N_sd*S_HR*&Mult and not missing(HR) or
      HR gt M_HR + &N_sd*S_HR*&Mult then put Patno= HR=;
run;

*Program 2-23;
%macro trimmed
   (/* the data set name (DSN) and ID variable (IDVAR)
       need to be assigned with %let statements
       prior to calling this macro */
       Var=,     /* Variable to test for outliers */
       N_sd=2,   /* Number of standard deviations */
       Trim=10   /* Percent top and bottom trim   */
                 /* Valid values of Trim are      */
                 /* 5, 10, 20, and 25             */);

   /*************************************************************
   
   Example:
   %let dsn=clean.patients;
   %let idvar=Patno;

   %trimmed(Var=HR,
            N_sd=2,
            Trim=20)

   **************************************************************/
   title "Outliers for &Var based on &N_sd Standard Deviations";
   title2 "Trimming &Trim% from the Top and Bottom of the Values";

   %if &Trim eq 5 or
       &Trim eq 10 or
       &Trim eq 20 or
       &Trim eq 25 %then %do;
   
   %let NGroups = %eval(100/&Trim);
   %if &Trim = 5 %then %let Mult = 1.24;
   %else %if &trim = 10 %then %let Mult = 1.49;
   %else %if &trim = 20 %then %let Mult = 2.12;
   %else %if &trim = 25 %then %let Mult = 2.59;

   proc rank data=&dsn(keep=&Idvar &Var)
             out=tmp groups=&NGroups;
      var &var;
      ranks rank;
   run;
   proc means data=tmp noprint;
      where rank not in (0,%eval(&Ngroups - 1));
      var &Var;
      output out=means(drop=_type_ _freq_)
             mean=Mean
             std=Sd;
   run; 

   data _null_;
      file print;
      set &dsn;
      if _n_ = 1 then set means;
      if &Var lt Mean - &N_sd*&Mult*Sd and 
         not missing(&Var) or 
         &Var gt Mean + &N_sd*&Mult*Sd 
         then put &Idvar= &Var=;
   run;

   proc datasets library=work;
      delete means;
   run;
   quit;
   %end;
   %else %do;
   data _null_;
      file print;
      put "You entered a value of &trim for the Trim Value."/
          "It must be 5, 10, 20, or 25";
   run;
   %end;

%mend trimmed;

/***************************************************
Sample call:

****************************************************/

%let Dsn=clean.patients;
%let Idvar=Patno;

%trimmed(Var=HR, N_sd=2, Trim=20)

%let Dsn=clean.patients;
%let Idvar=Patno;
%trimmed(Var=HR, N_sd=2, Trim=25)

%trimmed(Var=SBP, N_sd=2, Trim=20)
%trimmed(Var=DBP, N_sd=2, Trim=20)

*Program 2-24;
title "Trimmed statistics for HR with TRIM=5";
proc Univariate data=clean.patients trim=5;
   var HR;
run;

*Program 2-25;
ods output TrimmedMeans=Trimmed5(keep=VarName Mean Stdmean DF);
ods listing close;
proc univariate data=clean.patients trim=5;
  var HR SBP DBP;
run ;
ods output close ;
ods listing;

title "Listing of Data Det TRIMMED5";
proc print data=trimmed5 noobs;
run;

*Non-macro version to use proc univariate
  ods output and restructuring ;
data restructure;
   set clean.patients;
   length Varname $ 32;
   array vars[*] HR SBP DBP;
   do i = 1 to dim(vars);
      Varname = vname(vars[i]);
      Value = vars[i];
      output;
   end;
   keep Patno Varname Value;
run;

proc sort data=trimmed5;
   by Varname;
run;

proc sort data=restructure;
   by Varname;
run;

data outliers;
   merge restructure trimmed5;
   by Varname;
   Std = StdMean*sqrt(DF + 1);
   if Value lt Mean - 2*Std and not missing(Value) or
      Value gt Mean + 2*Std;
run;

proc sort data=outliers;
   by Patno;
run;
    
title "Outliers based on trimmed Statistics";
proc print data=outliers;
   id Patno;
   var Varname Value;
run;

*Program 2-26;
%macro auto_outliers(
   Dsn=,      /* Data set name                        */
   ID=,       /* Name of ID variable                  */
   Var_list=, /* List of variables to chec k          */
              /* separate names with spaces           */
   Trim=.1,   /* Integer 0 to n = number to trim      */
              /* from each tail; if between 0 and .5, */
              /* proportion to trim in each tail      */
   N_sd=2     /* Number of standard deviations        */);
   ods listing close;
   ods output TrimmedMeans=trimmed(keep=VarName Mean Stdmean DF);
   proc univariate data=&Dsn trim=&Trim;
     var &Var_list;
   run;
   ods output close;

   data restructure;
      set &Dsn;
      length Varname $ 32;
      array vars[*] &Var_list;
      do i = 1 to dim(vars);
         Varname = vname(vars[i]);
         Value = vars[i];
         output;
      end;
      keep &ID Varname Value;
   run;

   proc sort data=trimmed;
      by Varname;
   run;

   proc sort data=restructure;
      by Varname;
   run;

   data outliers;
      merge restructure trimmed;
      by Varname;
      Std = StdMean*sqrt(DF + 1);
      if Value lt Mean - &N_sd*Std and not missing(Value) 
         then do;
            Reason = 'Low  ';
            output;
         end;
      else if Value gt Mean + &N_sd*Std
         then do;
         Reason = 'High';
         output;
      end;
   run;

   proc sort data=outliers;
      by &ID;
   run;

   ods listing;
   title "Outliers based on trimmed Statistics";
   proc print data=outliers;
      id &ID;
      var Varname Value Reason;
   run;

   proc datasets nolist library=work;
      delete trimmed;
      delete restructure;
      *Note: work data set outliers not deleted;
   run;
   quit;
%mend auto_outliers;

%auto_outliers(Dsn=clean.patients,
               ID=Patno,
               Var_list=HR SBP DBP,
               Trim=.2,
               N_sd=2)

*Program 2-27;
%macro interquartile
   (/* the data set name (Dsn) and ID variable (Idvar)
       need to be assigned with %let statements
       prior to calling this macro */
       var=,     /* Variable to test for outliers  */
       n_iqr=2   /* Number of interquartile ranges */);

/****************************************************************
This macro will list outliers based on the interquartile range.

Example: To list all values beyond 1.5 interquartile ranges
   from a data set called clean.patients for a variable
   called hr, use the following:

   %let Dsn=clean.patients;
   %let Idvar=Patno;

   %interquartile(var=HR,
                  n_iqr=1.5)
****************************************************************/

   title "Outliers Based on &N_iqr Interquartile Ranges";

   proc means data=&dsn noprint;
      var &var;
      output out=tmp 
             q1=Lower
             q3=Upper
             qrange=Iqr;
   run;

   data _null_;
      set &dsn(keep=&Idvar &Var);
      file print;
      if _n_ = 1 then set tmp;
      if &Var le Lower - &N_iqr*Iqr and not missing(&Var) or
         &Var ge Upper + &N_iqr*Iqr then   
         put &Idvar= &Var=;
   run;

   proc datasets library=work;
      delete tmp;
   run;
   quit;
%mend interquartile;

%interquartile(var=HR,n_iqr=1.5)


*Program 3-1;
libname clean "c:\books\clean";

title "Missing value check for the patients data set";

proc means data=clean.patients n nmiss;
run;

proc format;
   value $misscnt ' '   = 'Missing'
                  other = 'Nonmissing';
run;

proc freq data=clean.patients;
   tables _character_ / nocum missing;
   format _character_ $misscnt.;
run;

*Program 3-2;
title "Listing of missing values";
data _null_;
   file print; ***send output to the output window;
   set clean.patients(keep=Patno Visit HR AE);
   if missing(visit) then 
      put "Missing or invalid visit date for ID " Patno;
   if missing(hr) then put "Missing or invalid HR for ID " Patno;
   if missing(AE) then put "Missing value for ID " Patno;
run;

*Program 3-3;
title "Listing of missing patient numbers";
data _null_;
   set clean.patients;
   ***Be sure to run this on the unsorted data set;
   file print;
   Prev_id = lag(Patno);
   Prev2_id = lag2(Patno);
   if missing(Patno) then put "Missing patient ID. Two previous ID's are:"
      Prev2_id "and " Prev_id / @5 "Missing record is number " _n_;
   else if notdigit(trim(Patno)) then
      put "Invalid patient ID:" patno +(-1)". Two previous ID's are:"
      Prev2_id "and " Prev_id / @5 "Missing record is number " _n_;
run;

*Program 3-4;
title "Data listing for patients with missing or invalid ID's";
proc print data=clean.patients;
   where missing(Patno) or notdigit(trim(Patno));
run;

*Program 3-5;
title "Listing of missing values";
data _null_;
   set clean.patients(keep=Patno Visit HR AE) end=last;
   file print; ***Send output to the output window;
   if missing(Visit) then do;
      put "Missing or invalid visit date for ID " Patno;
      N_visit + 1;
   end;
   if missing(HR) then do;
      put "Missing or invalid HR for ID " Patno;
      N_HR + 1;
   end;
   if missing(AE) then do;
      put "Missing AE for ID " Patno;
      N_AE + 1;
   end;

   if last then
           put // "Summary of missing values" /
           25*'-' /
           "Number of missing dates = " N_visit /
           "Number of missing HR's = " N_HR /
           "Number of missing adverse events = " N_AE;
run;

*Program 3-6;
***Create test data set;
data test;
   input X Y A $ X1-X3 Z $;
datalines;
1 2 X 3 4 5 Y
2 999 Y 999 1 999 J
999 999 R 999 999 999 X
1 2 3 4 5 6 7
;

***Program to detect the specified values;
data _null_;
   set test;
   file print;
   array nums[*] _numeric_;
   length Varname $ 32;
   do __i = 1 to dim(nums);
      if nums[__i] = 999 then do;
         Varname = vname(nums[__i]);
         put "Value of 999 found for variable " Varname
             "in observation " _n_;
      end;
   end;
   drop __i;
run;

*Program 3-7;
*-----------------------------------------------------------------*
| Macro name: find_value.sas  in c:\books\clean                   |
| purpose: Identifies any specified value for all numeric vars    |
| Calling arguments: dsn=   sas data set name                     |
|                    value=   numeric value to search for         |
| example:  to find variable values of 9999 in data set test, use |
|           %find_value(dsn=test, value=9999)                     |
*-----------------------------------------------------------------*;
%macro find_value(dsn=,      /* The data set name                 */
                  value=999  /* Value to look for, default is 999 */ );
   title "Variables with &value as missing values";
   data temp;
      set &dsn;
      file print;
      length Varname $ 32;
      array nums[*] _numeric_;
      do __i = 1 to dim(nums);
         if nums[__i] = &value then do;
         Varname = vname(nums[__i]);
         output;
         end;
      end;
      keep Varname;
   run;
   proc freq data=temp;
      tables Varname / out=summary(keep=Varname Count)
                       nocum;
   run;
   proc datasets library=work;
      delete temp;
   run;
   quit;
%mend find_value;

%find_value(dsn=test,value=999)

*Program 4-1;
libname clean "c:\books\clean";

title "Dates before June 1, 1998 or after October 15, 1999";
data _null_;
   file print;
   set clean.patients(keep=visit patno);
   if visit lt '01jun1998'd and not missing(visit) or
      visit gt '15oct1999'd then put Patno= Visit= mmddyy10.;
run;

*Program 4-2;
title "Dates before June 1, 1998 or after October 15, 1999";
proc print data=clean.patients;
   where Visit not between '01jun1998'd and '15oct1999'd and 
   not missing(Visit);
   id Patno;
   var Visit;
   format Visit date9.;
run;

*Program 4-3;
data dates;
   infile "c:\books\clean\patients.txt" truncover lrecl=20;
   /*Note: The lrecl=20 was included so that the log would
     fit on the book page.  It is not necessary to use it */
   input @5 Visit mmddyy10.;
   format Visit mmddyy10.;
run;

*Program 4-4;
title "Listing of missing and invalid dates";
data _null_;
   file print;
   infile "c:\books\clean\patients.txt" truncover;
   input @1 Patno $3.
         @5 Visit mmddyy10.
         @5 V_date $char10.;
   format Visit mmddyy10.;
   if missing(Visit) then put Patno= V_date=;
run;

*Program 4-5;
title "Listing of missing and invalid dates";
data _null_;
   file print;
   infile "c:\books\clean\patients.txt" truncover;
   input @1 Patno $3.
         @5 V_date $char10.;
   Visit = input(V_date,mmddyy10.);
   format Visit mmddyy10.;
   if missing(Visit) then put Patno= V_date=;
run;

*Program 4-6;
title "Listing only invalid dates";
data _null_;
   file print;
   infile "c:\books\clean\patients.txt" truncover;
   input @1 Patno $3.
         @5 V_date $char10.;
   
   Visit = input(V_date,mmddyy10.);
   format Visit mmddyy10.;
   if missing(Visit) and not missing(V_date) then put Patno= V_date=;
run;

*Program 4-7;
data nonstandard;
   input Patno $ 1-3 Month 6-7 Day 13-14 Year 20-23;
   Date = mdy(Month,Day,Year);
   format date mmddyy10.;
datalines;
001  05     23     1998
006  11     01     1998
123  14     03     1998
137  10            1946
;
title "Listing of data set NONSTANDARD";
proc print data=nonstandard;
   id Patno;
run;

*Program 4-8;
data no_day;
   input @1 Date1 monyy7. @8 Month 2. @10 Year 4.;
   Date2 = mdy(Month,15,Year);
   format Date1 Date2 mmddyy10.;
datalines;
JAN98  011998
OCT1998101998
;
title "Listing of data set NO_DAY";
proc print data=NO_DAY;
run;

*Program 4-9;
data miss_day;
   input @1  Patno  $3.
         @4  Month   2.
         @6  Day     2.
         @8  Year    4.;
   if not missing(Day) then Date = mdy(Month,Day,Year);
   else Date = mdy(Month,15,Year);
   format Date mmddyy10.;
datalines;
00110211998
00205  1998
00344  1998
;
title "Listing of data set MISS_DAY";
proc print data=miss_day;
run;

*Program 4-10;
data dates;
   infile "c:\books\clean\patients.txt" truncover;
   input @5 visit ?? mmddyy10.;
   format visit mmddyy10.;
run;

*Program 4-11;
title "Listing of missing and invalid dates";
data _null_;
   file print;
   infile "c:\books\clean\patients.txt" truncover;
   input @1 Patno $3.
         @5 V_date $char10.;
   Visit = input(V_date,?? mmddyy10.);
   format Visit mmddyy10.;
   if missing(Visit) then put Patno= V_date=;
run;

*Program 5-1;
libname clean "c:\books\clean";

proc sort data=clean.patients out=single nodupkey;
   by Patno;
run;

title "Data Set SINGLE - Duplicated ID's Removed from PATIENTS";
proc print data=single;
   id Patno;
run;

*Program 5-2;
proc sort data=clean.patients out=single noduprecs;
   BY Patno;
run;

title "Listing of data set SINGLE";
proc print data=SINGLE noobs;
run;

*program 5-3;
data multiple;
   input Patno $ x y;
datalines;
001 1 2
006 1 2
009 1 2
001 3 4
001 1 2
009 1 2
001 1 2
;
proc sort data=multiple out=single;
   by Patno;
run;

title "Listing of data set SINGLE";
proc print data=single ;
run;

*Program 5-4;
proc sql;
   create table single as
   select distinct *
   from multiple;
quit;

*Program 5-5;
proc sort data=clean.patients out=tmp;
   by Patno;
run;

data dup;
   set tmp;
   by Patno;
   if first.Patno and last.Patno then delete;
run;

title "Listing of duplicates from data set CLEAN.PATIENTS";
proc print data=dup;
   id Patno;
run;

*Raw data file patients2.txt to follow
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
;

*Program 5-6;
data clean.patients2;
   infile "c:\books\clean\patients2.txt" truncover;
   input @1  Patno  $3.
         @4  Visit  mmddyy10.
         @14 HR      3.
         @17 SBP     3.
         @20 DBP     3.;
   format Visit mmddyy10.;
run;

title "Listing of data set CLEAN.PATIENTs2";
proc print data=clean.patients2 noobs;
run;

*Program 5-7;
proc sort data=clean.patients2 out=tmp;
   by Patno Visit;
run;

data dup;
   set tmp;
   by Patno Visit;
   if first.Visit and last.Visit then delete;
run;

title "Listing of Duplicates from Data Set CLEAN.PATIENTS2";
proc print data=dup;
   id Patno;
run;

*Program 5-8;
proc freq data=clean.patients noprint;
   tables Patno / out=dup_no(keep=Patno Count
                             where=(Count gt 1));
run;

proc sort data=clean.patients out=tmp;
   by Patno;
run;

proc sort data=dup_no;
   by Patno;
run;

data dup;
   merge tmp dup_no(in=Yes_dup drop=Count);
   by Patno;
   if Yes_dup;
run;

title "Listing of data set dup";
proc print data=dup;
run;

*Program 5-9;
proc freq data=clean.patients noprint;
   tables Patno / out=dup_no(keep=Patno Count
                             where=(Count gt 1));
run;

title "Patients with duplicate observations";
proc print data=dup_no noobs;
run;

*Program 5-10;
proc sql noprint;
   select quote(Patno)
      into :Dup_list separated by " "
      from dup_no;
quit;

title "Duplicates selected using SQL and a macro variable";
proc print data=clean.patients;
   where Patno in (&Dup_list);
run;

*Program 5-11;
proc sort data=clean.patients2(keep=Patno) out=tmp;
   by Patno;
run;

title "Patient ID's for patients with other than two observations";
data _null_;
   file print;
   set tmp;  
   by Patno;
   if first.Patno then n = 0;
   n + 1;
   if last.Patno and n ne 2 then put
      "Patient number " Patno "has " n "observation(s).";
run;

*Program 5-12;
proc freq data=clean.patients2 noprint;   
   tables Patno / out=dup_no(keep=Patno Count
                             where=(Count ne 2));   
run;

title "Patient ID's for patients with other than two observations";
proc print data=dup_no noobs;
run;

*Program 6-1;
libname clean "c:\books\clean";

data one;
   input Patno x y;
datalines;
1 69 79
2 56 .
3 66 99
5 98 87
12 13 14
;
data two;
   input Patno z;
datalines;
1 56
3 67
4 88
5 98
13 99
;

*Program 6-2;
proc sort data=one;
   by Patno;
run;

proc sort data=two;
   by Patno;
run;

title "Listing of missing ID's";
data _null_;
   file print;
   merge one(in=Inone)
         two(in=Intwo)  end=Last;   
   by Patno;   

   if not Inone then do;   
      put "ID " Patno "is not in data set one";
      n + 1;
   end;

   else if not Intwo then do;   
      put "ID " Patno "is not in data set two";
      n + 1;
   end;

   if Last and n eq 0 then
      put "All ID's match in both files";   
run;

*Program 6-3;
data three;
   input Patno Gender $;
datalines;
1 M
2 F
3 M
5 F
6 M
12 M
13 M
;

*Program 6-4;
proc sort data=one(keep=Patno) out=tmp1;
   by Patno;
run;

proc sort data=two(keep=Patno) out=tmp2;
   by Patno;
run;

proc sort data=three(keep=Patno) out=tmp3;
   by Patno;
run;

title "Listing of missing ID's and data set names";
data _null_;
   file print;
   merge tmp1(in=In1)
         tmp2(in=In2)
         tmp3(in=In3)  end=Last;
   by Patno;

   if not In1 then do;
      put "ID " Patno "missing from data set one";
      n + 1;
   end;

   if not In2 then do;
      put "ID " Patno "missing from data set two";
      n + 1;
   end;

   if not In3 then do;
      put "ID " Patno "missing from data set three";
      n + 1;
   end;

   if Last and n eq 0 then
      put "All id's match in all files";

run;

*Program 6-5;
*----------------------------------------------------------------*
| Program Name: check_id.sas  in c:\books\clean                  |
| Purpose: Macro which checks if an ID exists in each of n files |
| Arguments: The name of the ID variable, followed by as many    |
|            data sets names as desired, separated by BLANKS     |
| Example: %check_id(ID = Patno,                                 |
|                    Dsn_list=one two three)                     |
| Date: Sept 17, 2007                                            |
*----------------------------------------------------------------*;
%macro check_id(ID=,       /* ID variable              */
                Dsn_list=  /* List of data set names,  */
                           /* separated by spaces      */);
   %do i = 1 %to 99;
     /* break up list into data set names */
      %let Dsn = %scan(&Dsn_list,&i);  
      %if &Dsn ne %then %do; /* If non null data set name */
         %let n = &i;    /* When you leave the loop, n will */
                         /* be the number of data sets      */
         proc sort data=&Dsn(keep=&ID) out=tmp&i;
            by &ID;
         run;
      %end;
   %end;
   
   title  "Report of data sets with missing ID's";
   title2 "-------------------------------------";
   data _null_;
      file print;
      merge

      %do i = 1 %to &n;
         tmp&i(in=In&i)
      %end;

      end=Last;
      by &ID;

      if Last and nn eq 0 then do;
         put "All ID's Match in All Files";
         stop;
      end;

      %do i = 1 %to &n;
         %let Dsn = %scan(&Dsn_list,&i);
         if not In&i then do;
            put "ID " &ID "missing from data set &dsn";
            nn + 1;
         end;
      %end;

      run;

%mend check_id;

%check_id(Id=Patno,Dsn_list=one two three)

*Program 6-6;
data clean.ae;
   input @1  Patno   $3.
         @4  Date_ae mmddyy10.
         @14 A_event $1.;
   label Patno   = 'Patient ID'
         Date_ae = 'Date of AE'
         A_event = 'Adverse event';
   format Date_ae mmddyy10.;
datalines;
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

title "Listing of data set AE";
proc print data=clean.ae noobs;
run;

*Program 6-7;
data clean.lab_test;
   input @1  Patno    $3.
         @4  Lab_date date9.
         @13 WBC      5.
         @18 RBC      4.;
   label  Patno    = 'Patient ID'
          Lab_date = 'Date of lab test'
          WBC      = 'White blood cell count'
          RBC      = 'Red blood cell count';
   format Lab_date mmddyy10.;
datalines;
00115NOV1998 90005.45
00319NOV1998 95005.44
00721OCT1998 82005.23
00422DEC1998110005.55
02501JAN1999 82345.02
02210OCT1998 80005.00
;

title "Listing of data set LAB_TEST";
proc print data=clean.lab_test noobs;
run;

*Program 6-8;
proc sort data=clean.ae(where=(A_event = 'X')) out=ae_x;  
   by Patno;
run;

proc sort data=clean.lab_test(keep=Patno Lab_date) out=lab;
   by Patno;
run;

data missing;
   merge ae_x
         lab(in=In_lab);
   by Patno;
   if not In_lab; 
run;

title "Patients with AE of X who are missing a lab test entry";
proc print data=missing label;
   id Patno;
   var Date_ae A_event;
run;

*Program 6-9;
title  "Patients with AE of X Who Are Missing Lab Test Entry";
title2 "or the Date of the Lab Test Is Earlier Than the AE Date";
title3 "-------------------------------------------------------";

data _null_;
   file print;
   merge ae_x(in=In_ae)
         lab(in=In_lab);
   
   by Patno;
   if not In_lab then put
      "No lab test for patient " Patno "with adverse event X";
   else if In_ae and missing(Lab_date) then put
      "Date of lab test is missing for patient "
      Patno /
      "Date of AE is " Date_ae /;
   else if In_ae and Lab_date lt Date_ae then put
      "Date of lab test is earlier than date of AE for patient "
      Patno /
      "  date of AE is " Date_ae " date of lab test is " Lab_date /;
run;

*raw data files file_1.txt to follow
001M10211946130 80
002F12201950110 70
003M09141956140 90
004F10101960180100
007m10321940184110
;

*raw data file file_2.txt to follow
001M1021194613080
002F12201950110 70
003M09141956144 90
004F10101960180100
007M10231940184110
;

*Program 7-1;
libname clean "c:\books\clean";

data one;
   infile "c:\books\clean\file_1.txt" truncover;
   input @1  Patno  3.
         @4  Gender $1.
         @5  DOB    mmddyy8.
         @13 SBP    3.
         @16 DBP    3.;
   format DOB mmddyy10.;
run;

data two;
   infile "c:\books\clean\file_2.txt" truncover;
   input @1  Patno  3.
         @4  Gender $1.
         @5  DOB    mmddyy8.
         @13 SBP    3.
         @16 DBP    3.;
   format dob mmddyy10.;
run;

*Program 7-2;
title "Using PROC COMPARE to compare two data sets";
proc compare base=one compare=two;
   id Patno;
run;

*Program 7-2b;
title "Using PROC COMPARE to compare two data sets";
proc compare base=one compare=two brief;
   id Patno;
run;

*Program 7-3;
title "Demonstrating the TRANSPOSE Option";
proc compare base=one compare=two brief transpose;
   id Patno;
run;

*Program 7-4;
data one;
   infile "c:\books\clean\file_1.txt" 
      truncover;
   input @1  patno  $char3.
         @4  gender $char1.
         @5  dob    $char8.
         @13 sbp    $char3.
         @16 dbp    $char3.;
run;
data two;
   infile "c:\books\clean\file_2.txt" 
      truncover;
   input @1  patno  $char3.
         @4  gender $char1.
         @5  dob    $char8.
         @13 sbp    $char3.
         @16 dbp    $char3.;
run;

title "Using PROC COMPARE to compare two data sets";
proc compare base=one compare=two brief;
   id Patno;
run;

*raw data file file_1b.txt to follow
001M10211946130 80
002F12201950110 70
003M09141956140 90
004F10101960180100
005M01041930166 88
007m10321940184110
;

*raw data file file_2b.txt to follow
001M1021194613080
002F12201950110 70
003M09141956144 90
007M10231940184110
;

*Program 7-5;
data one_b;
   infile "c:\books\clean\file_1b.txt" truncover;
   input @1  Patno  3.
         @4  Gender $1.
         @5  DOB    mmddyy8.
         @13 SBP    3.
         @16 DBP    3.;
   format DOB mmddyy10.;
run;

data two_b;
   infile "c:\books\clean\file_2b.txt" truncover;
   input @1  Patno  3.
         @4  Gender $1.
         @5  DOB    mmddyy8.
         @13 SBP    3.
         @16 DBP    3.;
   format dob mmddyy10.;
run;
title "Comparing Two Data Sets with Different ID Values";
proc compare base=one_b compare=two_b listbase listcompare;
   id Patno;
run;

*Program 7-6;
***Program to create data sets DEMOG and OLDDEMOG;
data demog;
   input  @1  Patno  3.
          @4  Gender $1.
          @5  DOB    mmddyy10.
          @15 Height 2.;
   format DOB mmddyy10.;
datalines;
001M10/21/194668
003F11/11/105062
004M04/05/193072
006F05/13/196863
;

data olddemog;
   input @1  Patno  3.
         @4  DOB    mmddyy8.
         @12 Gender $1.
         @13 Weight 3.;
   format DOB mmddyy10.;
datalines;
00110211946M155
00201011950F102
00404051930F101
00511111945M200
00605131966F133
;

*Program 7-7;
title "Comparing demographic information between two data sets";
proc compare base=olddemog compare=demog brief;
   id Patno;
run;

*Program 7-8;
title "Comparing demographic information between two data sets";
proc compare base=olddemog compare=demog brief;
   id Patno;
   var Gender;
run;

*Program 8-1;
libname clean "c:\books\clean";

*Data set ONE is created so you can run this program;
data one;
   input X Y Z;
datalines;
1 2 3
101 202 303
44 55 66
444 555 666
;
title "Values of X from data set ONE where X is greater than 100";
proc sql;
   select X
   from one
   where X gt 100;
quit;

*Program 8-2;
***Checking for invalid character data;
title "Checking for Invalid Character Data";
proc sql;
   select Patno,
          Gender,
          DX,
          AE
   from clean.patients
   where Gender not in ('M','F',' ')           or
         notdigit(trim(DX))and not missing(DX) or
         AE not in ('0','1',' ');
quit;

*Program 8-3;
title "Checking for out-of-range numeric values";
proc sql;
   select Patno,
          HR,
          SBP,
          DBP
   from clean.patients
   where HR  not between 40 and 100 and not missing(HR)    or
         SBP not between 80 and 200 and not missing(SBP)   or
         DBP not between 60 and 120 and not missing(DBP);
quit;

*Program 8-4;
title "Data values beyond two standard deviations";
proc sql;
   select Patno,
          SBP
   from clean.patients
   having SBP not between mean(SBP) - 2 * std(SBP) and
      mean(SBP) + 2 * std(SBP)                     and
      SBP is not missing;
quit;

*Program 8-5;
options linesize=84;
title "Observations with missing values";
proc sql;
   select *
   from clean.patients
   where Patno   is missing or
         Gender  is missing or
         Visit   is missing or
         HR      is missing or
         SBP     is missing or
         DBP     is missing or
         DX      is missing or
         AE      is missing;
quit;

*Program 8-6;
title "Dates before June 1, 1998 or after October 15, 1999";
proc sql;
   select Patno,
          Visit
   from clean.patients
   where Visit not between '01jun1998'd and '15oct1999'd and
         Visit is not missing;
quit;

*Program 8-7;
title "Duplicate Patient Numbers";
proc sql;
   select Patno,
          Visit
      from clean.patients
      group by Patno
      having count(Patno) gt 1;
quit;

*Program 8-8;
title "Listing of patients who do not have two visits";
proc sql;
   select Patno,
          Visit
      from clean.patients2
      group by Patno
      having count(Patno) ne 2;
quit;

*Program 8-9;
data one;
   input Patno X Y;
datalines;
1 69 79
2 56 .
3 66 99
5 98 87
12 13 14
;
data two;
   input Patno Z;
datalines;
1 56
3 67
4 88
5 98
13 99
;

*Program 8-10;
title "Patient numbers not in both files";
proc sql;
   select One.patno as ID_one,
          Two.patno as ID_two
   from one full join two
   on One.patno eq Two.patno
   where One.patno is missing or Two.patno is missing;
quit;

*Program 8-11;
title1 "Patients with an AE of X who did not have a";
title2 "labtest or where the date of the test is prior";
title3 "to the date of the visit";
proc sql;
   select AE.Patno as AE_Patno label="AE patient number",
          A_event,
          Date_ae,
          Lab_test.Patno as Labpatno label="Lab patient number",
          Lab_date
   from clean.ae left join clean.lab_test
   on AE.Patno=Lab_test.Patno
   where A_event = 'X'        and
         Lab_date lt Date_ae;
quit;

*Program 8-12;
proc sql;
   title "Left join";
   select one.Patno as One_id,
          two.patno as Two_id
   from one left join two
   on one.Patno eq two.Patno;

   title "Right join";
   select one.Patno as One_id,
          two.Patno as Two_id
   from one right join two
   on one.Patno eq two.Patno;

   title "Full join";
   select one.Patno as One_id,
          two.Patno as Two_id
   from one full join two
   on one.Patno eq two.Patno;
quit;

*Prograsm 9-1;
libname clean 'c:\books\clean';

data clean.patients_24Sept2007;
   set clean.patients;
   if Patno = '002' then DX = '3';
   else if Patno = '003' then do;
      Gender = 'F';
      SBP = 160;
   end;
   else if Patno = '004' then do;
      SBP = 188;
      DBP = 110;
      HR = 90;
   end;
***and so forth;
run;

*Program 9-2;
data named;
   length Char $ 3;
   input x=
         y=
         char=;
datalines;
x=3 y=4 char=abc
y=7
char=xyz z=9
;
title "Listing of data set NAMED";
proc print data=named noobs;
run;

*Program 9-3;
data correct_24Sept2007;
   length Patno DX $ 3
          Gender Drug $ 1;
   input Patno=
         DX=
         Gender=
         Drug=
         HR=
         SBP=
         DBP=;
datalines;
Patno=002 DX=3
Patno=003 Gender=F SBP=160
Patno=004 SBP=188 DBP=110 HR=90
;
title "Listing of CORRECT_24Sept2007";
proc print data=correct_24Sept2007 noobs;
run;

*Program 9-4;
data inventory;
   length PartNo $ 3;
   input PartNo $ Quantity Price;
datalines;
133 200 10.99
198 105 30.00
933 45 59.95
;
data transaction;
   length PartNo $ 3;
   input Partno=
         Quantity=
         Price=;
datalines;
PartNo=133 Quantity=195
PartNo=933 Quantity=40 Price=69.95
;
proc sort data=inventory;
   by Partno;
run;
proc sort data=transaction;
   by PartNo;
run;
data inventory_24Sept2007;
   update inventory transaction;
   by Partno;
run;

title "Listing of data set INVENTORY_24Sept2007";
proc print data=inventory_24Sept2007;
run;

*Program 10-1;
libname clean "c:\books\clean";

data health;
   input Patno : $3. Gender : $1.  HR    SBP    DBP;
datalines;
001 M  88 140  80
002 F  84 120  78
003 M  58 112  74
004 F   . 200 120
007 M  88 148 102
015 F  82 148  88
;
title "Listing of data set HEALTH";
proc print data=health noobs;
run;

*Program 10-2;
proc datasets library=work nolist;
   modify health;
      ic create gender_chk = check
         (where=(gender in('F','M')));

      ic create hr_chk = check
         (where=( HR between 40 and 100 or HR is missing));

      ic create sbp_chk = check
         (where=(SBP between 80 and 200 or SBP is missing));

      ic create dbp_chk = check
         (where=(DBP between 60 and 140));

      ic create id_chk = unique(Patno);
quit;

title "Output from PROC CONTENTS (selected portions)";
proc contents data=health;
run;

*Program 10-3;
data new;
   input Patno : $3. Gender : $1. HR SBP DBP;
datalines;
456 M 66 98 72
567 F 150 130 80
003 M 70 134 86
123 F 66 10 80
013 X 68 120 .
;

title "Listing of data set NEW";
proc print data=new noobs;
run;

*Program 10-4;
proc append base=health data=new;
run;

*Program 10-5;
proc datasets library=work nolist;
   modify health;
   ic delete gender_chk;
run;
quit;

*Program 10-6;
proc datasets library=work nolist;
   modify health;
      ic create gender_chk = check
         (where=(gender in('F','M')))
         message="Gender must be F or M"
         msgtype=user;

      ic create hr_chk = check
         (where=( HR between 40 and 100 or HR is missing))
         message="HR must be between 40 and 100 or missing"
         msgtype=user;

      ic create sbp_chk = check
         (where=(SBP between 80 and 200 or SBP is missing))
         message="SBP must be between 80 and 200 or missing"
         msgtype=user;

      ic create dbp_chk = check
         (where=(DBP between 60 and 140))
         message="DBP must be between 60 and 140"
         msgtype=user;

      ic create id_chk = unique(Patno)
         message="Patient number must be unique"
         msgtype=user;
quit;

*Program 10-7;
proc datasets library=work nolist;
   audit health;
   initiate;
run;

proc append base=health data=new;
run;

*Program 10-8;
title "Listing of audit trail data set";
proc print data=health(type=audit) noobs;
run;

*Program 10-9;
title "Integrity Constraint Violations";
proc report data=health(type=audit) nowd;
   where _ATOPCODE_ in ('EA' 'ED' 'EU');
   columns Patno Gender HR SBP DBP _ATMESSAGE_;
   define Patno / order "Patient Number" width=7;
   define Gender / display width=6;
   define HR / display "Heart Rate" width=5;
   define SBP / display width=3;
   define DBP / display width=3;
   define _atmessage_ / display "_IC Violation_" 
                        width=30 flow;
run;

*Program 10-10;
data correct_audit;
   set health(type=audit 
              where=(_ATOPCODE_ in ('EA' 'ED' 'EU')));
   if Patno = '003' then Patno = '103';
   else if Patno = '013' then do;
      Gender = 'F';
      DBP = 88;
   end;
   else if Patno = '123' then SBP = 100;
   else if Patno = '567' then HR = 87;
   drop _AT: ;
run;

proc append base=health data=correct_audit;
run;

title "Health data set with corrected data added";
proc print data=health noobs;
run;

*Program 10-11;
data survey;
   length ID $ 3;
   retain ID ' ' TimeTV TimeSleep TimeWork TimeOther .;
   stop;
run;

proc datasets library=work;
   modify survey;
   ic create ID_check = primary key(ID)
      message = "ID must be unique and nonmissing"
      msgtype = user;
   ic create TimeTV_max = check(where=(TimeTV le 100))
      message = "TimeTV must not be over 100"
      msgtype = user;
   ic create TimeSleep_max = check(where=(TimeSleep le 100))
      message = "TimeSleep must not be over 100"
      msgtype = user;
   ic create TimeWork_max = check(where=(TimeWork le 100))
      message = "TimeWork must not be over 100"
      msgtype = user;
   ic create TimeOther_max = check(where=(TimeOther le 100))
      message = "TimeOther must not be over 100"
      msgtype = user;
   ic create Time_total = check(where=(sum(TimeTV,TimeSleep,TimeWork,TimeOther) le 100))
      message = "Total percentage cannot exceed 100%"
      msgtype = user;
   audit survey;
   initiate;
quit;

*Program 10-12;
data add;
   input ID : $3. TimeTV TimeSleep TimeWork TimeOther;
datalines;
001 10 40 40 10
002 20 50 40 5
003 10 . . .
004 0 40 60 0
005 120 10 10 10
;

proc append base=survey data=add;
run;

title "Integrity Constraint Violations";
proc report data=survey(type=audit) nowd;
   where _ATOPCODE_ in ('EA' 'ED' 'EU');
   columns ID TimeTV TimeSleep TimeWork TimeOther _ATMESSAGE_;
   define ID / order "ID Number" width=7;
   define TimeTV / display "Time spent watching TV" width=8;
   define TimeSleep / display "Time spent sleeping" width=8;
   define TimeWork / display "Time spent working" width=8;
   define TimeOther / display "Time spent in other activities" width=10;
   define _atmessage_ / display "_Error Report_" 
                        width=25 flow;
run;

***Creating examples of referential integrity constraints;
*Program 10-13;
data master_list(label = 'Parent data set');
   input FirstName : $12. LastName : $12. DOB : mmddyy10. Gender : $1.;
   format DOB mmddyy10.;
datalines;
Julie Chen 7/7/1988 F
Nicholas Schneider 4/15/1966 M
Joanne DiMonte 6/15/1983 F
Roger Clement 9/11/1988 M
;

data salary(label='Child data set');
   input FirstName : $12. LastName : $12. Salary : comma10.;
   format Salary dollar9.;
datalines;
Julie Chen $54,123
Nicholas Schneider $56,877
Joanne DiMonte $67,800
Roger Clement $42,000
;

title "Listing of MASTER LIST";
proc print data=master_list;
run;
title "Listing of SALARY";
proc print data=salary;
run;

options linesize=82;
proc datasets library=work nolist;
   modify master_list;                                                                                                                      
   ic create prime_key = primary key (FirstName LastName);
   ic create gender_chk = check(where=(Gender in ('F','M')));
   modify salary;
   ic create foreign_key = foreign key (FirstName LastName) 
      references master_list 
   on delete restrict on update restrict;
   ic create salary_chk = check(where=(Salary le 90000));
quit;

title "Partial listing from PROC CONTENTS";
proc contents data=master_list;
run;

*Program 10-14;
*Attempt to delete an observation in the master_list;
data master_list;
   modify master_list;
   if FirstName = 'Joanne' and LastName = 'DiMonte' then remove;
run;

title "Listing of MASTER_LIST";
proc print data=master_list;
run;

*Program 10-15;
*Adding a new observation to the SALARY file that is not in MASTER_LIST;
data add_name;
   input FirstName : $12. LastName : $12. Salary : comma10.;
   format Salary dollar9.;
datalines;
David York 77,777
;

proc append base=salary data=add_name;
run;

*Program 10-16;
proc datasets library=work nolist;
   modify master_list;                                                                                                                      
   ic create prime_key = primary key (FirstName LastName);

   modify salary;
   ic create foreign_key = foreign key (FirstName LastName) 
      references master_list 
   on delete RESTRICT on update CASCADE;
quit;

data master_list;
   modify master_list;
   if FirstName = 'Roger' and LastName = 'Clement' then 
      LastName = 'Cody';
run;

title "master list";
proc print data=master_list;
run;
title "salary";
proc print data=salary;
run;

*Program 10-17;
proc datasets library=work nolist;
   modify master_list;                                                                                                                      
   ic create prime_key = primary key (FirstName LastName);

   modify salary;
   ic create foreign_key = foreign key (FirstName LastName) 
      references master_list 
   on delete SET NULL on update CASCADE;
quit;

data master_list;
   modify master_list;
   if FirstName = 'Roger' and LastName = 'Clement' then
      remove;
run;

title "Listing of MASTER LIST";
proc print data=master_list;
run;
title "Listing of SALARY";
proc print data=salary;
run;

*Program 10-18;
*Note: Foreign key must be deleted before the primary key can be deleted;
proc datasets library=work nolist;
   modify salary;
   ic delete foreign_key;
   modify master_list;
   ic delete prime_key;
quit;
