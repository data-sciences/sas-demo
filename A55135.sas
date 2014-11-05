***********************************************************************
This file contains selected programs from the book, "Reporting
from the Field: SAS(R) Software Experts Present Real-World Report-Writing
Applications" (pubcode 55135)

Copyright (C) 1994 by SAS Institute Inc., Cary, NC, USA.

SAS(R) is a registered trademark of SAS Institute Inc.

SAS Institute does not assume responsibility for the accuracy of any
material presented in this file.
***********************************************************************

---------
CHAPTER 1
---------
/* The following code appears in Chapter 1, p. 5 */

 data uniform;
    do i = 1 to 1000;
       point=round(ranuni(0) * 10 +.5),1);
       output;
       end;
 proc freq;
    tables point;


/* The following code appears in Chapter 1, p. 6 */

 proc format;
 value typefmt
 1='Abdominal'
 2='Head & Neck'
 3='Extremities'                    4='OB/Gyn'
 5='Thoracic';

 data report;
   set hospital;
   keep type hospital group state;
   array hosp hosp1-hosp5;
   array grp  group1-group5;
   array st   state1-state5;
   do _i_=1 to 5;
      type=put(_i_,typefmt.);
      hospital=hosp;
      group=grp;
      state=st;
      output;
      end;


/* The following code appears in Chapter 1, pp. 11-12 */

data schedule;
   i=0;
   do fireman= 'A','B','C','D';
      begin= '02jan94'd;

     /**** Prevent D from a pre-schedule start. ****/
      if (fireman='D') then do;
         begin = intnx('WEEK',begin,3);
         i=0;
         end;
      do shift=1 to 4;
         on=begin;
         off = intnx('WEEK',on,9);

     /**** Initiate staggered reliefs. ****/
         if (shift=1) then off = intnx('WEEK',on,9 - (3 * i));
         begin = intnx('WEEK',off,3);
         output;
         end;
      i+1;
      end;
proc print;
   by fireman;
   id shift;
   var on off;
   format on off date9.;
title 'Volunteer Fireman Schedule';


/* The following code appears in Chapter 1, p. 13 */

 data pick;
   retain sample 10 pop 100;
   do i=1 to 100;
      random=ranuni(0);
      if (random< sample / pop) then do;
         sample=sample - 1; output;
         end;
      pop=pop - 1;
         end;


/* The following code appears in Chapter 1, p. 18 */

data setup;
   infile in;
   input age gender $;
   if (age=10) then age1=1;
    else if (age=27) then age2=1;
    else if (age=42) then age3=1;
    else if (age=47) then age4=1;
    else if (age=72) then age5=1;
   if (gender='F') then gen1=1;
    else if (gender='M') then gen2=1;
proc means noprint;
   var age age1-age5 gen1-gen2;
   output out=stats mean(age)= sum(age1-gen2)=;
data report;
   set stats;
   array pct age1-age5 gen1-gen2;
   do over pct;
      pct=round((100 * pct) / _freq_),.1);
      end;
proc print;
title 'Mean Age Plus Age & Gender Percents';

---------
CHAPTER 2
---------

/* The following code appears in Chapter 2, pp. 30-31 */

/**** A format designating selected zipcodes is created. ****/
proc format;
   value $zip
   '84001' = 'Y'
   '84005' = 'Y'
   '84010' = 'Y'
   '84013' = 'Y'
   '84050' = 'Y'
   '84070' = 'Y'
   '84088' = 'Y'
   '84100' = 'Y';

/**** A 10000 observation data set with incremental zipcode values is
      generated ****/
data zips;
   do j=1 to 100;
      do i=1 to 100;
         zip=put(84000 + i, 5.);
         output;
      end;
   end;

/**** A subset is selected using the subsetting IF statement. ****/
data sub_if;
   set zips;
   if (put(zip,$zip.)='Y');

/**** A subset is selected using the WHERE data set option. ****/
data wheredso;
   set zips(where=(put(zip,$zip.)='Y'));

/**** A subset is slected using the DELETE statement. ****/
data deletes;
   set zips;
   if (put(zip,$zip.)^='Y') then delete;

/**** A subset is selected using the OUTPUT statement. ****/
data outputs;
   set zips;
   if (put(zip,$zip.)='Y') then output;

---------
CHAPTER 3
---------
/* The following code appears in Chapter 3, p. 40 */

proc format;
   value $zip0fmt
   '0001' = '0011000'
   '0002' = '0011000'
   '0003' = '0011031'
   '0005' = '0011020'
   ;
data temp;
   set zips;
   length zipc $1 coutny $3 tract $4;
   zipc = substr(zip,1);
   if (zipc='0') then string = put(zip, $zip0fmt.);
    else if (zipc='1') then string = put(zip, $zip1fmt.);
    else if (zipc='2') then string = put(zip, $zip2fmt.);
    else if (zipc='3') then string = put(zip, $zip3fmt.);
    else if (zipc='4') then string = put(zip, $zip4fmt.);
    else if (zipc='5') then string = put(zip, $zip5fmt.);
    else if (zipc='6') then string = put(zip, $zip6fmt.);
    else if (zipc='7') then string = put(zip, $zip7fmt.);
    else if (zipc='8') then string = put(zip, $zip8fmt.);
    else if (zipc='9') then string = put(zip, $zip9fmt.);
   county  = substr(string,1,3);
   track   = substr(string,4,4);


/* The following code appears in Chapter 3, pp. 42-43 */

/**** Create a format for related variables. ****/
proc format;
   value $group
   'A'='Age of Buyer'
   'E'='Education Level'
   'M'='Marital Status';

/**** Format original variable names to comply with row descriptions. ****/
   value $rows
   'AGE1'='Less than 30'
   'AGE2'='30-34'
   'AGE3'='35-39'
   'AGE4'='40-44'
   'AGE5'='45-49'
   'AGE6'='50-54'
   'AGE7'='55-59'
   'AGE8'='60-64'
   'AGE9'='65 and over'
   'AGEM'='Median Age'

   'ED1'='High School Graduate'
   'ED2'='Some College'
   'ED3'='College Graduate'
   'ED4'='Technical, Other'

   'MS1'='Married'
   'MS2'='Single'
   'MS3'='Other';

data demo;
   set trucks (keep=age educ ms seg);

/**** Create category freqency variables. ****/
   if (age < 28) then age1=1;
    else if (age=32) then age2=1;
    else if (age=37) then age3=1;
    else if (age=42) then age4=1;
    else if (age=47) then age5=1;
    else if (age=52) then age6=1;
    else if (age=57) then age7=1;
    else if (age=62) then age8=1;
    else if (age=68) then age9=1;
   agem = age + 3;

   if (ms='M') then ms1 =1;
    else if (ms='S') then ms2=1;
    else if (ms='O') then ms3=1;
   keep age1--ms3 seg agem;

/**** Summarize the data. ****/
proc means data=demo nway noprint;
   class seg;
   var age1--ms3;
   output out=sdemo sum(age1--ms3)=;

/**** Invoke the Percentile Macro. ****/
%pctl(50,agem,by=seg,out=medage)

/**** Compute percents using the category frequencies. ****/
data pct;
   length age1-age9 agem ed1-ed4 ms1-ms3;
   merge sdemo medage;
   by seg;
   array pct age1-age9 ed1--ms3;
   do over pct;
      pct = (100 * pct) / _freq_;
      end;

/**** Transpose the data orientation. ****/
proc transpose data=pct out-tdemo;
   id seg;
   var age1--ms3;

/**** create logical grouping variable tans sort if necessary. ****/
data tdemo;
   set tdemo;
   group = substr(_name_,1,1);
data _null_;
   file out ll=lines print header=top;
   set tdemo;
   by group;

/**** Govern spacing between groups with FIRST. processing. ****/
   if (first.group) then do;
      if (lines<20) then put _age);
       else put //;
      put @1 group $group. / @1 15 * '-';

/**** Conditionally output statistics witht he appropriate format. ****/
   if (_name_='AGEM') then put
      @3 _name_ $rows. @23 (bus--utility) (5.2 +3);
    else put @3 _name_ $rows. @23 (bus--utility) (5.1 +3);
   return;
top:
   put 'Demographic Characteristics by Vehicle Type' /
       @15 43 * '-' /
       @24 'BUS MINIVAN PICKUP UTILITY';
      return;
      run;

/* The following code appears in Chapter 3, pp. 48-49 */

/**** Macro for Computing Percentiles of Categorical Data ****/
%MACRO PCTL(PCTL,ON,BY=,IN=&SYSLAST,OUT=DATA1,WEIGHT=);
   %IF (%STR(&BY)^=%STR()) %THEN %DO;
      %LET BYSTR=&BY;
      %LET NULL=%STR( );
      %LET LAST=%INDEX(&BYSTR,&NULL);
      %DO %WHILE (&LAST ^=0);
         %LET BYSTR=%SUBSTR(&BYSTR,&LAST);
         %LET LAST=%INDEX(&BYSTR,&NULL);
         %END;
      %LET FIRSTBY=FIRST.&BYSTR;
      %LET LASTBY=LAST.&BYSTR;
      %STR(PROC SORT DATA=&IN;);
      %STR(BY &BY;);
      %END;
    %ELSE %DO;
      %LET FIRSTBY=_N_=1;
      %LET LASTBY=EOF;
      %END;
   %STR(PROC FREQ DATA=&IN;);
   %IF (%STR(&BY)^=%STR()) %THEN %DO;
      %STR(BY &BY;);
      %END;
   %STR(TABLES &ON / NOPRINT OUT=&OUT;);
   %IF (%STR(&WEIGHT)^=%STR()) %THEN %STR(WEIGHT &WEIGHT;);
   DATA &OUT;
      SET &OUT(WHERE=(&ON^=.)) END=EOF;
      KEEP &ON &BY;
      %IF (%STR(&BY)^=%STR()) %THEN %DO;
          %STR(BY &BY;);
          %END;
      LASTON = LAG(&ON);
      LASTPCT = LAG(PERCENT);
      IF (&FIRSTBY) THEN SUMPCT=0;
      IF (SUMPCT>=&PCTL) THEN DELETE;
      SUMPCT + PERCENT;
      IF (SUMPCT>=&PCTL) THEN DO;
         IF (&FIRSTBY | &LASTBY) THEN DO;
            IF (&FIRSTBY) THEN CELL='RIGHT';
             ELSE CELL='LEFT';
            PUT ">> WARNING: &PCTL.th PERCENTILE OF &ON IS IN "
               CELL $5. "-MOST CELL.";
            PUT '>> A MISSING VALUE WILL BE RETURNED';
            %IF (%STR(&BY)^=%STR()) %THEN %DO;
                PUT 'FOR BY VALUES ' &BY;
                %END;
            &ON=.;
            OUTPUT;
            END;
          ELSE DO;
            IF(SUMPCT>&PCTL) THEN &ON = ((&PCTL - LASTPCT) / (SUMPCT - LASTPCT))
                * (&ON - LASTON +1) + LASTON;
            OUTPUT;
            END;
         END;
       LABEL &ON="&ON &PCTL.th PCT EST. FROM CUM. DIST.";
    %mend;

---------
CHAPTER 5
---------

/* The following code appears in Chapter 5, p. 75 */

