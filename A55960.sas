 /*-------------------------------------------------------------------*/
 /* Efficiency: Improving the Performance of Your SAS(R) Applications */
 /*                    by Robert Virgile                              */
 /*     Copyright(c) 1998 by SAS Institute Inc., Cary, NC, USA        */
 /*               SAS Publications order # 55960                      */
 /*                    ISBN 1-58025-228-1                             */
 /*-------------------------------------------------------------------*/


**********************************************************
**                                                      **
**  Program   :  Setup.SAS                              **
**                                                      **
**  Purpose   :  Tests of Efficiency,                   **
**               Set Initial Parameters                 **
**                                                      **
**  Written by:  Bob Virgile                            **
**                                                      **
**  Date      :  12/1/97                                **                                                     **
**                                                      **
**********************************************************;
**                                                      **
**  This program gets run first, before the subsequent  **
**  programs Chapter2.SAS through Chapter7.SAS.         **
**                                                      **
**********************************************************;
**                                                      **
**  By adjusting the macro parameter LOOPSIZE, you are  **
**  controlling how long it will take to run efficiency **
**  tests.  Most tests will use CPU time proportional   **
**  to the value of LOOPSIZE.  If you find that one     **
**  platform is significantly faster than others, you   **
**  can adjust LOOPSIZE upward.  The idea is that tests **
**  should be long enough to be accurate, but short     **
**  enough to avoid tieing up a machine forever.        **
**                                                      **
**********************************************************;
**                                                      **
**  Under MVS, the filename statement may need to be    **
**  changed, or replaced by JCL such as:                **
**                                                      **
**  //RAWDATA DD DSN=&&TEMP,DISP=(NEW,DELETE,DELETE),   **
**  //           DCB=(RECFM=FB,LRECL=20,BLKSIZE=23000), **
**  //           UNIT=SYSDA,SPACE=(TRK,(200,10))        **
**                                                      **
**********************************************************;

%let LOOPSIZE=500000;

filename rawdata 'temp.sas';

options symbolgen linesize=170 pagesize=60 source2;

data _030vars (keep=var1-var30)
     _100vars (keep=var1-var100
               rename=(var2=var2a var3=var3a var4=var4a var5=var5a
                       var6=var6a var7=var7a var8=var8a var9=var9a
                       var10=var10a var11=var11a var12=var12a
                       var13=var13a var14=var14a var15=var15a
                       var16=var16a var17=var17a var18=var18a
                       var19=var19a var20=var20a var21=var21a
                       var22=var22a var23=var23a var24=var24a
                       var25=var25a var26=var26a var27=var27a
                       var28=var28a var29=var29a var30=var30a)
               );
do var1= round(&LOOPSIZE/5) to 1 by -1;
   if      var1 < &loopsize*.04 then var100='Value #2';
   else if var1 < &loopsize*.08 then var100='Value #3';
   else if var1 < &loopsize*.12 then var100='Value #4';
   else if var1 < &loopsize*.16 then var100='Value #5';
   output;
end;
retain var2 -var15 var31-var65  0
       var16-var30 var66-var100 'Value #1';
run;

data _null_;
file rawdata noprint linesize=20;
length string $ 20;
do i=1 to &LOOPSIZE;
   if i/2 = int(i/2) then gender=' FEMALE ';
   else                   gender=' MALE   ';
   string=put(mod(i,100000), z5.) || gender || put(i,yymmdd6.);
   put string $char20.;
end;
run;

**********************************************************
**                                                      **
**  Program   :  Chapter2.SAS                           **
**                                                      **
**  Purpose   :  Tests of Efficiency for                **
**               Chapter 2 - Reading Data               **
**                                                      **
**  Written by:  Bob Virgile                            **
**                                                      **
**  Date      :  12/1/97                                **
**                                                      **
**********************************************************
**                                                      **
**  This program concatenates all test runs related     **
**  to efficiency in reading data.                      **
**                                                      **
**********************************************************;


**********************************************************
**  CHAPTER 2:  BASELINE MEASUREMENTS                   **
**********************************************************;

data _null_;
infile rawdata;
input;
run;

data _null_;
infile rawdata;
input;
run;

data _null_;
infile rawdata;
input;
run;


**********************************************************
**  TEST #2A:  AVOID LIST INPUT                         **
**********************************************************;

data _null_;
infile rawdata;
input @4 age;
run;

data _null_;
infile rawdata;
input @4 age;
run;

data _null_;
infile rawdata;
input @4 age;
run;

data _null_;
infile rawdata;
input @4 age 2.;
run;

data _null_;
infile rawdata;
input @4 age 2.;
run;

data _null_;
infile rawdata;
input @4 age 2.;
run;

data _null_;
infile rawdata;
input age 4-5;
run;

data _null_;
infile rawdata;
input age 4-5;
run;

data _null_;
infile rawdata;
input age 4-5;
run;


**********************************************************
**  TEST #2B:  CHARACTER vs. NUMERIC vs. $CHAR          **
**********************************************************;

data _null_;
infile rawdata;
input zipcode 5.;
run;

data _null_;
infile rawdata;
input zipcode 5.;
run;

data _null_;
infile rawdata;
input zipcode 5.;
run;

data _null_;
infile rawdata;
input zipcode $5.;
run;

data _null_;
infile rawdata;
input zipcode $5.;
run;

data _null_;
infile rawdata;
input zipcode $5.;
run;

data _null_;
infile rawdata;
input zipcode $char5.;
run;

data _null_;
infile rawdata;
input zipcode $char5.;
run;

data _null_;
infile rawdata;
input zipcode $char5.;
run;


**********************************************************
**  TEST #2C:  CONSECUTIVE FIELDS                       **
**********************************************************;

data _null_;
infile rawdata;
input @1 V1 1.  @2 V2 1.  @3 V3 1.  @4 V4 1.  @5 V5 1.
      @6 V6 $1.  @7 V7 $1.  @8 V8 $1.  @9 V9 $1.  @10 V10 $1.
      @11 V11 $1.  @12 V12 $1.  @13 V13 1.  @14 V14 1.  @15 V15 1.
      @16 V16 $1. @17 V17 $1. @18 V18 $1. @19 V19 $1. @20 V20 $1.;
run;

data _null_;
infile rawdata;
input @1 V1 1.  @2 V2 1.  @3 V3 1.  @4 V4 1.  @5 V5 1.
      @6 V6 $1.  @7 V7 $1.  @8 V8 $1.  @9 V9 $1.  @10 V10 $1.
      @11 V11 $1.  @12 V12 $1.  @13 V13 1.  @14 V14 1.  @15 V15 1.
      @16 V16 $1. @17 V17 $1. @18 V18 $1. @19 V19 $1. @20 V20 $1.;
run;

data _null_;
infile rawdata;
input @1 V1 1.  @2 V2 1.  @3 V3 1.  @4 V4 1.  @5 V5 1.
      @6 V6 $1.  @7 V7 $1.  @8 V8 $1.  @9 V9 $1.  @10 V10 $1.
      @11 V11 $1.  @12 V12 $1.  @13 V13 1.  @14 V14 1.  @15 V15 1.
      @16 V16 $1. @17 V17 $1. @18 V18 $1. @19 V19 $1. @20 V20 $1.;
run;

data _null_;
infile rawdata;
input  V1 1.   V2 1.   V3 1.   V4 1.   V5 1.
       V6 $1.  V7 $1.  V8 $1.  V9 $1.  V10 $1.
       V11 $1.  V12 $1.  V13 1.  V14 1.  V15 1.
       V16 $1. V17 $1. V18 $1. V19 $1. V20 $1.;
run;

data _null_;
infile rawdata;
input  V1 1.   V2 1.   V3 1.   V4 1.   V5 1.
       V6 $1.  V7 $1.  V8 $1.  V9 $1.  V10 $1.
       V11 $1.  V12 $1.  V13 1.  V14 1.  V15 1.
       V16 $1. V17 $1. V18 $1. V19 $1. V20 $1.;
run;

data _null_;
infile rawdata;
input  V1 1.   V2 1.   V3 1.   V4 1.   V5 1.
       V6 $1.  V7 $1.  V8 $1.  V9 $1.  V10 $1.
       V11 $1.  V12 $1.  V13 1.  V14 1.  V15 1.
       V16 $1. V17 $1. V18 $1. V19 $1. V20 $1.;
run;


**********************************************************
**  TEST #2D:  INFORMATS replace data manipulation      **
**********************************************************;

data _null_;
infile rawdata;
input @14 SASDATE YYMMDD6.;
run;

data _null_;
infile rawdata;
input @14 SASDATE YYMMDD6.;
run;

data _null_;
infile rawdata;
input @14 SASDATE YYMMDD6.;
run;

data _null_;
infile rawdata;
input @14 CHARDATE $CHAR6.;
SASDATE = INPUT(CHARDATE,YYMMDD6.);
run;

data _null_;
infile rawdata;
input @14 CHARDATE $CHAR6.;
SASDATE = INPUT(CHARDATE,YYMMDD6.);
run;

data _null_;
infile rawdata;
input @14 CHARDATE $CHAR6.;
SASDATE = INPUT(CHARDATE,YYMMDD6.);
run;


**********************************************************
**  TEST #2E:  USER-DEFINED INFORMAT                    **
**********************************************************;

proc format;
invalue $gender 'MALE'=1 'FEMALE'=2;

data _null_;
infile rawdata;
input @7 TYPE $GENDER6.;
run;

data _null_;
infile rawdata;
input @7 TYPE $GENDER6.;
run;

data _null_;
infile rawdata;
input @7 TYPE $GENDER6.;
run;

data _null_;
infile rawdata;
input @7 gender $char6.;
if gender='MALE' then type=1;
else type=2;
run;

data _null_;
infile rawdata;
input @7 gender $char6.;
if gender='MALE' then type=1;
else type=2;
run;

data _null_;
infile rawdata;
input @7 gender $char6.;
if gender='MALE' then type=1;
else type=2;
run;


**********************************************************
**  TEST #2F:  Read needed variables                    **
**********************************************************;

proc sort data=_030vars out=temp;
by var1;
run;

proc sort data=_030vars out=temp;
by var1;
run;

proc sort data=_030vars out=temp;
by var1;
run;

proc sort data=_030vars out=temp (keep=var1-var3);
by var1;
run;

proc sort data=_030vars out=temp (keep=var1-var3);
by var1;
run;

proc sort data=_030vars out=temp (keep=var1-var3);
by var1;
run;

proc sort data=_030vars out=temp (keep=var1-var3);
by var1;
run;

proc sort data=_030vars (keep=var1-var3) out=temp;
by var1;
run;

proc sort data=_030vars (keep=var1-var3) out=temp;
by var1;
run;

proc sort data=_030vars (keep=var1-var3) out=temp;
by var1;
run;

proc sort data=_030vars (keep=var1-var3) out=temp;
by var1;
run;

proc means data=_030vars (keep=var1 var3);
var var1 var3;
run;

proc means data=_030vars (keep=var1 var3);
var var1 var3;
run;

proc means data=_030vars (keep=var1 var3);
var var1 var3;
run;

proc means data=_030vars;
var var1 var3;
run;

proc means data=_030vars;
var var1 var3;
run;

proc means data=_030vars;
var var1 var3;
run;

proc means data=temp;
var var1 var3;
run;

proc means data=temp;
var var1 var3;
run;

proc means data=temp;
var var1 var3;
run;


**********************************************************
**  TEST #2G:  Subsetting IF vs. DELETE vs. WHERE       **
**********************************************************;

**********************************************************
**  First set of tests on 30 variables                  **
**********************************************************;

**********************************************************
**  Selecting a 20% sample.                             **
**********************************************************;

data _null_;
call symput('LIMIT', put(&loopsize/5*.8    , 8.));
call symput('PLUS1', put(&loopsize/5*.8 + 1, 8.));
run;

data _null_;
set _030vars;
if var1 >  &LIMIT;
run;

data _null_;
set _030vars;
if var1 >  &LIMIT;
run;

data _null_;
set _030vars;
if var1 >  &LIMIT;
run;

data _null_;
set _030vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _030vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _030vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _030vars;
where var1 >  &LIMIT;
run;

data _null_;
set _030vars;
where var1 >  &LIMIT;
run;

data _null_;
set _030vars;
where var1 >  &LIMIT;
run;

**********************************************************
**  Selecting a 30% sample.                             **
**********************************************************;

data _null_;
call symput('LIMIT', put(&loopsize/5*.7    , 8.));
call symput('PLUS1', put(&loopsize/5*.7 + 1, 8.));
run;

data _null_;
set _030vars;
if var1 >  &LIMIT;
run;

data _null_;
set _030vars;
if var1 >  &LIMIT;
run;

data _null_;
set _030vars;
if var1 >  &LIMIT;
run;

data _null_;
set _030vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _030vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _030vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _030vars;
where var1 >  &LIMIT;
run;

data _null_;
set _030vars;
where var1 >  &LIMIT;
run;

data _null_;
set _030vars;
where var1 >  &LIMIT;
run;

**********************************************************
**  Selecting a 50% sample.                             **
**********************************************************;

data _null_;
call symput('LIMIT', put(&loopsize/5*.5    , 8.));
call symput('PLUS1', put(&loopsize/5*.5 + 1, 8.));
run;

data _null_;
set _030vars;
if var1 >  &LIMIT;
run;

data _null_;
set _030vars;
if var1 >  &LIMIT;
run;

data _null_;
set _030vars;
if var1 >  &LIMIT;
run;

data _null_;
set _030vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _030vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _030vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _030vars;
where var1 >  &LIMIT;
run;

data _null_;
set _030vars;
where var1 >  &LIMIT;
run;

data _null_;
set _030vars;
where var1 >  &LIMIT;
run;

**********************************************************
**  Selecting an 80% sample.                            **
**********************************************************;

data _null_;
call symput('LIMIT', put(&loopsize/5*.2    , 8.));
call symput('PLUS1', put(&loopsize/5*.2 + 1, 8.));
run;

data _null_;
set _030vars;
if var1 >  &LIMIT;
run;

data _null_;
set _030vars;
if var1 >  &LIMIT;
run;

data _null_;
set _030vars;
if var1 >  &LIMIT;
run;

data _null_;
set _030vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _030vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _030vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _030vars;
where var1 >  &LIMIT;
run;

data _null_;
set _030vars;
where var1 >  &LIMIT;
run;

data _null_;
set _030vars;
where var1 >  &LIMIT;
run;

**********************************************************
**  100 variables                                       **
**********************************************************;

**********************************************************
**  Selecting a 20% sample.                             **
**********************************************************;

data _null_;
call symput('LIMIT', put(&loopsize/5*.8    , 8.));
call symput('PLUS1', put(&loopsize/5*.8 + 1, 8.));
run;

data _null_;
set _100vars;
if var1 >  &LIMIT;
run;

data _null_;
set _100vars;
if var1 >  &LIMIT;
run;

data _null_;
set _100vars;
if var1 >  &LIMIT;
run;

data _null_;
set _100vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _100vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _100vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _100vars;
where var1 >  &LIMIT;
run;

data _null_;
set _100vars;
where var1 >  &LIMIT;
run;

data _null_;
set _100vars;
where var1 >  &LIMIT;
run;

**********************************************************
**  Selecting a 30% sample.                             **
**********************************************************;

data _null_;
call symput('LIMIT', put(&loopsize/5*.7    , 8.));
call symput('PLUS1', put(&loopsize/5*.7 + 1, 8.));
run;

data _null_;
set _100vars;
if var1 >  &LIMIT;
run;

data _null_;
set _100vars;
if var1 >  &LIMIT;
run;

data _null_;
set _100vars;
if var1 >  &LIMIT;
run;

data _null_;
set _100vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _100vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _100vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _100vars;
where var1 >  &LIMIT;
run;

data _null_;
set _100vars;
where var1 >  &LIMIT;
run;

data _null_;
set _100vars;
where var1 >  &LIMIT;
run;

**********************************************************
**  Selecting a 50% sample.                             **
**********************************************************;

data _null_;
call symput('LIMIT', put(&loopsize/5*.5    , 8.));
call symput('PLUS1', put(&loopsize/5*.5 + 1, 8.));
run;

data _null_;
set _100vars;
if var1 >  &LIMIT;
run;

data _null_;
set _100vars;
if var1 >  &LIMIT;
run;

data _null_;
set _100vars;
if var1 >  &LIMIT;
run;