proc tabulate data=repwrite.health;
  class year gender age smoker chol200 exercise;
  table year, gender*age, chol200 smoker exercise;
run;
/*-----------------------------------------------------------------------*/
proc tabulate data=repwrite.health;
  class year gender age smoker chol200 exercise;
  var weight systol diast chol;
  table year,
        gender*age,
        weight systol diast chol chol200 smoker exercise;
run;

/* The following code appears in Chapter 5, p. 76 */

proc tabulate data=repwrite.health;
  class year gender age smoker chol200 exercise;
  var weight systol diast chol;
  table year,
        gender*age,
        n weight*mean systol*mean diast*mean
        chol*mean chol*max
        chol200*pctn smoker*pctn exercise*pctn;
run;

/* The following code appears in Chapter 5, p. 78 */

proc tabulate data=repwrite.health;
  class year gender age smoker chol200 exercise;
  var weight systol diast chol;
  table year,
        all gender*(age all),
        n weight*mean systol*mean diast*mean
        chol*mean chol*max
        chol200*pctn smoker*pctn exercise*pctn;
run;
/*-----------------------------------------------------------------------*/
proc tabulate data=repwrite.health;
  class year gender age smoker chol200 exercise;
  var weight systol diast chol;
  table year,
        all gender*(age all),
        n weight*mean systol*mean diast*mean
        chol*mean chol*max
        chol200*pctn<chol200> smoker*pctn<smoker>
        exercise*pctn<exercise>;
run;

/* The following code appears in Chapter 5, p. 81 */

title1 'ANNUAL SUMMARY OF HEALTH ASSESSMENT PROGRAM';
title2 'BY GENDER AND AGE';
options pageno=1 ls=117 ps=45 center;

proc format;
  value agefmt   21-35='21-35'
                 36-55='36-55'
                 56-high='56+';
  value $gendfmt 'F'='Female'
                 'M'='Male';
  value $ynfmt   'N'='No'
                 'Y'='Yes';
run;

proc tabulate data=repwrite.health missing;
  class year gender age smoker chol200 exercise;
  var weight systol diast chol;

  table year,
        all gender*(age all),
        n*f=4.
        (weight systol diast)*mean='Mean'*f=9.
        chol*(mean='Mean'*f=7. max='Maximum'*f=7.)
        chol200*pctn<chol200>*f=7.1 smoker*pctn<smoker>*f=7.1
        exercise*pctn<exercise>*f=7.1   /
        box=_page_ rts=18 misstext='0';
  keylabel all='Total'
           pctn='Percent';
  format age agefmt. gender $gendfmt. chol200 smoker exercise $ynfmt.;
run;

/* The following code appears in Chapter 5, p. 84 */

proc tabulate data=repwrite.health;
  class year gender age chol200;
  var chol;
  table gender*age, year*chol*mean year*chol200*pctn;
run;
/*-----------------------------------------------------------------------*/
proc tabulate data=repwrite.health;
  class year gender age chol200;
  var chol;
  table all gender*(age all),
        year*chol*mean year*chol200*pctn;
run;

/* The following code appears in Chapter 5, p. 85 */

proc tabulate data=repwrite.health;
  class year gender age chol200;
  var chol;
  table all gender*(age all),
        year*chol*mean year*chol200*pctn<chol200>;
run;

/* The following code appears in Chapter 5, p. 86 */

title 'CHOLESTEROL RESULTS BY YEAR FOR HEALTH ASSESSMENT PROGRAM';
options pageno=1 ls=110 ps=45 center;

proc format;
  value agefmt   21-35='21-35'
                 36-55='36-55'
                 56-high='56+';
  value $gendfmt 'F'='Female'
                 'M'='Male';
  value $ynfmt   'N'='No'
                 'Y'='Yes';
run;

proc tabulate data=repwrite.health;
  class year gender age chol200;
  var chol;
  table all gender*(age all),
        year*chol='Mean Cholesterol'*mean*f=12.
        year*chol200*pctn<chol200>*f=9.1 /
        rts=21 misstext='0';
  format gender $gendfmt. age agefmt. chol200 $ynfmt.;
  keylabel pctn='Percent'
           mean=' '
           all='Total';
run;

---------
CHAPTER 6
---------

/* The following code appears in Chapter 6, p. 94 */

/* ******************************************* */
/* Write to more than one file                 */
filename inv 'invoice';
filename sales 'rpt';

data _null_;

date = '04jun78'd;
name = 'Jones';
code = '123';
cost = 4285.32;

file inv;
put @4 'Buyer ' name  cost;

file sales;
put @2 'item code ' code 'cost' cost;
run;


/* ********************************************** */
/* Creates a report with one observation per page */

data claims;
client='Industrial Hardware';
cases=437;
clchrg= 42798;
allowed=36731;
savings=clchrg-allowed;
opcases=153;
opchrg=15364;
opallow=14871;
opsav= opchrg-opallow;
run;

options ls=65;


/* The following code appears in Chapter 6, pp. 97-98 */

data _null_;
set claims;

file print;

link title;

put // 'Summary of all Cases';

put / @5 'Number of claims: ' @25 cases;
put   @10 'Claim amount: ' @25 clchrg dollar11.0;
put   @10 'Allowed amount: ' @25 allowed comma11.0;
put   @10 'Savings: ' @25 savings dollar11.0;

link foot;
return;

title:
offset = (60-length(client))/2;
put @offset client //;
return;

foot:
string = 'Savings realized during 1994';
offset = (60-length(string))/2;
put // @offset string _page_;
return;
run;

filename allcase '\author\datanull\allcase.txt';
filename opcase  '\author\datanull\opcase.txt';


/* The following code appears in Chapter 6, p. 99 */

data _null_;
set claims;

file allcase;

link title;
put // 'Summary of all Cases';
put / @5 'Number of claims: ' @25 cases;
put   @10 'Claim amount: ' @25 clchrg dollar11.0;
put   @10 'Allowed amount: ' @25 allowed comma11.0;
put   @10 'Savings: ' @25 savings dollar11.0;
link foot;

file opcase;
link title;
put // 'Summary of out patient cases';
put / @5 'Out patient claims: ' @25 opcases;
put   @10 'Claim amount: ' @25 opchrg dollar11.0;
put   @10 'Allowed amount: ' @25 opallow comma11.0;
put   @10 'Savings: ' @25 opsav dollar11.0;
link foot;
return;

title:
offset = (60-length(client))/2;
put @offset client //;
return;

foot:
string = 'Savings realized during 1994';
offset = (60-length(string))/2;
put // @offset string _page_;
return;
run;

/* The following code appears in Chapter 6, p. 100 */

/* ********************************************** */
/* Creates a multi-column report.                 */
libname sasclass '\training\sas\sas608\data';

options nonumber nodate ps=50;

data phnums (keep=lname fname ext);
set sasclass.clinics(keep=lname fname ssn);
ext= substr(ssn,1,4);
run;

proc sort data=phnums nodupkey;
by lname fname;
run;

filename phonelst '\author\datanull\phonelst.txt';

 data _null_;
 file phonelst n=ps ls=65 notitle;

 string = 'Industrial Manufacturing Employee Extensions';
 center=(60-length(string))/2;
 put @center string;

 do col = 1, 31;
    do row=4 to 40;
       set phnums;
       name = trim(lname) ||', '|| fname;
       put #row @col ext  name;
    end;
 end;
 put _page_;
 run;

---------
CHAPTER 7
---------

/* The following code appears in Chapter 7, pp. 112-113 */

client:
method;

* this data is included as an example;
lname='Jones';
fname='Laura';
date = '27sep94'd;
reviewer = 'Clint Smith';
company  = 'ABC Manufacturing';

     rc = filename('clmrpt',
            '<<system specific information\>>clmrpt.txt');
     flout = fopen('clmrpt','o',81,'p');

     pad = int((50-length(company))/2);
     if pad lt 0 then pad=0;
     rc = fpos(flout,pad+10);
     rc = fput(flout,company);
     rc = fwrite(flout,'1');
     rc = fwrite(flout,' ');

     rc = fpos(flout,5);
     rc = fput(flout,'Client name');
     rc = fwrite(flout, ' ');

     if lname = ' ' then line1=' ';
     else line1 = trim(fname) ||' '|| lname;
     rc = fpos(flout,5);
     rc = fput(flout,line1);
     rc = fwrite(flout, ' ');
     rc = fwrite(flout, ' ');

     rc = fpos(flout,10);
     rc = fput(flout,'Completed By: ');
     rc = fpos(flout,27);
     rc = fput(flout,reviewer);
     rc = fwrite(flout,' ');

     rc = fclose(flout);
endmethod;

---------
CHAPTER 8
---------

/* The following code appears in Chapter 8, p. 117 */

DATA A;
INPUT LEVEL RESPONSE;
CARDS;
1 21
1 23
2 41
2 51
3 33
3 29
;

PROC TABULATE;
VAR RESPONSE;
CLASS LEVEL;
TABLE LEVEL ALL, RESPONSE * MEAN;
RUN;

/* Use your own data set or key this in and then use the above
TABULATE commands to produce the result shown above. */

/* The following code appears in Chapter 8, p. 118 */

DATA B;
DO SKILL= 'A' , 'B';
DO AGE= 9 TO 11;
INPUT WT @@;
OUTPUT;
END;
END;
CARDS;
  3 4 5 8 7  6
PROC TABULATE;
FREQ WT;
CLASS SKILL AGE;
TABLE AGE, SKILL*(N PCTN);
RUN;

/* Modify the above code to produce column percent with the following:/

TABLE AGE, SKILL*(N PCTN<SKILL>);

/*then modify the code to produce row percent with the following:/

TABLE AGE, SKILL*(N PCTN<AGE>);

/* The following code appears in Chapter 8, p. 119 */

DATA BPRESS;
INPUT DBP SBP;
CARDS;
88 149
81 122
PROC TABULATE;
VAR SBP DBP;
TABLE SBP DBP, N MEAN STD MIN MAX;
RUN;
/*-----------------------------------------------------------------------*/
PROC TABULATE;
VAR SBP DBP;
KEYLABEL N='SAMPLE SIZE' STD='STANDARD DEVIATION' MIN='MINIMUM'
MAX='MAXIMUM';
TABLE SBP DBP, N MEAN STD MIN MAX/RTS=5;
RUN;


/* The following code appears in Chapter 8, p. 120 */

PROC TABULATE FORMCHAR='

/* The following code appears in Chapter 8, p. 121 */

DATA MISS;
INPUT DISEASE RISK X @@;
CARDS;
0 1 1   1 0 1  0 0 1
1 1 .   0 1 .  1 1 .
1 0 .   0 0 .  1 1 .

PROC TABULATE;
CLASS DISEASE RISK X;
TABLE DISEASE, RISK;
RUN;
/*-----------------------------------------------------------------------*/
DATA MISS;
INPUT DISEASE RISK X @@;
CARDS;
. 1 3.   1 0 2. 0 0 1.
1 1 .   0 1 . 1 1 .
1 0 .   0 0 . 1 1 .
PROC TABULATE MISSING;
CLASS DISEASE RISK X ;
TABLE DISEASE, RISK;
RUN;


/* The following code appears in Chapter 8, p. 122 */