data _null_;
set _100vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _100vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _100vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _100vars;
where var1 >  &LIMIT;
run;

data _null_;
set _100vars;
where var1 >  &LIMIT;
run;

data _null_;
set _100vars;
where var1 >  &LIMIT;
run;

**********************************************************
**  Selecting an 80% sample.                            **
**********************************************************;

data _null_;
call symput('LIMIT', put(&loopsize/5*.2    , 8.));
call symput('PLUS1', put(&loopsize/5*.2 + 1, 8.));
run;

data _null_;
set _100vars;
if var1 >  &LIMIT;
run;

data _null_;
set _100vars;
if var1 >  &LIMIT;
run;

data _null_;
set _100vars;
if var1 >  &LIMIT;
run;

data _null_;
set _100vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _100vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _100vars;
if var1 <  &PLUS1 then delete;
run;

data _null_;
set _100vars;
where var1 >  &LIMIT;
run;

data _null_;
set _100vars;
where var1 >  &LIMIT;
run;

data _null_;
set _100vars;
where var1 >  &LIMIT;
run;


**********************************************************
**  TEST #2H:  Beating the Supervisor                   **
**********************************************************;

data _null_;
set _100vars;
run;

data _null_;
set _100vars;
run;

data _null_;
set _100vars;
run;

data _null_;
do until (nomore);
   set _100vars end=nomore;
end;
run;

data _null_;
do until (nomore);
   set _100vars end=nomore;
end;
run;

data _null_;
do until (nomore);
   set _100vars end=nomore;
end;
run;

data _null_;
infile rawdata;
input (var1-var20) ($1.);
run;

data _null_;
infile rawdata;
input (var1-var20) ($1.);
run;

data _null_;
infile rawdata;
input (var1-var20) ($1.);
run;

data _null_;
infile rawdata;
input (var1-var20) ($1.);
retain var1-var20;
run;

data _null_;
infile rawdata;
input (var1-var20) ($1.);
retain var1-var20;
run;

data _null_;
infile rawdata;
input (var1-var20) ($1.);
retain var1-var20;
run;

data _null_;
infile rawdata end=nomore;
do until (nomore);
   input (var1-var20) ($1.);
end;
run;

data _null_;
infile rawdata end=nomore;
do until (nomore);
   input (var1-var20) ($1.);
end;
run;

data _null_;
infile rawdata end=nomore;
do until (nomore);
   input (var1-var20) ($1.);
end;
run;


**********************************************************
**                                                      **
**  Program   :  Chapter3.SAS                           **
**                                                      **
**  Purpose   :  Tests of Efficiency for                **
**               Chapter 3 - Reporting                  **
**                                                      **
**  Written by:  Bob Virgile                            **
**                                                      **
**  Date      :  12/1/97                                **
**                                                      **
**********************************************************
**                                                      **
**  This program concatenates all test runs related     **
**  to efficiency in reporting.                         **
**                                                      **
**********************************************************;


**********************************************************
**  TEST #3A:  Specify Formats                          **
**********************************************************;

data _null_;
call symput('LIMIT', put(&loopsize/100, 8.));
run;

proc print data=_100vars (obs=&LIMIT);
var var:;
run;

proc print data=_100vars (obs=&LIMIT);
var var:;
run;

proc print data=_100vars (obs=&LIMIT);
var var:;
run;

proc print data=_100vars (obs=&LIMIT);
var var:;
format _numeric_ 2. _character_ $8. var1 7.;
run;

proc print data=_100vars (obs=&LIMIT);
var var:;
format _numeric_ 2. _character_ $8. var1 7.;
run;

proc print data=_100vars (obs=&LIMIT);
var var:;
format _numeric_ 2. _character_ $8. var1 7.;
run;


**********************************************************
**  TEST #3B:  DATA _NULL_                              **
**********************************************************;

data _null_;
set _100vars;
run;

data _null_;
set _100vars;
run;

data _null_;
set _100vars;
run;

data temp;
set _100vars;
run;

data temp;
set _100vars;
run;

data temp;
set _100vars;
run;


**********************************************************
**  TEST #3C:  PUT _INFILE_                             **
**********************************************************;

data _null_;
infile rawdata;
input string $char20.;
file print notitles;
put @1 string $char20. @;
run;

data _null_;
infile rawdata;
input string $char20.;
file print notitles;
put @1 string $char20. @;
run;

data _null_;
infile rawdata;
input string $char20.;
file print notitles;
put @1 string $char20. @;
run;

data _null_;
infile rawdata;
input string $char20.;
file print notitles;
put @1 _infile_ @;
run;

data _null_;
infile rawdata;
input string $char20.;
file print notitles;
put @1 _infile_ @;
run;

data _null_;
infile rawdata;
input string $char20.;
file print notitles;
put @1 _infile_ @;
run;

data _null_;
infile rawdata;
input (s1-s4) ($char5.);
file print notitles;
put @1 s1 $char5. s2 $char5. s3 $char5. s4 $char5. @;
run;

data _null_;
infile rawdata;
input (s1-s4) ($char5.);
file print notitles;
put @1 s1 $char5. s2 $char5. s3 $char5. s4 $char5. @;
run;

data _null_;
infile rawdata;
input (s1-s4) ($char5.);
file print notitles;
put @1 s1 $char5. s2 $char5. s3 $char5. s4 $char5. @;
run;

data _null_;
infile rawdata;
input (s1-s4) ($char5.);
file print notitles;
put @1 _infile_ @;
run;

data _null_;
infile rawdata;
input (s1-s4) ($char5.);
file print notitles;
put @1 _infile_ @;
run;

data _null_;
infile rawdata;
input (s1-s4) ($char5.);
file print notitles;
put @1 _infile_ @;
run;


**********************************************************
**  TEST #3D:  Summarize before PROC TABULATE           **
**********************************************************;

proc tabulate data=_100vars;
class var100;
var var1;
tables var100, var1*(mean min max) / rts=15;
run;

proc tabulate data=_100vars;
class var100;
var var1;
tables var100, var1*(mean min max) / rts=15;
run;

proc tabulate data=_100vars;
class var100;
var var1;
tables var100, var1*(mean min max) / rts=15;
run;

proc means data=_100vars noprint nway;
class var100;
var var1;
output out=temp mean=mean min=min max=max;
run;

proc means data=_100vars noprint nway;
class var100;
var var1;
output out=temp mean=mean min=min max=max;
run;

proc means data=_100vars noprint nway;
class var100;
var var1;
output out=temp mean=mean min=min max=max;
run;

proc tabulate data=temp;
class var100;
var mean min max;
tables var100, sum='VAR1'*(mean min max) / rts=15;
run;

proc tabulate data=temp;
class var100;
var mean min max;
tables var100, sum='VAR1'*(mean min max) / rts=15;
run;

proc tabulate data=temp;
class var100;
var mean min max;
tables var100, sum='VAR1'*(mean min max) / rts=15;
run;

**********************************************************
**                                                      **
**  Program   :  Chapter4.SAS                           **
**                                                      **
**  Purpose   :  Tests of Efficiency for                **
**               Chapter 4 - File Handling              **
**                                                      **
**  Written by:  Bob Virgile                            **
**                                                      **
**  Date      :  12/1/97                                **
**                                                      **
**********************************************************
**                                                      **
**  This program concatenates all test runs related     **
**  to efficiency in file handling.                     **
**                                                      **
**********************************************************;


**********************************************************
**  TEST #4A:  Sorting by unnecessary variables         **
**********************************************************;

proc sort data=_030vars out=temp;
by var1;
run;

proc sort data=_030vars out=temp;
by var1;
run;

proc sort data=_030vars out=temp;
by var1;
run;

proc sort data=_030vars out=temp;
by var1 var3;
run;

proc sort data=_030vars out=temp;
by var1 var3;
run;

proc sort data=_030vars out=temp;
by var1 var3;
run;


**********************************************************
**  TEST #4B:  PROC SQL vs. DATA Step, 6 variations     **
**********************************************************;

**********************************************************
**  Variation #1:  Read all variables                   **
**********************************************************;

proc sql;
create table temp as select * from _100vars;

data temp;
set _100vars;
run;

proc sql;
create table temp as select * from _100vars;

data temp;
set _100vars;
run;

proc sql;
create table temp as select * from _100vars;