DATA AGEDIST;
INPUT AGE WT @@;
CARDS;
19 3 27 4 33 5 54 4 59 3 63 4 74 3 83 1
PROC FORMAT;
VALUE AGE 10-<20 = '10 TO 20'
                       20-<40 = '20 TO 40'
                       40-<65 = '40 TO 65'
                       65-<999= '65 AND UP'
;
PROC TABULATE;
CLASS AGE;
FORMAT AGE AGE.;
TABLE AGE;
FREQ WT;


/* The following code appears in Chapter 8, p. 123 */

DATA;
SET;
WT=WT*100000;
PROC TABULATE;
VAR WT;
CLASS AGE;
FORMAT AGE AGE.;
TABLE AGE,WT*MEAN*F=DOLLAR12.2;
RUN;

----------
CHAPTER 10
----------
/* The following code appears in Chapter 10, p. 153 */


01 /* ----------------------------------------------------------*/
02 /* Create the BTEQ program to get the data from the Teradata.*/
03 /* This is done in an interactive environment where the      */
04 /* user's answers to SAS/AF SCL questions are used to create */
05 /* a customized BTEQ program which contains SQL code.        */
06 /* ----------------------------------------------------------*/
07 /* The purpose of this example is not to teach you how to    */
08 /* write TeraData code, so the proper code isn't shown here. */
09 /* ----------------------------------------------------------*/

/* Once the TeraData program has been created, we execute it from
within SAS. */

10
11 /* ----------------------------------------------------------*/
12 /* Execute the BTEQ program and create the TERA file         */
13 /* ----------------------------------------------------------*/
14 x 'runbteq WREXAMPL';
15

/* Lines 16 through 30 Now you get to the heart of the matter.  You have created
a varying-length file whose records consist of a small fixed portion, followed
by two potentially very large text fields.  The first one might be as large as
5000 bytes, whereas the second one is limited to 2000 bytes. */

16      /* ----------------------------------------------------------*/
17      /* Process the TERA file into a SAS data set                 */
18      /* ----------------------------------------------------------*/

/* Lines 19 through 27 read the fixed portion of each record using a FILENAME
statement and a DATA step consisting of INFILE and INPUT statements. */

19    filename TERA 'J4EHEWL.TERA.EXTRACT';
20    data RPT;
21      infile TERA;
22      input
23          VAR1 $char30.
24          VAR2 ib4.
25          VAR3 pd3.4
26          VAR4 $char10.
27          @;

/* Note the @ sign in line 27.  This leaves the SAS pointer positioned at the
beginning of the first varying-length text field. */

/* Line 28 uses the macro VARCHAR to process the first text field into an array
called LONG1.  Note that the length parameter is set to 200.  Although the
macro allows you to use any length less than 201, you don't need to use any
length other than 200.  The third parameter in line 28 is 25.  The first
varying-length text field can be 5000 bytes long.  5000/200=25  Therefore,
25 array variables 200 characters long are required to hold the maximum
possible field.  For more information about the VARCHAR macro, see
"Explanation of the VARCHAR Macro" and Appendix B later in this chapter. */

28      %varchar(LONG1,200,25);

/* The following code appears in Chapter 10, p. 154 */

/* Line 29 processes the second text field into an array called LONG2.  Since
the second text field is limited to 2000 bytes, the third parameter is 10
2000/200). */

29      %varchar(LONG2,200,10);
30    run;

31      /* ----------------------------------------------------------*/
32      /* Write the Report                                          */
33      /* ----------------------------------------------------------*/

/* Lines 34 through 37 You now have a SAS data set where each SAS record
contains two arrays plus the four fixed length fields).  The following
statements set up the DATA _NULL_ step used to write the report.  */

34    data _null_;
35      set RPT end=EOF;
36      file PRINT header=HEADING linesleft=LINES notitles
37                                                  linesize=120;

/* Lines 38 through 40 use the WORDRAP macro to turn the 200 byte array called
LONG1 into a 110 byte array called TEXT1.  INLEN is set to 200 because the
second parameter in line 28 is 200.  INVARS is set to 25 because the third
parameter in line 28 is 25.  OUTLEN is set to the amount of room you want to
allow for printing, in this case 110.  This is the variable that changes in each
use of WORDRAP; sometimes you have a wide area to print in, and sometimes it's
fairly narrow. */

/* Note that OUTVARS is larger than just text-field length divided by OUTLEN.  In
other words, 5000 / 110 = 46, but 50 is used here.  You should always make
OUTVARS about 10% bigger than the exact calculation.  If you used 46, you
would not be guaranteed that the reformatted text would fit in 46 array
variables. */

38      %wordrap(inbase=LONG1,outbase=TEXT1,inlen=200,outlen=110,
39               invars=25,outvars=50);
40      MAX1 = WORDRAOP;

/* Line 40 is critical and line 43 is used for consistency.  You must save the
value in WORDRAOP in line 40 before you use WORDRAP a second time
(in line 41).  */

/* Lines 41 through 43 turn the array LONG2 into the array TEXT2.  This time,
INVARS is set to 10 because the third parameter of line 29 is 10. */

41      %wordrap(inbase=LONG2,outbase=TEXT2,inlen=200,outlen=110,
42               invars=10,outvars=20);
43      MAX2 = WORDRAOP;
44      if LINES < 6 then link FOOTING;

/* For more information on the WORDRAP macro, see Appendix A. */

/* Lines 45 through 49. You print the 4 fixed variables in the normal manner,
using a PUT statement. */

45      put  @1 VAR1
46          @33 VAR2
47          @45 VAR3
48          @65 VAR4
49          /;

/* The following code appears in Chapter 10, p. 155 */

/* Lines 50 through 53.  These statements print the first text field.  As many
rows as necessary are used to print your text; however, remember the width of
the field is limited to 110. */

50      if MAX1 > 0 then do I = 1 to MAX1;
51                         put @11 TEXT1(I);
52                         if LINES < 4 then link FOOTING;
53                       end;

/* Line 54.  If there is a first text field, this statement creates a blank line
between it and the second text field.  Remember, it's possible for the first
text field to be empty and the second text field to contain some data. */

54      if MAX1 > 0 then put;

/* Lines 55 through 58. These statements print the second text field.  Again, only
the correct number f rows are used to print the field. */

55      if MAX2 > 0 then do I = 1 to MAX2;
56                         put @11 TEXT2(I);
57                         if LINES < 4 then link FOOTING;
58                       end;

/* Lines 59 through 76. This code prints a title, column headings, and footnotes
on each page. */

59      if EOF then link FOOTING;
60    return;
61    HEADING:
62      put @31 'Title';
63      put  @1 'Variable 1'
64          @33 'Variable 2'
65          @45 'Variable 3'
66          @65 'Variable 4'
67          /;
68    return;
69    FOOTING:
70      do while(LINES > 2);
71        put;
72      end;
73      put @21 'Footing Line 1';
74      put @21 'Footing Line 2';
75    return;
76    run;

/* The following appears in Chapter 10, p. 156 */

/* Explanation of the VARCHAR Macro  */

/* Look at Appendix B.  VARCHAR is a short macro and is fairly straight-forward.
The only part that needs explaining is the ELSE clause in the IF statement.  In
this example you had a potential 5000 byte text field, followed by a potential
2000 byte text field.  Suppose that for some reason, you only wanted to print
out the first 1000 bytes of the first field.  You would make the third parameter
of VARCHAR a 5 instead of the normal 25.  */

/* But you we still have to process the pointer across the entire length of the
actual field.  This is the purpose of the ELSE clause, to get the pointer to the
beginning of the next field in those cases where you are not outputting 100% of
the current text field. */

/* Also note the ib2. on the input TL statement.  This assumes that your
varying-length text field uses a 2 byte binary value in front of the data to
define the length of the field.  If you were ever in a situation that didn't use
2 bytes, you'd have to adjust the ib value accordingly.  For example, you would
use ib4. if your system's software uses a 4 byte field to define length.  */

/* The following appears in Chapter 10, pp. 157-163 */

Appendix A - WORDRAP Macro

%macro WORDRAP(INBASE=,OUTBASE=,INLEN=,OUTLEN=,INVARS=,OUTVARS=,
               INARRAY=,OUTARRAY=,CLEAROUT=NO);
 /*------------------------------------------------------------------
 |      WORDRAP               1/91                                   |
 |                                                                   |
 |                                                                   |
 | Macro WORDRAP copies text from one set of character variables     |
 | to another set while trying to prevent word-splitting.  This      |
 | macro assumes that a stream of text has been stored in the input  |
 | set of character variables by breaking the text stream into       |
 | fixed-length segments for storage in SAS variables, so that word  |
 | splits have occurred.  During the copy to an output set of        |
 | character variables, words are recombined and padded with blanks  |
 | so that words are not split in the output character variables.    |
 |                                                                   |
 |                                                                   |
 | NOTES:                                                            |
 |                                                                   |
 |   1. The input variable names have to be XXX1,XXX2,...,XXX10,etc. |
 |      where INBASE=XXX.  Names containing leading zeros in the     |
 |      suffix, such as XXX01, will NOT work.                        |
 |                                                                   |
 |   2. INVAR and OUTVAR must be 2 or greater.                       |
 |                                                                   |
 |   3. INLEN and OUTLEN must be 3 or greater.                       |
 |                                                                   |
 |   4. A LENGTH statement is generated for the OUTBASE variables,   |
 |      so it is NOT necessary to pre-define the output variables.   |
 |                                                                   |
 |   5. You may need more total bytes of space in the output         |
 |      character variables than are in the input since some padding |
 |      with blanks may occur.                                       |
 |                                                                   |
 |                                                                   |
 | Usage Example:                                                    |
 |                                                                   |
 |   The SAS data set X contains the 25 text variables called LONG1  |
 |   through LONG25, each $200.  Copy to $100 strings, SHORT1        |
 |   through SHORT52, for printing.                                  |
 |                                                                   |
 |      data _null_;                                                 |
 |        set X:                                                     |
 |        %WORDRAP(INBASE=LONG,OUTBASE=SHORT,INLEN=200,OUTLEN=100,   |
 |                 INVARS=25,OUTVARS=52);                            |
 |        LINESOUT=WORDRAOP;                                         |
 |        do J = 1 to LINESOUT;                                      |
 |          put @13 LONG(J);                                         |
 |        end;                                                       |
 |      run;                                                         |
 |                                                                   |
 | Requirements:                                                     |
 |                                                                   |
 |   1. Input must be in a set of SAS variables, all with the SAME   |
 |      length, and all in a variable naming sequence; e.g.,         |
 |      DESCR1-DESCR25.                                              |
 |                                                                   |
 |   2. Output must also be a set of SAS variables, all with the     |
 |      SAME length, and all in a variable naming sequence; e.g.,    |
 |      OUT1-OUT25.                                                  |
 |                                                                   |
 |   3. A minimum of 2 variables are required for both input and     |
 |      output.                                                      |
 |                                                                   |
 |   4. If your DATA step contains a "retain", then set CLEAROUT=YES |
 |      to ensure that output variables are always initialized to    |
 |      blanks each time through the data loop.                      |
 |                                                                   |
 | Input:                                                            |
 |     INBASE=  The base portion of the names of the set of vari-    |
 |              ables in which text that is to be transferred can    |
 |              be found.  For example, if DESC1-DESC25 is the       |
 |              text source, then INBASE=DESC.                       |
 |                                                                   |
 |    OUTBASE=  The base portion of the names of the set of vari-    |
 |              ables in which word-wrapped versions of the input    |
 |              text are to be placed.  For example, if OUT1-OUT50   |
 |              is the text target, then OUTBASE=OUT.                |
 |                                                                   |
 |      INLEN=  Length of Source Text variables, $1 to $200          |
 |              200 is the usual value.                              |
 |                                                                   |
 |     OUTLEN=  Length of Target Text variables, $1 to $200.         |
 |              100 (or less) is the usual value.                    |
 |                                                                   |
 |     INVARS=  Number of variables in set of source variables.      |
 |                                                                   |
 |    OUTVARS=  Number of variables in set of target variables.      |
 |                                                                   |
 |    INARRAY=  Name to use as the array name for the array of input |
 |              variables.  If not specified, &INBASE is used.       |
 |                                                                   |
 |   OUTARRAY=  Name to use as the array name for the array of output|
 |              variables.  If not specified, &OUTBASE is used.      |
 |                                                                   |
 |                                                                   |
 | Output:                                                           |
 |                                                                   |
 |   1. Text in INBASE variables is word-wrapped into OUTBASE        |
 |      variables.                                                   |
 |                                                                   |
 |   2. As part of the process, array names are assigned to the set  |
 |      of input variables and the set of output variables (see      |
 |      INARRAY= and OUTARRAY= above).  The array names can be used  |
 |      in processing later in the same DATA step.  The arrays are   |
 |      explicit arrays.                                             |
 |                                                                   |
 |   3. Variable WORDRSLT tells what stopped the process.            |
 |      'INVAR Empty' indicates all text was successfully transferred|
 |      'OUTVAR Full' indicates there was NOT enough room in the     |
 |                    OUTVAR variables to hold all the reformatted   |
 |                    text.                                          |
 |                                                                   |
 |   4. Variable WORDRAOP tells how many OUTVARs had data transferred|
 |      to them.  If WORDRAOP = 0, then the first input text vari-   |
 |      able was blank and no text was transferred.                  |
 |      Note:                                                        |
 |           WORDRSLT and WORDRAOP are dropped from the output data  |
 |           set.  To save this info for later processing, store     |
 |           them in another variable; e.g.,                         |
 |               LINESOUT = WORDRAOP;                                |
 |                                                                   |
 |                                                                   |
 | Code Notes:                                                       |
 |                                                                   |
 | To simplify code, the Macro %PSEUDO was written to simulate a     |
 | SUBSTRING function that operates on a text string of any          |
 | length that consists of the concatenated values of the set of     |
 | input text strings.  The text value returned from %PSEUDO can be  |
 | a maximum of 200 bytes.  For efficiency, a completely blank       |
 | string in the input set will flag the end of the input text.      |
 |                                                                   |
  ------------------------------------------------------------------*/

 %if &INBASE= or &OUTBASE= or &INLEN= or &OUTLEN= or &INVARS= or
     &OUTVARS= %then %do;
                      %put *-*- For Macro WORDRAP you must specify;
                      %put      all of the following:;
                      %put         INBASE  INLEN  INVARS;
                      %put        OUTBASE OUTLEN OUTVARS;
                      %goto EXIT;
                     %end;

 /* To allow multiple calls to WORDRAP in a step, labels must differ
 */

 %let WORDSKIP = WORDS&sysindex;
 %let WORDEXIT = WORDX&sysindex;

 %if  &INARRAY= %then %let  INARRAY = &INBASE;
 %if &OUTARRAY= %then %let OUTARRAY = &OUTBASE;

 /*------------------------------------------------------------------
 |      Description of variables                                     |
 |      ------------------------                                     |
 |  PSEUDOFC First character of a string                             |
 |  PSEUDOLC Last  character of a string                             |
 |  PSEUDO1  Pointer to 1st input text string involved in a Pseudo-  |
 |           substring                                               |
 |  PSEUDOR1 Pointer to 1st involved character of 1st involved       |
 |           string in Pseudo-substring                              |
 |  PSEUDO2  Pointer to last input text string involved in a Pseudo- |
 |           substring                                               |
 |  PSEUDOR2 Pointer to last involved character of last involved     |
 |           string in Pseudo-substring                              |
 |  PSEUDOE  Pointer to last character in sum total string of text   |
 |           for Pseudo-substring                                    |
 |  PSEUDOJ  Pointer for stepping backwards, to avoid splitting      |
 |           a word                                                  |
 |  PSEUPTR  Pointer used during construction of output string       |
 |  WORDMAXC Sum total of input text characters to transfer          |
 |  WORDRAIP Pointer to  input text variable list                    |
 |  WORDRAOP Pointer to output text variable list                    |
 |  WORDRPPS Pointer to sum total string for start of string to      |
 |           extract                                                 |
 |  WORDRPPE Pointer to sum total string for end   of string to      |
 |           extract                                                 |
 |  WORDRSLT Text string describing macro result.                    |
  ------------------------------------------------------------------*/

 /*------------------------------------------------------------------
 |  Embedded Macro: %PSEUDO   Pseudo-SUBSTRING Function              |
 |                                                                   |
 | Acts like SUBSTRING function on a long text string of             |
 | concatenated values in &INBASE.  One version is for strings of    |
 | length 1; the other is for all other lengths.                     |
  ------------------------------------------------------------------*/

 %macro PSEUDO(PSEUDOS,PSEUDOL,OUTVAR);
   &OUTVAR = '';

 /* Generate Pointer and Offset to first variable in INBASE.
 */

   PSEUDO1  = int((&PSEUDOS-1)/&INLEN)+1;
   PSEUDOR1 = mod(&PSEUDOS,&INLEN);
   if PSEUDOR1 = 0 then PSEUDOR1 = &INLEN;

 /* The use of %quote prevents the automatic %eval from causing a
    macro error.
 */
   %if %quote(&PSEUDOL) = 1          /* simple code if length is 1 */
      %then %do;
             WORDRAIP = PSEUDO1;
             &OUTVAR  = substr(&INARRAY(WORDRAIP),PSEUDOR1,1);
            %end;

      %else %do;
             PSEUDOE  = &PSEUDOS + &PSEUDOL - 1;
             PSEUDO2  = int((PSEUDOE-1)/&INLEN)+1;
             PSEUDOR2 = mod(PSEUDOE,&INLEN);
             if PSEUDOR2 = 0 then PSEUDOR2 = &INLEN;

            do WORDRAIP = PSEUDO1 to PSEUDO2;

               if WORDRAIP = PSEUDO1 and WORDRAIP = PSEUDO2
                 then do;
                           /* only one text variable involved */
                      &OUTVAR = substr(&INARRAY(WORDRAIP),PSEUDOR1,
                                        &PSEUDOL);
                      end;
                 else if WORDRAIP = PSEUDO1 and WORDRAIP < PSEUDO2
                        then do;

                     /* first of many vars - take to end of string */

                              &OUTVAR = substr(&INARRAY(WORDRAIP),
                                        PSEUDOR1);
                              PSEUPTR = &INLEN - PSEUDOR1 + 2;
                             end;
                 else if WORDRAIP > PSEUDO1 and WORDRAIP < PSEUDO2
                        then do;

                            /* middle variable - take it all */

                       substr(&OUTVAR,PSEUPTR) = &INARRAY(WORDRAIP);
                              PSEUPTR + &INLEN;
                             end;

                          /* last variable - take from beginning */

                        else do;
                              substr(&OUTVAR,PSEUPTR) =
                                  substr(&INARRAY(WORDRAIP),1,PSEUDOR2);
                             end;
             end;
            %end;
 %mend PSEUDO;

 /*------------------------------------------------------------------
 |  Start of SAS Code                                                |
  ------------------------------------------------------------------*/

 PSEUDOLC = ' ';       /* set length with assignment so no warning */
 PSEUDOFC = ' ';       /* assoc. with mult. lengths if mult. use   */
 drop WORDMAXC PSEUDOFC PSEUDOLC WORDRPPS WORDRPPE PSEUPTR
      WORDRAIP WORDRAOP PSEUDO1  PSEUDOR1 PSEUDO2  PSEUDOR2
      PSEUDOE  PSEUDOJ  WORDRSLT;
 array  &INARRAY {*}           &INBASE.1 -  &INBASE&INVARS;
 array &OUTARRAY {*} $&OUTLEN &OUTBASE.1 - &OUTBASE&OUTVARS;

 /* Clear out output vars, in case of RETAIN.
 */
 %if &CLEAROUT=YES %then %do;
    do WORDRAOP = 1 to dim(&OUTARRAY);
      &OUTARRAY(WORDRAOP) = ' ';
    end;
  %end;

 /* For efficiency, set up stop point; i.e. WORDMAXC
 */
 WORDRAOP = 0;

 /* Find first blank text line.
 */
 do WORDRAIP = 1 to &INVARS until(&INARRAY(WORDRAIP)=' ');
 end;
 if WORDRAIP = 1                 /* 1st input is blank */
   then goto &WORDEXIT;
   else do;
         WORDRAIP = WORDRAIP - 1;  /* Point at Last entry */
         WORDMAXC = length(&INARRAY(WORDRAIP)) + (WORDRAIP-1)*&INLEN;
        end;

 /* Initialize Pointers.
 */
 WORDRAIP = 1;
 WORDRAOP = 1;
 WORDRPPS = 1;

 /* Loop - until no more input text OR output text is full.
    Continuously track where in 8000+ bytes you are.
    Use %PSEUDO to do SUBSTRINGS on 8000+ bytes.
 */
 do until(0);

 /* Calculate ending point in Pseudo-String.  You already know the
    starting point.
 */
   WORDRPPE = WORDRPPS + &OUTLEN - 1;
   if WORDRPPE > WORDMAXC then WORDRPPE = WORDMAXC;

   %PSEUDO(WORDRPPE,1,PSEUDOLC);            /* Get Last char  */
   if WORDRPPE < WORDMAXC
     then do;
           %PSEUDO(WORDRPPE+1,1,PSEUDOFC);  /* Get First char  */
          end;
     else PSEUDOFC = ' ';

 /* If last char of current string AND first char of next string are
    both non-blank, then we're in the middle of a word!
 */
   if PSEUDOLC ª= ' ' and PSEUDOFC ª= ' ' then do;
     PSEUDOJ = 0;
     do until(0);
       PSEUDOJ +1;
       WORDRPPE + (-1);           /* Decrement pointer */
       %PSEUDO(WORDRPPE,1,PSEUDOFC);

 /* Look backwards for a blank until a blank is found, OR we've gone
    back 20 characters, OR we've gone back 1/2 a string.
 */
       if PSEUDOFC = ' ' then goto &WORDSKIP;
       if PSEUDOJ  = 20  then goto &WORDSKIP;
       if PSEUDOJ  > &OUTLEN/2 then goto &WORDSKIP;
     end;