data temp;
set _100vars;
run;

**********************************************************
**  Variation #2:  Subset variables                     **
**********************************************************;

proc sql;
create table temp as select var1, var2a, var3a from _100vars;

data temp;
set _100vars (keep=var1 var2a var3a);
run;

proc sql;
create table temp as select var1, var2a, var3a from _100vars;

data temp;
set _100vars (keep=var1 var2a var3a);
run;

proc sql;
create table temp as select var1, var2a, var3a from _100vars;

data temp;
set _100vars (keep=var1 var2a var3a);
run;

**********************************************************
**  Variation #3:  Subset observations                  **
**********************************************************;

proc sql;
create table temp as select * from _100vars where var100='NewValue';

data temp;
set _100vars;
where var100='NewValue';
run;

proc sql;
create table temp as select * from _100vars where var100='NewValue';

data temp;
set _100vars;
where var100='NewValue';
run;

proc sql;
create table temp as select * from _100vars where var100='NewValue';

data temp;
set _100vars;
where var100='NewValue';
run;


**********************************************************
**  Variation #4:  FULL JOIN vs. MERGE                  **
**********************************************************;

**********************************************************
**  Variation #5:  LEFT JOIN vs. MERGE with IN=         **
**********************************************************;

**********************************************************
**  Variation #6:  RIGHT JOIN vs. MERGE with IN=        **
**********************************************************;


**********************************************************
**  All variations must test processing unsorted data   **
**  first, sorted data afterward.                       **
**********************************************************;

**********************************************************
**  Variation #4a:  SQL FULL JOIN on unsorted data      **
**********************************************************;

proc sql;
create table temp as select * from
_030vars full join _100vars on _030vars.var1=_100vars.var1;

proc sql;
create table temp as select * from
_030vars full join _100vars on _030vars.var1=_100vars.var1;

proc sql;
create table temp as select * from
_030vars full join _100vars on _030vars.var1=_100vars.var1;


**********************************************************
**  Variation #5a:  SQL LEFT JOIN on unsorted data      **
**********************************************************;

proc sql;
create table temp as select * from
_030vars left join _100vars on _030vars.var1=_100vars.var1;

proc sql;
create table temp as select * from
_030vars left join _100vars on _030vars.var1=_100vars.var1;

proc sql;
create table temp as select * from
_030vars left join _100vars on _030vars.var1=_100vars.var1;


**********************************************************
**  Variation #6a:  SQL RIGHT JOIN on unsorted data     **
**********************************************************;

proc sql;
create table temp as select * from
_030vars right join _100vars on _030vars.var1=_100vars.var1;

proc sql;
create table temp as select * from
_030vars right join _100vars on _030vars.var1=_100vars.var1;

proc sql;
create table temp as select * from
_030vars right join _100vars on _030vars.var1=_100vars.var1;


**********************************************************
**  Sort both data sets in preparation for further      **
**  testing:  4b, 5b, and 6b.                           **
**********************************************************;

proc sort data=_030vars out=_030_;
by var1;
run;

proc sort data=_100vars out=_100_;
by var1;


**********************************************************
**  Variation #4b:  FULL JOIN vs. MERGE                 **
**********************************************************;

proc sql;
create table temp as select * from
_030_ full join _100_ on _030_.var1=_100_.var1;

proc sql;
create table temp as select * from
_030_ full join _100_ on _030_.var1=_100_.var1;

proc sql;
create table temp as select * from
_030_ full join _100_ on _030_.var1=_100_.var1;

data temp;
merge _030_ _100_;
by var1;
run;

data temp;
merge _030_ _100_;
by var1;
run;

data temp;
merge _030_ _100_;
by var1;
run;


**********************************************************
**  Variation #5b:  LEFT JOIN vs. MERGE with IN=        **
**********************************************************;

proc sql;
create table temp as select * from
_030_ left join _100_ on _030_.var1=_100_.var1;

proc sql;
create table temp as select * from
_030_ left join _100_ on _030_.var1=_100_.var1;

proc sql;
create table temp as select * from
_030_ left join _100_ on _030_.var1=_100_.var1;

data temp;
merge _030_ (in=INA) _100_;
by var1;
if ina;
run;

data temp;
merge _030_ (in=INA) _100_;
by var1;
if ina;
run;

data temp;
merge _030_ (in=INA) _100_;
by var1;
if ina;
run;


**********************************************************
**  Variation #6b:  RIGHT JOIN vs. MERGE with IN=       **
**********************************************************;

proc sql;
create table temp as select * from
_030_ right join _100_ on _030_.var1=_100_.var1;

proc sql;
create table temp as select * from
_030_ right join _100_ on _030_.var1=_100_.var1;

proc sql;
create table temp as select * from
_030_ right join _100_ on _030_.var1=_100_.var1;

data temp;
merge _030_  _100_ (in=INB);
by var1;
if inb;
run;

data temp;
merge _030_  _100_ (in=INB);
by var1;
if inb;
run;

data temp;
merge _030_  _100_ (in=INB);
by var1;
if inb;
run;


**********************************************************
**                                                      **
**  Program   :  Chapter5.SAS                           **
**                                                      **
**  Purpose   :  Tests of Efficiency for                **
**               Chapter 5 - Sorting Data               **
**                                                      **
**  Written by:  Bob Virgile                            **
**                                                      **
**  Date      :  12/1/97                                **
**                                                      **
**********************************************************
**                                                      **
**  This program concatenates all test runs related     **
**  to efficiency in sorting data.                      **
**                                                      **
**********************************************************;


**********************************************************
**  TEST #5A:  Summarizing with CLASS to avoid SORTing  **
**********************************************************;

proc means data=_100vars nway;
class var100;
var _numeric_;
run;

proc means data=_100vars nway;
class var100;
var _numeric_;
run;

proc means data=_100vars nway;
class var100;
var _numeric_;
run;

proc sort data=_100vars out=temp;
by var100;
run;

proc sort data=_100vars out=temp;
by var100;
run;

proc sort data=_100vars out=temp;
by var100;
run;

proc means data=temp;
by var100;
var _numeric_;
run;

proc means data=temp;
by var100;
var _numeric_;
run;

proc means data=temp;
by var100;
var _numeric_;
run;


**********************************************************
**  TEST #5B:  Summarizing with CLASS to avoid SORTing  **
**********************************************************;
**  Use baseline measurements from Test 5A above.       **
**********************************************************;

proc sort data=_100vars out=temp sortsize=max;
by var100;
run;

proc sort data=_100vars out=temp sortsize=max;
by var100;
run;

proc sort data=_100vars out=temp sortsize=max;
by var100;
run;


**********************************************************
**  TEST #5C:  NOEQUALS                                 **
**********************************************************;
**  Use baseline measurements from Test 5A above.       **
**********************************************************;

proc sort data=_100vars out=temp noequals;
by var100;
run;

proc sort data=_100vars out=temp noequals;
by var100;
run;

proc sort data=_100vars out=temp noequals;
by var100;
run;


**********************************************************
**  TEST #5D:  Sorting Routine = SAS                    **
**********************************************************;
**  Use baseline measurements from Test 5A above.       **
**********************************************************;

options sortpgm=sas;

proc sort data=_100vars out=temp;
by var100;
run;

proc sort data=_100vars out=temp;
by var100;
run;

proc sort data=_100vars out=temp;
by var100;
run;

options sortpgm=best;


**********************************************************
**  TEST #5E:  TAGSORT vs. user-written work-around     **
**********************************************************;

proc sort data=_100vars out=temp TAGSORT;
by var100;
run;

proc sort data=_100vars out=temp TAGSORT;
by var100;
run;

proc sort data=_100vars out=temp TAGSORT;
by var100;
run;

data justkeys;
set _100vars (keep=var100);
obsno=_n_;
run;

proc sort data=justkeys;
by obsno;
run;

data temp;
set justkeys (keep=obsno);
set _100vars point=obsno;
run;

data justkeys;
set _100vars (keep=var100);
obsno=_n_;
run;

proc sort data=justkeys;
by obsno;
run;

data temp;
set justkeys (keep=obsno);
set _100vars point=obsno;
run;

data justkeys;
set _100vars (keep=var100);
obsno=_n_;
run;

proc sort data=justkeys;
by obsno;
run;