&WORDSKIP:

 /* Set to full length if no blank was found; i.e. the word will be
    split!
 */
     if PSEUDOFC ª= ' ' then WORDRPPE = WORDRPPS + &OUTLEN - 1;
    end;        /* End of if PSEUDOLC ª= ' ' etc. */

 /* Now load value into OUTVAR.
 */
   %PSEUDO(WORDRPPS,(WORDRPPE-WORDRPPS+1),&OUTARRAY(WORDRAOP));

 /* Set value of next start at first non-blank character.
    This ensures that the output text is always left justified.
 */
   WORDRPPS = WORDRPPE;
   PSEUDOFC = ' ';
   do while(PSEUDOFC = ' ');
     WORDRPPS +1;
     if WORDRPPS > WORDMAXC then do;
                                  WORDRSLT = 'INVARS Empty';
                                  goto &WORDEXIT;
                                 end;
     %PSEUDO(WORDRPPS,1,PSEUDOFC);
   end;

 /* Increment OUTVAR Pointer.  Stop if full!
 */
   WORDRAOP +1;
   if WORDRAOP > &OUTVARS then do;
                                WORDRSLT = 'OUTVARS Full';
                                goto &WORDEXIT;
                               end;
 end;         /* End of Main Loop  */
&WORDEXIT:;
%EXIT:
%mend WORDRAP;

/* The following appears in Chapter 10, p. 164 */

Appendix B - VARCHAR Macro

  %macro VARCHAR(ARRAY,ARYLEN,ARYCNT);
    array &ARRAY(&ARYCNT) $ &ARYLEN &ARRAY.1-&ARRAY.&ARYCNT;
    input TL  ib2. @;        /* TL = Text Length */
    do J = 1 by 1 while(TL>0);
      CURLEN = min(200,TL);
      if J <= &ARYCNT then input &ARRAY(J) $varying200. CURLEN @;
                      else input +CURLEN @;
 /*------------------------------------------------------------------
 | The ELSE clause is needed because the array might fill up before  |
 | the pointer has been moved to the end of the input field.         |
  ------------------------------------------------------------------*/
      TL = TL - CURLEN;
    end;
 %mend;

----------
CHAPTER 11
----------

/* The following code appears in Chapter 11, p. 166 */

proc print data=sashelp.vcatalg label;
where libname="MASTER";
by libname memname ;
id libname memname ;
var objname objtype objdesc modified;
title "Example A: List of catalog entries in a SAS data library";
run;

/* The following code appears in Chapter 11, p. 168 */

proc print data=sashelp.vtable label noobs ;
label nvar="# of Vars" nobs="# of Obs" indxtype="Index Type"
  compress="Com- press";
id libname;
by libname;
var memname  memlabel crdate modate nvar nobs compress bufsize;
title "Example B: Dataset Summary";
run;
/*-----------------------------------------------------------------------*/
proc print data=sashelp.vcolumn label split=' ' width=min;
where libname="MASTER";
by libname memname;
id libname memname;
var name type length npos varnum label format informat;
title "Example C: List of data sets and variables in a SAS data library";
run;

/* The following code appears in Chapter 11, p. 169 */

proc report data=sashelp.voption nofs panels=2 headline;
column  optname setting ;
define  optname / display  width=12 flow;
define  setting / display  width=20 flow;
title "Example D: List of SAS System options";
run;

/* The following code appears in Chapter 11, p. 171 */

proc print data=sashelp.vextfl label;
id fileref;
var xpath xengine;
title "Example E: List of external files defined to current SAS session";
run;

----------
CHAPTER 13
----------

Online code is not available for Chapter 13, "How to Automate Table Typesetting
of SAS Output in Microsoft Word."  Questions and comments should be directed to
the authors, Rhena Seidman or Rick Aster.

----------
CHAPTER 14
----------

/* The following code appears in Chapter 14, pp. 220-221 */

data demog;

input age 1-3 gender $ 5 height 7-11 weight 13-17 marital $ 19 income 21-26
      region $ 28-29 title $ 31-75;

datalines;
 28 M  72.5 165.3 S  30000 SE Electrician
 45 F  65.4 118.6 M  45695 SW Assistant Editor and Senior Correspondent
 18 M  68.0 135.0 S  18000 MW Food Technician
 61 M  69.5 150.0 M  95000 NE Chief Executive Officer
 22 F  62.0 105.2 S  20500 NW Retail Salesperson
 35 F  75.0 160.0 S  45250 MW European Investments Consultant
 17 M  62.5 170.2 S   9000 SE Night Clerk/Student
 52 F  60.0 139.2 M  37000 NE Assistant for Accounting and Payroll
 26 M  70.5 165.0 S  25250 SE Carpenter
 32 M  61.0 140.0 S  16025 NE Entrepreneur
;

Example 1:

options ls=80 nodate nonumber;

proc format;
 value $gender 'F' = 'Female'
               'M' = 'Male';
 value $marital 'S' = 'Single'
                'M' = 'Married';
 value $region 'SW' = 'Southwest'
               'NE' = 'Northeast'
               'SE' = 'Southeast'
               'NW' = 'Northwest'
               'MW' = 'Midwest';
run;


proc report
 data = demog
 headline
 headskip
 spacing = 2;

 column ("--" region ("_Physical_" age gender height weight) marital income
                    title);

 define region/order 'Geographic Region' order=data width=10
 format=$region.;
 define age/display 'Age'  format=3. center;
 define gender/display 'Gender' format = $gender. width=6 left;
 define height/display 'Height (in)' format=5.1 width=6 center;
 define weight/display 'Weight (lbs)' format=5.1 width=6 center;
 define marital/display 'Marital Status' format=$marital.;
 define income/display 'Annual Income' format=dollar8.;
 define title/display 'Occupation' width=18 flow;

 title1 "Listing of Demographics"; run;

/* The following code appears in Chapter 14, p. 222 /*

Example 2:
options ls=80 nodate nonumber;

proc format;
 value $gender 'F' = 'Female'
               'M' = 'Male';
 value $marital 'S' = 'Single'
                'M' = 'Married';
 value $region 'SW' = 'Southwest'
               'NE' = 'Northeast'
               'SE' = 'Southeast'
               'NW' = 'Northwest'
               'MW' = 'Midwest';
run;

proc report
 data = demog
 headskip;

 column gender marital region,(age=agen age=agemean);
   define gender /group 'Gender' format=$gender.;
   define marital /group 'Marital Status' format=$marital.;
   define region /across center 'Age across the Region' '--'
format=$region.;
   define agen/analysis 'n ---' n f=3.;
   define agemean/analysis 'mean -----' mean f=5.1;

 break after gender /skip;

title 'Summary of Age';
run;

/* The following code appears in Chapter 14, pp. 223-224 /*

Example 3:

options ls=80 nodate nonumber missing = '0';

proc format;
 value $gender 'F' = 'Female'
               'M' = 'Male';
 value $marital 'S' = 'Single'
                'M' = 'Married';
 value $region 'SW' = 'Southwest'
               'NE' = 'Northeast'
               'SE' = 'Southeast'
               'NW' = 'Northwest'
               'MW' = 'Midwest';
run;

proc tabulate
 data = demog;

 class region marital gender;
 var age height weight;
 tables (region ='Geographic Region')*(marital='Marital Status')
        (all='Total')*(marital='')
        (all='Overall Total'),
             age='Age'*(n='n'*f=3. mean='Mean'*f=5.1)
             height='Height'*(n='n'*f=3. mean='Mean'*f=5.1)
             weight='Weight'*(n='n'*f=3. mean='Mean'*f=5.1)
             gender='Gender'*(n='n'*f=3. pctn<region*marital all*marital
                             all>='%'*f=4.1)
             /rts=30;

 format region $region. marital $marital. gender $gender.;
 title 'Tabulation of Demographics';
run;

/* The following code appears in Chapter 14, p. 225 /*

Example 4:

proc format;
 value $gender 'F' = 'Female'
               'M' = 'Male';
 value $marital 'S' = 'Single'
                'M' = 'Married';
 value $region 'SW' = 'Southwest'
               'NE' = 'Northeast'
               'SE' = 'Southeast'
               'NW' = 'Northwest'
               'MW' = 'Midwest';
run;

title 'Summary of Age';

proc sql;
 select region format = $region. label='Region',
        marital format = $marital. label = 'Marital Status',
        n(age) as nage format = 3. label = 'Age N',
        mean(age) as meanage format = 5.1 label = 'Age Mean',
        std(age) as stdage format = 5.1 label = 'Std Age'

  from demog

   group by region, marital
   order by region, marital;

/* The following code appears in Chapter 14, p. 226 /*

Example 5:

proc format;
 value $gender 'F' = 'Female'
               'M' = 'Male';
 value $marital 'S' = 'Single'
                'M' = 'Married';
 value $region 'SW' = 'Southwest'
               'NE' = 'Northeast'
               'SE' = 'Southeast'
               'NW' = 'Northwest'
               'MW' = 'Midwest';
run;

proc print
 data = demog
 noobs
 label
 split="*";

 var region age gender height weight marital income title;

 label  region = 'Geographic*Region*-----------'
        age = 'Age*---'
        gender = 'Gender*------'
        height = 'Height*(in)*------'
        weight = 'Weight*(lbs)*------'
        marital = 'Marital*Status*-------'
        income = 'Annual*Income*--------'
        title = 'Occupation*-----------------------------';
format region $region. gender $gender. height weight 5.1 marital $marital.
       income dollar8. title $45.;
title1 "Listing of Demographics";
title2 "------------------------------------"
       "-----------------------------------";
run;

/* The following code appears in Chapter 14, p. 228-229  /*

Example 6:

options ls=80 nodate nonumber;

proc format;
 value $gender 'F' = 'Female'
               'M' = 'Male';
 value $marital 'S' = 'Single'
                'M' = 'Married';
 value $region 'SW' = 'Southwest'
               'NE' = 'Northeast'
               'SE' = 'Southeast'
               'NW' = 'Northwest'
               'MW' = 'Midwest';
run;

proc sort
 data=demog;
  by gender marital region;

proc means
 data=demog;
  by gender marital region;

  var age;
  output out=demsum n=n mean=mean;
run;

data _null_;
 set demsum;
  by gender marital;

  file print header=H;

  array ns {5} _temporary_;
  array means {5} _temporary_;

  if first.marital then
      do i = 1 to 5;
       ns{i} = 0;
       means{i} = 0;
      end;

     index = (region = 'MW')*1 + (region = 'NE')*2 + (region = 'NW')*3 +
             (region = 'SE')*4 + (region = 'SW')*5;

     ns{index} = n;
     means{index} = mean;

     if first.gender then
      put @4 gender $gender. @;

     if first.marital then
      put @12 marital $marital. @;

     if last.marital then
      put @21 ns{1} 3. @26 means{1} 5.1
          @33 ns{2} 3. @38 means{2} 5.1
          @45 ns{3} 3. @50 means{3} 5.1
          @57 ns{4} 3. @62 means{4} 5.1
          @69 ns{5} 3. @74 means{5} 5.1;

     if last.gender then
       put;

   return;

   H: put /
      @39 'Age across the Region' /
      @21 '----------------------------------------------------------' /
      @22 'Midwest    Northeast   Northwest   Southeast   Southwest' /
      @12 'Marital    n   mean    n   mean    n   mean    n   mean    n   mean'
           /
      @4 'Gender Status --- ----- --- ----- --- ----- --- ----- ---'
         '-----'/;
   return;
   title 'Summary of Age';
   run;

/* The following code appears in Chapter 14, pp. 230-232 /*

Example 7:

options ls=80 nodate nonumber ps=20;

proc format;
 value $gender 'F' = 'Female'
               'M' = 'Male';
 value $marital 'S' = 'Single'
                'M' = 'Married';
 value $region 'SW' = 'Southwest'
               'NE' = 'Northeast'
               'SE' = 'Southeast'
               'NW' = 'Northwest'
               'MW' = 'Midwest';
run;


%macro footer(L) / parmbuff;

  footnote "PAGEHERE ";  **** paging footnote for PROC;
  run;

  proc printto;

  %let repfile=%scan(&syspbuff,2,|);
  %let wide=%scan(&syspbuff,3,|);

  data lines;
   infile "&repfile"
          lrecl=&wide  missover recfm=v noprint pad linesize=&wide end=eof;


   input all $char&wide..;

   drop width startat;
   retain width 0 startat;

   index + 1;

   **** determine width and beginning column of output;
   if length(trim(left(all))) > width and
      (index(all,'---') > 0 or index(all,'___') > 0) then
    do;
     startat = indexc(all,'_-');
     width = length(trim(left(all))) - 1;
    end;

   placem = indexc(all,'012345678901234567890-=_+',
                          'qwertyuiopasdfghjklzxcvbnm',
                          'QWERTYUIOPASDFGHJKLZXCVBNM',
                          '{[}]:;|\><,.?/',
                          '"');

   /**** DRAW UNDERLINES ****/
   if index(all,"PAGEHERE") or eof then
    do;
     all = repeat("-",width);
     placem = startat;
     output;
     if eof then                        /**** LAST PAGE ****/
      do;
       all = repeat("-",width);
       placem = startat;
       output;
      end;
     else                            /**** BOTTOM OF ANY BUT LAST PAGE ****/
      do;
       all = '(Continued)';
       placem = startat + width - 10;
       output;
      end;

     /**** PLACE FOOTNOTES ****/
                %let stop=%length(&syspbuff);
                %do i=4 %to &stop;
                 %let foot =%scan(&syspbuff,&i,|);
                 %if "&foot" ne ")" %then
                  %do;
                   all = "&foot";
                   placem = startat;
                   output;
                  %end;
                 %else %let i=&stop;
                %end;
               end;
              else output;
             run;

             proc sort

              data=lines;

               by index;


             /**** OUTPUT FILE ****/
             data _null_;

              set lines;


               file "&repfile" lrecl= &wide recfm=f pad linesize= &wide new;
               put @placem all;
             run;


           %mend footer;


           proc printto
             print='repnul.lis' new;

           proc report
            data = demog
            headline
            headskip
            spacing = 2;

            column ("--" region ("_Physical_" age gender height weight) marital income
                       title);

            define region/order 'Geographic Region' order=data width=10
           format=$region.;
            define age/display 'Age'  format=3. center;
            define gender/display 'Gender' format = $gender. width=6 left;
            define height/display 'Height (in)' format=5.1 width=6 center;
            define weight/display 'Weight (lbs)' format=5.1 width=6 center;
            define marital/display 'Marital Status' format=$marital.;
            define income/display 'Annual Income' format=dollar8.;
            define title/display 'Occupation' width=18 flow;

           title1 "Listing of Demographics *";
           %footer(|repnul.lis|80|* Data collected for 1993.|);
           run;




----------
CHAPTER 15
----------

/* The following code appears in Chapter 15, pp. 241-242 */

*** Chapter 15 sas code - identified by names used in chapter ***;
****** format.sas - formats for employee opinion survey ***;
options pagesize=55 linesize=80 nodate nonumber;
libname library 'c:\mysas\satech';
proc format library=library fmtlib;

*** informat for Section 1 questions;
   invalue yv '1'=1 '3'=0 '5'=. '7'=.;
*** informat for Section 2 questions;
   invalue rv '1'=0 '3'=1 '5'=2 '7'=3 '9'=.;

*** pictures used in final reports;
   picture confl low-high='0009.99%' (prefix='(');
   picture confu low-high='0009.99% )';
   picture estv low-high='0009.99%';
   picture conf2l low-high='0009.9' (prefix='(');
   picture conf2u low-high='0009.9 )';
   picture est2v low-high='0009.9';

*** output formats for identifiers of questions in Sections 1 and 2;
   value $enamev 's1q1'='Sufficient financial info - planning?'
                 's1q2'='Benefits explained sufficiently?'
                 's1q3'='Materials ordered & received?'
                 's1q4'='Publications create positive image?'
                 's2q1'='Food Service'
                 's2q2'='Cashiers'
                 's2q3'='Security'
                 's2q4'='Personnel'
                 's2q1p0'='Food Service: Overall'
                 's2q1p1'='            : Helpful'
                 's2q1p2'='            : Timely Response'
                 's2q2p0'='Cashiers    : Overall'
                 's2q2p1'='            : Helpful'
                 's2q2p2'='            : Timely Response'
                 's2q3p0'='Security    : Overall'
                 's2q3p1'='            : Helpful'
                 's2q3p2'='            : Timely Response'
                 's2q4p0'='Personnel   : Overall'
                 's2q4p1'='            : Helpful'
                 's2q4p2'='            : Timely Response'
                 's3q1'='Employee Type'
                 's3q2'='Status'
                 's3q3'='Assignment Area'
                 's3q4'='Campus'
                 's3q5'='Yrs at Campus'
                 's3q6'='Yrs in System'
;

*** output format for rating scale in Section 2;
   value s2ratev 1='Never' 2='Sometimes' 3='Most Times' 4='Always';
*** output format for parts of questions in Section 2;
   value s2catv 1='Helpful' 2='Timely Response';
*** output format for responses to question in Section 3;
   value s3ev 11='Faculty'  13='Staff'  15='Not Reported'
              21='Full-time'  23='Part-time'  25='Not Reported'
              31='Academic Programs/Services'
              33='Student Services'
              35='Maintenance'
              37='Administration'
              39='Not Reported'
              41='Main'
              43='South Center'
              45='Other'
              47='Not Reported'
;
proc catalog c=library.formats et=format;
   contents;
   run;
   quit;

/* The following code appears in Chapter 15, pp. 242-243 */

******************* first.sas *********************************

  This program sets the parameters for all survey programs.

  Check each program for additional changes required before
     execution.

*******************************************************************;

options pagesize=55 linesize=80 nodate nonumber;

*** identify locations of libraries and raw data file
    and give names to SAS data sets created in programs;

libname library 'c:\mysas\satech'; *** location of SAS format library;
libname out 'c:\mysas\satech';  *** location of SAS data sets;
%let rawdsn=c:\mysas\satech\scsurvey.dat; *** name and location of
     the raw data file;

%let dsn1=employ; *** name used for SAS data set created
     in DATA.SAS;
%let dsnout=emp; *** prefix used for SAS data sets that store
     estimates - use maximum of 4 characters;

*** set parameters based on number of questions;

%let sec1=4;  *** number of questions in section 1;
%let sec2=4;  *** number of questions in section 2;
%let s2part=2; *** # of parts to each question in section 2;
%let sec3=6;  *** number of questions in section 3;
%let sec3t1=4; *** number of categorical questions in section 3;
%let sec3t2=2; *** number of quantitative questions in section 3;

*** set parameters that hold population and sample size;

%let npop=273; %* population size;
%let nsamp=94; %* sample size;

*** create two title statements for the final reports;
title1 '1991 Employee Opinion Survey';
title2 'Area Technical College';

/* The following code appears in Chapter 15, pp. 244-246 */

******************** edit.sas *********************************

The location and name of the raw data file is given in FIRST.SAS.

Customize PROC FORMAT to reflect the keying scheme used.

This program may require significant changes to reflect a specific survey.

*******************************************************************;

%let prefix=s2q; *** prefix for Section 2 questions;

%macro section2(start,stop,question);
   %do i=&start %to &stop;
         &prefix&i.p1-&prefix&i.p&question
      %end;
%mend section2;

proc format;
   value  r5v 1,3,5='x';
   value r7v 1,3,5,7='x';
   value r9v 1,3,5,7,9='x';
run;

data temp;
   array chk1 {*} s1q1-s1q&sec1;
   array chk2 {*} %section2(1,&sec2,&s2part);
   retain ecount 0;
   infile "&rawdsn" end=eof;  *** name and location of data file;
   file print;
   input @1 id1 3. @5 (s1q1-s1q&sec1) (1. +1) /
      @1 id2 3. @5 ( %section2(1,&sec2,&s2part)) (1. 1. +1) /
      @1 id3 3. @5 s3q1-s3q&sec3 ;

*** initialize error counter and edit for lost data;
   count=0;
   if id1^=id2 or id2^=id3 then do;
      count=count+1;
      put / 'DATA CARD MISSING: ' id1= id2= id3=;
      lostcard;
      end;

*** edit Section 1 data;
   do i=1 to hbound(chk1);
      if put(chk1{i},r7v.)^='x' then do;
         count=count+1;
         if count=1 then put / id1= chk1{i}=;
         else put '      ' chk1{i}=;
         end;
      end;

*** edit Section 2 data;
   do i=1 to hbound(chk2);
      if put(chk2{i},r9v.)^='x' then do;
         count=count+1;
         if count=1 then put / id1= chk2{i}=;
         else put '      ' chk2{i}=;
         end;
      end;

*** edit Section 3 data;
   if put(s3q1,r5v.)^='x' then do;
         count=count+1;
         if count=1 then put / id1= s3q1=;
         else put '      ' s3q1=;
         end;
   if put(s3q2,r5v.)^='x' then do;
         count=count+1;
         if count=1 then put / id1= s3q2=;
         else put '      ' s3q2=;
         end;
   if put(s3q3,r9v.)^='x' then do;
         count=count+1;
         if count=1 then put / id1= s3q3=;
         else put '      ' s3q3=;
         end;
**** edits for s3q4, s3q5 and s3q6 must be changed to reflect coding used
     at each institution.;
   if put(s3q4,r7v.)^='x' then do;
         count=count+1;
         if count=1 then put / id1= s3q4=;
         else put '      ' s3q4=;
         end;

*** logical edits;
   if s3q5>s3q6 then do;
         count=count+1;
         if count=1 then put / id1= s3q5= s3q6=;
         else put '      ' s3q5= s3q6=;
         end;

   ecount=ecount+count;
   if count>0 then put /  '   TOTAL ERRORS FOUND= ' count / ;
   if eof and ecount=0 then put / 'NO ERRORS FOUND IN DATA SET' / ;
run;

/* The following code appears in Chapter 15, pp. 246-247 */

******************** data.sas *********************************

     This program reads the raw data file and creates the SAS data
file &DSN1.SSD on the library defined in FIRST.SAS.

        Provide the correct prefix for Section 2 variables in the %LET statement.

     The SAS data set &DSN1.SSD is used in all the programs
that produce reports for the employee survey.
*******************************************************************;

%let prefix=s2q; *** prefix used for Section 2 variables;