data temp;
set justkeys (keep=obsno);
set _100vars point=obsno;
run;

**********************************************************
**                                                      **
**  Program   :  Chapter6.SAS                           **
**                                                      **
**  Purpose   :  Tests of Efficiency for                **
**               Chapter 6 - Summarizing Data           **
**                                                      **
**  Written by:  Bob Virgile                            **
**                                                      **
**  Date      :  12/1/97                                **
**                                                      **
**********************************************************
**                                                      **
**  This program concatenates all test runs related     **
**  to efficiency in summarizing data.                  **
**                                                      **
**  One related test (also related to sorting) appears  **
**  in Chapter5.SAS.                                    **
**                                                      **
**********************************************************;


**********************************************************
**  TEST #6A:  PROC MEANS vs. PROC SUMMARY              **
**********************************************************;

proc means data=_100vars;
var _numeric_;
run;

proc means data=_100vars;
var _numeric_;
run;

proc means data=_100vars;
var _numeric_;
run;

proc summary data=_100vars print;
var _numeric_;
run;

proc summary data=_100vars print;
var _numeric_;
run;

proc summary data=_100vars print;
var _numeric_;
run;


**********************************************************
**  TEST #6B:  PROC MEANS vs. PROC SQL vs. DATA step    **
**********************************************************;

**********************************************************
**  Variation #1:  Basic statistics                     **
**********************************************************;

proc means data=_030vars SUM N;
var var1;
run;

proc means data=_030vars SUM N;
var var1;
run;

proc means data=_030vars SUM N;
var var1;
run;

proc sql;
select sum(var1) as sum, n(var1) as n from _030vars;

proc sql;
select sum(var1) as sum, n(var1) as n from _030vars;

proc sql;
select sum(var1) as sum, n(var1) as n from _030vars;

data _null_;
set _030vars (keep=var1) end=eof;
sum + var1;
if var1 > .Z then n + 1;
if eof;
file print;
put sum= n=;
run;

data _null_;
set _030vars (keep=var1) end=eof;
sum + var1;
if var1 > .Z then n + 1;
if eof;
file print;
put sum= n=;
run;

data _null_;
set _030vars (keep=var1) end=eof;
sum + var1;
if var1 > .Z then n + 1;
if eof;
file print;
put sum= n=;
run;


**********************************************************
**  Variation #2:  Basic statistics for subgroups       **
**********************************************************;

data temp;
set _100vars (keep=var1 var100);
run;

proc means data=temp SUM N;
var var1;
class var100;
run;

proc means data=temp SUM N;
var var1;
class var100;
run;

proc means data=temp SUM N;
var var1;
class var100;
run;

proc sql;
select sum(var1) as sum, n(var1) as n from temp
group by var100;

proc sql;
select sum(var1) as sum, n(var1) as n from temp
group by var100;

proc sql;
select sum(var1) as sum, n(var1) as n from temp
group by var100;

proc sort data=temp out=temp2;
by var100;
run;

proc sort data=temp out=temp2;
by var100;
run;

proc sort data=temp out=temp2;
by var100;
run;

data _null_;
set temp2;
by var100;
sum + var1;
if var1 > .Z then n + 1;
if last.var100;
file print;
put var100= sum= n=;
sum=0;
n=0;
run;

data _null_;
set temp2;
by var100;
sum + var1;
if var1 > .Z then n + 1;
if last.var100;
file print;
put var100= sum= n=;
sum=0;
n=0;
run;

data _null_;
set temp2;
by var100;
sum + var1;
if var1 > .Z then n + 1;
if last.var100;
file print;
put var100= sum= n=;
sum=0;
n=0;
run;

proc sql;
select sum(var1) as sum, n(var1) as n from temp2
group by var100;

proc sql;
select sum(var1) as sum, n(var1) as n from temp2
group by var100;

proc sql;
select sum(var1) as sum, n(var1) as n from temp2
group by var100;

proc means data=temp2 SUM N;
var var1;
by var100;
run;

proc means data=temp2 SUM N;
var var1;
by var100;
run;

proc means data=temp2 SUM N;
var var1;
by var100;
run;

 **********************************************************
**                                                      **
**  Program   :  Chapter7.SAS                           **
**                                                      **
**  Purpose   :  Tests of Efficiency for                **
**               Chapter 7 - Data Manipulation          **
**                                                      **
**  Written by:  Bob Virgile                            **
**                                                      **
**  Date      :  12/1/97                                **
**                                                      **
**********************************************************
**                                                      **
**  This program concatenates all test runs related     **
**  to efficiency in manipulating data.                 **
**                                                      **
**  Because many data manipulation items run quickly    **
**  (compared to reading in an observation), most of    **
**  these tests run in DO loops instead of reading in   **
**  a data set.                                         **
**                                                      **
**********************************************************;


**********************************************************
**  TEST #7A:  Eliminating SUBSTR                       **
**********************************************************;

data _null_;
original='Original String';
length first3 $ 3;
do i=1 to &loopsize;
end;
run;

data _null_;
original='Original String';
length first3 $ 3;
do i=1 to &loopsize;
end;
run;

data _null_;
original='Original String';
length first3 $ 3;
do i=1 to &loopsize;
end;
run;

data _null_;
original='Original String';
length first3 $ 3;
do i=1 to &loopsize;
   first3=original;
end;
run;

data _null_;
original='Original String';
length first3 $ 3;
do i=1 to &loopsize;
   first3=original;
end;
run;

data _null_;
original='Original String';
length first3 $ 3;
do i=1 to &loopsize;
   first3=original;
end;
run;

data _null_;
original='Original String';
length first3 $ 3;
do i=1 to &loopsize;
   first3=substr(original,1,3);
end;
run;

data _null_;
original='Original String';
length first3 $ 3;
do i=1 to &loopsize;
   first3=substr(original,1,3);
end;
run;

data _null_;
original='Original String';
length first3 $ 3;
do i=1 to &loopsize;
   first3=substr(original,1,3);
end;
run;


**********************************************************
**  TEST #7B:  Eliminating SUBSTR in comparisons        **
**********************************************************;

data _null_;
original='Original String';
do i=1 to &loopsize;
end;
run;

data _null_;
original='Original String';
do i=1 to &loopsize;
end;
run;

data _null_;
original='Original String';
do i=1 to &loopsize;
end;
run;

data _null_;
original='Original String';
do i=1 to &loopsize;
   if substr(original,1,8)='Software' then x=5;
end;
run;

data _null_;
original='Original String';
do i=1 to &loopsize;
   if substr(original,1,8)='Software' then x=5;
end;
run;

data _null_;
original='Original String';
do i=1 to &loopsize;
   if substr(original,1,8)='Software' then x=5;
end;
run;

data _null_;
original='Original String';
do i=1 to &loopsize;
   if original=:'Software' then x=5;
end;
run;

data _null_;
original='Original String';
do i=1 to &loopsize;
   if original=:'Software' then x=5;
end;
run;

data _null_;
original='Original String';
do i=1 to &loopsize;
   if original=:'Software' then x=5;
end;
run;


**********************************************************
**  TEST #7C:  Getting the Current Date                 **
**********************************************************;

data _null_;
infile rawdata;
input;
date=today();
run;

data _null_;
infile rawdata;
input;
date=today();
run;

data _null_;
infile rawdata;
input;
date=today();
run;

data _null_;
infile rawdata;
input;
if _n_=1 then date=today();
retain date;
run;

data _null_;
infile rawdata;
input;
if _n_=1 then date=today();
retain date;
run;

data _null_;
infile rawdata;
input;
if _n_=1 then date=today();
retain date;
run;

data _null_;
infile rawdata;
input;
retain date "&SYSDATE"D;
run;

data _null_;
infile rawdata;
input;
retain date "&SYSDATE"D;
run;

data _null_;
infile rawdata;
input;
retain date "&SYSDATE"D;
run;


**********************************************************
**  TEST #7D:  Eliminating the LAG function             **
**********************************************************;

data _null_;
set _030vars (keep=var1);
run;

data _null_;
set _030vars (keep=var1);
run;

data _null_;
set _030vars (keep=var1);
run;

data _null_;
set _030vars (keep=var1);
newvar=lag(var1);
run;

data _null_;
set _030vars (keep=var1);
newvar=lag(var1);
run;

data _null_;
set _030vars (keep=var1);
newvar=lag(var1);
run;

data _null_;
set _030vars (keep=var1);
output;
newvar=var1;
retain newvar;
run;

data _null_;
set _030vars (keep=var1);
output;
newvar=var1;
retain newvar;
run;

data _null_;
set _030vars (keep=var1);
output;
newvar=var1;
retain newvar;
run;


**********************************************************
**  TEST #7E:  Numeric to character conversion          **
**********************************************************;

data _null_;
value=125;
length c $ 3;
do i=1 to &loopsize;
end;
run;

data _null_;
value=125;
length c $ 3;
do i=1 to &loopsize;
end;
run;

data _null_;
value=125;
length c $ 3;
do i=1 to &loopsize;
end;
run;

data _null_;
value=125;
length c $ 3;
do i=1 to &loopsize;
   c=value;
end;
run;

data _null_;
value=125;
length c $ 3;
do i=1 to &loopsize;
   c=value;
end;
run;

data _null_;
value=125;
length c $ 3;
do i=1 to &loopsize;
   c=value;
end;
run;

data _null_;
value=125;
length c $ 3;
do i=1 to &loopsize;
   c=put(value,3.);
end;
run;

data _null_;
value=125;
length c $ 3;
do i=1 to &loopsize;
   c=put(value,3.);
end;
run;

data _null_;
value=125;
length c $ 3;
do i=1 to &loopsize;
   c=put(value,3.);
end;
run;


**********************************************************
**  TEST #7F:  Order of Nested DO Loops                 **
**********************************************************;

data _null_;
do i=1 to &loopsize/10;
end;
run;

data _null_;
do i=1 to &loopsize/10;
end;
run;

data _null_;
do i=1 to &loopsize/10;
end;
run;

data _null_;
do i=1 to &loopsize/10;
   do customer=1 to 100;
      do price=5 to 25 by 5;
         do quantity=1 to 3;
            totcost=price*quantity;
         end;
      end;
   end;
end;
run;

data _null_;
do i=1 to &loopsize/10;
   do customer=1 to 100;
      do price=5 to 25 by 5;
         do quantity=1 to 3;
            totcost=price*quantity;
         end;
      end;
   end;
end;
run;

data _null_;
do i=1 to &loopsize/10;
   do customer=1 to 100;
      do price=5 to 25 by 5;
         do quantity=1 to 3;
            totcost=price*quantity;
         end;
      end;
   end;
end;
run;

data _null_;
do i=1 to &loopsize/10;
   do quantity=1 to 3;
      do price=5 to 25 by 5;
         do customer=1 to 100;
            totcost=price*quantity;
         end;
      end;
   end;
end;
run;

data _null_;
do i=1 to &loopsize/10;
   do quantity=1 to 3;
      do price=5 to 25 by 5;
         do customer=1 to 100;
            totcost=price*quantity;
         end;
      end;
   end;
end;
run;

data _null_;
do i=1 to &loopsize/10;
   do quantity=1 to 3;
      do price=5 to 25 by 5;
         do customer=1 to 100;
            totcost=price*quantity;
         end;
      end;
   end;
end;
run;

data _null_;
do i=1 to &loopsize/10;
   do quantity=1 to 3;
      do price=5 to 25 by 5;
         totcost=price*quantity;
         do customer=1 to 100;
         end;
      end;
   end;
end;
run;

data _null_;
do i=1 to &loopsize/10;
   do quantity=1 to 3;
      do price=5 to 25 by 5;
         totcost=price*quantity;
         do customer=1 to 100;
         end;
      end;
   end;
end;
run;

data _null_;
do i=1 to &loopsize/10;
   do quantity=1 to 3;
      do price=5 to 25 by 5;
         totcost=price*quantity;
         do customer=1 to 100;
         end;
      end;
   end;
end;
run;


**********************************************************
**  TEST #7G:  Test for Division by Zero                **
**********************************************************;

data _null_;
denom=0;
numer=1;
do i=1 to &loopsize;
end;
run;

data _null_;
denom=0;
numer=1;
do i=1 to &loopsize;
end;
run;

data _null_;
denom=0;
numer=1;
do i=1 to &loopsize;
end;
run;

data _null_;
denom=0;
numer=1;
do i=1 to &loopsize;
   quotient = numer/denom;
end;
run;

data _null_;
denom=0;
numer=1;
do i=1 to &loopsize;
   quotient = numer/denom;
end;
run;

data _null_;
denom=0;
numer=1;
do i=1 to &loopsize;
   quotient = numer/denom;
end;
run;

data _null_;
denom=0;
numer=1;
do i=1 to &loopsize;
   if denom then quotient = numer/denom;
end;
run;

data _null_;
denom=0;
numer=1;
do i=1 to &loopsize;
   if denom then quotient = numer/denom;
end;
run;

data _null_;
denom=0;
numer=1;
do i=1 to &loopsize;
   if denom then quotient = numer/denom;
end;
run;


**********************************************************
**  TEST #7H:  Test for Missing Values                  **
**********************************************************;

data _null_;
missing=.;
a=1;
b=1;
c=1;
d=1;
do i=1 to &loopsize;
end;
run;

data _null_;
missing=.;
a=1;
b=1;
c=1;
d=1;
do i=1 to &loopsize;
end;
run;

data _null_;
missing=.;
a=1;
b=1;
c=1;
d=1;
do i=1 to &loopsize;
end;
run;

data _null_;
missing=.;
a=1;
b=1;
c=1;
d=1;
do i=1 to &loopsize;
   total = missing + a + b + c + d;
end;
run;

data _null_;
missing=.;
a=1;
b=1;
c=1;
d=1;
do i=1 to &loopsize;
   total = missing + a + b + c + d;
end;
run;

data _null_;
missing=.;
a=1;
b=1;
c=1;
d=1;
do i=1 to &loopsize;
   total = missing + a + b + c + d;
end;
run;

data _null_;
missing=.;
a=1;
b=1;
c=1;
d=1;
do i=1 to &loopsize;
   total = a + b + c + d + missing;
end;
run;

data _null_;
missing=.;
a=1;
b=1;
c=1;
d=1;
do i=1 to &loopsize;
   total = a + b + c + d + missing;
end;
run;

data _null_;
missing=.;
a=1;
b=1;
c=1;
d=1;
do i=1 to &loopsize;
   total = a + b + c + d + missing;
end;
run;


**********************************************************
**  TEST #7I:  Multiplication vs. Division              **
**********************************************************;

data _null_;
a=1;
b=1;
do i=1 to &loopsize*5;
end;
run;

data _null_;
a=1;
b=1;
do i=1 to &loopsize*5;
end;
run;

data _null_;
a=1;
b=1;
do i=1 to &loopsize*5;
end;
run;

data _null_;
a=1;
b=1;
do i=1 to &loopsize*5;
   c = a / b;
end;
run;

data _null_;
a=1;
b=1;
do i=1 to &loopsize*5;
   c = a / b;
end;
run;

data _null_;
a=1;
b=1;
do i=1 to &loopsize*5;
   c = a / b;
end;
run;

data _null_;
a=1;
b=1;
do i=1 to &loopsize*5;
   c = a * b;
end;
run;

data _null_;
a=1;
b=1;
do i=1 to &loopsize*5;
   c = a * b;
end;
run;

data _null_;
a=1;
b=1;
do i=1 to &loopsize*5;
   c = a * b;
end;
run;


**********************************************************
**  TEST #7J:  Grouping Numeric Constants               **
**********************************************************;

data _null_;
a=1;
do i=1 to &loopsize*5;
end;
run;

data _null_;
a=1;
do i=1 to &loopsize*5;
end;
run;

data _null_;
a=1;
do i=1 to &loopsize*5;
end;
run;

data _null_;
a=1;
do i=1 to &loopsize*5;
   c = 1 + 8 + a;
end;
run;

data _null_;
a=1;
do i=1 to &loopsize*5;
   c = 1 + 8 + a;
end;
run;

data _null_;
a=1;
do i=1 to &loopsize*5;
   c = 1 + 8 + a;
end;
run;

data _null_;
a=1;
do i=1 to &loopsize*5;
   c = 1 + a + 8;
end;
run;

data _null_;
a=1;
do i=1 to &loopsize*5;
   c = 1 + a + 8;
end;
run;