%macro section2(start,stop,question);
   %do i=&start %to &stop;
         &prefix&i.p1-&prefix&i.p&question
      %end;
%mend section2;

%macro sec2;
   %do i=1 %to &sec2;
      if nmiss(of &prefix&i.p1-&prefix&i.p&s2part)=0 then
         &prefix&i=mean(of &prefix&i.p1-&prefix&i.p&s2part);
      %end;
   %mend sec2;

data out.&dsn1;
   array chk1 {*} s1q1-s1q&sec1;
   array chk2 {*} %section2(1,&sec2,&s2part);
   retain ecount 0;
   infile "&rawdsn" end=eof;  *** name and location of data file;
   input @1 id1 3. @5 (s1q1-s1q&sec1) (yv. +1) /
      @1 id2 3. @5 ( %section2(1,&sec2,&s2part)) (rv. rv. +1) /
      @1 id3 3. @5 s3q1-s3q&sec3;
   %sec2
run;

/* The following code appears in Chapter 15, pp. 247-248 */

*********************** s1p1.sas ********************************
   This program produces estimates of the percentage of respondents
   that answered yes to each question in Section 1 of the Employee
   Survey.  The program also produces estimates of the
   95% confidenceinterval.
*******************************************************************;

%let prefix=s1q; %* variable name prefix Section 1;

proc means data=out.&dsn1   noprint;
   var &prefix.1-&prefix&sec1;
   output out=temp n=n1-n&sec1 mean=est1-est&sec1
      stderr=se1- se&sec1;
run;

data last (keep=name n est lower upper);
   length name $ 6.;
   array tn {*} n1-n&sec1;
   array test {*} est1-est&sec1;
   array tse {*} se1-se&sec1;
   set temp;
   wt=sqrt((&npop-&nsamp)/&npop);
   do i=1 to &sec1;
      name="&prefix" || left(i);
      n=tn{i};
      est=test{i};
      dif=2*wt*tse{i};
      lower=max(round((est-dif)*100,.01),0);
      upper=min(round((est+dif)*100,.01),100);
      est=round(est*100,.01);
      output;
      end;
run;

proc print data=last split='*' d uniform;
   var n est lower upper;id name;
   format est estv. lower confl. upper confu. name $enamev.;
   label n='Number*Responding'
         est='% With*Yes*Response'
         lower='95%*Confidence*Lower*Endpoint'
         upper=' *Interval*Upper*Endpoint'
         name='Service';
title3 'Section 1: Overall Assessment of Services';
title4 'Percentage of Respondents Indicating Yes';
run;

data out.&dsnout.s1p1 (label='estimates for section 1');
   set last;
run;

/* The following code appears in Chapter 15, pp. 250-251 */

*********************** s2p1.sas ********************************
   This program produces estimates of the average rating given by
   respondents to each part of each question in Section 2 of
   the Employee Opinion Survey.  The average overall rating
   is also produced, as are the estimates of the
   95% confidence intervals.

   Verify that the values in the %LET statements for LOWR and HIGHR
   are correct for your survey.
******************************************************************;

%let upper=%eval(&sec2*%eval(&s2part+1));  %* quest*(parts+1);
%let lowr=0;  %* value of lowest rating for part;
%let highr=3;  %* value of highest rating for part;
%let prefix=s2q; %* variable name prefix for Section 2;
%let pagechk=%eval(40/%eval((&s2part+1)*2));

%macro listit;
   %do i=1 %to &sec2;
      &prefix&i &prefix&i.p1-&prefix&i.p&s2part
      %end;
   %mend listit;

proc means data=out.&dsn1   noprint;
   var %listit  ;
   output out=temp n=n1-n&upper mean=est1-est&upper
      stderr=se1- se&upper;
run;

data last (keep=page name n est lower upper);
   length name $ 8.;
   retain page 1 wt;
   array test {*} est1-est&upper;
   array tse {*} se1-se&upper;
   array tn {*} n1-n&upper;
   set temp;
   wt=sqrt((&npop-&nsamp)/&npop);
   do i=1 to &sec2;
      j=((&s2part+1)*(i-1)+1);
      do k=0 to &s2part;
         m=j+k;
         name="&prefix" || left(i) || "p" || left(k);
         n=tn{m};
         est=test{m};
         dif=2*wt*tse{m};
         lower=max(round((est-dif),.1),&lowr);
         upper=min(round((est+dif),.1),&highr);
         est=round(est,.1);
         output;
         end;
      if mod(i,&pagechk)=0 then page=page+1;
      end;
run;

proc print data=last split='*' d uniform;
   var n est lower upper;id name;
   format est est2v. lower conf2l. upper conf2u. name $enamev.;
   label n='Number*Responding'
         est='Average*Rating'
         lower='95%*Confidence*Lower*Endpoint'
         upper=' *Interval*Upper*Endpoint'
         name='Group: Characteristic'
         page='Page Number'
;
   by page notsorted;
   pageby page;
title3 'Section 2: Average Ratings of Service Groups';
title4 'Ratings: 0-Never, 1-Occasionally, 2-Most of the Time, 3-Always';
title5 'Overall Rating=Average of Ratings for All Characteristics : Range 0-3';
run;

data out.&dsnout.s2p1 (label='estimates of average ratings:sec 2');
   set last;
run;

/* The following code appears in Chapter 15, pp. 252-253 */

******************** s2p2.sas ********************************
   This program produces estimates of the median rating given by
   respondents to each part of each question in Section 2 of
   the Employee Opinion Survey.  The median overall rating
   is also produced as are the 25th. and 75th. percentiles.

   Verify that the values in the %LET statements for LOWR and HIGHR
   are correct for your survey.
*****************************************************************;

%let upper=%eval(&sec2*%eval(&s2part+1));
%let highr=3; %* highest rating for a part;
%let lowr=0; %* lowest rating for a part;
%let prefix=s2q; %* variable name prefix for Section 2;
%let pagechk=%eval(40/%eval((&s2part+1)*2));

%macro listit;
   %do i=1 %to &sec2;
      &prefix&i &prefix&i.p1-&prefix&i.p&s2part
      %end;
   %mend listit;

proc univariate data=out.&dsn1 noprint;
   var %listit  ;
   output out=temp n=n1-n&upper median=est1-est&upper
      q1=q1v1- q1v&upper q3=q3v1-q3v&upper;
run;

data last (keep=page name n est lower upper);
   length name $ 8.;
   retain page 1;
   array tn {*} n1-n&upper;
   array test {*} est1-est&upper;
   array tq1 {*} q1v1-q1v&upper;
   array tq3 {*} q3v1-q3v&upper;
   set temp;
   do i=1 to &sec2;
      j=((&s2part+1)*(i-1)+1);
      do k=0 to &s2part;
         m=j+k;
         name="&prefix" || left(i) || "p" || left(k);
         n=tn{m};
         est=round(test{m},.1);
         lower=max(round(tq1{m},.1),&lowr);
         upper=min(round(tq3{m},.1),&highr);
         output;
         end;
      if mod(i,&pagechk)=0 then page=page+1;
      end;
run;

proc print data=last split='*' d uniform;
   var n est lower upper;id name;
   format est est2v. lower conf2l. upper conf2u. name $enamev.;
   label n='Number*Responding'
         est='Median*Rating'
         lower='25th*Percentile'
         upper='75th*Percentile'
         name='Group: Characteristic'
         page='Page Number'
;
   by page notsorted;
   pageby page;
title3 'Section 2: Median Ratings of Service Groups';
title4 'Ratings: 0-Never, 1-Occasionally, 2-Most of the Time, 3-Always';
title5 'Overall Rating=Average of Ratings for All Characteristics : Range 0-3';
run;

data out.&dsnout.s2p2 (label='median estimates for section 2');
   set last;
run;

/* The following code appears in Chapter 15, pp. 255-256 */

*********************** s2p3.sas ********************************
   This program produces estimates for Section 2
   of the Employee Opinion Survey.

   For each question, the percentage of employees responding
   to each category and the 95% confidence intervals are estimated.

   Verify that the values in the %LET statement for CATEGORY and
   PREFIX arecorrect for your survey.
******************************************************************;

%let category=4;  %* number of response categories;
%let top1=%eval(&sec2 * &s2part);
%let top2=%eval(&sec2 * &s2part * &category);
%let prefix=s2q; %* variable name prefix;
%let pagechk=%eval(40/%eval((&s2part * &category * 2)+3));

%macro sec2;
    %do i=1 %to &sec2;
       &prefix&i.p1-&prefix&i.p&s2part
       %end;
   %mend sec2;

data one;
   set out.&dsn1 (keep=%sec2) end=eof;
   array temp {&sec2,&s2part} %sec2;
   array nt {&sec2,&s2part} n1-n&top1;
   array counts {&sec2,&s2part,&category} ct1-ct&top2;
   retain page 1 n1-n&top1 ct1-ct&top2 0 wt;
   length name $ 4;
   if _n_=1 then do;
      wt=sqrt((&npop-&nsamp)/&npop);
      end;
   do i=1 to &sec2;
      do i2=1 to &s2part;
         if temp{i,i2}^=. then do;
             j=temp{i,i2}+1;
             counts{i,i2,j}=counts{i,i2,j} + 1;
             nt{i,i2}=nt{i,i2} + 1;
             end;
         end;
      end;
   if eof then do i=1 to &sec2;
      name="&prefix" || left(i) ;
      do i2=1 to &s2part;
         part=i2;
         do j=1 to &category;
            response=j;
            n=counts{i,i2,j};
            est=counts{i,i2,j}/nt{i,i2} *100;
            dif=2*wt*sqrt(est*(100-est)/(nt{i,i2}-1));
            lower=max(round((est-dif),.01),0);
            upper=min(round((est+dif),.01),100);
            est=round(est,.01);
            output;
            end;
         end;
      if mod(i,&pagechk)=0 then page=page+1;
      end;
run;

proc print data=one split='*' d uniform;
   var response n est lower upper;id part;
   by page notsorted name notsorted;
   pageby page;
   format est estv. lower confl. upper confu. name $enamev.
         response s2ratev. part s2catv.;
   label n='Number*Responding'
         est='*% With*Response'
         lower='95%*Confidence*Lower*Endpoint'
         upper=' *Interval*Upper*Endpoint'
         name='Employee Group'
         response='Response';
title3 'Section 2: Percent of Ratings in Each Category';
title4 'Provided By Service Groups';
run;

data out.&dsnout.s2p3 (label='estimates by category for section 2');
   set one;
run;

/* The following code appears in Chapter 15, pp. 258-261 */

*********************** s3p1.sas ********************************
   This program produces estimates for Section 3 of the
   Employee Opinion Survey.

   For categorical questions, the percentage of employees responding
   to each category and the 95% confidence intervals are estimated.

   For quantitative questions, the mean value and the
   95% confidence interval are estimated.

   Verify that the values in the %LET statements for T1START,
   T1STOP, T2START and T2STOP are correct for your survey.
*****************************************************************;

%let prefix=s3q; %* variable name prefix for Section 3;
%let t1start=1; %* question number of first categorical value;
%let t1stop=4; %* question number of last categorical value;
%let t2start=5; %* question number of first quantitative value;
%let t2stop=6; %* question number of last quantitative value;