data _null_;
a=1;
do i=1 to &loopsize*5;
   c = 1 + a + 8;
end;
run;


**********************************************************
**  TEST #7K:  Using ELSE                               **
**********************************************************;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   if name='WILLIAM' then category='HUSBAND ';
   if name='HILLARY' then category='WIFE    ';
   if name='CHELSEA' then category='DAUGHTER';
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   if name='WILLIAM' then category='HUSBAND ';
   if name='HILLARY' then category='WIFE    ';
   if name='CHELSEA' then category='DAUGHTER';
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   if name='WILLIAM' then category='HUSBAND ';
   if name='HILLARY' then category='WIFE    ';
   if name='CHELSEA' then category='DAUGHTER';
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   if      name='WILLIAM' then category='HUSBAND ';
   else if name='HILLARY' then category='WIFE    ';
   else if name='CHELSEA' then category='DAUGHTER';
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   if      name='WILLIAM' then category='HUSBAND ';
   else if name='HILLARY' then category='WIFE    ';
   else if name='CHELSEA' then category='DAUGHTER';
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   if      name='WILLIAM' then category='HUSBAND ';
   else if name='HILLARY' then category='WIFE    ';
   else if name='CHELSEA' then category='DAUGHTER';
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   if      name='HILLARY' then category='WIFE    ';
   else if name='WILLIAM' then category='HUSBAND ';
   else if name='CHELSEA' then category='DAUGHTER';
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   if      name='HILLARY' then category='WIFE    ';
   else if name='WILLIAM' then category='HUSBAND ';
   else if name='CHELSEA' then category='DAUGHTER';
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   if      name='HILLARY' then category='WIFE    ';
   else if name='WILLIAM' then category='HUSBAND ';
   else if name='CHELSEA' then category='DAUGHTER';
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   if      name='HILLARY' then category='WIFE    ';
   else if name='CHELSEA' then category='DAUGHTER';
   else if name='WILLIAM' then category='HUSBAND ';
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   if      name='HILLARY' then category='WIFE    ';
   else if name='CHELSEA' then category='DAUGHTER';
   else if name='WILLIAM' then category='HUSBAND ';
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   if      name='HILLARY' then category='WIFE    ';
   else if name='CHELSEA' then category='DAUGHTER';
   else if name='WILLIAM' then category='HUSBAND ';
end;
run;


**********************************************************
**  TEST #7L:  ELSE vs. SELECT                          **
**********************************************************;
**  ELSE logic tested above in 7K                       **
**********************************************************;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   select;
      when (name='WILLIAM') category='HUSBAND ';
      when (name='HILLARY') category='WIFE    ';
      when (name='CHELSEA') category='DAUGHTER';
      otherwise;
   end;
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   select;
      when (name='WILLIAM') category='HUSBAND ';
      when (name='HILLARY') category='WIFE    ';
      when (name='CHELSEA') category='DAUGHTER';
      otherwise;
   end;
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   select;
      when (name='WILLIAM') category='HUSBAND ';
      when (name='HILLARY') category='WIFE    ';
      when (name='CHELSEA') category='DAUGHTER';
      otherwise;
   end;
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   select (name);
      when ('WILLIAM') category='HUSBAND ';
      when ('HILLARY') category='WIFE    ';
      when ('CHELSEA') category='DAUGHTER';
      otherwise;
   end;
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   select (name);
      when ('WILLIAM') category='HUSBAND ';
      when ('HILLARY') category='WIFE    ';
      when ('CHELSEA') category='DAUGHTER';
      otherwise;
   end;
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   select (name);
      when ('WILLIAM') category='HUSBAND ';
      when ('HILLARY') category='WIFE    ';
      when ('CHELSEA') category='DAUGHTER';
      otherwise;
   end;
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   select;
      when (name='HILLARY') category='WIFE    ';
      when (name='WILLIAM') category='HUSBAND ';
      when (name='CHELSEA') category='DAUGHTER';
      otherwise;
   end;
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   select;
      when (name='HILLARY') category='WIFE    ';
      when (name='WILLIAM') category='HUSBAND ';
      when (name='CHELSEA') category='DAUGHTER';
      otherwise;
   end;
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   select;
      when (name='HILLARY') category='WIFE    ';
      when (name='WILLIAM') category='HUSBAND ';
      when (name='CHELSEA') category='DAUGHTER';
      otherwise;
   end;
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   select (name);
      when ('HILLARY') category='WIFE    ';
      when ('WILLIAM') category='HUSBAND ';
      when ('CHELSEA') category='DAUGHTER';
      otherwise;
   end;
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   select (name);
      when ('HILLARY') category='WIFE    ';
      when ('WILLIAM') category='HUSBAND ';
      when ('CHELSEA') category='DAUGHTER';
      otherwise;
   end;
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   select (name);
      when ('HILLARY') category='WIFE    ';
      when ('WILLIAM') category='HUSBAND ';
      when ('CHELSEA') category='DAUGHTER';
      otherwise;
   end;
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   select;
      when (name='HILLARY') category='WIFE    ';
      when (name='CHELSEA') category='DAUGHTER';
      when (name='WILLIAM') category='HUSBAND ';
      otherwise;
   end;
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   select;
      when (name='HILLARY') category='WIFE    ';
      when (name='CHELSEA') category='DAUGHTER';
      when (name='WILLIAM') category='HUSBAND ';
      otherwise;
   end;
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   select;
      when (name='HILLARY') category='WIFE    ';
      when (name='CHELSEA') category='DAUGHTER';
      when (name='WILLIAM') category='HUSBAND ';
      otherwise;
   end;
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   select (name);
      when ('HILLARY') category='WIFE    ';
      when ('CHELSEA') category='DAUGHTER';
      when ('WILLIAM') category='HUSBAND ';
      otherwise;
   end;
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   select (name);
      when ('HILLARY') category='WIFE    ';
      when ('CHELSEA') category='DAUGHTER';
      when ('WILLIAM') category='HUSBAND ';
      otherwise;
   end;
end;
run;

data _null_;
length category $ 8;
name='WILLIAM';
do i=1 to &loopsize*5;
   select (name);
      when ('HILLARY') category='WIFE    ';
      when ('CHELSEA') category='DAUGHTER';
      when ('WILLIAM') category='HUSBAND ';
      otherwise;
   end;
end;
run;


**********************************************************
**  TEST #7M:  ELSE vs. FORMAT/PUT Function             **
**********************************************************;

proc format;
value testing  1='A'  2='B'  3='C'  4='D'  5='E'  6='F'  7='G'
               8='H'  9='I' 10='J' 11='K' 12='L' 13='M' 14='N'
              15='O' 16='P' 17='Q' 18='R' 19='S' 20='T' 21='U'
              22='V' 23='W' 24='X' 25='Y' 26='Z';
run;

data _null_;
do i=1 to &loopsize/5;
   do n=1 to 26;
      if      n= 1 then letter='A';
      else if n= 2 then letter='B';
      else if n= 3 then letter='C';
      else if n= 4 then letter='D';
      else if n= 5 then letter='E';
      else if n= 6 then letter='F';
      else if n= 7 then letter='G';
      else if n= 8 then letter='H';
      else if n= 9 then letter='I';
      else if n=10 then letter='J';
      else if n=11 then letter='K';
      else if n=12 then letter='L';
      else if n=13 then letter='M';
      else if n=14 then letter='N';
      else if n=15 then letter='O';
      else if n=16 then letter='P';
      else if n=17 then letter='Q';
      else if n=18 then letter='R';
      else if n=19 then letter='S';
      else if n=20 then letter='T';
      else if n=21 then letter='U';
      else if n=22 then letter='V';
      else if n=23 then letter='W';
      else if n=24 then letter='X';
      else if n=25 then letter='Y';
      else if n=26 then letter='Z';
   end;
end;
run;

data _null_;
do i=1 to &loopsize/5;
   do n=1 to 26;
      if      n= 1 then letter='A';
      else if n= 2 then letter='B';
      else if n= 3 then letter='C';
      else if n= 4 then letter='D';
      else if n= 5 then letter='E';
      else if n= 6 then letter='F';
      else if n= 7 then letter='G';
      else if n= 8 then letter='H';
      else if n= 9 then letter='I';
      else if n=10 then letter='J';
      else if n=11 then letter='K';
      else if n=12 then letter='L';
      else if n=13 then letter='M';
      else if n=14 then letter='N';
      else if n=15 then letter='O';
      else if n=16 then letter='P';
      else if n=17 then letter='Q';
      else if n=18 then letter='R';
      else if n=19 then letter='S';
      else if n=20 then letter='T';
      else if n=21 then letter='U';
      else if n=22 then letter='V';
      else if n=23 then letter='W';
      else if n=24 then letter='X';
      else if n=25 then letter='Y';
      else if n=26 then letter='Z';
   end;