*** Part 1 to produce estimates for Section 3 categorical variables
*** starts here.;

%macro flip;
   %do i=&t1start %to &t1stop;
      proc freq data=out.&dsn1;
          tables &prefix&i / out=temp noprint;
      run;

      data countit (keep=ntotal);
         set temp end=eof;
         retain ntotal 0;
         ntotal=ntotal + count;
         if eof then do;
            put "for &prefix&i, " ntotal;
            output;
            end;
      run;

      data temp2 (keep=name response n est lower upper);
         length name $ 5.;
         set temp;
         if _n_=1 then do;
            set wts;
            set countit;
            end;
         name="&prefix" || "&i";
         response=(&i*10) + &prefix&i;
         n=count;
         est=percent;
         dif=2*wt*sqrt(percent*(100-percent)/(ntotal-1));
         lower=max(round((est-dif),.01),0);
         upper=min(round((est+dif),.01),100);
         est=round(est,.01);
         output;
      run;

      %if &i=1 %then %do;
         data last;set temp2;
         %end;
      %else %then %do;
         data last;set last temp2;
         %end;
         run;
      %end;
   %mend flip;

 data wts;
    wt=sqrt((&npop-&nsamp)/&npop);
    put wt=;
 run;

%flip

proc print data=last split='*' d uniform;
   var n est lower upper;id response;
   by name notsorted;
   format est estv. lower confl. upper confu. name $enamev.
         response s3ev.;
   label n='Number*Responding'
         est='*% With*Response'
         lower='95%*Confidence*Lower*Endpoint'
         upper=' *Interval*Upper*Endpoint'
         name='Question'
         response='Response'
;
title3 'Section 3: Demographics';
run;

*** Part 2 to produce estimates for Section 3 quantitative
*** variables starts here.;

proc means data=out.&dsn1   noprint;
   var &prefix&t2start-&prefix&t2stop;
   output out=temp n=n&t2start-n&t2stop mean=est&t2start-est&t2stop
      stderr=se&t2start-se&t2stop;
run;

data last2 (keep=name n est lower upper);
   length name $ 5.;
   array tn {&t2start:&t2stop} n&t2start-n&t2stop;
   array test {&t2start:&t2stop} est&t2start-est&t2stop;
   array tse {&t2start:&t2stop} se&t2start-se&t2stop;
   set temp;
   wt=sqrt((&npop-&nsamp)/&npop);
   do i=&t2start to &t2stop;
      name="&prefix" || left(i);
      n=tn{i};
      est=test{i};
      dif=2*wt*tse{i};
      lower=round((est-dif),.1);
      upper=round((est+dif),.1);
      est=round(est,.1);
      output;
      end;
run;

proc print data=last2 split='*' d uniform;
   var n est lower upper;id name;
   format est est2v. lower conf2l. upper conf2u. name $enamev.;
   label n='Number*Responding'
         est='Average'
         lower='95%*Confidence*Lower*Endpoint'
         upper=' *Interval*Upper*Endpoint'
         name='Question'
;
title3 'Section 3: Demographics';
run;

data out.&dsnout.s3p1 (label='estimates for section 3-categorical');
   set last; run;

data out.&dsnout.s3p2 (label='estimates for section 3-quantitative');
   set last2; run;


----------
CHAPTER 18
----------

/* The following code appears in Chapter 18, pp. 312-315 */

libname forecast 'd:\sasuser\forecast';

%macro iter (i, state, sale, titl, inf1, inf2);

/*** This null data step creates some state-specific macro variables used
subsequently in the analysis and in title statements.  The data step creates
four macro variables (&lt1, &lr1, &lt2, &lr2) using either the %LET statement or
the SYMPUT routine, dep ending on an &IF--&THEN condition.  The values of the
%LET-created variables are conditional on the existence of pre-defined
inflection points in the dependent variable over time.  These inflection points
are contained in the macro parameters &inf1 and &i nf2. ***/

  data _null_;
    set forecast.sales;
      where statenum = &i;
    time = year   1974;
    ltime = log(time);
    lc = log(cust);
    if (&inf1=0) then do;
      %let lt1=0;  %let lr1=0;
      end;
    else if (year=&inf1) then do;
      call symput ('lt1', put(ltime, 8.2));
      call symput ('lr1', put(lc, 8.2));
      end;
    if (&inf2=0) then do;
      %let lt2=0;  %let lr2=0;
      end;
    else if (year=&inf2) then do;
      call symput ('lt2', put(ltime, 8.2));
      call symput ('lr2', put(lc, 8.2));
      end;
  run;

/*** The next data step creates the analysis variables for the OLS regression
and the autoregressive correction analyses for each state. It transforms all the
dependent and independent variables into their logarithmic values.  It also
constructs the piece wise variables ltim&inf1, ltimeinf2, lc&inf1, and lc&inf2,
which take advantage of the macro variables defined in the null data step above.
***/

  data sales&i;
    set forecast.sales;
      where statenum = &i;
    lc = log(cust);
    if year ge &inf1 then bin1=1;
      else bin1=0;
    if year ge &inf2 then bin2=1;
      else bin2=0;
    time = year   1974;
    ltime = log(time);
    ltim&inf1 = (ltime   &lt1) * bin1;
    ltim&inf2 = (ltime   &lt2) * bin2;
    lc&inf1 = (lc   &lr1) * bin1;
    lc&inf2 = (lc   &lr2) * bin2;
    lt&sale.&i = log(t&sale);
  run;

/*** This procedure runs the OLS regression. ***/

proc reg data=sales&i;
  model t&sale.&i = density lden cust lc time ltime /
    selection=adjrsq adjrsq b stb vif;
  title "Cumulative sales OLS forecast: test for &state, &titl";
run;

/*** The next set of procedures runs the regression analyses with autoregressive
correction (AUTOREG).  The choice between the three available models depends on
whether the data for each state and type of sales (new versus repeat sales)
involves zero, one , or two historical inflection points.  The output datasets
from each model create three additional variables: the predicted value, the
upper 95% confidence limit, and the lower 95% confidence limit. ***/

%if (&inf1=0 and &inf2=0) %then %do;
  proc autoreg data=sales&i;
    model lt&sale.&i = ltime lc / backstep nlag=3;
    where statenum = &i;
    output out=reg&sale.&i p=lp&sale.&i lclm=ll&sale.&i uclm=lu&sale.&i;
    title 'Cumulative Sales (Log Log Piecewise AutoRegressive) Forecast Model';
    title2 "Western Division: &state, &titl";
    title3 "Log Log model: No Slope Changes";
  run;
  %end;

%else %if (&inf1>0 and &inf2=0) %then %do;
  proc autoreg data=sales&i;
    model lt&sale.&i = ltime ltim&inf1 lc lc&inf1 / backstep nlag=3;
    where statenum = &i;
    output out=reg&sale.&i p=lp&sale.&i lclm=ll&sale.&i uclm=lu&sale.&i;
    title 'Cumulative Sales (Log Log Piecewise AutoRegressive) Forecast Model';
    title2 "Western Division: &state, &titl";
    title3 "Log Log model: Slope Changes in: &inf1";
  run;
  %end;
%else %if (&inf1>0 and &inf2>0) %then %do;
  proc autoreg data=sales&i;
    model lt&sale.&i = ltime ltim&inf1 ltim&inf2 lc lc&inf1 lc&inf2 / backstep nlag=3;
    where statenum = &i;
    output out=reg&sale.&i p=lp&sale.&i lclm=ll&sale.&i uclm=lu&sale.&i;
    title 'Cumulative Sales (Log Log Piecewise AutoRegressive) Forecast Model';
    title2 "Western Division: &state, &titl";
    title3 "Log Log model: Slope Changes in: &inf1 &inf2";
  run;
  %end;

/*** This sorts the output datasets by year to ensure proper ploting: ***/

proc sort data=reg&sale.&i;  by year;  run;

/*** This data step uses the EXP() function to convert the logarithmic (i.e., base e) regression parameters back into their regular (i.e., base 10) values. ***/

data pr&sale.&i;
  set reg&sale.&i;
  array in {4} lt&sale.&i lp&sale.&i ll&sale.&i lu&sale.&i;
  array out {4} t&sale.&i p&sale.&i l&sale.&i u&sale.&i;
  do i=1 to 4;
    out(i) = exp(in(i));
    end;
run;

/*** This resets any graphics options different from the defaults. ***/

goptions reset=all;

/*** This series of graphics statements set up the plotting symbols and
interpolation options (symbol statements), the axis labels, and legend options.
***/

symbol1 l=1 w=2 i=join h=1.5 v=dot c=black;
symbol2 l=1 w=2 i=join h=1.5 v=square c=black;
symbol3 l=2 w=1 i=join h=1 v=none c=black;
symbol4 l=2 w=1 i=join h=1 v=none c=black;
axis1 label=(h=1 j=l 'Cumulative' j=l 'Sales');
legend1 frame label=(h=1.5 "&state") across=2
  value=(h=1 t=1 'Actual' t=2 'Predicted' t=3 'Lower Forecast Range'
    t=4 'Upper Forecast Range');

/*** This states my preferred graphics options, including the graphics device
driver, the page orientation, the font selections for titles and text, and
turning off the prompt that asks the user to check the printer (since I work on
a network and this mes sage is unnecessary for my workstation). ***/

goptions device=ps600 rotate=portrait ftitle=hwpsl007 ftext=hwpsl005 fby=hwpsl005 noprompt;

/*** This GPLOT procedure plots the historical and predicted sales, as well as
confidence limits around the predicted value.  The procedure also draws a
vertical dashed reference line at the point on the plot where the historical
period ends and the forec ast horizon begins.  The title statements define the
state and sales type (new versus repeat), as well as creating a legend for the
lines plotted. ***/

proc gplot data=pr&sale.&i;
  plot (t&sale.&i p&sale.&i l&sale.&i u&sale.&i) * year /
    overlay legend=legend1 vaxis=axis1 href=1992 lhref=20;
  title1 h=2 ;
  title2 h=2 "Actual vs. Predicted &titl";
  title3 h=1.5 "Western Division: &state";
run;
quit;

%mend iter;

/*** The PROC PRINTTO statements define a physical file as the location in which
to save the printed output from PROC REG and PROC AUTOREG is to be saved.  The
macro calls specify the macro parameters for each iteration of the macro-driven
program. ***/

proc printto new print='d:\ a';  run;

%iter (1, Oregon, new, New Sales, 1982, 0)
%iter (2, Washington, new, New Sales, 1982, 0)
%iter (3, Idaho, new, New Sales, 1985, 0)
%iter (4, Montana, new, New Sales, 1982, 0)
%iter (5, California, new, New Sales, 1982, 0)
%iter (6, Wyoming, new, New Sales, 1982, 1986)

%iter (1, Oregon, rpt, Repeat Sales, 1982, 0)
%iter (2, Washington, rpt, Repeat Sales, 1979, 0)
%iter (3, Idaho, rpt, Repeat Sales, 1980, 1982)
%iter (4, Montana, rpt, Repeat Sales, 0, 0)
%iter (5, California, rpt, Repeat Sales, 0, 0)
%iter (6, Wyoming, rpt, Repeat Sales, 1982, 0)

proc printto;  run;



