end;
run;

data _null_;
do i=1 to &loopsize/5;
   do n=1 to 26;
      if      n= 1 then letter='A';
      else if n= 2 then letter='B';
      else if n= 3 then letter='C';
      else if n= 4 then letter='D';
      else if n= 5 then letter='E';
      else if n= 6 then letter='F';
      else if n= 7 then letter='G';
      else if n= 8 then letter='H';
      else if n= 9 then letter='I';
      else if n=10 then letter='J';
      else if n=11 then letter='K';
      else if n=12 then letter='L';
      else if n=13 then letter='M';
      else if n=14 then letter='N';
      else if n=15 then letter='O';
      else if n=16 then letter='P';
      else if n=17 then letter='Q';
      else if n=18 then letter='R';
      else if n=19 then letter='S';
      else if n=20 then letter='T';
      else if n=21 then letter='U';
      else if n=22 then letter='V';
      else if n=23 then letter='W';
      else if n=24 then letter='X';
      else if n=25 then letter='Y';
      else if n=26 then letter='Z';
   end;
end;
run;

data _null_;
do i=1 to &loopsize/5;
   do n=1 to 26;
      letter = put(n, testing.);
   end;
end;
run;

data _null_;
do i=1 to &loopsize/5;
   do n=1 to 26;
      letter = put(n, testing.);
   end;
end;
run;

data _null_;
do i=1 to &loopsize/5;
   do n=1 to 26;
      letter = put(n, testing.);
   end;
end;
run;


**********************************************************
**  TEST #7N:  IN Operator vs. Logical OR               **
**********************************************************;

data _null_;
symbol='GE';
do i=1 to &loopsize;
end;
run;

data _null_;
symbol='GE';
do i=1 to &loopsize;
end;
run;

data _null_;
symbol='GE';
do i=1 to &loopsize;
end;
run;

data _null_;
symbol='GE';
do i=1 to &loopsize;
   if symbol in ('GE', 'GM', 'F') then x=1;
end;
run;

data _null_;
symbol='GE';
do i=1 to &loopsize;
   if symbol in ('GE', 'GM', 'F') then x=1;
end;
run;

data _null_;
symbol='GE';
do i=1 to &loopsize;
   if symbol in ('GE', 'GM', 'F') then x=1;
end;
run;

data _null_;
symbol='GM';
do i=1 to &loopsize;
   if symbol in ('GE', 'GM', 'F') then x=1;
end;
run;

data _null_;
symbol='GM';
do i=1 to &loopsize;
   if symbol in ('GE', 'GM', 'F') then x=1;
end;
run;

data _null_;
symbol='GM';
do i=1 to &loopsize;
   if symbol in ('GE', 'GM', 'F') then x=1;
end;
run;

data _null_;
symbol='F ';
do i=1 to &loopsize;
   if symbol in ('GE', 'GM', 'F') then x=1;
end;
run;

data _null_;
symbol='F ';
do i=1 to &loopsize;
   if symbol in ('GE', 'GM', 'F') then x=1;
end;
run;

data _null_;
symbol='F ';
do i=1 to &loopsize;
   if symbol in ('GE', 'GM', 'F') then x=1;
end;
run;

data _null_;
symbol='F ';
do i=1 to &loopsize;
   if symbol='GE' or symbol='GM' or symbol='F' then x=1;
end;
run;

data _null_;
symbol='F ';
do i=1 to &loopsize;
   if symbol='GE' or symbol='GM' or symbol='F' then x=1;
end;
run;

data _null_;
symbol='F ';
do i=1 to &loopsize;
   if symbol='GE' or symbol='GM' or symbol='F' then x=1;
end;
run;

data _null_;
symbol='GM';
do i=1 to &loopsize;
   if symbol='GE' or symbol='GM' or symbol='F' then x=1;
end;
run;

data _null_;
symbol='GM';
do i=1 to &loopsize;
   if symbol='GE' or symbol='GM' or symbol='F' then x=1;
end;
run;

data _null_;
symbol='GM';
do i=1 to &loopsize;
   if symbol='GE' or symbol='GM' or symbol='F' then x=1;
end;
run;

data _null_;
symbol='GE';
do i=1 to &loopsize;
   if symbol='GE' or symbol='GM' or symbol='F' then x=1;
end;
run;

data _null_;
symbol='GE';
do i=1 to &loopsize;
   if symbol='GE' or symbol='GM' or symbol='F' then x=1;
end;
run;

data _null_;
symbol='GE';
do i=1 to &loopsize;
   if symbol='GE' or symbol='GM' or symbol='F' then x=1;
end;
run;


**********************************************************
**  TEST #7O:  If X vs. If X=1                          **
**********************************************************;

data _null_;
x=0;
do i=1 to &loopsize*5;
end;
run;

data _null_;
x=0;
do i=1 to &loopsize*5;
end;
run;

data _null_;
x=0;
do i=1 to &loopsize*5;
end;
run;

data _null_;
x=0;
do i=1 to &loopsize*5;
   if x=5 then y=1;
end;
run;

data _null_;
x=0;
do i=1 to &loopsize*5;
   if x=5 then y=1;
end;
run;

data _null_;
x=0;
do i=1 to &loopsize*5;
   if x=5 then y=1;
end;
run;

data _null_;
x=0;
do i=1 to &loopsize*5;
   if x then y=1;
end;
run;

data _null_;
x=0;
do i=1 to &loopsize*5;
   if x then y=1;
end;
run;

data _null_;
x=0;
do i=1 to &loopsize*5;
   if x then y=1;
end;
run;


**********************************************************
**  TEST #7P:  RETAIN vs. Assign                        **
**********************************************************;

data _null_;
set _030vars (keep=var1);
run;

data _null_;
set _030vars (keep=var1);
run;

data _null_;
set _030vars (keep=var1);
run;

data _null_;
set _030vars (keep=var1);
a=1;
b=1;
c=1;
d=1;
e=1;
run;

data _null_;
set _030vars (keep=var1);
a=1;
b=1;
c=1;
d=1;
e=1;
run;

data _null_;
set _030vars (keep=var1);
a=1;
b=1;
c=1;
d=1;
e=1;
run;

data _null_;
set _030vars (keep=var1);
retain a b c d e 1;
run;

data _null_;
set _030vars (keep=var1);
retain a b c d e 1;
run;

data _null_;
set _030vars (keep=var1);
retain a b c d e 1;
run;


**********************************************************
**  TEST #7Q:  Variables vs. Array Elements             **
**********************************************************;

data _null_;
array x {5};
do i=1 to &loopsize*10;
end;
run;

data _null_;
array x {5};
do i=1 to &loopsize*10;
end;
run;

data _null_;
array x {5};
do i=1 to &loopsize*10;
end;
run;

data _null_;
array x {5};
do i=1 to &loopsize*10;
   x1=0;
   x2=0;
   x3=0;
   x4=0;
   x5=0;
end;
run;

data _null_;
array x {5};
do i=1 to &loopsize*10;
   x1=0;
   x2=0;
   x3=0;
   x4=0;
   x5=0;
end;
run;

data _null_;
array x {5};
do i=1 to &loopsize*10;
   x1=0;
   x2=0;
   x3=0;
   x4=0;
   x5=0;
end;
run;

data _null_;
array x {5};
do i=1 to &loopsize*10;
   x{1}=0;
   x{2}=0;
   x{3}=0;
   x{4}=0;
   x{5}=0;
end;
run;

data _null_;
array x {5};
do i=1 to &loopsize*10;
   x{1}=0;
   x{2}=0;
   x{3}=0;
   x{4}=0;
   x{5}=0;
end;
run;

data _null_;
array x {5};
do i=1 to &loopsize*10;
   x{1}=0;
   x{2}=0;
   x{3}=0;
   x{4}=0;
   x{5}=0;
end;
run;
