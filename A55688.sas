 /*-------------------------------------------------------------------*/
 /*       Your Guide to Survey Research Using the SAS(R) System       */
 /*                   by Archer R. Gravely                            */
 /*     Copyright(c) 1998 by SAS Institute Inc., Cary, NC, USA        */
 /*               SAS Publications Order # 55688                      */
 /*                    ISBN 1-58025-146-3                             */
 /*-------------------------------------------------------------------*/
 /*                                                                   */
 /* This material is provided "as is" by SAS  Institute Inc.  There   */
 /* are no warranties, express or implied, as to merchantability or   */
 /* fitness for a particular purpose regarding the materials or code  */
 /* contained herein. The Institute is not responsible for errors     */
 /* in this  material as it now exists or will exist, nor does the    */
 /* Institute provide technical support for it.                       */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
 /* Questions or problem reports concerning this material may be      */
 /* addressed to the author:                                          */
 /*                                                                   */
 /*    Archer R. Gravely                                             */
 /*    Director of Institutional Research                             */
 /*    UNC Asheville                                                  */
 /*    One University Heights                                         */
 /*    Asheville, NC  28804-3299                                      */
 /*                                                                   */
 /* or by e-mail:                                                     */
 /* GRAVELY@unca.edu                                                  */
 /*                                                                   */
 /*-------------------------------------------------------------------*/

This file contains example code and data sets that are used in the                
book, Your Guide to Survey Research Using the SAS(R) System by 
Archer R. Gravely. 
     
*************************************************************************
*************************************************************************

EXAMPLE CODE USED IN THIS BOOK

--------------------------------------------------------------
--------------------------------------------------------------

***************************************************     
/* The following code appears on page 16,        */    
/* where it is used to produce output 2.1.       */    
*************************************************** 



* SAS Code to Determine Sample Size ;
*(note there is no separate data file;
* creates output 2-1;

options ls=80 nodate nonumber;

data compute;
************** Define Parameters *****************;
N = 2000;   ** Population Size                  **;
p = .5;     ** Estimated Sample Proportion      **;
b = .05;    ** Bound on the Error of Estimation ** ;
**************************************************;
q = 1-p;
d = (b*b)/4;
sample = (N*p*q)/(((N-1)*d)+(p*q));

proc print data = compute label; id N;
var p b sample;
label     N = 'Population Size'
          p = 'Estimated Proportion'
     sample = 'Sample Size Needed'
          b = 'Sampling Error';
title1 'Needed Sample Size';
run;



***************************************************     
/* The following code appears on page 18,        */    
/* where it is used to produce output 2.2.       */    
*************************************************** 

* SAS Code to Determine Sample Error;
*(note there is no separate data file);
* creates output 2-2;

options nodate nonumber ls=80;

data sample;
******** Define Parameters **********;
p = .15;      ** Sample Proportion **;
N = 3000;     ** Population Size   **;
sample = 100; ** Sample size       **;
*************************************;
error = 2*(sqrt(((p*(1-p))/(sample-1))*(N-sample)/N));
error = round(error,.01);

proc print data=sample; id N;
var sample p error;
title1 'Bound on the Error of Estimation';
run;



***************************************************     
/* The following code appears on page 21,        */    
/* where it is used to produce output 2.3.       */    
*************************************************** 
* SAS Code to generate random telephone numbers;
* (note there is no separate data file );
* creates output 2-3;

options ls=80 nodate nonumber;

data sample;
length phone $8;
do i = 1 to 25;
x1 = ranuni(0);
x2 = x1*10000;
last4 = put(x2,z4.);
phone='251-'||(last4);
output;
end;

proc sort data = sample nodupkey;
    by last4;

proc print data = sample;
var x1 x2 last4 phone;
title1 'Random Phone Numbers' ; 



***************************************************     
/* The following code appears on page 28,        */    
/* where it is used to produce output 2.5.       */    
*************************************************** 

* SAS code to read spreadsheet file - creates output 2-5;
* data set follows this code ;

filename reg 'hard drive:reg';
options nodate nonumber;

data cars;
 length name $25 make $15 ;
  infile reg dsd;
input name $ make $ type $ year $
      ?? price ;
 if _n_ = 1 then delete;

proc print;
format price dollar7.;
title1 'Car Registration Data Set';
run;

/* comma delimited text file for output 2-5;    */
/* Name,Make,Type,Year,Price                    */
/* Jan Grimes ,Nissan ,Trk ,96 ,10500           */
/* Dick Monterose ,Oldsmobile ,Car ,95 ,14280   */
/* Janet Beason ,Jeep ,Trk ,94 ,14280           */
/* Glenna Trull ,Subaru ,Car ,97 ,13900         */
/* Ken Wilson ,Toyota ,Trk ,93 ,9000            */


***************************************************     
/* The following code appears on page 31,        */    
/* where it is used to produce output 2.7.       */    
*************************************************** 

* merge example - creates output 2-7j;
* data files follow SAS code below;

filename survey 'voter.dat';
filename pop    'register.dat';

data raw;
  infile survey;
  input @1  id  4.  @5  choice  $1.;

data votereg;
  infile pop;
input @1 id  4. @6 party  $1. @8 age  2. @11 sex  $1. @13 race  $1.;

proc sort data = raw;     by id;
proc sort data = votereg; by id;

data combine;
  merge raw(in=a)  votereg; by id;
if a = 1;

proc print data = combine;
title1 'Results of Merging Raw Survey File and Voter Registration File'; 

/* voter.dat file; */
0017   D
0034   D
0012   D
0104  D
0321  C
3456 P
0090   C
0467  C
0781  P
5682 C

/* register.dat file; */
0001 D 59 F B
0002 D 34 M W
0003 R 29 M W
0004 R 78 M A
0005 D 18 F W
0006 I 45 M H
0007 D 22 M W
0008 D 67 F W
8000 D 34 F B
0017 D 43 M W
0034 D 76 B F
0012 R 46 W M
0104 I 39 W F
0321 I 53 W M
3456 D 22 H F
0090 D 19 B M
0467 R 66 W M
0781 R 19 W M
5682 D 20 W F





***************************************************     
/* The following code appears on page 61,        */    
/* where it is used to produce output 5.1.       */    
*************************************************** 

* SAS code to create new variable based on format values;

options nodate nonumber;

      proc format;
        value $code '01' = 'Service'
                    '02' = 'Finance'
                    '03' = 'Marketing'
                    '04' = 'Sales';
  data report;
     input @1 deptcode $2.  @4  rating  1. ;
    dept = put(deptcode,$code.);
drop deptcode;
cards;
01 3
02 4
03 2
04 4
;
proc sort data = report; by dept;
proc print; id dept;
var rating;
title1 'Department Ratings';



***************************************************     
/* The following code appears on pages 64-65,    */    
/* where it is used to produce output 5.2.       */    
*************************************************** 

* SAS code to convert all upper case names to proper case - creates output 5-2;

data test;
  infile 'name.dat';
  input name $35.  ;
space1 = 0;
space2 = 0;
space3 = 0;
name = lowcase(name);
DO X = 1 to 35;
if substr (name,x,1) =  ' ' then do;
    if space1 = 0 then space1 = x;
    else if space2 = 0 then space2 = x;
    else if space3 = 0 then space3 = x;
end;
end;
fname = substr(name,1,space1-1);
mname = substr(name,space1+1,((space2-1)-space1));
lname = substr(name,space2+1,((space3-1)-space2));

if lname = ' ' then do;
   lname=mname;
   mname = ' ';
end;

substr(fname,1,1) = upcase(substr(fname,1,1));
substr(mname,1,1) = upcase(substr(mname,1,1));
substr(lname,1,1) = upcase(substr(lname,1,1));

proc print; var fname mname lname;
title1 'Creation of New Name Variables';
run;




***************************************************     
/* The following code appears on page 68,        */    
/* where it is used to produce output 5.3.       */    
*************************************************** 

* SAS code to reshape vars into obs - creates output 5-3;
** SAS data set stored as comma delimited file db96.dat stored in separate file;

libname library 'pb hd:new student svy';

options  nonumber nodate ps=65 ls=80;

data survey(keep=goal freq);
length goal $40;
  set library.db96(keep=goal01-goal04);

goal = 'Prepare For Career or Good Job';
if goal01= '1' then freq = 1;
else freq = 0;
output;

goal = 'Take Part in College Social Life';
if goal02 = '1' then freq = 1;
else freq = 0;
output;

goal = 'Dev Apprec, Enjoy of Art, Music, & Lit';
if goal03 = '1' then freq = 1;
else freq = 0;
output;

goal = 'Dev Understand of Science and Tech';
if goal04 = '1' then freq = 1;
else freq = 0;
output;

proc tabulate data = survey;
class goal;
var freq;
table goal = ' ', freq ='Frequency'*sum=' '*f=11.0/
      box = 'Goals for Attending College' RTS=42;
title1 'Re-Shaped Data Example';
run;


 
***************************************************     
/* The following code appears on page 84,        */    
/* where it is used to produce output 6.5.       */    
*************************************************** 


* SAS Code for Calculating Percentages - creates output 6-5;
* uses SAS data sets stored as data95.dat and data96.dat;

libname svy  'pb hd:gss';

data report;
 set svy.data96(keep=discip qla qlb qlc year)
     svy.data95(keep=discip qla qlb qlc year);

if q1a >= 4 then pct1 = 100;
else if (1 <= q1a <= 3) then pct1 = 0;

 if q1b >=4 then pct2 = 100;
else if (1 <= q1b <= 3) then pct2 = 0;

if q1c >= 4 then pct3 = 100;
else if (1 <= q1c <= 3) then pct3 = 0;

label pct1 = 'Intellectual Growth'
      pct2 = 'Career Training'
      pct3 = 'Personal Growth';

proc format;
  value $discip  'NS' = 'Natural Sciences'
                 'SS' = 'Social Sciences'
                 'HM' = 'Humanities'
                 'PR' = 'Professional';

proc summary data = report;
   class discip year;
   var pct1 pct2 pct3 ;
   output out = stats
   mean = ;

proc print data = stats label;
format discip $discip. ;
title1 'Satisfaction Scores by Academic Discipline & Year';
title3 'Percent Reporting "Adequately" or "Very Well"';
run;



***************************************************     
/* The following code appears on page 126,       */    
/* where it is used to produce output 6.21.      */    
*************************************************** 
* Analyze Open-Ended Comments - creates Output 6-21;
* data sets used follow SAS program below;

options ls=65 ps=65 nodate;

filename cdata  'pb hd:survey:comments.dat';
filename iddata 'pb hd:survey:sample.dat';

data comments;
length id $3 dept $2 comment $60 ;
infile cdata dsd;
input id $ dept $  comment $ ;

data sample;
length id $3 ;
infile iddata dsd;
input id $ type $;

proc sort data = comments; by id;
proc sort data = sample;   by id;

proc format;
  value $type 'T' = 'Truck'
              'C' = 'Car';

  value $dept '01' = 'Sales'
              '02' = 'Service'
              '03' = 'Front Office';

data report;
 merge sample comments(in=a); by id;
if a;
comment=trim(comment)||' '||'('||trim(put(type,$type.))||')';

proc sort data = report; by dept type;

proc print data = report n uniform noobs; by dept;
 var comment;
format dept $dept. ;
Title1 'Open-Ended Responses to New Car Owner Survey';
run;

/* comments.dat file ; */
001,01,I couldn't get anyone to wait on me
001,02,Vehicle was not ready when promised
001,03,I didn't get the interest rate I was promised
002,01,Salesman was not knowledgeable
002,03,I resent the extended warranty rip-off
003,01,My salesman was less than honest 
003,02,I am tired of having to bring the car back for repair
004,01,Couldn't get waited on - seem short handed
004,02,price of service is too high!
005,01,Salesman promises were not kept
005,02,Why is shop open on weekends?
005,03,The paperwork was not handled well


***************************************************     
/* The following code appears on page 171,       */    
/* where it is used to produce output 7.16.      */    
*************************************************** 

/* PROC TABULATE - percentages based on column totals - creates output 7-16;
/* data are stored as survey96.dat in a separate file ;

proc tabulate data = db.survey96 noseps;
  class q01 region;
  table q01=' ' all,
        region='Geographical Region'*(n*f=5.0 pctn<q01 all>*f=5.1)
        all*(n*f=5.0 pctn*f=5.1)/rts=22;
  keylabel pctn = 'Pct'
            all = 'Total';
format q01 $q01f. Region $region. ;
title1 'How Well Do You Like Living in Asheville?';
title3 'By Geograhical Region';
run;



***************************************************     
/* The following code appears on page 173,       */    
/* where it is used to produce output 7.17.      */    
*************************************************** 

/* PROC TABULATE - column percentages with subtotals - output 7-17;
/* data are stored in 3 separate files separately:;
/* cohort91.dat, cohort93.dat, cohort95.dat;

libname db  'pb hd:non ret svy';

options ps=65 nodate nonumber ls=70 missing=' ';

data report;
 set  db.cohort91
      db.cohort93
      db.cohort95;

proc format;
   value $type 'F' = 'Freshmen'
               'T' = 'Transfer';

   value $q01f   '1','2' = 'Yes, Helpful'
                 '3','4' = 'Not Helpful'
                     '5' = 'Did Not Consult';

proc tabulate data = report noseps;
class q01 cohort studtype;
table q01 * (studtype all='Subtotal') all='Total',
      cohort ='Fall Semester'*(n*f=5.0 pctn<q01 studtype all>='Pct'*f=5.1)
      all = '3-Yr Total'*(n*f=5.0 pctn<q01 studtype all>='Pct'*f=5.1)/
      Box='Student Rating' rts=17 indent=3;
format q01 $q01f. studtype $type. ;
title1 'Non-Returning Student Perception of Faculty Advising';
run;



***************************************************     
/* The following code appears on page 176,       */    
/* where it is used to produce output 7.18.      */    
*************************************************** 

/* PROC TABULATE - column percentages for concatenated tables - output 7-18;
/* data are stored as cohort91.dat, cohort93.dat, and cohort95.dat in separate file;

libname db  'pb hd:non ret svy';

options ps=65 nodate nonumber ls=70;

data report;
 set  db.cohort91
      db.cohort93
      db.cohort95;

 proc format;
   value $rating   '1' = 'Poor'
                   '2' = 'Fair'
                   '3' = 'Good'
                   '4' = 'Excellent';

proc tabulate data = report;
  class q16a q16b q16c cohort;
  table q16a = 'Academic Exper: '
        q16b = 'Social Exper: '
        q16c = 'Overall Exper: ',
      cohort = 'Fall Semester'*(n*f=5.0 pctn<q16a q16b q16c>='Pct'*f=5.1)
        all = '3-Yr Total'*(n*f=5.0 pctn<q16a q16b q16c>='Pct'*f=5.1)/
        Box='Student Rating' rts=18;
format q16a $rating. q16b $rating. q16c $rating. ;
title1 'Non-Returning Student Rating of UNCA Experience';
run;



***************************************************     
/* The following code appears on page 179,       */    
/* where it is used to produce output 7.19.      */    
*************************************************** 

/* PROC TABULATE - percentages based on row totals - output 7-19;
/* data are stored as cohort91.dat, cohort93.dat, and cohort95.dat in separate file;

libname db  'pb hd:non ret svy';

options ps=65 nodate nonumber ls=70;

data report;
length cohort $4;
 set  db.cohort91(keep=q09 cohort)
      db.cohort93(keep=q09 cohort)
      db.cohort95(keep=q09 cohort);
 cohort = '19'||cohort;

 proc format;
   value $q09f '1' = 'None'
               '2' = 'One'
               '3' = 'Two'
               '4' = 'Three or More';

proc tabulate data = report noseps;
  class q09 cohort;
  table cohort = ' ' all='All Yrs',
        N*f=5. q09='Number of Faculty'*pctn<q09 all>='Percent'*f=9.1
        all='Yr Total'*pctn<q09 all>='Percent'*f=9.1/
        Box='Entering Cohort' rts=10;
format q09 $q09f.  ;
title1 'With How Many Faculty Did You Develop a Familiar Acquaintanceship?';
run;


***************************************************     
/* The following code appears on page 181,       */    
/* where it is used to produce output 7.20.      */    
*************************************************** 

* PROC TABULATE -  row percentages and subtotals - output 7-20;
* data are stored as cohort91.dat, cohort93.dat, and cohort95.dat in separate file;

libname db  'pb hd:non ret svy';

options ps=65 nodate nonumber ls=80;

data report;
length cohort $4;
 set  db.cohort91(keep=q09 cohort sex)
      db.cohort93(keep=q09 cohort sex)
      db.cohort95(keep=q09 cohort sex);
cohort = '19'||cohort;

 proc format;
   value $q09f '1' = 'None'
               '2' = 'One'
               '3' = 'Two'
               '4' = 'Three or More';

   value $sex  'M' = 'Male'
               'F' = 'Female';

proc tabulate data = report;
  class q09 cohort sex;
  table cohort = ' '*(sex=' ' all='Yr Total') sex='Sex Totals' all='Total',
        N*f=5. q09='Number of Faculty'*pctn<q09 all>='Percent'*f=9.1
        all='Yr Total'*pctn<q09 all>='Percent'*f=9.1/
        Box='Entering Cohort' rts=18;
format q09 $q09f. sex $sex. ;
title1 'With How Many Faculty Did You Develop a Familiar Acquaintanceship?';
title2 'By Cohort Year and Sex';
run;



***************************************************     
/* The following code appears on page 184,       */    
/* where it is used to produce output 7.21.      */    
*************************************************** 

* PROC TABULATE - calculate percentages with means - output 7-21;
* data are stored as data95.dat and data96.dat in separate file;

libname svy 'pb hd:gss';

options ls=70 nodate nonumber ps=65;

data report;
 set svy.data95(keep=a4_a a4_b year discip)
     svy.data96(keep=a4_a a4_b year discip);

if a4_a = '1' then percent1 = 100;
else if a4_a = '2' then percent1 = 0;

if a4_b = '1' then percent2 = 100;
else if a4_b = '2' then percent2 = 0;
 
proc format;
  value $discip  'NS' = 'Natural Sciences'
                 'SS' = 'Social Sciences'
                 'HM' = 'Humanities'
                 'PR' = 'Professional';

  value $year    '95' = '1995'
                 '96' = '1996';

proc tabulate data = report noseps;
  class discip year;
  var percent1 percent2;
  table discip*(Year ALL='Discipline Total') year all='Total',
        N*F=5. percent1 = 'Attend UNCA Again'*mean='Percent'*F=12.1
        Percent2 = 'Same Major Again' *mean='Percent'*F=12.1/
rts=23 indent=3;
FORMAT discip $discip. year $year.;
title1 'If You Could Begin Again, Would You Choose To:   ';
title2 '(1) Attend UNCA Or (2) Choose Same Field Of Study?';
run;


 
***************************************************     
/* The following code appears on page 188,       */    
/* where it is used to produce output 7.22.      */    
*************************************************** 

/* PROC TABULATE - Multiple Response Table Using Concatenation - Output 7-22;
/* uses data stored in survey96.dat as separate file;

libname db 'PB HD:stud exp svy';

options ls=85 nodate nonumber ps=65;

data report;
    set db.survey96(keep=q15_01-q15_11 dorm);
   if (q15_01 = ' ' and q15_02 = ' ' and q15_03 = ' ' and q15_04 = ' '
   and q15_05 = ' ' and q15_06 = ' ' and q15_07 = ' ' and q15_08 = ' '
   and q15_09 = ' ' and q15_10 = ' ' and q15_11 = ' ') then delete;
array old $ q15_01-q15_11;
array new pct01-pct11;
do x = 1 to 11;
new{x} = input(old{x},1.);
new{x} = 100*new{x};
end;
if dorm > ' ' then status = 'R';
else status = 'C';

keep status pct01-pct11;

proc format;
   value $status 'C' = 'Commuter'
                 'R' = 'Residence Hall';

proc tabulate data = report noseps;
   class status;
   var pct01-pct11;
   table
pct01 = 'Have To Work At a Job'
pct02 = 'Activities Of Interest Occur Elsewhere'
pct03 = 'Inconvenience Of Returning To Campus'
pct04 = 'Don''t Have Any More Leisure Time'
pct05 = 'There Is More To Do Elsewhere'
pct06 = 'Activ Not Available At Convenient Times'
pct07 = 'Cost of Additional Transp To/From Campus'
pct08 = 'Must Leave Campus At Certain Time'
pct09 = 'Not Interested In Returning to Campus'
pct10 = 'Lack Of Avail/Convenient Child Care'
pct11 = 'Other',
status = ' ' *(n*f=3. mean = 'Percent'*f=7.1)
all='Total'*(n*f=3. mean = 'Percent'*f=7.1)/
box ='Reason' rts=43;
format status $status. ;
title1
'Reasons for Not Spending More Leisure/Discretionary Time on Campus';
run;



***************************************************     
/* The following code appears on page 192,       */    
/* where it is used to produce output 7.24.      */    
*************************************************** 

/* PROC TABULATE - Reshape multiple response items without arrays - Output 7-24;
/* uses data stored in survey96.dat as separate file;

libname db 'PB HD:stud exp svy';

options ls=75 nodate nonumber ps=65;

data report(keep=reason percent status);
length reason $40;
 set db.survey96(keep=q15_01-q15_11 dorm);
 if (q15_01 = ' ' and q15_02 = ' ' and q15_03 = ' ' and q15_04 = ' ' and
     q15_05 = ' ' and q15_06 = ' ' and q15_07 = ' ' and q15_08 = ' ' and
     q15_09 = ' ' and q15_10 = ' ' and q15_11 = ' ') then delete;

if dorm > ' ' then status = 'R';
else status = 'C';

reason = 'Have To Work At a Job';
  if q15_01 = '1' then percent = 100;
  else  percent = 0;
  output;
reason = 'Activities Of Interest Occur Elsewhere';
  if q15_02 = '1' then percent = 100;
  else  percent = 0;
  output;
reason = 'Inconvenience Of Returning To Campus';
  if q15_03 = '1' then percent = 100;
  else  percent = 0;
  output;
reason = 'Don''t Have Any More Leisure Time';
  if q15_04 = '1' then percent = 100;
  else  percent = 0;
  output;
reason = 'There Is More To Do Elsewhere';
  if q15_05 = '1' then percent = 100;
  else  percent = 0;
  output;
reason = 'Activ Not Available At Convenient Times';
  if q15_06 = '1' then percent = 100;
  else  percent = 0;
  output;
reason = 'Cost of Additional Transp To/From Campus';
  if q15_07 = '1' then percent = 100;
  else  percent = 0;
  output;
reason = 'Must Leave Campus At Certain Time';
  if q15_08 = '1' then percent = 100;
  else  percent = 0;
  output;
reason = 'Not Interested In Returning to Campus';
  if q15_09 = '1' then percent = 100;
  else  percent = 0;
  output;
reason = 'Lack Of Avail/Convenient Child Care';
  if q15_10 = '1' then percent = 100;
  else  percent = 0;
  output;
reason = 'Other';
  if q15_11 = '1' then percent = 100;
  else  percent = 0;
  output;

proc format;
   value $status 'C' = 'Commuter (n=144)'
                 'R' = 'Residence Hall (n=126)';

proc tabulate data = report noseps;
   class reason status;
   var percent;
   table reason= ' ', status=' '*percent=' '*mean='Percent'*f=9.1
                      all='Total (n=279)'*percent=' '*mean='Percent'*f=9.1/
box ='Reason' rts=43;
format status $status. ;
title1
'Reasons for Not Spending More Leisure/Discretionary Time on Campus';
run;


***************************************************     
/* The following code appears on page 194,       */    
/* where it is used to produce output 7.24.      */    
*************************************************** 

* PROC TABULATE - Reshape multiple response items with array processing - Output 7-24;
* uses data stored in survey96.dat as separate file;

array q q15_01-q15_11;
do i = 1 to 11;
       if i =  1 then reason = 'Have To Work At a Job';
  else if i =  2 then reason = 'Activities Of Interest Occur Elsewhere';
  else if i =  3 then reason = 'Inconvenience Of Returning To Campus';
  else if i =  4 then reason = 'Don''t Have Any More Leisure Time';
  else if i =  5 then reason = 'There Is More To Do Elsewhere';
  else if i =  6 then reason = 'Activ Not Available At Convenient Times';
  else if i =  7 then reason = 'Cost of Additional Transp To/From Campus';
  else if i =  8 then reason = 'Must Leave Campus At Certain Time';
  else if i =  9 then reason = 'Not Interested In Returning to Campus';
  else if i = 10 then reason = 'Lack Of Avail/Convenient Child Care';
  else if i = 11 then reason = 'Other';
  if q{i} = '1' then percent = 100;
  else percent = 0;
  output;
end;

proc format;
   value $status 'C' = 'Commuter (n=142)'
                 'R' = 'Residence Hall (n=137)';

proc tabulate data = report noseps;
   class reason status;
   var percent;
   table reason= ' ', status=' '*percent=' '*mean='Percent'*f=9.1
                      all='Total (n=279)'*percent=' '*mean='Percent'*f=9.1/
box ='Reason' rts=43;
format status $status. ;
title1
'Reasons for Not Spending More Leisure/Discretionary Time on Campus';
run;



***************************************************     
/* The following code appears on page 200,       */    
/* where it is used to produce output 7.26.      */    
*************************************************** 

* PROC TABULATE - ordering headings by value of a statistic - output 7-26;
* data stored as progeval.dat in separate file;

libname library  'PB HD:prog assess svy';
options nodate PS=65 LS=75;

data report;
set library.progeval(keep=major q2l);
if q2l in('3','4') then percent = 100;
else if q2l in('1','2') then percent = 0;
if major in('SPAN','GERM','FREN') then major='FLANG';

proc summary data = report nway;
  class major;
  var percent;
  output out = dummy(keep=major sortv)
  mean = sortv;

proc sort data = dummy; by major;
proc sort data = report; by major;

data update;
  merge dummy report(in=a); by major;
 if a;

proc sort data = update; by descending sortv;

proc tabulate data = update noseps order=data;
  class major;
  var percent;
  table major=' ' all='Total',
        N*f=comma7. percent='Percent'*mean= ' '*f=9.1/
        box='Major';
title1 'Faculty Members of This Dept Work Together to Achieve Program Goals';
title3 'Percent of Students Responding "Agree" or "Strongly Agree"';
format major $major. ;
run;



***************************************************     
/* The following code appears on page 204,       */    
/* where it is used to produce output 7.27.      */    
*************************************************** 

* PROC TABULATE Supertable - output7-27;
* data stored as data95.dat and data96.dat in separate file;

libname library 'pb hd:gss';

options ls=70 nodate nonumber ps=65;

data supertab;
length year $4;
 set library.data95
     library.data96;
year= '19'||year;
 if a4_a = '1' then percent = 100;
 else if a4_a = '2' then percent = 0;

proc tabulate data = supertab missing noseps;
  var percent;
  class discip admtype cumgpa race sex year;
  table discip='Discipline:'
        admtype = 'Admission''s Type:'
        cumgpa = 'Cumulative GPA:'
        race = 'Race:'
        sex = 'Sex:'
        all = 'Total',
        year='Year Graduated'*(n*f=5.0 percent=' '*mean='Pct'*f=5.1)
        all='2-Year Total'*(n*f=5.0 percent=' '*mean='Pct'*f=5.1)/
 rts=23 box='Dimension' ;
format discip $discip. admtype $admtype. cumgpa cumgpa. race $race.
 sex $sex.;
title1 'If You Could Begin Again, Would You Choose to Attend UNCA';
title2 '(Percent Responding "Yes")';
run;



***************************************************     
/* The following code appears on page 208,       */    
/* where it is used to produce output 7.29.      */    
*************************************************** 

* PROC TABULATE - macro example;
* data stored in separate files as db96.dat--db90.dat;


libname library 'pb hd:new student svy';

%let yr1 = 90;
%let yr2 = 91;
%let yr3 = 92;
%let yr4 = 93;
%let yr5 = 94;
%let yr6 = 95;
%let yr7 = 96;

options nodate nonumber ps=65 ls=80;

data report;
  set library.db&yr1.(keep=year income )
      library.db&yr2.(keep=year income )
      library.db&yr3.(keep=year income )
      library.db&yr4.(keep=year income )
      library.db&yr5.(keep=year income )
      library.db&yr6.(keep=year income )
      library.db&yr7.(keep=year income );

proc tabulate data = report noseps;
class year income;
table income =' ' all,
year ='P E R C E N T A G E'*(pctn<income all>=' '*F=7.1)/
box='Family Income' rts=19;;
keylabel all='Total';
format income income. year $year. ;
title1 "New Freshmen Family Income: 19&yr1-19&yr7";
run;




***************************************************     
/* The following code appears on page 221-222,   */    
/* where it is used to produce figure 8.5.       */    
*************************************************** 

/* Gray Scale Example- creates figure 8-5;
data test;
input shade $;
cards;
gray00
gray30
gray45
gray60
gray75
gray90
gray99
grayaa
graybb
graycc
graydd
grayee
grayff
;
pattern01 c=gray00 v=s;
pattern02 c=gray30 v=s;
pattern03 c=gray45 v=s;
pattern04 c=gray60 v=s;
pattern05 c=gray75 v=s;
pattern06 c=gray90 v=s;
pattern07 c=gray99 v=s;
pattern08 c=grayaa v=s;
pattern09 c=graybb v=s;
pattern10 c=graycc v=s;
pattern11 c=graydd v=s;
pattern12 c=grayee v=s;
pattern13 c=grayff v=s;

 proc gchart ;
   axis1 value=none c=grayff;
  hbar shade/nostats patternid=midpoint raxis=axis1 ;
title1 'Figure 8-5:  SAS/GRAPH Grayscales:  Selected Shades';
run;
quit;



***************************************************     
/* The following code appears on page 227,       */    
/* where it is used to produce output 8.3.       */    
*************************************************** 

/* SAS Code for Note Example - creates output 8-3;

data test;
input x y;
cards;
1  1
2  2
3  3
4  4
5  5
6  6
7  7
8  8
9  9
10 10
;
symbol1 c=grayff;

proc gplot ;
axis1 order = (1 to 10 by 1) minor=none color=gray99 value=(color=gray99);
 plot x*y/vaxis=axis1 haxis=axis1 ;
 title1 h=1.5  'Output 8-3:  Note Statement Move Commands';
 note h=1 c=gray00  move=(1,1)   '(1,1)'
                    move=(15,15) '(15,15)'
                    move=(10,29) '(10,29)'
                    move=(50,10) '(50,10)'
                    move=(30,25) '(30,25)'
          c=gray45  move=(75 pct, 75 pct) '(75 pct, 75 pct)'
                    move=(25 pct, 25 pct) '(25 pct, 25 pct)'
                    move=(50 pct, 50 pct) '(50 pct, 50 pct)'
                    move=(75 pct, 15 pct) '(75 pct, 15 pct)';
run;
quit;




***************************************************     
/* The following code appears on page 231,       */    
/* where it is used to produce output 8.4.       */    
*************************************************** 

/* Basic Horizontal Bar Chart - creates output 8-4;
/* data stored as survey96.dat in separate file;

libname db 'PB HD:stud exp svy';

 proc format;
  value $q14f '1' = 'Not Impt.'
              '2' = 'Somewhat Impt.'
              '3' = 'Important'
              '4' = 'Very Impt.';

proc gchart data =db.survey96;
hbar q14;
label q14 = 'Level Impt.' ;
format q14 $q14f. ;
title1 h=1.5 'Output 8-4:  Default Horizontal Bar Chart';
title3
'How Important is it to you to Take Part in College Social Life?';
run;
quit;



***************************************************     
/* The following code appears on page 233,       */    
/* where it is used to produce output 8.5.       */    
*************************************************** 

/* Enhanced Basic Horizontal Bar Chart - creates output 8-5;
/* data is survey96.dat;

libname db 'PB HD:book:stud exp svy';

 proc format;
  value $q14f '1' = 'Not Impt.'
              '2' = 'Somewhat Impt.'
              '3' = 'Important'
              '4' = 'Very Impt.';

proc gchart data =db.survey96;
hbar q14;
label q14 = 'Level Impt.' ;
format q14 $q14f. ;
title;
title1 h=1.5 'Output 8-4:  Default Horizontal Bar Chart';
title4
'How Important is it to you to Take Part in College Social Life?';
footnote;
run;
quit;



***************************************************     
/* The following code appears on page 234,       */    
/* where it is used to produce output 8.6.       */    
*************************************************** 

/* Bar Chart of Groups - output 8-6;
/* uses survey96.dat file;

libname db 'PB HD:stud exp svy';

 proc format;
  value $q14f '1' = 'Not Impt.'
              '2' = 'Somewhat Impt.'
              '3' = 'Important'
              '4' = 'Very Impt.';

  value agegrp 16-25 = '16-25'
               26-high = '26-Up';

pattern1 c=grayff v=s;
pattern2 c=grayaa v=r3;
pattern3 c=grayaa v=s;
pattern4 c=gray22 v=s;

proc gchart data =db.survey96; where age > .;
hbar q14/ group=age g100
          midpoints='Not Impt.' 'Somewhat Impt.' 'Important' 'Very Impt.'
          coutline=black raxis=0 to 100 by 10 minor=0 patternid=midpoint;
label q14 = 'Level Impt.'
      age = 'Age';
format q14 $q14f. age agegrp. ;
title1 h=2
'Output 8-6: Horizontal Bar Chart With Group Dimension';
title3 h=1.75
'How Important is it to you to Take Part in College Social Life?';
title4 h=1 'by Age Group';
run;
quit;



***************************************************     
/* The following code appears on page 236,       */    
/* where it is used to produce output 8.7.       */    
*************************************************** 

/* Horizontal Bar Chart of Means -creates output 8-7;
/* uses survey96.dat file;

libname db 'PB HD:stud exp svy';

 proc format;
  value $q14f '1' = 'Not Impt.'
              '2' = 'Somewhat Impt.'
              '3' = 'Important'
              '4' = 'Very Impt.';

pattern1 c=grayaa v=s;

proc gchart data =db.survey96 ;
hbar q14/sumvar=hrswrk type=mean
        midpoints='Not Impt.' 'Somewhat Impt.' 'Important' 'Very Impt.'
          coutline=black ;
label q14 = 'Level Impt.'
      hrswrk = 'Hrs Wrk';

format q14 $q14f. ;
title1 h=1.75 'Output 8-7: Horizontal Bar Chart of Means';
title3 h=1.5
'How Important is it to you to Take Part in College Social Life?';
title4 h=1  'by Hours of Employment';
run;
quit;


***************************************************     
/* The following code appears on page 237,       */    
/* where it is used to produce output 8.8.       */    
*************************************************** 

/* Verticall Bar Chart of Means -creates output 8-8;
/* uses survey96.dat file;

proc gchart data =survey;
vbar q14/sumvar=hrswrk type=mean mean
        midpoints='Not Impt.' 'Somewhat Impt.' 'Important' 'Very Impt.'
          coutline=black raxis= 0 to 30 by 5 minor=4 ;
label q14 = 'Level Impt.'
      hrswrk = 'Hrs Wrk';
format q14 $q14f. hrswrk 4.1;
title1 h=1.75 'Output 8-8: Vertical Bar Chart of Means';
title3 h=1.5
'How Important is it to you to Take Part in College Social Life?';
title4 h=1  'by Hours of Employment';
run;
quit;



***************************************************     
/* The following code appears on page 239,       */    
/* where it is used to produce output 8.9.       */    
*************************************************** 

/*Charting multiple response items - creates output 8-9;
/* uses survey96.dat file;

libname db 'PB HD:stud exp svy';

pattern1 c=grayaa v=s;

data survey(keep=percent dim);
length dim $18;
   set db.survey96(keep=q19a q19b q19c q19d);
dim = 'Academics';
if q19a in ('4','3') then percent = 100;
else if q19a in ('1','2') then percent = 0;
else percent = . ;
output;

dim = 'Out-of-Class Exper';
if q19b in ('4','3') then percent = 100;
else if q19b in ('1','2') then percent = 0;
else percent = . ;
output;

dim = 'Overall Exper';
if q19c in ('4','3') then percent = 100;
else if q19c in ('1','2') then percent = 0;
else percent = . ;
output;

dim = 'Student Quality';
if q19d in ('4','3') then percent = 100;
else if q19d in ('1','2') then percent = 0;
else percent = . ;
output;

proc gchart data =survey;
hbar dim/sumvar=percent type=mean descending nostats coutline=black frame
         raxis=0 to 100 by 10 minor=1;
label DIM = 'Dimension'
      PERCENT='Percent';
title1 h=1.7
'Output 8-9: Reshaping Data to Graph Multiple Variables';
title3 h=1.5 'Student Rating of College Experience';
title4  h=1.3 'Percent Reporting "Good" or "Excellent"';
run;
quit;


***************************************************     
/* The following code appears on page 242-243,   */    
/* where it is used to produce output 8.10.      */    
***************************************************


/* Subdivided Bar Chart - output 8-10;
/* data stored as progeval.dat in separate file;

libname library  'pd hd':prog assess svy';

data survey;
set library.progeval(keep=major qb01);
if qb01 = ' ' then delete;
if qb01 = '3' then percent= 100;
else if qb01 in ('1','2','4') then percent = 0;
response = 'G';
output;
if qb01 = '4' then percent= 100;
else if qb01 in ('1','2','3') then percent = 0;
response = 'E';
output;

proc summary data = survey nway;
  class  major response;
  var percent;
  output out = stats
  mean = ;

 pattern1 c=gray99 v=s;
 pattern2 c=grayff v=e;

proc gchart data = stats ;
axis1 order = (0 to 90 by 10)
      minor = (n=1)
      label = ('Percent');
  hbar major/sumvar=percent subgroup=response type=sum nostats descending
             vref=59 coutline=black frame raxis=axis1 nolegend;
note h=.9    move=(15 pct,22 pct) c=gray99 'Excellent'
             move=(50 pct,22 pct) c=black  'Good'
             move=(60 pct,9 pct) c=black  'Univ Average';
title;
title1 h=1.5 'Output 8-10:  Segmented Bar Chart';
title2;
title3 h=1 'Student Rating of Advising by Major';
title4 h=.75 '(Percent Responding "Excellent" or "Good")';
run;
quit;


***************************************************     
/* The following code appears on page 246,       */    
/* where it is used to produce output 8.11.      */    
***************************************************

/* Basic Scatter Plot - output 8-11;
/* uses db96.dat stored as separate file;

libname library 'pb hd::new student svy';

data newsvy;
  set library.DB96(keep=hours credhrld);
if credhrld >= 12;
n = 1;

proc summary data = newsvy nway;
  class hours;
  var n;
  output out = stats
  sum = ;

proc gplot data = stats;
plot n*hours;
title1 'Output 8-11:  Basic Scatterplot';
title2 'How Many Hours Per Week Will You be Employed on Average?';
title3 '(Full-Time Students Employed One or More Hrs Per Week)';
run;
quit;


***************************************************     
/* The following code appears on page 247,       */    
/* where it is used to produce output 8.12.      */    
***************************************************

/* Enhanced Scatter Plot - output 8-12;
/* uses db96.dat stored as separate file;

symbol1 c=gray00 v=diamond;

proc gplot data = stats ;
axis1 order=(0 to 60 by 5)  minor=(number=1) label=('Employment Hours');
axis2 order=(0 to 60 by 10) minor=(number=1);
plot  n*hours/frame href=18.4 haxis=axis1 vaxis=axis2 ;
plot2 n*hours/vaxis=axis2;
note h= 1.2  move=(32,10) langle=90 'Mean Hours';
title;
title1 'Output 8-12:  Improved Scatter Plot';
title2 'How Many Hours Per Week Will You be Employed on Average?';
title3 '(Full-Time Students Employed One or More Hrs Per Week)';
run;
quit;


***************************************************     
/* The following code appears on page 249,       */    
/* where it is used to produce output 8.13.      */    
***************************************************

/* line plot with grid marks;
/* uses db96.dat--db90.dat;

libname library 'pb hd:new student svy';

data newsvy;
  set library.db90(keep=hours year credhrld)
      library.db91(keep=hours year credhrld)
      library.db92(keep=hours year credhrld)
      library.db93(keep=hours year credhrld)
      library.db94(keep=hours year credhrld)
      library.db95(keep=hours year credhrld)
      library.db96(keep=hours year credhrld) ;
 if credhrld >= 12;

proc summary data = newsvy nway;
  class year;
  var hours;
  output out = stats
  mean = ;

symbol1 v=square c=gray00 i=join line=1 w=2;

proc gplot data = stats;
axis1 order=(0 to 25 by 5) minor=(number=1) label=('Hrs Wrk');
 plot hours*year/frame grid vaxis=axis1;
 plot2 hours*year/vaxis=axis1;
title1 'Output 8-13:  Line Plot With Grid';
title2 'New Student Employment Hours by Year';
run;
quit;



***************************************************     
/* The following code appears on page 251,       */    
/* where it is used to produce output 8.14.      */    
***************************************************

/* Line Plot with Fill pattern;
/* uses db96.dat stored as separate file;

symbol1 v=none i=spline c=gray00;
pattern1 v=s c=grayff;

proc gplot data = stats ;
axis1 order=(0 to 25 by 5) minor=(number=1) label=('Hrs Wrk');
 plot hours*year/frame vaxis=axis1 areas=1 ;
 plot2 hours*year/vaxis=axis1;
title1 'Output 8-14:  Line Plot With Fill Pattern';
title2 'New Student Employment Hours by Year';
run;
quit;


***************************************************     
/* The following code appears on page 252,       */    
/* where it is used to produce output 8.15.      */    
***************************************************

/* Multiple line plot;
/* uses db96.dat stored as separate file;
libname library 'pb hd:book:new student svy';

data newsvy;
  set library.db90(keep=hours tstudent year credhrld)
      library.db91(keep=hours tstudent year credhrld)
      library.db92(keep=hours tstudent year credhrld)
      library.db93(keep=hours tstudent year credhrld)
      library.db94(keep=hours tstudent year credhrld)
      library.db95(keep=hours tstudent year credhrld)
      library.db96(keep=hours tstudent year credhrld) ;
 if credhrld >= 12;

proc summary data = newsvy nway;
  class year tstudent;
  var hours;
  output out = stats
  mean = ;

symbol1 v=diamond c=gray00 i=join line=2 w=4;
symbol2 v=circle  c=gray00 i=join line=1 w=4;

proc gplot data = stats ;
axis1 order=(0 to 25 by 5) minor=(number=1) label=('Hrs Wrk');
 plot hours*year=tstudent/frame vaxis=axis1 nolegend ;
 plot2 hours*year=tstudent/vaxis=axis1 nolegend;
note move = (40,19) c=gray00 h=1.2 'Transfer'
     move = (40,13) c=gray00 h=1.2 'Freshmen';
title1 'Output 8-15:  Multiple Line Plot';
title2 'New Student Employment Hours by Type and Year';
run;
quit;


***************************************************     
/* The following code appears on page 255,       */    
/* where it is used to produce output 8.16.      */    
***************************************************

* labeling data points with NOTES;
* uses survey96.dat;

libname db 'PB HD:stud exp svy';

data survey(keep=service use rating);
length service $30 rating 4 use 4 ;
  set db.survey96(keep= q22a_a q22a_b q22a_c q22a_d q22a_e q22a_f
                        q22a_g q22a_h q22a_i q22a_j q22a_k q22a_l
                        q22b_a q22b_b q22b_c q22b_d q22b_e q22b_f
                        q22b_g q22b_h q22b_i q22b_j q22b_k q22b_l);

service = 'Library';
use    = q22a_a;
rating = q22b_a;
output;

service = 'Career planning/placement';
use    = q22a_b;
rating = q22b_b;
output;

service = 'Counseling center';
use    = q22a_c;
rating = q22b_c;
output;

service = 'Outdoor recreation activities';
use    = q22a_d;
rating = q22b_d;
output;

service = 'Health service';
use    = q22a_e;
rating = q22b_e;
output;

service = 'Reading lab';
use    = q22a_f;
rating = q22b_f;
output;

service = 'Writing lab';
use    = q22a_g;
rating = q22b_g;
output;

service = 'Math lab';
use    = q22a_h;
rating = q22b_h;
output;

service = 'Dining hall';
use    = q22a_i;
rating = q22b_i;
output;

service = 'Dante''s snack bar';
use    = q22a_j;
rating = q22b_j;
output;

service = 'Cafe ramsey';
use    = q22a_k;
rating = q22b_k;
output;

service = 'Bookstore';
use    = q22a_l;
rating = q22b_l;
output;

data final;
  set survey;
if rating = 5 then rating = . ;

proc summary nway data = final;
  class service;
  var use rating;
  output out = stats(drop=_type_ _freq_)
  mean = ;

symbol1 c=gray00 h=1.0  v=diamond;

 proc gplot data = stats ;
 axis1 label=('Frequency of use') w=2 order=(1 to 4 by .5) minor=none;
 axis2 label=('Rating') w=2 order=(1 to 4 by .5) minor=none;
 plot rating*use/haxis=axis1 vaxis=axis2 vref=3.0 cvref=grayaa href=3.0
                 chref=grayaa nolegend ;
 plot2 rating*use/nolegend vaxis=axis2;
note h=.75 c=gray00 move=(45,12)            'Dining Hall'
                    move=(22,15) langle=340 'Career Planning'
                    move=(16,17) langle= 45 'Counseling Ctr'
                    move=(36,15) langle=0   'Snack Bar'
                    move=(41,17)            'Health Service'
                    move=(65,19)            'Library'
                    move=(28,18) langle= 45 'Math Lab'
                    move=(22,16) langle=350 'Outdoor Rec'
                    move=(10,14) langle=340 'Reading Lab'
                    move=(21,17) langle= 45 'Writing Lab'
                    move=(32,17) langle= 45 'Cafe Ramsey'
                    move=(59,15) langle=0   'Bookstore'
   h=1. c=grayaa    move=(17,23)  'Lower Use/Higher Quality'
                    move=(60,23)  'Higher Use/'
                    move=(60,22)  'Higher Quality'
                    move=(60,7)   'Higher Use/'
                    move=(60,6)   'Lower Quality'
                    move=(17,7)   'Lower Use/Lower Quality'
  h=.75             move=(7,2)    'Never'
                    move=(29,2)   'Seldom'
                    move=(50,2)   'Occasionally'
                    move=(75,2)   'Frequently'
                    move=(2,4)    'Poor'
                    move=(2,9)    'Fair'
                    move=(2,15)   'Good'
                    move=(2,21)   'Excel-'
                    move=(2,20)   'lent' ;
 title1 h=1 'Output 8-16:  Labeling Data Points';
 title2 H=1
'Use of Programs and Services by Perceived Quality of Service';
 run;
 quit;

--------------------------------------------------------------
DATASETS USED IN THIS BOOK
--------------------------------------------------------------
--------------------------------------------------------------
/* cohort91.dat  */


91 ,T ,M ,  ,  ,  ,  , 
91 ,F ,F ,  ,  ,  ,  , 
91 ,F ,M ,  ,  ,  ,  , 
91 ,F ,F ,  ,  ,  ,  , 
91 ,T ,F ,  ,  ,  ,  , 
91 ,T ,M ,2 ,4 ,3 ,4 ,3
91 ,T ,F ,2 ,2 ,3 ,1 ,3
91 ,T ,M ,  ,  ,  ,  , 
91 ,T ,M ,2 ,2 ,3 ,2 ,2
91 ,T ,F ,  ,  ,  ,  , 
91 ,F ,F ,3 ,2 ,3 ,1 ,2
91 ,F ,M ,2 ,4 ,4 ,3 ,3
91 ,F ,F ,  ,  ,  ,  , 
91 ,F ,M ,  ,  ,  ,  , 
91 ,T ,F ,2 ,1 ,1 ,3 ,2
91 ,T ,M ,  ,  ,  ,  , 
91 ,T ,M ,2 ,2 ,3 ,1 ,1
91 ,F ,F ,3 ,3 ,2 ,1 ,1
91 ,T ,F ,  ,  ,  ,  , 
91 ,F ,F ,  ,  ,  ,  , 
91 ,F ,F ,  ,  ,  ,  , 
91 ,F ,F ,4 ,3 ,1 ,3 ,1
91 ,F ,F ,2 ,4 ,3 ,3 ,2
91 ,F ,F ,3 ,1 ,2 ,2 ,2
91 ,F ,F ,  ,  ,  ,  , 
91 ,T ,M ,3 ,1 ,2 ,2 ,1
91 ,F ,M ,  ,  ,  ,  , 
91 ,F ,F ,2 ,2 ,2 ,1 ,1
91 ,F ,F ,3 ,1 ,2 ,1 ,1
91 ,F ,F ,2 ,3 ,2 ,2 ,2
91 ,F ,F ,4 ,4 ,3 ,1 ,2
91 ,F ,M ,  ,  ,  ,  , 
91 ,T ,F ,5 ,2 ,4 ,3 ,3
91 ,T ,M ,  ,  ,  ,  , 
91 ,T ,F ,  ,  ,  ,  , 
91 ,T ,F ,4 ,1 ,3 ,1 ,2
91 ,T ,F ,  ,  ,  ,  , 
91 ,F ,F ,  ,  ,  ,  , 
91 ,T ,F ,3 ,3 ,4 ,2 ,3
91 ,F ,F ,  ,  ,  ,  , 
91 ,F ,F ,  ,  ,  ,  , 
91 ,T ,M ,  ,  ,  ,  , 
91 ,F ,F ,2 ,3 ,3 ,2 ,2
91 ,T ,F ,  ,  ,  ,  , 
91 ,F ,F ,2 ,3 ,3 ,1 ,2
91 ,T ,M ,1 ,2 ,2 ,2 ,2
91 ,T ,M ,  ,  ,  ,  , 
91 ,F ,F ,3 ,3 ,3 ,2 ,2
91 ,F ,M ,1 ,1 ,2 ,1 ,1
91 ,F ,M ,  ,  ,  ,  , 
91 ,F ,M ,  ,  ,  ,  , 
91 ,F ,F ,2 ,1 ,3 ,1 ,2
91 ,F ,F ,  ,  ,  ,  , 
91 ,T ,M ,  ,  ,  ,  , 
91 ,T ,M ,2 ,2 ,3 ,2 ,2
91 ,T ,F ,1 ,4 ,4 ,3 ,4
91 ,F ,M ,  ,  ,  ,  , 
91 ,T ,F ,  ,  ,  ,  , 
91 ,T ,M ,  ,  ,  ,  , 
91 ,T ,F ,  ,  ,  ,  , 
91 ,F ,M ,  ,  ,  ,  , 
91 ,F ,F ,  ,  ,  ,  , 
91 ,F ,F ,  ,  ,  ,  , 
91 ,F ,F ,  ,  ,  ,  , 
91 ,F ,M ,4 ,2 ,2 ,1 ,1
91 ,F ,F ,  ,  ,  ,  , 
91 ,F ,F ,  ,  ,  ,  , 
91 ,F ,M ,  ,  ,  ,  , 
91 ,T ,M ,1 ,4 ,4 ,3 ,4
91 ,T ,M ,1 ,4 ,4 ,4 ,4
91 ,T ,M ,  ,  ,  ,  , 
91 ,F ,M ,  ,  ,  ,  , 
91 ,T ,F ,5 ,1 ,1 ,1 ,1
91 ,T ,M ,1 ,4 ,3 ,2 ,3
91 ,T ,M ,  ,  ,  ,  , 
91 ,F ,M ,  ,  ,  ,  , 
91 ,F ,F ,2 ,4 ,3 ,3 ,3
91 ,F ,M ,  ,  ,  ,  , 
91 ,T ,F ,2 ,2 ,3 ,2 ,2
91 ,F ,F ,1 ,4 ,3 ,3 ,3
91 ,T ,M ,  ,  ,  ,  , 
91 ,T ,F ,2 ,2 ,2 ,2 ,2
91 ,T ,F ,2 ,4 ,3 ,2 ,3
91 ,F ,M ,1 ,4 ,3 ,2 ,2
91 ,T ,F ,2 ,3 ,3 ,4 ,4
91 ,F ,M ,  ,  ,  ,  , 
91 ,F ,F ,2 ,2 ,3 ,3 ,3
91 ,T ,M ,4 ,3 ,1 ,3 ,3
91 ,F ,F ,3 ,3 ,3 ,2 ,3
91 ,T ,F ,1 ,2 ,4 ,3 ,4
91 ,T ,F ,3 ,2 ,3 ,3 ,3
91 ,T ,F ,5 ,1 ,3 ,1 ,2
91 ,T ,M ,  ,  ,  ,  , 
91 ,F ,F ,  ,  ,  ,  , 
91 ,F ,F ,  ,  ,  ,  , 
91 ,T ,F ,2 ,4 ,4 ,3 ,3
91 ,T ,M ,  ,  ,  ,  , 
91 ,T ,F ,2 ,3 ,3 ,1 ,2
91 ,F ,F ,  ,  ,  ,  , 
91 ,T ,M ,  ,  ,  ,  , 
91 ,T ,M ,1 ,1 ,3 ,3 ,3
91 ,F ,F ,  ,  ,  ,  , 
91 ,T ,M ,  ,  ,  ,  , 
91 ,T ,M ,  ,  ,  ,  , 
91 ,F ,F ,  ,  ,  ,  , 
91 ,T ,M ,  ,  ,  ,  , 
91 ,T ,M ,1 ,4 ,4 ,3 ,3
91 ,F ,M ,  ,  ,  ,  , 
91 ,F ,M ,1 ,2 ,4 ,2 ,3
91 ,F ,F ,2 ,2 ,3 ,3 ,1
91 ,F ,M ,1 ,4 ,3 ,1 ,2
91 ,T ,M ,  ,  ,  ,  , 
91 ,F ,F ,1 ,1 ,3 ,3 ,3
91 ,T ,F ,  ,  ,  ,  , 
91 ,F ,M ,1 ,3 ,3 ,3 ,2
91 ,F ,M ,2 ,1 ,3 ,3 ,3
91 ,F ,M ,  ,  ,  ,  , 
91 ,T ,F ,3 ,4 ,2 ,2 ,2
91 ,T ,F ,  ,  ,  ,  , 
91 ,F ,M ,  ,  ,  ,  , 
91 ,T ,M ,  ,  ,  ,  , 
91 ,T ,F ,3 ,3 ,4 ,1 ,2
91 ,F ,F ,  ,  ,  ,  , 
91 ,T ,F ,  ,  ,  ,  , 
91 ,T ,M ,  ,  ,  ,  , 
91 ,T ,M ,  ,  ,  ,  , 
91 ,F ,F ,2 ,3 ,3 ,2 ,3
91 ,T ,M ,  ,  ,  ,  , 
91 ,T ,M ,5 ,1 ,4 ,1 ,3
91 ,T ,F ,  ,  ,  ,  , 
91 ,T ,F ,  ,  ,  ,  , 
91 ,F ,F ,  ,  ,  ,  , 
91 ,F ,F ,2 ,3 ,3 ,4 ,3
91 ,T ,F ,3 ,4 ,3 ,3 ,3
91 ,T ,M ,  ,  ,  ,  , 
91 ,F ,F ,  ,  ,  ,  , 
91 ,T ,M ,  ,  ,  ,  , 
91 ,T ,F ,3 ,1 ,3 ,2 ,3
91 ,T ,M ,3 ,4 ,4 ,3 ,4
91 ,T ,F ,  ,  ,  ,  , 
91 ,T ,M ,  ,  ,  ,  , 
91 ,T ,M ,  ,  ,  ,  , 
91 ,T ,F ,2 ,2 ,3 ,2 ,3
91 ,F ,M ,2 ,4 ,4 ,3 ,3
91 ,F ,F ,  ,  ,  ,  , 
91 ,T ,F ,  ,  ,  ,  , 
91 ,T ,M ,  ,  ,  ,  , 
91 ,F ,F ,  ,  ,  ,  , 
91 ,T ,F ,  ,  ,  ,  , 
91 ,F ,M ,  ,  ,  ,  , 
91 ,T ,F ,  ,  ,  ,  , 
91 ,T ,F ,5 ,2 ,4 ,2 ,3
91 ,T ,F ,  ,  ,  ,  , 
91 ,T ,F ,  ,  ,  ,  , 
91 ,F ,F ,  ,  ,  ,  , 
91 ,T ,M ,1 ,4 ,4 ,2 ,3
91 ,T ,F ,  ,  ,  ,  , 
91 ,T ,F ,1 ,2 ,3 ,3 ,3
91 ,T ,M ,1 ,4 ,4 ,4 ,4
91 ,T ,F ,  ,  ,  ,  , 
91 ,T ,F ,2 ,1 ,3 ,2 ,3
91 ,F ,F ,3 ,2 ,2 ,2 ,2
91 ,T ,M ,  ,  ,  ,  , 
91 ,T ,M ,1 ,1 ,1 ,4 ,2
91 ,T ,F ,  ,  ,  ,  , 
91 ,T ,M ,  ,  ,  ,  , 
91 ,T ,F ,3 ,3 ,2 ,2 ,2
91 ,T ,F ,  ,  ,  ,  , 
91 ,T ,F ,3 ,1 ,3 ,1 ,2
91 ,T ,F ,  ,  ,  ,  , 
91 ,F ,M ,  ,  ,  ,  , 
91 ,F ,M ,  ,  ,  ,  , 
91 ,T ,M ,2 ,1 ,3 ,1 ,2
91 ,T ,F ,  ,  ,  ,  , 
91 ,T ,F ,  ,  ,  ,  , 
91 ,F ,F ,  ,  ,  ,  , 
91 ,T ,F ,  ,  ,  ,  , 


/* cohort93.dat */

93 ,T ,F ,1 ,4 ,3 ,4 ,3
93 ,F ,F ,1 ,3 ,2 ,3 ,3
93 ,F ,M ,1 ,3 ,3 ,4 ,4
93 ,T ,M ,  ,  ,  ,  , 
93 ,T ,M ,3 ,1 ,2 ,2 ,2
93 ,F ,F ,  ,  ,  ,  , 
93 ,T ,M ,  ,  ,  ,  , 
93 ,T ,F ,3 ,4 ,3 ,4 ,2
93 ,T ,F ,  ,  ,  ,  , 
93 ,F ,M ,  ,  ,  ,  , 
93 ,T ,F ,  ,  ,  ,  , 
93 ,T ,M ,  ,  ,  ,  , 
93 ,F ,F ,2 ,4 ,4 ,4 ,4
93 ,F ,F ,2 ,3 ,4 ,2 ,3
93 ,T ,M ,2 ,3 ,3 ,3 ,3
93 ,F ,M ,  ,  ,  ,  , 
93 ,T ,M ,  ,  ,  ,  , 
93 ,T ,M ,  ,  ,  ,  , 
93 ,T ,M ,2 ,2 ,4 ,4 ,4
93 ,F ,M ,  ,  ,  ,  , 
93 ,F ,F ,  ,  ,  ,  , 
93 ,F ,F ,  ,  ,  ,  , 
93 ,F ,F ,  ,  ,  ,  , 
93 ,T ,M ,1 ,2 ,3 ,1 ,3
93 ,F ,F ,3 ,3 ,3 ,2 ,2
93 ,T ,M ,2 ,1 ,2 ,1 ,2
93 ,F ,F ,1 ,4 ,3 ,2 ,2
93 ,F ,M ,4 ,3 ,3 ,2 ,3
93 ,F ,F ,2 ,2 ,4 ,4 ,4
93 ,T ,M ,  ,  ,  ,  , 
93 ,T ,M ,5 ,2 ,2 ,1 ,1
93 ,F ,M ,  ,  ,  ,  , 
93 ,T ,F ,  ,  ,  ,  , 
93 ,F ,F ,1 ,3 ,3 ,2 ,2
93 ,F ,M ,3 ,2 ,2 ,1 ,1
93 ,F ,M ,  ,  ,  ,  , 
93 ,F ,F ,  ,  ,  ,  , 
93 ,F ,F ,  ,  ,  ,  , 
93 ,T ,M ,  ,  ,  ,  , 
93 ,F ,F ,  ,  ,  ,  , 
93 ,F ,M ,  ,  ,  ,  , 
93 ,F ,M ,  ,  ,  ,  , 
93 ,F ,M ,2 ,2 ,2 ,4 ,3
93 ,F ,F ,  ,  ,  ,  , 
93 ,T ,M ,  ,  ,  ,  , 
93 ,T ,M ,1 ,4 ,3 ,3 ,3
93 ,F ,F ,  ,  ,  ,  , 
93 ,F ,M ,  ,  ,  ,  , 
93 ,F ,F ,3 ,3 ,1 ,2 ,1
93 ,T ,M ,4 ,2 ,2 ,3 ,2
93 ,F ,M ,4 ,4 ,3 ,3 ,3
93 ,F ,F ,1 ,3 ,3 ,1 ,2
93 ,F ,F ,2 ,2 ,4 ,3 ,3
93 ,T ,F ,1 ,4 ,3 ,2 ,2
93 ,T ,M ,  ,  ,  ,  , 
93 ,F ,M ,  ,  ,  ,  , 
93 ,F ,F ,  ,  ,  ,  , 
93 ,F ,F ,  ,  ,  ,  , 
93 ,T ,M ,  ,  ,  ,  , 
93 ,T ,F ,  ,  ,  ,  , 
93 ,T ,M ,1 ,4 ,3 ,3 ,3
93 ,T ,F ,5 ,1 ,4 ,3 ,3
93 ,T ,F ,1 ,3 ,4 ,4 ,4
93 ,F ,M ,1 ,3 ,3 ,1 ,1
93 ,F ,F ,  ,  ,  ,  , 
93 ,T ,F ,5 ,2 ,3 ,3 ,3
93 ,F ,M ,  ,  ,  ,  , 
93 ,T ,M ,  ,  ,  ,  , 
93 ,F ,M ,2 ,3 ,3 ,2 ,2
93 ,F ,M ,  ,  ,  ,  , 
93 ,T ,M ,1 ,2 ,4 ,2 ,3
93 ,F ,F ,1 ,3 ,4 ,2 ,3
93 ,T ,F ,1 ,1 ,3 ,1 ,1
93 ,T ,M ,  ,  ,  ,  , 
93 ,F ,M ,  ,  ,  ,  , 
93 ,F ,M ,3 ,2 ,1 ,2 , 
93 ,F ,F ,4 ,4 ,3 ,2 ,2
93 ,F ,F ,2 ,3 ,3 ,2 ,2
93 ,F ,F ,2 ,2 ,1 ,3 ,1
93 ,T ,M ,  ,  ,  ,  , 
93 ,T ,M ,  ,  ,  ,  , 
93 ,F ,F ,4 ,4 ,3 ,2 ,2
93 ,F ,M ,  ,  ,  ,  , 
93 ,F ,F ,  ,  ,  ,  , 
93 ,T ,F ,3 ,2 ,3 ,1 ,1
93 ,T ,M ,  ,  ,  ,  , 
93 ,T ,M ,  ,  ,  ,  , 
93 ,F ,F ,  ,  ,  ,  , 
93 ,F ,F ,  ,  ,  ,  , 
93 ,T ,F ,2 ,3 ,2 ,2 ,2
93 ,F ,F ,  ,  ,  ,  , 
93 ,T ,M ,5 ,2 ,3 ,3 ,3
93 ,T ,M ,  ,  ,  ,  , 
93 ,F ,M ,2 ,2 ,3 ,3 ,2
93 ,T ,F ,1 ,3 ,4 ,1 ,3
93 ,F ,M ,  ,  ,  ,  , 
93 ,T ,F ,2 ,1 ,3 ,3 ,3
93 ,T ,F ,  ,  ,  ,  , 
93 ,T ,M ,3 ,4 ,4 ,4 ,3
93 ,F ,M ,  ,  ,  ,  , 
93 ,F ,M ,2 ,3 ,2 ,4 ,4
93 ,T ,M ,  ,  ,  ,  , 
93 ,F ,F ,1 ,2 ,4 ,1 ,3
93 ,T ,F ,  ,  ,  ,  , 
93 ,T ,F ,1 ,3 ,3 ,2 ,3
93 ,T ,M ,2 ,1 ,2 ,2 ,2
93 ,T ,M ,  ,  ,  ,  , 
93 ,T ,F ,  ,  ,  ,  , 
93 ,F ,F ,  ,  ,  ,  , 
93 ,T ,F ,  ,  ,  ,  , 
93 ,F ,M ,1 ,2 ,2 ,2 ,3
93 ,F ,F ,3 ,1 ,4 ,2 ,3
93 ,F ,F ,  ,  ,  ,  , 
93 ,F ,F ,1 ,4 ,2 ,3 ,3
93 ,T ,M ,  ,  ,  ,  , 
93 ,F ,F ,2 ,4 ,3 ,4 ,3
93 ,T ,F ,  ,  ,  ,  , 
93 ,F ,F ,  ,  ,  ,  , 
93 ,T ,F ,1 ,4 ,3 ,2 ,3
93 ,T ,F ,  ,  ,  ,  , 
93 ,T ,F ,2 ,2 ,3 ,2 ,2
93 ,T ,F ,  ,  ,  ,  , 
93 ,F ,F ,  ,  ,  ,  , 
93 ,T ,F ,2 ,2 ,3 ,3 ,3
93 ,T ,M ,  ,  ,  ,  , 
93 ,F ,M ,  ,  ,  ,  , 
93 ,F ,F ,  ,  ,  ,  , 
93 ,T ,F ,  ,  ,  ,  , 
93 ,F ,M ,1 ,2 ,3 ,4 ,3
93 ,T ,M ,  ,  ,  ,  , 
93 ,F ,M ,  ,  ,  ,  , 
93 ,F ,F ,  ,  ,  ,  , 
93 ,T ,M ,  ,  ,  ,  , 
93 ,T ,F ,  ,  ,  ,  , 
93 ,F ,F ,  ,  ,  ,  , 
93 ,T ,F ,  ,  ,  ,  , 
93 ,T ,M ,  ,  ,  ,  , 
93 ,T ,M ,  ,  ,  ,  , 
93 ,T ,F ,  ,  ,  ,  , 
93 ,F ,F ,3 ,4 ,3 ,3 ,3
93 ,F ,M ,  ,  ,  ,  , 
93 ,F ,F ,1 ,3 ,3 ,3 ,3
93 ,F ,M ,  ,  ,  ,  , 
93 ,T ,F ,  ,  ,  ,  , 
93 ,F ,F ,  ,  ,  ,  , 
93 ,T ,F ,2 ,4 ,1 ,4 ,4
93 ,F ,F ,3 ,3 ,3 ,1 ,2
93 ,T ,M ,  ,  ,  ,  , 
93 ,F ,M ,1 ,3 ,4 ,2 ,3
93 ,T ,M ,  ,  ,  ,  , 
93 ,F ,F ,  ,  ,  ,  , 
93 ,T ,F ,4 ,2 ,4 ,3 ,4
93 ,T ,M ,  ,  ,  ,  , 
93 ,F ,M ,  ,  ,  ,  , 
93 ,T ,M ,1 ,4 ,4 ,3 ,4
93 ,T ,F ,1 ,4 ,4 ,4 ,3
93 ,T ,F ,  ,  ,  ,  , 
93 ,F ,M ,2 ,4 ,3 ,3 ,4


/* cohort95.dat */

95 ,T ,F ,  ,  ,  ,  , 
95 ,F ,F ,  ,  ,  ,  , 
95 ,T ,M ,  ,  ,  ,  , 
95 ,T ,M ,  ,  ,  ,  , 
95 ,T ,M ,1 ,1 ,4 ,3 ,3
95 ,T ,M ,1 ,4 ,4 ,2 ,3
95 ,F ,F ,  ,  ,  ,  , 
95 ,F ,M ,4 ,3 ,3 ,3 ,2
95 ,T ,M ,1 ,4 ,4 ,3 ,3
95 ,T ,M ,  ,  ,  ,  , 
95 ,T ,F ,  ,  ,  ,  , 
95 ,F ,F ,1 ,4 ,4 ,3 ,4
95 ,T ,M ,  ,  ,  ,  , 
95 ,T ,M ,  ,  ,  ,  , 
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,M ,1 ,4 ,3 ,3 ,3
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,F ,3 ,3 ,3 ,2 ,3
95 ,F ,M ,3 ,2 ,2 ,3 ,3
95 ,F ,F ,2 ,4 ,3 ,1 ,2
95 ,T ,F ,1 ,3 ,3 ,2 ,3
95 ,F ,M ,  ,  ,  ,  , 
95 ,T ,M ,  ,  ,  ,  , 
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,F ,  ,  ,  ,  , 
95 ,F ,F ,2 ,1 ,1 ,3 ,2
95 ,F ,F ,  ,  ,  ,  , 
95 ,T ,M ,4 ,1 ,2 ,1 ,2
95 ,F ,F ,3 ,3 ,4 ,1 ,2
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,F ,  ,  ,  ,  , 
95 ,F ,F ,  ,  ,  ,  , 
95 ,F ,F ,  ,  ,  ,  , 
95 ,T ,M ,  ,  ,  ,  , 
95 ,T ,M ,  ,  ,  ,  , 
95 ,T ,F ,1 ,4 ,4 ,4 ,4
95 ,T ,M ,  ,  ,  ,  , 
95 ,T ,F ,1 ,2 ,4 ,2 ,3
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,M ,  ,  ,  ,  , 
95 ,T ,F ,3 ,3 ,2 ,2 ,2
95 ,F ,F ,3 ,1 ,3 ,1 ,2
95 ,T ,F ,  ,  ,  ,  , 
95 ,F ,F ,  ,  ,  ,  , 
95 ,F ,F ,1 ,4 ,3 ,3 ,3
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,M ,  ,  ,  ,  , 
95 ,T ,F ,4 ,1 ,1 ,1 ,1
95 ,T ,M ,  ,  ,  ,  , 
95 ,F ,M ,  ,  ,  ,  , 
95 ,F ,F ,  ,  ,  ,  , 
95 ,T ,F ,1 ,1 ,3 ,3 ,3
95 ,T ,M ,2 ,2 ,3 ,1 ,2
95 ,F ,F ,2 ,3 ,4 ,1 ,3
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,M ,  ,  ,  ,  , 
95 ,F ,M ,2 ,3 ,2 ,1 ,1
95 ,T ,F ,1 ,1 ,1 ,1 ,2
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,M ,1 ,3 ,4 ,1 ,2
95 ,T ,M ,  ,  ,  ,  , 
95 ,T ,M ,  ,  ,  ,  , 
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,F ,2 ,4 ,4 ,3 ,2
95 ,T ,F ,2 ,2 ,2 ,1 ,2
95 ,F ,M ,2 ,4 ,4 ,4 ,4
95 ,F ,F ,2 ,1 ,2 ,2 ,2
95 ,T ,F ,  ,  ,  ,  , 
95 ,F ,M ,  ,  ,  ,  , 
95 ,T ,M ,5 ,3 ,3 ,2 ,2
95 ,T ,F ,1 ,4 ,4 ,3 ,4
95 ,T ,M ,  ,  ,  ,  , 
95 ,T ,M ,2 ,3 ,3 ,2 ,3
95 ,F ,M ,  ,  ,  ,  , 
95 ,F ,M ,3 ,3 ,2 ,2 ,3
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,M ,3 ,4 ,2 ,2 ,2
95 ,F ,F ,  ,  ,  ,  , 
95 ,F ,F ,4 ,1 ,1 ,1 ,1
95 ,F ,F ,  ,  ,  ,  , 
95 ,F ,M ,  ,  ,  ,  , 
95 ,T ,F ,3 ,1 ,3 ,1 ,2
95 ,F ,F ,  ,  ,  ,  , 
95 ,F ,M ,  ,  ,  ,  , 
95 ,T ,F ,  ,  ,  ,  , 
95 ,F ,F ,  ,  ,  ,  , 
95 ,T ,M ,  ,  ,  ,  , 
95 ,F ,M ,2 ,2 ,1 ,2 ,1
95 ,F ,F ,  ,  ,  ,  , 
95 ,T ,F ,  ,  ,  ,  , 
95 ,F ,F ,5 ,4 ,2 ,3 ,2
95 ,T ,M ,2 ,1 ,1 ,3 ,2
95 ,F ,F ,  ,  ,  ,  , 
95 ,T ,F ,2 ,4 ,4 ,2 ,3
95 ,F ,M ,  ,  ,  ,  , 
95 ,F ,M ,  ,  ,  ,  , 
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,F ,1 ,4 ,4 ,4 ,4
95 ,F ,F ,2 ,3 ,4 ,4 ,4
95 ,F ,F ,3 ,2 ,3 ,1 ,1
95 ,F ,F ,  ,  ,  ,  , 
95 ,F ,M ,  ,  ,  ,  , 
95 ,F ,F ,  ,  ,  ,  , 
95 ,T ,M ,  ,  ,  ,  , 
95 ,F ,M ,3 ,2 ,1 ,4 ,2
95 ,T ,M ,  ,  ,  ,  , 
95 ,T ,M ,  ,  ,  ,  , 
95 ,F ,F ,  ,  ,  ,  , 
95 ,T ,F ,  ,  ,  ,  , 
95 ,F ,M ,  ,  ,  ,  , 
95 ,F ,M ,4 ,2 ,1 ,3 ,1
95 ,F ,M ,1 ,3 ,4 ,3 ,4
95 ,F ,F ,1 ,4 ,3 ,3 ,3
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,M ,  ,  ,  ,  , 
95 ,F ,F ,4 ,1 ,3 ,1 ,2
95 ,T ,M ,  ,  ,  ,  , 
95 ,T ,M ,  ,  ,  ,  , 
95 ,F ,F ,  ,  ,  ,  , 
95 ,F ,M ,2 ,1 ,2 ,1 ,1
95 ,F ,M ,2 ,4 ,2 ,2 ,1
95 ,T ,F ,  ,  ,  ,  , 
95 ,F ,F ,1 ,4 ,3 ,1 ,2
95 ,F ,M ,  ,  ,  ,  , 
95 ,F ,M ,  ,  ,  ,  , 
95 ,F ,M ,  ,  ,  ,  , 
95 ,F ,M ,  ,  ,  ,  , 
95 ,F ,M ,2 ,4 ,1 ,1 ,1
95 ,T ,F ,2 ,1 ,3 ,3 ,3
95 ,T ,M ,  ,  ,  ,  , 
95 ,F ,M ,  ,  ,  ,  , 
95 ,F ,F ,  ,  ,  ,  , 
95 ,F ,F ,1 ,4 ,4 ,2 ,2
95 ,F ,F ,1 ,3 ,3 ,4 ,4
95 ,T ,F ,  ,  ,  ,  , 
95 ,F ,M ,1 ,4 ,3 ,4 ,4
95 ,F ,F ,  ,  ,  ,  , 
95 ,T ,F ,  ,  ,  ,  , 
95 ,F ,F ,3 ,3 ,3 ,1 ,3
95 ,T ,F ,2 ,1 ,3 ,4 ,2
95 ,F ,M ,  ,  ,  ,  , 
95 ,F ,M ,  ,  ,  ,  , 
95 ,T ,M ,1 ,3 ,4 ,3 ,4
95 ,F ,M ,  ,  ,  ,  , 
95 ,F ,F ,1 ,3 ,3 ,4 ,3
95 ,F ,F ,5 ,2 ,4 ,4 ,3
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,F ,2 ,3 ,3 ,1 ,2
95 ,T ,M ,3 ,2 ,3 ,4 ,2
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,F ,  ,  ,  ,  , 
95 ,F ,F ,1 ,3 ,3 ,4 ,3
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,F ,1 ,4 ,4 ,3 ,2
95 ,T ,F ,  ,  ,  ,  , 
95 ,F ,M ,  ,  ,  ,  , 
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,F ,2 ,3 ,3 ,1 ,3
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,F ,3 ,2 ,3 ,1 ,2
95 ,F ,M ,1 ,4 ,4 ,4 ,4
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,F ,5 ,1 ,2 ,2 ,2
95 ,F ,M ,  ,  ,  ,  , 
95 ,F ,M ,  ,  ,  ,  , 
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,F ,2 ,2 ,3 ,3 ,3
95 ,T ,F ,4 ,4 ,3 ,3 ,2
95 ,T ,F ,2 ,4 ,4 ,4 ,4
95 ,T ,F ,  ,  ,  ,  , 
95 ,F ,M ,3 ,2 ,3 ,4 ,3
95 ,F ,F ,2 ,4 ,2 ,3 ,3
95 ,T ,M ,  ,  ,  ,  , 
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,M ,2 ,2 ,  ,  , 
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,M ,1 ,4 ,4 ,3 ,4
95 ,T ,F ,2 ,3 ,3 ,2 ,3
95 ,T ,F ,  ,  ,  ,  , 
95 ,T ,M ,  ,  ,  ,  , 
95 ,T ,F ,3 ,1 ,2 ,1 ,2
95 ,T ,F ,  ,  ,  ,  , 
95 ,F ,M ,  ,  ,  ,  , 
95 ,T ,F ,3 ,1 ,2 ,1 ,1
95 ,F ,F ,1 ,3 ,3 ,3 ,2
95 ,T ,M ,1 ,1 ,4 ,2 ,3
95 ,F ,M ,  ,  ,  ,  , 
95 ,F ,M ,  ,  ,  ,  , 
95 ,T ,M ,3 ,3 ,2 ,1 ,2
95 ,F ,F ,3 ,3 ,2 ,3 ,2
95 ,T ,M ,  ,  ,  ,  , 
95 ,F ,M ,  ,  ,  ,  , 
95 ,T ,F ,2 ,3 ,3 ,2 ,2
95 ,F ,M ,  ,  ,  ,  , 
95 ,T ,F ,  ,  ,  ,  , 
95 ,F ,M ,2 ,3 ,4 ,4 ,4
95 ,F ,M ,2 ,2 ,1 ,1 ,1
95 ,F ,F ,  ,  ,  ,  , 
95 ,F ,F ,1 ,3 ,3 ,3 ,3
95 ,T ,F ,  ,  ,  ,  , 
95 ,F ,M ,  ,  ,  ,  , 
95 ,F ,M ,  ,  ,  ,  , 
95 ,T ,F ,2 ,3 ,4 ,2 ,3
95 ,T ,M ,2 ,4 ,4 ,1 ,3
95 ,T ,F ,1 ,3 ,3 ,1 ,2
95 ,T ,F ,  ,  ,  ,  , 
95 ,F ,M ,  ,  ,  ,  , 
95 ,T ,F ,  ,  ,  ,  , 
95 ,F ,M ,  ,  ,  ,  , 
95 ,T ,M ,1 ,4 ,4 ,3 ,3


/* create_cohortxx.dat */

libname db  'pb hd:book:non ret svy';
filename save1 'pb hd:book:non ret svy:cohort91.dat';
filename save2 'pb hd:book:non ret svy:cohort93.dat';
filename save3 'pb hd:book:non ret svy:cohort95.dat';

data _null_ ;
  set db.cohort91;
file save1;
put cohort ',' studtype ',' sex ',' q01 ',' q09 ',' q16a ',' q16b ',' q16c;

data _null_ ;
  set db.cohort93;
file save2;
put cohort ',' studtype ',' sex ',' q01 ',' q09 ',' q16a ',' q16b ',' q16c;
run;

data _null_ ;
  set db.cohort95;
file save3;
put cohort ',' studtype ',' sex ',' q01 ',' q09 ',' q16a ',' q16b ',' q16c;

run;

/* create_dataxx.dat */

libname  svy     'pb hd:book:gss';
filename save95  'pb hd:book:gss:data95.dat';
filename save96  'pb hd:book:gss:data96.dat';

options nodate;

data svy95;
 set svy.data95;
  q3 = input(a3_g,1.);
  q1a = input(a1_a,1.);
  q1b = input(a1_b,1.);
  q1c = input(a1_c,1.);
 if major in ('ATMS','BIOL','CHEM','PHYS','MATH','ENVR') then discip = 'NS';
else if major in ('CSCI','EDUC','MGMT','ACCT','IEMT','MCOM') then discip = 'PR';
else if major in ('HIST','POLS','ECON','SOC','PSYC') then discip = 'SS';
else if major in ('DRAM','FREN','GERM','SPAN','LIT','PHIL','ART','CLAS',
     'MUSC')  then discip = 'HM';

data svy96;
 set svy.data96;
  q3 = input(a3_g,1.);
  q1a = input(a1_a,1.);
  q1b = input(a1_b,1.);
  q1c = input(a1_c,1.);
if major in ('ATMS','BIOL','CHEM','PHYS','MATH','ENVR') then discip = 'NS';
else if major in ('CSCI','EDUC','MGMT','ACCT','IEMT','MCOM') then discip = 'PR';
else if major in ('HIST','POLS','ECON','SOC','PSYC') then discip = 'SS';
else if major in ('DRAM','FREN','GERM','SPAN','LIT','PHIL','ART','CLAS',
     'MUSC')  then discip = 'HM';

data _null_ ;
  set svy95;
file save95;
put major ',' year ',' sex ',' discip ',' a1_a ',' a1_b ',' a1_c ',' q3 ','
    a4_a ',' a4_b ','  admtype ',' cumgpa ','  race ',' q1a ',' q1b ','
    q1c  ;

data _null_ ;
  set svy96;
file save96;
put major ',' year ',' sex ',' discip ',' a1_a ',' a1_b ',' a1_c ',' q3 ','
     a4_a ',' a4_b ','  admtype ',' cumgpa ','  race ',' q1a ',' q1b ','
     q1c ;
run;


/* create_dbxx.dat */

libname library 'pb hd:book:new student svy';
filename save96 'pb hd:book:new student svy:db96.dat';
filename save95 'pb hd:book:new student svy:db95.dat';
filename save94 'pb hd:book:new student svy:db94.dat';
filename save93 'pb hd:book:new student svy:db93.dat';
filename save92 'pb hd:book:new student svy:db92.dat';
filename save91 'pb hd:book:new student svy:db91.dat';
filename save90 'pb hd:book:new student svy:db90.dat';

options nodate nonumber ps=65 ls=80;

data _null_ ;
  set library.db96;
file save96;
put apply1 ',' apply2 ',' apply3   ','  apply4 ','  apply5 ',' area   ','
    atunca ',' choice ',' employed ','  goal01 ','  goal02 ',' goal03 ','
    goal04 ',' goal05 ',' goal06   ','  hours  ','  income ',' maeduc ','
    n_coll ',' paeduc ',' tstudent ','  year   ','  credhrld;

data _null_ ;
  set library.db95;
file save95;
put apply1 ',' apply2 ',' apply3   ','  apply4 ','  apply5 ',' area   ','
    atunca ',' choice ',' employed ','  goal01 ','  goal02 ',' goal03 ','
    goal04 ',' goal05 ',' goal06   ','  hours  ','  income ',' maeduc ','
    n_coll ',' paeduc ',' tstudent ','  year   ','  credhrld;

data _null_ ;
  set library.db94;
file save94;
 put apply1 ',' apply2 ',' apply3   ','  apply4 ','  apply5 ',' area   ','
    atunca ',' choice ',' employed ','  goal01 ','  goal02 ',' goal03 ','
    goal04 ',' goal05 ',' goal06   ','  hours  ','  income ',' maeduc ','
    n_coll ',' paeduc ',' tstudent ','  year   ','  credhrld;

 data _null_ ;
  set library.db93;
file save93;
put apply1 ',' apply2 ',' apply3   ','  apply4 ','  apply5 ',' area   ','
    atunca ',' choice ',' employed ','  goal01 ','  goal02 ',' goal03 ','
    goal04 ',' goal05 ',' goal06   ','  hours  ','  income ',' maeduc ','
    n_coll ',' paeduc ',' tstudent ','  year   ','  credhrld;

data _null_ ;
  set library.db92;
file save92;
put apply1 ',' apply2 ',' apply3   ','  apply4 ','  apply5 ',' area   ','
    atunca ',' choice ',' employed ','  goal01 ','  goal02 ',' goal03 ','
    goal04 ',' goal05 ',' goal06   ','  hours  ','  income ',' maeduc ','
    n_coll ',' paeduc ',' tstudent ','  year   ','  credhrld;

 data _null_ ;
  set library.db91;
file save91;
 put apply1 ',' apply2 ',' apply3   ','  apply4 ','  apply5 ',' area   ','
    atunca ',' choice ',' employed ','  goal01 ','  goal02 ',' goal03 ','
    goal04 ',' goal05 ',' goal06   ','  hours  ','  income ',' maeduc ','
    n_coll ',' paeduc ',' tstudent ','  year   ','  credhrld;

data _null_ ;
  set library.db90;
file save90;
put apply1 ',' apply2 ',' apply3   ','  apply4 ','  apply5 ',' area   ','
    atunca ',' choice ',' employed ','  goal01 ','  goal02 ',' goal03 ','
    goal04 ',' goal05 ',' goal06   ','  hours  ','  income ',' maeduc ','
    n_coll ',' paeduc ',' tstudent ','  year   ','  credhrld;
run;

/* create_progeval.dat */

libname library 'pb hd:book:prog assess svy';
filename saveit 'pb hd:book:prog assess svy:progeval.dat';

data _null_ ;
 set library.progeval;
 file saveit;
put major  ','  q2l  ','  qb01;
run;


/* create_survey96.dat */

libname db       'PB HD:book:stud exp svy';
 filename saveit 'PB HD:book:stud exp svy:survey96.dat';

 data survey;
  set db.survey96;
if region = 'E' then region = 'P';
 if q10a=. then q10a = 0;
hrswrk = q10a;

 data _null_ ;
  set survey;
file saveit;
put
q01     ','  region  ','  dorm    ','  q14     ','  q15_01  ','  q15_02  ','
q15_03  ','  q15_04  ','  q15_05  ','  q15_06  ','  q15_07  ','  q15_08  ','
q15_09  ','  q15_10  ','  q15_11  ','  q19a    ','  q19b    ','  q19c    ','
q19d    ','  q22a_a  ','  q22a_b  ','  q22a_c  ','  q22a_d  ','  q22a_e  ','
q22a_f  ','  q22a_g  ','  q22a_h  ','  q22a_i  ','  q22a_j  ','  q22a_k  ','
q22a_l  ','  q22b_a  ','  q22b_b  ','  q22b_c  ','  q22b_d  ','  q22b_e  ','
q22b_f  ','  q22b_g  ','  q22b_h  ','  q22b_i  ','  q22b_j  ','  q22b_k  ','
q22b_l  ','  hrswrk
;
run;

/* data95.dat */

  ,95 ,  ,  ,  ,  ,  ,. ,  ,  ,  ,. ,  ,. ,. ,.
MUSC ,95 ,M ,HM ,3 ,2 ,2 ,3 ,  ,  ,TR ,3.58 ,W ,3 ,2 ,2
ACCT ,95 ,M ,PR ,3 ,4 ,2 ,3 ,1 ,1 ,NR ,3.02 ,W ,3 ,4 ,2
  ,95 ,  ,  ,4 ,  ,4 ,. ,1 ,  ,  ,. ,  ,4 ,. ,4
MUSC ,95 ,M ,HM ,4 ,2 ,4 ,1 ,2 ,2 ,NR ,3.27 ,W ,4 ,2 ,4
PSYC ,95 ,F ,SS ,4 ,4 ,4 ,3 ,1 ,1 ,NR ,3.39 ,W ,4 ,4 ,4
MGMT ,95 ,F ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,TR ,3.11 ,W ,3 ,3 ,3
MGMT ,95 ,M ,PR ,3 ,3 ,4 ,4 ,1 ,1 ,TR ,2.71 ,W ,3 ,3 ,4
MCOM ,95 ,F ,PR ,3 ,2 ,4 ,4 ,1 ,1 ,TR ,3.08 ,W ,3 ,2 ,4
MGMT ,95 ,M ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,TR ,3.31 ,W ,3 ,3 ,3
BIOL ,95 ,M ,NS ,4 ,3 ,2 ,. ,  ,  ,TR ,3.51 ,W ,4 ,3 ,2
MGMT ,95 ,M ,PR ,3 ,3 ,3 ,3 ,2 ,1 ,TR ,2.67 ,W ,3 ,3 ,3
MCOM ,95 ,F ,PR ,3 ,4 ,3 ,1 ,1 ,1 ,TR ,2.81 ,W ,3 ,4 ,3
PSYC ,95 ,F ,SS ,3 ,4 ,3 ,. ,1 ,1 ,TR ,3.69 ,W ,3 ,4 ,3
MGMT ,95 ,M ,PR ,4 ,3 ,4 ,3 ,1 ,1 ,TR ,3.36 ,W ,4 ,3 ,4
SPAN ,95 ,F ,HM ,4 ,2 ,4 ,3 ,1 ,  ,TR ,3.27 ,W ,4 ,2 ,4
MGMT ,95 ,M ,PR ,4 ,3 ,3 ,3 ,1 ,1 ,NR ,2.83 ,W ,4 ,3 ,3
DRAM ,95 ,F ,HM ,3 ,3 ,4 ,1 ,1 ,1 ,NR ,3.04 ,W ,3 ,3 ,4
ENVR ,95 ,F ,NS ,4 ,4 ,3 ,2 ,1 ,1 ,TR ,3.03 ,W ,4 ,4 ,3
ENVR ,95 ,F ,NS ,4 ,3 ,4 ,2 ,1 ,1 ,TR ,2.44 ,W ,4 ,3 ,4
POLS ,95 ,M ,SS ,3 ,1 ,4 ,. ,2 ,  ,NR ,2.13 ,B ,3 ,1 ,4
ENVR ,95 ,M ,NS ,3 ,3 ,3 ,3 ,1 ,1 ,TR ,2.7 ,W ,3 ,3 ,3
PSYC ,95 ,M ,SS ,4 ,2 ,3 ,3 ,1 ,2 ,CT ,2.98 ,W ,4 ,2 ,3
MGMT ,95 ,M ,PR ,3 ,2 ,4 ,2 ,2 ,1 ,TR ,2.54 ,W ,3 ,2 ,4
MUSC ,95 ,M ,HM ,2 ,1 ,2 ,1 ,2 ,2 ,TR ,3.11 ,W ,2 ,1 ,2
MGMT ,95 ,M ,PR ,3 ,2 ,3 ,4 ,1 ,1 ,NR ,2.24 ,W ,3 ,2 ,3
ATMS ,95 ,M ,NS ,3 ,2 ,4 ,3 ,1 ,1 ,NR ,2.5 ,W ,3 ,2 ,4
LIT ,95 ,F ,HM ,2 ,3 ,3 ,3 ,1 ,1 ,NR ,2.9 ,W ,2 ,3 ,3
MGMT ,95 ,M ,PR ,4 ,2 ,4 ,4 ,1 ,2 ,NR ,3.29 ,W ,4 ,2 ,4
BIOL ,95 ,M ,NS ,4 ,4 ,4 ,4 ,1 ,1 ,TR ,3.77 ,W ,4 ,4 ,4
ACCT ,95 ,F ,PR ,3 ,3 ,3 ,4 ,1 ,1 ,TR ,2.7 ,W ,3 ,3 ,3
LIT ,95 ,M ,HM ,4 ,4 ,4 ,3 ,1 ,1 ,TR ,3.68 ,W ,4 ,4 ,4
MATH ,95 ,F ,NS ,3 ,1 ,1 ,2 ,1 ,1 ,TR ,3.55 ,W ,3 ,1 ,1
BIOL ,95 ,F ,NS ,3 ,3 ,3 ,4 ,1 ,1 ,NR ,3.56 ,W ,3 ,3 ,3
MGMT ,95 ,F ,PR ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,3.34 ,W ,4 ,3 ,4
SOC ,95 ,F ,SS ,2 ,2 ,3 ,4 ,2 ,2 ,NR ,3.3 ,W ,2 ,2 ,3
PSYC ,95 ,F ,SS ,3 ,3 ,3 ,3 ,1 ,1 ,NR ,3.78 ,W ,3 ,3 ,3
MUSC ,95 ,F ,HM ,4 ,4 ,2 ,2 ,1 ,1 ,TR ,2.88 ,W ,4 ,4 ,2
ACCT ,95 ,F ,PR ,4 ,4 ,3 ,4 ,1 ,1 ,NR ,3.73 ,W ,4 ,4 ,3
ECON ,95 ,M ,SS ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,3.04 ,A ,4 ,3 ,4
ECON ,95 ,M ,SS ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,3.04 ,A ,4 ,3 ,4
SPAN ,95 ,M ,HM ,3 ,3 ,3 ,4 ,1 ,2 ,NR ,2.6 ,S ,3 ,3 ,3
MGMT ,95 ,F ,PR ,3 ,3 ,3 ,3 ,2 ,1 ,NR ,3.08 ,W ,3 ,3 ,3
BIOL ,95 ,M ,NS ,3 ,3 ,4 ,4 ,1 ,1 ,NR ,2.27 ,W ,3 ,3 ,4
CSCI ,95 ,F ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,NR ,2.27 ,A ,3 ,3 ,3
SOC ,95 ,M ,SS ,4 ,2 ,4 ,3 ,1 ,1 ,CT ,2.18 ,W ,4 ,2 ,4
ECON ,95 ,M ,SS ,4 ,4 ,4 ,4 ,1 ,1 ,NR ,3.16 ,W ,4 ,4 ,4
SOC ,95 ,F ,SS ,3 ,2 ,3 ,4 ,1 ,1 ,NR ,2.78 ,W ,3 ,2 ,3
MGMT ,95 ,F ,PR ,4 ,2 ,3 ,3 ,1 ,1 ,NR ,3.07 ,W ,4 ,2 ,3
BIOL ,95 ,F ,NS ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,3.33 ,W ,4 ,3 ,4
MATH ,95 ,M ,NS ,4 ,2 ,4 ,3 ,  ,  ,NR ,2.85 ,W ,4 ,2 ,4
BIOL ,95 ,M ,NS ,3 ,2 ,4 ,2 ,1 ,1 ,NR ,2.81 ,B ,3 ,2 ,4
MGMT ,95 ,M ,PR ,4 ,3 ,4 ,2 ,1 ,1 ,TR ,4 ,W ,4 ,3 ,4
MGMT ,95 ,M ,PR ,3 ,2 ,3 ,. ,  ,  ,TR ,2.12 ,W ,3 ,2 ,3
CLAS ,95 ,F ,HM ,2 ,2 ,2 ,4 ,1 ,1 ,TR ,2.87 ,W ,2 ,2 ,2
LIT ,95 ,F ,HM ,4 ,2 ,3 ,4 ,1 ,1 ,TR ,2.98 ,W ,4 ,2 ,3
SOC ,95 ,F ,SS ,2 ,2 ,2 ,3 ,1 ,1 ,NR ,2.47 ,W ,2 ,2 ,2
MATH ,95 ,F ,NS ,3 ,3 ,4 ,4 ,1 ,1 ,NR ,2.95 ,W ,3 ,3 ,4
ACCT ,95 ,F ,PR ,4 ,4 ,4 ,4 ,1 ,1 ,TR ,4 ,W ,4 ,4 ,4
PSYC ,95 ,F ,SS ,4 ,4 ,3 ,4 ,1 ,1 ,NR ,3.24 ,W ,4 ,4 ,3
POLS ,95 ,M ,SS ,4 ,  ,  ,4 ,1 ,1 ,NR ,2.4 ,W ,4 ,. ,.
HIST ,95 ,M ,SS ,3 ,3 ,4 ,3 ,2 ,1 ,NR ,2.63 ,W ,3 ,3 ,4
PSYC ,95 ,F ,SS ,3 ,4 ,3 ,3 ,1 ,1 ,NR ,3.85 ,W ,3 ,4 ,3
SOC ,95 ,M ,SS ,4 ,3 ,4 ,. ,1 ,1 ,NR ,3.28 ,S ,4 ,3 ,4
BIOL ,95 ,F ,NS ,4 ,4 ,4 ,3 ,1 ,1 ,CT ,3.78 ,W ,4 ,4 ,4
ART ,95 ,M ,HM ,3 ,2 ,3 ,2 ,2 ,2 ,TR ,2.95 ,W ,3 ,2 ,3
MGMT ,95 ,F ,PR ,3 ,4 ,3 ,3 ,1 ,1 ,TR ,3 ,W ,3 ,4 ,3
ACCT ,95 ,F ,PR ,4 ,4 ,4 ,2 ,1 ,1 ,TR ,3.01 ,W ,4 ,4 ,4
ACCT ,95 ,M ,PR ,3 ,3 ,2 ,2 ,1 ,1 ,TR ,3.42 ,A ,3 ,3 ,2
CSCI ,95 ,M ,PR ,3 ,4 ,3 ,4 ,1 ,1 ,NR ,3.31 ,W ,3 ,4 ,3
POLS ,95 ,F ,SS ,4 ,4 ,4 ,4 ,1 ,1 ,NR ,3.78 ,W ,4 ,4 ,4
BIOL ,95 ,F ,NS ,3 ,3 ,4 ,4 ,1 ,1 ,NR ,2.49 ,W ,3 ,3 ,4
PSYC ,95 ,F ,SS ,4 ,3 ,4 ,3 ,1 ,2 ,TR ,2.69 ,W ,4 ,3 ,4
ACCT ,95 ,M ,PR ,3 ,4 ,4 ,4 ,1 ,1 ,NR ,3.59 ,W ,3 ,4 ,4
MGMT ,95 ,F ,PR ,4 ,4 ,4 ,2 ,1 ,1 ,NR ,3.73 ,W ,4 ,4 ,4
ATMS ,95 ,F ,NS ,3 ,3 ,3 ,4 ,2 ,1 ,NR ,3.28 ,W ,3 ,3 ,3
ACCT ,95 ,F ,PR ,4 ,4 ,3 ,3 ,1 ,1 ,TR ,3.91 ,W ,4 ,4 ,3
LIT ,95 ,F ,HM ,3 ,4 ,4 ,2 ,1 ,1 ,NR ,3.66 ,W ,3 ,4 ,4
MGMT ,95 ,F ,PR ,3 ,2 ,4 ,3 ,1 ,1 ,NR ,2.66 ,W ,3 ,2 ,4
ATMS ,95 ,M ,NS ,3 ,4 ,3 ,4 ,1 ,1 ,NR ,3 ,W ,3 ,4 ,3
PSYC ,95 ,F ,SS ,3 ,3 ,2 ,0 ,2 ,1 ,TR ,2.31 ,B ,3 ,3 ,2
MCOM ,95 ,M ,PR ,3 ,3 ,3 ,4 ,1 ,1 ,TR ,3.41 ,W ,3 ,3 ,3
ATMS ,95 ,M ,NS ,3 ,3 ,4 ,2 ,1 ,1 ,TR ,2.98 ,W ,3 ,3 ,4
ART ,95 ,M ,HM ,3 ,1 ,4 ,4 ,1 ,1 ,NR ,3.07 ,W ,3 ,1 ,4
DRAM ,95 ,F ,HM ,3 ,2 ,4 ,4 ,1 ,1 ,NR ,3.5 ,W ,3 ,2 ,4
MGMT ,95 ,M ,PR ,4 ,2 ,2 ,3 ,1 ,1 ,NR ,2.15 ,W ,4 ,2 ,2
MGMT ,95 ,M ,PR ,3 ,3 ,4 ,3 ,1 ,1 ,NR ,2.5 ,W ,3 ,3 ,4
ART ,95 ,F ,HM ,4 ,4 ,4 ,4 ,1 ,1 ,TR ,2.48 ,W ,4 ,4 ,4
BIOL ,95 ,F ,NS ,4 ,3 ,3 ,4 ,1 ,1 ,NR ,3.12 ,W ,4 ,3 ,3
PSYC ,95 ,F ,SS ,4 ,2 ,4 ,0 ,1 ,2 ,TR ,3.47 ,W ,4 ,2 ,4
MCOM ,95 ,M ,PR ,3 ,4 ,3 ,4 ,  ,1 ,CT ,2.77 ,W ,3 ,4 ,3
LIT ,95 ,F ,HM ,3 ,2 ,1 ,1 ,1 ,1 ,NR ,3.66 ,W ,3 ,2 ,1
SOC ,95 ,F ,SS ,4 ,3 ,4 ,3 ,1 ,1 ,CF ,2.16 ,I ,4 ,3 ,4
PSYC ,95 ,F ,SS ,4 ,3 ,3 ,3 ,2 ,2 ,TR ,3.12 ,W ,4 ,3 ,3
PSYC ,95 ,F ,SS ,4 ,3 ,4 ,3 ,1 ,2 ,TR ,2.7 ,W ,4 ,3 ,4
MCOM ,95 ,F ,PR ,4 ,4 ,4 ,4 ,1 ,1 ,NR ,3.57 ,S ,4 ,4 ,4
PHYS ,95 ,M ,NS ,4 ,3 ,4 ,4 ,  ,1 ,NR ,3.85 ,W ,4 ,3 ,4
PSYC ,95 ,F ,SS ,4 ,4 ,4 ,0 ,1 ,  ,TR ,3.72 ,W ,4 ,4 ,4
CSCI ,95 ,F ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,TR ,2.27 ,W ,3 ,3 ,3
PSYC ,95 ,F ,SS ,3 ,2 ,3 ,3 ,1 ,2 ,NR ,2.19 ,W ,3 ,2 ,3
POLS ,95 ,F ,SS ,3 ,2 ,3 ,2 ,1 ,2 ,NR ,2.64 ,W ,3 ,2 ,3
MGMT ,95 ,M ,PR ,3 ,2 ,4 ,4 ,1 ,1 ,TR ,3.71 ,W ,3 ,2 ,4
MATH ,95 ,F ,NS ,2 ,3 ,2 ,4 ,1 ,2 ,NR ,2.76 ,W ,2 ,3 ,2
PHYS ,95 ,M ,NS ,3 ,2 ,3 ,4 ,2 ,2 ,NR ,2.98 ,W ,3 ,2 ,3
ATMS ,95 ,M ,NS ,4 ,3 ,3 ,4 ,1 ,1 ,NR ,3.22 ,W ,4 ,3 ,3
PSYC ,95 ,M ,SS ,4 ,3 ,4 ,2 ,1 ,1 ,CF ,3.65 ,W ,4 ,3 ,4
MCOM ,95 ,F ,PR ,3 ,4 ,2 ,3 ,2 ,2 ,TR ,3.15 ,W ,3 ,4 ,2
BIOL ,95 ,F ,NS ,4 ,3 ,3 ,3 ,1 ,1 ,TR ,3.1 ,W ,4 ,3 ,3
PSYC ,95 ,F ,SS ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,2.49 ,W ,4 ,3 ,4
PHIL ,95 ,M ,HM ,4 ,2 ,4 ,4 ,1 ,1 ,TR ,3.8 ,W ,4 ,2 ,4
SOC ,95 ,F ,SS ,4 ,3 ,3 ,1 ,1 ,1 ,CT ,3.14 ,W ,4 ,3 ,3
MGMT ,95 ,F ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,TR ,2.41 ,W ,3 ,3 ,3
PSYC ,95 ,F ,SS ,4 ,4 ,4 ,4 ,1 ,1 ,NR ,3.74 ,W ,4 ,4 ,4
CSCI ,95 ,F ,PR ,3 ,2 ,3 ,4 ,1 ,1 ,NR ,2.35 ,W ,3 ,2 ,3
MUSC ,95 ,M ,HM ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,2.52 ,B ,4 ,3 ,4
POLS ,95 ,F ,SS ,4 ,3 ,4 ,3 ,1 ,1 ,NR ,3.74 ,W ,4 ,3 ,4
CHEM ,95 ,M ,NS ,3 ,  ,  ,2 ,2 ,1 ,NR ,3.46 ,W ,3 ,. ,.
ECON ,95 ,F ,SS ,2 ,2 ,3 ,3 ,2 ,2 ,NR ,2.18 ,W ,2 ,2 ,3
LIT ,95 ,M ,HM ,3 ,2 ,3 ,2 ,1 ,1 ,TR ,2.89 ,W ,3 ,2 ,3
ACCT ,95 ,M ,PR ,3 ,3 ,4 ,4 ,1 ,1 ,CF ,2.79 ,W ,3 ,3 ,4
LIT ,95 ,F ,HM ,4 ,4 ,4 ,3 ,1 ,1 ,TR ,3.07 ,W ,4 ,4 ,4
ACCT ,95 ,F ,PR ,3 ,2 ,3 ,2 ,1 ,1 ,NR ,3.69 ,W ,3 ,2 ,3
PSYC ,95 ,F ,SS ,3 ,3 ,3 ,2 ,1 ,1 ,NR ,2.98 ,W ,3 ,3 ,3
HIST ,95 ,M ,SS ,3 ,3 ,3 ,3 ,2 ,1 ,NR ,2.53 ,W ,3 ,3 ,3
PSYC ,95 ,F ,SS ,3 ,4 ,2 ,2 ,1 ,1 ,NR ,3.3 ,W ,3 ,4 ,2
SOC ,95 ,F ,SS ,4 ,2 ,3 ,1 ,1 ,1 ,NR ,2.69 ,I ,4 ,2 ,3
MGMT ,95 ,M ,PR ,3 ,2 ,3 ,3 ,1 ,1 ,TR ,3.04 ,A ,3 ,2 ,3
ACCT ,95 ,F ,PR ,4 ,2 ,4 ,3 ,1 ,1 ,NR ,3.95 ,W ,4 ,2 ,4
ART ,95 ,F ,HM ,3 ,3 ,3 ,1 ,1 ,1 ,CT ,3.77 ,W ,3 ,3 ,3
LIT ,95 ,F ,HM ,4 ,4 ,3 ,3 ,1 ,1 ,CT ,3.14 ,W ,4 ,4 ,3
MGMT ,95 ,F ,PR ,4 ,3 ,4 ,3 ,1 ,1 ,TR ,2.29 ,W ,4 ,3 ,4
SOC ,95 ,F ,SS ,3 ,2 ,2 ,1 ,2 ,1 ,TR ,2.83 ,W ,3 ,2 ,2
SOC ,95 ,M ,SS ,4 ,2 ,4 ,2 ,1 ,1 ,CF ,3 ,W ,4 ,2 ,4
CHEM ,95 ,M ,NS ,3 ,3 ,3 ,3 ,1 ,1 ,NR ,3.55 ,W ,3 ,3 ,3
ENVR ,95 ,F ,NS ,3 ,2 ,3 ,3 ,1 ,1 ,TR ,3.26 ,W ,3 ,2 ,3
CHEM ,95 ,F ,NS ,3 ,2 ,4 ,3 ,1 ,1 ,NR ,2.81 ,W ,3 ,2 ,4
HIST ,95 ,F ,SS ,3 ,4 ,4 ,3 ,1 ,1 ,NR ,2.11 ,W ,3 ,4 ,4
PSYC ,95 ,F ,SS ,3 ,2 ,3 ,2 ,1 ,1 ,NR ,2.65 ,W ,3 ,2 ,3
HIST ,95 ,F ,SS ,3 ,2 ,4 ,4 ,1 ,1 ,NR ,2.5 ,W ,3 ,2 ,4
MGMT ,95 ,M ,PR ,3 ,3 ,3 ,3 ,1 ,2 ,NR ,2.81 ,W ,3 ,3 ,3
CSCI ,95 ,F ,PR ,4 ,3 ,3 ,4 ,1 ,1 ,NR ,3.73 ,W ,4 ,3 ,3
ECON ,95 ,M ,SS ,4 ,2 ,4 ,4 ,1 ,1 ,NR ,2.75 ,W ,4 ,2 ,4
BIOL ,95 ,M ,NS ,3 ,3 ,4 ,3 ,1 ,1 ,NR ,3 ,W ,3 ,3 ,4
PSYC ,95 ,F ,SS ,3 ,2 ,3 ,2 ,1 ,1 ,NR ,3.77 ,W ,3 ,2 ,3
PSYC ,95 ,F ,SS ,3 ,3 ,3 ,4 ,1 ,1 ,TR ,2.87 ,W ,3 ,3 ,3
BIOL ,95 ,F ,NS ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,2.62 ,W ,4 ,3 ,4
MGMT ,95 ,M ,PR ,4 ,3 ,4 ,3 ,1 ,2 ,TR ,3.14 ,W ,4 ,3 ,4
PSYC ,95 ,F ,SS ,3 ,3 ,4 ,4 ,1 ,1 ,NR ,2.67 ,W ,3 ,3 ,4
SPAN ,95 ,F ,HM ,3 ,3 ,3 ,3 ,1 ,1 ,NR ,2.81 ,B ,3 ,3 ,3
ART ,95 ,F ,HM ,4 ,4 ,4 ,2 ,1 ,1 ,NR ,2.66 ,W ,4 ,4 ,4
PSYC ,95 ,F ,SS ,4 ,3 ,4 ,3 ,1 ,2 ,TR ,3.66 ,W ,4 ,3 ,4
PSYC ,95 ,F ,SS ,4 ,3 ,3 ,2 ,2 ,2 ,NR ,3.57 ,W ,4 ,3 ,3
BIOL ,95 ,F ,NS ,4 ,3 ,4 ,3 ,1 ,2 ,NR ,3.42 ,W ,4 ,3 ,4
LIT ,95 ,F ,HM ,3 ,3 ,3 ,4 ,1 ,1 ,NR ,3.3 ,W ,3 ,3 ,3
ENVR ,95 ,F ,NS ,4 ,2 ,2 ,3 ,2 ,2 ,TR ,3.05 ,W ,4 ,2 ,2
ACCT ,95 ,F ,PR ,4 ,4 ,4 ,3 ,1 ,1 ,TR ,3.78 ,W ,4 ,4 ,4
LIT ,95 ,F ,HM ,3 ,1 ,2 ,3 ,1 ,1 ,TR ,3.01 ,W ,3 ,1 ,2
PSYC ,95 ,F ,SS ,4 ,3 ,4 ,3 ,1 ,1 ,NR ,3.57 ,W ,4 ,3 ,4
PSYC ,95 ,F ,SS ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,3.14 ,W ,4 ,3 ,4
MGMT ,95 ,M ,PR ,2 ,2 ,2 ,. ,1 ,1 ,CT ,2.81 ,W ,2 ,2 ,2
MCOM ,95 ,F ,PR ,4 ,3 ,3 ,4 ,1 ,1 ,NR ,2.76 ,W ,4 ,3 ,3
MGMT ,95 ,F ,PR ,4 ,2 ,4 ,4 ,1 ,2 ,TR ,3.07 ,W ,4 ,2 ,4
MGMT ,95 ,F ,PR ,3 ,3 ,4 ,4 ,1 ,1 ,TR ,2.85 ,W ,3 ,3 ,4
ART ,95 ,F ,HM ,4 ,3 ,3 ,2 ,1 ,1 ,CT ,3.21 ,W ,4 ,3 ,3
MGMT ,95 ,M ,PR ,4 ,3 ,4 ,4 ,2 ,1 ,TR ,2.33 ,W ,4 ,3 ,4
BIOL ,95 ,F ,NS ,4 ,2 ,4 ,3 ,1 ,1 ,NR ,3.56 ,W ,4 ,2 ,4
ART ,95 ,F ,HM ,4 ,3 ,3 ,3 ,1 ,1 ,TR ,3.54 ,W ,4 ,3 ,3
BIOL ,95 ,F ,NS ,3 ,2 ,3 ,3 ,1 ,1 ,TR ,3.5 ,W ,3 ,2 ,3
ATMS ,95 ,M ,NS ,4 ,4 ,3 ,4 ,1 ,1 ,NR ,3.91 ,W ,4 ,4 ,3
ATMS ,95 ,M ,NS ,3 ,4 ,4 ,3 ,1 ,1 ,NR ,3.07 ,W ,3 ,4 ,4
ACCT ,95 ,M ,PR ,4 ,4 ,3 ,3 ,1 ,1 ,TR ,3.73 ,W ,4 ,4 ,3
MGMT ,95 ,F ,PR ,4 ,3 ,4 ,3 ,1 ,1 ,NR ,2.78 ,W ,4 ,3 ,4
CSCI ,95 ,M ,PR ,3 ,2 ,  ,4 ,1 ,1 ,CF ,2.38 ,W ,3 ,2 ,.
PSYC ,95 ,F ,SS ,4 ,3 ,4 ,2 ,1 ,1 ,TR ,4 ,W ,4 ,3 ,4
LIT ,95 ,F ,HM ,4 ,3 ,4 ,3 ,1 ,1 ,TR ,3.36 ,W ,4 ,3 ,4
CLAS ,95 ,M ,HM ,4 ,4 ,4 ,0 ,1 ,1 ,TR ,4 ,W ,4 ,4 ,4
ACCT ,95 ,F ,PR ,4 ,3 ,4 ,2 ,1 ,1 ,TR ,2.83 ,W ,4 ,3 ,4
SOC ,95 ,F ,SS ,3 ,1 ,4 ,3 ,1 ,2 ,TR ,2.18 ,W ,3 ,1 ,4
HIST ,95 ,M ,SS ,3 ,2 ,4 ,2 ,1 ,1 ,TR ,3.4 ,W ,3 ,2 ,4
MGMT ,95 ,F ,PR ,4 ,4 ,4 ,4 ,1 ,2 ,TR ,3.79 ,W ,4 ,4 ,4
BIOL ,95 ,F ,NS ,4 ,3 ,3 ,4 ,1 ,1 ,NR ,2.69 ,W ,4 ,3 ,3
MATH ,95 ,F ,NS ,4 ,2 ,4 ,2 ,2 ,1 ,TR ,2.66 ,W ,4 ,2 ,4
ENVR ,95 ,M ,NS ,  ,  ,  ,3 ,1 ,2 ,TR ,3.09 ,W ,. ,. ,.
FREN ,95 ,F ,HM ,4 ,3 ,4 ,2 ,1 ,1 ,TR ,3.85 ,W ,4 ,3 ,4
MGMT ,95 ,F ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,NR ,2.19 ,W ,3 ,3 ,3
PSYC ,95 ,F ,SS ,4 ,3 ,4 ,2 ,1 ,2 ,TR ,2.99 ,W ,4 ,3 ,4
MATH ,95 ,F ,NS ,3 ,4 ,2 ,2 ,  ,  ,NR ,2.7 ,W ,3 ,4 ,2
ATMS ,95 ,M ,NS ,4 ,2 ,4 ,3 ,1 ,1 ,TR ,3.95 ,W ,4 ,2 ,4
SPAN ,95 ,M ,HM ,3 ,3 ,3 ,1 ,1 ,1 ,TR ,3.35 ,S ,3 ,3 ,3
ATMS ,95 ,M ,NS ,3 ,3 ,3 ,4 ,1 ,1 ,NR ,3.2 ,B ,3 ,3 ,3
PSYC ,95 ,F ,SS ,3 ,3 ,3 ,3 ,1 ,1 ,NR ,2.88 ,W ,3 ,3 ,3
PSYC ,95 ,F ,SS ,4 ,3 ,4 ,3 ,1 ,1 ,NR ,3.81 ,W ,4 ,3 ,4
BIOL ,95 ,M ,NS ,3 ,4 ,3 ,4 ,1 ,1 ,TR ,2.48 ,W ,3 ,4 ,3
CHEM ,95 ,F ,NS ,3 ,3 ,3 ,3 ,1 ,1 ,TR ,3.88 ,W ,3 ,3 ,3
ECON ,95 ,M ,SS ,3 ,3 ,3 ,3 ,1 ,1 ,TR ,2.07 ,W ,3 ,3 ,3
ACCT ,95 ,M ,PR ,3 ,2 ,3 ,4 ,2 ,1 ,NR ,3.73 ,W ,3 ,2 ,3
HIST ,95 ,F ,SS ,4 ,  ,4 ,2 ,  ,  ,TR ,3.44 ,W ,4 ,. ,4
MGMT ,95 ,M ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,NR ,2.18 ,W ,3 ,3 ,3
POLS ,95 ,F ,SS ,2 ,2 ,3 ,4 ,2 ,1 ,NR ,2.22 ,B ,2 ,2 ,3
MGMT ,95 ,M ,PR ,3 ,3 ,3 ,4 ,1 ,1 ,NR ,3.46 ,W ,3 ,3 ,3
ENVR ,95 ,F ,NS ,3 ,2 ,3 ,2 ,1 ,2 ,TR ,2.97 ,W ,3 ,2 ,3
POLS ,95 ,F ,SS ,4 ,3 ,2 ,4 ,1 ,1 ,TR ,3.39 ,W ,4 ,3 ,2
MGMT ,95 ,M ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,NR ,2.92 ,W ,3 ,3 ,3
BIOL ,95 ,F ,NS ,4 ,2 ,2 ,2 ,1 ,1 ,NR ,2.98 ,W ,4 ,2 ,2
CSCI ,95 ,F ,PR ,3 ,3 ,3 ,4 ,1 ,1 ,TR ,2.45 ,W ,3 ,3 ,3
BIOL ,95 ,F ,NS ,3 ,1 ,3 ,3 ,1 ,1 ,TR ,3.46 ,W ,3 ,1 ,3
MCOM ,95 ,F ,PR ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,3.26 ,W ,4 ,3 ,4
MGMT ,95 ,F ,PR ,3 ,2 ,4 ,1 ,1 ,1 ,TR ,3.93 ,W ,3 ,2 ,4
LIT ,95 ,M ,HM ,4 ,3 ,3 ,3 ,1 ,1 ,TR ,3.27 ,W ,4 ,3 ,3
MUSC ,95 ,M ,HM ,2 ,1 ,3 ,3 ,2 ,1 ,TR ,3.46 ,W ,2 ,1 ,3
BIOL ,95 ,M ,NS ,4 ,3 ,4 ,3 ,1 ,1 ,TR ,2.78 ,W ,4 ,3 ,4
PSYC ,95 ,F ,SS ,3 ,3 ,3 ,4 ,1 ,1 ,NR ,3.04 ,W ,3 ,3 ,3
LIT ,95 ,F ,HM ,4 ,4 ,4 ,2 ,1 ,1 ,TR ,3.57 ,W ,4 ,4 ,4
MCOM ,95 ,F ,PR ,3 ,2 ,4 ,4 ,2 ,1 ,TR ,3.09 ,O ,3 ,2 ,4
MGMT ,95 ,M ,PR ,4 ,3 ,3 ,4 ,1 ,1 ,CT ,3.26 ,W ,4 ,3 ,3
BIOL ,95 ,F ,NS ,4 ,4 ,4 ,0 ,1 ,1 ,CT ,3.58 ,W ,4 ,4 ,4
SOC ,95 ,F ,SS ,4 ,2 ,4 ,2 ,1 ,1 ,CT ,3.34 ,W ,4 ,2 ,4
ENVR ,95 ,F ,NS ,3 ,3 ,3 ,3 ,2 ,1 ,TR ,2.92 ,W ,3 ,3 ,3
ECON ,95 ,M ,SS ,4 ,2 ,4 ,4 ,1 ,1 ,NR ,2.95 ,W ,4 ,2 ,4
  ,95 ,  ,  ,3 ,3 ,4 ,4 ,2 ,2 ,  ,. ,  ,3 ,3 ,4
  ,95 ,  ,  ,3 ,2 ,3 ,4 ,1 ,1 ,  ,. ,  ,3 ,2 ,3
  ,95 ,  ,  ,4 ,3 ,4 ,4 ,1 ,1 ,  ,. ,  ,4 ,3 ,4
  ,95 ,  ,  ,3 ,2 ,2 ,3 ,2 ,2 ,  ,. ,  ,3 ,2 ,2
  ,95 ,  ,  ,3 ,3 ,3 ,3 ,1 ,1 ,  ,. ,  ,3 ,3 ,3
  ,95 ,  ,  ,  ,  ,  ,3 ,2 ,1 ,  ,. ,  ,. ,. ,.
  ,95 ,  ,  ,4 ,2 ,3 ,2 ,1 ,1 ,  ,. ,  ,4 ,2 ,3
  ,95 ,  ,  ,  ,  ,  ,4 ,1 ,1 ,  ,. ,  ,. ,. ,.
  ,95 ,  ,  ,4 ,2 ,4 ,4 ,1 ,1 ,  ,. ,  ,4 ,2 ,4
  ,95 ,  ,  ,4 ,2 ,4 ,4 ,1 ,1 ,  ,. ,  ,4 ,2 ,4
  ,95 ,  ,  ,4 ,3 ,3 ,4 ,1 ,2 ,  ,. ,  ,4 ,3 ,3
GERM ,95 ,  ,HM ,  ,  ,  ,2 ,1 ,2 ,  ,. ,  ,. ,. ,.
  ,95 ,  ,  ,3 ,1 ,2 ,4 ,  ,  ,  ,. ,  ,3 ,1 ,2
  ,95 ,  ,  ,3 ,2 ,3 ,3 ,1 ,1 ,  ,. ,  ,3 ,2 ,3
  ,95 ,  ,  ,2 ,3 ,3 ,2 ,1 ,1 ,  ,. ,  ,2 ,3 ,3
  ,95 ,  ,  ,3 ,2 ,3 ,2 ,1 ,1 ,  ,. ,  ,3 ,2 ,3
  ,95 ,  ,  ,4 ,4 ,3 ,1 ,  ,1 ,  ,. ,  ,4 ,4 ,3
  ,95 ,  ,  ,4 ,3 ,4 ,4 ,1 ,1 ,  ,. ,  ,4 ,3 ,4
  ,95 ,  ,  ,3 ,2 ,2 ,2 ,1 ,1 ,  ,. ,  ,3 ,2 ,2
  ,95 ,  ,  ,4 ,2 ,4 ,4 ,1 ,1 ,  ,. ,  ,4 ,2 ,4
PHYS ,95 ,  ,NS ,3 ,1 ,2 ,2 ,1 ,2 ,  ,. ,  ,3 ,1 ,2
  ,95 ,  ,  ,0 ,0 ,0 ,0 ,2 ,1 ,  ,. ,  ,0 ,0 ,0
  ,95 ,  ,  ,2 ,  ,3 ,3 ,  ,1 ,  ,. ,  ,2 ,. ,3
  ,95 ,  ,  ,3 ,3 ,3 ,4 ,1 ,1 ,  ,. ,  ,3 ,3 ,3
  ,95 ,  ,  ,3 ,2 ,2 ,2 ,  ,  ,  ,. ,  ,3 ,2 ,2
  ,95 ,  ,  ,3 ,2 ,4 ,4 ,1 ,1 ,  ,. ,  ,3 ,2 ,4
  ,95 ,  ,  ,3 ,3 ,3 ,3 ,1 ,1 ,  ,. ,  ,3 ,3 ,3
  ,95 ,  ,  ,3 ,2 ,3 ,3 ,1 ,1 ,  ,. ,  ,3 ,2 ,3
  ,95 ,  ,  ,3 ,3 ,4 ,4 ,1 ,1 ,  ,. ,  ,3 ,3 ,4
  ,95 ,  ,  ,4 ,4 ,4 ,3 ,1 ,1 ,  ,. ,  ,4 ,4 ,4
  ,95 ,  ,  ,4 ,3 ,4 ,3 ,1 ,1 ,  ,. ,  ,4 ,3 ,4
  ,95 ,  ,  ,3 ,3 ,3 ,4 ,1 ,1 ,  ,. ,  ,3 ,3 ,3
  ,95 ,  ,  ,4 ,3 ,4 ,. ,  ,  ,  ,. ,  ,4 ,3 ,4
  ,95 ,  ,  ,3 ,3 ,2 ,3 ,1 ,1 ,  ,. ,  ,3 ,3 ,2
  ,95 ,  ,  ,4 ,3 ,3 ,3 ,1 ,1 ,  ,. ,  ,4 ,3 ,3


/* data96.dat */

  ,96 ,  ,  ,  ,  ,  ,. ,  ,  ,  ,. ,  ,. ,. ,.
  ,96 ,  ,  ,  ,  ,  ,. ,  ,  ,  ,. ,  ,. ,. ,.
  ,96 ,  ,  ,  ,  ,  ,. ,  ,  ,  ,. ,  ,. ,. ,.
ART ,95 ,F ,HM ,3 ,  ,  ,0 ,1 ,1 ,TR ,2.89 ,W ,3 ,. ,.
SOC ,96 ,M ,SS ,3 ,2 ,4 ,4 ,1 ,1 ,TR ,3.56 ,W ,3 ,2 ,4
SOC ,96 ,F ,SS ,4 ,3 ,4 ,3 ,1 ,1 ,NR ,2.66 ,W ,4 ,3 ,4
PSYC ,96 ,M ,SS ,4 ,  ,3 ,3 ,1 ,  ,TR ,3.01 ,W ,4 ,. ,3
ENVR ,96 ,F ,NS ,4 ,4 ,4 ,3 ,1 ,1 ,NR ,3.48 ,W ,4 ,4 ,4
BIOL ,96 ,F ,NS ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,3.97 ,W ,4 ,3 ,4
MGMT ,95 ,M ,PR ,4 ,3 ,4 ,2 ,1 ,1 ,TR ,3.34 ,W ,4 ,3 ,4
POLS ,96 ,M ,SS ,3 ,2 ,4 ,3 ,2 ,1 ,TR ,3.82 ,W ,3 ,2 ,4
CHEM ,96 ,F ,NS ,4 ,3 ,4 ,3 ,1 ,1 ,TR ,3.08 ,W ,4 ,3 ,4
MUSC ,96 ,M ,HM ,2 ,2 ,2 ,1 ,  ,1 ,CT ,3.63 ,W ,2 ,2 ,2
PSYC ,96 ,F ,SS ,3 ,3 ,4 ,4 ,2 ,1 ,TR ,2.2 ,W ,3 ,3 ,4
SOC ,95 ,M ,SS ,2 ,1 ,3 ,0 ,2 ,1 ,TR ,2.22 ,W ,2 ,1 ,3
BIOL ,96 ,M ,NS ,4 ,3 ,4 ,3 ,1 ,1 ,TR ,3.3 ,W ,4 ,3 ,4
MGMT ,95 ,F ,PR ,4 ,2 ,3 ,3 ,1 ,2 ,TR ,3.92 ,W ,4 ,2 ,3
BIOL ,95 ,F ,NS ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,3.26 ,W ,4 ,3 ,4
MGMT ,95 ,F ,PR ,1 ,1 ,1 ,1 ,2 ,1 ,TR ,2.74 ,W ,1 ,1 ,1
IEMT ,96 ,F ,PR ,3 ,4 ,3 ,4 ,1 ,1 ,TR ,3.22 ,W ,3 ,4 ,3
ENVR ,95 ,F ,NS ,4 ,2 ,4 ,2 ,  ,2 ,TR ,3.97 ,W ,4 ,2 ,4
PSYC ,95 ,M ,SS ,4 ,2 ,3 ,3 ,1 ,1 ,NR ,2.48 ,W ,4 ,2 ,3
ACCT ,96 ,F ,PR ,3 ,3 ,2 ,3 ,1 ,1 ,NR ,3.2 ,W ,3 ,3 ,2
MGMT ,95 ,M ,PR ,4 ,2 ,2 ,4 ,1 ,1 ,CT ,3.19 ,W ,4 ,2 ,2
HIST ,96 ,M ,SS ,3 ,2 ,3 ,3 ,1 ,2 ,TR ,2.5 ,W ,3 ,2 ,3
CSCI ,95 ,M ,PR ,4 ,3 ,4 ,3 ,1 ,1 ,TR ,3.09 ,W ,4 ,3 ,4
MCOM ,96 ,F ,PR ,3 ,2 ,4 ,1 ,2 ,1 ,TR ,2.05 ,B ,3 ,2 ,4
POLS ,96 ,M ,SS ,2 ,1 ,1 ,3 ,2 ,1 ,TR ,2.81 ,W ,2 ,1 ,1
POLS ,96 ,M ,SS ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,2.55 ,W ,4 ,3 ,4
LIT ,96 ,F ,HM ,4 ,3 ,4 ,3 ,1 ,1 ,TR ,4 ,W ,4 ,3 ,4
MGMT ,96 ,M ,PR ,4 ,4 ,4 ,4 ,1 ,1 ,TR ,3.29 ,W ,4 ,4 ,4
PHIL ,96 ,F ,HM ,4 ,3 ,3 ,3 ,1 ,1 ,TR ,3.39 ,W ,4 ,3 ,3
MGMT ,95 ,M ,PR ,4 ,3 ,3 ,4 ,1 ,1 ,TR ,3.31 ,B ,4 ,3 ,3
ENVR ,96 ,M ,NS ,4 ,4 ,4 ,3 ,1 ,2 ,NR ,2.74 ,W ,4 ,4 ,4
ACCT ,96 ,F ,PR ,4 ,3 ,3 ,4 ,1 ,1 ,NR ,2.74 ,W ,4 ,3 ,3
ENVR ,96 ,M ,NS ,3 ,2 ,3 ,3 ,2 ,2 ,TR ,3.46 ,W ,3 ,2 ,3
PSYC ,95 ,F ,SS ,4 ,2 ,3 ,4 ,1 ,1 ,NR ,3.34 ,W ,4 ,2 ,3
MGMT ,95 ,F ,PR ,4 ,4 ,3 ,4 ,1 ,1 ,NR ,2.37 ,W ,4 ,4 ,3
POLS ,96 ,M ,SS ,3 ,1 ,3 ,3 ,2 ,1 ,NR ,3.24 ,W ,3 ,1 ,3
MGMT ,96 ,M ,PR ,4 ,4 ,4 ,4 ,1 ,1 ,TR ,3.15 ,W ,4 ,4 ,4
CSCI ,96 ,F ,PR ,3 ,2 ,1 ,3 ,2 ,1 ,TR ,3.22 ,W ,3 ,2 ,1
LIT ,96 ,F ,HM ,4 ,3 ,3 ,1 ,1 ,1 ,TR ,3.72 ,W ,4 ,3 ,3
MCOM ,95 ,F ,PR ,3 ,2 ,3 ,2 ,1 ,1 ,TR ,2.75 ,W ,3 ,2 ,3
PSYC ,96 ,F ,SS ,3 ,2 ,2 ,4 ,  ,1 ,TR ,2.49 ,W ,3 ,2 ,2
PSYC ,96 ,F ,SS ,2 ,2 ,4 ,2 ,1 ,  ,NR ,2.71 ,W ,2 ,2 ,4
CSCI ,96 ,M ,PR ,2 ,1 ,1 ,3 ,1 ,1 ,TR ,2.76 ,W ,2 ,1 ,1
SOC ,96 ,M ,SS ,3 ,1 ,3 ,4 ,  ,1 ,TR ,2.17 ,B ,3 ,1 ,3
CSCI ,96 ,M ,PR ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,3.6 ,W ,4 ,3 ,4
HIST ,95 ,M ,SS ,4 ,3 ,2 ,3 ,1 ,1 ,TR ,3.27 ,W ,4 ,3 ,2
BIOL ,96 ,M ,NS ,3 ,2 ,2 ,3 ,1 ,2 ,TR ,2.86 ,W ,3 ,2 ,2
PHYS ,95 ,M ,NS ,3 ,2 ,3 ,3 ,1 ,1 ,NR ,3.54 ,W ,3 ,2 ,3
CHEM ,96 ,F ,NS ,3 ,1 ,2 ,2 ,1 ,1 ,TR ,2.22 ,B ,3 ,1 ,2
  ,96 ,  ,  ,3 ,2 ,4 ,4 ,1 ,1 ,  ,. ,  ,3 ,2 ,4
PSYC ,96 ,F ,SS ,3 ,2 ,3 ,2 ,1 ,1 ,TR ,3.43 ,W ,3 ,2 ,3
PSYC ,95 ,M ,SS ,4 ,  ,4 ,3 ,1 ,1 ,TR ,3.28 ,W ,4 ,. ,4
PSYC ,95 ,F ,SS ,4 ,3 ,4 ,2 ,1 ,1 ,TR ,3.65 ,W ,4 ,3 ,4
ACCT ,96 ,M ,PR ,4 ,4 ,3 ,3 ,1 ,1 ,TR ,3.37 ,W ,4 ,4 ,3
SOC ,95 ,F ,SS ,4 ,3 ,4 ,2 ,1 ,1 ,TR ,3.06 ,W ,4 ,3 ,4
BIOL ,96 ,F ,NS ,4 ,3 ,4 ,2 ,1 ,1 ,TR ,3.92 ,W ,4 ,3 ,4
PSYC ,96 ,F ,SS ,4 ,2 ,4 ,1 ,1 ,1 ,TR ,2.12 ,W ,4 ,2 ,4
ECON ,96 ,M ,SS ,4 ,2 ,3 ,3 ,2 ,1 ,NR ,3.68 ,W ,4 ,2 ,3
  ,96 ,  ,  ,3 ,3 ,2 ,4 ,1 ,1 ,  ,. ,  ,3 ,3 ,2
MGMT ,96 ,F ,PR ,3 ,3 ,2 ,4 ,2 ,1 ,NR ,2.19 ,B ,3 ,3 ,2
BIOL ,95 ,F ,NS ,4 ,3 ,4 ,2 ,1 ,1 ,TR ,2.56 ,W ,4 ,3 ,4
PSYC ,95 ,M ,SS ,4 ,3 ,4 ,3 ,1 ,1 ,TR ,3.69 ,W ,4 ,3 ,4
MATH ,96 ,F ,NS ,3 ,2 ,2 ,3 ,1 ,1 ,NR ,2.94 ,W ,3 ,2 ,2
ATMS ,96 ,M ,NS ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,3.55 ,W ,4 ,3 ,4
SOC ,96 ,F ,SS ,4 ,2 ,4 ,4 ,2 ,2 ,TR ,2.46 ,W ,4 ,2 ,4
IEMT ,95 ,M ,PR ,3 ,1 ,3 ,4 ,1 ,1 ,TR ,3.42 ,W ,3 ,1 ,3
MGMT ,96 ,M ,PR ,3 ,3 ,3 ,4 ,1 ,1 ,NR ,2.88 ,W ,3 ,3 ,3
PSYC ,96 ,F ,SS ,4 ,3 ,4 ,3 ,1 ,1 ,NR ,3.08 ,W ,4 ,3 ,4
PSYC ,95 ,F ,SS ,3 ,2 ,4 ,3 ,2 ,2 ,TR ,2.27 ,W ,3 ,2 ,4
PSYC ,96 ,F ,SS ,2 ,2 ,3 ,2 ,1 ,1 ,NR ,2.79 ,W ,2 ,2 ,3
LIT ,96 ,F ,HM ,4 ,2 ,4 ,2 ,1 ,1 ,NR ,3.24 ,W ,4 ,2 ,4
SOC ,96 ,F ,SS ,2 ,2 ,2 ,2 ,2 ,1 ,NR ,2.42 ,B ,2 ,2 ,2
BIOL ,96 ,M ,NS ,4 ,3 ,4 ,3 ,1 ,1 ,NR ,3.64 ,W ,4 ,3 ,4
SOC ,96 ,F ,SS ,3 ,2 ,3 ,3 ,1 ,1 ,NR ,3.78 ,W ,3 ,2 ,3
ART ,96 ,F ,HM ,4 ,1 ,4 ,0 ,1 ,2 ,TR ,3.68 ,W ,4 ,1 ,4
MGMT ,96 ,F ,PR ,3 ,3 ,4 ,3 ,2 ,2 ,TR ,2.22 ,W ,3 ,3 ,4
IEMT ,95 ,M ,PR ,3 ,4 ,2 ,4 ,1 ,1 ,TR ,2.16 ,W ,3 ,4 ,2
LIT ,96 ,F ,HM ,4 ,1 ,3 ,4 ,1 ,2 ,NR ,3.61 ,W ,4 ,1 ,3
ART ,96 ,F ,HM ,3 ,1 ,2 ,2 ,1 ,1 ,TR ,3.58 ,W ,3 ,1 ,2
MGMT ,96 ,M ,PR ,3 ,2 ,3 ,4 ,1 ,2 ,TR ,4 ,W ,3 ,2 ,3
SOC ,95 ,F ,SS ,4 ,2 ,3 ,1 ,1 ,1 ,TR ,3.2 ,W ,4 ,2 ,3
SPAN ,95 ,M ,HM ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,3.76 ,W ,4 ,3 ,4
BIOL ,96 ,M ,NS ,3 ,2 ,2 ,2 ,2 ,1 ,TR ,2.64 ,W ,3 ,2 ,2
MGMT ,96 ,M ,PR ,4 ,3 ,3 ,3 ,1 ,1 ,TR ,2.86 ,W ,4 ,3 ,3
MGMT ,96 ,M ,PR ,3 ,4 ,3 ,4 ,1 ,1 ,TR ,2.7 ,W ,3 ,4 ,3
PSYC ,96 ,F ,SS ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,3.45 ,W ,4 ,3 ,4
PSYC ,96 ,M ,SS ,4 ,3 ,4 ,1 ,1 ,1 ,NR ,2.57 ,W ,4 ,3 ,4
MGMT ,96 ,M ,PR ,3 ,3 ,4 ,3 ,1 ,1 ,NR ,3.21 ,W ,3 ,3 ,4
MGMT ,96 ,F ,PR ,4 ,3 ,3 ,4 ,1 ,1 ,NR ,3.83 ,W ,4 ,3 ,3
PSYC ,96 ,F ,SS ,3 ,2 ,2 ,1 ,2 ,2 ,TR ,3.11 ,W ,3 ,2 ,2
SOC ,96 ,F ,SS ,4 ,2 ,3 ,4 ,1 ,1 ,NR ,3.49 ,W ,4 ,2 ,3
PSYC ,96 ,F ,SS ,4 ,4 ,4 ,4 ,1 ,1 ,TR ,3.32 ,W ,4 ,4 ,4
ENVR ,95 ,F ,NS ,4 ,1 ,4 ,2 ,1 ,1 ,NR ,3.1 ,W ,4 ,1 ,4
ENVR ,95 ,F ,NS ,3 ,3 ,3 ,2 ,1 ,1 ,TR ,3.45 ,W ,3 ,3 ,3
HIST ,95 ,F ,SS ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,2.74 ,W ,4 ,3 ,4
HIST ,96 ,F ,SS ,4 ,3 ,3 ,3 ,1 ,1 ,TR ,3.08 ,W ,4 ,3 ,3
PHIL ,95 ,M ,HM ,3 ,2 ,3 ,3 ,1 ,1 ,NR ,2.86 ,W ,3 ,2 ,3
PSYC ,96 ,M ,SS ,4 ,3 ,3 ,2 ,1 ,1 ,TR ,2.95 ,W ,4 ,3 ,3
CHEM ,95 ,M ,NS ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,3.14 ,W ,4 ,3 ,4
CSCI ,96 ,M ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,TR ,2.05 ,W ,3 ,3 ,3
ENVR ,96 ,M ,NS ,4 ,1 ,3 ,2 ,2 ,1 ,NR ,2.28 ,W ,4 ,1 ,3
BIOL ,96 ,M ,NS ,3 ,3 ,4 ,2 ,1 ,1 ,TR ,2.67 ,A ,3 ,3 ,4
ACCT ,96 ,F ,PR ,4 ,3 ,3 ,3 ,1 ,1 ,CT ,3.92 ,W ,4 ,3 ,3
HIST ,95 ,M ,SS ,2 ,2 ,4 ,4 ,2 ,1 ,NR ,2.75 ,W ,2 ,2 ,4
PSYC ,96 ,F ,SS ,4 ,3 ,3 ,3 ,1 ,1 ,NR ,3.52 ,W ,4 ,3 ,3
HIST ,96 ,M ,SS ,3 ,2 ,4 ,3 ,1 ,1 ,TR ,2.96 ,W ,3 ,2 ,4
PSYC ,96 ,M ,SS ,3 ,2 ,4 ,2 ,  ,  ,TR ,3.39 ,B ,3 ,2 ,4
LIT ,96 ,F ,HM ,4 ,4 ,4 ,4 ,1 ,1 ,NR ,2.87 ,W ,4 ,4 ,4
MGMT ,95 ,M ,PR ,4 ,3 ,4 ,2 ,1 ,1 ,NR ,2.43 ,W ,4 ,3 ,4
MGMT ,95 ,F ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,NR ,2.82 ,W ,3 ,3 ,3
LIT ,95 ,F ,HM ,4 ,3 ,4 ,2 ,1 ,1 ,TR ,3.65 ,W ,4 ,3 ,4
MUSC ,96 ,M ,HM ,4 ,2 ,3 ,4 ,1 ,1 ,NR ,3.52 ,W ,4 ,2 ,3
FREN ,96 ,F ,HM ,4 ,3 ,3 ,4 ,1 ,1 ,TR ,3.87 ,W ,4 ,3 ,3
ACCT ,96 ,F ,PR ,4 ,4 ,3 ,4 ,1 ,1 ,NR ,3.15 ,W ,4 ,4 ,3
MCOM ,96 ,F ,PR ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,3.06 ,W ,4 ,3 ,4
FREN ,95 ,M ,HM ,4 ,4 ,  ,1 ,1 ,1 ,NR ,3.43 ,W ,4 ,4 ,.
MATH ,96 ,F ,NS ,4 ,3 ,4 ,4 ,2 ,1 ,NR ,2.72 ,W ,4 ,3 ,4
POLS ,96 ,M ,SS ,4 ,1 ,3 ,3 ,1 ,2 ,NR ,3.05 ,W ,4 ,1 ,3
ART ,96 ,F ,HM ,4 ,1 ,3 ,2 ,1 ,1 ,TR ,2.91 ,W ,4 ,1 ,3
ENVR ,95 ,M ,NS ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,3.23 ,W ,4 ,3 ,4
ACCT ,95 ,F ,PR ,4 ,4 ,4 ,4 ,1 ,2 ,TR ,2.85 ,W ,4 ,4 ,4
ACCT ,95 ,M ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,NR ,2.59 ,W ,3 ,3 ,3
ENVR ,95 ,M ,NS ,2 ,2 ,2 ,3 ,2 ,1 ,NR ,3.46 ,W ,2 ,2 ,2
ACCT ,96 ,F ,PR ,3 ,3 ,4 ,4 ,1 ,1 ,NR ,2.75 ,W ,3 ,3 ,4
MGMT ,96 ,M ,PR ,  ,  ,  ,3 ,2 ,2 ,NR ,2.37 ,W ,. ,. ,.
MGMT ,95 ,M ,PR ,3 ,3 ,3 ,4 ,1 ,1 ,NR ,2.66 ,W ,3 ,3 ,3
ENVR ,96 ,F ,NS ,3 ,2 ,3 ,4 ,1 ,1 ,NR ,2.79 ,W ,3 ,2 ,3
BIOL ,96 ,M ,NS ,3 ,1 ,2 ,4 ,2 ,2 ,CF ,2.52 ,W ,3 ,1 ,2
SOC ,96 ,F ,SS ,4 ,2 ,4 ,2 ,1 ,2 ,NR ,3.72 ,W ,4 ,2 ,4
MCOM ,96 ,M ,PR ,2 ,2 ,2 ,2 ,2 ,1 ,TR ,2.45 ,W ,2 ,2 ,2
PSYC ,95 ,M ,SS ,3 ,2 ,3 ,2 ,1 ,2 ,NR ,2.09 ,W ,3 ,2 ,3
ECON ,95 ,M ,SS ,3 ,3 ,2 ,2 ,2 ,2 ,CF ,3.63 ,W ,3 ,3 ,2
MGMT ,96 ,M ,PR ,3 ,2 ,2 ,3 ,2 ,2 ,NR ,2.73 ,W ,3 ,2 ,2
PSYC ,96 ,F ,SS ,3 ,2 ,3 ,2 ,2 ,1 ,CT ,3.51 ,W ,3 ,2 ,3
MGMT ,96 ,F ,PR ,4 ,4 ,4 ,4 ,1 ,1 ,NR ,3.14 ,W ,4 ,4 ,4
POLS ,95 ,F ,SS ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,2.96 ,W ,4 ,3 ,4
MATH ,96 ,M ,NS ,3 ,3 ,4 ,3 ,1 ,1 ,NR ,3.17 ,W ,3 ,3 ,4
MCOM ,96 ,M ,PR ,4 ,3 ,4 ,3 ,1 ,1 ,TR ,3.47 ,W ,4 ,3 ,4
MGMT ,96 ,M ,PR ,4 ,4 ,4 ,2 ,1 ,1 ,TR ,2.65 ,W ,4 ,4 ,4
MGMT ,96 ,F ,PR ,3 ,4 ,3 ,4 ,1 ,1 ,TR ,2.5 ,W ,3 ,4 ,3
HIST ,96 ,F ,SS ,3 ,4 ,3 ,2 ,1 ,1 ,TR ,2.63 ,W ,3 ,4 ,3
POLS ,96 ,M ,SS ,3 ,2 ,3 ,4 ,1 ,1 ,NR ,2.21 ,W ,3 ,2 ,3
PSYC ,95 ,M ,SS ,4 ,3 ,3 ,3 ,1 ,1 ,TR ,3.34 ,W ,4 ,3 ,3
PSYC ,96 ,F ,SS ,4 ,3 ,2 ,0 ,1 ,1 ,TR ,3 ,W ,4 ,3 ,2
PSYC ,96 ,M ,SS ,4 ,2 ,3 ,3 ,1 ,1 ,CT ,2.68 ,W ,4 ,2 ,3
PSYC ,96 ,F ,SS ,3 ,3 ,3 ,3 ,1 ,1 ,NR ,3.23 ,W ,3 ,3 ,3
MGMT ,95 ,F ,PR ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,2.84 ,A ,4 ,3 ,4
MCOM ,95 ,M ,PR ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,2.83 ,W ,4 ,3 ,4
MGMT ,96 ,F ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,TR ,3.12 ,W ,3 ,3 ,3
MGMT ,96 ,M ,PR ,4 ,4 ,4 ,4 ,1 ,1 ,NR ,2.53 ,W ,4 ,4 ,4
POLS ,96 ,M ,SS ,4 ,2 ,3 ,4 ,1 ,  ,TR ,2.15 ,W ,4 ,2 ,3
PSYC ,95 ,F ,SS ,3 ,2 ,2 ,3 ,1 ,1 ,CT ,3.11 ,W ,3 ,2 ,2
MCOM ,96 ,M ,PR ,4 ,4 ,3 ,4 ,1 ,1 ,TR ,3.11 ,W ,4 ,4 ,3
PHIL ,96 ,F ,HM ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,3.28 ,W ,4 ,3 ,4
PSYC ,95 ,F ,SS ,4 ,3 ,4 ,3 ,1 ,1 ,NR ,3.23 ,W ,4 ,3 ,4
SOC ,96 ,F ,SS ,3 ,2 ,4 ,2 ,1 ,2 ,NR ,2.34 ,B ,3 ,2 ,4
PSYC ,96 ,F ,SS ,4 ,4 ,4 ,3 ,1 ,1 ,TR ,3.41 ,W ,4 ,4 ,4
MCOM ,96 ,F ,PR ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,3.13 ,W ,4 ,3 ,4
MGMT ,96 ,F ,PR ,4 ,3 ,4 ,3 ,1 ,2 ,NR ,3.53 ,W ,4 ,3 ,4
IEMT ,95 ,M ,PR ,4 ,2 ,3 ,2 ,1 ,1 ,NR ,2.33 ,W ,4 ,2 ,3
MGMT ,95 ,F ,PR ,3 ,3 ,3 ,2 ,1 ,1 ,TR ,2.32 ,W ,3 ,3 ,3
HIST ,96 ,F ,SS ,4 ,3 ,2 ,4 ,1 ,1 ,NR ,3.17 ,W ,4 ,3 ,2
PHIL ,95 ,M ,HM ,3 ,1 ,3 ,2 ,1 ,1 ,TR ,3.54 ,W ,3 ,1 ,3
PSYC ,96 ,F ,SS ,3 ,3 ,4 ,1 ,1 ,  ,NR ,3 ,W ,3 ,3 ,4
POLS ,95 ,M ,SS ,4 ,3 ,4 ,1 ,1 ,1 ,TR ,2.64 ,W ,4 ,3 ,4
BIOL ,96 ,M ,NS ,4 ,4 ,3 ,0 ,1 ,1 ,NR ,3.69 ,W ,4 ,4 ,3
MGMT ,96 ,M ,PR ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,2.84 ,W ,4 ,3 ,4
ART ,95 ,F ,HM ,3 ,1 ,3 ,4 ,2 ,1 ,NR ,2.23 ,W ,3 ,1 ,3
CSCI ,95 ,M ,PR ,3 ,2 ,3 ,4 ,1 ,1 ,CT ,2.16 ,W ,3 ,2 ,3
BIOL ,95 ,F ,NS ,4 ,4 ,4 ,1 ,1 ,1 ,NR ,2.95 ,W ,4 ,4 ,4
MGMT ,96 ,M ,PR ,3 ,2 ,2 ,3 ,1 ,1 ,NR ,3.17 ,W ,3 ,2 ,2
PSYC ,96 ,F ,SS ,4 ,2 ,4 ,4 ,1 ,  ,TR ,3.31 ,W ,4 ,2 ,4
BIOL ,96 ,F ,NS ,2 ,2 ,3 ,4 ,1 ,1 ,CT ,3.79 ,W ,2 ,2 ,3
ENVR ,95 ,M ,NS ,3 ,3 ,2 ,2 ,  ,1 ,NR ,2.97 ,W ,3 ,3 ,2
SOC ,95 ,F ,SS ,4 ,2 ,4 ,2 ,1 ,1 ,NR ,2.69 ,W ,4 ,2 ,4
BIOL ,96 ,M ,NS ,3 ,2 ,3 ,2 ,1 ,1 ,TR ,3.08 ,W ,3 ,2 ,3
MGMT ,96 ,M ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,TR ,3.18 ,W ,3 ,3 ,3
PSYC ,95 ,F ,SS ,4 ,2 ,4 ,3 ,1 ,2 ,TR ,3.23 ,W ,4 ,2 ,4
PSYC ,96 ,M ,SS ,4 ,1 ,1 ,3 ,1 ,2 ,NR ,3.62 ,W ,4 ,1 ,1
ENVR ,96 ,M ,NS ,4 ,4 ,4 ,0 ,1 ,1 ,NR ,3.06 ,W ,4 ,4 ,4
HIST ,95 ,M ,SS ,4 ,4 ,4 ,3 ,1 ,1 ,NR ,3.25 ,W ,4 ,4 ,4
SOC ,95 ,M ,SS ,4 ,3 ,4 ,4 ,  ,  ,TR ,3.08 ,W ,4 ,3 ,4
SOC ,96 ,F ,SS ,2 ,2 ,2 ,0 ,1 ,1 ,CT ,3.61 ,W ,2 ,2 ,2
SOC ,96 ,F ,SS ,3 ,3 ,4 ,4 ,1 ,1 ,NR ,2.96 ,W ,3 ,3 ,4
PSYC ,96 ,F ,SS ,4 ,3 ,4 ,3 ,1 ,1 ,NR ,2.75 ,W ,4 ,3 ,4
MGMT ,96 ,M ,PR ,4 ,4 ,4 ,4 ,1 ,1 ,NR ,3.01 ,W ,4 ,4 ,4
MCOM ,95 ,M ,PR ,3 ,2 ,3 ,3 ,1 ,1 ,TR ,3.67 ,W ,3 ,2 ,3
CSCI ,95 ,M ,PR ,3 ,3 ,3 ,4 ,2 ,2 ,NR ,2.11 ,W ,3 ,3 ,3
MGMT ,96 ,M ,PR ,3 ,2 ,3 ,3 ,1 ,1 ,TR ,3 ,W ,3 ,2 ,3
MGMT ,95 ,F ,PR ,3 ,3 ,2 ,4 ,1 ,1 ,TR ,2.5 ,W ,3 ,3 ,2
ENVR ,96 ,F ,NS ,3 ,2 ,3 ,3 ,1 ,1 ,NR ,3.45 ,A ,3 ,2 ,3
SOC ,96 ,F ,SS ,4 ,4 ,3 ,4 ,1 ,1 ,NR ,3.09 ,B ,4 ,4 ,3
ENVR ,96 ,F ,NS ,3 ,2 ,4 ,3 ,1 ,1 ,NR ,2.91 ,W ,3 ,2 ,4
BIOL ,95 ,F ,NS ,4 ,2 ,4 ,3 ,1 ,1 ,NR ,2.76 ,W ,4 ,2 ,4
LIT ,96 ,F ,HM ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,3.08 ,W ,4 ,3 ,4
MCOM ,95 ,F ,PR ,3 ,3 ,2 ,4 ,2 ,1 ,NR ,3.34 ,W ,3 ,3 ,2
MCOM ,96 ,F ,PR ,4 ,2 ,3 ,4 ,1 ,2 ,TR ,3.32 ,W ,4 ,2 ,3
MGMT ,96 ,M ,PR ,4 ,2 ,3 ,4 ,1 ,1 ,NR ,3.74 ,W ,4 ,2 ,3
BIOL ,96 ,M ,NS ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,3.29 ,W ,4 ,3 ,4
LIT ,95 ,F ,HM ,4 ,3 ,4 ,3 ,1 ,1 ,NR ,3.56 ,W ,4 ,3 ,4
ACCT ,95 ,F ,PR ,4 ,2 ,3 ,3 ,1 ,1 ,TR ,3.64 ,W ,4 ,2 ,3
LIT ,95 ,F ,HM ,3 ,  ,2 ,3 ,2 ,1 ,TR ,3.57 ,W ,3 ,. ,2
POLS ,96 ,F ,SS ,4 ,1 ,3 ,2 ,2 ,1 ,NR ,3.73 ,W ,4 ,1 ,3
ART ,95 ,F ,HM ,3 ,3 ,4 ,3 ,1 ,1 ,NR ,3.48 ,W ,3 ,3 ,4
ENVR ,95 ,F ,NS ,4 ,3 ,4 ,3 ,  ,1 ,TR ,2.26 ,W ,4 ,3 ,4
BIOL ,96 ,M ,NS ,4 ,3 ,3 ,3 ,1 ,1 ,TR ,3.27 ,W ,4 ,3 ,3
POLS ,96 ,F ,SS ,4 ,4 ,4 ,3 ,1 ,1 ,CT ,2.47 ,W ,4 ,4 ,4
ACCT ,96 ,F ,PR ,4 ,4 ,4 ,4 ,1 ,1 ,NR ,3.25 ,W ,4 ,4 ,4
MGMT ,96 ,F ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,NR ,2.78 ,W ,3 ,3 ,3
MGMT ,96 ,M ,PR ,3 ,3 ,3 ,4 ,  ,1 ,NR ,3.23 ,W ,3 ,3 ,3
POLS ,96 ,F ,SS ,4 ,1 ,3 ,4 ,1 ,  ,CT ,3.72 ,W ,4 ,1 ,3
MUSC ,95 ,F ,HM ,4 ,1 ,4 ,1 ,1 ,1 ,TR ,2.75 ,W ,4 ,1 ,4
POLS ,96 ,M ,SS ,3 ,2 ,3 ,2 ,1 ,1 ,NR ,2.72 ,W ,3 ,2 ,3
ECON ,96 ,M ,SS ,3 ,2 ,3 ,3 ,1 ,1 ,NR ,2.42 ,W ,3 ,2 ,3
ACCT ,96 ,F ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,NR ,2.87 ,W ,3 ,3 ,3
ACCT ,96 ,F ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,NR ,2.87 ,W ,3 ,3 ,3
BIOL ,95 ,F ,NS ,4 ,2 ,3 ,4 ,1 ,1 ,NR ,3.49 ,W ,4 ,2 ,3
LIT ,96 ,F ,HM ,4 ,3 ,4 ,3 ,1 ,1 ,NR ,3.68 ,W ,4 ,3 ,4
HIST ,95 ,F ,SS ,3 ,2 ,2 ,3 ,1 ,1 ,NR ,3.66 ,W ,3 ,2 ,2
CSCI ,95 ,F ,PR ,4 ,3 ,4 ,4 ,1 ,2 ,NR ,2.87 ,W ,4 ,3 ,4
PSYC ,96 ,F ,SS ,2 ,2 ,1 ,0 ,  ,1 ,TR ,3.08 ,W ,2 ,2 ,1
MATH ,96 ,F ,NS ,4 ,4 ,4 ,4 ,1 ,1 ,NR ,3.33 ,W ,4 ,4 ,4
HIST ,96 ,F ,SS ,4 ,3 ,3 ,2 ,1 ,1 ,NR ,2.85 ,W ,4 ,3 ,3
PSYC ,95 ,F ,SS ,4 ,3 ,3 ,4 ,1 ,1 ,NR ,3.36 ,W ,4 ,3 ,3
SOC ,95 ,F ,SS ,4 ,4 ,2 ,4 ,2 ,1 ,NR ,3.23 ,W ,4 ,4 ,2
MGMT ,95 ,F ,PR ,3 ,2 ,3 ,3 ,1 ,1 ,NR ,3.08 ,W ,3 ,2 ,3
PSYC ,95 ,F ,SS ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,2.67 ,W ,4 ,3 ,4
PSYC ,96 ,F ,SS ,3 ,1 ,3 ,4 ,1 ,2 ,TR ,3.45 ,W ,3 ,1 ,3
PSYC ,96 ,F ,SS ,4 ,3 ,4 ,3 ,1 ,1 ,CF ,3.87 ,W ,4 ,3 ,4
ACCT ,95 ,M ,PR ,4 ,4 ,4 ,4 ,1 ,1 ,TR ,3.43 ,W ,4 ,4 ,4
MGMT ,95 ,F ,PR ,4 ,4 ,4 ,4 ,1 ,1 ,TR ,3.76 ,W ,4 ,4 ,4
ENVR ,95 ,F ,NS ,4 ,3 ,4 ,3 ,1 ,1 ,NR ,2.81 ,W ,4 ,3 ,4
  ,96 ,  ,  ,3 ,3 ,4 ,4 ,1 ,1 ,  ,. ,  ,3 ,3 ,4
ENVR ,95 ,M ,NS ,4 ,3 ,3 ,4 ,1 ,1 ,NR ,2.85 ,W ,4 ,3 ,3
PSYC ,96 ,F ,SS ,3 ,2 ,3 ,4 ,1 ,1 ,NR ,2.4 ,W ,3 ,2 ,3
HIST ,95 ,F ,SS ,4 ,3 ,3 ,4 ,1 ,1 ,CT ,2.92 ,W ,4 ,3 ,3
PSYC ,95 ,F ,SS ,2 ,2 ,3 ,2 ,2 ,1 ,NR ,2.99 ,W ,2 ,2 ,3
PSYC ,95 ,F ,SS ,4 ,3 ,4 ,3 ,1 ,2 ,TR ,2.66 ,W ,4 ,3 ,4
BIOL ,96 ,F ,NS ,4 ,3 ,3 ,3 ,1 ,1 ,TR ,3.33 ,W ,4 ,3 ,3
PSYC ,96 ,M ,SS ,4 ,4 ,3 ,3 ,1 ,1 ,TR ,3.45 ,W ,4 ,4 ,3
ECON ,95 ,M ,SS ,3 ,1 ,4 ,3 ,1 ,1 ,NR ,3.44 ,W ,3 ,1 ,4
CSCI ,95 ,M ,PR ,4 ,3 ,3 ,4 ,1 ,1 ,NR ,2.78 ,W ,4 ,3 ,3
SOC ,95 ,F ,SS ,2 ,2 ,1 ,2 ,1 ,1 ,TR ,2.8 ,B ,2 ,2 ,1
MATH ,96 ,F ,NS ,3 ,2 ,3 ,2 ,1 ,1 ,NR ,2.88 ,W ,3 ,2 ,3
PHIL ,96 ,M ,HM ,4 ,3 ,4 ,3 ,1 ,1 ,GE ,3 ,W ,4 ,3 ,4
CSCI ,96 ,M ,PR ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,2.96 ,W ,4 ,3 ,4
ART ,95 ,F ,HM ,4 ,1 ,4 ,3 ,1 ,1 ,TR ,3.52 ,W ,4 ,1 ,4
BIOL ,96 ,F ,NS ,3 ,2 ,3 ,2 ,1 ,1 ,NR ,2.83 ,W ,3 ,2 ,3
ACCT ,95 ,M ,PR ,4 ,4 ,4 ,3 ,1 ,2 ,TR ,2.5 ,W ,4 ,4 ,4
ENVR ,96 ,F ,NS ,4 ,1 ,2 ,4 ,1 ,1 ,NR ,2.59 ,W ,4 ,1 ,2
SOC ,95 ,F ,SS ,3 ,4 ,3 ,1 ,2 ,1 ,NR ,3.27 ,W ,3 ,4 ,3
SOC ,96 ,F ,SS ,4 ,2 ,3 ,4 ,1 ,1 ,TR ,2.94 ,W ,4 ,2 ,3
BIOL ,96 ,M ,NS ,3 ,3 ,2 ,3 ,2 ,1 ,NR ,3.19 ,W ,3 ,3 ,2
ACCT ,96 ,F ,PR ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,2.73 ,W ,4 ,3 ,4
MCOM ,96 ,F ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,TR ,2.85 ,A ,3 ,3 ,3
PSYC ,95 ,F ,SS ,3 ,2 ,2 ,4 ,1 ,1 ,TR ,3.5 ,W ,3 ,2 ,2
MGMT ,95 ,F ,PR ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,2.98 ,W ,4 ,3 ,4
CHEM ,96 ,M ,NS ,2 ,2 ,2 ,4 ,2 ,2 ,TR ,3.68 ,W ,2 ,2 ,2
MCOM ,95 ,M ,PR ,3 ,3 ,1 ,4 ,2 ,1 ,TR ,3.24 ,W ,3 ,3 ,1
ACCT ,96 ,F ,PR ,4 ,4 ,4 ,4 ,1 ,1 ,TR ,3.61 ,W ,4 ,4 ,4
ACCT ,96 ,F ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,CT ,3.76 ,W ,3 ,3 ,3
ECON ,96 ,M ,SS ,4 ,2 ,3 ,3 ,1 ,1 ,NR ,3.44 ,W ,4 ,2 ,3
FREN ,96 ,F ,HM ,3 ,2 ,2 ,2 ,1 ,1 ,NR ,3.58 ,W ,3 ,2 ,2
MATH ,96 ,F ,NS ,3 ,  ,4 ,4 ,1 ,1 ,CT ,3.64 ,W ,3 ,. ,4
CSCI ,95 ,M ,PR ,3 ,1 ,2 ,4 ,2 ,1 ,TR ,3.84 ,A ,3 ,1 ,2
MGMT ,96 ,M ,PR ,3 ,2 ,3 ,2 ,1 ,1 ,NR ,3.66 ,W ,3 ,2 ,3
PSYC ,96 ,F ,SS ,3 ,3 ,4 ,4 ,1 ,2 ,NR ,3.17 ,W ,3 ,3 ,4
MGMT ,96 ,F ,PR ,4 ,4 ,4 ,4 ,1 ,1 ,TR ,3.21 ,W ,4 ,4 ,4
MGMT ,95 ,M ,PR ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,2.98 ,W ,4 ,3 ,4
ACCT ,95 ,F ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,CT ,3.09 ,W ,3 ,3 ,3
HIST ,96 ,F ,SS ,4 ,3 ,3 ,4 ,1 ,1 ,TR ,3.01 ,W ,4 ,3 ,3
MGMT ,95 ,M ,PR ,4 ,3 ,3 ,3 ,1 ,1 ,TR ,2.91 ,W ,4 ,3 ,3
ACCT ,95 ,M ,PR ,4 ,3 ,4 ,4 ,1 ,2 ,TR ,3.01 ,W ,4 ,3 ,4
PSYC ,96 ,F ,SS ,4 ,4 ,4 ,3 ,1 ,1 ,NR ,2.88 ,W ,4 ,4 ,4
DRAM ,96 ,M ,HM ,4 ,4 ,4 ,4 ,1 ,1 ,TR ,3.07 ,W ,4 ,4 ,4
MCOM ,96 ,F ,PR ,4 ,3 ,4 ,3 ,1 ,1 ,NR ,3.57 ,W ,4 ,3 ,4
PHYS ,96 ,M ,NS ,3 ,3 ,3 ,3 ,1 ,1 ,TR ,3.41 ,W ,3 ,3 ,3
LIT ,96 ,F ,HM ,4 ,2 ,4 ,2 ,1 ,1 ,NR ,3.5 ,W ,4 ,2 ,4
PSYC ,95 ,F ,SS ,3 ,3 ,3 ,4 ,1 ,1 ,NR ,2.39 ,W ,3 ,3 ,3
MUSC ,96 ,M ,HM ,3 ,1 ,3 ,3 ,  ,  ,TR ,3.43 ,W ,3 ,1 ,3
MUSC ,96 ,M ,HM ,4 ,1 ,3 ,4 ,2 ,1 ,TR ,2.63 ,W ,4 ,1 ,3
MGMT ,96 ,M ,PR ,3 ,2 ,3 ,2 ,1 ,1 ,NR ,2.11 ,W ,3 ,2 ,3
ACCT ,95 ,F ,PR ,3 ,3 ,4 ,3 ,1 ,1 ,NR ,2.58 ,W ,3 ,3 ,4
MGMT ,95 ,M ,PR ,2 ,3 ,2 ,4 ,2 ,1 ,NR ,2.67 ,W ,2 ,3 ,2
MGMT ,96 ,M ,PR ,3 ,2 ,2 ,4 ,1 ,1 ,NR ,3.43 ,W ,3 ,2 ,2
  ,96 ,  ,  ,4 ,2 ,4 ,1 ,1 ,1 ,  ,. ,  ,4 ,2 ,4
PSYC ,96 ,F ,SS ,3 ,4 ,3 ,4 ,1 ,1 ,NR ,3.51 ,W ,3 ,4 ,3
MGMT ,96 ,F ,PR ,3 ,3 ,2 ,3 ,1 ,1 ,NR ,2.59 ,W ,3 ,3 ,2
ENVR ,96 ,F ,NS ,3 ,3 ,3 ,3 ,1 ,1 ,TR ,3.51 ,W ,3 ,3 ,3
MGMT ,95 ,F ,PR ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,3.82 ,W ,4 ,3 ,4
MUSC ,96 ,M ,HM ,2 ,2 ,2 ,4 ,1 ,2 ,TR ,2.77 ,W ,2 ,2 ,2
PSYC ,96 ,F ,SS ,4 ,3 ,3 ,4 ,1 ,  ,CT ,2.84 ,W ,4 ,3 ,3
LIT ,96 ,M ,HM ,3 ,4 ,3 ,2 ,1 ,1 ,NR ,3.13 ,W ,3 ,4 ,3
PHIL ,96 ,M ,HM ,3 ,1 ,  ,1 ,1 ,  ,NR ,2.38 ,W ,3 ,1 ,.
LIT ,96 ,F ,HM ,4 ,2 ,4 ,4 ,1 ,1 ,NR ,2.85 ,W ,4 ,2 ,4
PSYC ,96 ,F ,SS ,3 ,3 ,3 ,2 ,1 ,1 ,TR ,2.5 ,W ,3 ,3 ,3
SOC ,95 ,F ,SS ,2 ,2 ,3 ,1 ,1 ,1 ,NR ,2.37 ,W ,2 ,2 ,3
PHIL ,95 ,M ,HM ,4 ,4 ,4 ,4 ,1 ,1 ,NR ,3.26 ,W ,4 ,4 ,4
MGMT ,95 ,F ,PR ,4 ,4 ,4 ,4 ,1 ,2 ,NR ,2.33 ,B ,4 ,4 ,4
HIST ,96 ,M ,SS ,4 ,2 ,4 ,3 ,1 ,1 ,TR ,2.62 ,W ,4 ,2 ,4
ACCT ,95 ,F ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,NR ,3.09 ,W ,3 ,3 ,3
PSYC ,95 ,F ,SS ,4 ,2 ,4 ,1 ,1 ,1 ,TR ,3.98 ,W ,4 ,2 ,4
HIST ,95 ,M ,SS ,3 ,3 ,4 ,3 ,1 ,1 ,NR ,2.72 ,W ,3 ,3 ,4
PSYC ,96 ,F ,SS ,4 ,2 ,4 ,2 ,1 ,2 ,TR ,2.96 ,W ,4 ,2 ,4
ECON ,96 ,M ,SS ,4 ,2 ,4 ,4 ,1 ,1 ,NR ,2.9 ,W ,4 ,2 ,4
MGMT ,96 ,F ,PR ,3 ,1 ,2 ,2 ,1 ,2 ,NR ,3.71 ,W ,3 ,1 ,2
MATH ,96 ,F ,NS ,1 ,2 ,4 ,2 ,2 ,1 ,NR ,3.57 ,W ,1 ,2 ,4
MGMT ,96 ,M ,PR ,4 ,4 ,4 ,2 ,1 ,1 ,TR ,2.13 ,S ,4 ,4 ,4
ACCT ,96 ,M ,PR ,4 ,4 ,4 ,3 ,1 ,1 ,CT ,3.23 ,W ,4 ,4 ,4
POLS ,95 ,F ,SS ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,3.79 ,W ,4 ,3 ,4
CSCI ,96 ,M ,PR ,4 ,3 ,3 ,4 ,1 ,1 ,CT ,3.22 ,W ,4 ,3 ,3
MGMT ,96 ,M ,PR ,3 ,2 ,3 ,4 ,1 ,2 ,NR ,2 ,W ,3 ,2 ,3
PSYC ,96 ,F ,SS ,3 ,3 ,4 ,3 ,1 ,1 ,NR ,2.51 ,W ,3 ,3 ,4
  ,96 ,  ,  ,3 ,3 ,3 ,4 ,1 ,2 ,  ,. ,  ,3 ,3 ,3
ACCT ,95 ,M ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,TR ,2.6 ,W ,3 ,3 ,3
ACCT ,95 ,F ,PR ,4 ,4 ,4 ,4 ,1 ,2 ,TR ,3.71 ,W ,4 ,4 ,4
SOC ,95 ,F ,SS ,4 ,1 ,3 ,2 ,1 ,1 ,TR ,2.96 ,W ,4 ,1 ,3
ECON ,95 ,M ,SS ,3 ,1 ,2 ,3 ,2 ,1 ,NR ,2.97 ,W ,3 ,1 ,2
SOC ,96 ,F ,SS ,3 ,3 ,2 ,3 ,2 ,2 ,TR ,2.12 ,W ,3 ,3 ,2
MGMT ,96 ,M ,PR ,3 ,2 ,3 ,2 ,2 ,1 ,TR ,2.2 ,W ,3 ,2 ,3
MGMT ,96 ,F ,PR ,2 ,1 ,2 ,2 ,2 ,1 ,TR ,2.63 ,A ,2 ,1 ,2
MUSC ,96 ,M ,HM ,4 ,3 ,3 ,4 ,1 ,2 ,TR ,3.15 ,W ,4 ,3 ,3
PSYC ,95 ,M ,SS ,3 ,3 ,3 ,3 ,2 ,1 ,TR ,2.97 ,W ,3 ,3 ,3
SPAN ,96 ,F ,HM ,3 ,2 ,3 ,4 ,1 ,1 ,NR ,3.84 ,W ,3 ,2 ,3
MGMT ,96 ,M ,PR ,4 ,3 ,4 ,3 ,1 ,1 ,NR ,3.35 ,W ,4 ,3 ,4
MGMT ,95 ,M ,PR ,4 ,1 ,3 ,4 ,1 ,1 ,TR ,3.32 ,W ,4 ,1 ,3
ATMS ,96 ,M ,NS ,3 ,3 ,2 ,2 ,1 ,1 ,TR ,2.58 ,W ,3 ,3 ,2
ECON ,95 ,M ,SS ,3 ,3 ,3 ,2 ,1 ,1 ,TR ,2.47 ,W ,3 ,3 ,3
ENVR ,96 ,M ,NS ,4 ,3 ,3 ,4 ,1 ,1 ,TR ,3.37 ,W ,4 ,3 ,3
LIT ,95 ,M ,HM ,4 ,1 ,4 ,1 ,1 ,1 ,CF ,2.62 ,W ,4 ,1 ,4
SOC ,95 ,F ,SS ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,3.5 ,W ,4 ,3 ,4
BIOL ,95 ,M ,NS ,4 ,4 ,4 ,4 ,1 ,1 ,TR ,3.6 ,W ,4 ,4 ,4
CSCI ,96 ,M ,PR ,4 ,2 ,3 ,4 ,1 ,1 ,TR ,3.55 ,W ,4 ,2 ,3
MCOM ,96 ,F ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,NR ,2.91 ,B ,3 ,3 ,3
BIOL ,96 ,M ,NS ,3 ,2 ,2 ,3 ,1 ,2 ,TR ,2.75 ,W ,3 ,2 ,2
ATMS ,95 ,M ,NS ,3 ,3 ,3 ,4 ,1 ,1 ,TR ,3.51 ,B ,3 ,3 ,3
LIT ,96 ,F ,HM ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,3.37 ,W ,4 ,3 ,4
ATMS ,96 ,M ,NS ,4 ,4 ,4 ,4 ,1 ,1 ,NR ,3.15 ,W ,4 ,4 ,4
PSYC ,95 ,M ,SS ,4 ,2 ,4 ,2 ,  ,1 ,TR ,2.67 ,W ,4 ,2 ,4
ENVR ,96 ,F ,NS ,3 ,4 ,3 ,4 ,2 ,1 ,NR ,2.98 ,W ,3 ,4 ,3
GERM ,96 ,F ,HM ,4 ,4 ,4 ,3 ,1 ,1 ,TR ,3.8 ,W ,4 ,4 ,4
ART ,95 ,F ,HM ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,2.7 ,W ,4 ,3 ,4
CSCI ,95 ,M ,PR ,4 ,3 ,2 ,4 ,1 ,1 ,TR ,3.27 ,W ,4 ,3 ,2
PSYC ,95 ,F ,SS ,4 ,3 ,4 ,2 ,1 ,2 ,NR ,3.36 ,W ,4 ,3 ,4
MGMT ,96 ,M ,PR ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,3.2 ,W ,4 ,3 ,4
MUSC ,95 ,M ,HM ,3 ,2 ,4 ,4 ,2 ,1 ,TR ,3.24 ,W ,3 ,2 ,4
ENVR ,96 ,F ,NS ,3 ,3 ,3 ,4 ,1 ,1 ,NR ,3.34 ,W ,3 ,3 ,3
ENVR ,96 ,F ,NS ,3 ,3 ,4 ,3 ,1 ,2 ,NR ,3.25 ,W ,3 ,3 ,4
BIOL ,95 ,F ,NS ,4 ,4 ,4 ,4 ,1 ,1 ,TR ,2.48 ,W ,4 ,4 ,4
ACCT ,96 ,F ,PR ,3 ,4 ,2 ,1 ,1 ,1 ,NR ,3.24 ,W ,3 ,4 ,2
IEMT ,96 ,F ,PR ,4 ,2 ,3 ,3 ,1 ,1 ,NR ,3.44 ,W ,4 ,2 ,3
MCOM ,96 ,F ,PR ,3 ,3 ,4 ,2 ,1 ,1 ,TR ,3.59 ,W ,3 ,3 ,4
POLS ,95 ,F ,SS ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,3.84 ,W ,4 ,3 ,4
MGMT ,95 ,F ,PR ,3 ,3 ,3 ,4 ,1 ,1 ,TR ,3.13 ,W ,3 ,3 ,3
ACCT ,96 ,F ,PR ,3 ,2 ,2 ,3 ,2 ,1 ,TR ,3.92 ,W ,3 ,2 ,2
BIOL ,96 ,F ,NS ,3 ,2 ,4 ,3 ,1 ,1 ,TR ,4 ,W ,3 ,2 ,4
HIST ,96 ,F ,SS ,3 ,3 ,3 ,3 ,1 ,1 ,TR ,3.11 ,W ,3 ,3 ,3
MGMT ,95 ,F ,PR ,4 ,3 ,3 ,4 ,1 ,1 ,TR ,3.62 ,W ,4 ,3 ,3
BIOL ,96 ,F ,NS ,3 ,1 ,4 ,3 ,1 ,1 ,NR ,2.69 ,W ,3 ,1 ,4
BIOL ,96 ,F ,NS ,4 ,2 ,4 ,3 ,1 ,1 ,TR ,2.96 ,W ,4 ,2 ,4
HIST ,96 ,M ,SS ,3 ,2 ,3 ,4 ,1 ,1 ,NR ,3.01 ,W ,3 ,2 ,3
HIST ,95 ,F ,SS ,4 ,3 ,4 ,4 ,1 ,  ,TR ,3.84 ,W ,4 ,3 ,4
ECON ,96 ,M ,SS ,4 ,1 ,4 ,4 ,1 ,2 ,NR ,2.47 ,W ,4 ,1 ,4
ART ,96 ,F ,HM ,4 ,2 ,4 ,1 ,1 ,1 ,TR ,3.55 ,W ,4 ,2 ,4
MGMT ,96 ,F ,PR ,4 ,3 ,4 ,3 ,1 ,1 ,NR ,2.98 ,W ,4 ,3 ,4
  ,96 ,  ,  ,4 ,2 ,3 ,2 ,1 ,2 ,  ,. ,  ,4 ,2 ,3
PSYC ,96 ,F ,SS ,2 ,2 ,3 ,2 ,2 ,1 ,TR ,3.56 ,W ,2 ,2 ,3
ART ,95 ,F ,HM ,4 ,  ,4 ,. ,2 ,1 ,CT ,3.55 ,W ,4 ,. ,4
MGMT ,96 ,M ,PR ,3 ,3 ,3 ,2 ,  ,  ,TR ,3.74 ,W ,3 ,3 ,3
HIST ,96 ,F ,SS ,4 ,3 ,4 ,4 ,1 ,  ,CT ,3.66 ,W ,4 ,3 ,4
POLS ,96 ,F ,SS ,4 ,3 ,4 ,4 ,1 ,1 ,NR ,3.39 ,B ,4 ,3 ,4
PHIL ,96 ,M ,HM ,4 ,2 ,3 ,3 ,1 ,1 ,TR ,3.09 ,W ,4 ,2 ,3
PSYC ,96 ,F ,SS ,4 ,3 ,4 ,3 ,1 ,1 ,NR ,3.13 ,W ,4 ,3 ,4
BIOL ,96 ,M ,NS ,4 ,3 ,4 ,3 ,1 ,1 ,TR ,3.04 ,W ,4 ,3 ,4
ACCT ,95 ,F ,PR ,3 ,2 ,2 ,3 ,1 ,2 ,TR ,3.08 ,W ,3 ,2 ,2
MGMT ,96 ,F ,PR ,4 ,2 ,3 ,3 ,1 ,1 ,TR ,2.44 ,W ,4 ,2 ,3
MCOM ,95 ,M ,PR ,3 ,3 ,3 ,4 ,  ,1 ,TR ,3.34 ,W ,3 ,3 ,3
POLS ,96 ,F ,SS ,3 ,2 ,3 ,0 ,1 ,1 ,TR ,2.57 ,W ,3 ,2 ,3
FREN ,96 ,F ,HM ,4 ,3 ,4 ,2 ,1 ,1 ,NR ,3.88 ,W ,4 ,3 ,4
POLS ,96 ,F ,SS ,3 ,2 ,3 ,3 ,1 ,1 ,NR ,2.53 ,W ,3 ,2 ,3
MCOM ,96 ,F ,PR ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,3.64 ,W ,4 ,3 ,4
PHIL ,96 ,F ,HM ,4 ,2 ,4 ,2 ,1 ,1 ,TR ,3.57 ,W ,4 ,2 ,4
ACCT ,96 ,F ,PR ,3 ,2 ,4 ,3 ,1 ,2 ,NR ,3.22 ,A ,3 ,2 ,4
SOC ,96 ,M ,SS ,3 ,1 ,1 ,2 ,1 ,2 ,TR ,3.27 ,W ,3 ,1 ,1
ENVR ,95 ,M ,NS ,3 ,3 ,3 ,2 ,1 ,1 ,NR ,3 ,W ,3 ,3 ,3
ENVR ,96 ,F ,NS ,4 ,3 ,3 ,2 ,1 ,1 ,TR ,3 ,W ,4 ,3 ,3
PSYC ,95 ,F ,SS ,3 ,1 ,2 ,3 ,1 ,1 ,TR ,2.59 ,B ,3 ,1 ,2
ENVR ,96 ,F ,NS ,4 ,3 ,3 ,4 ,1 ,1 ,TR ,2.59 ,W ,4 ,3 ,3
SOC ,95 ,F ,SS ,4 ,3 ,4 ,2 ,1 ,1 ,TR ,3.65 ,W ,4 ,3 ,4
ATMS ,96 ,M ,NS ,2 ,1 ,2 ,3 ,2 ,2 ,TR ,3.06 ,W ,2 ,1 ,2
PSYC ,96 ,M ,SS ,3 ,2 ,3 ,3 ,2 ,1 ,TR ,2.16 ,B ,3 ,2 ,3
BIOL ,96 ,F ,NS ,4 ,4 ,4 ,4 ,1 ,1 ,TR ,2.55 ,W ,4 ,4 ,4
CSCI ,95 ,M ,PR ,  ,  ,  ,4 ,1 ,1 ,TR ,2.33 ,W ,. ,. ,.
BIOL ,95 ,F ,NS ,4 ,4 ,4 ,3 ,1 ,1 ,CT ,3.04 ,W ,4 ,4 ,4
LIT ,96 ,F ,HM ,4 ,4 ,4 ,4 ,1 ,1 ,NR ,3.72 ,W ,4 ,4 ,4
ART ,96 ,F ,HM ,4 ,2 ,3 ,0 ,1 ,1 ,TR ,3.86 ,W ,4 ,2 ,3
MCOM ,95 ,F ,PR ,4 ,3 ,4 ,3 ,1 ,2 ,TR ,3.55 ,W ,4 ,3 ,4
ENVR ,96 ,F ,NS ,2 ,3 ,2 ,3 ,1 ,1 ,TR ,2.7 ,W ,2 ,3 ,2
PSYC ,96 ,F ,SS ,3 ,2 ,3 ,3 ,2 ,1 ,TR ,2.33 ,W ,3 ,2 ,3
IEMT ,96 ,F ,PR ,4 ,3 ,4 ,3 ,1 ,1 ,NR ,3.1 ,A ,4 ,3 ,4
MGMT ,96 ,F ,PR ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,2.83 ,W ,4 ,3 ,4
ACCT ,96 ,F ,PR ,4 ,4 ,4 ,4 ,1 ,1 ,TR ,3.26 ,W ,4 ,4 ,4
BIOL ,96 ,M ,NS ,4 ,3 ,4 ,3 ,1 ,1 ,TR ,3.53 ,W ,4 ,3 ,4
IEMT ,96 ,M ,PR ,3 ,1 ,2 ,4 ,2 ,1 ,NR ,2.45 ,B ,3 ,1 ,2
POLS ,95 ,M ,SS ,4 ,2 ,4 ,2 ,1 ,1 ,TR ,2.47 ,W ,4 ,2 ,4
  ,96 ,  ,  ,3 ,2 ,3 ,3 ,2 ,1 ,  ,. ,  ,3 ,2 ,3
BIOL ,96 ,F ,NS ,4 ,3 ,4 ,3 ,1 ,2 ,NR ,3.5 ,W ,4 ,3 ,4
  ,96 ,  ,  ,4 ,3 ,4 ,3 ,2 ,1 ,  ,. ,  ,4 ,3 ,4
MGMT ,96 ,M ,PR ,3 ,3 ,3 ,3 ,1 ,1 ,NR ,2.84 ,W ,3 ,3 ,3
DRAM ,96 ,M ,HM ,3 ,4 ,4 ,4 ,1 ,1 ,NR ,3.45 ,W ,3 ,4 ,4
ENVR ,96 ,M ,NS ,3 ,2 ,3 ,4 ,1 ,1 ,TR ,2.53 ,W ,3 ,2 ,3
CSCI ,96 ,M ,PR ,4 ,4 ,4 ,4 ,1 ,1 ,TR ,3.94 ,W ,4 ,4 ,4
MGMT ,96 ,M ,PR ,4 ,3 ,4 ,3 ,2 ,1 ,TR ,3.07 ,B ,4 ,3 ,4
ACCT ,96 ,F ,PR ,4 ,3 ,3 ,3 ,1 ,1 ,TR ,4 ,W ,4 ,3 ,3
ACCT ,96 ,M ,PR ,4 ,4 ,2 ,2 ,2 ,1 ,NR ,3.87 ,W ,4 ,4 ,2
ACCT ,96 ,M ,PR ,3 ,3 ,4 ,0 ,1 ,1 ,CT ,2.45 ,W ,3 ,3 ,4
HIST ,96 ,F ,SS ,4 ,3 ,4 ,0 ,2 ,1 ,TR ,3.21 ,W ,4 ,3 ,4
POLS ,96 ,M ,SS ,3 ,1 ,3 ,3 ,1 ,2 ,TR ,3.39 ,W ,3 ,1 ,3
HIST ,95 ,M ,SS ,2 ,3 ,2 ,3 ,1 ,1 ,NR ,3.06 ,W ,2 ,3 ,2
ENVR ,95 ,F ,NS ,4 ,3 ,3 ,2 ,1 ,1 ,TR ,3.54 ,W ,4 ,3 ,3
ATMS ,96 ,M ,NS ,4 ,4 ,4 ,4 ,1 ,1 ,TR ,3.55 ,W ,4 ,4 ,4
BIOL ,95 ,M ,NS ,4 ,2 ,3 ,3 ,1 ,1 ,NR ,2.66 ,W ,4 ,2 ,3
SPAN ,95 ,M ,HM ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,3.85 ,W ,4 ,3 ,4
POLS ,96 ,F ,SS ,4 ,2 ,4 ,4 ,1 ,1 ,CF ,3.95 ,W ,4 ,2 ,4
MGMT ,95 ,F ,PR ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,2.62 ,W ,4 ,3 ,4
HIST ,95 ,M ,SS ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,2.53 ,W ,4 ,3 ,4
  ,96 ,  ,  ,4 ,3 ,4 ,3 ,1 ,1 ,  ,. ,  ,4 ,3 ,4
ATMS ,96 ,M ,NS ,4 ,4 ,4 ,4 ,1 ,1 ,TR ,3.87 ,W ,4 ,4 ,4
SOC ,95 ,M ,SS ,4 ,3 ,3 ,2 ,1 ,1 ,TR ,3.52 ,W ,4 ,3 ,3
HIST ,96 ,F ,SS ,3 ,3 ,3 ,3 ,1 ,2 ,NR ,2.08 ,B ,3 ,3 ,3
PSYC ,96 ,F ,SS ,4 ,4 ,4 ,4 ,1 ,1 ,TR ,2.77 ,W ,4 ,4 ,4
LIT ,96 ,F ,HM ,3 ,2 ,3 ,3 ,2 ,1 ,TR ,2.11 ,W ,3 ,2 ,3
ACCT ,96 ,M ,PR ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,2.96 ,A ,4 ,3 ,4
FREN ,96 ,F ,HM ,3 ,3 ,3 ,4 ,1 ,1 ,TR ,3.24 ,W ,3 ,3 ,3
ENVR ,95 ,M ,NS ,4 ,3 ,4 ,4 ,1 ,1 ,TR ,3.49 ,W ,4 ,3 ,4
PSYC ,96 ,M ,SS ,3 ,2 ,4 ,4 ,1 ,1 ,NR ,2.6 ,W ,3 ,2 ,4
SOC ,96 ,M ,SS ,4 ,  ,  ,3 ,1 ,1 ,TR ,2.79 ,W ,4 ,. ,.
CSCI ,96 ,M ,PR ,4 ,4 ,3 ,4 ,1 ,1 ,TR ,3.71 ,W ,4 ,4 ,3
  ,96 ,  ,  ,3 ,1 ,3 ,3 ,2 ,1 ,  ,. ,  ,3 ,1 ,3
  ,96 ,  ,  ,3 ,3 ,3 ,3 ,2 ,2 ,  ,. ,  ,3 ,3 ,3

/* db90.dat */

  ,  ,  ,  ,  ,  ,3 ,  ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,5 ,3 ,. ,8 ,T ,90 ,4
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,25 ,1 ,5 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,16 ,4 ,3 ,. ,6 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,30 ,7 ,5 ,. ,6 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,1 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,. ,10 ,8 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,8 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,36 ,6 ,3 ,. ,4 ,T ,90 ,2
  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,7 ,3 ,. ,6 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,8 ,7 ,. ,7 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,20 ,10 ,8 ,. ,8 ,F ,90 ,9
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,1 ,15 ,1 ,6 ,. ,7 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,3 ,. ,3 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,5 ,3 ,. ,6 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,7 ,6 ,. ,4 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,10 ,7 ,. ,7 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,35 ,6 ,3 ,. ,4 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,5 ,. ,3 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,8 ,6 ,. ,5 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,3 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,23 ,10 ,3 ,. ,8 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,14 ,1 ,7 ,. ,7 ,T ,90 ,17
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,2 ,3 ,. ,3 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,30 ,4 ,3 ,. ,3 ,F ,90 ,6
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,3 ,5 ,. ,6 ,T ,90 ,7
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,37 ,3 ,4 ,. ,6 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,10 ,2 ,5 ,. ,3 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,9 ,3 ,. ,4 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,10 ,4 ,. ,3 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,15 ,2 ,3 ,. ,1 ,T ,90 ,5
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,10 ,5 ,. ,8 ,F ,90 ,18
  ,  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,3 ,3 ,. ,5 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,6 ,3 ,. ,6 ,F ,90 ,18
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,2 ,3 ,. ,7 ,F ,90 ,17
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,1 ,40 ,3 ,1 ,. ,5 ,T ,90 ,6
  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,6 ,3 ,. ,3 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,15 ,7 ,5 ,. ,6 ,T ,90 ,7
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,7 ,8 ,5 ,. ,6 ,T ,90 ,17
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,19 ,5 ,8 ,. ,8 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,. ,5 ,6 ,. ,8 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,8 ,. ,8 ,F ,90 ,18
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,55 ,7 ,6 ,. ,6 ,T ,90 ,3
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,0 ,0 ,1 ,0 ,1 ,0 ,25 ,10 ,5 ,. ,5 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,3 ,3 ,. ,3 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,2 ,  ,1 ,0 ,1 ,0 ,1 ,0 ,. ,2 ,8 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,10 ,4 ,. ,8 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,8 ,7 ,3 ,. ,3 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,20 ,2 ,3 ,. ,4 ,T ,90 ,7
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,5 ,. ,3 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,3 ,. ,5 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,6 ,6 ,. ,8 ,T ,90 ,19
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,35 ,5 ,6 ,. ,6 ,T ,90 ,4
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,0 ,. ,6 ,6 ,. ,8 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,6 ,. ,5 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,8 ,5 ,. ,5 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,2 ,3 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,6 ,6 ,. ,8 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,7 ,7 ,. ,8 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,10 ,. ,5 ,. ,5 ,T ,90 ,18
  ,  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,2 ,5 ,. ,6 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,. ,8 ,. ,8 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,5 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,5 ,4 ,. ,4 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,8 ,5 ,. ,5 ,F ,90 ,17
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,4 ,2 ,. ,2 ,T ,90 ,6
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,6 ,. ,8 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,7 ,3 ,. ,5 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,5 ,6 ,. ,6 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,2 ,4 ,. ,2 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,7 ,3 ,. ,3 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,9 ,3 ,. ,3 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,25 ,5 ,6 ,. ,5 ,T ,90 ,7
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,20 ,2 ,6 ,. ,6 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,6 ,. ,6 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,6 ,6 ,. ,6 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,3 ,2 ,. ,3 ,T ,90 ,6
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,46 ,4 ,6 ,. ,4 ,T ,90 ,9
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,3 ,3 ,. ,6 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,3 ,6 ,. ,2 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,5 ,3 ,. ,4 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,1 ,2 ,. ,2 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,6 ,5 ,. ,6 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,38 ,2 ,5 ,. ,7 ,T ,90 ,4
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,3 ,3 ,. ,5 ,T ,90 ,6
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,6 ,7 ,. ,7 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,12 ,4 ,3 ,. ,2 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,6 ,3 ,. ,3 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,10 ,3 ,6 ,. ,5 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,10 ,6 ,3 ,. ,5 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,9 ,6 ,. ,6 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,6 ,5 ,. ,2 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,15 ,3 ,3 ,. ,3 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,10 ,6 ,3 ,. ,5 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,17 ,5 ,3 ,. ,1 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,3 ,. ,5 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,5 ,. ,6 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,1 ,6 ,. ,6 ,F ,90 ,17
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,6 ,5 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,8 ,. ,8 ,F ,90 ,17
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,5 ,4 ,. ,4 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,8 ,8 ,. ,7 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,7 ,8 ,. ,8 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,9 ,5 ,. ,6 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,25 ,8 ,4 ,. ,6 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,8 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,6 ,. ,6 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,8 ,. ,7 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,. ,6 ,. ,8 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,7 ,1 ,2 ,. ,1 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,45 ,6 ,3 ,. ,8 ,T ,90 ,5
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,17 ,. ,4 ,. ,6 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,20 ,2 ,3 ,. ,4 ,T ,90 ,9
  ,  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,25 ,1 ,2 ,. ,3 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,5 ,. ,3 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,25 ,. ,8 ,. ,5 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,7 ,5 ,. ,3 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,25 ,3 ,3 ,. ,2 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,8 ,4 ,. ,4 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,2 ,3 ,. ,3 ,F ,90 ,17
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,20 ,6 ,3 ,. ,2 ,F ,90 ,10
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,25 ,2 ,8 ,. ,6 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,10 ,7 ,5 ,. ,6 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,2 ,5 ,. ,6 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,16 ,8 ,3 ,. ,4 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,27 ,6 ,6 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,5 ,3 ,. ,2 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,7 ,. ,6 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,5 ,. ,5 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,1 ,5 ,. ,6 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,3 ,. ,3 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,3 ,. ,4 ,F ,90 ,12
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,27 ,6 ,2 ,. ,3 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,3 ,7 ,. ,5 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,3 ,. ,5 ,F ,90 ,17
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,9 ,6 ,. ,6 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,3 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,3 ,5 ,. ,6 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,3 ,6 ,. ,3 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,5 ,1 ,. ,1 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,7 ,3 ,. ,4 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,3 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,30 ,7 ,3 ,. ,3 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,20 ,4 ,3 ,. ,3 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,3 ,. ,6 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,16 ,. ,3 ,. ,7 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,5 ,5 ,. ,5 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,30 ,6 ,3 ,. ,3 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,9 ,5 ,. ,5 ,F ,90 ,17
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,5 ,. ,6 ,T ,90 ,3
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,3 ,3 ,. ,5 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,2 ,5 ,. ,6 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,7 ,6 ,. ,6 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,10 ,6 ,. ,5 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,3 ,3 ,. ,3 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,23 ,6 ,6 ,. ,6 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,15 ,. ,8 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,6 ,. ,8 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,5 ,. ,5 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,5 ,5 ,. ,5 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,2 ,3 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,10 ,2 ,. ,6 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,9 ,6 ,. ,6 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,34 ,7 ,6 ,. ,6 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,5 ,5 ,. ,3 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,2 ,6 ,. ,8 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,4 ,3 ,. ,5 ,T ,90 ,7
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,32 ,10 ,5 ,. ,3 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,2 ,5 ,. ,3 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,7 ,3 ,. ,6 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,9 ,8 ,. ,5 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,5 ,1 ,. ,4 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,30 ,7 ,3 ,. ,1 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,8 ,. ,8 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,17 ,4 ,3 ,. ,3 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,25 ,6 ,4 ,. ,8 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,22 ,3 ,6 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,2 ,3 ,2 ,0 ,1 ,0 ,1 ,0 ,0 ,40 ,1 ,7 ,. ,8 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,33 ,8 ,5 ,. ,4 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,9 ,6 ,. ,2 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,7 ,3 ,. ,4 ,F ,90 ,12
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,6 ,. ,6 ,F ,90 ,17
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,4 ,. ,. ,F ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,7 ,3 ,. ,3 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,6 ,3 ,. ,5 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,9 ,5 ,. ,5 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,17 ,4 ,4 ,. ,3 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,0 ,0 ,1 ,1 ,1 ,0 ,. ,4 ,8 ,. ,8 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,5 ,3 ,. ,3 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,35 ,8 ,6 ,. ,6 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,5 ,. ,8 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,2 ,. ,2 ,T ,90 ,9
  ,  ,  ,  ,  ,  ,1 ,1 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,4 ,5 ,. ,3 ,T ,90 ,9
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,1 ,5 ,. ,6 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,1 ,6 ,. ,6 ,F ,90 ,17
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,40 ,1 ,3 ,. ,3 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,23 ,10 ,5 ,. ,6 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,8 ,4 ,. ,3 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,18 ,7 ,3 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,25 ,. ,5 ,. ,4 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,5 ,5 ,. ,7 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,15 ,10 ,5 ,. ,8 ,T ,90 ,17
  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,6 ,3 ,. ,4 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,  ,1 ,1 ,0 ,1 ,0 ,0 ,. ,2 ,5 ,. ,8 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,3 ,. ,3 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,4 ,3 ,. ,3 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,4 ,. ,4 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,10 ,6 ,. ,8 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,10 ,6 ,. ,6 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,12 ,8 ,6 ,. ,5 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,6 ,. ,5 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,5 ,6 ,. ,7 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,30 ,2 ,5 ,. ,3 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,25 ,8 ,6 ,. ,3 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,6 ,4 ,. ,4 ,F ,90 ,18
  ,  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,16 ,3 ,5 ,. ,2 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,40 ,8 ,3 ,. ,5 ,F ,90 ,4
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,3 ,. ,4 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,3 ,4 ,. ,3 ,F ,90 ,9
  ,  ,  ,  ,  ,  ,1 ,1 ,  ,1 ,1 ,0 ,1 ,1 ,0 ,. ,9 ,8 ,. ,5 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,6 ,3 ,. ,3 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,10 ,3 ,. ,3 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,15 ,7 ,3 ,. ,3 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,3 ,3 ,. ,4 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,18 ,5 ,5 ,. ,3 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,8 ,. ,8 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,  ,1 ,0 ,0 ,0 ,1 ,0 ,. ,2 ,5 ,. ,6 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,3 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,15 ,7 ,5 ,. ,6 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,5 ,. ,6 ,T ,90 ,17
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,3 ,3 ,. ,6 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,4 ,. ,. ,F ,90 ,13
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,9 ,8 ,. ,8 ,F ,90 ,9
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,21 ,7 ,4 ,. ,3 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,7 ,. ,8 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,9 ,3 ,. ,4 ,F ,90 ,17
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,6 ,3 ,. ,3 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,  ,3 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,2 ,3 ,. ,5 ,T ,90 ,9
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,10 ,1 ,5 ,. ,5 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,8 ,5 ,. ,6 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,12 ,8 ,3 ,. ,5 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,3 ,3 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,10 ,4 ,8 ,. ,8 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,12 ,5 ,4 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,. ,8 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,20 ,2 ,5 ,. ,5 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,25 ,7 ,4 ,. ,4 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,27 ,1 ,5 ,. ,3 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,8 ,5 ,. ,3 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,9 ,6 ,. ,5 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,7 ,3 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,5 ,. ,7 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,17 ,5 ,5 ,. ,5 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,30 ,4 ,2 ,. ,2 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,7 ,5 ,. ,8 ,F ,90 ,17
  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,3 ,. ,5 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,12 ,10 ,8 ,. ,8 ,F ,90 ,17
  ,  ,  ,  ,  ,  ,2 ,3 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,5 ,5 ,. ,5 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,. ,6 ,. ,7 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,7 ,3 ,. ,3 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,7 ,3 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,3 ,3 ,. ,4 ,F ,90 ,17
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,6 ,. ,8 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,5 ,. ,3 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,. ,4 ,5 ,. ,6 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,4 ,. ,5 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,5 ,6 ,. ,3 ,F ,90 ,18
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,5 ,3 ,. ,6 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,8 ,4 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,32 ,7 ,3 ,. ,1 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,6 ,3 ,. ,3 ,F ,90 ,17
  ,  ,  ,  ,  ,  ,1 ,1 ,  ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,7 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,20 ,2 ,3 ,. ,6 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,8 ,5 ,. ,5 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,5 ,. ,6 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,3 ,3 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,7 ,. ,7 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,10 ,3 ,. ,8 ,T ,90 ,18
  ,  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,3 ,. ,6 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,  ,3 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,15 ,6 ,6 ,. ,3 ,F ,90 ,12
  ,  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,3 ,5 ,. ,1 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,17 ,6 ,3 ,. ,4 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,10 ,5 ,3 ,. ,5 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,5 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,2 ,2 ,. ,2 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,1 ,2 ,. ,2 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,. ,9 ,6 ,. ,6 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,7 ,5 ,. ,8 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,6 ,2 ,. ,1 ,T ,90 ,6
  ,  ,  ,  ,  ,  ,3 ,2 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,5 ,5 ,. ,4 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,10 ,9 ,6 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,12 ,6 ,4 ,. ,5 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,2 ,6 ,. ,7 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,10 ,3 ,. ,6 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,3 ,. ,3 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,15 ,1 ,5 ,. ,5 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,9 ,4 ,. ,6 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,30 ,4 ,3 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,30 ,3 ,7 ,. ,5 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,25 ,2 ,5 ,. ,6 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,10 ,5 ,. ,6 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,5 ,6 ,. ,6 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,7 ,5 ,4 ,. ,5 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,22 ,9 ,6 ,. ,3 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,. ,5 ,. ,4 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,3 ,. ,5 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,7 ,6 ,. ,8 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,6 ,. ,6 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,2 ,3 ,. ,6 ,F ,90 ,12
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,30 ,2 ,4 ,. ,4 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,. ,5 ,. ,5 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,5 ,3 ,. ,4 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,1 ,3 ,. ,7 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,3 ,3 ,. ,3 ,F ,90 ,17
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,3 ,5 ,. ,5 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,3 ,3 ,. ,5 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,12 ,7 ,3 ,. ,6 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,. ,9 ,8 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,3 ,. ,3 ,F ,90 ,17
  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,4 ,. ,5 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,5 ,. ,6 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,1 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,6 ,6 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,6 ,3 ,. ,3 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,2 ,5 ,. ,6 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,12 ,10 ,5 ,. ,8 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,60 ,6 ,4 ,. ,5 ,T ,90 ,7
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,8 ,4 ,. ,3 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,3 ,3 ,. ,5 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,5 ,. ,7 ,F ,90 ,17
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,3 ,5 ,. ,3 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,20 ,. ,4 ,. ,5 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,12 ,5 ,4 ,. ,6 ,T ,90 ,3
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,8 ,6 ,. ,6 ,F ,90 ,17
  ,  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,5 ,. ,5 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,. ,6 ,T ,90 ,17
  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,8 ,3 ,. ,3 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,10 ,6 ,. ,5 ,T ,90 ,4
  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,8 ,. ,8 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,6 ,. ,8 ,F ,90 ,6
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,1 ,17 ,6 ,5 ,. ,5 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,5 ,. ,6 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,7 ,8 ,. ,3 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,2 ,2 ,. ,1 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,. ,. ,. ,. ,F ,90 ,17
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,5 ,. ,4 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,5 ,3 ,. ,2 ,F ,90 ,17
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,32 ,6 ,3 ,. ,2 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,9 ,4 ,. ,8 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,3 ,5 ,. ,2 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,3 ,. ,5 ,F ,90 ,18
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,4 ,. ,5 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,3 ,2 ,. ,4 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,. ,3 ,. ,5 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,8 ,5 ,. ,. ,F ,90 ,14
  ,  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,4 ,. ,5 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,3 ,3 ,. ,2 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,12 ,2 ,5 ,. ,5 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,12 ,8 ,3 ,. ,6 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,25 ,8 ,3 ,. ,5 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,5 ,8 ,6 ,. ,6 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,3 ,. ,3 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,2 ,3 ,. ,5 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,8 ,6 ,. ,6 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,2 ,. ,5 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,15 ,10 ,4 ,. ,4 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,45 ,4 ,2 ,. ,2 ,F ,90 ,3
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,5 ,6 ,. ,8 ,T ,90 ,6
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,45 ,. ,5 ,. ,8 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,1 ,3 ,. ,3 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,30 ,8 ,3 ,. ,3 ,T ,90 ,3
  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,3 ,. ,3 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,40 ,5 ,2 ,. ,1 ,T ,90 ,6
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,6 ,2 ,. ,5 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,6 ,. ,8 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,20 ,8 ,6 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,35 ,2 ,4 ,. ,6 ,T ,90 ,17
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,25 ,6 ,1 ,. ,5 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,9 ,8 ,. ,8 ,T ,90 ,4
  ,  ,  ,  ,  ,  ,1 ,3 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,3 ,5 ,. ,5 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,6 ,3 ,. ,2 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,5 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,20 ,1 ,5 ,. ,6 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,8 ,. ,8 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,30 ,9 ,3 ,. ,6 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,5 ,. ,5 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,. ,3 ,. ,3 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,. ,4 ,5 ,. ,4 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,5 ,4 ,. ,5 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,30 ,6 ,2 ,. ,3 ,F ,90 ,6
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,26 ,5 ,3 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,20 ,8 ,3 ,. ,2 ,T ,90 ,18
  ,  ,  ,  ,  ,  ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,17 ,8 ,3 ,. ,3 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,6 ,4 ,. ,3 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,6 ,. ,5 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,2 ,3 ,. ,3 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,2 ,7 ,. ,4 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,23 ,2 ,3 ,. ,2 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,8 ,4 ,. ,3 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,9 ,6 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,30 ,10 ,3 ,. ,5 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,5 ,6 ,. ,6 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,1 ,3 ,. ,4 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,  ,1 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,. ,5 ,6 ,. ,5 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,12 ,2 ,3 ,. ,3 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,3 ,. ,3 ,F ,90 ,12
  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,6 ,. ,6 ,T ,90 ,7
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,8 ,4 ,. ,6 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,3 ,. ,3 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,5 ,. ,6 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,30 ,4 ,3 ,. ,6 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,4 ,3 ,. ,3 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,35 ,5 ,4 ,. ,4 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,13 ,5 ,3 ,. ,3 ,T ,90 ,18
  ,  ,  ,  ,  ,  ,3 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,. ,6 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,1 ,3 ,. ,1 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,2 ,3 ,1 ,0 ,0 ,1 ,1 ,0 ,0 ,. ,8 ,6 ,. ,8 ,F ,90 ,17
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,3 ,. ,5 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,23 ,10 ,8 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,8 ,3 ,. ,3 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,30 ,1 ,3 ,. ,8 ,F ,90 ,7
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,12 ,6 ,7 ,. ,8 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,19 ,2 ,8 ,. ,8 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,6 ,8 ,. ,6 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,5 ,. ,8 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,2 ,5 ,. ,5 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,8 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,7 ,5 ,. ,3 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,23 ,3 ,5 ,. ,6 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,12 ,8 ,4 ,. ,5 ,T ,90 ,10
  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,4 ,. ,4 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,4 ,. ,5 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,2 ,3 ,. ,3 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,2 ,6 ,. ,6 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,18 ,5 ,3 ,. ,5 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,17 ,2 ,3 ,. ,. ,F ,90 ,16
  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,5 ,. ,5 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,9 ,4 ,6 ,. ,3 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,10 ,1 ,6 ,. ,1 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,40 ,2 ,3 ,. ,3 ,T ,90 ,11
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,9 ,6 ,. ,8 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,8 ,3 ,. ,6 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,8 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,. ,6 ,. ,6 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,5 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,3 ,. ,4 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,4 ,4 ,. ,3 ,F ,90 ,19
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,23 ,8 ,3 ,. ,5 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,6 ,3 ,. ,3 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,2 ,3 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,25 ,7 ,6 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,6 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,44 ,5 ,3 ,. ,2 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,4 ,. ,6 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,25 ,4 ,3 ,. ,3 ,T ,90 ,18
  ,  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,10 ,5 ,. ,3 ,T ,90 ,9
  ,  ,  ,  ,  ,  ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,6 ,. ,6 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,18 ,8 ,5 ,. ,6 ,T ,90 ,18
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,15 ,6 ,5 ,. ,2 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,15 ,2 ,3 ,. ,3 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,6 ,. ,6 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,6 ,. ,5 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,  ,1 ,  ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,6 ,. ,4 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,. ,4 ,. ,5 ,T ,90 ,7
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,8 ,. ,8 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,3 ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,25 ,. ,4 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,0 ,1 ,1 ,1 ,0 ,0 ,. ,. ,5 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,3 ,5 ,. ,3 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,30 ,9 ,3 ,. ,6 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,23 ,9 ,3 ,. ,3 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,4 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,3 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,50 ,3 ,3 ,. ,3 ,T ,90 ,6
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,0 ,0 ,1 ,1 ,1 ,0 ,40 ,9 ,2 ,. ,3 ,T ,90 ,6
  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,3 ,. ,8 ,F ,90 ,18
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,5 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,4 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,4 ,4 ,. ,3 ,T ,90 ,9
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,6 ,. ,6 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,8 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,9 ,2 ,. ,3 ,T ,90 ,6
  ,  ,  ,  ,  ,  ,  ,3 ,2 ,0 ,0 ,1 ,1 ,1 ,0 ,20 ,1 ,6 ,. ,6 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,10 ,5 ,. ,8 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,5 ,3 ,. ,4 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,24 ,9 ,3 ,. ,3 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,4 ,. ,5 ,T ,90 ,7
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,6 ,5 ,. ,5 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,32 ,1 ,5 ,. ,5 ,T ,90 ,10
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,4 ,3 ,. ,2 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,10 ,1 ,3 ,. ,5 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,8 ,5 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,2 ,5 ,. ,6 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,  ,  ,2 ,0 ,0 ,0 ,1 ,0 ,0 ,40 ,6 ,3 ,. ,2 ,T ,90 ,0
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,8 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,8 ,3 ,. ,4 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,23 ,3 ,3 ,. ,5 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,3 ,. ,6 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,3 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,30 ,10 ,7 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,5 ,6 ,. ,7 ,F ,90 ,12
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,5 ,5 ,. ,5 ,T ,90 ,3
  ,  ,  ,  ,  ,  ,3 ,3 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,25 ,9 ,6 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,7 ,5 ,. ,5 ,T ,90 ,10
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,10 ,3 ,. ,6 ,T ,90 ,6
  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,1 ,5 ,. ,3 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,9 ,5 ,. ,8 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,9 ,7 ,4 ,. ,5 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,3 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,5 ,3 ,. ,1 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,. ,7 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,1 ,3 ,. ,2 ,F ,90 ,11
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,6 ,. ,8 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,3 ,3 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,18 ,1 ,6 ,. ,8 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,12 ,4 ,6 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,15 ,3 ,5 ,. ,6 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,10 ,3 ,. ,5 ,F ,90 ,12
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,10 ,1 ,6 ,. ,8 ,T ,90 ,11
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,2 ,. ,2 ,T ,90 ,3
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,9 ,7 ,. ,6 ,T ,90 ,17
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,3 ,. ,3 ,T ,90 ,3
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,. ,8 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,4 ,. ,8 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,38 ,3 ,7 ,. ,3 ,T ,90 ,8
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,5 ,. ,8 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,5 ,4 ,. ,3 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,1 ,6 ,. ,5 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,18 ,8 ,3 ,. ,3 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,6 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,33 ,2 ,5 ,. ,3 ,F ,90 ,7
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,32 ,4 ,1 ,. ,1 ,T ,90 ,9
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,30 ,7 ,6 ,. ,3 ,T ,90 ,9
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,35 ,6 ,3 ,. ,3 ,T ,90 ,9
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,50 ,9 ,5 ,. ,4 ,T ,90 ,8
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,. ,8 ,3 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,1 ,3 ,. ,3 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,3 ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,30 ,1 ,3 ,. ,4 ,T ,90 ,11
  ,  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,10 ,4 ,. ,3 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,24 ,10 ,5 ,. ,1 ,T ,90 ,5
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,20 ,4 ,2 ,. ,2 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,16 ,2 ,4 ,. ,3 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,6 ,. ,1 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,4 ,8 ,. ,6 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,2 ,5 ,. ,7 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,5 ,5 ,. ,5 ,F ,90 ,12
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,9 ,3 ,. ,5 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,9 ,6 ,. ,3 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,5 ,3 ,. ,3 ,T ,90 ,10
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,10 ,10 ,6 ,. ,6 ,T ,90 ,17
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,40 ,8 ,3 ,. ,3 ,T ,90 ,3
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,24 ,7 ,5 ,. ,6 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,. ,5 ,. ,3 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,34 ,2 ,5 ,. ,7 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,6 ,5 ,. ,8 ,T ,90 ,9
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,18 ,3 ,5 ,. ,5 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,7 ,3 ,. ,6 ,T ,90 ,3
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,2 ,5 ,. ,2 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,5 ,3 ,. ,2 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,. ,6 ,. ,8 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,2 ,5 ,. ,2 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,16 ,8 ,3 ,. ,4 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,1 ,8 ,. ,6 ,T ,90 ,18
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,1 ,1 ,. ,1 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,15 ,9 ,8 ,. ,8 ,F ,90 ,17
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,30 ,1 ,2 ,. ,2 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,6 ,. ,8 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,7 ,4 ,. ,. ,T ,90 ,11
  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,8 ,6 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,8 ,4 ,. ,6 ,T ,90 ,17
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,2 ,2 ,. ,5 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,10 ,10 ,5 ,. ,4 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,7 ,6 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,2 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,6 ,3 ,. ,5 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,0 ,0 ,1 ,1 ,1 ,0 ,20 ,1 ,5 ,. ,4 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,. ,6 ,T ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,3 ,. ,3 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,8 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,2 ,9 ,5 ,. ,8 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,8 ,. ,8 ,F ,90 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,6 ,. ,6 ,F ,90 ,16
  ,  ,  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,25 ,6 ,3 ,. ,3 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,  ,2 ,  ,1 ,0 ,1 ,1 ,0 ,0 ,. ,10 ,4 ,. ,4 ,F ,90 ,18
  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,5 ,3 ,. ,3 ,F ,90 ,14
  ,  ,  ,  ,  ,  ,3 ,2 ,  ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,3 ,. ,3 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,3 ,. ,3 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,1 ,3 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,25 ,7 ,3 ,. ,3 ,T ,90 ,14
  ,  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,. ,6 ,T ,90 ,13
  ,  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,. ,4 ,2 ,. ,2 ,T ,90 ,12
  ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,4 ,8 ,. ,5 ,F ,90 ,12
  ,  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,12 ,8 ,8 ,. ,8 ,F ,90 ,13
  ,  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,30 ,6 ,3 ,. ,5 ,T ,90 ,16
  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,7 ,4 ,. ,2 ,F ,90 ,16

/* db91.dat */

  ,  ,  ,  ,  ,5 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,6 ,4 ,8 ,F ,91 ,19
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,5 ,6 ,1 ,6 ,T ,91 ,7
  ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,. ,3 ,1 ,1 ,T ,91 ,3
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,40 ,4 ,6 ,1 ,6 ,T ,91 ,3
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,5 ,4 ,6 ,T ,91 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,3 ,1 ,6 ,T ,91 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,5 ,3 ,1 ,3 ,F ,91 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,6 ,. ,2 ,1 ,8 ,T ,91 ,13
  ,  ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,10 ,6 ,3 ,8 ,F ,91 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,40 ,10 ,5 ,1 ,8 ,T ,91 ,7
  ,  ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,6 ,2 ,5 ,5 ,2 ,F ,91 ,19
  ,  ,  ,  ,  ,5 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,8 ,7 ,8 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,4 ,6 ,4 ,3 ,F ,91 ,16
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,15 ,10 ,3 ,1 ,3 ,T ,91 ,14
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,8 ,8 ,5 ,8 ,F ,91 ,15
  ,  ,  ,  ,  ,5 ,3 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,6 ,3 ,5 ,F ,91 ,16
  ,  ,  ,  ,  ,1 ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,15 ,3 ,6 ,4 ,5 ,F ,91 ,14
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,8 ,2 ,6 ,F ,91 ,14
  ,  ,  ,  ,  ,3 ,  ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,. ,3 ,1 ,3 ,T ,91 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,4 ,6 ,4 ,. ,T ,91 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,25 ,9 ,3 ,1 ,5 ,T ,91 ,12
  ,  ,  ,  ,  ,2 ,  ,1 ,  ,1 ,1 ,1 ,0 ,1 ,0 ,. ,8 ,8 ,2 ,8 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,5 ,3 ,5 ,3 ,6 ,T ,91 ,18
  ,  ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,40 ,8 ,6 ,2 ,6 ,T ,91 ,8
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,9 ,3 ,1 ,6 ,T ,91 ,12
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,52 ,8 ,3 ,1 ,3 ,T ,91 ,11
  ,  ,  ,  ,  ,3 ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,7 ,4 ,8 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,2 ,7 ,1 ,4 ,F ,91 ,19
  ,  ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,6 ,3 ,3 ,1 ,T ,91 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,. ,. ,1 ,. ,F ,91 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,35 ,. ,6 ,1 ,6 ,T ,91 ,5
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,10 ,9 ,5 ,1 ,4 ,T ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,5 ,6 ,1 ,8 ,T ,91 ,12
  ,  ,  ,  ,  ,5 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,3 ,3 ,5 ,F ,91 ,15
  ,  ,  ,  ,  ,3 ,3 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,6 ,5 ,8 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,2 ,3 ,1 ,4 ,T ,91 ,4
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,. ,4 ,1 ,2 ,T ,91 ,6
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,25 ,10 ,5 ,1 ,8 ,T ,91 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,3 ,2 ,3 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,10 ,4 ,3 ,3 ,F ,91 ,14
  ,  ,  ,  ,  ,3 ,2 ,3 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,25 ,9 ,6 ,5 ,5 ,F ,91 ,14
  ,  ,  ,  ,  ,5 ,2 ,3 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,8 ,7 ,6 ,3 ,F ,91 ,18
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,. ,7 ,6 ,2 ,6 ,T ,91 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,9 ,6 ,5 ,6 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,6 ,1 ,6 ,T ,91 ,14
  ,  ,  ,  ,  ,5 ,  ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,3 ,0 ,2 ,F ,91 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,1 ,2 ,1 ,2 ,T ,91 ,13
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,10 ,5 ,1 ,5 ,T ,91 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,7 ,7 ,4 ,6 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,6 ,7 ,1 ,7 ,T ,91 ,15
  ,  ,  ,  ,  ,2 ,  ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,6 ,6 ,5 ,6 ,F ,91 ,18
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,4 ,2 ,0 ,2 ,T ,91 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,15 ,6 ,3 ,2 ,5 ,T ,91 ,12
  ,  ,  ,  ,  ,4 ,1 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,10 ,4 ,1 ,5 ,T ,91 ,13
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,8 ,6 ,3 ,8 ,T ,91 ,8
  ,  ,  ,  ,  ,4 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,2 ,6 ,4 ,3 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,35 ,6 ,3 ,3 ,2 ,T ,91 ,17
  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,5 ,3 ,8 ,T ,91 ,13
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,9 ,8 ,1 ,8 ,T ,91 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,35 ,5 ,3 ,2 ,6 ,T ,91 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,10 ,8 ,4 ,1 ,6 ,T ,91 ,13
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,5 ,2 ,3 ,F ,91 ,13
  ,  ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,1 ,3 ,4 ,3 ,T ,91 ,13
  ,  ,  ,  ,  ,4 ,2 ,1 ,  ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,8 ,4 ,8 ,F ,91 ,12
  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,8 ,1 ,8 ,F ,91 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,10 ,5 ,4 ,1 ,4 ,T ,91 ,12
  ,  ,  ,  ,  ,1 ,1 ,2 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,5 ,2 ,3 ,4 ,4 ,F ,91 ,17
  ,  ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,18 ,8 ,6 ,2 ,4 ,F ,91 ,16
  ,  ,  ,  ,  ,4 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,5 ,1 ,. ,F ,91 ,12
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,8 ,1 ,8 ,F ,91 ,15
  ,  ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,10 ,4 ,1 ,5 ,T ,91 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,8 ,8 ,1 ,6 ,T ,91 ,12
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,9 ,5 ,2 ,6 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,10 ,3 ,1 ,3 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,5 ,6 ,1 ,5 ,F ,91 ,17
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,7 ,3 ,4 ,6 ,F ,91 ,17
  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,7 ,3 ,1 ,3 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,3 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,18 ,7 ,4 ,3 ,3 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,2 ,2 ,2 ,3 ,T ,91 ,9
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,10 ,6 ,3 ,1 ,3 ,T ,91 ,13
  ,  ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,4 ,3 ,0 ,5 ,T ,91 ,16
  ,  ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,8 ,5 ,2 ,4 ,T ,91 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,. ,5 ,2 ,1 ,3 ,T ,91 ,12
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,30 ,8 ,3 ,4 ,4 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,3 ,4 ,3 ,F ,91 ,13
  ,  ,  ,  ,  ,3 ,  ,  ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,20 ,5 ,5 ,. ,6 ,F ,91 ,14
  ,  ,  ,  ,  ,5 ,  ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,8 ,3 ,4 ,2 ,F ,91 ,16
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,3 ,2 ,2 ,F ,91 ,12
  ,  ,  ,  ,  ,1 ,2 ,  ,1 ,0 ,0 ,0 ,1 ,1 ,0 ,. ,5 ,4 ,. ,5 ,F ,91 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,8 ,6 ,5 ,8 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,1 ,2 ,2 ,2 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,20 ,5 ,4 ,2 ,2 ,T ,91 ,15
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,8 ,4 ,1 ,4 ,T ,91 ,12
  ,  ,  ,  ,  ,4 ,  ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,4 ,3 ,1 ,3 ,T ,91 ,3
  ,  ,  ,  ,  ,1 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,3 ,1 ,5 ,T ,91 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,10 ,7 ,6 ,1 ,6 ,T ,91 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,30 ,10 ,5 ,1 ,5 ,T ,91 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,5 ,1 ,5 ,T ,91 ,14
  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,7 ,7 ,3 ,8 ,F ,91 ,16
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,10 ,6 ,1 ,8 ,F ,91 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,25 ,6 ,3 ,2 ,5 ,T ,91 ,12
  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,5 ,6 ,2 ,6 ,F ,91 ,16
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,25 ,9 ,6 ,4 ,5 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,8 ,8 ,4 ,5 ,F ,91 ,17
  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,3 ,1 ,4 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,2 ,2 ,3 ,T ,91 ,14
  ,  ,  ,  ,  ,1 ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,26 ,5 ,3 ,3 ,3 ,T ,91 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,3 ,1 ,3 ,T ,91 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,20 ,. ,4 ,1 ,5 ,T ,91 ,12
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,1 ,35 ,2 ,2 ,3 ,3 ,F ,91 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,12 ,7 ,4 ,2 ,4 ,F ,91 ,13
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,25 ,3 ,2 ,1 ,3 ,T ,91 ,15
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,9 ,3 ,2 ,8 ,F ,91 ,14
  ,  ,  ,  ,  ,2 ,3 ,3 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,9 ,5 ,3 ,3 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,8 ,3 ,1 ,3 ,F ,91 ,14
  ,  ,  ,  ,  ,2 ,1 ,3 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,24 ,5 ,5 ,5 ,6 ,F ,91 ,13
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,24 ,9 ,4 ,3 ,4 ,F ,91 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,10 ,2 ,3 ,2 ,2 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,7 ,6 ,2 ,5 ,F ,91 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,5 ,6 ,2 ,6 ,F ,91 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,10 ,10 ,6 ,5 ,8 ,T ,91 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,10 ,8 ,1 ,5 ,T ,91 ,14
  ,  ,  ,  ,  ,5 ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,10 ,6 ,2 ,3 ,F ,91 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,  ,1 ,0 ,0 ,1 ,0 ,0 ,. ,4 ,6 ,2 ,6 ,T ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,4 ,3 ,1 ,3 ,T ,91 ,6
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,6 ,3 ,2 ,3 ,T ,91 ,15
  ,  ,  ,  ,  ,5 ,  ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,10 ,5 ,6 ,1 ,3 ,T ,91 ,3
  ,  ,  ,  ,  ,3 ,3 ,3 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,4 ,5 ,5 ,7 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,3 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,10 ,8 ,6 ,4 ,2 ,F ,91 ,18
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,30 ,3 ,3 ,1 ,3 ,T ,91 ,14
  ,  ,  ,  ,  ,4 ,1 ,2 ,  ,1 ,1 ,1 ,0 ,1 ,0 ,. ,. ,6 ,5 ,6 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,40 ,9 ,6 ,2 ,6 ,T ,91 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,15 ,6 ,5 ,3 ,3 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,2 ,6 ,3 ,6 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,5 ,2 ,5 ,F ,91 ,15
  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,8 ,1 ,8 ,T ,91 ,14
  ,  ,  ,  ,  ,3 ,1 ,3 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,6 ,3 ,5 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,  ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,. ,5 ,3 ,3 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,4 ,5 ,3 ,3 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,30 ,3 ,3 ,1 ,3 ,F ,91 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,6 ,3 ,6 ,F ,91 ,18
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,8 ,5 ,8 ,F ,91 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,. ,2 ,1 ,4 ,T ,91 ,9
  ,  ,  ,  ,  ,2 ,1 ,3 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,24 ,5 ,5 ,8 ,6 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,8 ,8 ,2 ,8 ,F ,91 ,17
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,. ,2 ,5 ,3 ,1 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,35 ,6 ,5 ,1 ,1 ,T ,91 ,15
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,15 ,7 ,5 ,11 ,5 ,F ,91 ,14
  ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,13 ,7 ,3 ,1 ,4 ,F ,91 ,13
  ,  ,  ,  ,  ,5 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,6 ,4 ,8 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,5 ,5 ,3 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,2 ,1 ,3 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,1 ,3 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,7 ,3 ,1 ,3 ,T ,91 ,9
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,4 ,6 ,3 ,6 ,F ,91 ,15
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,20 ,8 ,4 ,1 ,5 ,F ,91 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,8 ,3 ,7 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,7 ,3 ,1 ,4 ,F ,91 ,13
  ,  ,  ,  ,  ,1 ,2 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,5 ,8 ,5 ,5 ,5 ,F ,91 ,14
  ,  ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,18 ,6 ,4 ,2 ,5 ,F ,91 ,13
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,5 ,1 ,6 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,10 ,2 ,6 ,1 ,6 ,F ,91 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,9 ,3 ,1 ,4 ,T ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,9 ,2 ,1 ,2 ,T ,91 ,10
  ,  ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,20 ,10 ,5 ,2 ,8 ,T ,91 ,14
  ,  ,  ,  ,  ,3 ,3 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,8 ,6 ,2 ,8 ,T ,91 ,4
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,10 ,4 ,1 ,4 ,T ,91 ,10
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,5 ,5 ,4 ,6 ,F ,91 ,17
  ,  ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,4 ,3 ,2 ,3 ,T ,91 ,12
  ,  ,  ,  ,  ,2 ,  ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,3 ,3 ,3 ,2 ,F ,91 ,13
  ,  ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,10 ,8 ,3 ,6 ,T ,91 ,14
  ,  ,  ,  ,  ,1 ,1 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,10 ,3 ,1 ,3 ,T ,91 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,. ,5 ,1 ,5 ,T ,91 ,7
  ,  ,  ,  ,  ,2 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,1 ,6 ,T ,91 ,15
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,30 ,8 ,5 ,1 ,4 ,T ,91 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,17 ,2 ,5 ,1 ,3 ,T ,91 ,13
  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,8 ,3 ,3 ,3 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,3 ,3 ,2 ,0 ,0 ,1 ,1 ,1 ,0 ,20 ,9 ,8 ,1 ,6 ,F ,91 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,5 ,3 ,4 ,2 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,1 ,20 ,3 ,5 ,1 ,6 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,3 ,3 ,4 ,F ,91 ,13
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,25 ,8 ,4 ,2 ,5 ,F ,91 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,7 ,5 ,4 ,3 ,F ,91 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,5 ,3 ,2 ,3 ,T ,91 ,16
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,7 ,6 ,3 ,3 ,F ,91 ,14
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,25 ,5 ,5 ,3 ,5 ,F ,91 ,17
  ,  ,  ,  ,  ,2 ,1 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,6 ,6 ,2 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,6 ,3 ,1 ,5 ,T ,91 ,15
  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,3 ,3 ,3 ,3 ,F ,91 ,14
  ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,. ,9 ,8 ,1 ,3 ,F ,91 ,8
  ,  ,  ,  ,  ,1 ,  ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,. ,3 ,1 ,3 ,F ,91 ,13
  ,  ,  ,  ,  ,2 ,3 ,3 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,8 ,8 ,5 ,3 ,5 ,F ,91 ,7
  ,  ,  ,  ,  ,3 ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,. ,8 ,3 ,3 ,6 ,F ,91 ,16
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,8 ,3 ,8 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,7 ,8 ,5 ,4 ,5 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,2 ,2 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,10 ,8 ,7 ,2 ,5 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,. ,1 ,1 ,1 ,1 ,T ,91 ,9
  ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,48 ,1 ,1 ,1 ,1 ,T ,91 ,3
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,3 ,1 ,5 ,T ,91 ,16
  ,  ,  ,  ,  ,4 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,8 ,4 ,5 ,3 ,F ,91 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,3 ,3 ,3 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,6 ,3 ,1 ,3 ,T ,91 ,12
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,8 ,3 ,3 ,4 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,1 ,3 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,5 ,4 ,8 ,F ,91 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,0 ,0 ,1 ,0 ,0 ,0 ,. ,. ,6 ,1 ,8 ,T ,91 ,16
  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,8 ,5 ,5 ,F ,91 ,16
  ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,2 ,5 ,2 ,3 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,10 ,8 ,3 ,8 ,T ,91 ,12
  ,  ,  ,  ,  ,1 ,1 ,3 ,2 ,0 ,0 ,0 ,1 ,1 ,0 ,10 ,10 ,6 ,3 ,3 ,F ,91 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,6 ,6 ,1 ,6 ,T ,91 ,15
  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,6 ,4 ,3 ,4 ,F ,91 ,17
  ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,3 ,5 ,3 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,2 ,4 ,1 ,3 ,T ,91 ,8
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,4 ,5 ,3 ,8 ,F ,91 ,11
  ,  ,  ,  ,  ,4 ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,6 ,3 ,8 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,5 ,5 ,2 ,3 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,3 ,2 ,3 ,T ,91 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,8 ,3 ,1 ,4 ,T ,91 ,14
  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,7 ,4 ,2 ,1 ,T ,91 ,10
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,8 ,3 ,7 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,17 ,5 ,3 ,3 ,2 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,30 ,9 ,3 ,1 ,6 ,T ,91 ,13
  ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,14 ,6 ,5 ,3 ,5 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,8 ,3 ,1 ,5 ,F ,91 ,15
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,1 ,15 ,9 ,8 ,1 ,3 ,F ,91 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,4 ,6 ,1 ,6 ,T ,91 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,5 ,5 ,2 ,3 ,T ,91 ,12
  ,  ,  ,  ,  ,3 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,8 ,3 ,2 ,2 ,F ,91 ,17
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,1 ,. ,3 ,4 ,3 ,5 ,F ,91 ,14
  ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,8 ,6 ,3 ,2 ,F ,91 ,12
  ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,8 ,6 ,1 ,3 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,9 ,8 ,5 ,3 ,3 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,1 ,15 ,9 ,5 ,1 ,3 ,F ,91 ,9
  ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,9 ,7 ,7 ,3 ,7 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,5 ,3 ,5 ,F ,91 ,17
  ,  ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,5 ,2 ,1 ,2 ,T ,91 ,6
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,6 ,3 ,4 ,3 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,  ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,. ,6 ,4 ,2 ,8 ,F ,91 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,4 ,3 ,6 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,18 ,9 ,8 ,1 ,8 ,T ,91 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,9 ,4 ,1 ,8 ,F ,91 ,5
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,10 ,5 ,5 ,8 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,  ,3 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,6 ,3 ,5 ,3 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,4 ,3 ,1 ,5 ,T ,91 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,3 ,3 ,5 ,F ,91 ,12
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,6 ,3 ,2 ,3 ,F ,91 ,13
  ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,35 ,9 ,3 ,1 ,3 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,4 ,3 ,1 ,3 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,6 ,3 ,2 ,4 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,3 ,3 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,12 ,1 ,6 ,4 ,6 ,F ,91 ,14
  ,  ,  ,  ,  ,3 ,3 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,25 ,7 ,3 ,6 ,3 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,40 ,3 ,3 ,1 ,3 ,T ,91 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,3 ,3 ,4 ,4 ,F ,91 ,17
  ,  ,  ,  ,  ,2 ,3 ,2 ,2 ,0 ,0 ,1 ,0 ,0 ,0 ,8 ,8 ,6 ,3 ,6 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,3 ,3 ,  ,1 ,0 ,1 ,1 ,1 ,1 ,. ,10 ,8 ,6 ,8 ,F ,91 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,8 ,3 ,2 ,6 ,F ,91 ,13
  ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,5 ,4 ,1 ,6 ,T ,91 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,12 ,3 ,2 ,1 ,5 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,2 ,3 ,5 ,3 ,F ,91 ,16
  ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,8 ,9 ,3 ,2 ,4 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,25 ,7 ,7 ,1 ,8 ,T ,91 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,5 ,5 ,2 ,4 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,40 ,8 ,3 ,1 ,2 ,F ,91 ,13
  ,  ,  ,  ,  ,2 ,1 ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,5 ,4 ,3 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,  ,0 ,0 ,1 ,0 ,1 ,0 ,. ,7 ,3 ,3 ,3 ,F ,91 ,17
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,5 ,5 ,1 ,3 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,2 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,4 ,3 ,3 ,3 ,F ,91 ,14
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,6 ,1 ,6 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,22 ,7 ,5 ,1 ,6 ,T ,91 ,10
  ,  ,  ,  ,  ,5 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,16 ,. ,3 ,1 ,3 ,T ,91 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,5 ,5 ,1 ,4 ,T ,91 ,16
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,8 ,1 ,8 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,6 ,8 ,3 ,5 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,5 ,4 ,3 ,F ,91 ,12
  ,  ,  ,  ,  ,1 ,  ,2 ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,25 ,4 ,3 ,2 ,2 ,T ,91 ,13
  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,4 ,5 ,3 ,5 ,F ,91 ,14
  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,6 ,4 ,6 ,F ,91 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,15 ,10 ,8 ,6 ,8 ,F ,91 ,16
  ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,3 ,6 ,1 ,5 ,F ,91 ,14
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,12 ,9 ,8 ,3 ,7 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,15 ,10 ,8 ,2 ,8 ,F ,91 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,  ,1 ,0 ,0 ,1 ,0 ,0 ,. ,5 ,3 ,1 ,1 ,T ,91 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,  ,1 ,0 ,0 ,1 ,0 ,0 ,. ,3 ,3 ,1 ,3 ,T ,91 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,8 ,1 ,3 ,1 ,F ,91 ,17
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,3 ,3 ,2 ,4 ,T ,91 ,3
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,3 ,6 ,1 ,5 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,13 ,3 ,4 ,3 ,6 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,32 ,1 ,2 ,2 ,3 ,T ,91 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,35 ,6 ,5 ,1 ,8 ,T ,91 ,14
  ,  ,  ,  ,  ,4 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,8 ,1 ,8 ,F ,91 ,18
  ,  ,  ,  ,  ,4 ,1 ,3 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,9 ,5 ,5 ,5 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,18 ,10 ,3 ,1 ,7 ,F ,91 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,8 ,2 ,8 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,25 ,7 ,4 ,1 ,6 ,T ,91 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,30 ,7 ,5 ,1 ,5 ,T ,91 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,15 ,5 ,5 ,1 ,5 ,T ,91 ,12
  ,  ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,7 ,7 ,7 ,2 ,5 ,F ,91 ,15
  ,  ,  ,  ,  ,3 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,. ,6 ,6 ,2 ,6 ,F ,91 ,18
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,8 ,6 ,1 ,6 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,3 ,2 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,17 ,4 ,3 ,4 ,3 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,15 ,. ,5 ,1 ,5 ,T ,91 ,15
  ,  ,  ,  ,  ,2 ,3 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,30 ,5 ,5 ,5 ,5 ,F ,91 ,17
  ,  ,  ,  ,  ,1 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,1 ,3 ,2 ,3 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,15 ,6 ,4 ,2 ,8 ,F ,91 ,14
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,9 ,6 ,3 ,6 ,T ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,20 ,7 ,3 ,3 ,4 ,T ,91 ,13
  ,  ,  ,  ,  ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,8 ,2 ,8 ,F ,91 ,14
  ,  ,  ,  ,  ,4 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,. ,5 ,3 ,6 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,23 ,7 ,5 ,3 ,6 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,5 ,3 ,3 ,3 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,9 ,6 ,2 ,8 ,T ,91 ,13
  ,  ,  ,  ,  ,2 ,  ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,8 ,2 ,5 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,7 ,3 ,3 ,3 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,25 ,9 ,8 ,2 ,8 ,F ,91 ,14
  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,4 ,2 ,5 ,F ,91 ,16
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,3 ,5 ,1 ,2 ,T ,91 ,13
  ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,4 ,3 ,1 ,8 ,T ,91 ,8
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,. ,5 ,4 ,5 ,T ,91 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,. ,6 ,1 ,5 ,T ,91 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,  ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,6 ,1 ,6 ,F ,91 ,13
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,4 ,6 ,2 ,6 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,. ,3 ,1 ,1 ,T ,91 ,3
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,7 ,6 ,1 ,5 ,T ,91 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,16 ,7 ,5 ,1 ,5 ,T ,91 ,14
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,15 ,9 ,3 ,1 ,3 ,T ,91 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,0 ,0 ,0 ,0 ,1 ,0 ,20 ,. ,5 ,1 ,6 ,T ,91 ,14
  ,  ,  ,  ,  ,4 ,2 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,9 ,5 ,5 ,3 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,1 ,3 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,12 ,2 ,3 ,3 ,1 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,5 ,7 ,4 ,2 ,2 ,F ,91 ,12
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,11 ,10 ,4 ,3 ,8 ,F ,91 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,7 ,3 ,3 ,5 ,T ,91 ,13
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,18 ,7 ,3 ,1 ,6 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,6 ,4 ,2 ,4 ,F ,91 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,3 ,3 ,3 ,2 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,3 ,2 ,3 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,2 ,3 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,5 ,10 ,5 ,3 ,3 ,F ,91 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,8 ,5 ,4 ,5 ,T ,91 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,  ,1 ,0 ,0 ,0 ,0 ,0 ,. ,5 ,3 ,1 ,3 ,T ,91 ,12
  ,  ,  ,  ,  ,3 ,  ,3 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,12 ,10 ,8 ,4 ,6 ,F ,91 ,10
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,3 ,4 ,2 ,2 ,T ,91 ,14
  ,  ,  ,  ,  ,3 ,3 ,2 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,6 ,9 ,6 ,4 ,6 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,2 ,3 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,. ,5 ,3 ,5 ,F ,91 ,13
  ,  ,  ,  ,  ,3 ,  ,3 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,8 ,3 ,3 ,3 ,F ,91 ,13
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,5 ,4 ,4 ,4 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,2 ,2 ,2 ,0 ,0 ,1 ,1 ,0 ,0 ,20 ,1 ,3 ,2 ,2 ,T ,91 ,18
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,. ,8 ,1 ,8 ,T ,91 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,5 ,1 ,5 ,T ,91 ,13
  ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,7 ,6 ,2 ,6 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,15 ,5 ,3 ,3 ,3 ,F ,91 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,40 ,9 ,5 ,1 ,5 ,T ,91 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,7 ,6 ,1 ,6 ,T ,91 ,14
  ,  ,  ,  ,  ,4 ,2 ,2 ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,20 ,. ,5 ,0 ,7 ,F ,91 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,0 ,0 ,0 ,1 ,0 ,0 ,60 ,9 ,5 ,0 ,8 ,T ,91 ,3
  ,  ,  ,  ,  ,  ,  ,3 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,4 ,6 ,4 ,F ,91 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,8 ,. ,4 ,1 ,6 ,T ,91 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,1 ,8 ,T ,91 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,3 ,5 ,1 ,5 ,F ,91 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,5 ,3 ,1 ,1 ,T ,91 ,7
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,10 ,9 ,6 ,1 ,6 ,F ,91 ,13
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,18 ,8 ,3 ,1 ,4 ,T ,91 ,14
  ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,9 ,8 ,4 ,8 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,3 ,4 ,4 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,5 ,4 ,2 ,5 ,T ,91 ,14
  ,  ,  ,  ,  ,1 ,1 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,9 ,5 ,2 ,6 ,F ,91 ,12
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,5 ,3 ,6 ,F ,91 ,15
  ,  ,  ,  ,  ,3 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,3 ,2 ,3 ,1 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,5 ,2 ,3 ,F ,91 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,2 ,2 ,1 ,2 ,T ,91 ,17
  ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,7 ,6 ,1 ,8 ,T ,91 ,7
  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,5 ,1 ,6 ,T ,91 ,17
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,6 ,3 ,3 ,4 ,F ,91 ,16
  ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,5 ,3 ,3 ,3 ,F ,91 ,14
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,10 ,5 ,3 ,1 ,6 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,8 ,3 ,6 ,5 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,1 ,3 ,2 ,1 ,T ,91 ,15
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,25 ,3 ,1 ,1 ,1 ,F ,91 ,15
  ,  ,  ,  ,  ,3 ,  ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,3 ,4 ,2 ,5 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,8 ,5 ,1 ,5 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,2 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,15 ,2 ,3 ,1 ,2 ,T ,91 ,13
  ,  ,  ,  ,  ,1 ,1 ,2 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,16 ,2 ,6 ,1 ,5 ,T ,91 ,2
  ,  ,  ,  ,  ,1 ,1 ,1 ,  ,1 ,1 ,0 ,0 ,1 ,0 ,. ,1 ,6 ,1 ,3 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,6 ,6 ,1 ,5 ,T ,91 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,10 ,7 ,4 ,3 ,4 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,. ,3 ,3 ,2 ,F ,91 ,14
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,0 ,0 ,0 ,1 ,1 ,0 ,40 ,. ,3 ,1 ,6 ,T ,91 ,3
  ,  ,  ,  ,  ,1 ,3 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,5 ,4 ,3 ,1 ,F ,91 ,17
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,4 ,1 ,3 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,5 ,4 ,3 ,F ,91 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,9 ,8 ,3 ,8 ,F ,91 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,10 ,5 ,10 ,8 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,4 ,3 ,1 ,3 ,T ,91 ,15
  ,  ,  ,  ,  ,1 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,10 ,5 ,2 ,7 ,F ,91 ,15
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,15 ,5 ,4 ,2 ,4 ,T ,91 ,3
  ,  ,  ,  ,  ,2 ,2 ,2 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,20 ,10 ,8 ,7 ,8 ,F ,91 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,4 ,6 ,1 ,6 ,F ,91 ,6
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,8 ,3 ,8 ,F ,91 ,16
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,0 ,1 ,1 ,0 ,1 ,0 ,16 ,2 ,3 ,1 ,5 ,T ,91 ,16
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,14 ,6 ,2 ,2 ,3 ,T ,91 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,5 ,3 ,3 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,5 ,3 ,2 ,4 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,. ,5 ,1 ,7 ,T ,91 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,8 ,6 ,1 ,6 ,T ,91 ,12
  ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,7 ,6 ,1 ,6 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,5 ,2 ,6 ,F ,91 ,10
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,25 ,3 ,3 ,1 ,2 ,T ,91 ,12
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,56 ,6 ,3 ,1 ,3 ,F ,91 ,6
  ,  ,  ,  ,  ,4 ,1 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,5 ,6 ,4 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,3 ,3 ,1 ,5 ,F ,91 ,6
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,7 ,4 ,2 ,4 ,F ,91 ,16
  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,. ,3 ,1 ,2 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,2 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,4 ,3 ,4 ,3 ,F ,91 ,17
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,4 ,1 ,8 ,T ,91 ,13
  ,  ,  ,  ,  ,3 ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,20 ,6 ,. ,0 ,6 ,T ,91 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,10 ,6 ,4 ,3 ,3 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,9 ,4 ,1 ,5 ,T ,91 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,15 ,5 ,3 ,1 ,3 ,T ,91 ,18
  ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,15 ,6 ,6 ,3 ,8 ,F ,91 ,17
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,40 ,9 ,4 ,2 ,4 ,T ,91 ,14
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,5 ,3 ,1 ,3 ,F ,91 ,17
  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,. ,3 ,1 ,5 ,T ,91 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,8 ,5 ,1 ,8 ,T ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,2 ,4 ,3 ,7 ,T ,91 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,. ,3 ,1 ,3 ,F ,91 ,14
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,30 ,4 ,3 ,1 ,2 ,F ,91 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,10 ,7 ,5 ,1 ,5 ,F ,91 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,20 ,8 ,3 ,1 ,3 ,F ,91 ,15
  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,2 ,3 ,7 ,4 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,3 ,4 ,0 ,2 ,T ,91 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,15 ,6 ,3 ,1 ,6 ,T ,91 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,5 ,1 ,7 ,T ,91 ,14
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,20 ,4 ,3 ,2 ,6 ,T ,91 ,12
  ,  ,  ,  ,  ,4 ,3 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,6 ,6 ,3 ,7 ,F ,91 ,16
  ,  ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,5 ,1 ,7 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,14 ,7 ,4 ,3 ,8 ,F ,91 ,16
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,8 ,5 ,6 ,2 ,4 ,F ,91 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,3 ,1 ,4 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,4 ,5 ,1 ,1 ,T ,91 ,14
  ,  ,  ,  ,  ,5 ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,8 ,1 ,6 ,T ,91 ,15
  ,  ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,15 ,10 ,6 ,2 ,8 ,T ,91 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,5 ,3 ,2 ,8 ,T ,91 ,12
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,9 ,8 ,2 ,8 ,F ,91 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,8 ,5 ,6 ,T ,91 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,3 ,5 ,1 ,5 ,T ,91 ,15
  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,7 ,8 ,2 ,6 ,F ,91 ,15
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,26 ,4 ,3 ,1 ,5 ,T ,91 ,4
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,. ,3 ,1 ,3 ,T ,91 ,3
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,9 ,8 ,1 ,5 ,T ,91 ,15
  ,  ,  ,  ,  ,1 ,  ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,35 ,. ,8 ,2 ,2 ,F ,91 ,13
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,15 ,8 ,6 ,4 ,8 ,F ,91 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,10 ,8 ,3 ,3 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,7 ,3 ,2 ,5 ,F ,91 ,17
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,10 ,7 ,4 ,1 ,3 ,T ,91 ,10
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,30 ,9 ,5 ,1 ,3 ,T ,91 ,13
  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,7 ,2 ,8 ,F ,91 ,13
  ,  ,  ,  ,  ,2 ,  ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,3 ,5 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,10 ,8 ,8 ,3 ,6 ,F ,91 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,15 ,10 ,3 ,4 ,4 ,T ,91 ,12
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,25 ,8 ,6 ,2 ,3 ,T ,91 ,12
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,4 ,1 ,4 ,T ,91 ,0
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,6 ,1 ,6 ,T ,91 ,13
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,60 ,. ,3 ,0 ,2 ,T ,91 ,7
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,10 ,3 ,8 ,1 ,6 ,T ,91 ,3
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,. ,3 ,1 ,4 ,T ,91 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,7 ,5 ,4 ,6 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,8 ,7 ,1 ,7 ,T ,91 ,12
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,5 ,1 ,5 ,F ,91 ,15
  ,  ,  ,  ,  ,5 ,2 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,2 ,4 ,3 ,8 ,F ,91 ,12
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,10 ,8 ,0 ,8 ,T ,91 ,16
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,8 ,5 ,1 ,5 ,T ,91 ,18
  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,7 ,5 ,7 ,F ,91 ,16
  ,  ,  ,  ,  ,4 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,8 ,1 ,8 ,T ,91 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,5 ,4 ,1 ,4 ,T ,91 ,11
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,10 ,3 ,6 ,9 ,8 ,F ,91 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,8 ,1 ,1 ,1 ,T ,91 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,7 ,3 ,1 ,3 ,F ,91 ,18
  ,  ,  ,  ,  ,1 ,1 ,3 ,  ,1 ,1 ,1 ,0 ,1 ,0 ,. ,. ,. ,3 ,. ,F ,91 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,10 ,8 ,1 ,6 ,T ,91 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,8 ,3 ,1 ,3 ,F ,91 ,14
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,0 ,0 ,0 ,0 ,0 ,1 ,. ,10 ,6 ,1 ,6 ,T ,91 ,10
  ,  ,  ,  ,  ,3 ,3 ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,10 ,. ,5 ,2 ,8 ,F ,91 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,. ,. ,6 ,1 ,4 ,T ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,7 ,3 ,4 ,4 ,F ,91 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,6 ,10 ,5 ,2 ,8 ,F ,91 ,17
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,9 ,3 ,0 ,3 ,T ,91 ,3
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,. ,8 ,1 ,8 ,F ,91 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,1 ,8 ,T ,91 ,18
  ,  ,  ,  ,  ,4 ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,4 ,3 ,1 ,5 ,F ,91 ,14
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,8 ,1 ,8 ,F ,91 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,0 ,0 ,1 ,0 ,0 ,0 ,45 ,4 ,6 ,1 ,2 ,T ,91 ,3
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,10 ,1 ,6 ,1 ,2 ,T ,91 ,14
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,6 ,4 ,8 ,T ,91 ,14
  ,  ,  ,  ,  ,1 ,3 ,2 ,2 ,0 ,1 ,1 ,0 ,1 ,0 ,15 ,4 ,3 ,1 ,3 ,T ,91 ,13
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,6 ,5 ,1 ,5 ,F ,91 ,17
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,4 ,5 ,2 ,. ,F ,91 ,21
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,1 ,2 ,3 ,3 ,F ,91 ,15
  ,  ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,25 ,. ,6 ,2 ,6 ,T ,91 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,35 ,10 ,5 ,1 ,5 ,T ,91 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,. ,2 ,1 ,2 ,T ,91 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,25 ,10 ,5 ,3 ,5 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,3 ,5 ,1 ,4 ,T ,91 ,4
  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,6 ,5 ,8 ,F ,91 ,17
  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,6 ,5 ,2 ,7 ,F ,91 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,8 ,4 ,1 ,5 ,T ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,30 ,7 ,5 ,1 ,4 ,T ,91 ,12
  ,  ,  ,  ,  ,5 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,7 ,5 ,5 ,7 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,8 ,5 ,3 ,6 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,10 ,8 ,2 ,8 ,T ,91 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,10 ,2 ,3 ,6 ,5 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,3 ,5 ,3 ,3 ,F ,91 ,14
  ,  ,  ,  ,  ,2 ,3 ,2 ,  ,1 ,0 ,1 ,0 ,1 ,0 ,. ,. ,. ,7 ,. ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,3 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,5 ,3 ,4 ,F ,91 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,. ,6 ,1 ,6 ,T ,91 ,11
  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,4 ,3 ,5 ,3 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,5 ,2 ,5 ,F ,91 ,14
  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,7 ,3 ,1 ,3 ,T ,91 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,. ,1 ,0 ,1 ,T ,91 ,6
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,7 ,8 ,2 ,6 ,F ,91 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,0 ,0 ,1 ,0 ,1 ,0 ,25 ,4 ,5 ,2 ,5 ,T ,91 ,17
  ,  ,  ,  ,  ,1 ,3 ,2 ,2 ,0 ,1 ,1 ,1 ,1 ,0 ,. ,2 ,7 ,3 ,8 ,F ,91 ,15
  ,  ,  ,  ,  ,5 ,3 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,8 ,5 ,1 ,4 ,F ,91 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,6 ,5 ,1 ,8 ,T ,91 ,12
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,10 ,5 ,1 ,6 ,T ,91 ,12
  ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,3 ,3 ,1 ,3 ,T ,91 ,3
  ,  ,  ,  ,  ,2 ,2 ,3 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,12 ,5 ,8 ,5 ,8 ,F ,91 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,25 ,10 ,3 ,1 ,6 ,T ,91 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,4 ,4 ,1 ,3 ,T ,91 ,3
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,3 ,5 ,2 ,5 ,T ,91 ,13
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,9 ,5 ,1 ,6 ,T ,91 ,20
  ,  ,  ,  ,  ,5 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,1 ,32 ,6 ,2 ,1 ,5 ,T ,91 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,1 ,10 ,5 ,1 ,3 ,T ,91 ,12
  ,  ,  ,  ,  ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,7 ,2 ,8 ,F ,91 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,. ,5 ,1 ,6 ,T ,91 ,11
  ,  ,  ,  ,  ,4 ,  ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,15 ,10 ,8 ,1 ,8 ,F ,91 ,14
  ,  ,  ,  ,  ,4 ,3 ,  ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,10 ,6 ,. ,8 ,T ,91 ,13
  ,  ,  ,  ,  ,4 ,3 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,8 ,. ,8 ,T ,91 ,15
  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,8 ,3 ,8 ,F ,91 ,15
  ,  ,  ,  ,  ,5 ,  ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,15 ,6 ,6 ,1 ,5 ,T ,91 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,20 ,2 ,3 ,3 ,1 ,F ,91 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,10 ,6 ,1 ,8 ,T ,91 ,6
  ,  ,  ,  ,  ,2 ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,10 ,5 ,3 ,6 ,F ,91 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,35 ,6 ,3 ,0 ,5 ,T ,91 ,4
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,4 ,3 ,1 ,3 ,T ,91 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,65 ,4 ,3 ,2 ,3 ,T ,91 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,10 ,3 ,2 ,4 ,F ,91 ,13
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,6 ,1 ,6 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,20 ,5 ,6 ,1 ,8 ,T ,91 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,30 ,6 ,3 ,1 ,8 ,T ,91 ,11
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,4 ,5 ,1 ,6 ,F ,91 ,14
  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,8 ,1 ,8 ,T ,91 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,45 ,4 ,7 ,1 ,8 ,T ,91 ,3
  ,  ,  ,  ,  ,3 ,1 ,1 ,  ,0 ,1 ,1 ,0 ,0 ,0 ,. ,7 ,4 ,1 ,. ,T ,91 ,18
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,2 ,1 ,3 ,T ,91 ,10
  ,  ,  ,  ,  ,3 ,1 ,  ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,40 ,10 ,6 ,1 ,6 ,T ,91 ,8
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,25 ,10 ,6 ,3 ,6 ,F ,91 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,3 ,6 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,8 ,3 ,2 ,3 ,T ,91 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,. ,. ,1 ,. ,T ,91 ,14
  ,  ,  ,  ,  ,3 ,3 ,3 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,3 ,3 ,3 ,3 ,F ,91 ,15
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,16 ,6 ,8 ,1 ,6 ,F ,91 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,18 ,. ,. ,2 ,. ,T ,91 ,16
  ,  ,  ,  ,  ,5 ,1 ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,5 ,. ,5 ,5 ,6 ,F ,91 ,12
  ,  ,  ,  ,  ,5 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,5 ,4 ,3 ,7 ,T ,91 ,8
  ,  ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,22 ,. ,3 ,3 ,6 ,T ,91 ,7
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,9 ,6 ,3 ,8 ,F ,91 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,30 ,7 ,7 ,1 ,7 ,T ,91 ,16
  ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,4 ,5 ,1 ,8 ,T ,91 ,14
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,6 ,1 ,5 ,F ,91 ,16
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,30 ,. ,5 ,1 ,5 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,5 ,2 ,3 ,2 ,F ,91 ,17
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,1 ,2 ,1 ,4 ,F ,91 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,12 ,4 ,5 ,1 ,6 ,T ,91 ,16
  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,4 ,2 ,4 ,F ,91 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,25 ,6 ,5 ,1 ,4 ,T ,91 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,8 ,5 ,5 ,3 ,5 ,F ,91 ,15
  ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,6 ,8 ,6 ,F ,91 ,18
  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,1 ,. ,2 ,8 ,F ,91 ,16


/* db92.dat */

  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,22 ,9 ,4 ,1 ,8 ,F ,92 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,14 ,3 ,3 ,1 ,3 ,F ,92 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,10 ,8 ,6 ,1 ,5 ,T ,92 ,7
002077 ,002974 ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,12 ,8 ,8 ,3 ,8 ,F ,92 ,16
004033 ,  ,  ,  ,  ,4 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,9 ,6 ,2 ,3 ,T ,92 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,18 ,8 ,3 ,1 ,3 ,T ,92 ,16
001489 ,002516 ,002221 ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,8 ,. ,3 ,6 ,T ,92 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,8 ,5 ,1 ,6 ,T ,92 ,15
002981 ,002944 ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,3 ,3 ,3 ,4 ,T ,92 ,18
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,5 ,3 ,1 ,5 ,T ,92 ,6
001572 ,002632 ,  ,  ,  ,5 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,6 ,3 ,3 ,3 ,T ,92 ,16
001397 ,003895 ,002926 ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,11 ,2 ,3 ,4 ,3 ,T ,92 ,17
002976 ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,6 ,5 ,2 ,5 ,T ,92 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,25 ,6 ,3 ,1 ,3 ,T ,92 ,6
002161 ,003509 ,002785 ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,6 ,6 ,4 ,8 ,F ,92 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,7 ,4 ,1 ,6 ,T ,92 ,16
  ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,. ,4 ,1 ,8 ,T ,92 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,2 ,8 ,1 ,1 ,F ,92 ,14
002850 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,10 ,5 ,3 ,2 ,6 ,T ,92 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,10 ,3 ,1 ,6 ,T ,92 ,18
002974 ,001321 ,001264 ,006951 ,002906 ,5 ,3 ,3 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,9 ,8 ,6 ,4 ,F ,92 ,15
  ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,15 ,2 ,5 ,1 ,6 ,T ,92 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,8 ,3 ,1 ,3 ,T ,92 ,20
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,3 ,3 ,1 ,1 ,T ,92 ,10
002844 ,002850 ,001422 ,001397 ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,9 ,7 ,5 ,3 ,F ,92 ,15
003487 ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,1 ,1 ,. ,8 ,7 ,2 ,8 ,T ,92 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,6 ,3 ,1 ,3 ,T ,92 ,14
002906 ,002972 ,002975 ,002981 ,002974 ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,16 ,8 ,5 ,6 ,5 ,F ,92 ,16
002981 ,002906 ,002984 ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,20 ,8 ,3 ,4 ,3 ,T ,92 ,6
  ,  ,  ,  ,  ,4 ,1 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,1 ,8 ,T ,92 ,13
002911 ,002905 ,002986 ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,8 ,6 ,4 ,8 ,T ,92 ,15
002906 ,002984 ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,5 ,3 ,3 ,3 ,F ,92 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,38 ,10 ,3 ,1 ,8 ,T ,92 ,4
  ,  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,. ,6 ,1 ,6 ,F ,92 ,14
003371 ,002927 ,003404 ,002788 ,002976 ,2 ,3 ,3 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,25 ,5 ,2 ,6 ,3 ,F ,92 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,12 ,10 ,8 ,1 ,8 ,T ,92 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,. ,. ,3 ,1 ,3 ,T ,92 ,7
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,5 ,3 ,1 ,3 ,T ,92 ,4
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,8 ,5 ,1 ,8 ,T ,92 ,14
002978 ,002974 ,999996 ,  ,  ,2 ,1 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,9 ,3 ,4 ,4 ,T ,92 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,6 ,1 ,8 ,T ,92 ,14
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,25 ,10 ,3 ,1 ,6 ,T ,92 ,13
001081 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,8 ,2 ,3 ,F ,92 ,16
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,25 ,10 ,5 ,1 ,6 ,T ,92 ,10
002984 ,002976 ,002906 ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,3 ,4 ,5 ,F ,92 ,16
002974 ,002976 ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,25 ,10 ,5 ,3 ,8 ,F ,92 ,15
002105 ,009345 ,001536 ,002984 ,003711 ,3 ,1 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,7 ,4 ,6 ,4 ,T ,92 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,20 ,2 ,6 ,1 ,6 ,T ,92 ,15
  ,  ,  ,  ,  ,4 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,4 ,1 ,6 ,F ,92 ,16
  ,  ,  ,  ,  ,3 ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,6 ,1 ,8 ,T ,92 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,0 ,. ,10 ,6 ,1 ,6 ,T ,92 ,19
002933 ,002906 ,002984 ,002978 ,  ,2 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,10 ,3 ,4 ,4 ,F ,92 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,4 ,3 ,1 ,8 ,T ,92 ,16
002984 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,10 ,3 ,2 ,8 ,F ,92 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,10 ,4 ,1 ,6 ,T ,92 ,4
002975 ,002984 ,999996 ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,4 ,6 ,T ,92 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,. ,5 ,1 ,1 ,T ,92 ,15
002905 ,  ,  ,  ,  ,3 ,3 ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,25 ,3 ,3 ,2 ,2 ,T ,92 ,6
003326 ,003721 ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,6 ,3 ,6 ,F ,92 ,16
003955 ,  ,  ,  ,  ,2 ,3 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,4 ,2 ,8 ,T ,92 ,17
003269 ,001987 ,003327 ,003721 ,003323 ,2 ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,5 ,8 ,F ,92 ,15
003401 ,002516 ,002105 ,  ,  ,4 ,1 ,2 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,12 ,5 ,7 ,4 ,8 ,T ,92 ,19
001082 ,  ,  ,  ,  ,2 ,3 ,2 ,1 ,1 ,0 ,1 ,1 ,1 ,1 ,. ,. ,8 ,2 ,8 ,T ,92 ,12
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,3 ,4 ,1 ,. ,T ,92 ,14
002984 ,006965 ,010313 ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,10 ,5 ,5 ,4 ,8 ,F ,92 ,16
  ,  ,  ,  ,  ,1 ,1 ,  ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,24 ,. ,2 ,. ,5 ,T ,92 ,10
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,6 ,6 ,1 ,6 ,F ,92 ,14
  ,  ,  ,  ,  ,5 ,2 ,1 ,  ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,5 ,1 ,8 ,F ,92 ,15
002981 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,15 ,7 ,3 ,2 ,2 ,T ,92 ,7
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,1 ,6 ,1 ,6 ,F ,92 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,1 ,5 ,1 ,8 ,T ,92 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,3 ,1 ,5 ,T ,92 ,15
002972 ,001569 ,  ,  ,  ,2 ,2 ,3 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,15 ,6 ,6 ,3 ,7 ,F ,92 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,9 ,5 ,1 ,6 ,T ,92 ,8
001431 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,6 ,3 ,2 ,6 ,T ,92 ,18
001431 ,003529 ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,10 ,7 ,3 ,3 ,3 ,T ,92 ,16
002906 ,002981 ,  ,  ,  ,4 ,1 ,1 ,2 ,0 ,0 ,1 ,1 ,1 ,0 ,10 ,10 ,5 ,3 ,5 ,F ,92 ,15
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,7 ,6 ,1 ,8 ,T ,92 ,16
002972 ,002974 ,002984 ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,27 ,. ,3 ,4 ,4 ,T ,92 ,15
  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,. ,1 ,1 ,1 ,T ,92 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,30 ,10 ,6 ,1 ,8 ,T ,92 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,5 ,3 ,1 ,3 ,T ,92 ,14
002974 ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,2 ,8 ,F ,92 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,40 ,. ,5 ,1 ,1 ,T ,92 ,6
002981 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,30 ,2 ,5 ,2 ,5 ,T ,92 ,15
003721 ,003744 ,003658 ,003732 ,002845 ,3 ,3 ,2 ,2 ,1 ,0 ,1 ,0 ,1 ,1 ,. ,10 ,6 ,6 ,6 ,F ,92 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,5 ,1 ,3 ,F ,92 ,16
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,15 ,10 ,8 ,1 ,8 ,T ,92 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,10 ,. ,6 ,1 ,8 ,T ,92 ,15
  ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,10 ,7 ,1 ,6 ,F ,92 ,17
002976 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,4 ,6 ,2 ,6 ,F ,92 ,14
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,17 ,9 ,8 ,1 ,8 ,T ,92 ,16
029258 ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,7 ,2 ,8 ,T ,92 ,12
002975 ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,9 ,3 ,2 ,2 ,F ,92 ,13
002972 ,002974 ,002906 ,003457 ,  ,2 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,5 ,5 ,6 ,F ,92 ,16
  ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,15 ,2 ,5 ,1 ,8 ,T ,92 ,7
003487 ,  ,  ,  ,  ,4 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,24 ,3 ,5 ,2 ,8 ,F ,92 ,16
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,23 ,9 ,2 ,1 ,2 ,F ,92 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,7 ,3 ,1 ,2 ,T ,92 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,33 ,1 ,3 ,1 ,6 ,T ,92 ,8
002981 ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,10 ,8 ,2 ,8 ,F ,92 ,14
002974 ,002906 ,002972 ,002927 ,002984 ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,10 ,8 ,6 ,8 ,F ,92 ,14
002974 ,002913 ,002906 ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,6 ,4 ,4 ,F ,92 ,15
002972 ,002927 ,002975 ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,10 ,6 ,4 ,6 ,F ,92 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,2 ,8 ,1 ,3 ,T ,92 ,6
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,15 ,5 ,3 ,1 ,6 ,F ,92 ,16
  ,  ,  ,  ,  ,5 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,1 ,. ,9 ,6 ,1 ,5 ,T ,92 ,14
002972 ,002913 ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,6 ,3 ,6 ,F ,92 ,17
  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,. ,10 ,4 ,1 ,4 ,T ,92 ,13
002968 ,002953 ,002913 ,  ,  ,2 ,  ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,23 ,4 ,5 ,4 ,4 ,T ,92 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,3 ,4 ,1 ,3 ,T ,92 ,12
002933 ,002951 ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,8 ,8 ,3 ,8 ,T ,92 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,36 ,4 ,2 ,1 ,2 ,T ,92 ,8
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,40 ,1 ,1 ,1 ,1 ,T ,92 ,12
002975 ,002976 ,002923 ,002913 ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,6 ,5 ,5 ,5 ,F ,92 ,13
002975 ,002972 ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,24 ,7 ,8 ,2 ,8 ,F ,92 ,13
002906 ,002975 ,002981 ,003425 ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,27 ,7 ,6 ,5 ,5 ,T ,92 ,20
002974 ,002976 ,002972 ,002906 ,  ,3 ,1 ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,10 ,8 ,4 ,5 ,6 ,F ,92 ,13
002974 ,  ,  ,  ,  ,3 ,3 ,3 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,30 ,9 ,4 ,2 ,6 ,T ,92 ,15
002927 ,001569 ,002972 ,003447 ,  ,2 ,2 ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,15 ,6 ,3 ,5 ,3 ,F ,92 ,15
002976 ,002972 ,002906 ,  ,  ,1 ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,6 ,4 ,6 ,F ,92 ,14
002906 ,002981 ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,6 ,4 ,2 ,2 ,F ,92 ,15
002929 ,002972 ,002975 ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,5 ,7 ,6 ,4 ,6 ,F ,92 ,16
002974 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,. ,5 ,2 ,5 ,F ,92 ,18
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,15 ,. ,5 ,1 ,8 ,F ,92 ,15
  ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,2 ,4 ,1 ,4 ,F ,92 ,16
002981 ,002906 ,002976 ,002984 ,002923 ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,5 ,6 ,8 ,F ,92 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,3 ,1 ,3 ,T ,92 ,15
003536 ,004608 ,003441 ,  ,  ,2 ,2 ,3 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,4 ,3 ,4 ,2 ,F ,92 ,16
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,7 ,5 ,1 ,3 ,F ,92 ,15
002984 ,002981 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,7 ,5 ,3 ,6 ,F ,92 ,15
002918 ,002981 ,  ,  ,  ,2 ,  ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,6 ,3 ,6 ,F ,92 ,13
002976 ,002906 ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,5 ,3 ,6 ,F ,92 ,14
002906 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,7 ,3 ,2 ,5 ,F ,92 ,16
002923 ,002981 ,002944 ,003425 ,002974 ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,7 ,3 ,6 ,3 ,F ,92 ,15
  ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,7 ,2 ,1 ,5 ,F ,92 ,16
002923 ,002981 ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,32 ,9 ,3 ,3 ,5 ,T ,92 ,14
002975 ,  ,  ,  ,  ,2 ,2 ,3 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,22 ,8 ,6 ,2 ,6 ,F ,92 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,1 ,6 ,T ,92 ,16
002972 ,002906 ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,5 ,3 ,3 ,5 ,F ,92 ,15
002972 ,002906 ,002975 ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,. ,5 ,4 ,5 ,F ,92 ,16
002976 ,003732 ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,1 ,. ,3 ,. ,T ,92 ,16
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,. ,5 ,1 ,5 ,T ,92 ,14
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,7 ,1 ,6 ,T ,92 ,14
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,15 ,2 ,6 ,1 ,5 ,F ,92 ,13
  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,3 ,2 ,1 ,3 ,F ,92 ,13
002985 ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,7 ,2 ,8 ,F ,92 ,14
002981 ,002906 ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,17 ,10 ,8 ,3 ,8 ,F ,92 ,15
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,9 ,3 ,1 ,1 ,T ,92 ,8
  ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,2 ,1 ,3 ,F ,92 ,14
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,7 ,6 ,1 ,5 ,T ,92 ,12
002945 ,002933 ,002906 ,  ,  ,5 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,5 ,4 ,5 ,F ,92 ,15
002974 ,002906 ,002981 ,  ,  ,2 ,3 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,9 ,3 ,4 ,6 ,F ,92 ,13
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,5 ,1 ,7 ,T ,92 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,5 ,5 ,1 ,3 ,T ,92 ,16
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,8 ,6 ,1 ,5 ,T ,92 ,16
002906 ,002981 ,002944 ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,. ,3 ,4 ,5 ,F ,92 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,1 ,20 ,10 ,6 ,1 ,8 ,T ,92 ,17
003086 ,003428 ,002974 ,002972 ,  ,3 ,3 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,10 ,10 ,3 ,5 ,5 ,F ,92 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,7 ,3 ,1 ,4 ,T ,92 ,15
001108 ,002906 ,002981 ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,34 ,10 ,2 ,5 ,6 ,F ,92 ,14
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,15 ,9 ,4 ,1 ,5 ,F ,92 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,4 ,1 ,3 ,F ,92 ,16
002975 ,002984 ,002972 ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,8 ,8 ,6 ,4 ,6 ,F ,92 ,14
002161 ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,25 ,. ,6 ,2 ,3 ,T ,92 ,14
002974 ,001569 ,003434 ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,6 ,4 ,6 ,F ,92 ,15
002906 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,2 ,2 ,6 ,F ,92 ,18
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,6 ,1 ,6 ,T ,92 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,6 ,8 ,1 ,6 ,T ,92 ,14
002906 ,002984 ,002975 ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,2 ,. ,5 ,4 ,5 ,F ,92 ,15
002975 ,002972 ,002984 ,  ,  ,5 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,4 ,5 ,F ,92 ,15
002981 ,002906 ,  ,  ,  ,4 ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,10 ,5 ,3 ,6 ,F ,92 ,15
002972 ,  ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,50 ,4 ,6 ,2 ,3 ,T ,92 ,18
002986 ,002976 ,  ,  ,  ,5 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,6 ,3 ,8 ,T ,92 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,30 ,4 ,3 ,1 ,3 ,T ,92 ,16
002944 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,5 ,2 ,5 ,F ,92 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,2 ,3 ,1 ,3 ,T ,92 ,15
002962 ,  ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,9 ,3 ,2 ,3 ,T ,92 ,9
002972 ,002974 ,002984 ,002976 ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,7 ,5 ,5 ,3 ,F ,92 ,15
003404 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,10 ,5 ,2 ,3 ,F ,92 ,13
002981 ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,12 ,8 ,8 ,2 ,3 ,F ,92 ,15
002913 ,002976 ,  ,  ,  ,5 ,3 ,2 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,4 ,2 ,3 ,5 ,F ,92 ,15
002906 ,002978 ,002974 ,002976 ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,8 ,5 ,8 ,F ,92 ,17
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,10 ,8 ,1 ,8 ,F ,92 ,13
  ,  ,  ,  ,  ,3 ,2 ,  ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,20 ,5 ,3 ,1 ,3 ,T ,92 ,17
002981 ,002975 ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,8 ,8 ,5 ,3 ,6 ,F ,92 ,18
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,5 ,2 ,1 ,2 ,T ,92 ,14
002976 ,002974 ,002931 ,002930 ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,5 ,5 ,6 ,F ,92 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,25 ,5 ,3 ,1 ,6 ,T ,92 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,10 ,6 ,1 ,8 ,T ,92 ,15
002906 ,002981 ,  ,  ,  ,2 ,1 ,1 ,  ,1 ,0 ,0 ,0 ,0 ,0 ,. ,3 ,5 ,3 ,6 ,F ,92 ,13
002981 ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,5 ,8 ,1 ,8 ,F ,92 ,15
002974 ,002906 ,002972 ,  ,  ,2 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,8 ,4 ,8 ,F ,92 ,17
002972 ,002981 ,999996 ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,9 ,3 ,4 ,6 ,F ,92 ,14
002972 ,  ,  ,  ,  ,4 ,2 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,14 ,8 ,6 ,2 ,6 ,F ,92 ,16
  ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,16 ,7 ,5 ,1 ,3 ,F ,92 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,10 ,8 ,1 ,8 ,F ,92 ,16
  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,. ,10 ,5 ,1 ,6 ,F ,92 ,15
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,20 ,3 ,4 ,1 ,4 ,T ,92 ,14
002974 ,002906 ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,8 ,3 ,7 ,F ,92 ,17
002975 ,002981 ,002906 ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,7 ,5 ,4 ,6 ,T ,92 ,12
002972 ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,5 ,2 ,5 ,F ,92 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,40 ,9 ,6 ,1 ,6 ,T ,92 ,17
002974 ,002981 ,002914 ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,4 ,4 ,6 ,F ,92 ,16
002974 ,002981 ,002976 ,002906 ,  ,2 ,3 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,3 ,2 ,5 ,1 ,F ,92 ,15
002981 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,4 ,5 ,2 ,6 ,F ,92 ,14
002981 ,002974 ,002979 ,002984 ,  ,4 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,6 ,5 ,8 ,F ,92 ,15
002906 ,  ,  ,  ,  ,5 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,5 ,2 ,5 ,F ,92 ,15
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,12 ,7 ,5 ,1 ,6 ,F ,92 ,12
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,10 ,4 ,1 ,8 ,T ,92 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,4 ,6 ,1 ,3 ,T ,92 ,5
002906 ,002981 ,  ,  ,  ,3 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,12 ,4 ,5 ,3 ,6 ,F ,92 ,14
  ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,60 ,4 ,4 ,1 ,2 ,T ,92 ,4
002975 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,2 ,3 ,2 ,3 ,T ,92 ,14
002974 ,002906 ,002972 ,002984 ,002976 ,3 ,3 ,3 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,6 ,4 ,5 ,6 ,3 ,F ,92 ,12
  ,  ,  ,  ,  ,1 ,2 ,1 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,8 ,1 ,6 ,F ,92 ,15
002972 ,004033 ,002906 ,  ,  ,1 ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,30 ,8 ,4 ,4 ,4 ,T ,92 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,2 ,3 ,1 ,3 ,T ,92 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,10 ,6 ,1 ,5 ,T ,92 ,12
  ,  ,  ,  ,  ,5 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,6 ,5 ,1 ,5 ,F ,92 ,18
002944 ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,36 ,10 ,5 ,1 ,8 ,T ,92 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,7 ,4 ,1 ,8 ,T ,92 ,12
002984 ,002906 ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,6 ,3 ,3 ,3 ,F ,92 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,10 ,8 ,5 ,1 ,5 ,T ,92 ,13
002944 ,008466 ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,30 ,9 ,3 ,3 ,2 ,F ,92 ,14
003534 ,003705 ,003519 ,003742 ,003768 ,5 ,3 ,3 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,10 ,10 ,6 ,6 ,5 ,F ,92 ,20
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,5 ,3 ,1 ,3 ,F ,92 ,13
002972 ,002981 ,002906 ,  ,  ,2 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,35 ,8 ,4 ,4 ,3 ,T ,92 ,14
002975 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,25 ,10 ,8 ,2 ,5 ,T ,92 ,14
  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,5 ,5 ,1 ,3 ,T ,92 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,10 ,6 ,1 ,8 ,T ,92 ,18
002906 ,002981 ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,5 ,3 ,3 ,F ,92 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,35 ,5 ,3 ,1 ,4 ,T ,92 ,11
002974 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,6 ,6 ,2 ,6 ,F ,92 ,16
002981 ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,5 ,5 ,2 ,7 ,F ,92 ,14
002981 ,002906 ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,. ,6 ,3 ,6 ,F ,92 ,12
002976 ,002905 ,002986 ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,10 ,8 ,6 ,4 ,6 ,F ,92 ,15
  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,5 ,5 ,1 ,2 ,F ,92 ,14
002910 ,002975 ,002974 ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,3 ,3 ,4 ,3 ,F ,92 ,15
004033 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,9 ,3 ,2 ,5 ,F ,92 ,14
002906 ,002944 ,002981 ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,2 ,4 ,4 ,5 ,F ,92 ,15
  ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,37 ,5 ,2 ,1 ,4 ,F ,92 ,12
006951 ,002976 ,002912 ,002981 ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,9 ,6 ,5 ,6 ,F ,92 ,14
002976 ,002906 ,002981 ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,3 ,4 ,4 ,5 ,F ,92 ,13
002972 ,002976 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,6 ,3 ,5 ,F ,92 ,14
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,7 ,3 ,1 ,4 ,F ,92 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,1 ,. ,. ,5 ,1 ,6 ,F ,92 ,14
003713 ,002975 ,002972 ,002920 ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,10 ,. ,3 ,5 ,3 ,F ,92 ,17
002906 ,002979 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,4 ,5 ,3 ,5 ,F ,92 ,15
002889 ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,10 ,6 ,6 ,2 ,4 ,F ,92 ,15
002978 ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,5 ,2 ,6 ,F ,92 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,35 ,1 ,3 ,1 ,3 ,T ,92 ,12
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,50 ,3 ,3 ,1 ,3 ,T ,92 ,4
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,0 ,0 ,0 ,1 ,1 ,0 ,30 ,8 ,6 ,1 ,6 ,T ,92 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,5 ,3 ,1 ,3 ,T ,92 ,13
002974 ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,4 ,3 ,2 ,4 ,F ,92 ,13
003432 ,003530 ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,5 ,3 ,3 ,5 ,F ,92 ,15
002972 ,002975 ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,10 ,5 ,3 ,5 ,F ,92 ,14
002976 ,003530 ,002923 ,004033 ,  ,2 ,2 ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,15 ,9 ,8 ,5 ,8 ,F ,92 ,15
002906 ,002978 ,002927 ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,7 ,4 ,4 ,4 ,F ,92 ,17
002978 ,002918 ,002981 ,  ,  ,4 ,  ,2 ,  ,1 ,0 ,1 ,0 ,1 ,0 ,. ,5 ,4 ,4 ,5 ,F ,92 ,16
002906 ,002984 ,002975 ,002981 ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,7 ,5 ,8 ,F ,92 ,17
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,5 ,1 ,6 ,F ,92 ,14
002975 ,002945 ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,6 ,3 ,6 ,F ,92 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,8 ,8 ,1 ,6 ,T ,92 ,15
003723 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,2 ,5 ,2 ,4 ,F ,92 ,15
002906 ,002981 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,4 ,3 ,3 ,1 ,F ,92 ,13
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,6 ,1 ,0 ,3 ,F ,92 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,25 ,7 ,8 ,1 ,8 ,T ,92 ,12
002976 ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,17 ,8 ,6 ,2 ,5 ,F ,92 ,15
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,9 ,8 ,1 ,8 ,T ,92 ,6
002974 ,002906 ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,9 ,6 ,3 ,6 ,F ,92 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,0 ,0 ,1 ,0 ,1 ,0 ,20 ,3 ,6 ,1 ,4 ,F ,92 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,1 ,8 ,F ,92 ,16
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,30 ,6 ,3 ,1 ,4 ,F ,92 ,15
002906 ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,8 ,6 ,2 ,3 ,F ,92 ,14
002981 ,002906 ,002975 ,  ,  ,2 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,18 ,8 ,3 ,4 ,5 ,F ,92 ,14
002981 ,002906 ,002972 ,003418 ,002930 ,1 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,8 ,6 ,4 ,6 ,F ,92 ,17
  ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,4 ,3 ,1 ,3 ,F ,92 ,17
002976 ,003530 ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,5 ,3 ,3 ,5 ,F ,92 ,13
002975 ,002929 ,002941 ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,8 ,6 ,5 ,4 ,3 ,F ,92 ,16
003431 ,  ,  ,  ,  ,3 ,  ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,1 ,16 ,4 ,5 ,2 ,5 ,F ,92 ,13
002975 ,002972 ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,12 ,10 ,6 ,3 ,4 ,F ,92 ,16
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,15 ,7 ,8 ,1 ,8 ,T ,92 ,16
002944 ,  ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,25 ,5 ,5 ,2 ,6 ,F ,92 ,15
002906 ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,8 ,8 ,2 ,8 ,T ,92 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,30 ,8 ,4 ,1 ,3 ,F ,92 ,14
002975 ,  ,  ,  ,  ,4 ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,30 ,8 ,5 ,2 ,6 ,F ,92 ,16
  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,9 ,2 ,1 ,6 ,T ,92 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,7 ,5 ,1 ,6 ,F ,92 ,16
003709 ,  ,  ,  ,  ,2 ,1 ,1 ,  ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,4 ,2 ,8 ,F ,92 ,14
002906 ,  ,  ,  ,  ,4 ,  ,2 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,6 ,2 ,2 ,8 ,F ,92 ,15
  ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,16 ,4 ,5 ,1 ,5 ,F ,92 ,15
002923 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,8 ,4 ,2 ,6 ,F ,92 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,55 ,10 ,3 ,1 ,3 ,T ,92 ,4
002973 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,32 ,7 ,3 ,2 ,4 ,T ,92 ,16
002974 ,002972 ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,7 ,3 ,3 ,3 ,F ,92 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,13 ,7 ,3 ,1 ,6 ,T ,92 ,12
002906 ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,6 ,5 ,2 ,3 ,F ,92 ,15
002976 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,7 ,. ,3 ,2 ,3 ,F ,92 ,14
002975 ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,9 ,8 ,2 ,8 ,T ,92 ,14
002975 ,002906 ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,3 ,3 ,8 ,F ,92 ,13
002906 ,002981 ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,18 ,1 ,3 ,3 ,4 ,F ,92 ,14
002974 ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,13 ,. ,5 ,2 ,5 ,F ,92 ,14
002944 ,002981 ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,5 ,6 ,3 ,3 ,F ,92 ,17
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,4 ,3 ,1 ,1 ,F ,92 ,14
002975 ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,12 ,2 ,3 ,2 ,3 ,F ,92 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,0 ,0 ,0 ,0 ,1 ,0 ,12 ,10 ,5 ,1 ,6 ,T ,92 ,20
002944 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,. ,5 ,4 ,2 ,3 ,T ,92 ,13
004033 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,12 ,8 ,2 ,2 ,4 ,T ,92 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,3 ,4 ,1 ,3 ,T ,92 ,14
002906 ,002976 ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,2 ,2 ,3 ,4 ,F ,92 ,16
002926 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,2 ,7 ,3 ,1 ,5 ,F ,92 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,8 ,6 ,1 ,6 ,F ,92 ,15
002913 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,5 ,2 ,1 ,F ,92 ,16
004033 ,002972 ,  ,  ,  ,1 ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,3 ,3 ,3 ,F ,92 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,1 ,0 ,. ,7 ,3 ,1 ,5 ,T ,92 ,14
002972 ,002974 ,  ,  ,  ,4 ,1 ,2 ,  ,0 ,0 ,0 ,0 ,0 ,1 ,. ,9 ,6 ,3 ,5 ,F ,92 ,13
003530 ,002974 ,  ,  ,  ,1 ,2 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,17 ,8 ,3 ,3 ,4 ,F ,92 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,38 ,. ,3 ,1 ,2 ,T ,92 ,8
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,6 ,2 ,1 ,3 ,T ,92 ,16
001479 ,006740 ,001370 ,003825 ,002975 ,2 ,1 ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,20 ,10 ,6 ,6 ,6 ,T ,92 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,50 ,3 ,3 ,1 ,1 ,T ,92 ,6
  ,  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,5 ,5 ,1 ,5 ,F ,92 ,16
002972 ,002974 ,999996 ,002923 ,  ,4 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,7 ,6 ,5 ,7 ,F ,92 ,18
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,0 ,0 ,0 ,0 ,1 ,0 ,20 ,7 ,3 ,1 ,3 ,T ,92 ,14
003086 ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,8 ,2 ,8 ,F ,92 ,16
002906 ,002974 ,002972 ,  ,  ,1 ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,8 ,4 ,8 ,F ,92 ,15
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,40 ,3 ,3 ,1 ,2 ,T ,92 ,13
002984 ,002923 ,002972 ,  ,  ,4 ,  ,3 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,4 ,6 ,4 ,3 ,F ,92 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,4 ,3 ,1 ,2 ,T ,92 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,8 ,3 ,1 ,3 ,F ,92 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,8 ,7 ,4 ,1 ,6 ,F ,92 ,15
002906 ,002975 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,6 ,6 ,3 ,3 ,F ,92 ,15
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,24 ,8 ,4 ,1 ,3 ,T ,92 ,12
002981 ,002976 ,002906 ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,4 ,5 ,4 ,3 ,F ,92 ,18
002975 ,002978 ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,8 ,3 ,8 ,F ,92 ,16
002906 ,002984 ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,8 ,3 ,8 ,F ,92 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,8 ,3 ,1 ,4 ,T ,92 ,14
003434 ,002978 ,001598 ,002974 ,001569 ,1 ,2 ,2 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,6 ,4 ,8 ,5 ,F ,92 ,16
002981 ,003509 ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,. ,3 ,3 ,3 ,T ,92 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,9 ,6 ,1 ,8 ,T ,92 ,17
002975 ,002972 ,002981 ,  ,  ,1 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,9 ,3 ,4 ,3 ,F ,92 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,0 ,0 ,1 ,0 ,1 ,0 ,20 ,3 ,3 ,1 ,3 ,T ,92 ,16
  ,  ,  ,  ,  ,1 ,1 ,  ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,. ,5 ,1 ,4 ,T ,92 ,7
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,18 ,7 ,4 ,1 ,3 ,T ,92 ,15
002941 ,002981 ,002906 ,  ,  ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,7 ,5 ,4 ,6 ,F ,92 ,16
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,5 ,1 ,6 ,F ,92 ,18
002906 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,25 ,8 ,3 ,2 ,3 ,F ,92 ,15
004033 ,002981 ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,12 ,5 ,1 ,2 ,3 ,F ,92 ,16
002972 ,002954 ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,8 ,8 ,3 ,8 ,F ,92 ,15
003487 ,002975 ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,5 ,2 ,5 ,T ,92 ,12
003530 ,002972 ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,3 ,3 ,3 ,1 ,F ,92 ,16
002906 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,20 ,6 ,5 ,2 ,3 ,F ,92 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,8 ,8 ,6 ,1 ,8 ,F ,92 ,15
002972 ,002905 ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,6 ,3 ,4 ,F ,92 ,16
002981 ,002912 ,  ,  ,  ,3 ,  ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,9 ,8 ,3 ,8 ,F ,92 ,17
002948 ,  ,  ,  ,  ,5 ,1 ,2 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,8 ,6 ,2 ,8 ,T ,92 ,12
002976 ,002974 ,002979 ,002906 ,  ,3 ,3 ,  ,  ,1 ,1 ,1 ,0 ,1 ,0 ,. ,. ,6 ,5 ,5 ,F ,92 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,30 ,1 ,1 ,1 ,1 ,T ,92 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,  ,1 ,0 ,1 ,1 ,1 ,0 ,. ,1 ,1 ,. ,1 ,T ,92 ,13
005318 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,4 ,3 ,2 ,3 ,F ,92 ,14
  ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,4 ,3 ,1 ,3 ,F ,92 ,13
002975 ,002906 ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,3 ,3 ,3 ,3 ,F ,92 ,14
002972 ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,30 ,7 ,5 ,2 ,3 ,T ,92 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,6 ,3 ,1 ,5 ,T ,92 ,14
002981 ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,8 ,6 ,2 ,8 ,F ,92 ,17
002974 ,002906 ,002981 ,002972 ,002923 ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,8 ,7 ,8 ,F ,92 ,12
002944 ,002927 ,002906 ,002981 ,002975 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,10 ,8 ,6 ,8 ,F ,92 ,17
003242 ,006791 ,002984 ,002975 ,003981 ,2 ,3 ,2 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,5 ,6 ,5 ,F ,92 ,16
002978 ,002913 ,002923 ,002981 ,002984 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,5 ,9 ,6 ,F ,92 ,14
  ,  ,  ,  ,  ,4 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,17 ,6 ,4 ,1 ,8 ,T ,92 ,12
003448 ,  ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,12 ,3 ,3 ,2 ,7 ,T ,92 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,7 ,3 ,1 ,3 ,F ,92 ,15
  ,  ,  ,  ,  ,  ,  ,2 ,  ,1 ,0 ,0 ,1 ,1 ,0 ,. ,5 ,6 ,1 ,2 ,T ,92 ,15
  ,  ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,15 ,10 ,6 ,1 ,3 ,F ,92 ,13
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,9 ,5 ,1 ,3 ,F ,92 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,6 ,1 ,6 ,T ,92 ,14
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,30 ,9 ,3 ,1 ,3 ,T ,92 ,13
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,37 ,6 ,3 ,1 ,3 ,T ,92 ,11
002972 ,002974 ,  ,  ,  ,3 ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,5 ,8 ,3 ,6 ,F ,92 ,15
  ,  ,  ,  ,  ,4 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,. ,5 ,1 ,3 ,F ,92 ,15
002972 ,  ,  ,  ,  ,2 ,  ,2 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,5 ,5 ,2 ,3 ,F ,92 ,15
002981 ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,30 ,2 ,3 ,2 ,2 ,F ,92 ,14
002976 ,002974 ,002984 ,002906 ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,6 ,5 ,8 ,F ,92 ,14
  ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,5 ,8 ,1 ,8 ,F ,92 ,16
002972 ,001479 ,001830 ,  ,  ,2 ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,3 ,4 ,4 ,F ,92 ,14
002906 ,002920 ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,16 ,1 ,2 ,3 ,6 ,F ,92 ,16
002972 ,  ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,15 ,7 ,3 ,2 ,4 ,F ,92 ,13
002984 ,  ,  ,  ,  ,1 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,24 ,6 ,2 ,2 ,2 ,F ,92 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,8 ,5 ,1 ,3 ,F ,92 ,18
002981 ,002906 ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,6 ,4 ,5 ,2 ,5 ,F ,92 ,16
002981 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,5 ,2 ,3 ,F ,92 ,13
002972 ,002975 ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,10 ,7 ,3 ,7 ,F ,92 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,7 ,3 ,1 ,3 ,T ,92 ,11
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,1 ,3 ,1 ,3 ,T ,92 ,18
003425 ,002972 ,002912 ,  ,  ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,5 ,4 ,3 ,F ,92 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,10 ,3 ,1 ,5 ,T ,92 ,16
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,8 ,8 ,1 ,8 ,F ,92 ,17
002906 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,6 ,6 ,2 ,3 ,F ,92 ,15
002906 ,003428 ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,15 ,10 ,5 ,3 ,6 ,T ,92 ,15
  ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,15 ,4 ,3 ,1 ,3 ,T ,92 ,17
002944 ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,9 ,4 ,2 ,4 ,F ,92 ,16
002981 ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,3 ,7 ,2 ,6 ,F ,92 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,10 ,8 ,1 ,8 ,F ,92 ,12
002941 ,002984 ,002975 ,002981 ,002923 ,3 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,4 ,6 ,4 ,F ,92 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,15 ,9 ,6 ,1 ,7 ,F ,92 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,17 ,6 ,5 ,1 ,8 ,T ,92 ,16
  ,  ,  ,  ,  ,3 ,3 ,2 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,8 ,6 ,1 ,6 ,T ,92 ,13
004840 ,003457 ,003487 ,003810 ,  ,1 ,  ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,11 ,6 ,4 ,5 ,2 ,F ,92 ,12
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,40 ,5 ,2 ,1 ,2 ,T ,92 ,8
002906 ,  ,  ,  ,  ,1 ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,4 ,4 ,2 ,8 ,F ,92 ,16
002972 ,002975 ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,6 ,3 ,5 ,F ,92 ,18
002976 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,15 ,3 ,5 ,2 ,3 ,T ,92 ,14
002906 ,002976 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,9 ,7 ,3 ,7 ,F ,92 ,17
  ,  ,  ,  ,  ,3 ,3 ,1 ,  ,1 ,0 ,1 ,1 ,1 ,0 ,. ,8 ,3 ,1 ,3 ,F ,92 ,17
002939 ,002981 ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,4 ,5 ,2 ,2 ,F ,92 ,15
003715 ,  ,  ,  ,  ,3 ,3 ,2 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,10 ,9 ,6 ,2 ,8 ,F ,92 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,12 ,6 ,3 ,1 ,4 ,T ,92 ,13
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,35 ,8 ,4 ,1 ,4 ,F ,92 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,5 ,6 ,1 ,6 ,T ,92 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,25 ,6 ,5 ,1 ,5 ,T ,92 ,12
002975 ,003487 ,003425 ,002906 ,  ,1 ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,3 ,5 ,3 ,F ,92 ,17
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,25 ,5 ,4 ,1 ,4 ,T ,92 ,12
002974 ,002906 ,002976 ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,5 ,4 ,4 ,4 ,F ,92 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,5 ,3 ,1 ,2 ,T ,92 ,17
002974 ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,4 ,3 ,2 ,3 ,F ,92 ,16
002929 ,002981 ,  ,  ,  ,1 ,3 ,2 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,20 ,9 ,6 ,3 ,4 ,F ,92 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,6 ,5 ,1 ,5 ,T ,92 ,13
002972 ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,10 ,6 ,3 ,2 ,4 ,F ,92 ,16
002906 ,002974 ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,10 ,6 ,3 ,6 ,F ,92 ,15
002913 ,001952 ,  ,  ,  ,5 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,5 ,3 ,6 ,F ,92 ,15
002984 ,002974 ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,7 ,3 ,3 ,7 ,F ,92 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,5 ,6 ,1 ,6 ,T ,92 ,7
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,17 ,6 ,8 ,1 ,6 ,T ,92 ,14
001564 ,002931 ,002981 ,002941 ,007693 ,2 ,3 ,2 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,7 ,8 ,6 ,8 ,F ,92 ,16
002906 ,002978 ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,8 ,3 ,8 ,F ,92 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,6 ,1 ,8 ,F ,92 ,16
002923 ,002974 ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,5 ,6 ,3 ,6 ,F ,92 ,14
002974 ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,4 ,4 ,2 ,2 ,F ,92 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,7 ,4 ,1 ,8 ,T ,92 ,9
002906 ,  ,  ,  ,  ,1 ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,25 ,. ,6 ,2 ,6 ,T ,92 ,15
002981 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,1 ,2 ,1 ,T ,92 ,12
  ,  ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,15 ,10 ,3 ,1 ,3 ,T ,92 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,4 ,4 ,1 ,3 ,T ,92 ,7
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,40 ,4 ,4 ,1 ,6 ,T ,92 ,8
002981 ,002906 ,002972 ,  ,  ,2 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,7 ,4 ,4 ,3 ,T ,92 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,1 ,20 ,6 ,6 ,1 ,6 ,T ,92 ,14
  ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,2 ,3 ,1 ,5 ,T ,92 ,16
002923 ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,3 ,2 ,3 ,F ,92 ,12
  ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,1 ,3 ,1 ,6 ,F ,92 ,13
002972 ,002974 ,  ,  ,  ,3 ,  ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,20 ,5 ,4 ,3 ,4 ,F ,92 ,18
002984 ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,30 ,7 ,5 ,2 ,6 ,T ,92 ,13
  ,  ,  ,  ,  ,2 ,  ,  ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,. ,6 ,1 ,3 ,T ,92 ,16
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,7 ,3 ,1 ,3 ,T ,92 ,12
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,44 ,. ,3 ,1 ,5 ,F ,92 ,5
002972 ,002923 ,002975 ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,10 ,6 ,4 ,6 ,F ,92 ,16
001140 ,  ,  ,  ,  ,5 ,3 ,1 ,1 ,0 ,0 ,1 ,1 ,1 ,0 ,. ,7 ,8 ,2 ,3 ,F ,92 ,14
002906 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,6 ,3 ,2 ,7 ,F ,92 ,15
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,6 ,1 ,6 ,F ,92 ,15
002972 ,002974 ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,6 ,5 ,3 ,6 ,F ,92 ,15
002976 ,002981 ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,30 ,8 ,3 ,3 ,5 ,F ,92 ,17
004033 ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,8 ,3 ,2 ,6 ,F ,92 ,15
  ,  ,  ,  ,  ,4 ,  ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,9 ,6 ,1 ,6 ,F ,92 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,27 ,4 ,3 ,1 ,2 ,F ,92 ,15
002972 ,003425 ,  ,  ,  ,3 ,2 ,3 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,10 ,3 ,3 ,6 ,F ,92 ,15
002984 ,002923 ,  ,  ,  ,4 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,6 ,3 ,5 ,F ,92 ,14
002972 ,002974 ,003425 ,002906 ,001569 ,1 ,1 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,6 ,6 ,5 ,F ,92 ,15
003800 ,003732 ,  ,  ,  ,4 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,10 ,7 ,3 ,8 ,T ,92 ,15
002939 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,. ,1 ,2 ,3 ,T ,92 ,14
002985 ,  ,  ,  ,  ,1 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,2 ,6 ,2 ,5 ,F ,92 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,4 ,5 ,1 ,8 ,T ,92 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,17 ,4 ,8 ,1 ,8 ,T ,92 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,5 ,1 ,8 ,T ,92 ,18
006951 ,002976 ,002933 ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,5 ,4 ,3 ,F ,92 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,6 ,8 ,1 ,5 ,T ,92 ,5
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,25 ,9 ,5 ,1 ,7 ,F ,92 ,16
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,8 ,. ,5 ,1 ,5 ,T ,92 ,16
002906 ,002974 ,999996 ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,6 ,4 ,8 ,F ,92 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,4 ,5 ,1 ,7 ,T ,92 ,15
002906 ,002976 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,8 ,3 ,6 ,F ,92 ,17
002929 ,002906 ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,3 ,6 ,3 ,6 ,F ,92 ,13
001598 ,001554 ,001578 ,  ,  ,4 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,10 ,6 ,4 ,8 ,F ,92 ,16
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,10 ,3 ,1 ,3 ,T ,92 ,14
001479 ,003005 ,002330 ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,23 ,1 ,5 ,4 ,5 ,T ,92 ,16
001955 ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,2 ,8 ,2 ,8 ,F ,92 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,3 ,3 ,1 ,3 ,T ,92 ,12
003432 ,003431 ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,4 ,3 ,3 ,3 ,F ,92 ,14
003425 ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,8 ,2 ,8 ,F ,92 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,3 ,1 ,5 ,T ,92 ,8
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,8 ,8 ,1 ,4 ,T ,92 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,10 ,6 ,1 ,6 ,F ,92 ,13
002972 ,001009 ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,1 ,5 ,3 ,1 ,F ,92 ,15
002974 ,002972 ,  ,  ,  ,1 ,3 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,6 ,3 ,8 ,F ,92 ,15
001554 ,001578 ,001598 ,  ,  ,4 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,3 ,4 ,6 ,F ,92 ,16
003425 ,002972 ,002975 ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,7 ,4 ,6 ,F ,92 ,14
002974 ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,10 ,8 ,2 ,8 ,F ,92 ,16
002978 ,001598 ,001574 ,001572 ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,15 ,. ,4 ,5 ,3 ,F ,92 ,16
002974 ,002906 ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,2 ,3 ,3 ,7 ,F ,92 ,15
001574 ,001598 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,7 ,3 ,6 ,F ,92 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,  ,1 ,0 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,1 ,6 ,T ,92 ,15
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,55 ,7 ,5 ,1 ,5 ,T ,92 ,13
002906 ,001574 ,002981 ,003487 ,  ,5 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,6 ,5 ,5 ,F ,92 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,. ,3 ,1 ,5 ,T ,92 ,8
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,4 ,5 ,1 ,6 ,T ,92 ,19
003425 ,001009 ,002105 ,001005 ,  ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,5 ,5 ,8 ,F ,92 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,6 ,1 ,6 ,T ,92 ,14
001598 ,003431 ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,25 ,5 ,3 ,3 ,3 ,F ,92 ,12
001598 ,003487 ,002004 ,  ,  ,3 ,1 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,5 ,6 ,4 ,4 ,F ,92 ,14
002920 ,002974 ,002978 ,  ,  ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,9 ,8 ,4 ,8 ,F ,92 ,18
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,2 ,3 ,1 ,5 ,F ,92 ,14
006740 ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,21 ,10 ,5 ,2 ,5 ,T ,92 ,11
002976 ,002981 ,002974 ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,20 ,2 ,5 ,4 ,1 ,T ,92 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,1 ,5 ,T ,92 ,12
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,3 ,3 ,1 ,3 ,T ,92 ,14
003558 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,10 ,5 ,2 ,6 ,F ,92 ,17
002974 ,002985 ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,12 ,8 ,8 ,3 ,8 ,F ,92 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,40 ,9 ,3 ,1 ,6 ,T ,92 ,10
002589 ,001537 ,003230 ,004661 ,  ,4 ,3 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,8 ,5 ,8 ,F ,92 ,17
001572 ,  ,  ,  ,  ,3 ,3 ,2 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,8 ,3 ,5 ,2 ,5 ,F ,92 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,3 ,1 ,6 ,T ,92 ,13
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,7 ,8 ,1 ,3 ,T ,92 ,8
003434 ,003955 ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,8 ,3 ,8 ,F ,92 ,12
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,10 ,8 ,1 ,8 ,T ,92 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,17 ,. ,1 ,1 ,2 ,T ,92 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,8 ,7 ,5 ,1 ,5 ,T ,92 ,10
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,12 ,5 ,6 ,1 ,2 ,T ,92 ,6
001599 ,001537 ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,. ,4 ,3 ,4 ,F ,92 ,15
001565 ,001569 ,001537 ,  ,  ,4 ,3 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,6 ,6 ,4 ,6 ,F ,92 ,16
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,10 ,4 ,1 ,8 ,T ,92 ,14
002974 ,003505 ,001009 ,003510 ,001480 ,4 ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,8 ,10 ,5 ,F ,92 ,15
007693 ,001495 ,001585 ,002910 ,001840 ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,5 ,6 ,8 ,F ,92 ,15
009684 ,002981 ,  ,  ,  ,5 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,8 ,5 ,3 ,7 ,T ,92 ,7
002981 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,15 ,8 ,6 ,2 ,6 ,T ,92 ,17
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,42 ,10 ,6 ,1 ,5 ,T ,92 ,12
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,. ,4 ,1 ,4 ,T ,92 ,18
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,15 ,5 ,5 ,. ,6 ,T ,92 ,12
002972 ,002906 ,002913 ,004608 ,  ,5 ,3 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,4 ,5 ,5 ,8 ,F ,92 ,13
002984 ,002906 ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,12 ,8 ,6 ,3 ,7 ,F ,92 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,7 ,6 ,1 ,6 ,T ,92 ,4
002981 ,  ,  ,  ,  ,5 ,2 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,15 ,10 ,4 ,2 ,3 ,T ,92 ,15
003675 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,10 ,8 ,2 ,8 ,T ,92 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,0 ,0 ,1 ,0 ,0 ,0 ,20 ,. ,5 ,1 ,5 ,T ,92 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,7 ,. ,2 ,1 ,3 ,F ,92 ,12
002536 ,001444 ,001370 ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,15 ,7 ,3 ,4 ,4 ,F ,92 ,13
002976 ,002906 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,. ,5 ,3 ,6 ,F ,92 ,16
002975 ,002972 ,  ,  ,  ,4 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,15 ,10 ,6 ,3 ,6 ,T ,92 ,13
002944 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,5 ,2 ,3 ,F ,92 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,4 ,1 ,4 ,T ,92 ,14
002974 ,001839 ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,15 ,7 ,3 ,3 ,3 ,F ,92 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,. ,1 ,1 ,2 ,T ,92 ,15
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,17 ,7 ,8 ,1 ,8 ,T ,92 ,14
003535 ,001792 ,001825 ,002029 ,  ,2 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,5 ,6 ,F ,92 ,15
001598 ,002967 ,002972 ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,3 ,3 ,4 ,5 ,F ,92 ,14
002981 ,004033 ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,40 ,9 ,6 ,3 ,5 ,T ,92 ,11
001598 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,15 ,8 ,5 ,2 ,6 ,F ,92 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,8 ,8 ,1 ,3 ,T ,92 ,15
002974 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,4 ,8 ,2 ,8 ,F ,92 ,14
  ,  ,  ,  ,  ,5 ,3 ,1 ,2 ,0 ,0 ,1 ,0 ,1 ,0 ,20 ,5 ,6 ,1 ,1 ,T ,92 ,13
002981 ,002906 ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,3 ,6 ,3 ,6 ,F ,92 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,25 ,. ,6 ,1 ,6 ,T ,92 ,17
002974 ,002975 ,002906 ,002944 ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,8 ,5 ,6 ,F ,92 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,3 ,2 ,1 ,3 ,T ,92 ,4
  ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,5 ,5 ,1 ,6 ,F ,92 ,13
  ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,6 ,6 ,1 ,6 ,T ,92 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,4 ,1 ,8 ,T ,92 ,14
002975 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,4 ,2 ,5 ,T ,92 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,. ,10 ,8 ,1 ,6 ,T ,92 ,20
003425 ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,1 ,3 ,2 ,8 ,F ,92 ,15
002972 ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,33 ,1 ,5 ,2 ,6 ,F ,92 ,14
009635 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,8 ,5 ,2 ,8 ,T ,92 ,13
002974 ,003217 ,002671 ,002353 ,002358 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,8 ,6 ,8 ,F ,92 ,18
007104 ,001989 ,  ,  ,  ,4 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,5 ,3 ,6 ,F ,92 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,3 ,1 ,3 ,T ,92 ,15
002906 ,002976 ,002948 ,002926 ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,25 ,8 ,7 ,5 ,8 ,T ,92 ,14
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,9 ,8 ,1 ,8 ,F ,92 ,13
002981 ,  ,  ,  ,  ,  ,  ,  ,  ,1 ,0 ,1 ,1 ,1 ,0 ,. ,4 ,6 ,2 ,8 ,T ,92 ,11
002972 ,003423 ,001479 ,  ,  ,3 ,3 ,3 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,30 ,9 ,5 ,4 ,3 ,F ,92 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,8 ,1 ,1 ,1 ,T ,92 ,13
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,7 ,3 ,1 ,2 ,T ,92 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,6 ,1 ,8 ,T ,92 ,16
002126 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,10 ,6 ,2 ,7 ,F ,92 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,9 ,3 ,1 ,3 ,T ,92 ,16
  ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,6 ,7 ,1 ,8 ,F ,92 ,15
002739 ,003981 ,003530 ,  ,  ,2 ,3 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,6 ,5 ,4 ,4 ,F ,92 ,17
005447 ,003534 ,001487 ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,9 ,6 ,4 ,6 ,F ,92 ,14
002975 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,. ,6 ,2 ,6 ,T ,92 ,10
999996 ,999996 ,999996 ,999996 ,002920 ,3 ,3 ,3 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,6 ,7 ,6 ,T ,92 ,14
006968 ,002976 ,002984 ,001535 ,  ,1 ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,1 ,5 ,5 ,8 ,F ,92 ,16
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,5 ,1 ,5 ,T ,92 ,15
002976 ,003448 ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,9 ,8 ,3 ,6 ,F ,92 ,14
003451 ,001515 ,003529 ,003481 ,001531 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,8 ,3 ,6 ,6 ,F ,92 ,15
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,1 ,. ,6 ,3 ,1 ,6 ,F ,92 ,16
002975 ,  ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,45 ,10 ,3 ,1 ,3 ,T ,92 ,10
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,4 ,3 ,1 ,. ,T ,92 ,18
002981 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,17 ,10 ,5 ,2 ,6 ,T ,92 ,14
003505 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,. ,8 ,2 ,8 ,T ,92 ,17
002974 ,002976 ,002906 ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,. ,5 ,5 ,4 ,6 ,F ,92 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,. ,3 ,1 ,6 ,T ,92 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,5 ,2 ,1 ,2 ,T ,92 ,14
002975 ,001009 ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,10 ,5 ,4 ,7 ,T ,92 ,15
002981 ,002923 ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,7 ,3 ,8 ,F ,92 ,16
  ,  ,  ,  ,  ,4 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,1 ,27 ,3 ,3 ,1 ,3 ,F ,92 ,15
002960 ,002941 ,002957 ,003456 ,002945 ,4 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,8 ,6 ,6 ,F ,92 ,16
002979 ,  ,  ,  ,  ,4 ,2 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,4 ,3 ,2 ,6 ,T ,92 ,8
002974 ,001321 ,001605 ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,15 ,1 ,6 ,4 ,6 ,F ,92 ,16
  ,  ,  ,  ,  ,3 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,5 ,1 ,6 ,T ,92 ,13
  ,  ,  ,  ,  ,1 ,3 ,2 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,12 ,3 ,5 ,1 ,3 ,T ,92 ,17
002906 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,3 ,5 ,2 ,4 ,T ,92 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,25 ,5 ,5 ,1 ,5 ,T ,92 ,15
003304 ,004741 ,  ,  ,  ,5 ,3 ,2 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,6 ,8 ,3 ,8 ,F ,92 ,18
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,6 ,5 ,1 ,5 ,F ,92 ,17
002974 ,002906 ,  ,  ,  ,5 ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,10 ,8 ,3 ,8 ,T ,92 ,16
003478 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,4 ,2 ,4 ,T ,92 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,10 ,8 ,1 ,7 ,T ,92 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,5 ,1 ,5 ,T ,92 ,15
002974 ,003448 ,  ,  ,  ,5 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,3 ,3 ,T ,92 ,14
002542 ,002503 ,003613 ,  ,  ,5 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,6 ,3 ,6 ,F ,92 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,35 ,1 ,8 ,1 ,8 ,F ,92 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,8 ,5 ,1 ,3 ,T ,92 ,15
003969 ,002972 ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,7 ,5 ,3 ,6 ,T ,92 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,15 ,7 ,6 ,1 ,6 ,T ,92 ,13
003421 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,8 ,5 ,2 ,6 ,T ,92 ,16
002981 ,002906 ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,20 ,10 ,5 ,3 ,6 ,F ,92 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,10 ,7 ,8 ,1 ,2 ,T ,92 ,11
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,15 ,10 ,8 ,1 ,5 ,T ,92 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,40 ,4 ,6 ,1 ,5 ,T ,92 ,4
002954 ,002949 ,  ,  ,  ,4 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,10 ,5 ,3 ,5 ,T ,92 ,19
001598 ,002975 ,002972 ,006951 ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,10 ,3 ,5 ,4 ,T ,92 ,10
002972 ,002978 ,002984 ,002974 ,002975 ,1 ,1 ,2 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,10 ,7 ,6 ,21 ,8 ,T ,92 ,14
003802 ,003798 ,003790 ,003785 ,002981 ,5 ,3 ,3 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,35 ,10 ,5 ,8 ,7 ,T ,92 ,13
001569 ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,3 ,8 ,2 ,6 ,F ,92 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,9 ,5 ,1 ,5 ,T ,92 ,14
002981 ,002976 ,002979 ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,6 ,1 ,4 ,2 ,F ,92 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,. ,3 ,1 ,3 ,T ,92 ,15
002974 ,002976 ,002981 ,001535 ,  ,2 ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,24 ,5 ,3 ,5 ,3 ,F ,92 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,7 ,7 ,1 ,3 ,T ,92 ,7
002984 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,10 ,5 ,2 ,6 ,T ,92 ,16
002906 ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,20 ,. ,5 ,2 ,6 ,F ,92 ,12
001531 ,002941 ,003456 ,002906 ,002976 ,5 ,1 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,5 ,10 ,6 ,F ,92 ,15
002984 ,002974 ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,18 ,2 ,3 ,3 ,5 ,F ,92 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,3 ,1 ,1 ,1 ,T ,92 ,16
  ,  ,  ,  ,  ,4 ,3 ,1 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,3 ,1 ,4 ,F ,92 ,15
003481 ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,9 ,2 ,2 ,4 ,F ,92 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,1 ,3 ,1 ,3 ,T ,92 ,19
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,. ,5 ,1 ,5 ,T ,92 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,10 ,6 ,1 ,7 ,T ,92 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,6 ,1 ,6 ,T ,92 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,9 ,6 ,1 ,6 ,F ,92 ,15
006740 ,  ,  ,  ,  ,5 ,1 ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,20 ,10 ,6 ,2 ,6 ,T ,92 ,13
002984 ,002974 ,003954 ,001489 ,001469 ,5 ,2 ,3 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,7 ,5 ,6 ,5 ,F ,92 ,13
  ,  ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,2 ,. ,8 ,1 ,8 ,F ,92 ,14


/* db93.dat */

  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,9 ,6 ,1 ,6 ,T ,93 ,14
002906 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,30 ,3 ,6 ,2 ,5 ,T ,93 ,15
003535 ,001987 ,003767 ,001537 ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,6 ,6 ,5 ,6 ,F ,93 ,16
002981 ,002976 ,002906 ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,9 ,2 ,3 ,6 ,F ,93 ,15
008084 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,3 ,4 ,2 ,3 ,T ,93 ,14
003954 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,3 ,2 ,6 ,F ,93 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,  ,1 ,0 ,0 ,0 ,0 ,0 ,. ,9 ,6 ,1 ,8 ,T ,93 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,. ,4 ,1 ,7 ,T ,93 ,12
002957 ,  ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,5 ,4 ,2 ,2 ,T ,93 ,14
002941 ,002927 ,001418 ,002739 ,001564 ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,8 ,2 ,5 ,6 ,4 ,F ,93 ,14
  ,  ,  ,  ,  ,4 ,  ,  ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,40 ,3 ,3 ,1 ,8 ,T ,93 ,3
003425 ,003456 ,011385 ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,5 ,4 ,5 ,F ,93 ,16
002906 ,002976 ,002975 ,002984 ,  ,3 ,2 ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,10 ,6 ,8 ,5 ,3 ,F ,93 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,50 ,. ,7 ,1 ,4 ,T ,93 ,13
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,7 ,8 ,1 ,3 ,T ,93 ,17
002975 ,002976 ,002978 ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,35 ,10 ,4 ,3 ,8 ,T ,93 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,15 ,10 ,6 ,1 ,8 ,T ,93 ,12
  ,  ,  ,  ,  ,5 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,8 ,2 ,1 ,5 ,T ,93 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,2 ,3 ,1 ,6 ,F ,93 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,9 ,3 ,1 ,3 ,T ,93 ,15
  ,  ,  ,  ,  ,  ,  ,1 ,  ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,. ,1 ,. ,T ,93 ,4
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,. ,3 ,1 ,2 ,T ,93 ,8
002978 ,001572 ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,20 ,10 ,3 ,3 ,6 ,T ,93 ,15
003487 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,8 ,3 ,6 ,2 ,3 ,F ,93 ,15
002976 ,002221 ,999999 ,002951 ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,5 ,5 ,4 ,1 ,F ,93 ,12
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,25 ,3 ,6 ,1 ,8 ,T ,93 ,5
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,3 ,1 ,4 ,T ,93 ,14
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,10 ,6 ,1 ,8 ,T ,93 ,15
  ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,17 ,. ,7 ,1 ,6 ,F ,93 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,. ,3 ,1 ,1 ,2 ,F ,93 ,14
003721 ,003746 ,003732 ,  ,  ,1 ,3 ,2 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,8 ,4 ,6 ,4 ,8 ,F ,93 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,6 ,1 ,4 ,T ,93 ,15
002920 ,002927 ,002913 ,002984 ,  ,4 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,4 ,5 ,6 ,F ,93 ,17
002389 ,002923 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,6 ,3 ,6 ,F ,93 ,15
002906 ,002923 ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,6 ,3 ,6 ,F ,93 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,  ,1 ,1 ,0 ,1 ,1 ,0 ,. ,. ,5 ,1 ,5 ,F ,93 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,6 ,5 ,1 ,5 ,F ,93 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,0 ,1 ,1 ,1 ,1 ,0 ,20 ,. ,5 ,1 ,8 ,T ,93 ,18
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,3 ,1 ,1 ,. ,T ,93 ,12
002944 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,7 ,8 ,2 ,5 ,T ,93 ,17
002974 ,003378 ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,4 ,3 ,4 ,F ,93 ,21
006965 ,003256 ,004741 ,001489 ,002628 ,2 ,3 ,3 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,6 ,3 ,7 ,7 ,F ,93 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,10 ,7 ,5 ,1 ,3 ,F ,93 ,16
002972 ,  ,  ,  ,  ,4 ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,8 ,2 ,8 ,F ,93 ,17
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,27 ,10 ,5 ,1 ,7 ,T ,93 ,12
002978 ,002906 ,002981 ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,8 ,3 ,4 ,3 ,F ,93 ,17
003744 ,003721 ,011644 ,003388 ,002984 ,2 ,  ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,3 ,8 ,8 ,F ,93 ,14
002976 ,002899 ,002109 ,002744 ,003288 ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,14 ,4 ,4 ,10 ,6 ,F ,93 ,12
003288 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,2 ,2 ,3 ,F ,93 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,7 ,3 ,1 ,5 ,T ,93 ,12
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,15 ,10 ,8 ,1 ,7 ,T ,93 ,14
002976 ,002981 ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,18 ,9 ,3 ,3 ,6 ,T ,93 ,13
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,23 ,10 ,4 ,1 ,6 ,T ,93 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,10 ,7 ,6 ,1 ,6 ,T ,93 ,18
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,10 ,6 ,3 ,1 ,3 ,F ,93 ,15
003127 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,5 ,3 ,2 ,3 ,F ,93 ,13
001989 ,002905 ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,10 ,10 ,6 ,3 ,8 ,T ,93 ,16
  ,  ,  ,  ,  ,5 ,  ,  ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,. ,1 ,. ,T ,93 ,15
002199 ,  ,  ,  ,  ,5 ,3 ,2 ,2 ,0 ,1 ,1 ,0 ,1 ,0 ,20 ,8 ,6 ,2 ,6 ,T ,93 ,16
002972 ,002975 ,  ,  ,  ,2 ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,8 ,10 ,3 ,3 ,4 ,F ,93 ,15
003721 ,002103 ,002078 ,002065 ,002941 ,3 ,1 ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,3 ,10 ,6 ,F ,93 ,16
  ,  ,  ,  ,  ,4 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,25 ,10 ,6 ,1 ,6 ,F ,93 ,17
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,25 ,1 ,4 ,1 ,4 ,T ,93 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,15 ,6 ,5 ,1 ,3 ,F ,93 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,23 ,. ,3 ,1 ,5 ,T ,93 ,13
001009 ,003425 ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,10 ,7 ,3 ,8 ,T ,93 ,16
002946 ,003732 ,003735 ,003749 ,  ,5 ,1 ,2 ,  ,1 ,0 ,1 ,0 ,1 ,0 ,. ,8 ,7 ,5 ,8 ,F ,93 ,15
002972 ,002978 ,002975 ,  ,  ,2 ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,8 ,6 ,4 ,6 ,F ,93 ,16
003736 ,003720 ,002984 ,002906 ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,8 ,6 ,5 ,6 ,F ,93 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,23 ,10 ,5 ,1 ,6 ,T ,93 ,12
003530 ,002222 ,001598 ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,7 ,4 ,4 ,2 ,F ,93 ,15
002906 ,002976 ,  ,  ,  ,2 ,2 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,10 ,4 ,3 ,5 ,F ,93 ,14
002029 ,001515 ,001564 ,006951 ,  ,3 ,1 ,2 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,8 ,5 ,8 ,F ,93 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,25 ,9 ,5 ,1 ,7 ,T ,93 ,15
  ,  ,  ,  ,  ,3 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,3 ,6 ,1 ,3 ,F ,93 ,15
002105 ,001081 ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,3 ,6 ,3 ,4 ,F ,93 ,16
  ,  ,  ,  ,  ,5 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,. ,5 ,1 ,5 ,T ,93 ,13
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,9 ,3 ,1 ,5 ,F ,93 ,14
003749 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,10 ,9 ,6 ,2 ,8 ,T ,93 ,15
003697 ,002976 ,008504 ,003734 ,  ,3 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,3 ,5 ,3 ,F ,93 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,8 ,5 ,1 ,5 ,T ,93 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,0 ,0 ,1 ,1 ,1 ,0 ,15 ,10 ,8 ,1 ,8 ,T ,93 ,15
002972 ,002975 ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,. ,6 ,3 ,6 ,F ,93 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,5 ,5 ,1 ,6 ,T ,93 ,12
002930 ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,8 ,2 ,4 ,F ,93 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,0 ,0 ,0 ,0 ,0 ,1 ,20 ,. ,3 ,1 ,3 ,T ,93 ,5
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,12 ,7 ,3 ,1 ,3 ,T ,93 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,2 ,1 ,8 ,T ,93 ,10
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,8 ,3 ,1 ,4 ,F ,93 ,15
002929 ,  ,  ,  ,  ,4 ,1 ,1 ,  ,1 ,0 ,1 ,1 ,1 ,0 ,. ,9 ,3 ,2 ,8 ,F ,93 ,15
002979 ,002923 ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,3 ,3 ,5 ,F ,93 ,15
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,3 ,1 ,4 ,F ,93 ,15
004033 ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,8 ,6 ,6 ,1 ,5 ,F ,93 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,8 ,6 ,1 ,6 ,F ,93 ,14
002906 ,  ,  ,  ,  ,3 ,1 ,1 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,4 ,6 ,2 ,5 ,F ,93 ,15
002981 ,  ,  ,  ,  ,4 ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,6 ,6 ,2 ,6 ,F ,93 ,12
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,10 ,9 ,5 ,1 ,3 ,T ,93 ,16
002906 ,002981 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,9 ,6 ,3 ,6 ,F ,93 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,30 ,8 ,6 ,1 ,8 ,T ,93 ,14
002976 ,002984 ,002981 ,002975 ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,3 ,5 ,3 ,F ,93 ,14
002974 ,002972 ,002975 ,003425 ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,6 ,6 ,5 ,4 ,F ,93 ,17
002974 ,003425 ,  ,  ,  ,1 ,3 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,4 ,3 ,3 ,5 ,F ,93 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,24 ,2 ,5 ,1 ,5 ,T ,93 ,17
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,9 ,8 ,1 ,6 ,F ,93 ,16
002975 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,10 ,9 ,7 ,2 ,7 ,T ,93 ,12
002974 ,002906 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,6 ,3 ,3 ,1 ,F ,93 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,7 ,5 ,1 ,5 ,F ,93 ,16
002974 ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,6 ,. ,5 ,2 ,5 ,F ,93 ,15
002974 ,  ,  ,  ,  ,1 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,5 ,2 ,5 ,F ,93 ,16
002981 ,002976 ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,8 ,. ,3 ,3 ,6 ,F ,93 ,11
002972 ,002981 ,  ,  ,  ,5 ,3 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,8 ,3 ,4 ,3 ,3 ,F ,93 ,15
002906 ,002923 ,002984 ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,6 ,6 ,4 ,5 ,F ,93 ,17
002972 ,002975 ,002906 ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,8 ,3 ,4 ,3 ,F ,93 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,7 ,3 ,1 ,8 ,F ,93 ,14
002944 ,003496 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,3 ,3 ,3 ,3 ,F ,93 ,17
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,8 ,8 ,1 ,8 ,F ,93 ,18
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,15 ,. ,5 ,1 ,8 ,F ,93 ,17
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,25 ,3 ,3 ,1 ,5 ,T ,93 ,18
002906 ,002979 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,8 ,3 ,6 ,F ,93 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,6 ,3 ,1 ,3 ,T ,93 ,14
002906 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,4 ,2 ,3 ,T ,93 ,15
002974 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,7 ,2 ,8 ,F ,93 ,15
002981 ,002955 ,002923 ,002978 ,  ,1 ,3 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,3 ,4 ,3 ,F ,93 ,15
  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,5 ,1 ,4 ,F ,93 ,15
002906 ,  ,  ,  ,  ,1 ,1 ,1 ,  ,1 ,0 ,0 ,0 ,0 ,0 ,. ,9 ,5 ,2 ,5 ,F ,93 ,12
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,0 ,0 ,1 ,1 ,1 ,0 ,. ,7 ,6 ,1 ,7 ,F ,93 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,1 ,2 ,1 ,3 ,F ,93 ,15
002975 ,002972 ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,4 ,6 ,3 ,6 ,F ,93 ,14
  ,  ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,23 ,5 ,4 ,1 ,3 ,F ,93 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,8 ,6 ,1 ,3 ,T ,93 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,67 ,3 ,2 ,1 ,3 ,T ,93 ,6
002974 ,002972 ,002923 ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,3 ,4 ,6 ,F ,93 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,40 ,7 ,3 ,1 ,3 ,T ,93 ,8
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,5 ,3 ,1 ,3 ,F ,93 ,14
002772 ,001813 ,  ,  ,  ,1 ,  ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,5 ,2 ,2 ,F ,93 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,5 ,1 ,6 ,F ,93 ,16
002981 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,8 ,3 ,2 ,2 ,F ,93 ,17
002972 ,002981 ,  ,  ,  ,1 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,3 ,3 ,4 ,F ,93 ,15
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,7 ,7 ,4 ,1 ,4 ,F ,93 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,4 ,. ,6 ,T ,93 ,10
002906 ,003519 ,002701 ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,4 ,8 ,4 ,7 ,F ,93 ,14
002972 ,  ,  ,  ,  ,1 ,1 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,25 ,3 ,5 ,2 ,5 ,F ,93 ,15
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,9 ,6 ,1 ,6 ,T ,93 ,14
002944 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,10 ,1 ,. ,2 ,. ,T ,93 ,17
002906 ,002923 ,  ,  ,  ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,8 ,3 ,6 ,F ,93 ,14
002979 ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,25 ,4 ,3 ,2 ,6 ,F ,93 ,17
002905 ,002950 ,  ,  ,  ,5 ,  ,1 ,2 ,0 ,0 ,0 ,0 ,1 ,0 ,20 ,1 ,5 ,3 ,4 ,T ,93 ,12
002974 ,002978 ,002906 ,  ,  ,1 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,6 ,3 ,4 ,3 ,F ,93 ,15
002972 ,002984 ,  ,  ,  ,1 ,3 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,6 ,3 ,4 ,F ,93 ,14
002979 ,  ,  ,  ,  ,4 ,  ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,2 ,7 ,2 ,2 ,T ,93 ,15
002974 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,5 ,2 ,5 ,F ,93 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,10 ,3 ,1 ,3 ,T ,93 ,14
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,25 ,7 ,6 ,1 ,4 ,F ,93 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,18 ,10 ,7 ,1 ,4 ,T ,93 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,40 ,5 ,3 ,1 ,4 ,T ,93 ,5
003379 ,  ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,8 ,3 ,2 ,3 ,F ,93 ,15
  ,  ,  ,  ,  ,  ,  ,1 ,  ,1 ,0 ,1 ,1 ,1 ,0 ,. ,7 ,. ,1 ,. ,F ,93 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,10 ,5 ,1 ,5 ,T ,93 ,15
002981 ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,7 ,3 ,2 ,5 ,F ,93 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,6 ,1 ,6 ,F ,93 ,15
001305 ,002785 ,002974 ,002976 ,  ,2 ,1 ,3 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,. ,5 ,5 ,5 ,4 ,F ,93 ,15
002972 ,002927 ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,8 ,10 ,5 ,3 ,8 ,T ,93 ,18
002981 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,30 ,9 ,3 ,2 ,4 ,F ,93 ,14
002944 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,6 ,6 ,2 ,6 ,F ,93 ,17
002974 ,002976 ,002906 ,003511 ,002981 ,2 ,1 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,5 ,6 ,6 ,F ,93 ,16
002906 ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,6 ,5 ,2 ,5 ,F ,93 ,16
002976 ,002981 ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,. ,4 ,3 ,5 ,F ,93 ,14
002972 ,  ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,10 ,10 ,6 ,2 ,5 ,T ,93 ,13
002972 ,002975 ,002981 ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,5 ,4 ,4 ,F ,93 ,16
002974 ,002972 ,  ,  ,  ,5 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,3 ,6 ,F ,93 ,18
002975 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,0 ,0 ,1 ,0 ,1 ,0 ,28 ,1 ,8 ,2 ,8 ,T ,93 ,18
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,8 ,1 ,8 ,F ,93 ,15
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,9 ,6 ,1 ,7 ,F ,93 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,3 ,1 ,3 ,T ,93 ,18
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,3 ,1 ,6 ,F ,93 ,17
002923 ,002946 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,. ,8 ,3 ,3 ,3 ,F ,93 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,6 ,1 ,6 ,F ,93 ,15
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,3 ,3 ,1 ,4 ,F ,93 ,16
001620 ,001598 ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,16 ,7 ,5 ,3 ,4 ,T ,93 ,10
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,6 ,1 ,6 ,T ,93 ,12
002981 ,002976 ,002906 ,  ,  ,2 ,3 ,3 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,12 ,5 ,3 ,4 ,3 ,F ,93 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,6 ,5 ,1 ,4 ,T ,93 ,4
003256 ,002972 ,002981 ,002976 ,  ,2 ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,30 ,9 ,2 ,5 ,2 ,F ,93 ,16
002972 ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,16 ,8 ,5 ,2 ,5 ,F ,93 ,12
002981 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,9 ,6 ,2 ,6 ,F ,93 ,14
002944 ,002913 ,002981 ,002972 ,  ,2 ,  ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,6 ,4 ,5 ,6 ,F ,93 ,15
002981 ,002906 ,002975 ,  ,  ,3 ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,3 ,4 ,5 ,F ,93 ,12
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,9 ,5 ,1 ,6 ,F ,93 ,17
002974 ,002944 ,002906 ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,10 ,8 ,4 ,6 ,F ,93 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,4 ,1 ,4 ,T ,93 ,13
002981 ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,25 ,8 ,5 ,2 ,5 ,F ,93 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,6 ,1 ,5 ,F ,93 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,5 ,5 ,1 ,5 ,T ,93 ,18
002974 ,002981 ,002986 ,  ,  ,3 ,3 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,1 ,3 ,4 ,. ,F ,93 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,30 ,6 ,8 ,1 ,5 ,T ,93 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,20 ,4 ,3 ,1 ,3 ,F ,93 ,13
003428 ,002011 ,999999 ,002108 ,  ,3 ,  ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,35 ,10 ,8 ,8 ,8 ,F ,93 ,13
  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,7 ,5 ,1 ,5 ,F ,93 ,15
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,10 ,4 ,1 ,4 ,T ,93 ,12
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,4 ,1 ,6 ,F ,93 ,16
002974 ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,6 ,2 ,6 ,F ,93 ,18
002906 ,009092 ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,12 ,6 ,8 ,3 ,5 ,F ,93 ,15
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,6 ,1 ,8 ,F ,93 ,16
002944 ,002906 ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,8 ,6 ,3 ,6 ,F ,93 ,16
002972 ,002976 ,002984 ,002979 ,  ,1 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,5 ,8 ,F ,93 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,8 ,5 ,1 ,3 ,F ,93 ,17
002923 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,6 ,6 ,2 ,6 ,F ,93 ,14
002972 ,002975 ,  ,  ,  ,5 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,6 ,4 ,3 ,4 ,F ,93 ,16
002974 ,001598 ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,10 ,8 ,3 ,7 ,F ,93 ,16
  ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,2 ,1 ,5 ,F ,93 ,15
002906 ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,25 ,8 ,5 ,2 ,6 ,F ,93 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,6 ,3 ,1 ,4 ,T ,93 ,4
  ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,10 ,10 ,6 ,1 ,8 ,T ,93 ,15
002981 ,  ,  ,  ,  ,2 ,3 ,1 ,  ,1 ,1 ,0 ,0 ,1 ,1 ,. ,6 ,6 ,2 ,8 ,F ,93 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,20 ,5 ,6 ,1 ,5 ,T ,93 ,14
002906 ,002975 ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,6 ,8 ,3 ,7 ,T ,93 ,14
002976 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,2 ,1 ,2 ,1 ,F ,93 ,15
002949 ,002974 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,3 ,3 ,4 ,T ,93 ,10
002944 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,16 ,4 ,6 ,2 ,1 ,F ,93 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,30 ,6 ,2 ,1 ,5 ,T ,93 ,9
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,20 ,6 ,4 ,1 ,4 ,T ,93 ,12
002976 ,002974 ,  ,  ,  ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,. ,. ,8 ,2 ,5 ,T ,93 ,12
002974 ,002906 ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,6 ,3 ,8 ,F ,93 ,16
002974 ,002976 ,002929 ,003732 ,003721 ,3 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,8 ,3 ,7 ,6 ,F ,93 ,15
  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,4 ,5 ,1 ,3 ,T ,93 ,13
010392 ,002972 ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,6 ,3 ,6 ,F ,93 ,15
  ,  ,  ,  ,  ,1 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,6 ,3 ,1 ,6 ,F ,93 ,16
002906 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,3 ,2 ,2 ,F ,93 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,25 ,7 ,5 ,1 ,6 ,T ,93 ,14
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,6 ,4 ,1 ,3 ,F ,93 ,16
002974 ,001598 ,003301 ,  ,  ,3 ,3 ,1 ,  ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,4 ,4 ,5 ,F ,93 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,3 ,6 ,1 ,3 ,F ,93 ,15
002906 ,002981 ,  ,  ,  ,1 ,  ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,24 ,5 ,3 ,3 ,3 ,F ,93 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,6 ,3 ,0 ,3 ,T ,93 ,19
002927 ,001586 ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,8 ,6 ,3 ,7 ,F ,93 ,16
002906 ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,. ,5 ,3 ,2 ,3 ,F ,93 ,14
002974 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,15 ,. ,8 ,2 ,8 ,T ,93 ,15
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,5 ,5 ,1 ,6 ,T ,93 ,13
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,0 ,0 ,1 ,0 ,1 ,0 ,40 ,9 ,4 ,1 ,8 ,T ,93 ,4
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,8 ,1 ,6 ,F ,93 ,16
002976 ,002931 ,003428 ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,6 ,4 ,5 ,F ,93 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,6 ,1 ,8 ,F ,93 ,14
002906 ,  ,  ,  ,  ,5 ,3 ,1 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,7 ,2 ,7 ,F ,93 ,14
002974 ,002976 ,002906 ,002972 ,002953 ,2 ,1 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,6 ,3 ,7 ,4 ,F ,93 ,16
002975 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,6 ,2 ,6 ,F ,93 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,3 ,3 ,1 ,2 ,T ,93 ,14
002972 ,  ,  ,  ,  ,2 ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,12 ,7 ,5 ,2 ,6 ,F ,93 ,15
002981 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,7 ,6 ,2 ,5 ,T ,93 ,14
002981 ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,8 ,3 ,3 ,2 ,5 ,F ,93 ,16
002944 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,3 ,2 ,5 ,T ,93 ,16
002976 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,12 ,5 ,3 ,2 ,3 ,T ,93 ,12
002981 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,37 ,5 ,2 ,2 ,2 ,T ,93 ,20
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,15 ,8 ,6 ,1 ,6 ,F ,93 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,. ,10 ,4 ,1 ,5 ,F ,93 ,12
003431 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,7 ,6 ,2 ,5 ,F ,93 ,15
  ,  ,  ,  ,  ,3 ,  ,3 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,7 ,6 ,1 ,6 ,T ,93 ,13
002981 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,4 ,3 ,2 ,3 ,F ,93 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,8 ,1 ,8 ,F ,93 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,6 ,5 ,1 ,3 ,T ,93 ,14
002975 ,002972 ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,2 ,3 ,3 ,F ,93 ,17
002981 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,. ,6 ,2 ,6 ,F ,93 ,14
002981 ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,15 ,. ,5 ,2 ,5 ,F ,93 ,15
002976 ,002949 ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,10 ,. ,6 ,3 ,8 ,T ,93 ,15
002974 ,  ,  ,  ,  ,2 ,  ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,5 ,5 ,2 ,5 ,F ,93 ,13
002906 ,001513 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,6 ,5 ,3 ,4 ,F ,93 ,16
002927 ,002984 ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,7 ,8 ,3 ,5 ,F ,93 ,15
002981 ,002972 ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,5 ,2 ,3 ,2 ,F ,93 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,6 ,1 ,8 ,T ,93 ,16
002972 ,002976 ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,8 ,6 ,3 ,6 ,F ,93 ,16
002920 ,002974 ,002944 ,002979 ,  ,3 ,3 ,2 ,  ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,8 ,5 ,8 ,F ,93 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,10 ,6 ,1 ,8 ,T ,93 ,8
002972 ,002974 ,002946 ,  ,  ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,6 ,5 ,4 ,5 ,F ,93 ,14
  ,  ,  ,  ,  ,5 ,  ,1 ,  ,1 ,0 ,1 ,0 ,0 ,0 ,. ,9 ,6 ,1 ,6 ,F ,93 ,15
003536 ,003445 ,002981 ,  ,  ,2 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,8 ,4 ,6 ,F ,93 ,16
002906 ,002975 ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,4 ,3 ,4 ,F ,93 ,17
003732 ,002927 ,002945 ,  ,  ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,5 ,4 ,4 ,F ,93 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,14 ,5 ,6 ,1 ,5 ,F ,93 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,10 ,3 ,1 ,5 ,T ,93 ,12
002976 ,002981 ,002906 ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,8 ,4 ,4 ,4 ,F ,93 ,14
003754 ,002975 ,002905 ,  ,  ,3 ,3 ,3 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,4 ,7 ,4 ,5 ,F ,93 ,15
002981 ,002906 ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,4 ,4 ,3 ,4 ,F ,93 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,27 ,9 ,6 ,1 ,3 ,F ,93 ,13
  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,2 ,5 ,1 ,5 ,F ,93 ,12
002974 ,002972 ,  ,  ,  ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,2 ,8 ,3 ,8 ,F ,93 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,6 ,7 ,1 ,6 ,T ,93 ,18
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,6 ,1 ,6 ,F ,93 ,14
002608 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,21 ,9 ,5 ,2 ,8 ,F ,93 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,30 ,9 ,5 ,1 ,8 ,T ,93 ,11
  ,  ,  ,  ,  ,1 ,1 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,3 ,5 ,. ,1 ,T ,93 ,17
002906 ,002945 ,002927 ,002981 ,  ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,5 ,3 ,5 ,4 ,F ,93 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,1 ,20 ,10 ,8 ,1 ,8 ,T ,93 ,17
  ,  ,  ,  ,  ,2 ,2 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,7 ,1 ,8 ,T ,93 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,5 ,1 ,6 ,T ,93 ,15
002946 ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,2 ,8 ,F ,93 ,14
  ,  ,  ,  ,  ,5 ,  ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,30 ,7 ,4 ,1 ,6 ,T ,93 ,11
002974 ,002906 ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,5 ,5 ,3 ,8 ,F ,93 ,18
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,6 ,3 ,8 ,1 ,3 ,F ,93 ,16
  ,  ,  ,  ,  ,1 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,6 ,1 ,8 ,F ,93 ,16
002923 ,002906 ,002972 ,002974 ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,5 ,6 ,5 ,7 ,F ,93 ,15
  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,. ,1 ,6 ,1 ,6 ,T ,93 ,19
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,0 ,0 ,0 ,0 ,1 ,0 ,40 ,4 ,3 ,1 ,3 ,T ,93 ,7
  ,  ,  ,  ,  ,2 ,1 ,1 ,  ,0 ,0 ,0 ,0 ,0 ,1 ,. ,6 ,3 ,1 ,3 ,T ,93 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,16 ,6 ,6 ,1 ,6 ,T ,93 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,9 ,3 ,1 ,3 ,T ,93 ,4
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,4 ,1 ,6 ,T ,93 ,14
002974 ,002972 ,002975 ,002906 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,8 ,5 ,6 ,F ,93 ,14
002976 ,002975 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,4 ,3 ,6 ,F ,93 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,3 ,4 ,1 ,4 ,T ,93 ,17
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,40 ,5 ,2 ,1 ,4 ,T ,93 ,10
003530 ,002974 ,002972 ,  ,  ,1 ,  ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,9 ,8 ,4 ,8 ,F ,93 ,13
002927 ,002906 ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,6 ,8 ,3 ,8 ,F ,93 ,14
002972 ,002906 ,  ,  ,  ,4 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,3 ,8 ,F ,93 ,14
002974 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,2 ,6 ,F ,93 ,16
002906 ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,3 ,3 ,2 ,3 ,F ,93 ,14
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,0 ,1 ,1 ,1 ,1 ,1 ,10 ,9 ,7 ,1 ,8 ,F ,93 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,16 ,8 ,5 ,1 ,5 ,T ,93 ,18
001099 ,002931 ,002979 ,001793 ,  ,4 ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,8 ,5 ,6 ,F ,93 ,14
002984 ,002101 ,002916 ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,2 ,3 ,4 ,3 ,F ,93 ,15
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,30 ,10 ,6 ,1 ,8 ,T ,93 ,16
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,1 ,3 ,1 ,3 ,F ,93 ,15
  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,8 ,3 ,1 ,5 ,T ,93 ,13
002984 ,003744 ,002978 ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,12 ,7 ,5 ,4 ,6 ,F ,93 ,16
006760 ,002589 ,003414 ,002849 ,  ,4 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,5 ,5 ,5 ,F ,93 ,17
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,5 ,1 ,5 ,F ,93 ,15
002981 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,15 ,5 ,3 ,2 ,5 ,F ,93 ,16
002906 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,6 ,3 ,2 ,5 ,F ,93 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,9 ,9 ,5 ,1 ,5 ,T ,93 ,16
002906 ,002975 ,002914 ,002985 ,  ,1 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,17 ,5 ,3 ,5 ,5 ,F ,93 ,16
002975 ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,4 ,2 ,5 ,F ,93 ,17
002708 ,002974 ,003981 ,  ,  ,4 ,3 ,  ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,9 ,5 ,4 ,8 ,F ,93 ,17
003530 ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,5 ,3 ,2 ,3 ,F ,93 ,12
002906 ,002944 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,3 ,3 ,6 ,F ,93 ,16
002906 ,003434 ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,5 ,3 ,6 ,T ,93 ,12
002981 ,002944 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,5 ,5 ,3 ,3 ,F ,93 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,5 ,1 ,6 ,T ,93 ,15
002981 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,3 ,6 ,2 ,3 ,F ,93 ,14
002974 ,002671 ,001598 ,  ,  ,4 ,3 ,2 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,10 ,10 ,8 ,4 ,8 ,F ,93 ,15
002906 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,3 ,2 ,3 ,T ,93 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,10 ,. ,4 ,1 ,8 ,T ,93 ,6
002981 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,9 ,5 ,2 ,5 ,T ,93 ,16
  ,  ,  ,  ,  ,5 ,  ,1 ,2 ,0 ,0 ,0 ,0 ,1 ,0 ,40 ,2 ,6 ,1 ,5 ,T ,93 ,4
003086 ,  ,  ,  ,  ,3 ,  ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,0 ,. ,10 ,8 ,2 ,8 ,F ,93 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,9 ,6 ,1 ,6 ,T ,93 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,10 ,6 ,1 ,8 ,T ,93 ,12
002906 ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,5 ,2 ,3 ,F ,93 ,14
001554 ,002978 ,002974 ,003434 ,  ,4 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,5 ,5 ,7 ,F ,93 ,14
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,8 ,3 ,1 ,1 ,T ,93 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,30 ,3 ,3 ,1 ,3 ,T ,93 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,2 ,5 ,1 ,4 ,F ,93 ,15
002906 ,002944 ,002929 ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,4 ,4 ,4 ,F ,93 ,15
002976 ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,6 ,5 ,2 ,. ,T ,93 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,10 ,5 ,1 ,6 ,T ,93 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,  ,1 ,0 ,0 ,0 ,1 ,0 ,. ,5 ,3 ,1 ,3 ,F ,93 ,14
002972 ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,9 ,6 ,2 ,8 ,F ,93 ,16
002906 ,  ,  ,  ,  ,2 ,  ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,3 ,2 ,3 ,F ,93 ,16
  ,  ,  ,  ,  ,3 ,3 ,3 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,12 ,2 ,7 ,1 ,8 ,F ,93 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,28 ,2 ,6 ,1 ,6 ,T ,93 ,12
002912 ,002979 ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,6 ,3 ,6 ,F ,93 ,16
  ,  ,  ,  ,  ,5 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,6 ,1 ,7 ,F ,93 ,19
002976 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,15 ,8 ,3 ,2 ,3 ,F ,93 ,15
002974 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,5 ,3 ,2 ,1 ,F ,93 ,15
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,6 ,5 ,1 ,5 ,F ,93 ,15
003428 ,  ,  ,  ,  ,3 ,1 ,1 ,  ,1 ,0 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,2 ,8 ,F ,93 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,30 ,5 ,3 ,1 ,2 ,F ,93 ,15
002979 ,  ,  ,  ,  ,5 ,3 ,1 ,2 ,0 ,1 ,1 ,0 ,1 ,0 ,17 ,6 ,3 ,2 ,1 ,F ,93 ,12
002927 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,. ,5 ,2 ,6 ,F ,93 ,15
003434 ,002974 ,002975 ,  ,  ,3 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,7 ,4 ,5 ,4 ,6 ,F ,93 ,13
002976 ,002972 ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,10 ,6 ,3 ,6 ,F ,93 ,14
002985 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,8 ,7 ,2 ,6 ,F ,93 ,16
002981 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,4 ,2 ,6 ,F ,93 ,13
002906 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,. ,4 ,2 ,5 ,F ,93 ,12
009237 ,002927 ,002916 ,003709 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,3 ,5 ,3 ,F ,93 ,13
002976 ,002974 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,6 ,3 ,3 ,T ,93 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,8 ,1 ,8 ,T ,93 ,17
002981 ,  ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,35 ,1 ,7 ,2 ,. ,T ,93 ,6
003434 ,002974 ,  ,  ,  ,2 ,2 ,3 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,10 ,6 ,3 ,8 ,T ,93 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,4 ,5 ,1 ,5 ,T ,93 ,15
002929 ,002944 ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,. ,4 ,3 ,3 ,F ,93 ,14
002906 ,002981 ,002944 ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,6 ,4 ,4 ,6 ,F ,93 ,17
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,0 ,0 ,0 ,0 ,1 ,0 ,8 ,2 ,3 ,1 ,1 ,F ,93 ,15
002981 ,002906 ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,8 ,3 ,6 ,F ,93 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,15 ,9 ,8 ,1 ,8 ,T ,93 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,16 ,2 ,3 ,1 ,2 ,T ,93 ,13
002944 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,6 ,3 ,2 ,1 ,F ,93 ,12
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,27 ,. ,8 ,1 ,8 ,F ,93 ,16
002972 ,002975 ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,10 ,8 ,4 ,3 ,4 ,F ,93 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,9 ,3 ,1 ,3 ,T ,93 ,14
002974 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,10 ,10 ,6 ,2 ,7 ,F ,93 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,7 ,3 ,1 ,3 ,T ,93 ,12
002974 ,002972 ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,8 ,3 ,3 ,6 ,F ,93 ,14
002975 ,002915 ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,5 ,3 ,8 ,T ,93 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,23 ,8 ,4 ,1 ,3 ,T ,93 ,17
002920 ,002978 ,002906 ,  ,  ,3 ,1 ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,4 ,4 ,5 ,F ,93 ,16
002906 ,002972 ,002967 ,003445 ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,8 ,6 ,5 ,6 ,F ,93 ,15
  ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,25 ,7 ,2 ,1 ,5 ,F ,93 ,15
002944 ,003487 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,5 ,4 ,3 ,5 ,T ,93 ,9
002972 ,002974 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,9 ,3 ,3 ,5 ,F ,93 ,15
002944 ,003496 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,3 ,3 ,3 ,F ,93 ,17
002981 ,002906 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,6 ,3 ,1 ,F ,93 ,16
002974 ,  ,  ,  ,  ,2 ,3 ,2 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,5 ,2 ,5 ,F ,93 ,17
002976 ,002944 ,002927 ,002933 ,  ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,12 ,8 ,5 ,5 ,5 ,F ,93 ,15
002974 ,002916 ,002954 ,  ,  ,2 ,  ,2 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,2 ,3 ,4 ,1 ,F ,93 ,15
002974 ,002976 ,002906 ,  ,  ,4 ,3 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,8 ,4 ,4 ,6 ,F ,93 ,15
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,12 ,9 ,8 ,1 ,8 ,T ,93 ,14
002972 ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,7 ,2 ,6 ,F ,93 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,2 ,6 ,1 ,6 ,F ,93 ,14
002906 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,23 ,5 ,6 ,2 ,5 ,F ,93 ,14
002972 ,003425 ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,8 ,3 ,4 ,F ,93 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,30 ,5 ,5 ,1 ,5 ,F ,93 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,  ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,6 ,1 ,6 ,F ,93 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,14 ,6 ,3 ,1 ,3 ,T ,93 ,14
002906 ,002976 ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,10 ,6 ,6 ,3 ,8 ,F ,93 ,14
003448 ,003434 ,003428 ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,6 ,6 ,3 ,6 ,F ,93 ,14
  ,  ,  ,  ,  ,4 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,30 ,10 ,5 ,1 ,8 ,F ,93 ,4
002981 ,002929 ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,4 ,2 ,3 ,5 ,T ,93 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,9 ,7 ,1 ,8 ,F ,93 ,16
003425 ,001469 ,001489 ,003428 ,001495 ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,10 ,8 ,9 ,8 ,F ,93 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,8 ,1 ,8 ,T ,93 ,14
003237 ,002192 ,002974 ,  ,  ,2 ,3 ,3 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,3 ,5 ,4 ,6 ,F ,93 ,16
003425 ,006951 ,  ,  ,  ,3 ,  ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,3 ,3 ,5 ,F ,93 ,16
003457 ,007693 ,003428 ,002906 ,  ,3 ,1 ,  ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,. ,6 ,5 ,6 ,T ,93 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,30 ,10 ,6 ,1 ,6 ,T ,93 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,0 ,0 ,1 ,0 ,1 ,0 ,30 ,7 ,4 ,1 ,6 ,T ,93 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,. ,6 ,1 ,8 ,T ,93 ,13
001554 ,001577 ,001572 ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,3 ,3 ,3 ,F ,93 ,15
003428 ,002957 ,003481 ,003736 ,003418 ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,5 ,6 ,5 ,F ,93 ,14
001583 ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,3 ,4 ,2 ,3 ,F ,93 ,15
002906 ,001598 ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,7 ,6 ,3 ,8 ,F ,93 ,15
002957 ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,4 ,2 ,5 ,T ,93 ,15
001598 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,7 ,4 ,2 ,4 ,T ,93 ,15
002933 ,001585 ,001115 ,001567 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,7 ,5 ,6 ,F ,93 ,13
003535 ,003768 ,003534 ,003519 ,  ,2 ,  ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,10 ,8 ,5 ,7 ,F ,93 ,15
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,33 ,9 ,6 ,1 ,6 ,T ,93 ,4
002975 ,002984 ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,5 ,6 ,3 ,6 ,F ,93 ,15
003086 ,001574 ,  ,  ,  ,5 ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,5 ,5 ,3 ,6 ,F ,93 ,15
002972 ,002976 ,  ,  ,  ,5 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,8 ,10 ,6 ,3 ,8 ,F ,93 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,5 ,1 ,5 ,T ,93 ,10
009684 ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,6 ,8 ,2 ,8 ,T ,93 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,9 ,6 ,1 ,6 ,T ,93 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,0 ,0 ,1 ,1 ,0 ,0 ,10 ,6 ,6 ,1 ,4 ,T ,93 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,48 ,10 ,3 ,1 ,5 ,T ,93 ,7
001535 ,001489 ,002941 ,002978 ,  ,4 ,1 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,17 ,9 ,8 ,5 ,8 ,F ,93 ,15
001489 ,003954 ,001580 ,009841 ,003955 ,4 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,6 ,5 ,F ,93 ,12
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,. ,8 ,5 ,1 ,1 ,T ,93 ,9
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,. ,2 ,1 ,2 ,T ,93 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,10 ,3 ,1 ,5 ,T ,93 ,10
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,0 ,0 ,1 ,1 ,1 ,0 ,25 ,1 ,5 ,1 ,1 ,T ,93 ,13
002981 ,001489 ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,8 ,3 ,8 ,F ,93 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,24 ,6 ,6 ,1 ,1 ,T ,93 ,8
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,8 ,. ,1 ,. ,T ,93 ,13
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,10 ,6 ,1 ,8 ,T ,93 ,13
002941 ,002906 ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,. ,10 ,8 ,3 ,8 ,F ,93 ,14
003434 ,002912 ,  ,  ,  ,1 ,3 ,2 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,15 ,10 ,5 ,3 ,5 ,F ,93 ,15
003487 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,0 ,0 ,0 ,0 ,1 ,0 ,45 ,6 ,4 ,2 ,3 ,T ,93 ,9
003815 ,001999 ,003072 ,003051 ,003018 ,3 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,. ,3 ,6 ,5 ,F ,93 ,14
002975 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,6 ,5 ,2 ,5 ,F ,93 ,16
003391 ,002645 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,3 ,3 ,6 ,F ,93 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,35 ,8 ,4 ,1 ,3 ,F ,93 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,27 ,9 ,3 ,1 ,6 ,T ,93 ,14
  ,  ,  ,  ,  ,2 ,2 ,  ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,1 ,3 ,1 ,2 ,T ,93 ,7
  ,  ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,3 ,5 ,1 ,5 ,F ,93 ,15
002984 ,002954 ,  ,  ,  ,1 ,2 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,3 ,8 ,T ,93 ,19
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,2 ,3 ,1 ,4 ,T ,93 ,8
003746 ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,2 ,8 ,F ,93 ,15
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,43 ,8 ,7 ,1 ,4 ,T ,93 ,4
002974 ,002984 ,  ,  ,  ,4 ,3 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,9 ,7 ,3 ,6 ,F ,93 ,16
002976 ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,8 ,6 ,1 ,5 ,T ,93 ,16
002974 ,006740 ,004033 ,  ,  ,5 ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,8 ,4 ,4 ,5 ,F ,93 ,12
002972 ,002976 ,002933 ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,6 ,4 ,6 ,F ,93 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,2 ,2 ,1 ,. ,T ,93 ,16
002906 ,003721 ,001641 ,001696 ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,8 ,4 ,5 ,8 ,F ,93 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,20 ,10 ,6 ,1 ,7 ,T ,93 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,1 ,3 ,1 ,3 ,T ,93 ,19
002013 ,009092 ,002290 ,001489 ,001535 ,3 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,6 ,10 ,6 ,F ,93 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,. ,9 ,8 ,1 ,6 ,T ,93 ,9
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,5 ,3 ,1 ,5 ,T ,93 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,15 ,10 ,6 ,1 ,6 ,T ,93 ,14
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,7 ,6 ,1 ,3 ,T ,93 ,9
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,1 ,8 ,T ,93 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,5 ,1 ,8 ,T ,93 ,15
002923 ,002975 ,002984 ,  ,  ,4 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,9 ,8 ,4 ,8 ,F ,93 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,15 ,6 ,3 ,1 ,3 ,T ,93 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,0 ,0 ,1 ,0 ,1 ,0 ,20 ,7 ,3 ,1 ,3 ,T ,93 ,16
003530 ,003529 ,003709 ,003478 ,003487 ,3 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,7 ,6 ,6 ,6 ,F ,93 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,40 ,8 ,3 ,1 ,8 ,T ,93 ,5
  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,. ,5 ,1 ,3 ,T ,93 ,12
003479 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,4 ,6 ,2 ,3 ,F ,93 ,16
002906 ,002984 ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,5 ,3 ,3 ,F ,93 ,15
002972 ,003425 ,002974 ,001489 ,  ,4 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,8 ,5 ,8 ,F ,93 ,16
003496 ,003481 ,003529 ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,8 ,8 ,5 ,4 ,5 ,T ,93 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,6 ,6 ,1 ,6 ,T ,93 ,14
001999 ,001989 ,002972 ,  ,  ,2 ,1 ,1 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,5 ,4 ,4 ,F ,93 ,14
001598 ,002222 ,003414 ,003425 ,  ,1 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,10 ,8 ,5 ,8 ,T ,93 ,15
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,8 ,. ,8 ,1 ,8 ,T ,93 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,5 ,1 ,5 ,T ,93 ,18
002974 ,011792 ,001036 ,001554 ,  ,2 ,1 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,6 ,4 ,8 ,T ,93 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,15 ,7 ,7 ,1 ,6 ,T ,93 ,15
002910 ,003510 ,  ,  ,  ,5 ,3 ,2 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,. ,10 ,6 ,3 ,6 ,F ,93 ,17
002981 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,9 ,5 ,5 ,2 ,6 ,T ,93 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,0 ,0 ,1 ,0 ,1 ,0 ,15 ,8 ,4 ,1 ,4 ,T ,93 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,9 ,8 ,1 ,8 ,T ,93 ,14
002414 ,002910 ,002599 ,001580 ,003457 ,5 ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,10 ,6 ,12 ,8 ,F ,93 ,15
002976 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,23 ,5 ,6 ,2 ,6 ,T ,93 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,5 ,4 ,1 ,5 ,T ,93 ,14
002981 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,0 ,1 ,0 ,1 ,0 ,1 ,. ,10 ,8 ,2 ,6 ,T ,93 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,11 ,. ,3 ,1 ,6 ,T ,93 ,6
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,32 ,6 ,3 ,1 ,3 ,T ,93 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,17 ,1 ,6 ,1 ,7 ,T ,93 ,13
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,5 ,5 ,1 ,5 ,T ,93 ,16
001370 ,  ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,20 ,. ,8 ,2 ,8 ,F ,93 ,17
003754 ,003009 ,006965 ,002906 ,  ,3 ,2 ,2 ,2 ,0 ,0 ,1 ,1 ,1 ,0 ,8 ,10 ,7 ,5 ,8 ,F ,93 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,10 ,6 ,1 ,6 ,T ,93 ,13
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,35 ,9 ,5 ,1 ,8 ,T ,93 ,12
002918 ,003457 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,8 ,5 ,3 ,8 ,F ,93 ,17
002974 ,002976 ,002972 ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,3 ,4 ,1 ,F ,93 ,14
002974 ,002516 ,002651 ,002346 ,  ,2 ,1 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,2 ,7 ,5 ,8 ,F ,93 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,1 ,3 ,1 ,5 ,T ,93 ,9
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,25 ,8 ,3 ,1 ,5 ,F ,93 ,14
001536 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,6 ,10 ,4 ,2 ,6 ,T ,93 ,13
002974 ,003037 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,8 ,8 ,3 ,6 ,F ,93 ,16
001535 ,007893 ,001488 ,  ,  ,2 ,3 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,1 ,. ,7 ,5 ,4 ,5 ,F ,93 ,16
003185 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,15 ,3 ,6 ,2 ,6 ,T ,93 ,15
002906 ,002981 ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,8 ,3 ,8 ,F ,93 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,. ,. ,2 ,1 ,6 ,T ,93 ,9
  ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,30 ,9 ,3 ,1 ,3 ,T ,93 ,12
001012 ,001586 ,001564 ,001565 ,  ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,6 ,5 ,7 ,F ,93 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,9 ,8 ,1 ,6 ,T ,93 ,14
002906 ,002975 ,002974 ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,5 ,4 ,8 ,F ,93 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,0 ,0 ,1 ,0 ,1 ,0 ,20 ,3 ,8 ,1 ,5 ,T ,93 ,17
010139 ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,6 ,2 ,5 ,F ,93 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,15 ,9 ,7 ,1 ,8 ,T ,93 ,14
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,8 ,1 ,8 ,T ,93 ,14
002981 ,  ,  ,  ,  ,3 ,3 ,3 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,20 ,9 ,5 ,2 ,5 ,F ,93 ,14
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,25 ,1 ,2 ,1 ,3 ,T ,93 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,4 ,1 ,5 ,T ,93 ,13
002976 ,002974 ,003705 ,  ,  ,3 ,3 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,6 ,4 ,8 ,F ,93 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,5 ,4 ,1 ,3 ,T ,93 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,6 ,1 ,6 ,T ,93 ,17
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,0 ,1 ,0 ,0 ,1 ,0 ,55 ,1 ,1 ,1 ,3 ,T ,93 ,6
003732 ,002072 ,003428 ,002984 ,002095 ,4 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,3 ,6 ,8 ,F ,93 ,15
002927 ,002945 ,002941 ,002954 ,  ,4 ,3 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,10 ,2 ,2 ,5 ,2 ,F ,93 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,0 ,1 ,1 ,1 ,1 ,0 ,15 ,7 ,5 ,1 ,6 ,T ,93 ,14
002978 ,002974 ,002928 ,002920 ,  ,2 ,3 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,5 ,8 ,F ,93 ,16
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,8 ,1 ,8 ,T ,93 ,17
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,4 ,3 ,8 ,T ,93 ,18
002974 ,002918 ,002975 ,  ,  ,2 ,2 ,3 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,15 ,9 ,3 ,4 ,4 ,F ,93 ,16
002976 ,999999 ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,10 ,10 ,6 ,3 ,8 ,F ,93 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,2 ,1 ,1 ,1 ,T ,93 ,14
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,9 ,10 ,8 ,1 ,6 ,T ,93 ,15
003109 ,  ,  ,  ,  ,5 ,  ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,2 ,7 ,F ,93 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,5 ,1 ,6 ,T ,93 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,  ,1 ,1 ,0 ,1 ,0 ,0 ,. ,5 ,6 ,1 ,3 ,T ,93 ,13
  ,  ,  ,  ,  ,5 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,9 ,5 ,1 ,6 ,F ,93 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,5 ,3 ,1 ,. ,T ,93 ,17
003746 ,007693 ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,20 ,10 ,5 ,3 ,6 ,T ,93 ,16
002981 ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,10 ,7 ,4 ,2 ,5 ,F ,93 ,14
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,12 ,10 ,5 ,1 ,5 ,F ,93 ,15
002914 ,002933 ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,5 ,3 ,6 ,F ,93 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,25 ,. ,3 ,1 ,5 ,T ,93 ,5
002906 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,6 ,2 ,6 ,F ,93 ,16
001809 ,002976 ,002972 ,001535 ,  ,5 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,5 ,5 ,5 ,5 ,F ,93 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,5 ,3 ,1 ,3 ,F ,93 ,16
009635 ,001489 ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,10 ,6 ,5 ,3 ,5 ,F ,93 ,14
  ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,2 ,3 ,1 ,3 ,T ,93 ,6
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,8 ,6 ,1 ,8 ,F ,93 ,15
001535 ,003331 ,  ,  ,  ,3 ,2 ,3 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,25 ,1 ,6 ,3 ,6 ,F ,93 ,15
002972 ,002981 ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,12 ,10 ,3 ,3 ,5 ,F ,93 ,18
001586 ,  ,  ,  ,  ,4 ,3 ,  ,2 ,0 ,0 ,1 ,0 ,1 ,0 ,20 ,8 ,6 ,2 ,6 ,T ,93 ,15
003210 ,002906 ,002972 ,  ,  ,5 ,2 ,2 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,15 ,9 ,6 ,4 ,6 ,T ,93 ,10
003732 ,001117 ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,3 ,2 ,3 ,. ,T ,93 ,12
003212 ,999999 ,003265 ,001795 ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,14 ,4 ,3 ,5 ,4 ,F ,93 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,3 ,1 ,1 ,1 ,T ,93 ,13
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,. ,5 ,1 ,8 ,T ,93 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,5 ,5 ,1 ,8 ,T ,93 ,15
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,8 ,8 ,1 ,8 ,F ,93 ,15


/* db94.dat */

002130 ,003530 ,002981 ,002944 ,002906 ,3 ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,12 ,4 ,4 ,6 ,3 ,F ,94 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,9 ,6 ,1 ,. ,T ,94 ,18
002975 ,002981 ,  ,  ,  ,4 ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,6 ,5 ,5 ,3 ,6 ,F ,94 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,0 ,0 ,1 ,0 ,1 ,0 ,20 ,5 ,5 ,1 ,6 ,T ,94 ,7
002654 ,008155 ,002984 ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,4 ,2 ,4 ,2 ,T ,94 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,15 ,8 ,3 ,1 ,3 ,T ,94 ,19
002927 ,002984 ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,5 ,. ,3 ,3 ,6 ,F ,94 ,14
  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,. ,. ,8 ,1 ,8 ,T ,94 ,14
002906 ,002985 ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,9 ,7 ,6 ,3 ,6 ,F ,94 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,35 ,. ,4 ,1 ,4 ,T ,94 ,4
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,7 ,3 ,1 ,3 ,F ,94 ,16
002974 ,002984 ,002976 ,  ,  ,3 ,3 ,3 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,12 ,9 ,3 ,4 ,8 ,F ,94 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,38 ,7 ,6 ,1 ,6 ,T ,94 ,14
002579 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,. ,8 ,2 ,8 ,T ,94 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,20 ,1 ,1 ,1 ,1 ,T ,94 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,2 ,3 ,1 ,5 ,T ,94 ,18
002975 ,002972 ,001418 ,001422 ,003448 ,1 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,12 ,8 ,5 ,6 ,3 ,F ,94 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,10 ,3 ,1 ,3 ,F ,94 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,1 ,5 ,1 ,5 ,T ,94 ,16
002984 ,002976 ,002974 ,002978 ,001418 ,2 ,  ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,12 ,10 ,8 ,7 ,8 ,F ,94 ,15
003767 ,013022 ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,6 ,5 ,3 ,5 ,F ,94 ,15
  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,1 ,6 ,F ,94 ,10
001535 ,001489 ,002981 ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,10 ,. ,6 ,4 ,5 ,F ,94 ,16
001544 ,999999 ,002975 ,999999 ,002851 ,4 ,1 ,1 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,6 ,7 ,6 ,F ,94 ,15
003431 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,2 ,5 ,2 ,1 ,T ,94 ,16
002976 ,002974 ,002975 ,002942 ,  ,1 ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,3 ,5 ,2 ,F ,94 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,40 ,4 ,3 ,1 ,2 ,T ,94 ,7
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,. ,1 ,1 ,1 ,T ,94 ,17
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,15 ,2 ,6 ,1 ,6 ,T ,94 ,12
002849 ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,7 ,6 ,2 ,7 ,T ,94 ,14
002178 ,002974 ,001536 ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,27 ,8 ,3 ,4 ,5 ,F ,94 ,15
  ,  ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,40 ,. ,6 ,1 ,8 ,T ,94 ,17
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,1 ,5 ,1 ,2 ,F ,94 ,14
002844 ,002836 ,001707 ,002841 ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,8 ,3 ,5 ,3 ,T ,94 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,4 ,3 ,1 ,3 ,T ,94 ,17
002972 ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,10 ,10 ,5 ,2 ,8 ,F ,94 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,8 ,1 ,2 ,T ,94 ,13
002976 ,002906 ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,8 ,10 ,5 ,3 ,7 ,F ,94 ,15
002974 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,6 ,2 ,6 ,F ,94 ,17
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,3 ,1 ,5 ,F ,94 ,12
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,50 ,2 ,1 ,1 ,. ,T ,94 ,3
  ,  ,  ,  ,  ,4 ,  ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,16 ,10 ,6 ,1 ,8 ,F ,94 ,16
  ,  ,  ,  ,  ,5 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,2 ,6 ,1 ,6 ,T ,94 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,5 ,9 ,5 ,1 ,5 ,T ,94 ,15
003754 ,003721 ,002091 ,003744 ,002978 ,2 ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,8 ,9 ,8 ,F ,94 ,17
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,9 ,. ,. ,1 ,. ,T ,94 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,3 ,8 ,1 ,6 ,T ,94 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,15 ,. ,3 ,1 ,3 ,T ,94 ,15
002974 ,002975 ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,9 ,3 ,3 ,6 ,F ,94 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,10 ,8 ,1 ,8 ,T ,94 ,15
003732 ,999999 ,002927 ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,4 ,3 ,5 ,T ,94 ,15
001598 ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,8 ,4 ,2 ,5 ,F ,94 ,17
002967 ,009345 ,002600 ,002913 ,003732 ,2 ,1 ,1 ,  ,1 ,0 ,0 ,0 ,1 ,0 ,. ,8 ,3 ,8 ,6 ,T ,94 ,18
002979 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,. ,1 ,2 ,1 ,T ,94 ,14
002974 ,002976 ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,12 ,6 ,6 ,3 ,3 ,F ,94 ,17
  ,  ,  ,  ,  ,4 ,  ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,30 ,1 ,5 ,1 ,5 ,T ,94 ,14
002906 ,002975 ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,6 ,3 ,6 ,F ,94 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,17 ,2 ,4 ,1 ,3 ,T ,94 ,14
002981 ,002913 ,002972 ,002101 ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,7 ,5 ,8 ,F ,94 ,15
002972 ,002906 ,  ,  ,  ,5 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,3 ,3 ,6 ,F ,94 ,16
006965 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,8 ,3 ,2 ,6 ,F ,94 ,12
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,8 ,5 ,1 ,4 ,T ,94 ,27
  ,  ,  ,  ,  ,3 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,5 ,1 ,7 ,F ,94 ,16
002979 ,006965 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,5 ,3 ,8 ,F ,94 ,14
003981 ,999999 ,001671 ,999999 ,006791 ,3 ,3 ,3 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,2 ,3 ,6 ,8 ,F ,94 ,14
002972 ,002975 ,002906 ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,8 ,4 ,8 ,F ,94 ,16
003256 ,  ,  ,  ,  ,4 ,  ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,3 ,2 ,6 ,F ,94 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,1 ,6 ,1 ,6 ,T ,94 ,13
001564 ,  ,  ,  ,  ,1 ,1 ,2 ,2 ,0 ,0 ,1 ,1 ,1 ,0 ,30 ,6 ,5 ,2 ,3 ,T ,94 ,17
002091 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,9 ,6 ,2 ,8 ,T ,94 ,16
006951 ,002929 ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,25 ,2 ,6 ,3 ,3 ,T ,94 ,16
002103 ,002972 ,  ,  ,  ,2 ,3 ,1 ,  ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,6 ,3 ,8 ,F ,94 ,14
002974 ,001775 ,002920 ,  ,  ,4 ,1 ,3 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,12 ,10 ,6 ,4 ,8 ,F ,94 ,15
002882 ,002974 ,003238 ,003262 ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,10 ,6 ,5 ,8 ,F ,94 ,19
002972 ,002910 ,  ,  ,  ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,5 ,3 ,3 ,5 ,F ,94 ,14
002974 ,003434 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,3 ,8 ,3 ,8 ,F ,94 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,3 ,2 ,1 ,2 ,T ,94 ,17
001431 ,006965 ,001434 ,001444 ,002978 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,10 ,8 ,6 ,8 ,F ,94 ,15
  ,  ,  ,  ,  ,3 ,3 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,. ,2 ,5 ,1 ,6 ,F ,94 ,12
  ,  ,  ,  ,  ,4 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,12 ,9 ,3 ,1 ,8 ,T ,94 ,14
003535 ,002972 ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,10 ,8 ,3 ,6 ,F ,94 ,17
002945 ,002960 ,002984 ,003723 ,003428 ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,8 ,6 ,6 ,F ,94 ,18
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,25 ,10 ,8 ,1 ,7 ,T ,94 ,13
001052 ,002975 ,  ,  ,  ,4 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,10 ,6 ,3 ,6 ,F ,94 ,16
003981 ,002978 ,002974 ,002918 ,002906 ,2 ,3 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,3 ,7 ,3 ,F ,94 ,16
002906 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,4 ,2 ,8 ,F ,94 ,15
  ,  ,  ,  ,  ,5 ,  ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,30 ,7 ,3 ,1 ,3 ,T ,94 ,3
002423 ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,3 ,2 ,4 ,F ,94 ,15
002974 ,003705 ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,6 ,3 ,8 ,F ,94 ,18
003746 ,003719 ,002927 ,  ,  ,5 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,7 ,3 ,4 ,3 ,F ,94 ,15
002974 ,003705 ,002130 ,  ,  ,5 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,8 ,4 ,6 ,F ,94 ,17
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,0 ,0 ,0 ,0 ,1 ,0 ,20 ,10 ,6 ,1 ,7 ,T ,94 ,14
003754 ,  ,  ,  ,  ,5 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,3 ,6 ,2 ,6 ,F ,94 ,16
002974 ,002976 ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,10 ,8 ,3 ,8 ,F ,94 ,15
002974 ,002984 ,002917 ,  ,  ,5 ,1 ,2 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,30 ,5 ,5 ,4 ,6 ,T ,94 ,16
002095 ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,8 ,2 ,8 ,F ,94 ,16
003184 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,13 ,9 ,6 ,2 ,7 ,F ,94 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,5 ,1 ,6 ,T ,94 ,16
003711 ,001572 ,002975 ,001055 ,001580 ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,12 ,10 ,6 ,6 ,8 ,F ,94 ,15
001825 ,  ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,2 ,5 ,2 ,3 ,F ,94 ,17
001825 ,  ,  ,  ,  ,2 ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,2 ,5 ,2 ,3 ,F ,94 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,5 ,1 ,5 ,F ,94 ,15
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,4 ,5 ,1 ,3 ,T ,94 ,15
001989 ,003144 ,003831 ,  ,  ,2 ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,4 ,5 ,3 ,8 ,F ,94 ,16
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,10 ,8 ,1 ,8 ,T ,94 ,19
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,7 ,8 ,1 ,8 ,T ,94 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,. ,2 ,1 ,1 ,T ,94 ,7
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,17 ,6 ,5 ,1 ,1 ,T ,94 ,16
  ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,1 ,2 ,1 ,3 ,T ,94 ,8
002934 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,5 ,5 ,2 ,6 ,T ,94 ,13
002975 ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,2 ,5 ,2 ,3 ,F ,94 ,14
002981 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,5 ,3 ,2 ,3 ,T ,94 ,7
002972 ,002906 ,002981 ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,. ,5 ,4 ,6 ,F ,94 ,13
002941 ,002951 ,002930 ,002967 ,002931 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,8 ,5 ,6 ,4 ,F ,94 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,25 ,8 ,6 ,1 ,8 ,T ,94 ,14
002923 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,5 ,3 ,2 ,3 ,F ,94 ,18
  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,1 ,3 ,1 ,3 ,F ,94 ,18
002974 ,002975 ,002985 ,002929 ,002913 ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,8 ,6 ,5 ,F ,94 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,6 ,1 ,6 ,T ,94 ,13
001321 ,001320 ,001299 ,002358 ,002974 ,4 ,3 ,2 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,8 ,8 ,F ,94 ,14
002944 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,6 ,3 ,3 ,2 ,3 ,T ,94 ,11
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,8 ,2 ,1 ,4 ,T ,94 ,11
002972 ,003732 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,3 ,6 ,3 ,5 ,T ,94 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,4 ,5 ,1 ,4 ,T ,94 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,6 ,1 ,8 ,T ,94 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,10 ,6 ,1 ,6 ,T ,94 ,16
002976 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,25 ,7 ,4 ,2 ,3 ,F ,94 ,14
002981 ,002944 ,002906 ,  ,  ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,4 ,3 ,4 ,5 ,F ,94 ,16
  ,  ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,3 ,1 ,1 ,3 ,T ,94 ,12
002974 ,  ,  ,  ,  ,1 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,1 ,6 ,2 ,3 ,F ,94 ,17
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,5 ,1 ,6 ,F ,94 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,5 ,3 ,1 ,3 ,T ,94 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,1 ,. ,5 ,3 ,1 ,6 ,T ,94 ,14
002975 ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,15 ,5 ,5 ,2 ,5 ,F ,94 ,14
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,7 ,5 ,1 ,6 ,F ,94 ,13
003042 ,007693 ,001580 ,001036 ,001961 ,3 ,2 ,1 ,2 ,0 ,0 ,0 ,1 ,0 ,0 ,10 ,10 ,4 ,1 ,7 ,T ,94 ,15
009224 ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,9 ,. ,8 ,2 ,6 ,F ,94 ,19
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,10 ,8 ,5 ,1 ,6 ,F ,94 ,16
002976 ,002975 ,  ,  ,  ,4 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,6 ,3 ,8 ,F ,94 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,5 ,5 ,1 ,3 ,T ,94 ,12
  ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,30 ,5 ,5 ,1 ,5 ,T ,94 ,12
002981 ,002984 ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,6 ,3 ,6 ,F ,94 ,14
002941 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,30 ,7 ,5 ,2 ,3 ,T ,94 ,13
002948 ,  ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,24 ,9 ,5 ,2 ,3 ,T ,94 ,16
003432 ,003448 ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,8 ,6 ,3 ,6 ,F ,94 ,17
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,. ,. ,3 ,1 ,3 ,F ,94 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,8 ,6 ,1 ,5 ,F ,94 ,17
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,6 ,1 ,5 ,F ,94 ,17
003427 ,002944 ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,15 ,2 ,3 ,3 ,3 ,F ,94 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,10 ,5 ,1 ,8 ,F ,94 ,15
001830 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,5 ,2 ,5 ,F ,94 ,15
  ,  ,  ,  ,  ,4 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,6 ,1 ,6 ,F ,94 ,15
004033 ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,10 ,8 ,2 ,8 ,T ,94 ,4
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,1 ,1 ,1 ,1 ,F ,94 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,4 ,3 ,1 ,3 ,T ,94 ,16
  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,3 ,1 ,3 ,F ,94 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,5 ,1 ,6 ,F ,94 ,14
  ,  ,  ,  ,  ,2 ,2 ,3 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,10 ,8 ,1 ,8 ,T ,94 ,15
002974 ,  ,  ,  ,  ,2 ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,10 ,3 ,2 ,4 ,T ,94 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,3 ,6 ,1 ,7 ,T ,94 ,17
001739 ,002155 ,002978 ,002950 ,002974 ,3 ,1 ,3 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,3 ,6 ,5 ,3 ,F ,94 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,10 ,1 ,4 ,1 ,3 ,T ,94 ,17
002912 ,002981 ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,7 ,4 ,3 ,3 ,F ,94 ,15
002974 ,002906 ,001564 ,002939 ,  ,1 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,25 ,2 ,5 ,5 ,5 ,T ,94 ,15
003428 ,002931 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,10 ,5 ,3 ,5 ,F ,94 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,. ,. ,6 ,1 ,6 ,T ,94 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,3 ,2 ,1 ,2 ,T ,94 ,7
002972 ,  ,  ,  ,  ,1 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,7 ,4 ,2 ,3 ,T ,94 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,5 ,3 ,1 ,4 ,T ,94 ,13
  ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,25 ,4 ,2 ,1 ,3 ,T ,94 ,14
002975 ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,14 ,9 ,6 ,2 ,6 ,F ,94 ,16
002949 ,002916 ,002954 ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,5 ,4 ,4 ,F ,94 ,15
029258 ,  ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,17 ,7 ,5 ,2 ,5 ,T ,94 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,12 ,9 ,5 ,1 ,6 ,F ,94 ,16
  ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,10 ,6 ,1 ,8 ,T ,94 ,12
011385 ,003704 ,  ,  ,  ,4 ,1 ,3 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,10 ,7 ,8 ,3 ,8 ,F ,94 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,1 ,5 ,T ,94 ,14
  ,  ,  ,  ,  ,2 ,1 ,  ,1 ,1 ,0 ,1 ,0 ,0 ,1 ,. ,3 ,3 ,1 ,3 ,T ,94 ,13
002974 ,  ,  ,  ,  ,4 ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,3 ,5 ,2 ,8 ,F ,94 ,17
002972 ,002984 ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,7 ,6 ,3 ,6 ,F ,94 ,16
  ,  ,  ,  ,  ,4 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,5 ,1 ,3 ,F ,94 ,13
002906 ,001415 ,  ,  ,  ,5 ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,. ,10 ,6 ,3 ,8 ,F ,94 ,15
001891 ,002923 ,  ,  ,  ,1 ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,3 ,4 ,3 ,4 ,F ,94 ,16
002906 ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,2 ,3 ,F ,94 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,15 ,5 ,5 ,1 ,5 ,F ,94 ,13
002906 ,002949 ,002955 ,002933 ,  ,2 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,. ,6 ,5 ,6 ,F ,94 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,10 ,7 ,5 ,1 ,2 ,T ,94 ,17
002976 ,  ,  ,  ,  ,1 ,  ,1 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,4 ,3 ,2 ,3 ,F ,94 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,12 ,9 ,6 ,1 ,8 ,T ,94 ,17
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,4 ,5 ,1 ,3 ,T ,94 ,14
  ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,4 ,5 ,1 ,3 ,T ,94 ,13
010313 ,002981 ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,8 ,5 ,3 ,3 ,T ,94 ,13
002906 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,7 ,4 ,2 ,4 ,T ,94 ,14
001554 ,001598 ,001857 ,002981 ,  ,2 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,3 ,4 ,1 ,F ,94 ,17
002981 ,002944 ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,8 ,3 ,3 ,3 ,T ,94 ,15
002944 ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,7 ,6 ,2 ,5 ,F ,94 ,14
001479 ,002974 ,005449 ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,. ,5 ,4 ,6 ,F ,94 ,16
002976 ,002906 ,  ,  ,  ,3 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,6 ,3 ,6 ,F ,94 ,12
010392 ,002981 ,002974 ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,17 ,3 ,3 ,4 ,4 ,F ,94 ,16
002906 ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,9 ,10 ,8 ,2 ,7 ,F ,94 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,10 ,10 ,3 ,1 ,4 ,F ,94 ,15
002945 ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,4 ,2 ,7 ,F ,94 ,17
  ,  ,  ,  ,  ,1 ,  ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,5 ,3 ,1 ,3 ,T ,94 ,14
003713 ,002975 ,002976 ,  ,  ,3 ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,9 ,6 ,3 ,6 ,T ,94 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,1 ,3 ,1 ,5 ,T ,94 ,4
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,6 ,3 ,1 ,3 ,T ,94 ,4
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,8 ,10 ,3 ,1 ,3 ,T ,94 ,10
002976 ,002923 ,002906 ,002974 ,  ,5 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,4 ,5 ,8 ,T ,94 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,3 ,1 ,5 ,T ,94 ,8
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,27 ,9 ,5 ,1 ,6 ,T ,94 ,14
002944 ,002981 ,004033 ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,40 ,1 ,2 ,4 ,1 ,T ,94 ,5
003425 ,  ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,27 ,5 ,5 ,2 ,5 ,T ,94 ,13
  ,  ,  ,  ,  ,2 ,  ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,5 ,6 ,1 ,6 ,T ,94 ,17
001582 ,002936 ,002968 ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,1 ,5 ,4 ,. ,F ,94 ,16
002972 ,002906 ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,8 ,. ,6 ,3 ,6 ,F ,94 ,16
004033 ,  ,  ,  ,  ,4 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,12 ,5 ,5 ,2 ,6 ,F ,94 ,5
002976 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,0 ,0 ,0 ,1 ,1 ,0 ,20 ,2 ,5 ,2 ,5 ,T ,94 ,12
001569 ,009224 ,002974 ,002972 ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,3 ,5 ,3 ,F ,94 ,16
003425 ,002927 ,002945 ,  ,  ,5 ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,8 ,6 ,4 ,6 ,F ,94 ,14
002972 ,003434 ,001569 ,  ,  ,1 ,1 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,10 ,5 ,4 ,4 ,3 ,F ,94 ,18
002906 ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,4 ,2 ,8 ,F ,94 ,15
002945 ,002974 ,002976 ,003705 ,002981 ,2 ,3 ,2 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,17 ,2 ,5 ,6 ,3 ,F ,94 ,18
002974 ,001598 ,  ,  ,  ,5 ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,7 ,8 ,3 ,6 ,F ,94 ,14
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,17 ,10 ,4 ,1 ,6 ,T ,94 ,14
002981 ,  ,  ,  ,  ,4 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,14 ,8 ,3 ,2 ,5 ,F ,94 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,10 ,. ,4 ,1 ,3 ,F ,94 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,17 ,9 ,8 ,1 ,8 ,F ,94 ,16
002975 ,002981 ,  ,  ,  ,2 ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,30 ,7 ,5 ,3 ,4 ,T ,94 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,6 ,1 ,2 ,T ,94 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,30 ,10 ,7 ,1 ,8 ,T ,94 ,14
002974 ,002976 ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,6 ,5 ,3 ,3 ,F ,94 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,25 ,9 ,3 ,1 ,3 ,T ,94 ,14
003875 ,002906 ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,9 ,3 ,3 ,3 ,F ,94 ,14
003981 ,002976 ,002906 ,  ,  ,3 ,3 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,3 ,4 ,3 ,F ,94 ,15
022944 ,002929 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,4 ,5 ,3 ,1 ,F ,94 ,15
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,7 ,5 ,1 ,3 ,F ,94 ,15
  ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,5 ,5 ,1 ,3 ,F ,94 ,14
012448 ,  ,  ,  ,  ,3 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,5 ,3 ,2 ,6 ,F ,94 ,16
001598 ,001546 ,001572 ,002949 ,002913 ,4 ,3 ,3 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,7 ,5 ,6 ,5 ,F ,94 ,16
002981 ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,10 ,7 ,3 ,2 ,2 ,F ,94 ,18
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,15 ,6 ,3 ,1 ,2 ,T ,94 ,15
002944 ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,6 ,2 ,6 ,F ,94 ,15
002923 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,3 ,3 ,2 ,3 ,F ,94 ,13
002984 ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,2 ,5 ,2 ,5 ,F ,94 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,. ,6 ,1 ,5 ,T ,94 ,16
  ,  ,  ,  ,  ,1 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,32 ,2 ,4 ,1 ,3 ,F ,94 ,13
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,17 ,9 ,5 ,1 ,6 ,T ,94 ,15
002929 ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,3 ,5 ,2 ,2 ,T ,94 ,15
002984 ,002981 ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,12 ,6 ,5 ,3 ,5 ,F ,94 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,4 ,5 ,1 ,8 ,T ,94 ,19
002906 ,002923 ,  ,  ,  ,  ,  ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,5 ,3 ,6 ,T ,94 ,12
002944 ,  ,  ,  ,  ,2 ,1 ,  ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,. ,2 ,2 ,2 ,T ,94 ,13
  ,  ,  ,  ,  ,3 ,  ,1 ,  ,0 ,0 ,1 ,0 ,0 ,0 ,. ,10 ,8 ,1 ,8 ,T ,94 ,16
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,1 ,3 ,1 ,3 ,T ,94 ,12
002010 ,002005 ,002984 ,  ,  ,5 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,8 ,4 ,8 ,F ,94 ,15
003713 ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,7 ,2 ,6 ,F ,94 ,15
002976 ,  ,  ,  ,  ,5 ,3 ,1 ,  ,0 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,8 ,2 ,8 ,F ,94 ,13
  ,  ,  ,  ,  ,5 ,  ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,47 ,8 ,3 ,1 ,4 ,T ,94 ,3
002905 ,003428 ,003448 ,003754 ,  ,5 ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,12 ,9 ,4 ,5 ,4 ,F ,94 ,13
002976 ,002975 ,002972 ,  ,  ,1 ,3 ,3 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,6 ,6 ,3 ,5 ,F ,94 ,12
002927 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,10 ,5 ,2 ,6 ,F ,94 ,12
002974 ,002984 ,002972 ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,10 ,3 ,4 ,4 ,F ,94 ,14
  ,  ,  ,  ,  ,4 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,6 ,1 ,5 ,F ,94 ,16
002981 ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,3 ,2 ,5 ,T ,94 ,16
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,35 ,4 ,3 ,1 ,2 ,T ,94 ,12
002981 ,002906 ,002967 ,003431 ,  ,2 ,1 ,1 ,  ,1 ,1 ,0 ,0 ,1 ,0 ,. ,7 ,6 ,5 ,5 ,F ,94 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,15 ,8 ,7 ,1 ,5 ,F ,94 ,16
002945 ,002906 ,002981 ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,6 ,4 ,6 ,F ,94 ,15
002974 ,002913 ,  ,  ,  ,2 ,2 ,3 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,3 ,3 ,6 ,F ,94 ,14
002972 ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,16 ,9 ,3 ,2 ,4 ,F ,94 ,17
002906 ,002976 ,004033 ,  ,  ,3 ,2 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,. ,6 ,4 ,6 ,F ,94 ,14
002974 ,  ,  ,  ,  ,2 ,2 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,30 ,10 ,6 ,1 ,8 ,T ,94 ,10
  ,  ,  ,  ,  ,2 ,2 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,6 ,3 ,1 ,5 ,F ,94 ,14
002906 ,  ,  ,  ,  ,1 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,5 ,2 ,3 ,F ,94 ,17
002972 ,004033 ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,3 ,3 ,5 ,F ,94 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,16 ,8 ,3 ,1 ,6 ,T ,94 ,12
002976 ,  ,  ,  ,  ,1 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,6 ,5 ,2 ,3 ,F ,94 ,12
002981 ,002944 ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,8 ,3 ,6 ,F ,94 ,15
002944 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,6 ,1 ,3 ,T ,94 ,17
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,17 ,4 ,8 ,1 ,2 ,T ,94 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,7 ,4 ,1 ,5 ,T ,94 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,12 ,5 ,2 ,1 ,4 ,F ,94 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,10 ,6 ,4 ,1 ,4 ,T ,94 ,18
002974 ,  ,  ,  ,  ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,7 ,2 ,8 ,T ,94 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,15 ,5 ,3 ,1 ,5 ,F ,94 ,16
001891 ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,23 ,8 ,4 ,2 ,3 ,F ,94 ,15
002984 ,002906 ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,5 ,3 ,3 ,5 ,F ,94 ,15
002974 ,002972 ,002981 ,  ,  ,2 ,3 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,1 ,2 ,4 ,4 ,F ,94 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,9 ,5 ,1 ,3 ,T ,94 ,7
  ,  ,  ,  ,  ,1 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,45 ,4 ,5 ,1 ,8 ,T ,94 ,3
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,7 ,2 ,1 ,2 ,T ,94 ,5
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,16 ,5 ,4 ,1 ,4 ,F ,94 ,13
002972 ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,5 ,3 ,2 ,6 ,F ,94 ,16
002906 ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,5 ,7 ,2 ,6 ,F ,94 ,14
002974 ,002906 ,002978 ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,6 ,4 ,6 ,F ,94 ,15
002975 ,002972 ,003448 ,003425 ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,8 ,5 ,6 ,F ,94 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,3 ,3 ,1 ,3 ,T ,94 ,13
002905 ,  ,  ,  ,  ,5 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,6 ,5 ,2 ,5 ,F ,94 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,2 ,5 ,1 ,2 ,F ,94 ,15
002974 ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,7 ,1 ,6 ,T ,94 ,15
003721 ,003736 ,002984 ,  ,  ,4 ,1 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,5 ,4 ,4 ,F ,94 ,16
001328 ,003428 ,  ,  ,  ,1 ,  ,2 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,3 ,3 ,4 ,F ,94 ,16
001569 ,002974 ,  ,  ,  ,3 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,6 ,6 ,3 ,6 ,F ,94 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,4 ,6 ,1 ,3 ,T ,94 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,17 ,7 ,2 ,1 ,5 ,T ,94 ,11
002918 ,002978 ,  ,  ,  ,3 ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,17 ,5 ,6 ,3 ,6 ,F ,94 ,15
002974 ,002976 ,002906 ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,10 ,10 ,8 ,4 ,8 ,F ,94 ,15
002906 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,5 ,2 ,5 ,F ,94 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,23 ,7 ,4 ,1 ,2 ,F ,94 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,6 ,1 ,6 ,T ,94 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,. ,4 ,1 ,4 ,T ,94 ,14
002981 ,002906 ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,3 ,3 ,3 ,F ,94 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,. ,7 ,5 ,1 ,6 ,F ,94 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,9 ,6 ,1 ,8 ,T ,94 ,15
002913 ,002981 ,002974 ,  ,  ,4 ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,10 ,9 ,5 ,4 ,. ,F ,94 ,15
002906 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,5 ,2 ,5 ,F ,94 ,14
002960 ,003496 ,002974 ,  ,  ,1 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,10 ,9 ,3 ,4 ,4 ,F ,94 ,15
002710 ,  ,  ,  ,  ,2 ,2 ,2 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,25 ,3 ,7 ,2 ,6 ,T ,94 ,14
002923 ,  ,  ,  ,  ,2 ,2 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,34 ,2 ,3 ,1 ,3 ,T ,94 ,12
002906 ,003425 ,  ,  ,  ,5 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,8 ,3 ,8 ,F ,94 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,8 ,5 ,1 ,5 ,F ,94 ,17
004033 ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,15 ,6 ,3 ,2 ,4 ,F ,94 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,. ,3 ,1 ,5 ,T ,94 ,16
002945 ,  ,  ,  ,  ,1 ,1 ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,30 ,10 ,2 ,2 ,5 ,T ,94 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,15 ,10 ,3 ,1 ,5 ,T ,94 ,12
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,15 ,3 ,4 ,1 ,5 ,F ,94 ,16
002923 ,002981 ,002944 ,002914 ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,5 ,5 ,5 ,3 ,F ,94 ,15
002974 ,002972 ,002981 ,  ,  ,2 ,1 ,2 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,17 ,7 ,3 ,4 ,3 ,F ,94 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,. ,5 ,1 ,6 ,T ,94 ,16
002975 ,002972 ,002984 ,  ,  ,5 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,5 ,3 ,7 ,F ,94 ,13
003815 ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,6 ,2 ,7 ,F ,94 ,14
002981 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,10 ,3 ,2 ,3 ,T ,94 ,12
  ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,10 ,1 ,2 ,1 ,2 ,T ,94 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,18 ,10 ,3 ,1 ,5 ,T ,94 ,15
002906 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,12 ,8 ,4 ,2 ,3 ,F ,94 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,8 ,4 ,1 ,. ,T ,94 ,15
002923 ,002967 ,  ,  ,  ,1 ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,10 ,5 ,3 ,3 ,3 ,F ,94 ,14
002984 ,002972 ,  ,  ,  ,1 ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,6 ,5 ,3 ,2 ,F ,94 ,12
  ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,6 ,1 ,. ,F ,94 ,13
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,30 ,4 ,5 ,1 ,5 ,T ,94 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,27 ,4 ,3 ,1 ,3 ,T ,94 ,10
002981 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,17 ,7 ,6 ,2 ,7 ,T ,94 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,3 ,1 ,3 ,F ,94 ,15
002944 ,002981 ,004033 ,  ,  ,1 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,5 ,3 ,4 ,3 ,F ,94 ,14
  ,  ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,30 ,1 ,5 ,1 ,. ,F ,94 ,12
002905 ,002972 ,002928 ,002923 ,  ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,6 ,4 ,4 ,4 ,F ,94 ,12
009224 ,  ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,40 ,5 ,4 ,2 ,3 ,T ,94 ,8
002974 ,002906 ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,3 ,5 ,F ,94 ,17
002979 ,002976 ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,11 ,10 ,4 ,3 ,8 ,F ,94 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,4 ,5 ,1 ,5 ,T ,94 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,25 ,5 ,6 ,1 ,3 ,T ,94 ,8
002906 ,002981 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,5 ,3 ,5 ,F ,94 ,15
002976 ,002975 ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,12 ,5 ,4 ,3 ,6 ,F ,94 ,15
  ,  ,  ,  ,  ,1 ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,. ,7 ,5 ,1 ,4 ,T ,94 ,16
002974 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,0 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,7 ,2 ,5 ,T ,94 ,14
002981 ,002972 ,002974 ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,8 ,5 ,4 ,3 ,F ,94 ,15
002972 ,002975 ,  ,  ,  ,3 ,3 ,1 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,5 ,3 ,6 ,F ,94 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,6 ,6 ,1 ,7 ,F ,94 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,23 ,3 ,3 ,1 ,6 ,T ,94 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,4 ,6 ,1 ,5 ,F ,94 ,16
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,4 ,3 ,1 ,3 ,F ,94 ,17
002920 ,002978 ,002974 ,002905 ,  ,3 ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,8 ,5 ,8 ,F ,94 ,18
  ,  ,  ,  ,  ,4 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,4 ,8 ,1 ,6 ,T ,94 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,3 ,1 ,5 ,F ,94 ,16
002981 ,002906 ,002972 ,002923 ,  ,1 ,3 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,10 ,6 ,5 ,3 ,F ,94 ,16
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,9 ,5 ,1 ,5 ,F ,94 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,5 ,3 ,1 ,3 ,T ,94 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,2 ,2 ,1 ,6 ,T ,94 ,12
003423 ,002914 ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,12 ,10 ,6 ,3 ,6 ,T ,94 ,14
  ,  ,  ,  ,  ,3 ,1 ,  ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,3 ,1 ,6 ,T ,94 ,12
002974 ,003448 ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,8 ,3 ,6 ,F ,94 ,14
002927 ,002906 ,  ,  ,  ,4 ,3 ,2 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,4 ,3 ,7 ,F ,94 ,15
002976 ,002906 ,  ,  ,  ,4 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,3 ,8 ,F ,94 ,16
002975 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,25 ,2 ,3 ,2 ,5 ,F ,94 ,15
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,6 ,4 ,1 ,3 ,F ,94 ,17
002972 ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,8 ,3 ,2 ,3 ,F ,94 ,16
002984 ,002923 ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,5 ,3 ,7 ,F ,94 ,16
003535 ,002929 ,002974 ,  ,  ,4 ,1 ,3 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,5 ,7 ,4 ,6 ,F ,94 ,18
002974 ,002976 ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,10 ,3 ,1 ,3 ,1 ,F ,94 ,16
002906 ,  ,  ,  ,  ,3 ,3 ,1 ,  ,1 ,0 ,1 ,1 ,0 ,0 ,. ,. ,5 ,2 ,5 ,T ,94 ,13
008155 ,003737 ,003711 ,  ,  ,5 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,. ,9 ,5 ,4 ,8 ,F ,94 ,14
002975 ,002984 ,003530 ,003487 ,002972 ,2 ,2 ,3 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,6 ,6 ,4 ,F ,94 ,14
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,8 ,1 ,8 ,F ,94 ,11
003370 ,003434 ,  ,  ,  ,4 ,2 ,3 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,30 ,7 ,3 ,3 ,5 ,F ,94 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,  ,1 ,1 ,0 ,0 ,1 ,0 ,. ,3 ,3 ,1 ,3 ,T ,94 ,18
002979 ,  ,  ,  ,  ,5 ,3 ,1 ,  ,0 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,8 ,2 ,6 ,F ,94 ,13
  ,  ,  ,  ,  ,1 ,2 ,3 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,14 ,1 ,5 ,1 ,5 ,T ,94 ,16
001594 ,002905 ,002928 ,002950 ,001448 ,3 ,1 ,3 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,40 ,7 ,4 ,7 ,4 ,F ,94 ,15
002906 ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,10 ,3 ,2 ,3 ,F ,94 ,15
  ,  ,  ,  ,  ,3 ,  ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,5 ,6 ,1 ,8 ,F ,94 ,17
002972 ,  ,  ,  ,  ,2 ,  ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,4 ,3 ,2 ,5 ,F ,94 ,17
002906 ,002974 ,011693 ,  ,  ,4 ,3 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,6 ,4 ,8 ,F ,94 ,16
006968 ,003530 ,002975 ,002972 ,002974 ,2 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,13 ,9 ,6 ,8 ,6 ,F ,94 ,14
002906 ,002975 ,002976 ,002981 ,  ,5 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,25 ,9 ,3 ,5 ,3 ,F ,94 ,12
002981 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,8 ,4 ,2 ,3 ,F ,94 ,17
002906 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,7 ,3 ,2 ,3 ,F ,94 ,16
  ,  ,  ,  ,  ,  ,  ,1 ,  ,1 ,1 ,0 ,0 ,1 ,0 ,. ,7 ,6 ,1 ,3 ,F ,94 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,12 ,6 ,6 ,2 ,3 ,F ,94 ,15
002974 ,002972 ,002906 ,002976 ,  ,2 ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,10 ,6 ,4 ,6 ,F ,94 ,16
002972 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,12 ,9 ,2 ,2 ,6 ,F ,94 ,15
002944 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,. ,6 ,2 ,3 ,F ,94 ,14
002972 ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,3 ,2 ,3 ,F ,94 ,14
002906 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,20 ,. ,3 ,2 ,1 ,F ,94 ,15
002981 ,001572 ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,25 ,10 ,6 ,3 ,8 ,F ,94 ,16
002906 ,001801 ,  ,  ,  ,5 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,. ,10 ,6 ,3 ,6 ,F ,94 ,14
002968 ,002972 ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,4 ,3 ,3 ,3 ,T ,94 ,12
002929 ,002914 ,002985 ,002975 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,6 ,5 ,6 ,F ,94 ,15
  ,  ,  ,  ,  ,4 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,5 ,3 ,1 ,3 ,T ,94 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,5 ,3 ,1 ,3 ,T ,94 ,7
002968 ,002950 ,002981 ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,25 ,3 ,5 ,4 ,5 ,F ,94 ,12
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,0 ,0 ,1 ,0 ,1 ,0 ,15 ,10 ,4 ,1 ,6 ,T ,94 ,16
002906 ,002975 ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,6 ,3 ,3 ,2 ,F ,94 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,6 ,5 ,1 ,3 ,F ,94 ,18
002974 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,7 ,5 ,2 ,5 ,F ,94 ,13
002976 ,002981 ,003432 ,  ,  ,3 ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,15 ,8 ,3 ,4 ,6 ,F ,94 ,18
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,6 ,3 ,1 ,2 ,T ,94 ,14
002906 ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,8 ,2 ,8 ,F ,94 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,3 ,1 ,3 ,F ,94 ,13
002906 ,002913 ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,5 ,5 ,3 ,3 ,F ,94 ,15
002975 ,002923 ,002981 ,002906 ,002976 ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,8 ,7 ,8 ,6 ,8 ,F ,94 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,25 ,5 ,3 ,1 ,6 ,F ,94 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,5 ,7 ,1 ,6 ,T ,94 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,5 ,3 ,1 ,3 ,T ,94 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,7 ,5 ,1 ,3 ,F ,94 ,15
002906 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,3 ,6 ,2 ,5 ,F ,94 ,15
002906 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,5 ,2 ,6 ,F ,94 ,16
002972 ,001598 ,002975 ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,4 ,8 ,F ,94 ,15
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,10 ,9 ,6 ,1 ,6 ,T ,94 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,4 ,5 ,1 ,6 ,T ,94 ,12
002929 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,10 ,6 ,6 ,4 ,2 ,F ,94 ,15
002905 ,  ,  ,  ,  ,3 ,3 ,2 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,20 ,8 ,3 ,2 ,5 ,T ,94 ,13
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,4 ,5 ,1 ,3 ,T ,94 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,3 ,1 ,3 ,T ,94 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,8 ,5 ,1 ,5 ,F ,94 ,16
  ,  ,  ,  ,  ,1 ,2 ,  ,2 ,1 ,1 ,0 ,1 ,0 ,1 ,. ,9 ,3 ,1 ,3 ,T ,94 ,12
002981 ,002906 ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,3 ,2 ,8 ,T ,94 ,16
  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,7 ,3 ,1 ,5 ,T ,94 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,10 ,3 ,1 ,6 ,F ,94 ,8
002906 ,002974 ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,. ,6 ,2 ,8 ,T ,94 ,14
002974 ,  ,  ,  ,  ,1 ,3 ,2 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,8 ,2 ,2 ,5 ,F ,94 ,15
002974 ,002906 ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,5 ,5 ,3 ,5 ,F ,94 ,16
004033 ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,20 ,8 ,5 ,2 ,5 ,F ,94 ,13
002906 ,002981 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,3 ,3 ,3 ,3 ,F ,94 ,16
002984 ,  ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,8 ,6 ,2 ,4 ,F ,94 ,16
002707 ,  ,  ,  ,  ,3 ,3 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,5 ,2 ,5 ,F ,94 ,15
002981 ,003445 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,6 ,3 ,8 ,F ,94 ,15
002976 ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,8 ,8 ,3 ,2 ,5 ,F ,94 ,13
003530 ,002972 ,  ,  ,  ,5 ,3 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,5 ,3 ,5 ,F ,94 ,13
  ,  ,  ,  ,  ,1 ,2 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,25 ,. ,5 ,1 ,6 ,T ,94 ,17
002931 ,  ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,18 ,1 ,3 ,2 ,4 ,F ,94 ,13
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,8 ,3 ,7 ,1 ,6 ,F ,94 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,6 ,1 ,8 ,T ,94 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,25 ,9 ,6 ,1 ,3 ,T ,94 ,13
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,25 ,6 ,3 ,1 ,6 ,T ,94 ,4
009224 ,  ,  ,  ,  ,3 ,3 ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,20 ,1 ,4 ,2 ,4 ,F ,94 ,14
002981 ,  ,  ,  ,  ,4 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,55 ,2 ,8 ,2 ,3 ,T ,94 ,8
002906 ,002929 ,009226 ,  ,  ,3 ,  ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,6 ,4 ,6 ,F ,94 ,13
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,10 ,6 ,1 ,4 ,T ,94 ,8
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,15 ,6 ,5 ,1 ,5 ,F ,94 ,15
002978 ,002976 ,  ,  ,  ,5 ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,9 ,5 ,3 ,3 ,3 ,F ,94 ,15
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,15 ,3 ,5 ,1 ,5 ,F ,94 ,13
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,. ,5 ,1 ,6 ,T ,94 ,15
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,12 ,7 ,3 ,1 ,3 ,T ,94 ,17
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,5 ,5 ,1 ,5 ,T ,94 ,4
009226 ,  ,  ,  ,  ,1 ,  ,1 ,2 ,0 ,0 ,1 ,1 ,1 ,1 ,. ,8 ,6 ,2 ,5 ,F ,94 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,  ,1 ,1 ,1 ,0 ,1 ,0 ,. ,6 ,8 ,1 ,3 ,F ,94 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,15 ,10 ,8 ,1 ,8 ,T ,94 ,16
002906 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,15 ,7 ,6 ,2 ,3 ,T ,94 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,15 ,8 ,3 ,1 ,2 ,T ,94 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,4 ,6 ,1 ,8 ,F ,94 ,11
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,7 ,5 ,1 ,6 ,F ,94 ,14
  ,  ,  ,  ,  ,4 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,7 ,1 ,8 ,F ,94 ,16
002975 ,002981 ,002941 ,002985 ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,5 ,5 ,3 ,F ,94 ,16
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,8 ,8 ,1 ,8 ,F ,94 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,30 ,7 ,2 ,1 ,4 ,T ,94 ,14
002944 ,002981 ,  ,  ,  ,2 ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,25 ,1 ,5 ,3 ,3 ,F ,94 ,15
002944 ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,8 ,8 ,2 ,4 ,T ,94 ,14
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,. ,5 ,1 ,3 ,T ,94 ,12
002927 ,002906 ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,6 ,5 ,3 ,5 ,F ,94 ,18
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,10 ,10 ,5 ,1 ,8 ,T ,94 ,12
002981 ,002906 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,3 ,3 ,4 ,F ,94 ,16
002981 ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,3 ,3 ,2 ,5 ,F ,94 ,12
002976 ,002906 ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,7 ,3 ,3 ,3 ,F ,94 ,18
002976 ,002927 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,10 ,4 ,3 ,3 ,F ,94 ,16
002976 ,002984 ,002906 ,  ,  ,3 ,1 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,5 ,4 ,5 ,F ,94 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,3 ,6 ,1 ,6 ,T ,94 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,8 ,6 ,1 ,8 ,F ,94 ,15
003487 ,002906 ,002923 ,  ,  ,2 ,  ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,3 ,4 ,3 ,T ,94 ,15
001513 ,010392 ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,4 ,6 ,2 ,6 ,F ,94 ,14
002984 ,002929 ,  ,  ,  ,5 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,6 ,3 ,6 ,F ,94 ,16
002974 ,002923 ,  ,  ,  ,4 ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,2 ,3 ,3 ,6 ,F ,94 ,16
002972 ,002906 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,6 ,3 ,2 ,F ,94 ,12
002974 ,002976 ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,6 ,3 ,5 ,T ,94 ,14
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,0 ,0 ,1 ,1 ,1 ,0 ,16 ,6 ,5 ,1 ,6 ,T ,94 ,18
  ,  ,  ,  ,  ,2 ,1 ,1 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,1 ,3 ,1 ,5 ,F ,94 ,15
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,27 ,9 ,8 ,1 ,6 ,F ,94 ,13
003692 ,002972 ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,12 ,8 ,4 ,3 ,3 ,F ,94 ,16
002981 ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,18 ,4 ,3 ,2 ,2 ,F ,94 ,17
002972 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,4 ,4 ,2 ,6 ,F ,94 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,9 ,6 ,1 ,6 ,T ,94 ,19
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,10 ,5 ,1 ,6 ,T ,94 ,12
001444 ,002974 ,001328 ,002976 ,003946 ,3 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,3 ,8 ,7 ,5 ,F ,94 ,17
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,5 ,3 ,1 ,3 ,F ,94 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,  ,1 ,0 ,0 ,1 ,0 ,0 ,. ,9 ,7 ,1 ,6 ,T ,94 ,14
003431 ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,5 ,2 ,8 ,T ,94 ,15
002972 ,002923 ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,10 ,4 ,4 ,3 ,6 ,F ,94 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,8 ,1 ,8 ,T ,94 ,12
001489 ,002105 ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,25 ,10 ,4 ,3 ,8 ,T ,94 ,18
002981 ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,5 ,7 ,2 ,5 ,T ,94 ,11
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,8 ,6 ,1 ,5 ,T ,94 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,8 ,8 ,1 ,8 ,T ,94 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,14 ,9 ,3 ,1 ,3 ,F ,94 ,14
003425 ,002985 ,002954 ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,7 ,3 ,8 ,F ,94 ,14
002974 ,002975 ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,10 ,8 ,4 ,3 ,6 ,F ,94 ,15
002974 ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,5 ,3 ,2 ,3 ,F ,94 ,16
003448 ,003425 ,002957 ,  ,  ,3 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,6 ,4 ,5 ,F ,94 ,13
003457 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,3 ,6 ,2 ,2 ,F ,94 ,14
003125 ,  ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,8 ,6 ,2 ,3 ,F ,94 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,1 ,6 ,T ,94 ,16
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,10 ,7 ,1 ,8 ,F ,94 ,16
  ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,5 ,10 ,6 ,1 ,8 ,T ,94 ,5
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,3 ,1 ,1 ,T ,94 ,11
001793 ,999999 ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,10 ,8 ,3 ,8 ,T ,94 ,15
002130 ,  ,  ,  ,  ,3 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,3 ,2 ,6 ,F ,94 ,15
001569 ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,6 ,2 ,6 ,F ,94 ,13
002976 ,002981 ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,8 ,8 ,3 ,3 ,4 ,F ,94 ,15
002976 ,002981 ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,8 ,7 ,3 ,3 ,6 ,F ,94 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,35 ,8 ,3 ,1 ,3 ,T ,94 ,18
002981 ,004033 ,009684 ,  ,  ,5 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,20 ,10 ,5 ,4 ,8 ,T ,94 ,8
002974 ,002972 ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,1 ,0 ,. ,4 ,6 ,3 ,6 ,F ,94 ,14
002920 ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,9 ,8 ,2 ,6 ,F ,94 ,15
001598 ,  ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,15 ,10 ,6 ,2 ,8 ,F ,94 ,15
002981 ,002974 ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,. ,6 ,3 ,6 ,F ,94 ,15
001577 ,007893 ,001586 ,  ,  ,4 ,1 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,10 ,3 ,3 ,6 ,F ,94 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,. ,3 ,1 ,3 ,F ,94 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,20 ,. ,3 ,1 ,8 ,T ,94 ,7
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,0 ,0 ,1 ,1 ,1 ,0 ,10 ,. ,5 ,1 ,3 ,T ,94 ,15
001535 ,001537 ,002974 ,001448 ,  ,4 ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,17 ,6 ,3 ,4 ,6 ,T ,94 ,12
001531 ,003827 ,003051 ,003954 ,  ,5 ,  ,2 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,10 ,5 ,5 ,8 ,T ,94 ,15
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,35 ,6 ,5 ,1 ,3 ,T ,94 ,12
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,9 ,3 ,1 ,8 ,F ,94 ,14
002906 ,002929 ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,9 ,5 ,3 ,5 ,F ,94 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,3 ,1 ,1 ,T ,94 ,18
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,6 ,3 ,1 ,3 ,T ,94 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,6 ,1 ,6 ,T ,94 ,14
002981 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,10 ,6 ,2 ,8 ,F ,94 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,7 ,5 ,1 ,3 ,T ,94 ,15
001535 ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,3 ,7 ,2 ,6 ,T ,94 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,9 ,2 ,1 ,2 ,F ,94 ,14
004033 ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,3 ,2 ,5 ,F ,94 ,12
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,9 ,4 ,1 ,7 ,T ,94 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,23 ,10 ,7 ,1 ,8 ,T ,94 ,21
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,. ,. ,5 ,1 ,2 ,F ,94 ,16
002972 ,  ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,4 ,5 ,1 ,5 ,F ,94 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,2 ,5 ,1 ,6 ,T ,94 ,14
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,2 ,2 ,1 ,3 ,F ,94 ,14
002906 ,002979 ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,5 ,3 ,5 ,T ,94 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,32 ,10 ,3 ,1 ,3 ,F ,94 ,7
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,25 ,10 ,7 ,1 ,6 ,T ,94 ,13
002975 ,002974 ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,15 ,7 ,3 ,3 ,3 ,F ,94 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,7 ,3 ,1 ,5 ,F ,94 ,14
001825 ,001535 ,001537 ,999999 ,002542 ,5 ,3 ,3 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,10 ,7 ,6 ,7 ,6 ,F ,94 ,13
003529 ,003359 ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,8 ,3 ,8 ,F ,94 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,3 ,1 ,3 ,F ,94 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,7 ,2 ,1 ,2 ,T ,94 ,11
002948 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,1 ,1 ,1 ,T ,94 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,1 ,1 ,1 ,1 ,T ,94 ,8
002976 ,  ,  ,  ,  ,3 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,6 ,2 ,8 ,F ,94 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,10 ,. ,3 ,1 ,3 ,T ,94 ,9
002095 ,003100 ,001793 ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,8 ,4 ,8 ,T ,94 ,19
001564 ,001809 ,  ,  ,  ,5 ,3 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,8 ,8 ,3 ,3 ,6 ,F ,94 ,17
002984 ,002974 ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,20 ,5 ,6 ,3 ,6 ,F ,94 ,16
002920 ,002974 ,003535 ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,4 ,4 ,3 ,F ,94 ,16
002972 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,0 ,1 ,1 ,1 ,1 ,0 ,30 ,3 ,3 ,2 ,5 ,F ,94 ,16
002923 ,002981 ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,11 ,8 ,5 ,3 ,8 ,T ,94 ,16
  ,  ,  ,  ,  ,1 ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,6 ,1 ,5 ,F ,94 ,16
003818 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,3 ,2 ,5 ,T ,94 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,. ,5 ,1 ,6 ,T ,94 ,18
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,10 ,6 ,1 ,6 ,T ,94 ,11
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,1 ,5 ,T ,94 ,13
  ,  ,  ,  ,  ,5 ,1 ,1 ,  ,1 ,0 ,0 ,1 ,0 ,0 ,. ,. ,3 ,1 ,3 ,T ,94 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,25 ,6 ,2 ,1 ,2 ,F ,94 ,16
004033 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,12 ,9 ,5 ,2 ,8 ,F ,94 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,1 ,3 ,1 ,3 ,T ,94 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,6 ,1 ,8 ,F ,94 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,9 ,3 ,1 ,5 ,F ,94 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,10 ,6 ,1 ,6 ,T ,94 ,11
002290 ,001977 ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,. ,8 ,2 ,3 ,6 ,T ,94 ,13
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,10 ,7 ,1 ,8 ,T ,94 ,14
008083 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,5 ,1 ,8 ,T ,94 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,6 ,3 ,1 ,3 ,T ,94 ,12
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,. ,3 ,1 ,3 ,T ,94 ,12
002972 ,002975 ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,10 ,3 ,3 ,6 ,F ,94 ,15
003535 ,003481 ,002906 ,002981 ,003530 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,6 ,10 ,6 ,F ,94 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,. ,5 ,1 ,3 ,T ,94 ,16
002976 ,002981 ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,20 ,10 ,3 ,3 ,6 ,F ,94 ,16
001795 ,003523 ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,10 ,10 ,6 ,3 ,6 ,F ,94 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,10 ,3 ,1 ,4 ,T ,94 ,18
002976 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,40 ,6 ,6 ,2 ,2 ,T ,94 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,40 ,. ,4 ,1 ,6 ,T ,94 ,16
002979 ,  ,  ,  ,  ,5 ,1 ,  ,1 ,1 ,0 ,1 ,0 ,1 ,1 ,. ,9 ,3 ,1 ,6 ,T ,94 ,15
  ,  ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,2 ,3 ,1 ,3 ,T ,94 ,13
001108 ,002923 ,003448 ,002975 ,002974 ,5 ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,8 ,6 ,8 ,F ,94 ,15
006965 ,002974 ,002976 ,001892 ,003969 ,1 ,3 ,  ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,. ,6 ,5 ,6 ,8 ,T ,94 ,18
003170 ,003818 ,003636 ,002038 ,001839 ,3 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,8 ,6 ,8 ,F ,94 ,15
  ,  ,  ,  ,  ,1 ,1 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,10 ,7 ,5 ,1 ,5 ,T ,94 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,15 ,1 ,8 ,1 ,5 ,F ,94 ,15
  ,  ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,15 ,10 ,8 ,1 ,8 ,T ,94 ,14
002923 ,003620 ,006951 ,002984 ,002946 ,4 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,8 ,6 ,8 ,F ,94 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,4 ,1 ,7 ,T ,94 ,17
  ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,1 ,4 ,1 ,1 ,F ,94 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,4 ,3 ,1 ,3 ,T ,94 ,17
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,8 ,3 ,8 ,1 ,8 ,F ,94 ,15
002960 ,003658 ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,5 ,3 ,6 ,F ,94 ,15
003184 ,002516 ,003689 ,010366 ,003564 ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,10 ,6 ,5 ,8 ,F ,94 ,15
003981 ,002976 ,003675 ,  ,  ,2 ,2 ,2 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,10 ,8 ,5 ,4 ,8 ,F ,94 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,32 ,7 ,5 ,1 ,5 ,T ,94 ,5
002974 ,002906 ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,6 ,3 ,6 ,F ,94 ,14
  ,  ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,15 ,8 ,4 ,1 ,8 ,T ,94 ,14
002981 ,  ,  ,  ,  ,4 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,10 ,6 ,2 ,6 ,T ,94 ,9
003448 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,17 ,3 ,3 ,2 ,3 ,T ,94 ,14
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,9 ,3 ,1 ,5 ,T ,94 ,16
  ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,7 ,5 ,1 ,8 ,F ,94 ,17
010366 ,002972 ,  ,  ,  ,2 ,3 ,1 ,  ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,3 ,3 ,8 ,F ,94 ,15
008795 ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,6 ,5 ,2 ,6 ,F ,94 ,13
002238 ,  ,  ,  ,  ,2 ,  ,3 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,12 ,9 ,6 ,2 ,5 ,F ,94 ,17
002238 ,001572 ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,23 ,10 ,3 ,3 ,6 ,F ,94 ,16
001370 ,002906 ,  ,  ,  ,5 ,3 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,6 ,2 ,8 ,F ,94 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,1 ,1 ,5 ,F ,94 ,15
002976 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,13 ,8 ,7 ,2 ,8 ,F ,94 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,40 ,7 ,4 ,1 ,3 ,T ,94 ,9
  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,6 ,1 ,5 ,F ,94 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,3 ,1 ,3 ,T ,94 ,8
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,. ,3 ,1 ,3 ,T ,94 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,1 ,30 ,4 ,6 ,1 ,5 ,T ,94 ,12
002503 ,001531 ,001466 ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,3 ,4 ,6 ,F ,94 ,15
002981 ,002906 ,  ,  ,  ,2 ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,3 ,3 ,3 ,5 ,F ,94 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,1 ,6 ,1 ,6 ,T ,94 ,14
002974 ,004838 ,  ,  ,  ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,. ,6 ,6 ,3 ,6 ,T ,94 ,16
002976 ,  ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,15 ,3 ,8 ,2 ,8 ,F ,94 ,12
  ,  ,  ,  ,  ,4 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,10 ,6 ,1 ,8 ,T ,94 ,15
002981 ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,30 ,6 ,5 ,2 ,5 ,F ,94 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,12 ,3 ,6 ,1 ,8 ,F ,94 ,13
  ,  ,  ,  ,  ,2 ,2 ,1 ,  ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,6 ,1 ,6 ,F ,94 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,  ,1 ,0 ,1 ,0 ,1 ,0 ,. ,4 ,4 ,1 ,2 ,T ,94 ,14
001800 ,002929 ,002934 ,  ,  ,2 ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,7 ,5 ,4 ,8 ,F ,94 ,14
002984 ,002923 ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,17 ,7 ,2 ,3 ,6 ,T ,94 ,16
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,1 ,3 ,F ,94 ,17
002976 ,002984 ,  ,  ,  ,2 ,1 ,2 ,  ,1 ,1 ,0 ,1 ,1 ,0 ,. ,4 ,3 ,3 ,1 ,F ,94 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,8 ,1 ,8 ,T ,94 ,15
003425 ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,5 ,5 ,2 ,2 ,F ,94 ,17
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,1 ,3 ,1 ,1 ,T ,94 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,2 ,1 ,4 ,T ,94 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,2 ,3 ,1 ,3 ,T ,94 ,12
  ,  ,  ,  ,  ,5 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,8 ,1 ,7 ,T ,94 ,14
002981 ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,9 ,6 ,2 ,6 ,F ,94 ,18
002906 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,25 ,10 ,3 ,2 ,5 ,F ,94 ,14
003981 ,  ,  ,  ,  ,2 ,2 ,2 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,9 ,8 ,2 ,8 ,T ,94 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,. ,6 ,1 ,6 ,F ,94 ,13
001537 ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,. ,1 ,8 ,2 ,8 ,F ,94 ,13
  ,  ,  ,  ,  ,5 ,1 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,2 ,7 ,1 ,6 ,T ,94 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,24 ,8 ,3 ,1 ,3 ,T ,94 ,12
002906 ,002974 ,  ,  ,  ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,2 ,5 ,F ,94 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,5 ,5 ,1 ,6 ,F ,94 ,17
001537 ,002984 ,001535 ,001489 ,001507 ,5 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,6 ,8 ,F ,94 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,10 ,7 ,1 ,6 ,T ,94 ,17
001489 ,003425 ,001578 ,001598 ,001537 ,4 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,8 ,7 ,6 ,F ,94 ,13
002978 ,001564 ,003604 ,003519 ,001489 ,5 ,1 ,3 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,10 ,10 ,8 ,6 ,8 ,F ,94 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,6 ,2 ,1 ,2 ,T ,94 ,13
002981 ,002906 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,5 ,3 ,3 ,T ,94 ,14
  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,4 ,3 ,1 ,3 ,T ,94 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,7 ,6 ,1 ,3 ,T ,94 ,15
003752 ,002029 ,001057 ,001535 ,  ,3 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,8 ,4 ,5 ,8 ,F ,94 ,16
004033 ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,40 ,10 ,4 ,2 ,3 ,T ,94 ,10
  ,  ,  ,  ,  ,2 ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,10 ,10 ,3 ,1 ,5 ,T ,94 ,16
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,30 ,6 ,6 ,1 ,6 ,T ,94 ,13
002981 ,002906 ,002929 ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,4 ,5 ,3 ,8 ,T ,94 ,12
001710 ,003827 ,001108 ,001538 ,001737 ,5 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,7 ,9 ,7 ,F ,94 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,1 ,0 ,. ,. ,3 ,1 ,3 ,T ,94 ,12
003658 ,001538 ,029143 ,001147 ,009635 ,4 ,3 ,  ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,5 ,3 ,15 ,3 ,T ,94 ,18
  ,  ,  ,  ,  ,5 ,  ,1 ,  ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,2 ,1 ,6 ,T ,94 ,12
003771 ,009549 ,  ,  ,  ,5 ,1 ,1 ,  ,1 ,0 ,0 ,1 ,0 ,0 ,. ,1 ,8 ,3 ,8 ,T ,94 ,14
  ,  ,  ,  ,  ,3 ,  ,1 ,1 ,0 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,3 ,1 ,3 ,T ,94 ,12

/* db95.dat */

001321 ,001314 ,001370 ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,. ,. ,6 ,3 ,6 ,T ,95 ,16
002221 ,003696 ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,10 ,4 ,3 ,8 ,F ,95 ,16
002895 ,002814 ,004661 ,002130 ,002671 ,2 ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,2 ,6 ,7 ,5 ,F ,95 ,16
  ,  ,  ,  ,  ,4 ,3 ,3 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,10 ,6 ,1 ,6 ,F ,95 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,5 ,5 ,1 ,5 ,F ,95 ,17
009092 ,001574 ,002330 ,002243 ,002290 ,  ,1 ,3 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,6 ,4 ,5 ,7 ,T ,95 ,17
003434 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,10 ,9 ,6 ,2 ,6 ,T ,95 ,15
001489 ,002972 ,003448 ,  ,  ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,. ,2 ,5 ,4 ,5 ,F ,95 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,7 ,5 ,1 ,6 ,F ,95 ,17
002575 ,002960 ,  ,  ,  ,4 ,1 ,1 ,  ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,8 ,3 ,6 ,F ,95 ,16
002981 ,002906 ,002913 ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,17 ,7 ,6 ,4 ,5 ,F ,95 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,0 ,0 ,1 ,1 ,1 ,0 ,25 ,. ,. ,1 ,. ,T ,95 ,12
002975 ,  ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,15 ,11 ,3 ,2 ,6 ,T ,95 ,17
003414 ,002959 ,001422 ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,5 ,3 ,8 ,T ,95 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,18 ,6 ,3 ,1 ,3 ,T ,95 ,16
002984 ,002906 ,002974 ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,18 ,. ,3 ,4 ,5 ,T ,95 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,18 ,. ,6 ,1 ,6 ,T ,95 ,15
002976 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,5 ,5 ,1 ,3 ,F ,95 ,15
002984 ,002906 ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,12 ,11 ,6 ,3 ,8 ,F ,95 ,13
002976 ,  ,  ,  ,  ,5 ,3 ,1 ,  ,1 ,0 ,0 ,0 ,0 ,0 ,. ,11 ,8 ,2 ,8 ,T ,95 ,13
999998 ,999998 ,999998 ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,25 ,. ,6 ,3 ,5 ,T ,95 ,8
002974 ,002975 ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,15 ,8 ,5 ,3 ,8 ,F ,95 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,16 ,4 ,6 ,1 ,5 ,T ,95 ,14
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,15 ,8 ,5 ,1 ,3 ,T ,95 ,13
003481 ,001036 ,002981 ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,15 ,12 ,8 ,4 ,5 ,F ,95 ,14
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,40 ,3 ,6 ,1 ,6 ,T ,95 ,11
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,8 ,1 ,8 ,T ,95 ,17
003746 ,003767 ,002975 ,002923 ,  ,2 ,2 ,3 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,12 ,8 ,5 ,8 ,F ,95 ,15
001536 ,003714 ,  ,  ,  ,4 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,1 ,4 ,3 ,4 ,F ,95 ,14
002906 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,5 ,2 ,5 ,F ,95 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,1 ,22 ,1 ,8 ,1 ,6 ,F ,95 ,15
002906 ,002946 ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,5 ,8 ,3 ,6 ,F ,95 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,38 ,9 ,3 ,1 ,3 ,T ,95 ,8
002981 ,002984 ,002906 ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,7 ,6 ,3 ,6 ,F ,95 ,19
  ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,15 ,10 ,5 ,1 ,3 ,T ,95 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,25 ,8 ,3 ,1 ,4 ,T ,95 ,12
002974 ,002931 ,002984 ,001321 ,002972 ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,20 ,6 ,6 ,12 ,3 ,F ,95 ,15
002974 ,002984 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,5 ,3 ,3 ,F ,95 ,17
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,7 ,6 ,1 ,4 ,F ,95 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,35 ,8 ,4 ,1 ,5 ,T ,95 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,40 ,6 ,5 ,2 ,3 ,T ,95 ,8
  ,  ,  ,  ,  ,5 ,2 ,3 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,8 ,6 ,1 ,6 ,T ,95 ,14
003425 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,25 ,10 ,4 ,2 ,7 ,T ,95 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,7 ,4 ,1 ,5 ,T ,95 ,12
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,9 ,4 ,1 ,3 ,T ,95 ,12
001140 ,002701 ,002972 ,002976 ,006740 ,4 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,6 ,5 ,8 ,F ,95 ,15
003721 ,002722 ,003735 ,  ,  ,3 ,1 ,3 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,10 ,10 ,8 ,4 ,. ,F ,95 ,18
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,6 ,8 ,1 ,3 ,T ,95 ,4
002105 ,007502 ,001489 ,001328 ,  ,3 ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,3 ,6 ,4 ,6 ,F ,95 ,15
002976 ,002923 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,11 ,3 ,3 ,5 ,F ,95 ,15
002972 ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,5 ,2 ,6 ,T ,95 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,20 ,3 ,4 ,1 ,4 ,T ,95 ,17
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,0 ,0 ,0 ,0 ,1 ,0 ,50 ,2 ,3 ,1 ,2 ,T ,95 ,3
003530 ,006965 ,001489 ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,9 ,5 ,4 ,5 ,F ,95 ,14
006791 ,001569 ,002923 ,002984 ,  ,2 ,3 ,2 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,. ,5 ,5 ,4 ,F ,95 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,11 ,6 ,1 ,8 ,T ,95 ,17
003721 ,008770 ,002716 ,003298 ,  ,2 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,10 ,5 ,5 ,5 ,F ,95 ,16
002979 ,003677 ,001372 ,003875 ,002336 ,3 ,1 ,2 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,7 ,6 ,6 ,T ,95 ,15
001431 ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,7 ,8 ,2 ,8 ,F ,95 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,. ,3 ,1 ,8 ,T ,95 ,13
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,7 ,1 ,6 ,T ,95 ,15
  ,  ,  ,  ,  ,4 ,  ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,23 ,12 ,5 ,1 ,8 ,T ,95 ,15
008083 ,002979 ,  ,  ,  ,4 ,2 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,11 ,8 ,2 ,7 ,T ,95 ,11
  ,  ,  ,  ,  ,5 ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,30 ,4 ,4 ,1 ,3 ,T ,95 ,12
006965 ,003448 ,003123 ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,3 ,4 ,3 ,F ,95 ,13
002955 ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,6 ,6 ,2 ,3 ,F ,95 ,15
002906 ,  ,  ,  ,  ,1 ,1 ,2 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,20 ,7 ,6 ,2 ,3 ,T ,95 ,13
002975 ,002905 ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,10 ,3 ,3 ,5 ,F ,95 ,15
002960 ,  ,  ,  ,  ,1 ,3 ,2 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,25 ,9 ,5 ,2 ,2 ,F ,95 ,15
002981 ,  ,  ,  ,  ,5 ,1 ,1 ,  ,1 ,1 ,0 ,1 ,0 ,0 ,. ,. ,3 ,2 ,4 ,F ,95 ,15
002974 ,002923 ,002981 ,002984 ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,15 ,9 ,6 ,5 ,8 ,F ,95 ,16
002974 ,  ,  ,  ,  ,5 ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,6 ,8 ,2 ,8 ,T ,95 ,17
002974 ,002972 ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,20 ,12 ,3 ,3 ,8 ,T ,95 ,17
003279 ,002984 ,001378 ,001415 ,  ,3 ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,6 ,5 ,3 ,F ,95 ,16
002981 ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,4 ,7 ,2 ,4 ,F ,95 ,15
002984 ,003481 ,003531 ,003445 ,001036 ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,12 ,7 ,6 ,8 ,F ,95 ,14
003325 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,10 ,3 ,2 ,3 ,F ,95 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,32 ,7 ,5 ,1 ,3 ,T ,95 ,8
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,28 ,. ,3 ,1 ,1 ,T ,95 ,3
004033 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,1 ,8 ,7 ,3 ,2 ,3 ,T ,95 ,13
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,6 ,1 ,8 ,T ,95 ,17
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,15 ,11 ,8 ,1 ,8 ,F ,95 ,16
002975 ,002984 ,002972 ,002906 ,  ,3 ,3 ,3 ,2 ,0 ,1 ,1 ,1 ,1 ,0 ,15 ,10 ,8 ,5 ,8 ,T ,95 ,16
001598 ,002974 ,  ,  ,  ,3 ,1 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,10 ,3 ,3 ,6 ,F ,95 ,17
002235 ,003721 ,003705 ,002358 ,  ,5 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,. ,8 ,5 ,8 ,F ,95 ,16
001426 ,002155 ,006965 ,  ,  ,3 ,1 ,3 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,12 ,6 ,4 ,6 ,F ,95 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,3 ,1 ,3 ,F ,95 ,14
  ,  ,  ,  ,  ,1 ,2 ,3 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,30 ,9 ,4 ,1 ,8 ,F ,95 ,15
002906 ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,1 ,2 ,2 ,5 ,T ,95 ,15
002918 ,003746 ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,5 ,3 ,6 ,F ,95 ,18
002981 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,8 ,6 ,2 ,8 ,T ,95 ,14
003378 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,6 ,6 ,2 ,5 ,T ,95 ,13
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,8 ,6 ,1 ,5 ,F ,95 ,16
003423 ,003746 ,002923 ,002906 ,002984 ,5 ,3 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,12 ,8 ,6 ,8 ,F ,95 ,15
001009 ,003754 ,  ,  ,  ,4 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,11 ,4 ,3 ,6 ,F ,95 ,15
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,3 ,3 ,1 ,5 ,F ,95 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,12 ,8 ,1 ,8 ,F ,95 ,16
001948 ,001737 ,003798 ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,5 ,4 ,4 ,T ,95 ,14
002916 ,010392 ,003732 ,002095 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,6 ,4 ,3 ,T ,95 ,14
002972 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,9 ,8 ,2 ,8 ,F ,95 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,1 ,3 ,1 ,2 ,T ,95 ,12
002906 ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,6 ,2 ,6 ,F ,95 ,12
002906 ,002975 ,002976 ,003432 ,  ,2 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,15 ,9 ,6 ,5 ,7 ,F ,95 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,. ,3 ,1 ,4 ,T ,95 ,14
  ,  ,  ,  ,  ,4 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,12 ,6 ,1 ,3 ,T ,95 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,35 ,7 ,7 ,1 ,8 ,T ,95 ,4
002976 ,003754 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,6 ,8 ,3 ,5 ,F ,95 ,15
003981 ,002974 ,  ,  ,  ,3 ,3 ,2 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,. ,4 ,3 ,4 ,F ,95 ,16
002976 ,002906 ,  ,  ,  ,5 ,2 ,1 ,  ,1 ,1 ,1 ,0 ,1 ,0 ,. ,11 ,4 ,3 ,8 ,T ,95 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,20 ,8 ,8 ,1 ,8 ,T ,95 ,15
  ,  ,  ,  ,  ,4 ,2 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,10 ,8 ,1 ,8 ,T ,95 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,2 ,5 ,1 ,8 ,T ,95 ,17
002981 ,002906 ,008085 ,002948 ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,8 ,5 ,5 ,6 ,F ,95 ,15
002974 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,6 ,2 ,5 ,F ,95 ,16
002972 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,. ,6 ,2 ,5 ,F ,95 ,16
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,6 ,1 ,6 ,F ,95 ,15
002974 ,002972 ,002981 ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,1 ,8 ,4 ,8 ,F ,95 ,13
002906 ,002981 ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,. ,6 ,3 ,5 ,F ,95 ,17
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,5 ,4 ,1 ,5 ,F ,95 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,. ,2 ,1 ,2 ,T ,95 ,6
  ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,15 ,. ,5 ,1 ,5 ,T ,95 ,13
004033 ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,3 ,3 ,2 ,1 ,F ,95 ,15
002906 ,003428 ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,12 ,7 ,3 ,8 ,F ,95 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,30 ,7 ,6 ,1 ,3 ,T ,95 ,15
002972 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,15 ,8 ,4 ,2 ,4 ,F ,95 ,15
002975 ,002923 ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,5 ,3 ,5 ,F ,95 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,10 ,8 ,1 ,6 ,T ,95 ,15
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,6 ,1 ,8 ,T ,95 ,14
003705 ,003728 ,001564 ,003535 ,003388 ,3 ,  ,2 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,12 ,8 ,7 ,8 ,F ,95 ,12
002906 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,5 ,2 ,6 ,F ,95 ,14
002927 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,8 ,3 ,2 ,6 ,F ,95 ,15
002978 ,  ,  ,  ,  ,1 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,25 ,9 ,5 ,1 ,6 ,T ,95 ,17
002536 ,  ,  ,  ,  ,2 ,2 ,3 ,1 ,0 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,5 ,2 ,5 ,F ,95 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,40 ,9 ,4 ,1 ,8 ,T ,95 ,13
  ,  ,  ,  ,  ,2 ,  ,2 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,25 ,3 ,3 ,1 ,6 ,F ,95 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,40 ,3 ,8 ,1 ,6 ,T ,95 ,15
002906 ,002976 ,  ,  ,  ,3 ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,. ,3 ,3 ,4 ,F ,95 ,15
002974 ,002981 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,4 ,3 ,3 ,3 ,F ,95 ,15
  ,  ,  ,  ,  ,1 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,6 ,1 ,6 ,F ,95 ,15
002976 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,5 ,2 ,6 ,T ,95 ,20
002979 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,7 ,6 ,2 ,5 ,F ,95 ,16
002906 ,002978 ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,9 ,5 ,3 ,4 ,F ,95 ,16
002981 ,002906 ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,28 ,8 ,3 ,3 ,6 ,T ,95 ,11
002906 ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,10 ,4 ,6 ,2 ,6 ,F ,95 ,12
  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,. ,3 ,1 ,3 ,F ,95 ,15
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,1 ,6 ,1 ,6 ,T ,95 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,23 ,10 ,5 ,1 ,4 ,T ,95 ,14
  ,  ,  ,  ,  ,  ,  ,1 ,  ,1 ,0 ,0 ,1 ,0 ,0 ,. ,2 ,3 ,1 ,4 ,T ,95 ,14
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,12 ,3 ,1 ,5 ,T ,95 ,17
002981 ,002905 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,6 ,3 ,6 ,T ,95 ,13
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,25 ,12 ,5 ,1 ,8 ,T ,95 ,15
002975 ,003670 ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,9 ,3 ,3 ,3 ,F ,95 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,4 ,6 ,1 ,6 ,F ,95 ,14
001426 ,001564 ,002742 ,003670 ,002130 ,5 ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,11 ,7 ,11 ,8 ,F ,95 ,14
003366 ,002923 ,  ,  ,  ,2 ,2 ,  ,  ,1 ,0 ,1 ,1 ,1 ,0 ,. ,12 ,8 ,3 ,8 ,F ,95 ,15
003534 ,003428 ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,12 ,6 ,3 ,8 ,F ,95 ,15
001586 ,003519 ,  ,  ,  ,5 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,7 ,4 ,8 ,F ,95 ,14
002981 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,4 ,3 ,2 ,5 ,F ,95 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,1 ,7 ,1 ,3 ,F ,95 ,15
002948 ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,1 ,5 ,2 ,3 ,F ,95 ,15
002976 ,002975 ,  ,  ,  ,4 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,1 ,0 ,. ,. ,6 ,3 ,6 ,F ,95 ,14
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,23 ,8 ,2 ,1 ,5 ,T ,95 ,1
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,6 ,6 ,1 ,6 ,T ,95 ,12
002974 ,003445 ,  ,  ,  ,3 ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,7 ,6 ,3 ,6 ,F ,95 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,20 ,6 ,6 ,1 ,8 ,T ,95 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,3 ,3 ,1 ,3 ,T ,95 ,12
002981 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,8 ,8 ,2 ,7 ,F ,95 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,6 ,1 ,3 ,T ,95 ,16
002906 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,6 ,2 ,6 ,F ,95 ,15
002974 ,002972 ,002905 ,  ,  ,1 ,2 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,1 ,10 ,2 ,5 ,4 ,3 ,F ,95 ,17
  ,  ,  ,  ,  ,3 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,3 ,3 ,1 ,3 ,F ,95 ,16
  ,  ,  ,  ,  ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,12 ,5 ,1 ,6 ,F ,95 ,16
002981 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,20 ,5 ,3 ,2 ,4 ,T ,95 ,12
002981 ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,6 ,3 ,1 ,3 ,T ,95 ,17
002960 ,002906 ,  ,  ,  ,3 ,3 ,3 ,  ,1 ,0 ,1 ,0 ,1 ,0 ,. ,8 ,4 ,3 ,5 ,F ,95 ,14
  ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,7 ,3 ,1 ,3 ,F ,95 ,12
002906 ,002923 ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,23 ,6 ,5 ,3 ,5 ,T ,95 ,14
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,. ,6 ,1 ,7 ,T ,95 ,16
004033 ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,17 ,12 ,8 ,1 ,8 ,T ,95 ,12
002981 ,002975 ,  ,  ,  ,5 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,. ,8 ,6 ,3 ,4 ,T ,95 ,14
  ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,16 ,12 ,6 ,1 ,8 ,T ,95 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,18 ,9 ,6 ,1 ,8 ,T ,95 ,13
002984 ,002981 ,002906 ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,2 ,5 ,4 ,5 ,F ,95 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,25 ,10 ,3 ,1 ,6 ,T ,95 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,5 ,1 ,6 ,T ,95 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,18 ,12 ,6 ,1 ,7 ,T ,95 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,10 ,9 ,8 ,1 ,8 ,T ,95 ,19
002976 ,002906 ,002981 ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,3 ,5 ,4 ,6 ,F ,95 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,9 ,7 ,1 ,3 ,T ,95 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,2 ,1 ,1 ,1 ,T ,95 ,15
  ,  ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,7 ,3 ,1 ,5 ,F ,95 ,14
002972 ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,4 ,2 ,4 ,F ,95 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,. ,2 ,1 ,3 ,T ,95 ,14
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,15 ,11 ,8 ,1 ,3 ,F ,95 ,19
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,4 ,4 ,1 ,2 ,F ,95 ,15
002981 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,6 ,2 ,8 ,F ,95 ,16
002981 ,  ,  ,  ,  ,4 ,  ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,9 ,5 ,2 ,3 ,F ,95 ,15
002906 ,002972 ,  ,  ,  ,2 ,3 ,2 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,3 ,3 ,3 ,F ,95 ,18
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,11 ,6 ,1 ,6 ,T ,95 ,14
  ,  ,  ,  ,  ,1 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,29 ,1 ,3 ,1 ,. ,T ,95 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,30 ,8 ,4 ,1 ,4 ,T ,95 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,5 ,3 ,1 ,4 ,T ,95 ,15
002972 ,002967 ,002975 ,  ,  ,5 ,  ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,. ,. ,3 ,4 ,6 ,F ,95 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,30 ,. ,6 ,1 ,5 ,F ,95 ,12
002972 ,002906 ,002927 ,002976 ,  ,3 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,6 ,5 ,8 ,F ,95 ,15
002906 ,  ,  ,  ,  ,3 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,5 ,2 ,4 ,T ,95 ,16
002974 ,002975 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,5 ,3 ,4 ,F ,95 ,15
002975 ,002906 ,002960 ,  ,  ,1 ,1 ,3 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,6 ,2 ,4 ,3 ,F ,95 ,17
002972 ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,7 ,3 ,2 ,4 ,F ,95 ,16
002984 ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,1 ,3 ,2 ,3 ,T ,95 ,13
002927 ,002944 ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,5 ,3 ,5 ,F ,95 ,14
002929 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,3 ,2 ,3 ,F ,95 ,16
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,18 ,6 ,4 ,1 ,4 ,T ,95 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,4 ,6 ,5 ,1 ,6 ,T ,95 ,13
  ,  ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,7 ,4 ,1 ,4 ,T ,95 ,4
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,37 ,3 ,4 ,1 ,4 ,T ,95 ,14
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,8 ,8 ,1 ,7 ,T ,95 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,8 ,5 ,1 ,5 ,F ,95 ,12
006883 ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,8 ,6 ,2 ,. ,F ,95 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,8 ,10 ,4 ,1 ,3 ,F ,95 ,14
002981 ,011197 ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,30 ,7 ,6 ,3 ,6 ,F ,95 ,15
002923 ,002976 ,002984 ,  ,  ,4 ,  ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,8 ,4 ,8 ,F ,95 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,. ,4 ,6 ,1 ,4 ,F ,95 ,17
002974 ,002976 ,002923 ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,7 ,6 ,4 ,8 ,F ,95 ,16
003456 ,002944 ,002941 ,  ,  ,4 ,1 ,1 ,2 ,0 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,6 ,4 ,8 ,F ,95 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,5 ,10 ,5 ,1 ,5 ,F ,95 ,15
002906 ,002923 ,002126 ,003736 ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,. ,8 ,5 ,6 ,F ,95 ,18
002981 ,  ,  ,  ,  ,1 ,2 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,50 ,5 ,3 ,2 ,3 ,T ,95 ,4
002984 ,002906 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,6 ,3 ,8 ,F ,95 ,17
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,1 ,8 ,7 ,3 ,1 ,3 ,F ,95 ,16
002918 ,003448 ,003434 ,002906 ,002923 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,6 ,6 ,6 ,F ,95 ,14
  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,6 ,6 ,1 ,3 ,F ,95 ,16
002906 ,002985 ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,. ,5 ,3 ,5 ,F ,95 ,15
002906 ,002953 ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,8 ,8 ,3 ,8 ,F ,95 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,28 ,12 ,3 ,1 ,6 ,T ,95 ,11
002976 ,002984 ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,8 ,8 ,6 ,3 ,6 ,F ,95 ,17
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,0 ,0 ,1 ,0 ,0 ,1 ,30 ,4 ,8 ,1 ,5 ,T ,95 ,12
009430 ,002981 ,002975 ,001537 ,  ,2 ,  ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,. ,10 ,6 ,5 ,8 ,F ,95 ,15
002923 ,  ,  ,  ,  ,2 ,2 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,22 ,10 ,3 ,2 ,3 ,F ,95 ,16
002976 ,002906 ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,5 ,3 ,4 ,F ,95 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,10 ,5 ,1 ,8 ,F ,95 ,18
002972 ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,15 ,9 ,3 ,2 ,3 ,F ,95 ,15
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,4 ,1 ,3 ,F ,95 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,32 ,10 ,4 ,1 ,3 ,T ,95 ,15
002941 ,002975 ,002929 ,  ,  ,3 ,1 ,2 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,8 ,8 ,6 ,4 ,6 ,F ,95 ,14
002975 ,  ,  ,  ,  ,4 ,3 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,3 ,3 ,2 ,4 ,F ,95 ,14
002906 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,8 ,2 ,6 ,F ,95 ,18
002906 ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,4 ,2 ,6 ,F ,95 ,14
002918 ,002976 ,  ,  ,  ,1 ,1 ,2 ,  ,1 ,0 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,3 ,6 ,F ,95 ,17
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,3 ,6 ,1 ,6 ,T ,95 ,13
002981 ,  ,  ,  ,  ,4 ,2 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,5 ,5 ,2 ,3 ,F ,95 ,12
002972 ,002906 ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,11 ,5 ,3 ,8 ,F ,95 ,16
002950 ,002986 ,002926 ,  ,  ,4 ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,6 ,3 ,6 ,F ,95 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,6 ,3 ,1 ,3 ,T ,95 ,14
  ,  ,  ,  ,  ,1 ,3 ,  ,  ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,3 ,1 ,5 ,T ,95 ,15
003728 ,  ,  ,  ,  ,3 ,1 ,  ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,38 ,9 ,2 ,2 ,2 ,T ,95 ,14
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,10 ,3 ,1 ,3 ,T ,95 ,7
002981 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,8 ,3 ,2 ,4 ,T ,95 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,10 ,6 ,1 ,6 ,T ,95 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,30 ,6 ,3 ,1 ,3 ,T ,95 ,15
002972 ,002975 ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,5 ,3 ,6 ,F ,95 ,16
002920 ,002918 ,002913 ,002974 ,003713 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,12 ,8 ,6 ,8 ,F ,95 ,14
002972 ,002906 ,002981 ,  ,  ,1 ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,1 ,15 ,9 ,7 ,4 ,6 ,F ,95 ,14
002953 ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,25 ,3 ,5 ,1 ,2 ,F ,95 ,17
002972 ,002929 ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,. ,5 ,3 ,6 ,F ,95 ,16
002906 ,002981 ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,15 ,7 ,3 ,3 ,3 ,F ,95 ,15
002981 ,002972 ,002906 ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,9 ,5 ,4 ,8 ,F ,95 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,. ,8 ,1 ,8 ,T ,95 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,8 ,3 ,1 ,6 ,T ,95 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,9 ,6 ,1 ,6 ,F ,95 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,11 ,5 ,1 ,5 ,T ,95 ,13
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,22 ,6 ,3 ,1 ,5 ,F ,95 ,9
002906 ,002981 ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,10 ,8 ,3 ,8 ,F ,95 ,18
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,10 ,3 ,1 ,6 ,T ,95 ,12
002972 ,002975 ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,8 ,10 ,4 ,3 ,4 ,F ,95 ,17
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,8 ,5 ,1 ,5 ,T ,95 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,40 ,5 ,6 ,1 ,6 ,T ,95 ,16
002979 ,002948 ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,10 ,6 ,3 ,6 ,F ,95 ,15
  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,4 ,5 ,1 ,5 ,F ,95 ,14
  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,7 ,4 ,1 ,3 ,F ,95 ,16
002906 ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,. ,3 ,2 ,3 ,F ,95 ,13
002972 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,8 ,6 ,2 ,8 ,F ,95 ,15
  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,12 ,6 ,1 ,2 ,T ,95 ,14
002923 ,003481 ,003418 ,  ,  ,2 ,3 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,3 ,4 ,6 ,F ,95 ,15
002972 ,002906 ,002976 ,002913 ,  ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,. ,5 ,5 ,6 ,F ,95 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,12 ,7 ,6 ,1 ,5 ,T ,95 ,12
002978 ,002974 ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,3 ,3 ,8 ,F ,95 ,17
  ,  ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,8 ,8 ,8 ,1 ,5 ,T ,95 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,1 ,. ,3 ,4 ,1 ,4 ,T ,95 ,12
002978 ,002972 ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,12 ,6 ,3 ,8 ,T ,95 ,16
  ,  ,  ,  ,  ,5 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,6 ,3 ,1 ,3 ,T ,95 ,16
003530 ,001928 ,001830 ,  ,  ,3 ,2 ,3 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,8 ,3 ,4 ,6 ,F ,95 ,13
002906 ,  ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,1 ,20 ,6 ,6 ,2 ,6 ,T ,95 ,15
002972 ,002984 ,001479 ,002981 ,003530 ,3 ,2 ,3 ,  ,1 ,0 ,0 ,1 ,1 ,0 ,. ,7 ,5 ,6 ,5 ,F ,95 ,13
003754 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,5 ,5 ,2 ,5 ,F ,95 ,14
002974 ,002972 ,002906 ,  ,  ,5 ,  ,3 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,12 ,6 ,4 ,8 ,F ,95 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,30 ,8 ,3 ,1 ,8 ,T ,95 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,15 ,3 ,5 ,1 ,3 ,T ,95 ,19
002976 ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,12 ,6 ,2 ,6 ,F ,95 ,16
002918 ,003434 ,001052 ,002013 ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,12 ,6 ,5 ,6 ,F ,95 ,15
002979 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,48 ,1 ,3 ,2 ,3 ,T ,95 ,11
002974 ,002906 ,002984 ,002923 ,  ,3 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,7 ,3 ,5 ,4 ,T ,95 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,18 ,9 ,6 ,1 ,6 ,F ,95 ,16
002976 ,002941 ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,6 ,3 ,3 ,T ,95 ,17
002906 ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,. ,11 ,6 ,2 ,6 ,F ,95 ,16
003981 ,  ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,10 ,8 ,5 ,2 ,5 ,F ,95 ,14
002974 ,003434 ,002906 ,  ,  ,2 ,3 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,4 ,8 ,F ,95 ,15
002933 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,8 ,3 ,2 ,3 ,F ,95 ,12
002930 ,002941 ,002981 ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,6 ,4 ,6 ,F ,95 ,16
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,11 ,5 ,1 ,5 ,T ,95 ,18
002976 ,002927 ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,6 ,3 ,6 ,F ,95 ,15
002955 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,6 ,3 ,2 ,6 ,F ,95 ,17
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,18 ,8 ,6 ,1 ,3 ,F ,95 ,13
  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,6 ,1 ,5 ,F ,95 ,14
012448 ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,8 ,5 ,5 ,2 ,3 ,F ,95 ,13
  ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,23 ,10 ,5 ,1 ,3 ,F ,95 ,15
002906 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,15 ,8 ,6 ,2 ,3 ,T ,95 ,14
002974 ,002972 ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,10 ,8 ,3 ,8 ,F ,95 ,14
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,23 ,7 ,4 ,1 ,4 ,F ,95 ,12
002981 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,40 ,6 ,3 ,2 ,3 ,F ,95 ,15
021415 ,003752 ,003484 ,  ,  ,2 ,3 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,. ,10 ,8 ,4 ,8 ,F ,95 ,16
002974 ,002972 ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,6 ,6 ,3 ,6 ,F ,95 ,15
002974 ,002972 ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,18 ,12 ,7 ,3 ,6 ,F ,95 ,16
  ,  ,  ,  ,  ,3 ,3 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,12 ,5 ,1 ,5 ,F ,95 ,15
  ,  ,  ,  ,  ,4 ,3 ,1 ,  ,1 ,1 ,0 ,0 ,1 ,0 ,. ,7 ,8 ,1 ,8 ,T ,95 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,0 ,0 ,1 ,0 ,0 ,0 ,45 ,2 ,5 ,1 ,7 ,T ,95 ,3
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,6 ,3 ,1 ,1 ,T ,95 ,16
002976 ,  ,  ,  ,  ,3 ,1 ,1 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,. ,6 ,6 ,2 ,7 ,F ,95 ,14
001321 ,002918 ,003954 ,001515 ,002575 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,12 ,5 ,6 ,8 ,F ,95 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,24 ,10 ,2 ,1 ,3 ,T ,95 ,20
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,6 ,6 ,1 ,3 ,F ,95 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,20 ,4 ,5 ,1 ,5 ,F ,95 ,18
  ,  ,  ,  ,  ,2 ,3 ,1 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,3 ,5 ,1 ,2 ,F ,95 ,12
  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,1 ,6 ,1 ,3 ,F ,95 ,15
  ,  ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,15 ,8 ,6 ,1 ,3 ,F ,95 ,13
002984 ,002972 ,002974 ,002906 ,  ,4 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,12 ,8 ,5 ,8 ,F ,95 ,16
002974 ,003746 ,002945 ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,12 ,5 ,4 ,6 ,F ,95 ,18
002972 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,6 ,8 ,2 ,5 ,F ,95 ,15
003005 ,002984 ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,11 ,6 ,2 ,8 ,T ,95 ,16
002981 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,40 ,7 ,2 ,2 ,2 ,T ,95 ,9
  ,  ,  ,  ,  ,5 ,  ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,. ,3 ,1 ,1 ,T ,95 ,14
  ,  ,  ,  ,  ,4 ,  ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,1 ,. ,6 ,5 ,1 ,5 ,F ,95 ,12
002984 ,002923 ,002926 ,  ,  ,3 ,2 ,3 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,25 ,2 ,6 ,4 ,8 ,F ,95 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,28 ,6 ,5 ,1 ,6 ,T ,95 ,10
002974 ,002984 ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,12 ,4 ,2 ,3 ,3 ,F ,95 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,18 ,9 ,3 ,1 ,3 ,T ,95 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,9 ,5 ,1 ,5 ,T ,95 ,13
002981 ,002984 ,003425 ,  ,  ,2 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,3 ,4 ,6 ,T ,95 ,15
001830 ,001569 ,002972 ,  ,  ,2 ,2 ,3 ,  ,1 ,0 ,0 ,1 ,0 ,0 ,. ,6 ,6 ,4 ,6 ,F ,95 ,16
002933 ,002975 ,002906 ,  ,  ,3 ,3 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,10 ,9 ,2 ,3 ,2 ,F ,95 ,14
  ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,5 ,7 ,3 ,1 ,6 ,F ,95 ,16
002981 ,004033 ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,4 ,3 ,4 ,F ,95 ,16
002981 ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,3 ,2 ,5 ,F ,95 ,18
002906 ,002913 ,002948 ,002984 ,002954 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,6 ,6 ,8 ,F ,95 ,15
002974 ,002929 ,  ,  ,  ,2 ,  ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,3 ,3 ,3 ,F ,95 ,15
002906 ,002913 ,  ,  ,  ,4 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,11 ,8 ,3 ,8 ,F ,95 ,15
002929 ,002981 ,002906 ,  ,  ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,6 ,3 ,4 ,5 ,F ,95 ,17
002974 ,002972 ,002976 ,  ,  ,3 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,5 ,4 ,6 ,F ,95 ,14
002981 ,004033 ,002972 ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,15 ,10 ,5 ,4 ,5 ,F ,95 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,5 ,9 ,3 ,1 ,3 ,T ,95 ,14
002972 ,002906 ,002944 ,  ,  ,1 ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,2 ,3 ,4 ,3 ,F ,95 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,5 ,5 ,1 ,5 ,T ,95 ,13
002972 ,002984 ,002906 ,  ,  ,3 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,11 ,7 ,4 ,6 ,F ,95 ,15
002974 ,  ,  ,  ,  ,1 ,2 ,2 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,8 ,9 ,6 ,2 ,6 ,F ,95 ,16
004033 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,18 ,3 ,5 ,2 ,6 ,F ,95 ,14
  ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,. ,5 ,1 ,3 ,F ,95 ,12
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,9 ,8 ,1 ,8 ,F ,95 ,18
002976 ,001955 ,002906 ,002927 ,  ,2 ,  ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,10 ,3 ,3 ,5 ,3 ,F ,95 ,16
003434 ,002978 ,003445 ,  ,  ,2 ,1 ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,6 ,4 ,6 ,F ,95 ,16
  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,5 ,7 ,1 ,5 ,T ,95 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,50 ,5 ,2 ,1 ,1 ,T ,95 ,3
001488 ,001594 ,002928 ,  ,  ,2 ,  ,2 ,  ,1 ,1 ,0 ,1 ,0 ,0 ,. ,. ,3 ,4 ,. ,F ,95 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,18 ,10 ,2 ,1 ,6 ,T ,95 ,17
002944 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,8 ,3 ,2 ,3 ,F ,95 ,14
002130 ,003378 ,003277 ,002974 ,002128 ,5 ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,6 ,6 ,F ,95 ,18
  ,  ,  ,  ,  ,4 ,2 ,  ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,4 ,4 ,1 ,3 ,T ,95 ,11
002918 ,002978 ,002974 ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,11 ,5 ,4 ,6 ,F ,95 ,15
002906 ,002939 ,  ,  ,  ,4 ,1 ,2 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,8 ,8 ,3 ,5 ,T ,95 ,14
002944 ,002906 ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,9 ,3 ,3 ,4 ,F ,95 ,18
002972 ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,10 ,7 ,3 ,2 ,6 ,F ,95 ,14
001445 ,002974 ,002984 ,002906 ,002914 ,4 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,12 ,8 ,7 ,8 ,F ,95 ,15
002972 ,  ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,12 ,9 ,5 ,2 ,3 ,F ,95 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,30 ,11 ,6 ,1 ,8 ,T ,95 ,12
002974 ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,. ,4 ,2 ,3 ,F ,95 ,16
  ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,4 ,5 ,1 ,4 ,F ,95 ,14
002972 ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,0 ,0 ,0 ,1 ,0 ,0 ,18 ,8 ,4 ,2 ,8 ,T ,95 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,40 ,9 ,5 ,1 ,5 ,T ,95 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,16 ,10 ,5 ,1 ,5 ,T ,95 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,6 ,5 ,1 ,3 ,F ,95 ,15
  ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,7 ,3 ,1 ,5 ,F ,95 ,15
002979 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,10 ,8 ,2 ,8 ,F ,95 ,15
002920 ,002972 ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,5 ,6 ,3 ,6 ,F ,95 ,17
009684 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,. ,4 ,2 ,6 ,F ,95 ,14
002976 ,002981 ,002906 ,002944 ,002979 ,2 ,3 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,25 ,4 ,4 ,5 ,8 ,F ,95 ,19
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,2 ,3 ,1 ,3 ,F ,95 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,6 ,4 ,1 ,6 ,T ,95 ,15
999999 ,  ,  ,  ,  ,1 ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,20 ,3 ,3 ,2 ,3 ,F ,95 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,. ,6 ,1 ,6 ,T ,95 ,15
002981 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,11 ,5 ,2 ,6 ,F ,95 ,17
  ,  ,  ,  ,  ,5 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,10 ,4 ,1 ,6 ,T ,95 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,14 ,9 ,5 ,1 ,3 ,T ,95 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,9 ,3 ,1 ,2 ,T ,95 ,10
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,10 ,10 ,6 ,1 ,6 ,T ,95 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,2 ,2 ,1 ,3 ,T ,95 ,16
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,2 ,3 ,1 ,2 ,F ,95 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,8 ,2 ,5 ,1 ,6 ,F ,95 ,16
999999 ,002935 ,002976 ,002906 ,  ,5 ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,2 ,4 ,5 ,3 ,F ,95 ,15
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,18 ,3 ,6 ,1 ,8 ,T ,95 ,6
002974 ,002906 ,003428 ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,9 ,8 ,4 ,8 ,F ,95 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,  ,1 ,1 ,0 ,1 ,0 ,0 ,. ,5 ,3 ,1 ,3 ,F ,95 ,16
002974 ,002923 ,  ,  ,  ,5 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,6 ,3 ,3 ,3 ,F ,95 ,15
002972 ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,. ,3 ,2 ,3 ,F ,95 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,15 ,9 ,6 ,1 ,6 ,T ,95 ,13
002984 ,002972 ,  ,  ,  ,3 ,3 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,11 ,8 ,3 ,5 ,F ,95 ,16
002927 ,002981 ,002944 ,  ,  ,1 ,  ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,25 ,6 ,3 ,4 ,3 ,F ,95 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,5 ,6 ,1 ,1 ,T ,95 ,13
  ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,1 ,. ,. ,8 ,1 ,8 ,F ,95 ,10
002906 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,15 ,8 ,6 ,2 ,8 ,T ,95 ,16
004033 ,002929 ,002981 ,  ,  ,2 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,1 ,6 ,4 ,6 ,F ,95 ,12
003434 ,002972 ,003425 ,002906 ,  ,2 ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,15 ,10 ,5 ,5 ,5 ,F ,95 ,19
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,11 ,6 ,1 ,6 ,F ,95 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,. ,6 ,3 ,1 ,3 ,F ,95 ,15
002944 ,002929 ,002981 ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,3 ,6 ,4 ,6 ,F ,95 ,12
002906 ,002984 ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,3 ,3 ,2 ,F ,95 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,6 ,2 ,1 ,2 ,F ,95 ,12
002974 ,002976 ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,15 ,9 ,8 ,3 ,5 ,F ,95 ,15
002976 ,003457 ,002905 ,  ,  ,3 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,3 ,3 ,5 ,F ,95 ,18
003530 ,  ,  ,  ,  ,1 ,1 ,1 ,  ,1 ,0 ,1 ,1 ,0 ,0 ,. ,7 ,3 ,2 ,1 ,T ,95 ,18
003440 ,002948 ,003456 ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,4 ,4 ,4 ,F ,95 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,3 ,3 ,1 ,. ,T ,95 ,15
002974 ,  ,  ,  ,  ,3 ,  ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,. ,3 ,2 ,5 ,F ,95 ,15
002923 ,  ,  ,  ,  ,3 ,  ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,. ,4 ,3 ,2 ,3 ,F ,95 ,13
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,11 ,5 ,1 ,3 ,T ,95 ,13
002972 ,002981 ,  ,  ,  ,1 ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,3 ,3 ,3 ,F ,95 ,17
  ,  ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,30 ,7 ,5 ,1 ,4 ,T ,95 ,13
002984 ,002976 ,002927 ,  ,  ,  ,3 ,2 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,3 ,6 ,4 ,6 ,F ,95 ,15
002923 ,002975 ,002926 ,  ,  ,1 ,3 ,2 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,4 ,4 ,3 ,F ,95 ,16
002972 ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,5 ,2 ,6 ,F ,95 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,10 ,9 ,6 ,1 ,6 ,F ,95 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,1 ,0 ,. ,12 ,4 ,1 ,3 ,T ,95 ,15
002972 ,003530 ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,9 ,6 ,3 ,5 ,F ,95 ,16
002972 ,002974 ,002927 ,002906 ,009903 ,1 ,3 ,2 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,16 ,9 ,7 ,6 ,4 ,F ,95 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,40 ,7 ,6 ,1 ,6 ,T ,95 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,30 ,8 ,3 ,1 ,3 ,T ,95 ,8
002974 ,002906 ,  ,  ,  ,4 ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,9 ,5 ,3 ,4 ,F ,95 ,15
002905 ,002972 ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,1 ,10 ,9 ,5 ,3 ,6 ,F ,95 ,15
002974 ,002906 ,001569 ,003530 ,  ,4 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,7 ,7 ,5 ,5 ,F ,95 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,4 ,3 ,1 ,. ,F ,95 ,16
002978 ,002976 ,  ,  ,  ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,3 ,3 ,5 ,F ,95 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,23 ,7 ,3 ,1 ,5 ,T ,95 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,22 ,6 ,3 ,1 ,5 ,T ,95 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,37 ,3 ,5 ,1 ,3 ,T ,95 ,5
002976 ,002981 ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,9 ,8 ,3 ,8 ,F ,95 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,3 ,1 ,3 ,F ,95 ,14
002981 ,002944 ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,8 ,5 ,2 ,8 ,T ,95 ,17
002981 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,6 ,2 ,6 ,F ,95 ,18
002976 ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,12 ,6 ,2 ,6 ,F ,95 ,15
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,11 ,6 ,1 ,8 ,T ,95 ,14
002972 ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,15 ,9 ,5 ,2 ,5 ,F ,95 ,13
003434 ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,9 ,5 ,1 ,8 ,T ,95 ,14
002972 ,999999 ,  ,  ,  ,4 ,3 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,4 ,6 ,3 ,3 ,F ,95 ,15
002981 ,  ,  ,  ,  ,5 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,11 ,7 ,2 ,6 ,F ,95 ,16
003720 ,003530 ,003754 ,001370 ,  ,4 ,  ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,12 ,5 ,5 ,6 ,F ,95 ,15
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,. ,6 ,1 ,8 ,T ,95 ,8
002974 ,002920 ,002981 ,002978 ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,2 ,5 ,5 ,5 ,F ,95 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,10 ,. ,3 ,1 ,5 ,F ,95 ,18
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,40 ,6 ,4 ,1 ,4 ,T ,95 ,12
002978 ,002984 ,  ,  ,  ,1 ,1 ,1 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,. ,5 ,3 ,3 ,3 ,F ,95 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,7 ,5 ,1 ,3 ,T ,95 ,13
002906 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,. ,5 ,2 ,8 ,F ,95 ,16
002906 ,002976 ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,. ,5 ,3 ,4 ,F ,95 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,. ,3 ,1 ,5 ,T ,95 ,17
003425 ,002972 ,002975 ,  ,  ,2 ,3 ,2 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,5 ,4 ,6 ,F ,95 ,15
002972 ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,1 ,5 ,9 ,8 ,2 ,7 ,F ,95 ,15
002972 ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,12 ,9 ,6 ,1 ,8 ,F ,95 ,15
  ,  ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,4 ,1 ,3 ,F ,95 ,14
003981 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,2 ,6 ,2 ,7 ,F ,95 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,25 ,. ,8 ,1 ,3 ,T ,95 ,12
  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,5 ,1 ,6 ,F ,95 ,17
002906 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,20 ,11 ,6 ,2 ,8 ,T ,95 ,12
002981 ,002906 ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,10 ,11 ,8 ,3 ,6 ,F ,95 ,14
003428 ,003456 ,001495 ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,8 ,4 ,8 ,F ,95 ,17
003425 ,002972 ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,8 ,3 ,8 ,F ,95 ,16
001793 ,002974 ,002976 ,002906 ,002671 ,3 ,3 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,8 ,7 ,6 ,F ,95 ,16
002972 ,  ,  ,  ,  ,5 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,12 ,8 ,2 ,8 ,T ,95 ,15
003425 ,  ,  ,  ,  ,3 ,3 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,25 ,9 ,3 ,2 ,6 ,F ,95 ,11
002967 ,002974 ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,5 ,3 ,6 ,F ,95 ,16
001610 ,  ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,29 ,1 ,3 ,2 ,3 ,T ,95 ,16
  ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,10 ,2 ,6 ,1 ,6 ,F ,95 ,12
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,. ,4 ,1 ,8 ,F ,95 ,17
002978 ,002974 ,  ,  ,  ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,. ,12 ,4 ,3 ,4 ,F ,95 ,16
003530 ,003529 ,003487 ,003523 ,001564 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,8 ,10 ,8 ,F ,95 ,15
002906 ,  ,  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,. ,6 ,2 ,8 ,F ,95 ,15
  ,  ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,35 ,11 ,5 ,1 ,6 ,T ,95 ,15
002974 ,002910 ,002906 ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,5 ,8 ,4 ,6 ,F ,95 ,14
003445 ,003434 ,002978 ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,12 ,5 ,4 ,6 ,F ,95 ,14
003425 ,001554 ,001580 ,001809 ,001564 ,2 ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,9 ,6 ,8 ,8 ,F ,95 ,15
002972 ,  ,  ,  ,  ,3 ,  ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,1 ,10 ,11 ,8 ,2 ,5 ,F ,95 ,16
  ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,23 ,. ,3 ,1 ,3 ,T ,95 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,2 ,5 ,1 ,6 ,T ,95 ,14
001598 ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,11 ,6 ,1 ,8 ,T ,95 ,13
002105 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,8 ,2 ,7 ,F ,95 ,18
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,12 ,5 ,1 ,8 ,T ,95 ,18
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,. ,3 ,1 ,6 ,T ,95 ,12
002981 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,0 ,1 ,1 ,1 ,1 ,0 ,17 ,6 ,8 ,2 ,8 ,F ,95 ,11
  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,12 ,8 ,1 ,5 ,F ,95 ,16
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,2 ,5 ,1 ,6 ,T ,95 ,12
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,30 ,9 ,4 ,1 ,4 ,T ,95 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,20 ,. ,5 ,1 ,5 ,T ,95 ,5
004033 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,15 ,5 ,3 ,2 ,6 ,T ,95 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,32 ,9 ,7 ,1 ,6 ,T ,95 ,4
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,25 ,3 ,3 ,1 ,3 ,T ,95 ,13
002906 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,8 ,7 ,2 ,7 ,T ,95 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,12 ,3 ,1 ,3 ,T ,95 ,12
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,10 ,5 ,1 ,6 ,T ,95 ,8
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,8 ,6 ,1 ,1 ,8 ,T ,95 ,13
002974 ,002906 ,002923 ,002975 ,  ,4 ,1 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,10 ,8 ,5 ,5 ,8 ,F ,95 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,10 ,. ,3 ,1 ,5 ,T ,95 ,7
002918 ,002978 ,001535 ,003434 ,  ,3 ,2 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,9 ,5 ,5 ,7 ,F ,95 ,16
002554 ,001489 ,001325 ,001350 ,  ,4 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,5 ,4 ,6 ,F ,95 ,13
001569 ,002906 ,002974 ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,12 ,8 ,4 ,8 ,F ,95 ,12
002972 ,  ,  ,  ,  ,1 ,  ,2 ,2 ,0 ,1 ,1 ,0 ,0 ,0 ,30 ,1 ,5 ,2 ,. ,F ,95 ,13
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,. ,3 ,1 ,3 ,T ,95 ,12
  ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,24 ,10 ,7 ,1 ,5 ,T ,95 ,13
002981 ,002927 ,002969 ,  ,  ,5 ,3 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,12 ,8 ,4 ,8 ,F ,95 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,1 ,5 ,T ,95 ,6
  ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,4 ,8 ,1 ,6 ,T ,95 ,16
002923 ,002972 ,002984 ,  ,  ,4 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,28 ,9 ,1 ,4 ,3 ,T ,95 ,13
003125 ,003051 ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,3 ,8 ,T ,95 ,17
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,0 ,0 ,1 ,0 ,1 ,0 ,. ,11 ,8 ,1 ,8 ,T ,95 ,5
002536 ,002053 ,003185 ,003042 ,003100 ,5 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,. ,11 ,6 ,7 ,8 ,F ,95 ,16
002944 ,  ,  ,  ,  ,2 ,  ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,12 ,3 ,2 ,3 ,T ,95 ,6
009068 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,0 ,1 ,1 ,0 ,1 ,0 ,10 ,11 ,6 ,2 ,5 ,F ,95 ,16
  ,  ,  ,  ,  ,4 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,8 ,6 ,1 ,8 ,T ,95 ,3
002906 ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,6 ,5 ,2 ,8 ,F ,95 ,15
003798 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,3 ,3 ,2 ,5 ,T ,95 ,16
001598 ,003875 ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,11 ,6 ,3 ,7 ,F ,95 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,30 ,5 ,4 ,1 ,5 ,F ,95 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,4 ,2 ,1 ,2 ,F ,95 ,16
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,40 ,9 ,4 ,1 ,5 ,T ,95 ,8
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,3 ,1 ,1 ,T ,95 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,18 ,4 ,3 ,1 ,4 ,T ,95 ,12
  ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,9 ,6 ,1 ,3 ,T ,95 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,65 ,3 ,5 ,1 ,6 ,T ,95 ,7
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,12 ,8 ,1 ,3 ,T ,95 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,0 ,0 ,0 ,1 ,0 ,0 ,10 ,. ,6 ,1 ,8 ,T ,95 ,14
002906 ,  ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,20 ,9 ,4 ,2 ,7 ,T ,95 ,12
001487 ,003434 ,003428 ,  ,  ,3 ,1 ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,12 ,6 ,8 ,4 ,5 ,F ,95 ,15
  ,  ,  ,  ,  ,3 ,3 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,5 ,1 ,6 ,T ,95 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,16 ,8 ,3 ,1 ,5 ,T ,95 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,30 ,7 ,5 ,1 ,6 ,T ,95 ,13
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,25 ,5 ,7 ,1 ,7 ,T ,95 ,10
002979 ,002972 ,002975 ,  ,  ,2 ,3 ,1 ,  ,1 ,1 ,0 ,0 ,1 ,0 ,. ,12 ,6 ,4 ,8 ,F ,95 ,14
001739 ,001775 ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,25 ,11 ,8 ,3 ,8 ,T ,95 ,14
  ,  ,  ,  ,  ,5 ,3 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,. ,3 ,1 ,3 ,T ,95 ,13
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,7 ,6 ,1 ,6 ,T ,95 ,13
002972 ,  ,  ,  ,  ,  ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,8 ,6 ,2 ,6 ,F ,95 ,15
003754 ,002918 ,001780 ,  ,  ,4 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,4 ,6 ,3 ,8 ,F ,95 ,15
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,36 ,3 ,3 ,1 ,3 ,T ,95 ,5
004033 ,  ,  ,  ,  ,2 ,1 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,5 ,2 ,6 ,T ,95 ,16
  ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,12 ,9 ,6 ,1 ,8 ,T ,95 ,18
  ,  ,  ,  ,  ,3 ,1 ,  ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,15 ,. ,6 ,1 ,8 ,T ,95 ,15
002975 ,002976 ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,8 ,3 ,8 ,F ,95 ,14
  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,. ,3 ,5 ,1 ,4 ,F ,95 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,10 ,5 ,1 ,8 ,T ,95 ,4
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,9 ,4 ,1 ,6 ,T ,95 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,16 ,4 ,5 ,1 ,5 ,T ,95 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,1 ,25 ,. ,5 ,1 ,3 ,T ,95 ,11
001776 ,001671 ,003969 ,002358 ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,. ,. ,5 ,. ,T ,95 ,14
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,15 ,. ,6 ,1 ,5 ,T ,95 ,10
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,40 ,5 ,3 ,1 ,3 ,T ,95 ,7
003658 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,12 ,7 ,5 ,2 ,8 ,T ,95 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,. ,3 ,1 ,3 ,T ,95 ,8
002975 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,15 ,11 ,8 ,2 ,8 ,F ,95 ,17
002927 ,002914 ,003711 ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,6 ,4 ,8 ,F ,95 ,17
  ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,30 ,6 ,5 ,1 ,5 ,T ,95 ,9
001999 ,007893 ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,8 ,3 ,8 ,F ,95 ,17
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,11 ,6 ,1 ,6 ,T ,95 ,18
002906 ,001989 ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,12 ,6 ,3 ,6 ,F ,95 ,15
002984 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,6 ,2 ,5 ,F ,95 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,12 ,7 ,8 ,1 ,6 ,F ,95 ,15
002972 ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,12 ,6 ,2 ,6 ,F ,95 ,16
003487 ,003523 ,003535 ,003530 ,  ,4 ,3 ,3 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,7 ,3 ,5 ,3 ,F ,95 ,15
003624 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,18 ,12 ,4 ,2 ,8 ,T ,95 ,15
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,7 ,5 ,1 ,3 ,T ,95 ,13
002976 ,002984 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,7 ,8 ,3 ,6 ,F ,95 ,16
003487 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,10 ,6 ,2 ,6 ,F ,95 ,13
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,. ,6 ,1 ,8 ,F ,95 ,17
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,30 ,9 ,6 ,1 ,8 ,T ,95 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,7 ,5 ,1 ,8 ,T ,95 ,15
  ,  ,  ,  ,  ,4 ,1 ,3 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,10 ,8 ,1 ,6 ,T ,95 ,16
003721 ,002918 ,  ,  ,  ,5 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,6 ,3 ,6 ,F ,95 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,1 ,5 ,1 ,3 ,F ,95 ,17
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,40 ,4 ,5 ,1 ,3 ,T ,95 ,8
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,25 ,8 ,7 ,1 ,8 ,T ,95 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,3 ,5 ,1 ,2 ,T ,95 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,23 ,10 ,4 ,1 ,7 ,T ,95 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,28 ,8 ,3 ,1 ,5 ,T ,95 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,35 ,. ,5 ,1 ,5 ,T ,95 ,11
003425 ,002972 ,002981 ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,3 ,3 ,4 ,5 ,F ,95 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,40 ,2 ,6 ,1 ,6 ,T ,95 ,7
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,. ,9 ,8 ,1 ,6 ,T ,95 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,0 ,0 ,1 ,1 ,1 ,0 ,20 ,6 ,6 ,1 ,6 ,T ,95 ,11
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,16 ,12 ,6 ,1 ,8 ,T ,95 ,19
002984 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,18 ,10 ,6 ,2 ,5 ,T ,95 ,12
002906 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,4 ,6 ,2 ,8 ,F ,95 ,15
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,10 ,9 ,3 ,1 ,8 ,F ,95 ,16
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,8 ,8 ,1 ,4 ,F ,95 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,36 ,2 ,2 ,1 ,2 ,T ,95 ,8
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,25 ,9 ,8 ,1 ,8 ,T ,95 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,40 ,12 ,4 ,1 ,3 ,T ,95 ,12
001507 ,002974 ,002918 ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,12 ,3 ,4 ,6 ,F ,95 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,3 ,5 ,1 ,5 ,T ,95 ,15
002382 ,003675 ,002536 ,001349 ,002532 ,3 ,3 ,  ,1 ,0 ,1 ,1 ,0 ,1 ,0 ,. ,. ,7 ,6 ,8 ,F ,95 ,15
002913 ,002927 ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,8 ,6 ,3 ,6 ,F ,95 ,17
  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,5 ,1 ,6 ,F ,95 ,18
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,2 ,1 ,8 ,1 ,8 ,F ,95 ,16
001955 ,  ,  ,  ,  ,2 ,3 ,1 ,  ,1 ,1 ,0 ,0 ,1 ,0 ,. ,5 ,8 ,2 ,8 ,F ,95 ,15
001753 ,002080 ,007468 ,002972 ,002906 ,3 ,  ,3 ,1 ,0 ,0 ,1 ,1 ,1 ,0 ,. ,3 ,5 ,7 ,3 ,F ,95 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,24 ,. ,3 ,1 ,5 ,T ,95 ,5
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,3 ,1 ,3 ,F ,95 ,15
001564 ,  ,  ,  ,  ,4 ,1 ,2 ,2 ,0 ,0 ,1 ,0 ,1 ,0 ,12 ,3 ,6 ,2 ,8 ,T ,95 ,22
002974 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,11 ,6 ,2 ,8 ,F ,95 ,18
  ,  ,  ,  ,  ,1 ,1 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,45 ,6 ,3 ,1 ,3 ,T ,95 ,3
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,. ,6 ,1 ,6 ,F ,95 ,17
008155 ,003010 ,002894 ,  ,  ,4 ,3 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,8 ,4 ,8 ,F ,95 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,11 ,6 ,1 ,8 ,T ,95 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,0 ,0 ,0 ,1 ,0 ,0 ,40 ,9 ,8 ,1 ,8 ,T ,95 ,5
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,12 ,3 ,1 ,6 ,T ,95 ,16
001305 ,002920 ,002155 ,002573 ,002627 ,4 ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,12 ,7 ,8 ,8 ,F ,95 ,19
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,18 ,8 ,6 ,1 ,6 ,T ,95 ,19
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,12 ,8 ,1 ,8 ,F ,95 ,15
  ,  ,  ,  ,  ,5 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,11 ,8 ,1 ,8 ,T ,95 ,14
001325 ,002542 ,001302 ,002540 ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,12 ,6 ,5 ,6 ,F ,95 ,13
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,4 ,6 ,1 ,8 ,T ,95 ,8
001489 ,002554 ,001370 ,001325 ,001328 ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,4 ,6 ,7 ,8 ,F ,95 ,14
  ,  ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,60 ,12 ,5 ,1 ,8 ,T ,95 ,8
002984 ,002981 ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,8 ,3 ,4 ,F ,95 ,16
009684 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,3 ,2 ,2 ,T ,95 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,12 ,5 ,8 ,1 ,8 ,T ,95 ,18
001082 ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,18 ,12 ,7 ,2 ,5 ,F ,95 ,15
003746 ,008155 ,001083 ,003677 ,003223 ,5 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,12 ,6 ,7 ,8 ,F ,95 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,18 ,1 ,4 ,1 ,3 ,T ,95 ,15
009930 ,  ,  ,  ,  ,3 ,1 ,3 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,10 ,5 ,2 ,5 ,T ,95 ,6
002974 ,002984 ,003428 ,  ,  ,5 ,3 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,12 ,8 ,4 ,8 ,F ,95 ,16
002972 ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,2 ,5 ,2 ,2 ,F ,95 ,17
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,8 ,6 ,1 ,6 ,T ,95 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,1 ,0 ,. ,9 ,3 ,1 ,6 ,T ,95 ,15
  ,  ,  ,  ,  ,4 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,4 ,5 ,1 ,5 ,T ,95 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,50 ,8 ,5 ,1 ,8 ,T ,95 ,4
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,12 ,5 ,1 ,8 ,T ,95 ,13
001151 ,001325 ,001154 ,001488 ,002554 ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,6 ,7 ,5 ,F ,95 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,9 ,7 ,1 ,7 ,F ,95 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,2 ,2 ,1 ,. ,T ,95 ,14
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,. ,5 ,1 ,6 ,F ,95 ,14
003434 ,003457 ,002957 ,003534 ,001495 ,4 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,12 ,8 ,6 ,8 ,F ,95 ,16
002981 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,2 ,3 ,2 ,3 ,F ,95 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,8 ,3 ,1 ,5 ,F ,95 ,16
001009 ,002981 ,003456 ,  ,  ,5 ,  ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,12 ,11 ,6 ,4 ,6 ,F ,95 ,16
  ,  ,  ,  ,  ,5 ,1 ,3 ,2 ,1 ,0 ,0 ,0 ,1 ,1 ,30 ,3 ,6 ,1 ,7 ,T ,95 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,2 ,3 ,1 ,5 ,F ,95 ,15
001535 ,001489 ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,10 ,3 ,3 ,4 ,F ,95 ,12
  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,8 ,1 ,5 ,T ,95 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,30 ,9 ,6 ,1 ,8 ,T ,95 ,12
  ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,11 ,3 ,1 ,5 ,T ,95 ,17
003434 ,003428 ,002906 ,001598 ,003744 ,4 ,3 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,7 ,6 ,6 ,8 ,F ,95 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,9 ,3 ,1 ,4 ,T ,95 ,12
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,6 ,5 ,1 ,4 ,T ,95 ,14
002972 ,002984 ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,11 ,6 ,3 ,4 ,T ,95 ,15
001489 ,001535 ,003434 ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,12 ,8 ,4 ,8 ,F ,95 ,14
002976 ,002927 ,001536 ,  ,  ,3 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,18 ,7 ,5 ,4 ,6 ,F ,95 ,14
002944 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,6 ,2 ,8 ,F ,95 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,24 ,7 ,5 ,1 ,5 ,T ,95 ,11
002981 ,001564 ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,12 ,6 ,3 ,6 ,F ,95 ,15
  ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,0 ,0 ,1 ,1 ,1 ,1 ,15 ,7 ,5 ,1 ,5 ,T ,95 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,15 ,6 ,3 ,1 ,3 ,T ,95 ,6
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,7 ,6 ,1 ,6 ,T ,95 ,6
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,20 ,6 ,6 ,1 ,5 ,T ,95 ,21
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,5 ,6 ,1 ,6 ,F ,95 ,12
002976 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,. ,5 ,2 ,4 ,F ,95 ,16
001554 ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,9 ,5 ,2 ,8 ,T ,95 ,16
001083 ,003663 ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,12 ,2 ,4 ,3 ,5 ,T ,95 ,15
001903 ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,11 ,5 ,2 ,6 ,F ,95 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,11 ,6 ,1 ,6 ,T ,95 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,24 ,6 ,5 ,1 ,6 ,T ,95 ,17
002981 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,1 ,1 ,2 ,1 ,T ,95 ,15
999998 ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,2 ,5 ,2 ,6 ,F ,95 ,16
003955 ,001495 ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,6 ,5 ,6 ,F ,95 ,14
002013 ,003529 ,002016 ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,4 ,4 ,8 ,F ,95 ,15
002209 ,  ,  ,  ,  ,5 ,3 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,1 ,10 ,4 ,2 ,2 ,3 ,F ,95 ,16
999998 ,001892 ,003100 ,002554 ,001495 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,9 ,5 ,18 ,3 ,T ,95 ,15
002358 ,002218 ,  ,  ,  ,5 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,1 ,3 ,2 ,T ,95 ,12


/* db96.dat */

002972 ,002976 ,002923 ,002906 ,  ,5 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,11 ,3 ,5 ,7 ,F ,96 ,14
002053 ,002882 ,003696 ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,12 ,4 ,4 ,8 ,F ,96 ,16
001830 ,002101 ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,3 ,3 ,2 ,F ,96 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,8 ,2 ,1 ,2 ,F ,96 ,13
002895 ,002139 ,002603 ,002073 ,002108 ,1 ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,7 ,6 ,5 ,F ,96 ,15
002972 ,002974 ,003496 ,003298 ,  ,2 ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,8 ,3 ,5 ,5 ,F ,96 ,15
002906 ,002984 ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,. ,5 ,3 ,7 ,F ,96 ,13
003733 ,003414 ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,10 ,7 ,5 ,3 ,2 ,F ,96 ,14
002976 ,002974 ,002984 ,002927 ,  ,5 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,11 ,7 ,5 ,4 ,F ,96 ,17
002974 ,002976 ,002975 ,002972 ,  ,3 ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,. ,4 ,5 ,5 ,F ,96 ,15
002979 ,002038 ,002701 ,004661 ,029013 ,1 ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,10 ,7 ,7 ,7 ,F ,96 ,17
003981 ,002978 ,  ,  ,  ,1 ,3 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,6 ,3 ,5 ,3 ,4 ,F ,96 ,16
003721 ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,11 ,7 ,2 ,7 ,F ,96 ,17
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,11 ,7 ,1 ,5 ,F ,96 ,15
002968 ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,3 ,2 ,3 ,F ,96 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,18 ,6 ,2 ,1 ,1 ,T ,96 ,16
001444 ,001434 ,002836 ,002845 ,003238 ,2 ,3 ,3 ,  ,1 ,1 ,1 ,0 ,1 ,0 ,. ,12 ,5 ,6 ,5 ,F ,96 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,20 ,13 ,7 ,1 ,7 ,T ,96 ,17
001417 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,4 ,2 ,2 ,2 ,T ,96 ,19
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,0 ,1 ,1 ,0 ,1 ,0 ,25 ,2 ,3 ,1 ,7 ,T ,96 ,16
006968 ,001825 ,002975 ,002974 ,003754 ,5 ,3 ,2 ,2 ,1 ,0 ,1 ,1 ,0 ,1 ,8 ,12 ,8 ,6 ,8 ,T ,96 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,10 ,. ,2 ,1 ,2 ,F ,96 ,9
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,11 ,7 ,1 ,8 ,T ,96 ,17
  ,  ,  ,  ,  ,5 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,. ,7 ,1 ,4 ,F ,96 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,30 ,3 ,2 ,1 ,2 ,T ,96 ,19
002984 ,002923 ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,. ,2 ,3 ,3 ,T ,96 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,12 ,. ,2 ,1 ,2 ,T ,96 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,. ,. ,7 ,1 ,7 ,T ,96 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,. ,. ,3 ,1 ,3 ,T ,96 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,22 ,11 ,3 ,1 ,7 ,T ,96 ,14
002974 ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,8 ,4 ,2 ,8 ,F ,96 ,12
001426 ,003744 ,  ,  ,  ,4 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,7 ,3 ,7 ,F ,96 ,15
002975 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,. ,5 ,2 ,4 ,F ,96 ,15
002978 ,003256 ,002616 ,003448 ,003705 ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,. ,5 ,8 ,5 ,F ,96 ,15
006964 ,003238 ,001431 ,003558 ,002942 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,4 ,6 ,5 ,F ,96 ,15
  ,  ,  ,  ,  ,4 ,3 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,4 ,1 ,3 ,F ,96 ,14
002939 ,002981 ,002906 ,002976 ,002930 ,5 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,12 ,5 ,6 ,3 ,F ,96 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,5 ,2 ,1 ,3 ,F ,96 ,16
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,5 ,1 ,1 ,T ,96 ,12
  ,  ,  ,  ,  ,2 ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,12 ,2 ,1 ,4 ,T ,96 ,17
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,2 ,1 ,5 ,F ,96 ,18
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,7 ,5 ,1 ,8 ,T ,96 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,4 ,5 ,1 ,5 ,F ,96 ,15
002798 ,002105 ,001431 ,001444 ,003322 ,4 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,10 ,13 ,7 ,6 ,7 ,F ,96 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,3 ,1 ,2 ,T ,96 ,17
009684 ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,30 ,. ,3 ,2 ,5 ,T ,96 ,13
001536 ,003392 ,  ,  ,  ,1 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,2 ,3 ,4 ,F ,96 ,16
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,0 ,0 ,1 ,0 ,1 ,0 ,15 ,8 ,7 ,1 ,7 ,F ,96 ,17
002974 ,002933 ,002103 ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,10 ,5 ,4 ,7 ,F ,96 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,10 ,5 ,4 ,1 ,3 ,F ,96 ,15
  ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,0 ,1 ,1 ,0 ,1 ,0 ,40 ,7 ,3 ,1 ,7 ,F ,96 ,13
006965 ,002913 ,002975 ,003268 ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,6 ,3 ,5 ,5 ,F ,96 ,14
  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,3 ,1 ,2 ,T ,96 ,15
002906 ,  ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,2 ,2 ,3 ,F ,96 ,14
002105 ,002091 ,002984 ,  ,  ,5 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,12 ,5 ,4 ,7 ,F ,96 ,18
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,9 ,2 ,1 ,3 ,F ,96 ,11
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,3 ,1 ,1 ,T ,96 ,17
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,7 ,4 ,1 ,2 ,T ,96 ,12
003827 ,002974 ,003448 ,006968 ,  ,2 ,3 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,35 ,8 ,2 ,5 ,2 ,F ,96 ,12
003746 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,5 ,7 ,2 ,. ,F ,96 ,16
003768 ,006968 ,003705 ,003721 ,  ,3 ,2 ,3 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,. ,3 ,5 ,5 ,F ,96 ,18
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,9 ,2 ,1 ,3 ,F ,96 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,20 ,4 ,3 ,1 ,4 ,T ,96 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,24 ,. ,3 ,1 ,5 ,T ,96 ,13
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,11 ,2 ,1 ,8 ,T ,96 ,14
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,30 ,7 ,7 ,1 ,8 ,T ,96 ,16
  ,  ,  ,  ,  ,3 ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,12 ,7 ,2 ,1 ,2 ,F ,96 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,7 ,5 ,1 ,4 ,T ,96 ,16
002951 ,002972 ,  ,  ,  ,5 ,3 ,3 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,. ,2 ,3 ,3 ,F ,96 ,15
004839 ,003827 ,003822 ,003815 ,008084 ,3 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,8 ,10 ,5 ,10 ,3 ,F ,96 ,14
002974 ,002906 ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,11 ,7 ,3 ,4 ,F ,96 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,6 ,4 ,1 ,4 ,F ,96 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,. ,2 ,1 ,1 ,T ,96 ,15
002981 ,002906 ,002984 ,002912 ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,8 ,5 ,5 ,5 ,F ,96 ,16
003487 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,25 ,1 ,5 ,2 ,7 ,T ,96 ,12
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,8 ,12 ,5 ,1 ,5 ,T ,96 ,14
002984 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,8 ,5 ,2 ,8 ,F ,96 ,15
002978 ,002974 ,002920 ,002906 ,002972 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,7 ,6 ,8 ,F ,96 ,13
002981 ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,3 ,2 ,2 ,5 ,F ,96 ,16
002984 ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,. ,8 ,5 ,2 ,5 ,T ,96 ,14
  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,9 ,2 ,1 ,3 ,F ,96 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,14 ,5 ,1 ,5 ,F ,96 ,13
002972 ,002906 ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,30 ,11 ,5 ,3 ,6 ,T ,96 ,13
003441 ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,8 ,3 ,2 ,5 ,F ,96 ,15
002948 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,7 ,2 ,2 ,1 ,T ,96 ,14
002913 ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,3 ,2 ,2 ,F ,96 ,14
  ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,2 ,1 ,2 ,F ,96 ,15
003734 ,002974 ,  ,  ,  ,3 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,7 ,3 ,7 ,F ,96 ,15
002976 ,002906 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,3 ,3 ,5 ,F ,96 ,14
002913 ,002941 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,14 ,4 ,3 ,3 ,F ,96 ,15
  ,  ,  ,  ,  ,3 ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,8 ,6 ,1 ,7 ,F ,96 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,4 ,2 ,1 ,2 ,F ,96 ,12
002979 ,002948 ,002906 ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,11 ,5 ,4 ,4 ,F ,96 ,14
002974 ,  ,  ,  ,  ,3 ,  ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,30 ,12 ,1 ,2 ,1 ,F ,96 ,14
002981 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,6 ,1 ,2 ,1 ,F ,96 ,17
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,5 ,2 ,1 ,2 ,F ,96 ,17
002972 ,  ,  ,  ,  ,2 ,2 ,2 ,  ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,5 ,2 ,2 ,F ,96 ,16
  ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,7 ,3 ,1 ,3 ,F ,96 ,14
002984 ,002975 ,002976 ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,7 ,3 ,4 ,3 ,F ,96 ,16
002972 ,002975 ,  ,  ,  ,1 ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,3 ,3 ,3 ,F ,96 ,16
002981 ,002979 ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,9 ,2 ,3 ,3 ,F ,96 ,14
003721 ,002974 ,002906 ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,7 ,3 ,4 ,5 ,F ,96 ,19
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,10 ,8 ,4 ,1 ,5 ,F ,96 ,19
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,22 ,10 ,2 ,1 ,4 ,T ,96 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,28 ,8 ,3 ,1 ,7 ,T ,96 ,15
002981 ,002906 ,  ,  ,  ,4 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,5 ,3 ,5 ,F ,96 ,17
002927 ,002906 ,  ,  ,  ,3 ,3 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,. ,. ,7 ,3 ,5 ,F ,96 ,15
002929 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,11 ,4 ,2 ,4 ,F ,96 ,15
001598 ,  ,  ,  ,  ,2 ,  ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,4 ,2 ,5 ,F ,96 ,15
002974 ,002906 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,11 ,8 ,3 ,8 ,F ,96 ,17
002981 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,15 ,8 ,2 ,1 ,3 ,F ,96 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,0 ,0 ,1 ,0 ,0 ,0 ,40 ,14 ,7 ,1 ,8 ,T ,96 ,3
002976 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,8 ,3 ,2 ,7 ,F ,96 ,16
002972 ,002975 ,002905 ,  ,  ,4 ,2 ,3 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,8 ,5 ,4 ,5 ,F ,96 ,17
  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,8 ,3 ,1 ,3 ,F ,96 ,14
004033 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,16 ,11 ,4 ,2 ,5 ,F ,96 ,15
  ,  ,  ,  ,  ,5 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,3 ,1 ,7 ,F ,96 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,8 ,. ,1 ,. ,T ,96 ,13
002981 ,002976 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,4 ,4 ,3 ,. ,F ,96 ,16
004033 ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,32 ,3 ,3 ,2 ,2 ,T ,96 ,10
002976 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,10 ,8 ,2 ,2 ,3 ,F ,96 ,15
  ,  ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,28 ,6 ,3 ,1 ,3 ,T ,96 ,11
001671 ,002923 ,002906 ,002927 ,  ,3 ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,12 ,7 ,5 ,5 ,F ,96 ,15
002944 ,002975 ,002954 ,  ,  ,1 ,3 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,7 ,4 ,8 ,F ,96 ,14
002972 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,7 ,4 ,2 ,7 ,T ,96 ,12
002906 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,6 ,2 ,5 ,F ,96 ,17
002972 ,002974 ,  ,  ,  ,4 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,7 ,3 ,7 ,F ,96 ,17
002906 ,002984 ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,. ,7 ,3 ,7 ,F ,96 ,13
002906 ,  ,  ,  ,  ,3 ,3 ,3 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,7 ,5 ,2 ,5 ,F ,96 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,7 ,1 ,1 ,1 ,T ,96 ,13
002976 ,002975 ,002906 ,  ,  ,5 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,5 ,4 ,5 ,F ,96 ,14
003487 ,002906 ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,8 ,1 ,3 ,3 ,1 ,F ,96 ,16
003496 ,001563 ,  ,  ,  ,2 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,18 ,8 ,6 ,3 ,5 ,F ,96 ,12
002923 ,002906 ,002974 ,002948 ,002916 ,2 ,1 ,3 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,5 ,2 ,6 ,3 ,F ,96 ,16
  ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,3 ,4 ,1 ,4 ,T ,96 ,11
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,6 ,7 ,1 ,6 ,T ,96 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,8 ,5 ,1 ,7 ,T ,96 ,3
002981 ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,. ,5 ,2 ,5 ,F ,96 ,17
002927 ,003457 ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,5 ,3 ,5 ,F ,96 ,15
002906 ,002950 ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,2 ,1 ,3 ,. ,F ,96 ,15
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,9 ,6 ,1 ,7 ,F ,96 ,16
009684 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,. ,5 ,2 ,3 ,T ,96 ,12
003425 ,002972 ,002906 ,002929 ,002976 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,. ,2 ,6 ,5 ,F ,96 ,15
  ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,12 ,8 ,7 ,1 ,5 ,F ,96 ,14
  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,12 ,5 ,1 ,8 ,F ,96 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,6 ,2 ,1 ,4 ,T ,96 ,16
002984 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,. ,2 ,2 ,6 ,T ,96 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,. ,4 ,1 ,4 ,T ,96 ,16
  ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,3 ,1 ,2 ,F ,96 ,15
  ,  ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,5 ,6 ,1 ,6 ,F ,96 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,7 ,4 ,1 ,4 ,T ,96 ,14
  ,  ,  ,  ,  ,4 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,3 ,1 ,3 ,F ,96 ,17
002974 ,  ,  ,  ,  ,3 ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,7 ,4 ,2 ,4 ,F ,96 ,12
002972 ,002976 ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,25 ,7 ,3 ,3 ,2 ,F ,96 ,14
002906 ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,1 ,3 ,2 ,2 ,F ,96 ,15
002906 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,9 ,5 ,2 ,4 ,T ,96 ,16
002981 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,22 ,3 ,2 ,2 ,2 ,T ,96 ,14
002981 ,002906 ,002923 ,  ,  ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,7 ,4 ,5 ,F ,96 ,16
002976 ,002981 ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,6 ,3 ,3 ,3 ,2 ,F ,96 ,14
002981 ,002923 ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,22 ,3 ,2 ,3 ,. ,F ,96 ,14
002981 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,9 ,2 ,2 ,2 ,T ,96 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,22 ,4 ,3 ,1 ,5 ,F ,96 ,16
002975 ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,4 ,2 ,4 ,F ,96 ,15
002948 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,. ,8 ,5 ,2 ,5 ,F ,96 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,6 ,2 ,1 ,2 ,F ,96 ,16
002974 ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,14 ,5 ,2 ,3 ,F ,96 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,4 ,1 ,3 ,F ,96 ,15
  ,  ,  ,  ,  ,3 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,2 ,1 ,2 ,F ,96 ,16
002974 ,002978 ,003705 ,002972 ,  ,1 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,7 ,4 ,2 ,F ,96 ,15
002927 ,002945 ,003484 ,002957 ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,12 ,12 ,4 ,5 ,3 ,F ,96 ,18
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,20 ,9 ,4 ,1 ,4 ,T ,96 ,16
002974 ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,10 ,13 ,7 ,2 ,8 ,T ,96 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,4 ,2 ,1 ,4 ,T ,96 ,17
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,35 ,11 ,4 ,1 ,2 ,T ,96 ,14
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,20 ,7 ,2 ,1 ,5 ,T ,96 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,5 ,1 ,1 ,1 ,T ,96 ,7
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,18 ,. ,3 ,1 ,3 ,T ,96 ,12
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,25 ,3 ,5 ,1 ,6 ,T ,96 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,5 ,1 ,5 ,T ,96 ,16
002974 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,12 ,3 ,2 ,2 ,2 ,F ,96 ,18
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,6 ,9 ,5 ,1 ,5 ,F ,96 ,15
  ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,2 ,1 ,5 ,F ,96 ,15
002906 ,  ,  ,  ,  ,4 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,6 ,2 ,3 ,F ,96 ,14
002894 ,002906 ,002927 ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,8 ,7 ,4 ,7 ,F ,96 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,6 ,2 ,1 ,1 ,T ,96 ,14
  ,  ,  ,  ,  ,5 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,3 ,1 ,7 ,F ,96 ,15
002929 ,002927 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,2 ,3 ,2 ,F ,96 ,18
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,19 ,1 ,1 ,1 ,1 ,T ,96 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,10 ,2 ,1 ,4 ,F ,96 ,13
  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,4 ,2 ,1 ,5 ,T ,96 ,16
002972 ,002975 ,  ,  ,  ,2 ,2 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,4 ,2 ,3 ,5 ,F ,96 ,12
002923 ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,10 ,. ,7 ,2 ,5 ,F ,96 ,17
002981 ,002906 ,002974 ,002976 ,  ,5 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,3 ,5 ,5 ,F ,96 ,15
002975 ,002910 ,003456 ,  ,  ,5 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,9 ,4 ,4 ,3 ,F ,96 ,16
001083 ,001081 ,001009 ,001052 ,010313 ,1 ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,. ,11 ,5 ,7 ,8 ,F ,96 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,35 ,8 ,7 ,1 ,4 ,T ,96 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,7 ,5 ,1 ,4 ,T ,96 ,14
004840 ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,3 ,1 ,1 ,2 ,F ,96 ,15
002972 ,002923 ,002976 ,002975 ,  ,3 ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,28 ,8 ,. ,5 ,. ,F ,96 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,3 ,1 ,2 ,F ,96 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,7 ,7 ,1 ,2 ,T ,96 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,24 ,6 ,2 ,1 ,3 ,T ,96 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,11 ,4 ,1 ,4 ,T ,96 ,14
002972 ,  ,  ,  ,  ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,2 ,2 ,1 ,F ,96 ,16
002976 ,002930 ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,24 ,5 ,2 ,3 ,. ,F ,96 ,13
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,10 ,4 ,1 ,4 ,T ,96 ,16
002981 ,  ,  ,  ,  ,2 ,2 ,1 ,  ,1 ,1 ,0 ,1 ,0 ,0 ,. ,6 ,4 ,2 ,2 ,F ,96 ,15
002976 ,002981 ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,8 ,2 ,3 ,3 ,F ,96 ,13
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,3 ,3 ,1 ,2 ,F ,96 ,13
002972 ,  ,  ,  ,  ,5 ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,18 ,11 ,2 ,2 ,5 ,T ,96 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,7 ,3 ,1 ,5 ,F ,96 ,15
002972 ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,10 ,4 ,3 ,2 ,3 ,F ,96 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,5 ,2 ,1 ,4 ,T ,96 ,18
002906 ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,15 ,3 ,2 ,2 ,3 ,F ,96 ,8
002984 ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,3 ,2 ,5 ,F ,96 ,15
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,7 ,4 ,1 ,2 ,F ,96 ,13
002913 ,002974 ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,8 ,7 ,3 ,5 ,F ,96 ,17
002974 ,  ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,15 ,7 ,1 ,2 ,3 ,F ,96 ,17
002906 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,10 ,3 ,2 ,4 ,F ,96 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,12 ,5 ,1 ,7 ,T ,96 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,. ,4 ,1 ,. ,T ,96 ,13
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,9 ,5 ,1 ,5 ,T ,96 ,12
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,5 ,12 ,7 ,1 ,8 ,T ,96 ,15
003425 ,001431 ,002984 ,002923 ,002906 ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,14 ,7 ,6 ,8 ,F ,96 ,17
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,35 ,. ,. ,1 ,. ,T ,96 ,13
002974 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,10 ,. ,. ,2 ,. ,F ,96 ,12
002981 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,5 ,2 ,3 ,F ,96 ,13
003754 ,002972 ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,13 ,5 ,3 ,8 ,F ,96 ,16
  ,  ,  ,  ,  ,4 ,  ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,10 ,4 ,1 ,4 ,F ,96 ,16
  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,9 ,5 ,1 ,2 ,F ,96 ,16
002976 ,002981 ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,28 ,5 ,2 ,3 ,3 ,F ,96 ,12
002984 ,002906 ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,1 ,7 ,3 ,5 ,F ,96 ,13
002906 ,002984 ,002944 ,  ,  ,1 ,1 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,28 ,7 ,4 ,4 ,3 ,F ,96 ,15
002906 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,5 ,2 ,2 ,2 ,F ,96 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,. ,3 ,1 ,2 ,T ,96 ,12
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,25 ,8 ,5 ,1 ,7 ,T ,96 ,12
002974 ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,8 ,9 ,7 ,2 ,6 ,F ,96 ,13
002981 ,004033 ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,11 ,4 ,3 ,3 ,F ,96 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,10 ,7 ,1 ,1 ,3 ,F ,96 ,15
  ,  ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,11 ,4 ,1 ,1 ,F ,96 ,16
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,5 ,1 ,3 ,F ,96 ,16
001347 ,001353 ,008155 ,002906 ,003197 ,3 ,  ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,15 ,12 ,3 ,6 ,8 ,F ,96 ,15
002974 ,002906 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,4 ,3 ,5 ,F ,96 ,17
002972 ,002984 ,002906 ,002979 ,002927 ,3 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,5 ,6 ,4 ,F ,96 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,12 ,9 ,3 ,1 ,4 ,F ,96 ,16
002906 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,8 ,2 ,2 ,2 ,F ,96 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,. ,7 ,1 ,5 ,T ,96 ,15
  ,  ,  ,  ,  ,3 ,2 ,3 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,7 ,1 ,5 ,F ,96 ,15
  ,  ,  ,  ,  ,4 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,9 ,3 ,1 ,2 ,F ,96 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,35 ,4 ,1 ,1 ,2 ,F ,96 ,14
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,12 ,9 ,3 ,1 ,4 ,F ,96 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,7 ,5 ,1 ,3 ,T ,96 ,15
002974 ,002972 ,002906 ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,. ,7 ,4 ,8 ,F ,96 ,15
002974 ,001448 ,003535 ,003478 ,  ,3 ,  ,3 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,. ,3 ,5 ,3 ,F ,96 ,13
002941 ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,5 ,2 ,5 ,F ,96 ,14
002972 ,002981 ,002974 ,  ,  ,3 ,2 ,3 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,25 ,8 ,3 ,4 ,2 ,F ,96 ,12
002976 ,  ,  ,  ,  ,2 ,  ,1 ,  ,1 ,0 ,0 ,0 ,1 ,0 ,. ,9 ,2 ,2 ,4 ,F ,96 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,22 ,7 ,3 ,1 ,2 ,F ,96 ,16
002073 ,002931 ,  ,  ,  ,5 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,8 ,5 ,3 ,4 ,F ,96 ,15
002976 ,002920 ,002936 ,  ,  ,4 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,8 ,2 ,4 ,3 ,F ,96 ,14
002974 ,  ,  ,  ,  ,4 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,11 ,7 ,2 ,7 ,F ,96 ,15
002974 ,002906 ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,8 ,3 ,8 ,F ,96 ,15
002906 ,  ,  ,  ,  ,4 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,12 ,5 ,2 ,7 ,F ,96 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,12 ,9 ,3 ,1 ,2 ,F ,96 ,16
  ,  ,  ,  ,  ,1 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,2 ,1 ,2 ,F ,96 ,13
002972 ,001321 ,002923 ,002974 ,001149 ,3 ,3 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,8 ,. ,7 ,7 ,3 ,F ,96 ,16
002981 ,002906 ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,2 ,3 ,2 ,F ,96 ,13
002893 ,002933 ,002981 ,002906 ,  ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,. ,2 ,5 ,2 ,F ,96 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,8 ,2 ,1 ,2 ,F ,96 ,16
002974 ,001536 ,  ,  ,  ,3 ,  ,3 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,16 ,11 ,5 ,3 ,2 ,F ,96 ,12
002981 ,002944 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,2 ,2 ,3 ,2 ,F ,96 ,15
  ,  ,  ,  ,  ,4 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,. ,9 ,5 ,1 ,2 ,T ,96 ,12
002984 ,002981 ,002974 ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,11 ,7 ,3 ,7 ,F ,96 ,18
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,0 ,0 ,1 ,0 ,1 ,0 ,20 ,. ,2 ,1 ,3 ,T ,96 ,13
002976 ,002923 ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,11 ,5 ,3 ,3 ,F ,96 ,14
002974 ,  ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,9 ,6 ,5 ,2 ,5 ,F ,96 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,8 ,4 ,1 ,4 ,T ,96 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,6 ,5 ,1 ,3 ,F ,96 ,15
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,6 ,3 ,1 ,2 ,F ,96 ,15
002978 ,002913 ,002906 ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,15 ,8 ,4 ,4 ,4 ,F ,96 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,10 ,4 ,1 ,1 ,T ,96 ,15
002981 ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,9 ,5 ,2 ,5 ,F ,96 ,12
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,10 ,7 ,1 ,7 ,F ,96 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,3 ,5 ,1 ,. ,T ,96 ,13
002905 ,  ,  ,  ,  ,5 ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,4 ,2 ,3 ,F ,96 ,16
002974 ,002984 ,002954 ,002984 ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,3 ,5 ,3 ,F ,96 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,52 ,6 ,8 ,1 ,2 ,T ,96 ,4
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,13 ,3 ,1 ,3 ,T ,96 ,13
002972 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,13 ,4 ,2 ,8 ,F ,96 ,16
002906 ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,10 ,11 ,2 ,2 ,4 ,F ,96 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,7 ,5 ,1 ,5 ,F ,96 ,16
002906 ,002981 ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,3 ,5 ,F ,96 ,13
  ,  ,  ,  ,  ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,5 ,3 ,1 ,3 ,F ,96 ,15
999998 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,8 ,4 ,2 ,5 ,F ,96 ,15
002906 ,001538 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,11 ,5 ,3 ,2 ,F ,96 ,15
012627 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,55 ,4 ,4 ,2 ,4 ,T ,96 ,19
002978 ,002974 ,002913 ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,10 ,9 ,5 ,4 ,5 ,F ,96 ,16
002931 ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,11 ,5 ,2 ,5 ,F ,96 ,16
002976 ,002981 ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,4 ,3 ,4 ,F ,96 ,16
  ,  ,  ,  ,  ,4 ,1 ,2 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,20 ,10 ,4 ,1 ,4 ,T ,96 ,15
002906 ,002974 ,  ,  ,  ,5 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,11 ,5 ,3 ,5 ,F ,96 ,17
002974 ,002906 ,  ,  ,  ,4 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,14 ,3 ,3 ,8 ,F ,96 ,15
002906 ,002981 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,2 ,3 ,1 ,F ,96 ,17
002976 ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,10 ,3 ,1 ,2 ,F ,96 ,13
002976 ,002981 ,  ,  ,  ,3 ,3 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,. ,7 ,3 ,7 ,F ,96 ,17
002974 ,  ,  ,  ,  ,5 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,5 ,2 ,3 ,F ,96 ,18
002974 ,002976 ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,10 ,8 ,5 ,3 ,5 ,F ,96 ,12
004033 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,15 ,9 ,4 ,2 ,4 ,F ,96 ,14
002981 ,002984 ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,18 ,5 ,7 ,3 ,3 ,F ,96 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,4 ,1 ,4 ,F ,96 ,16
002974 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,11 ,5 ,2 ,5 ,F ,96 ,16
002947 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,5 ,1 ,5 ,T ,96 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,5 ,1 ,5 ,T ,96 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,12 ,5 ,1 ,8 ,T ,96 ,16
  ,  ,  ,  ,  ,4 ,  ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,22 ,2 ,5 ,1 ,5 ,T ,96 ,12
002985 ,002981 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,2 ,3 ,2 ,T ,96 ,12
002976 ,002954 ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,15 ,9 ,5 ,3 ,5 ,F ,96 ,15
002981 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,22 ,10 ,4 ,2 ,4 ,T ,96 ,12
002906 ,002945 ,002927 ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,6 ,4 ,7 ,F ,96 ,19
  ,  ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,18 ,8 ,3 ,1 ,5 ,F ,96 ,14
002944 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,5 ,2 ,7 ,F ,96 ,17
004661 ,001379 ,002589 ,002572 ,002906 ,4 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,8 ,7 ,6 ,7 ,F ,96 ,15
002906 ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,2 ,2 ,2 ,F ,96 ,16
  ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,28 ,1 ,2 ,1 ,2 ,F ,96 ,15
999999 ,999999 ,  ,  ,  ,4 ,  ,2 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,17 ,5 ,2 ,3 ,3 ,F ,96 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,25 ,4 ,2 ,1 ,4 ,T ,96 ,16
002972 ,002975 ,  ,  ,  ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,2 ,3 ,3 ,F ,96 ,15
002976 ,  ,  ,  ,  ,2 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,8 ,10 ,3 ,2 ,2 ,F ,96 ,17
002984 ,  ,  ,  ,  ,1 ,  ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,5 ,2 ,2 ,2 ,F ,96 ,15
004033 ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,18 ,8 ,2 ,2 ,1 ,F ,96 ,15
003675 ,011462 ,002009 ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,13 ,8 ,4 ,8 ,T ,96 ,17
002981 ,002906 ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,14 ,6 ,3 ,4 ,F ,96 ,15
002974 ,002906 ,  ,  ,  ,2 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,3 ,3 ,4 ,F ,96 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,40 ,4 ,1 ,1 ,1 ,T ,96 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,10 ,3 ,1 ,7 ,T ,96 ,16
002916 ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,10 ,9 ,2 ,2 ,3 ,F ,96 ,15
002979 ,  ,  ,  ,  ,1 ,  ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,7 ,4 ,2 ,3 ,F ,96 ,14
002906 ,002929 ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,13 ,8 ,2 ,3 ,5 ,T ,96 ,14
002981 ,002923 ,  ,  ,  ,1 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,12 ,11 ,7 ,3 ,3 ,F ,96 ,12
002972 ,002906 ,  ,  ,  ,5 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,12 ,6 ,3 ,3 ,F ,96 ,14
002927 ,002974 ,002972 ,  ,  ,3 ,  ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,11 ,4 ,4 ,4 ,F ,96 ,12
002939 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,11 ,2 ,2 ,4 ,F ,96 ,18
  ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,11 ,7 ,1 ,8 ,F ,96 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,12 ,6 ,3 ,1 ,5 ,F ,96 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,3 ,1 ,1 ,1 ,F ,96 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,32 ,8 ,2 ,1 ,2 ,T ,96 ,8
002976 ,002923 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,4 ,3 ,5 ,F ,96 ,16
002974 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,11 ,4 ,2 ,6 ,F ,96 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,1 ,15 ,5 ,3 ,1 ,2 ,F ,96 ,13
001063 ,  ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,8 ,4 ,6 ,2 ,5 ,T ,96 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,7 ,1 ,1 ,1 ,T ,96 ,12
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,3 ,1 ,7 ,T ,96 ,13
002981 ,002906 ,003456 ,002941 ,002984 ,2 ,1 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,9 ,6 ,6 ,5 ,F ,96 ,14
002974 ,001564 ,001961 ,002906 ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,12 ,7 ,4 ,8 ,F ,96 ,14
002974 ,002976 ,002906 ,  ,  ,2 ,3 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,11 ,5 ,4 ,5 ,F ,96 ,15
002906 ,  ,  ,  ,  ,3 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,3 ,2 ,1 ,F ,96 ,15
002974 ,002906 ,002976 ,  ,  ,4 ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,9 ,8 ,4 ,8 ,F ,96 ,16
  ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,5 ,1 ,7 ,F ,96 ,14
002934 ,002929 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,4 ,3 ,4 ,F ,96 ,15
002974 ,002126 ,  ,  ,  ,3 ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,16 ,9 ,4 ,3 ,8 ,F ,96 ,17
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,32 ,2 ,1 ,1 ,2 ,F ,96 ,8
002972 ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,1 ,2 ,2 ,2 ,F ,96 ,15
002975 ,999999 ,  ,  ,  ,2 ,  ,1 ,  ,1 ,1 ,1 ,0 ,1 ,0 ,. ,11 ,2 ,3 ,2 ,T ,96 ,12
002975 ,002974 ,  ,  ,  ,5 ,  ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,10 ,7 ,7 ,3 ,7 ,F ,96 ,16
002974 ,002972 ,002920 ,002101 ,  ,4 ,3 ,3 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,11 ,4 ,5 ,5 ,F ,96 ,15
002906 ,002981 ,002984 ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,. ,8 ,4 ,8 ,F ,96 ,18
002906 ,003323 ,002979 ,  ,  ,4 ,3 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,11 ,5 ,4 ,5 ,F ,96 ,17
002806 ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,6 ,5 ,2 ,7 ,F ,96 ,15
002906 ,002981 ,  ,  ,  ,1 ,  ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,25 ,10 ,2 ,3 ,2 ,T ,96 ,18
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,20 ,6 ,7 ,1 ,3 ,T ,96 ,13
002975 ,003720 ,002972 ,003440 ,  ,3 ,3 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,. ,12 ,5 ,5 ,4 ,F ,96 ,16
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,11 ,5 ,1 ,6 ,T ,96 ,12
002974 ,002972 ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,18 ,11 ,2 ,3 ,2 ,F ,96 ,15
002927 ,002945 ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,4 ,3 ,5 ,F ,96 ,17
002974 ,  ,  ,  ,  ,3 ,  ,2 ,1 ,0 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,5 ,2 ,5 ,F ,96 ,12
002984 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,2 ,1 ,2 ,1 ,F ,96 ,13
002906 ,  ,  ,  ,  ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,5 ,4 ,2 ,2 ,F ,96 ,15
002906 ,002927 ,003481 ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,10 ,4 ,4 ,4 ,F ,96 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,8 ,3 ,1 ,7 ,T ,96 ,16
  ,  ,  ,  ,  ,1 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,2 ,1 ,3 ,F ,96 ,15
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,18 ,10 ,2 ,1 ,2 ,T ,96 ,10
002906 ,  ,  ,  ,  ,2 ,  ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,5 ,2 ,5 ,F ,96 ,16
002906 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,3 ,2 ,5 ,T ,96 ,14
002974 ,002972 ,  ,  ,  ,4 ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,7 ,3 ,4 ,F ,96 ,15
002906 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,5 ,5 ,2 ,3 ,F ,96 ,13
002974 ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,8 ,5 ,2 ,4 ,F ,96 ,16
004033 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,10 ,2 ,2 ,2 ,T ,96 ,16
002813 ,003217 ,003519 ,002976 ,  ,5 ,3 ,2 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,. ,12 ,2 ,5 ,7 ,F ,96 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,7 ,5 ,1 ,5 ,T ,96 ,11
002906 ,002923 ,002981 ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,8 ,2 ,4 ,3 ,F ,96 ,15
002944 ,  ,  ,  ,  ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,. ,9 ,7 ,2 ,4 ,F ,96 ,16
002906 ,002976 ,002972 ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,13 ,5 ,4 ,8 ,F ,96 ,17
002906 ,  ,  ,  ,  ,4 ,  ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,. ,. ,4 ,2 ,3 ,F ,96 ,16
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,24 ,3 ,3 ,1 ,2 ,F ,96 ,17
002981 ,002923 ,002984 ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,15 ,10 ,7 ,4 ,2 ,F ,96 ,12
002934 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,7 ,3 ,2 ,4 ,F ,96 ,15
002972 ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,8 ,6 ,2 ,2 ,2 ,F ,96 ,16
002981 ,  ,  ,  ,  ,4 ,3 ,2 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,14 ,6 ,5 ,2 ,5 ,F ,96 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,4 ,1 ,5 ,F ,96 ,13
002979 ,002981 ,003428 ,002906 ,  ,3 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,12 ,7 ,5 ,6 ,F ,96 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,5 ,1 ,8 ,T ,96 ,18
002906 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,4 ,2 ,2 ,5 ,T ,96 ,10
002972 ,002906 ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,1 ,2 ,3 ,. ,F ,96 ,16
002976 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,4 ,2 ,2 ,F ,96 ,12
002933 ,002930 ,002941 ,002927 ,  ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,7 ,3 ,5 ,5 ,F ,96 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,4 ,2 ,1 ,4 ,T ,96 ,11
002984 ,002923 ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,8 ,2 ,3 ,4 ,F ,96 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,7 ,5 ,1 ,5 ,T ,96 ,11
002976 ,  ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,18 ,11 ,4 ,2 ,4 ,T ,96 ,14
002941 ,  ,  ,  ,  ,3 ,1 ,1 ,  ,1 ,1 ,0 ,1 ,1 ,0 ,. ,. ,2 ,2 ,3 ,F ,96 ,17
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,28 ,7 ,5 ,1 ,4 ,T ,96 ,16
  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,. ,5 ,1 ,3 ,F ,96 ,15
  ,  ,  ,  ,  ,2 ,2 ,  ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,. ,2 ,1 ,2 ,F ,96 ,15
003425 ,002906 ,  ,  ,  ,1 ,  ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,9 ,3 ,3 ,5 ,F ,96 ,16
002972 ,002976 ,002957 ,002927 ,  ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,11 ,2 ,5 ,5 ,F ,96 ,16
  ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,11 ,3 ,1 ,5 ,F ,96 ,15
  ,  ,  ,  ,  ,2 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,5 ,2 ,1 ,3 ,T ,96 ,17
002906 ,002984 ,002923 ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,16 ,10 ,3 ,4 ,5 ,F ,96 ,15
002927 ,002972 ,002931 ,  ,  ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,11 ,5 ,4 ,7 ,F ,96 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,9 ,2 ,1 ,2 ,F ,96 ,15
002092 ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,12 ,5 ,2 ,7 ,F ,96 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,11 ,3 ,1 ,3 ,F ,96 ,13
  ,  ,  ,  ,  ,3 ,  ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,20 ,4 ,4 ,1 ,4 ,F ,96 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,  ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,4 ,1 ,2 ,T ,96 ,16
  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,13 ,5 ,1 ,7 ,F ,96 ,16
002984 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,20 ,6 ,5 ,2 ,5 ,T ,96 ,12
003432 ,002984 ,008084 ,  ,  ,3 ,1 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,6 ,4 ,4 ,4 ,F ,96 ,14
002951 ,002927 ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,6 ,5 ,3 ,2 ,F ,96 ,16
003428 ,002906 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,2 ,3 ,5 ,F ,96 ,17
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,9 ,1 ,1 ,4 ,T ,96 ,7
002923 ,002981 ,  ,  ,  ,4 ,2 ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,20 ,6 ,4 ,3 ,5 ,F ,96 ,15
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,11 ,8 ,1 ,8 ,T ,96 ,16
002981 ,002975 ,002972 ,008084 ,  ,1 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,12 ,8 ,7 ,5 ,5 ,F ,96 ,13
002984 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,28 ,10 ,5 ,2 ,8 ,T ,96 ,14
  ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,9 ,2 ,1 ,2 ,T ,96 ,16
002939 ,001598 ,002906 ,003425 ,  ,2 ,3 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,11 ,5 ,5 ,4 ,F ,96 ,15
002906 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,40 ,9 ,4 ,2 ,6 ,T ,96 ,13
  ,  ,  ,  ,  ,5 ,  ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,10 ,. ,6 ,1 ,5 ,T ,96 ,13
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,12 ,7 ,1 ,8 ,T ,96 ,16
001569 ,001598 ,002906 ,002984 ,003428 ,2 ,  ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,11 ,7 ,6 ,3 ,F ,96 ,16
002981 ,002906 ,001598 ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,11 ,5 ,4 ,8 ,T ,96 ,14
001347 ,002092 ,003709 ,003705 ,001434 ,2 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,12 ,3 ,7 ,3 ,F ,96 ,17
002923 ,002981 ,003692 ,002975 ,002976 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,9 ,5 ,8 ,5 ,F ,96 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,6 ,2 ,1 ,3 ,T ,96 ,21
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,14 ,11 ,5 ,1 ,5 ,T ,96 ,17
002589 ,010238 ,001598 ,002038 ,  ,5 ,1 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,5 ,5 ,8 ,F ,96 ,14
001598 ,002933 ,002906 ,  ,  ,5 ,  ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,3 ,4 ,3 ,F ,96 ,15
003419 ,002974 ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,6 ,4 ,3 ,5 ,F ,96 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,7 ,4 ,1 ,5 ,T ,96 ,12
009636 ,  ,  ,  ,  ,1 ,3 ,1 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,16 ,10 ,4 ,2 ,7 ,F ,96 ,15
002974 ,001564 ,003434 ,  ,  ,2 ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,8 ,4 ,4 ,3 ,F ,96 ,16
002984 ,002972 ,003318 ,  ,  ,3 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,. ,5 ,4 ,5 ,F ,96 ,13
  ,  ,  ,  ,  ,5 ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,22 ,12 ,3 ,1 ,3 ,F ,96 ,5
002155 ,001582 ,002986 ,001489 ,  ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,6 ,2 ,5 ,4 ,F ,96 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,30 ,8 ,7 ,1 ,7 ,T ,96 ,10
002984 ,002975 ,002974 ,002976 ,002002 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,7 ,4 ,7 ,7 ,T ,96 ,12
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,25 ,9 ,4 ,1 ,3 ,T ,96 ,13
003457 ,001487 ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,11 ,5 ,3 ,7 ,F ,96 ,16
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,30 ,6 ,2 ,1 ,3 ,T ,96 ,11
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,5 ,1 ,5 ,T ,96 ,10
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,30 ,12 ,4 ,1 ,2 ,T ,96 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,20 ,10 ,3 ,1 ,3 ,T ,96 ,13
002076 ,002901 ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,7 ,3 ,7 ,F ,96 ,16
003014 ,001825 ,002290 ,002260 ,002330 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,14 ,5 ,9 ,7 ,F ,96 ,16
002906 ,003456 ,002979 ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,12 ,7 ,4 ,4 ,F ,96 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,40 ,8 ,2 ,1 ,5 ,T ,96 ,4
002923 ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,. ,5 ,3 ,2 ,2 ,F ,96 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,8 ,11 ,7 ,1 ,5 ,T ,96 ,14
002974 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,12 ,5 ,2 ,5 ,F ,96 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,10 ,11 ,2 ,1 ,5 ,T ,96 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,1 ,2 ,1 ,2 ,T ,96 ,14
  ,  ,  ,  ,  ,5 ,  ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,38 ,. ,4 ,1 ,6 ,T ,96 ,7
  ,  ,  ,  ,  ,3 ,1 ,2 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,20 ,12 ,5 ,1 ,5 ,T ,96 ,15
002984 ,002974 ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,12 ,7 ,3 ,7 ,F ,96 ,16
002944 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,4 ,2 ,1 ,T ,96 ,15
002234 ,  ,  ,  ,  ,1 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,3 ,2 ,2 ,6 ,F ,96 ,17
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,10 ,3 ,1 ,3 ,T ,96 ,15
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,10 ,3 ,1 ,3 ,T ,96 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,12 ,5 ,1 ,3 ,F ,96 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,20 ,. ,5 ,1 ,5 ,T ,96 ,12
002972 ,002976 ,002906 ,  ,  ,5 ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,. ,9 ,7 ,4 ,7 ,F ,96 ,15
002930 ,  ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,10 ,9 ,5 ,2 ,2 ,F ,96 ,17
  ,  ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,12 ,2 ,1 ,7 ,F ,96 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,1 ,3 ,1 ,3 ,F ,96 ,15
002927 ,002931 ,002718 ,003279 ,002109 ,2 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,13 ,5 ,8 ,5 ,F ,96 ,14
  ,  ,  ,  ,  ,5 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,5 ,1 ,5 ,T ,96 ,15
  ,  ,  ,  ,  ,4 ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,9 ,5 ,1 ,5 ,T ,96 ,11
  ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,10 ,. ,5 ,1 ,3 ,F ,96 ,15
002974 ,002978 ,002976 ,  ,  ,4 ,1 ,3 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,15 ,4 ,3 ,4 ,2 ,F ,96 ,15
002975 ,002972 ,  ,  ,  ,1 ,2 ,3 ,2 ,1 ,0 ,1 ,0 ,1 ,0 ,10 ,11 ,2 ,3 ,3 ,F ,96 ,15
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,35 ,10 ,2 ,1 ,3 ,T ,96 ,5
002974 ,002913 ,  ,  ,  ,1 ,  ,2 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,30 ,1 ,2 ,3 ,5 ,F ,96 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,32 ,11 ,3 ,1 ,3 ,F ,96 ,14
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,20 ,9 ,3 ,1 ,2 ,T ,96 ,12
  ,  ,  ,  ,  ,2 ,3 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,15 ,6 ,3 ,1 ,3 ,F ,96 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,5 ,2 ,1 ,1 ,T ,96 ,14
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,9 ,7 ,1 ,6 ,F ,96 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,25 ,8 ,4 ,1 ,5 ,T ,96 ,12
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,12 ,2 ,1 ,5 ,T ,96 ,8
  ,  ,  ,  ,  ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,9 ,3 ,1 ,4 ,F ,96 ,16
002976 ,002984 ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,12 ,3 ,3 ,5 ,T ,96 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,9 ,2 ,1 ,1 ,T ,96 ,8
  ,  ,  ,  ,  ,1 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,20 ,4 ,3 ,1 ,5 ,T ,96 ,13
  ,  ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,4 ,1 ,5 ,T ,96 ,13
003534 ,008145 ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,1 ,20 ,8 ,7 ,3 ,6 ,T ,96 ,13
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,30 ,. ,5 ,1 ,8 ,T ,96 ,14
002906 ,002985 ,002976 ,  ,  ,5 ,1 ,3 ,  ,1 ,1 ,1 ,0 ,1 ,0 ,. ,6 ,3 ,4 ,3 ,F ,96 ,14
003529 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,. ,7 ,4 ,2 ,4 ,F ,96 ,16
003530 ,009914 ,002923 ,003494 ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,14 ,6 ,5 ,5 ,F ,96 ,15
  ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,30 ,11 ,3 ,1 ,5 ,T ,96 ,10
  ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,10 ,3 ,1 ,3 ,F ,96 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,2 ,4 ,1 ,5 ,T ,96 ,14
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,. ,5 ,7 ,1 ,5 ,T ,96 ,13
002976 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,9 ,5 ,2 ,8 ,T ,96 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,10 ,6 ,1 ,5 ,T ,96 ,14
002984 ,002979 ,003530 ,003510 ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,. ,6 ,4 ,5 ,5 ,F ,96 ,14
002985 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,0 ,0 ,1 ,0 ,1 ,0 ,. ,7 ,5 ,2 ,5 ,F ,96 ,16
002906 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,1 ,0 ,28 ,3 ,4 ,1 ,5 ,T ,96 ,14
002013 ,001564 ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,12 ,5 ,3 ,3 ,F ,96 ,15
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,40 ,. ,2 ,1 ,2 ,T ,96 ,4
002013 ,002910 ,003482 ,002933 ,002981 ,5 ,1 ,2 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,. ,7 ,16 ,8 ,F ,96 ,13
003434 ,003457 ,002972 ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,. ,4 ,4 ,5 ,F ,96 ,16
001598 ,003530 ,002976 ,  ,  ,4 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,5 ,4 ,7 ,F ,96 ,16
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,. ,. ,1 ,1 ,1 ,T ,96 ,7
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,0 ,1 ,1 ,0 ,0 ,0 ,20 ,1 ,2 ,1 ,1 ,T ,96 ,14
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,30 ,9 ,2 ,1 ,5 ,T ,96 ,9
002906 ,  ,  ,  ,  ,2 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,4 ,2 ,3 ,F ,96 ,14
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,10 ,4 ,1 ,7 ,F ,96 ,14
002944 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,25 ,2 ,2 ,2 ,2 ,T ,96 ,8
003184 ,001315 ,  ,  ,  ,5 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,9 ,4 ,3 ,4 ,F ,96 ,14
002974 ,002976 ,  ,  ,  ,5 ,  ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,12 ,5 ,3 ,5 ,F ,96 ,16
002974 ,002984 ,002972 ,002906 ,  ,3 ,2 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,11 ,4 ,5 ,4 ,F ,96 ,16
003425 ,002972 ,  ,  ,  ,2 ,2 ,3 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,25 ,9 ,3 ,3 ,5 ,F ,96 ,13
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,40 ,9 ,3 ,1 ,5 ,T ,96 ,12
002923 ,  ,  ,  ,  ,2 ,1 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,30 ,6 ,5 ,2 ,4 ,T ,96 ,13
001422 ,003144 ,007104 ,003127 ,003696 ,3 ,3 ,1 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,8 ,4 ,6 ,4 ,F ,96 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,. ,8 ,2 ,1 ,2 ,T ,96 ,4
002972 ,001892 ,003428 ,002918 ,  ,5 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,12 ,7 ,5 ,8 ,F ,96 ,16
002972 ,003713 ,  ,  ,  ,5 ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,4 ,6 ,5 ,F ,96 ,14
  ,  ,  ,  ,  ,2 ,  ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,. ,14 ,3 ,1 ,8 ,F ,96 ,14
002974 ,002130 ,001444 ,002073 ,  ,5 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,12 ,5 ,5 ,5 ,F ,96 ,15
002984 ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,8 ,12 ,4 ,2 ,6 ,F ,96 ,16
003644 ,001928 ,  ,  ,  ,2 ,1 ,1 ,2 ,0 ,1 ,0 ,0 ,0 ,0 ,20 ,2 ,1 ,3 ,1 ,T ,96 ,15
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,20 ,1 ,4 ,1 ,8 ,T ,96 ,14
  ,  ,  ,  ,  ,4 ,3 ,1 ,2 ,0 ,1 ,1 ,1 ,1 ,0 ,25 ,10 ,5 ,1 ,8 ,T ,96 ,15
001788 ,003798 ,  ,  ,  ,5 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,10 ,5 ,3 ,5 ,F ,96 ,15
001601 ,  ,  ,  ,  ,4 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,10 ,4 ,2 ,4 ,F ,96 ,14
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,0 ,1 ,1 ,1 ,1 ,1 ,15 ,5 ,6 ,1 ,5 ,F ,96 ,12
001370 ,001839 ,001347 ,  ,  ,2 ,3 ,1 ,  ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,4 ,5 ,5 ,F ,96 ,15
002974 ,  ,  ,  ,  ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,9 ,3 ,2 ,5 ,F ,96 ,16
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,28 ,. ,5 ,1 ,6 ,T ,96 ,13
002974 ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,10 ,5 ,2 ,5 ,F ,96 ,17
002976 ,002974 ,002984 ,  ,  ,4 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,8 ,6 ,5 ,4 ,7 ,F ,96 ,17
002974 ,003448 ,002913 ,002923 ,  ,5 ,3 ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,. ,. ,3 ,5 ,3 ,F ,96 ,16
002755 ,001143 ,  ,  ,  ,1 ,3 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,12 ,7 ,3 ,7 ,F ,96 ,14
002981 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,2 ,2 ,2 ,2 ,F ,96 ,14
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,0 ,45 ,. ,3 ,1 ,3 ,T ,96 ,21
  ,  ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,40 ,10 ,5 ,1 ,3 ,T ,96 ,4
001809 ,006964 ,001598 ,001574 ,  ,4 ,3 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,9 ,5 ,5 ,7 ,F ,96 ,17
002978 ,002974 ,  ,  ,  ,4 ,3 ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,. ,11 ,6 ,3 ,7 ,F ,96 ,16
004033 ,  ,  ,  ,  ,3 ,3 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,2 ,2 ,2 ,3 ,F ,96 ,18
  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,40 ,. ,3 ,1 ,5 ,T ,96 ,8
002972 ,002906 ,  ,  ,  ,3 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,11 ,7 ,3 ,7 ,F ,96 ,15
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,. ,3 ,1 ,5 ,F ,96 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,12 ,3 ,1 ,3 ,F ,96 ,14
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,20 ,10 ,5 ,1 ,7 ,T ,96 ,11
003505 ,002209 ,  ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,3 ,3 ,2 ,F ,96 ,14
002969 ,002984 ,  ,  ,  ,2 ,  ,3 ,2 ,1 ,1 ,0 ,1 ,1 ,0 ,30 ,10 ,4 ,3 ,5 ,F ,96 ,13
002981 ,  ,  ,  ,  ,5 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,20 ,2 ,2 ,2 ,1 ,F ,96 ,16
002923 ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,20 ,9 ,2 ,2 ,2 ,T ,96 ,12
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,. ,10 ,5 ,1 ,6 ,T ,96 ,18
002906 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,1 ,0 ,. ,1 ,2 ,2 ,. ,F ,96 ,15
002906 ,002981 ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,10 ,5 ,3 ,4 ,F ,96 ,12
001537 ,001535 ,002941 ,002906 ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,7 ,4 ,5 ,6 ,F ,96 ,16
002981 ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,12 ,10 ,3 ,2 ,3 ,F ,96 ,15
002981 ,  ,  ,  ,  ,3 ,3 ,1 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,25 ,7 ,3 ,2 ,2 ,F ,96 ,15
001510 ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,. ,3 ,2 ,2 ,5 ,F ,96 ,15
003496 ,002976 ,001952 ,002933 ,  ,1 ,2 ,2 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,20 ,8 ,7 ,5 ,7 ,F ,96 ,16
002732 ,  ,  ,  ,  ,1 ,3 ,2 ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,15 ,8 ,3 ,2 ,3 ,F ,96 ,16
002984 ,003981 ,  ,  ,  ,1 ,2 ,2 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,18 ,7 ,5 ,3 ,3 ,F ,96 ,14
  ,  ,  ,  ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,10 ,1 ,1 ,4 ,F ,96 ,13
  ,  ,  ,  ,  ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,. ,12 ,5 ,1 ,6 ,T ,96 ,14
  ,  ,  ,  ,  ,4 ,1 ,1 ,2 ,1 ,0 ,1 ,1 ,1 ,1 ,25 ,6 ,6 ,1 ,8 ,T ,96 ,12
002972 ,001569 ,  ,  ,  ,2 ,2 ,2 ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,25 ,9 ,2 ,3 ,2 ,F ,96 ,17
003434 ,003705 ,003253 ,003265 ,003042 ,1 ,3 ,2 ,2 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,13 ,5 ,6 ,7 ,F ,96 ,14
001507 ,001535 ,001489 ,  ,  ,5 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,. ,7 ,4 ,8 ,F ,96 ,16
003875 ,001745 ,002906 ,  ,  ,5 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,. ,2 ,1 ,4 ,2 ,F ,96 ,16
  ,  ,  ,  ,  ,5 ,  ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,. ,12 ,2 ,1 ,6 ,T ,96 ,13
  ,  ,  ,  ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,10 ,4 ,1 ,6 ,F ,96 ,16
001564 ,002974 ,002076 ,002209 ,  ,5 ,3 ,2 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,. ,10 ,7 ,5 ,7 ,F ,96 ,16
001314 ,002575 ,029013 ,002239 ,002512 ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,. ,. ,7 ,6 ,7 ,F ,96 ,15
002520 ,001313 ,001321 ,001127 ,  ,5 ,1 ,2 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,10 ,11 ,6 ,5 ,7 ,F ,96 ,14
004608 ,002519 ,003723 ,  ,  ,4 ,1 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,15 ,5 ,3 ,4 ,4 ,F ,96 ,16
001315 ,001313 ,001264 ,001320 ,001328 ,5 ,2 ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,14 ,7 ,8 ,7 ,F ,96 ,13
006883 ,003434 ,  ,  ,  ,5 ,3 ,2 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,10 ,9 ,2 ,6 ,5 ,T ,96 ,18
  ,  ,  ,  ,  ,3 ,2 ,1 ,2 ,1 ,0 ,0 ,0 ,1 ,0 ,10 ,11 ,7 ,1 ,7 ,F ,96 ,18
009563 ,001963 ,001926 ,001948 ,003170 ,3 ,1 ,1 ,  ,1 ,0 ,1 ,1 ,1 ,0 ,. ,4 ,4 ,9 ,4 ,F ,96 ,16
002358 ,001515 ,003744 ,002208 ,  ,2 ,1 ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,7 ,6 ,7 ,F ,96 ,16
999998 ,006967 ,002218 ,003184 ,  ,5 ,1 ,1 ,  ,1 ,1 ,0 ,0 ,0 ,0 ,. ,. ,5 ,5 ,7 ,T ,96 ,17
  ,  ,  ,  ,  ,3 ,3 ,  ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,. ,. ,5 ,. ,1 ,F ,96 ,16
  ,  ,  ,  ,  ,2 ,1 ,1 ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,15 ,. ,1 ,1 ,1 ,F ,96 ,16
003378 ,006968 ,  ,  ,  ,5 ,3 ,2 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,. ,7 ,5 ,3 ,5 ,F ,96 ,15


/* progeval.dat */

CHEM ,2 ,3
PHYS ,3 ,2
ATMS ,4 ,3
ATMS ,3 ,3
ATMS ,4 ,4
ATMS ,3 , 
ATMS ,3 ,4
CHEM ,3 ,3
ATMS ,3 ,3
ATMS ,4 ,4
ATMS ,4 ,3
PHYS ,3 ,3
CHEM ,3 ,2
ATMS ,3 ,4
PHYS ,4 ,4
CHEM ,3 ,2
PHYS ,4 ,4
CHEM ,3 ,3
ATMS ,4 ,4
ATMS ,3 ,3
ATMS ,3 ,3
ATMS ,4 ,4
PHYS ,3 ,2
PHYS ,2 ,2
CHEM ,3 ,2
ATMS ,3 ,4
CHEM ,3 ,2
ATMS ,4 ,2
CHEM ,3 ,3
ATMS ,4 , 
ATMS ,3 ,3
ATMS ,3 ,3
PHYS ,3 ,3
PHYS ,3 ,4
ATMS ,3 ,3
ATMS ,4 ,3
PHYS ,3 ,3
ATMS ,2 ,2
CHEM ,4 ,4
ATMS ,3 ,3
ATMS ,4 ,3
PHYS ,4 ,4
ATMS ,3 ,1
ATMS ,3 ,3
CHEM ,3 ,3
ATMS ,4 ,4
ATMS ,3 , 
PHYS ,1 ,1
ATMS ,2 ,3
ATMS ,3 , 
PHYS ,3 ,3
ATMS ,4 ,4
ATMS ,  ,4
PHYS ,4 ,4
CHEM ,4 ,4
MATH ,3 ,3
CSCI ,3 ,4
MATH ,2 ,3
CSCI ,3 ,3
CSCI ,2 ,3
MATH ,2 ,2
CSCI ,3 ,1
MATH ,3 ,2
MATH ,2 ,2
MATH ,  ,3
MATH ,3 ,2
CSCI ,3 ,4
CSCI ,3 ,2
CSCI ,3 ,3
MATH ,2 ,2
CSCI ,2 ,3
CSCI ,3 ,2
CSCI ,2 ,3
MATH ,3 ,3
CSCI ,3 ,2
CSCI ,3 ,2
CSCI ,4 ,4
MATH ,  ,2
CSCI ,  ,1
MATH ,3 ,3
CSCI ,3 ,3
CSCI ,2 ,2
CSCI ,3 ,2
CSCI ,3 ,3
CSCI ,2 ,2
CSCI ,3 ,4
CSCI ,2 ,3
CSCI ,4 ,3
CSCI ,3 ,2
CSCI ,3 ,3
CSCI ,3 ,2
CSCI ,3 ,3
CSCI ,3 ,4
MATH ,4 ,4
CSCI ,3 ,3
CSCI ,3 ,2
CSCI ,3 ,2
CSCI ,3 ,2
MATH ,2 , 
CSCI ,3 ,3
MATH ,1 ,2
CSCI ,3 ,2
CSCI ,2 ,3
CSCI ,2 ,2
CSCI ,3 ,2
MATH ,3 ,3
CSCI ,3 ,2
CSCI ,3 ,2
CSCI ,2 ,2
CSCI ,3 ,3
CSCI ,2 ,2
MATH ,1 ,1
CSCI ,4 ,4
CSCI ,3 ,2
MATH ,2 ,3
CSCI ,4 ,4
CSCI ,2 ,1
CSCI ,3 ,3
MATH ,1 ,2
CSCI ,3 ,3
CSCI ,2 ,2
CSCI ,3 ,3
CSCI ,2 ,2
CSCI ,2 ,1
MATH ,  ,4
CSCI ,3 ,1
CSCI ,  ,2
CSCI ,4 ,2
CSCI ,3 ,3
CSCI ,2 ,3
EDUC ,3 ,4
EDUC ,2 ,3
EDUC ,1 ,2
EDUC ,3 ,2
POLS ,3 ,3
POLS ,2 ,3
EDUC ,3 ,3
POLS ,3 ,4
POLS ,2 ,2
POLS ,1 ,4
POLS ,3 ,4
EDUC ,  ,3
EDUC ,1 ,1
POLS ,2 ,3
EDUC ,3 ,3
POLS ,1 ,2
POLS ,  ,2
EDUC ,3 ,2
POLS ,2 ,3
POLS ,2 ,3
EDUC ,3 ,2
POLS ,2 ,4
EDUC ,  , 
EDUC ,1 ,1
POLS ,3 ,3
POLS ,3 ,3
EDUC ,2 ,1
POLS ,1 ,3
POLS ,  , 
POLS ,  ,2
POLS ,2 ,3
POLS ,2 ,3
EDUC ,3 ,3
EDUC ,2 ,2
EDUC ,3 ,3
EDUC ,3 ,3
POLS ,3 ,3
EDUC ,3 ,2
POLS ,3 ,3
EDUC ,3 ,2
POLS ,4 ,4
POLS ,3 ,2
EDUC ,2 ,2
EDUC ,1 ,2
EDUC ,2 ,2
EDUC ,  ,2
POLS ,1 ,1
EDUC ,2 ,3
EDUC ,3 ,2
EDUC ,2 ,2
EDUC ,3 ,4
EDUC ,3 ,2
EDUC ,3 ,4
POLS ,2 ,2
EDUC ,2 ,2
POLS ,2 ,2
POLS ,2 ,2
EDUC ,3 ,3
POLS ,2 ,1
EDUC ,2 ,1
POLS ,4 ,4
POLS ,3 ,2
EDUC ,3 ,2
ART ,2 ,3
POLS ,3 ,3
POLS ,4 ,3
POLS ,3 ,3
DRAM ,4 ,1
POLS ,2 ,2
DRAM ,2 ,4
POLS ,2 ,2
ART ,3 ,3
POLS ,3 ,3
POLS ,3 ,1
ART ,4 ,4
POLS ,3 ,3
ART ,3 , 
ART ,3 ,3
POLS ,  ,3
ART ,3 ,2
ART ,3 ,4
ART ,3 ,3
ART ,4 ,3
POLS ,3 , 
ART ,3 ,1
ART ,3 ,4
POLS ,3 ,3
POLS ,4 ,2
ART ,3 ,4
ART ,4 ,4
ART ,4 ,4
POLS ,3 ,3
ART ,4 ,3
POLS ,3 ,2
POLS ,3 ,2
ART ,4 ,3
POLS ,3 ,3
POLS ,3 ,3
ART ,3 ,3
POLS ,2 ,2
POLS ,2 ,3
POLS ,3 ,4
ART ,  ,2
POLS ,2 ,4
DRAM ,3 ,2
ART ,4 ,4
ART ,4 ,2
DRAM ,3 ,4
ART ,3 ,2
ART ,2 ,3
ART ,3 ,3
ART ,3 ,2
POLS ,1 ,2
POLS ,2 ,3
ART ,4 ,3
ART ,3 ,1
POLS ,3 ,3
POLS ,1 ,2
ART ,3 ,2
POLS ,2 ,3
DRAM ,3 ,3
ART ,3 ,4
ART ,3 ,3
ART ,4 ,2
ART ,4 ,3
POLS ,3 ,4
ART ,3 ,3
DRAM ,3 ,3
ART ,3 ,1
DRAM ,3 ,1
POLS ,3 ,4
ART ,4 ,3
ART ,  , 
POLS ,2 ,2
ART ,4 ,4
DRAM ,3 ,4
DRAM ,2 ,2
DRAM ,2 ,3
ART ,3 ,2
ART ,4 ,4
ART ,4 ,4
DRAM ,2 ,2
ART ,3 ,3
ART ,4 ,3
ART ,4 ,4
ART ,3 ,1
ART ,2 ,2
DRAM ,2 ,2
ART ,3 ,1
DRAM ,2 ,2
DRAM ,3 ,1
ART ,4 ,4
ART ,3 ,2
POLS ,3 ,3
DRAM ,1 ,1
DRAM ,3 ,3
ART ,2 ,1
DRAM ,3 ,2
ART ,4 ,3
POLS ,3 ,3
ART ,  , 
ART ,4 ,4
DRAM ,3 ,4
DRAM ,3 ,3
GERM ,2 ,3
FREN ,4 ,4
ACCT ,3 ,3
MGMT ,3 ,3
MGMT ,4 ,4
ACCT ,3 ,3
ACCT ,3 ,4
ACCT ,2 ,3
ACCT ,3 ,4
ACCT ,3 ,4
MGMT ,3 ,3
ACCT ,1 ,1
MGMT ,3 ,3
ACCT ,3 ,3
MGMT ,3 ,4
MGMT ,  ,2
ACCT ,3 ,2
MGMT ,2 ,4
MGMT ,3 ,3
ACCT ,3 ,3
EDUC ,3 ,2
ACCT ,4 ,4
MGMT ,3 ,3
FREN ,3 ,3
EDUC ,  ,2
ACCT ,4 ,3
ACCT ,3 ,3
GERM ,3 ,3
ACCT ,  ,1
ACCT ,3 ,3
ACCT ,4 ,4
MGMT ,  , 
EDUC ,4 ,2
MGMT ,3 ,3
MGMT ,3 ,2
ACCT ,3 ,4
MGMT ,3 ,3
MGMT ,3 ,3
ACCT ,3 ,3
MGMT ,3 ,4
MGMT ,4 ,4
ACCT ,3 ,2
MGMT ,3 ,2
MGMT ,3 ,2
EDUC ,2 ,1
MGMT ,3 ,3
EDUC ,2 ,2
MGMT ,3 ,2
GERM ,  ,4
EDUC ,3 ,3
SPAN ,4 ,3
EDUC ,3 ,2
MGMT ,2 ,1
EDUC ,4 ,4
EDUC ,3 ,3
FREN ,3 ,2
ACCT ,4 ,4
ACCT ,3 ,4
MGMT ,  , 
MGMT ,3 ,4
MGMT ,3 ,2
ACCT ,3 ,3
MGMT ,3 ,3
MGMT ,3 ,2
MGMT ,3 ,3
EDUC ,3 ,3
MGMT ,3 ,3
ACCT ,3 ,2
MGMT ,3 ,3
ACCT ,4 ,4
MGMT ,3 ,3
MGMT ,2 ,2
SPAN ,3 ,2
MGMT ,3 ,2
ACCT ,3 ,3
MGMT ,3 ,1
MGMT ,3 ,4
SPAN ,1 ,1
MGMT ,  ,2
MGMT ,2 ,1
ACCT ,3 ,3
EDUC ,1 ,2
ACCT ,3 ,3
ACCT ,3 ,3
SPAN ,3 ,3
MGMT ,2 ,4
MGMT ,3 ,3
MGMT ,3 ,2
MGMT ,3 ,4
ACCT ,4 ,4
SPAN ,3 ,4
EDUC ,4 ,4
MGMT ,3 ,1
ACCT ,3 ,4
EDUC ,3 ,3
MGMT ,4 ,2
MGMT ,3 ,3
MGMT ,3 ,2
ACCT ,  , 
ACCT ,3 ,2
MGMT ,3 ,2
MGMT ,2 ,4
MGMT ,2 ,2
GERM ,2 ,2
MGMT ,3 ,3
MGMT ,3 ,3
MGMT ,3 ,3
MGMT ,3 ,2
EDUC ,3 ,2
MGMT ,2 ,1
ACCT ,3 ,3
MGMT ,4 ,4
FREN ,4 ,3
SPAN ,  ,3
MGMT ,3 ,3
MGMT ,  ,2
EDUC ,3 ,2
ACCT ,3 ,3
MGMT ,2 ,2
MGMT ,3 ,3
MGMT ,3 ,2
MGMT ,3 ,3
MGMT ,4 ,3
MGMT ,2 ,1
ACCT ,3 ,4
MGMT ,3 ,4
MGMT ,3 ,3
MGMT ,  ,3
ACCT ,3 ,3
MGMT ,3 ,3
MGMT ,3 ,2
MGMT ,2 ,2
MGMT ,3 ,3
ACCT ,3 ,4
ACCT ,3 ,3
GERM ,1 ,4
MGMT ,3 ,3
EDUC ,3 ,4
MGMT ,4 ,3
MGMT ,3 ,3
MGMT ,2 ,2
ACCT ,3 ,3
MGMT ,3 ,3
EDUC ,3 ,1
SPAN ,3 ,3
MGMT ,  ,3
ACCT ,3 ,3
ACCT ,3 ,4
EDUC ,3 ,3
ACCT ,2 ,2
FREN ,3 ,2
ACCT ,4 ,4
ACCT ,3 ,2
MGMT ,3 ,3
MGMT ,3 ,4
ACCT ,3 ,3
ACCT ,3 ,4
MGMT ,3 ,3
ACCT ,3 ,3
SPAN ,2 ,3
EDUC ,2 ,1
MGMT ,3 ,2
ACCT ,3 ,3
EDUC ,3 ,2
MGMT ,3 ,2
MGMT ,4 ,3
MGMT ,3 ,3
EDUC ,4 ,4
MGMT ,3 ,3
ACCT ,3 ,4
MGMT ,3 ,3
SPAN ,1 ,1
ACCT ,4 ,3
MGMT ,3 ,3
MGMT ,3 ,2
EDUC ,3 ,2
EDUC ,3 ,3
ACCT ,3 ,3
ACCT ,4 ,3
ACCT ,3 ,2
ACCT ,3 ,2
MGMT ,3 ,3
ACCT ,4 ,3
EDUC ,3 ,4
MGMT ,3 ,2
MGMT ,2 ,2
MGMT ,  ,3
MGMT ,3 ,2
MGMT ,2 ,3
MGMT ,3 ,4
FREN ,4 ,4
MGMT ,2 ,3
MGMT ,3 ,2
MGMT ,3 ,3
EDUC ,3 ,3
EDUC ,2 ,3
FREN ,3 ,2
MGMT ,3 ,2
MGMT ,2 ,4
MGMT ,3 ,1
EDUC ,  ,1
MGMT ,4 ,4
MGMT ,3 ,3
MGMT ,3 , 
MGMT ,3 ,3
MGMT ,3 ,3
MGMT ,3 ,4
EDUC ,2 ,2
ACCT ,2 ,2
FREN ,  ,3
GERM ,3 ,4
MGMT ,3 ,1
MGMT ,3 ,3
EDUC ,3 ,1
MGMT ,3 ,2
MGMT ,3 ,3
MGMT ,3 ,2
MGMT ,4 ,4
ACCT ,2 ,3
ACCT ,3 ,3
ACCT ,3 ,3
MGMT ,4 ,2
MGMT ,4 ,3
SPAN ,3 , 
EDUC ,3 ,3
EDUC ,4 ,4
MGMT ,3 ,4
ACCT ,4 , 
MGMT ,3 ,3
ACCT ,  ,3
EDUC ,3 ,3
MGMT ,3 ,1
SPAN ,3 ,2
ACCT ,4 ,4
MGMT ,3 ,3
EDUC ,2 ,2
MGMT ,2 ,3
MGMT ,3 ,3
MGMT ,3 ,2
MGMT ,3 ,2
EDUC ,2 ,2
MGMT ,3 ,2
ACCT ,3 ,3
MGMT ,3 ,2
MGMT ,3 ,3
MGMT ,3 ,2
ACCT ,  ,3
MGMT ,4 ,3
EDUC ,3 ,2
MGMT ,3 ,3
EDUC ,3 ,2
SPAN ,  ,2
MGMT ,3 ,3
MGMT ,3 ,4
EDUC ,3 ,2
MGMT ,4 ,3
EDUC ,3 ,2
EDUC ,  ,1
SPAN ,2 ,1
MGMT ,3 ,3
ACCT ,3 ,3
EDUC ,3 ,3
FREN ,  ,2
EDUC ,3 ,3
FREN ,  , 
ACCT ,  ,2
MGMT ,3 ,3
GERM ,2 ,2
MGMT ,3 ,2
MGMT ,3 ,3
EDUC ,3 ,3
EDUC ,1 ,3
ACCT ,3 ,3
MGMT ,3 ,3
MGMT ,  , 
MGMT ,  ,2
MGMT ,  ,3
EDUC ,2 ,3
DRAM ,4 ,2
DRAM ,3 ,3
DRAM ,3 ,3
DRAM ,4 ,3
DRAM ,3 ,1
DRAM ,3 ,3
DRAM ,3 ,3
DRAM ,3 ,3
DRAM ,2 ,2
DRAM ,4 ,4
DRAM ,1 ,3
DRAM ,3 ,3
DRAM ,3 ,2
DRAM ,  ,3
DRAM ,3 ,3
EDUC ,1 ,3
ENVR ,2 ,3
ENVR ,2 ,2
ECON ,3 ,1
ENVR ,  ,1
ECON ,  ,4
ECON ,3 ,3
ENVR ,1 ,1
ENVR ,2 ,2
ECON ,4 ,2
ENVR ,2 ,2
ENVR ,2 ,3
ENVR ,3 ,3
ENVR ,1 ,1
ENVR ,3 ,3
ENVR ,3 ,3
ENVR ,3 ,3
ECON ,4 ,3
ENVR ,3 ,3
ENVR ,2 ,2
ENVR ,2 ,1
ENVR ,3 ,4
ECON ,3 ,3
ENVR ,3 ,2
ENVR ,3 ,2
ENVR ,3 ,1
ECON ,3 ,3
ECON ,3 ,2
ENVR ,3 ,4
ENVR ,3 ,1
ENVR ,2 ,2
ECON ,3 ,4
ENVR ,3 ,1
ECON ,3 ,4
ENVR ,2 ,2
ENVR ,  ,3
ENVR ,  ,2
ECON ,3 ,3
ENVR ,1 ,1
ENVR ,4 ,2
ENVR ,2 ,3
ENVR ,2 ,3
ENVR ,3 ,3
ENVR ,2 ,1
ENVR ,1 ,1
ENVR ,2 ,1
ECON ,3 ,3
ENVR ,4 ,4
ENVR ,2 ,2
ENVR ,2 ,1
ENVR ,3 ,3
ENVR ,2 ,3
ECON ,3 ,3
ENVR ,3 ,3
ENVR ,  ,1
ENVR ,2 ,4
ENVR ,2 ,1
ENVR ,2 ,3
ECON ,4 ,3
ECON ,  ,4
ENVR ,  ,2
ENVR ,2 ,3
ENVR ,2 ,1
ENVR ,2 ,3
ECON ,3 ,4
ECON ,  ,4
ECON ,3 ,3
ENVR ,2 ,1
ENVR ,3 ,2
ECON ,3 ,2
ECON ,3 ,3
ENVR ,2 ,2
ENVR ,3 ,1
ENVR ,2 ,3
ENVR ,  ,1
ECON ,3 ,3
ENVR ,3 ,3
ECON ,3 ,1
ENVR ,2 ,1
ECON ,3 ,1
ENVR ,3 ,3
ENVR ,3 ,1
ECON ,3 ,2
ECON ,3 ,3
ENVR ,4 ,4
ENVR ,2 ,2
ENVR ,3 ,3
ENVR ,  ,3
ENVR ,3 ,3
ENVR ,1 ,1
ENVR ,3 ,2
ENVR ,3 ,2
LIT ,3 ,4
SOC ,3 ,4
SOC ,3 ,4
LIT ,3 ,3
LIT ,3 ,2
SOC ,3 ,3
PHIL ,3 ,3
SOC ,3 ,3
LIT ,4 ,3
SOC ,3 ,3
SOC ,2 ,1
LIT ,  , 
LIT ,  ,2
LIT ,3 ,2
SOC ,3 ,3
LIT ,3 ,2
LIT ,3 ,3
LIT ,3 ,3
LIT ,4 ,4
LIT ,3 ,3
SOC ,2 ,1
SOC ,3 ,3
LIT ,3 ,1
PHIL ,4 ,4
LIT ,  ,1
SOC ,2 ,3
LIT ,3 ,3
SOC ,3 ,3
SOC ,  , 
LIT ,3 ,2
LIT ,2 ,2
LIT ,4 ,4
SOC ,2 ,3
SOC ,3 ,2
SOC ,3 ,2
SOC ,3 ,3
PHIL ,4 ,3
SOC ,3 ,2
LIT ,2 ,1
SOC ,3 ,3
SOC ,3 ,2
SOC ,3 ,4
SOC ,3 ,3
PHIL ,3 ,2
LIT ,3 ,2
SOC ,4 ,4
LIT ,4 ,4
LIT ,3 ,3
LIT ,  ,3
SOC ,3 ,3
SOC ,4 ,3
PHIL ,4 ,3
SOC ,3 ,3
SOC ,3 , 
SOC ,2 ,2
SOC ,2 ,3
SOC ,2 ,3
PHIL ,3 ,3
LIT ,3 ,2
LIT ,4 ,2
PHIL ,2 ,3
LIT ,3 ,2
SOC ,3 ,2
SOC ,3 ,4
LIT ,3 ,2
SOC ,3 ,3
SOC ,3 ,3
LIT ,4 ,2
LIT ,4 ,3
SOC ,4 ,2
SOC ,4 ,2
LIT ,4 ,3
SOC ,3 ,3
LIT ,3 , 
LIT ,4 ,3
LIT ,3 ,4
LIT ,3 ,2
LIT ,3 ,3
PHIL ,1 ,2
LIT ,3 ,2
SOC ,3 ,3
SOC ,2 ,2
PHIL ,2 ,3
LIT ,3 , 
LIT ,3 ,3
LIT ,3 ,2
LIT ,3 ,2
SOC ,  ,3
LIT ,3 ,3
LIT ,4 ,2
SOC ,3 ,2
SOC ,3 ,3
LIT ,4 ,2
SOC ,3 ,2
SOC ,3 ,2
SOC ,  ,2
LIT ,3 ,3
PHIL ,3 ,4
SOC ,3 ,3
SOC ,3 ,3
SOC ,3 ,2
SOC ,3 ,1
SOC ,3 ,2
SOC ,  , 
LIT ,  , 
LIT ,3 ,3
LIT ,3 ,2
SOC ,3 ,1
LIT ,3 ,2
SOC ,3 ,3
PHIL ,3 , 
SOC ,4 ,3
SOC ,3 ,2
SOC ,3 ,2
LIT ,3 ,2
LIT ,4 ,4
ART ,3 ,1
ART ,4 ,2
ART ,3 ,2
ART ,3 ,2
ART ,4 ,3
ART ,4 , 
ART ,4 ,3
ART ,3 ,2
ART ,3 ,3
ART ,4 ,4
ART ,3 , 
ART ,3 ,1
ART ,1 ,2
ART ,3 ,2
ART ,3 ,2
ART ,3 ,1
ART ,3 ,2
ART ,3 ,3
ART ,3 ,3
ART ,3 ,2
ART ,4 ,4
ART ,4 ,2
ART ,3 ,2
ART ,3 ,2
ART ,4 ,4
ART ,  ,1
ART ,4 ,2
PSYC ,3 ,3
PSYC ,4 ,3
PSYC ,3 ,1
PSYC ,3 ,3
PSYC ,3 ,4
PSYC ,4 ,4
PSYC ,4 ,4
PSYC ,4 ,3
PSYC ,3 ,3
PSYC ,3 ,3
PSYC ,3 ,2
PSYC ,2 ,1
PSYC ,3 ,3
PSYC ,3 ,2
PSYC ,4 ,4
PSYC ,3 ,3
PSYC ,3 ,3
PSYC ,3 ,1
PSYC ,3 ,2
PSYC ,3 ,3
PSYC ,3 ,3
PSYC ,3 ,3
PSYC ,3 ,3
PSYC ,3 ,3
PSYC ,4 ,4
PSYC ,3 ,1
PSYC ,3 ,4
PSYC ,3 ,3
PSYC ,3 ,1
PSYC ,4 ,4
PSYC ,3 ,3
PSYC ,3 ,3
PSYC ,3 ,2
PSYC ,3 ,3
PSYC ,3 ,3
PSYC ,3 ,3
CLAS ,3 ,3
CLAS ,4 ,4
PSYC ,4 ,4
PSYC ,4 ,4
PSYC ,4 ,2
PSYC ,3 ,3
PSYC ,  ,1
PSYC ,3 ,3
PSYC ,4 ,1
CLAS ,3 ,2
CLAS ,4 ,4
PSYC ,3 ,3
PSYC ,4 ,2
PSYC ,3 ,2
PSYC ,3 ,2
PSYC ,3 ,2
PSYC ,  ,2
PSYC ,3 ,3
PSYC ,3 ,3
PSYC ,3 ,2
PSYC ,3 ,3
PSYC ,3 ,3
PSYC ,3 ,2
PSYC ,  ,2
PSYC ,  ,3
PSYC ,3 ,3
PSYC ,3 ,1
PSYC ,3 ,3
PSYC ,3 ,4
PSYC ,3 ,4
PSYC ,3 ,2
PSYC ,3 ,3
PSYC ,3 ,3
PSYC ,3 ,4
PSYC ,3 ,2
PSYC ,3 ,4
CLAS ,3 ,3
PSYC ,4 ,2
PSYC ,4 ,3
BIOL ,3 ,3
HIST ,3 ,1
BIOL ,4 ,3
CSCI ,3 ,3
ENVR ,3 ,2
HIST ,3 ,3
BIOL ,3 ,2
CSCI ,3 ,2
PHYS ,3 ,3
BIOL ,4 ,3
BIOL ,3 ,3
DRAM ,3 ,3
ENVR ,3 ,3
BIOL ,4 ,3
BIOL ,3 ,3
HIST ,  ,3
ENVR ,3 ,3
HIST ,3 ,3
CSCI ,2 ,1
ENVR ,3 ,3
HIST ,3 ,2
BIOL ,3 ,4
BIOL ,3 ,3
CSCI ,3 ,4
MATH ,4 ,4
ENVR ,3 ,3
HIST ,3 ,4
HIST ,3 ,3
ATMS ,4 ,4
PHYS ,3 ,3
BIOL ,3 ,1
DRAM ,1 ,3
MATH ,3 ,3
ATMS ,4 ,4
HIST ,3 ,2
HIST ,3 ,3
CSCI ,4 ,3
HIST ,3 ,2
BIOL ,3 ,3
HIST ,2 ,1
BIOL ,2 ,1
CSCI ,3 ,2
BIOL ,3 ,2
BIOL ,3 ,3
BIOL ,  ,2
HIST ,3 ,2
MATH ,4 ,2
PHYS ,3 ,2
ENVR ,1 ,1
ENVR ,3 ,2
ENVR ,1 ,1
ENVR ,3 ,1
CSCI ,4 ,2
CSCI ,3 ,3
BIOL ,2 ,3
ATMS ,2 ,2
ENVR ,3 ,3
ENVR ,3 ,2
BIOL ,3 ,3
ATMS ,3 ,2
HIST ,3 ,3
ENVR ,3 ,3
ENVR ,3 ,2
HIST ,3 ,2
ENVR ,2 ,3
CSCI ,3 ,3
ENVR ,3 ,2
ENVR ,3 ,3
BIOL ,4 ,2
ENVR ,3 ,3
PHYS ,  ,3
HIST ,3 ,2
CSCI ,3 ,3
ENVR ,2 ,2
BIOL ,2 ,4
PHYS ,3 ,2
HIST ,2 ,1
ATMS ,4 ,2
MATH ,3 ,3
ENVR ,3 ,2
CHEM ,3 ,4
ENVR ,3 ,3
BIOL ,2 ,2
BIOL ,4 ,3
CSCI ,3 ,2
ENVR ,3 ,3
ENVR ,3 ,3
MATH ,3 ,3
ENVR ,3 ,2
BIOL ,3 ,2
CHEM ,2 ,2
HIST ,3 ,3
HIST ,3 ,2
MATH ,3 ,3
MATH ,3 ,3
CHEM ,2 ,1
HIST ,3 ,4
CSCI ,  ,2
BIOL ,3 ,2
BIOL ,3 ,3
DRAM ,3 ,2
CSCI ,3 ,2
ENVR ,3 ,3
MATH ,4 ,4
CSCI ,3 ,3
DRAM ,4 ,4
CHEM ,3 ,3
ENVR ,3 ,3
HIST ,2 ,4
HIST ,3 ,3
ENVR ,1 ,3
ATMS ,2 ,2
BIOL ,3 ,4
BIOL ,2 ,2
PHYS ,1 ,1
BIOL ,3 ,2
ATMS ,3 ,4
BIOL ,4 ,4
MATH ,4 ,3
BIOL ,3 ,2
HIST ,  ,2
BIOL ,3 ,2
BIOL ,3 ,1
ATMS ,4 ,3
ENVR ,4 ,4
CHEM ,3 ,3
BIOL ,3 ,2
ATMS ,3 ,3
DRAM ,3 ,3
BIOL ,3 ,4
BIOL ,3 ,3
BIOL ,4 ,4
CSCI ,3 ,2
ATMS ,3 ,3
BIOL ,3 ,3
CSCI ,3 ,2
HIST ,3 ,3
ENVR ,3 ,3
CSCI ,3 ,2
CSCI ,4 ,4
ENVR ,3 ,4
ENVR ,2 ,2
CSCI ,3 ,2
ENVR ,3 ,2
ENVR ,3 ,3
BIOL ,3 ,2
BIOL ,3 ,3
HIST ,4 ,3
BIOL ,3 ,2
CSCI ,2 ,2
MATH ,3 ,4
ENVR ,3 ,3
ENVR ,3 ,3
CSCI ,4 ,4
BIOL ,3 ,3
BIOL ,2 ,1
CSCI ,3 ,2
BIOL ,4 ,4
CSCI ,3 ,3
BIOL ,3 ,4
ATMS ,4 ,3
BIOL ,3 ,4
CHEM ,3 ,2
BIOL ,3 ,2
CSCI ,3 ,3
BIOL ,4 ,3
BIOL ,3 ,2
ATMS ,3 ,3
CSCI ,3 ,4
HIST ,3 ,3
ENVR ,4 ,4
HIST ,2 ,1
CSCI ,3 ,2
MATH ,3 ,2
BIOL ,3 ,3
BIOL ,4 ,4
DRAM ,2 ,2
HIST ,3 ,2
BIOL ,3 ,2
ATMS ,4 ,4
DRAM ,3 ,3
ATMS ,4 ,3
CSCI ,3 ,2
BIOL ,4 ,3
CSCI ,2 ,3
CSCI ,3 ,1
BIOL ,3 ,3
ATMS ,3 ,3
ENVR ,2 ,3
DRAM ,2 ,2
ENVR ,3 ,2
ENVR ,4 ,4
PHYS ,3 ,2
BIOL ,4 ,4
ATMS ,3 ,3
BIOL ,3 ,3
ATMS ,3 ,3
ENVR ,3 ,3
CSCI ,3 ,3
ENVR ,1 ,3
BIOL ,3 , 
HIST ,3 ,3
HIST ,3 ,2
ENVR ,3 ,4
CHEM ,3 ,3
BIOL ,3 ,2
ATMS ,2 ,3
HIST ,3 ,2
ATMS ,4 ,4
BIOL ,3 ,2
BIOL ,3 ,3
CSCI ,3 ,2
ENVR ,3 ,3
BIOL ,3 ,3
ENVR ,3 ,2
CSCI ,  ,2
ENVR ,3 ,1
ENVR ,3 ,3
BIOL ,4 ,3
BIOL ,3 ,2
ENVR ,3 ,2
MATH ,3 ,2
ENVR ,3 ,2
BIOL ,3 ,4
BIOL ,3 ,3
ATMS ,4 ,4
BIOL ,3 ,2
CSCI ,3 ,1
ENVR ,3 ,3
ENVR ,  ,2
ATMS ,4 ,3
HIST ,3 ,2
CSCI ,3 ,2
CSCI ,4 ,3
HIST ,3 ,3
BIOL ,4 ,4
MATH ,4 ,4
MATH ,4 ,4
ENVR ,3 ,2
ENVR ,2 ,2
ENVR ,1 ,2
BIOL ,4 ,4
CHEM ,  ,3
HIST ,3 ,2
ENVR ,4 ,4
ENVR ,2 ,2
HIST ,2 ,3
BIOL ,3 ,1
ATMS ,4 ,4
ENVR ,3 ,4
CHEM ,2 ,2
BIOL ,2 ,2
BIOL ,2 ,3
ENVR ,3 ,3
ENVR ,3 ,2
DRAM ,4 ,3
ENVR ,2 ,3
ENVR ,4 ,2
CHEM ,1 ,1
MATH ,3 ,3
DRAM ,3 ,4
BIOL ,4 ,3
BIOL ,3 ,3
CSCI ,3 ,3
ENVR ,3 ,3
BIOL ,1 ,2
ATMS ,2 ,2
PHYS ,3 ,3
CHEM ,1 ,2
BIOL ,3 , 
HIST ,3 ,1
ENVR ,3 ,4
MATH ,  ,2
ENVR ,3 ,3
DRAM ,3 ,2
DRAM ,3 ,4
HIST ,4 ,4
HIST ,4 ,4
CSCI ,3 ,2
ENVR ,3 ,3
PHYS ,4 ,3
PHYS ,3 ,3
ENVR ,2 ,1
CSCI ,3 ,2

/* survey96.dat */

  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,0
2 ,W ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,3 ,1 ,1 ,2 ,3 ,1 ,2 ,2 ,2 ,2 ,2 ,2 ,3 ,5 ,5 ,3 ,4 ,5 ,3 ,2 ,3 ,2 ,2 ,2 ,25
3 ,X ,MH ,1 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,2 ,2 ,2 ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,2 ,3 ,2 ,1 ,4 ,3 ,5 ,5 ,5 ,5 ,5 ,5 ,2 ,1 ,2 ,5 ,3 ,0
2 ,W ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,4 ,2 ,3 ,3 ,4 ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,2 ,1 ,3 ,3 ,2 ,  ,  ,3 ,  ,  ,  ,  ,2 ,  ,3 ,40
2 ,W ,  ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,3 ,3 ,3 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,3 ,2 ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,3 ,0
4 ,P ,  ,1 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,1 ,2 ,1 ,4 ,2 ,1 ,1 ,3 ,1 ,3 ,2 ,3 ,3 ,3 ,3 ,3 ,  ,  ,  ,3 ,  ,  ,  ,1 ,2 ,  ,1 ,0
2 ,W ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,2 ,3 ,3 ,2 ,3 ,1 ,2 ,1 ,2 ,1 ,1 ,3 ,3 ,3 ,4 ,3 ,3 ,5 ,1 ,5 ,4 ,5 ,  ,2 ,2 ,1 ,3 ,1 ,40
4 ,W ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,1 ,2 ,2 ,3 ,4 ,4 ,1 ,4 ,1 ,1 ,4 ,3 ,1 ,1 ,2 ,2 ,4 ,4 ,5 ,4 ,5 ,5 ,4 ,3 ,5 ,5 ,1 ,40
1 ,W ,  ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,2 ,3 ,3 ,4 ,1 ,2 ,1 ,3 ,1 ,4 ,3 ,1 ,1 ,1 ,4 ,3 ,5 ,3 ,5 ,4 ,5 ,4 ,2 ,5 ,5 ,5 ,3 ,16
2 ,P ,MH ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,2 ,3 ,3 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,2 ,4 ,2 ,1 ,2 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,4 ,1 ,1 ,5 ,3 ,0
  ,W ,  ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,3 ,1 ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,2 ,3 ,4 ,5 ,5 ,4 ,5 ,5 ,5 ,5 ,5 ,5 ,4 ,0
1 ,W ,  ,1 ,1 ,0 ,1 ,1 ,0 ,1 ,1 ,0 ,1 ,1 ,0 ,4 ,2 ,3 ,3 ,4 ,1 ,1 ,1 ,2 ,1 ,2 ,1 ,1 ,1 ,1 ,3 ,3 ,5 ,5 ,5 ,3 ,5 ,3 ,5 ,5 ,5 ,5 ,2 ,27
  ,W ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,4 ,2 ,3 ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,2 ,  ,3 ,4 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,4 ,5 ,3 ,40
1 ,W ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,3 ,3 ,4 ,1 ,1 ,3 ,3 ,2 ,2 ,4 ,3 ,2 ,1 ,3 ,2 ,5 ,5 ,3 ,3 ,3 ,3 ,4 ,2 ,2 ,5 ,2 ,40
2 ,W ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,3 ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,2 ,2 ,3 ,4 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,3 ,3 ,3 ,32
4 ,W ,SS ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,2 ,1 ,2 ,2 ,3 ,1 ,3 ,1 ,2 ,1 ,1 ,1 ,1 ,4 ,1 ,2 ,  ,5 ,  ,5 ,  ,5 ,5 ,5 ,5 ,  ,5 ,  ,30
1 ,W ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,4 ,2 ,3 ,3 ,2 ,1 ,1 ,1 ,4 ,1 ,1 ,1 ,3 ,3 ,2 ,3 ,2 ,5 ,5 ,5 ,4 ,5 ,5 ,5 ,1 ,3 ,3 ,2 ,15
1 ,W ,  ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,4 ,3 ,4 ,4 ,4 ,1 ,  ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,3 ,3 ,4 ,5 ,  ,5 ,4 ,5 ,5 ,5 ,5 ,5 ,4 ,3 ,30
2 ,W ,  ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,3 ,2 ,3 ,3 ,3 ,1 ,1 ,1 ,2 ,1 ,1 ,2 ,2 ,2 ,1 ,3 ,3 ,5 ,5 ,5 ,3 ,5 ,5 ,3 ,3 ,3 ,5 ,3 ,33
  ,W ,  ,1 ,0 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,1 ,1 ,1 ,3 ,3 ,1 ,1 ,1 ,2 ,1 ,1 ,2 ,3 ,1 ,1 ,3 ,3 ,5 ,5 ,5 ,2 ,5 ,5 ,2 ,2 ,5 ,5 ,1 ,0
2 ,W ,  ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,2 ,2 ,2 ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,4 ,3 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,4 ,45
2 ,P ,HI ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,2 ,1 ,1 ,3 ,1 ,1 ,2 ,4 ,3 ,1 ,3 ,3 ,1 ,5 ,5 ,4 ,5 ,5 ,3 ,3 ,3 ,5 ,3 ,15
2 ,P ,HI ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,2 ,3 ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,0
1 ,W ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,4 ,3 ,3 ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,3 ,2 ,2 ,3 ,4 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,3 ,2 ,2 ,3 ,20
2 ,W ,  ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,2 ,2 ,2 ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,3 ,1 ,3 ,1 ,3 ,2 ,5 ,5 ,5 ,5 ,5 ,5 ,3 ,5 ,2 ,5 ,2 ,33
3 ,W ,  ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,2 ,2 ,3 ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,3 ,3 ,5 ,5 ,5 ,5 ,5 ,5 ,2 ,5 ,5 ,5 ,1 ,32
3 ,W ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,3 ,2 ,2 ,3 ,4 ,1 ,1 ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,4 ,3 ,5 ,5 ,5 ,4 ,5 ,5 ,5 ,5 ,5 ,5 ,1 ,25
3 ,P ,HI ,1 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,1 ,1 ,0 ,0 ,3 ,3 ,3 ,3 ,3 ,1 ,1 ,1 ,3 ,1 ,1 ,1 ,4 ,2 ,2 ,3 ,3 ,5 ,5 ,5 ,4 ,5 ,5 ,5 ,2 ,2 ,3 ,4 ,0
2 ,W ,  ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,3 ,1 ,3 ,4 ,5 ,5 ,5 ,4 ,5 ,5 ,5 ,5 ,3 ,5 ,3 ,14
2 ,W ,  ,1 ,0 ,0 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,3 ,2 ,2 ,2 ,4 ,1 ,1 ,1 ,4 ,1 ,2 ,3 ,2 ,2 ,1 ,4 ,4 ,5 ,5 ,5 ,4 ,5 ,2 ,4 ,3 ,3 ,5 ,3 ,0
1 ,W ,  ,1 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,2 ,1 ,1 ,3 ,1 ,1 ,4 ,1 ,1 ,1 ,2 ,4 ,1 ,5 ,5 ,4 ,5 ,5 ,3 ,5 ,5 ,5 ,2 ,10
1 ,W ,  ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,3 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,4 ,4 ,3 ,3 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,3 ,45
3 ,W ,  ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,3 ,3 ,3 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,3 ,3 ,40
1 ,W ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,4 ,4 ,4 ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,4 ,1 ,1 ,2 ,4 ,3 ,3 ,5 ,5 ,5 ,5 ,5 ,3 ,5 ,5 ,2 ,4 ,3 ,20
2 ,W ,AYC ,1 ,0 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,3 ,2 ,3 ,2 ,4 ,3 ,  ,1 ,1 ,1 ,1 ,1 ,2 ,1 ,1 ,4 ,4 ,3 ,  ,5 ,5 ,5 ,5 ,5 ,1 ,5 ,5 ,2 ,0
3 ,P ,SCH ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,3 ,1 ,2 ,2 ,3 ,1 ,3 ,1 ,3 ,1 ,1 ,1 ,4 ,2 ,1 ,3 ,2 ,5 ,3 ,5 ,2 ,5 ,5 ,5 ,2 ,1 ,5 ,2 ,18
  ,W ,  ,1 ,0 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,4 ,1 ,2 ,1 ,4 ,1 ,1 ,1 ,3 ,1 ,1 ,1 ,1 ,2 ,4 ,3 ,1 ,5 ,5 ,5 ,3 ,5 ,5 ,5 ,5 ,1 ,3 ,3 ,0
1 ,P ,  ,1 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,4 ,2 ,3 ,2 ,2 ,1 ,3 ,1 ,1 ,1 ,2 ,2 ,2 ,3 ,2 ,1 ,2 ,5 ,2 ,5 ,5 ,5 ,3 ,3 ,4 ,3 ,0
1 ,W ,  ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,4 ,2 ,3 ,4 ,4 ,1 ,1 ,1 ,1 ,1 ,2 ,3 ,4 ,3 ,2 ,3 ,4 ,5 ,5 ,5 ,5 ,5 ,3 ,4 ,4 ,4 ,3 ,3 ,0
2 ,W ,  ,1 ,1 ,0 ,1 ,1 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,3 ,2 ,2 ,3 ,4 ,3 ,1 ,1 ,1 ,1 ,1 ,2 ,1 ,1 ,2 ,3 ,4 ,4 ,5 ,5 ,5 ,5 ,5 ,2 ,5 ,5 ,2 ,2 ,20
2 ,W ,  ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,2 ,2 ,1 ,1 ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,3 ,3 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,3 ,40
3 ,W ,  ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,1 ,0 ,0 ,3 ,4 ,3 ,3 ,3 ,1 ,1 ,1 ,4 ,1 ,1 ,1 ,1 ,1 ,3 ,3 ,4 ,5 ,5 ,5 ,4 ,5 ,5 ,5 ,5 ,5 ,3 ,3 ,21
2 ,W ,  ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,4 ,3 ,3 ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,3 ,3 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,3 ,20
3 ,W ,  ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,3 ,3 ,3 ,3 ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,2 ,2 ,4 ,2 ,  ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,  ,4 ,4 ,4 ,0
  ,W ,  ,1 ,1 ,0 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,1 ,3 ,  ,  ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,3 ,4 ,3 ,4 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,1 ,4 ,3 ,18
4 ,X ,CRH ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,3 ,1 ,2 ,1 ,4 ,3 ,1 ,1 ,4 ,1 ,3 ,2 ,4 ,4 ,1 ,4 ,3 ,4 ,5 ,5 ,4 ,5 ,4 ,3 ,2 ,2 ,5 ,3 ,13
2 ,W ,  ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,3 ,2 ,2 ,2 ,3 ,1 ,1 ,1 ,2 ,1 ,1 ,2 ,3 ,2 ,1 ,3 ,3 ,5 ,5 ,5 ,3 ,5 ,5 ,3 ,3 ,4 ,5 ,4 ,25
1 ,W ,  ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,3 ,4 ,3 ,3 ,3 ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,2 ,2 ,3 ,4 ,5 ,5 ,5 ,4 ,5 ,5 ,5 ,5 ,4 ,4 ,4 ,10
2 ,W ,  ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,4 ,4 ,3 ,4 ,3 ,3 ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,3 ,3 ,4 ,1 ,1 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,4 ,2 ,23
  ,W ,  ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,4 ,2 ,3 ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,2 ,2 ,1 ,1 ,1 ,2 ,4 ,5 ,5 ,5 ,5 ,5 ,3 ,3 ,5 ,5 ,5 ,2 ,0
2 ,W ,  ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,3 ,3 ,4 ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,2 ,3 ,4 ,5 ,5 ,5 ,4 ,5 ,5 ,5 ,5 ,5 ,4 ,2 ,28
2 ,X ,HI ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,3 ,4 ,3 ,3 ,3 ,2 ,1 ,1 ,1 ,2 ,2 ,1 ,1 ,3 ,3 ,3 ,4 ,2 ,5 ,5 ,5 ,4 ,3 ,5 ,5 ,4 ,15
2 ,P ,MOH ,1 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,2 ,3 ,1 ,1 ,1 ,3 ,1 ,1 ,1 ,4 ,3 ,1 ,3 ,3 ,5 ,5 ,5 ,2 ,5 ,5 ,5 ,1 ,2 ,5 ,1 ,10
1 ,W ,  ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,4 ,3 ,3 ,3 ,4 ,2 ,1 ,2 ,2 ,1 ,1 ,1 ,3 ,3 ,3 ,4 ,3 ,2 ,5 ,2 ,3 ,5 ,5 ,5 ,4 ,1 ,3 ,3 ,45
2 ,W ,  ,1 ,0 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,2 ,3 ,2 ,4 ,1 ,1 ,1 ,3 ,1 ,1 ,1 ,2 ,1 ,1 ,3 ,4 ,5 ,5 ,5 ,3 ,5 ,5 ,5 ,3 ,5 ,5 ,3 ,0
  ,W ,  ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,2 ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,3 ,4 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,4 ,0
3 ,W ,  ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,3 ,3 ,4 ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,4 ,4 ,2 ,5 ,5 ,3 ,5 ,5 ,5 ,5 ,5 ,5 ,2 ,40
  ,W ,  ,1 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,4 ,3 ,3 ,3 ,4 ,1 ,1 ,1 ,2 ,1 ,1 ,2 ,2 ,1 ,1 ,4 ,4 ,5 ,5 ,5 ,4 ,5 ,5 ,4 ,2 ,5 ,5 ,2 ,0
2 ,W ,  ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,4 ,3 ,1 ,1 ,1 ,3 ,1 ,1 ,1 ,3 ,1 ,1 ,3 ,4 ,5 ,5 ,5 ,4 ,5 ,5 ,5 ,4 ,5 ,5 ,4 ,40
1 ,W ,  ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,4 ,2 ,3 ,3 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,2 ,3 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,  ,44
1 ,W ,  ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,3 ,2 ,3 ,3 ,3 ,1 ,2 ,1 ,2 ,1 ,1 ,3 ,1 ,2 ,2 ,3 ,3 ,5 ,2 ,5 ,3 ,5 ,5 ,3 ,5 ,3 ,3 ,3 ,0
2 ,W ,  ,1 ,1 ,0 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,2 ,1 ,2 ,1 ,4 ,2 ,1 ,1 ,3 ,1 ,1 ,1 ,1 ,3 ,4 ,3 ,4 ,4 ,5 ,5 ,4 ,5 ,5 ,5 ,5 ,1 ,4 ,4 ,20
2 ,W ,  ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,3 ,1 ,1 ,1 ,4 ,1 ,1 ,1 ,4 ,4 ,2 ,3 ,3 ,5 ,5 ,5 ,4 ,5 ,5 ,5 ,3 ,2 ,2 ,3 ,24
4 ,X ,MH ,1 ,0 ,1 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,2 ,2 ,2 ,1 ,1 ,2 ,2 ,1 ,1 ,3 ,4 ,3 ,2 ,2 ,3 ,5 ,5 ,2 ,3 ,5 ,5 ,2 ,1 ,3 ,2 ,2 ,0
2 ,W ,  ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,3 ,2 ,3 ,3 ,4 ,2 ,3 ,1 ,2 ,1 ,1 ,2 ,1 ,2 ,3 ,4 ,4 ,3 ,4 ,5 ,4 ,5 ,5 ,4 ,5 ,3 ,3 ,3 ,40
4 ,X ,MOH ,1 ,0 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,3 ,1 ,2 ,2 ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,3 ,4 ,2 ,1 ,4 ,4 ,5 ,5 ,5 ,5 ,5 ,5 ,4 ,2 ,3 ,5 ,3 ,0
4 ,W ,  ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,4 ,4 ,3 ,1 ,1 ,4 ,1 ,1 ,1 ,1 ,3 ,4 ,4 ,3 ,2 ,5 ,5 ,4 ,5 ,5 ,5 ,5 ,3 ,4 ,2 ,15
4 ,X ,MT ,2 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,2 ,3 ,1 ,4 ,1 ,1 ,1 ,3 ,1 ,1 ,1 ,3 ,4 ,2 ,2 ,4 ,5 ,5 ,5 ,3 ,5 ,5 ,  ,3 ,3 ,2 ,3 ,10
3 ,X ,HI ,2 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,3 ,1 ,3 ,3 ,1 ,3 ,2 ,4 ,2 ,2 ,3 ,4 ,3 ,5 ,3 ,4 ,5 ,4 ,3 ,2 ,2 ,2 ,2 ,0
3 ,W ,  ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,4 ,2 ,3 ,3 ,4 ,2 ,1 ,1 ,2 ,1 ,1 ,4 ,1 ,2 ,1 ,3 ,4 ,4 ,5 ,5 ,3 ,5 ,5 ,4 ,5 ,3 ,5 ,3 ,10
  ,W ,  ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,4 ,4 ,4 ,3 ,4 ,2 ,2 ,3 ,3 ,1 ,1 ,2 ,2 ,4 ,2 ,4 ,4 ,4 ,4 ,4 ,4 ,  ,  ,3 ,3 ,4 ,4 ,3 ,0
3 ,W ,  ,2 ,1 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,  ,2 ,2 ,  ,3 ,1 ,1 ,2 ,2 ,1 ,1 ,2 ,2 ,2 ,3 ,2 ,2 ,5 ,5 ,3 ,4 ,5 ,5 ,1 ,2 ,  ,3 ,2 ,20
2 ,W ,  ,2 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,4 ,3 ,4 ,4 ,4 ,2 ,1 ,1 ,1 ,1 ,1 ,2 ,3 ,2 ,3 ,2 ,3 ,4 ,5 ,5 ,5 ,5 ,5 ,4 ,3 ,2 ,3 ,2 ,0
3 ,W ,MH ,2 ,0 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,2 ,2 ,4 ,1 ,1 ,2 ,4 ,1 ,1 ,1 ,4 ,2 ,1 ,4 ,2 ,5 ,5 ,3 ,4 ,5 ,5 ,5 ,3 ,3 ,5 ,1 ,0
3 ,P ,ASH ,2 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,4 ,1 ,3 ,3 ,3 ,2 ,4 ,1 ,3 ,4 ,4 ,4 ,4 ,3 ,1 ,2 ,2 ,3 ,4 ,5 ,4 ,4 ,4 ,4 ,2 ,1 ,5 ,2 ,0
2 ,W ,  ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,1 ,2 ,2 ,2 ,2 ,3 ,1 ,1 ,2 ,3 ,1 ,2 ,4 ,1 ,4 ,1 ,2 ,3 ,5 ,5 ,2 ,4 ,5 ,2 ,4 ,5 ,3 ,5 ,2 ,17
2 ,P ,  ,2 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,2 ,3 ,4 ,1 ,1 ,3 ,1 ,1 ,1 ,1 ,2 ,3 ,3 ,4 ,2 ,5 ,5 ,3 ,5 ,5 ,5 ,5 ,2 ,3 ,4 ,0
3 ,W ,HI ,2 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,2 ,4 ,1 ,1 ,1 ,2 ,1 ,2 ,3 ,3 ,2 ,1 ,3 ,  ,5 ,5 ,5 ,2 ,5 ,3 ,4 ,3 ,2 ,5 ,4 ,0
2 ,P ,  ,2 ,1 ,0 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,3 ,3 ,3 ,3 ,3 ,3 ,1 ,1 ,3 ,1 ,2 ,2 ,2 ,3 ,2 ,3 ,3 ,3 ,5 ,5 ,4 ,3 ,3 ,3 ,3 ,4 ,1 ,3 ,15
1 ,P ,  ,2 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,1 ,0 ,2 ,2 ,2 ,2 ,3 ,1 ,2 ,1 ,3 ,1 ,2 ,1 ,4 ,3 ,2 ,4 ,4 ,  ,4 ,  ,2 ,  ,3 ,  ,3 ,2 ,2 ,1 ,35
3 ,W ,  ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,1 ,1 ,1 ,4 ,1 ,3 ,3 ,2 ,3 ,3 ,3 ,4 ,5 ,5 ,5 ,4 ,5 ,4 ,4 ,4 ,4 ,4 ,4 ,37
1 ,W ,  ,2 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,4 ,3 ,3 ,3 ,2 ,1 ,1 ,4 ,1 ,3 ,1 ,4 ,4 ,3 ,4 ,2 ,1 ,5 ,5 ,4 ,5 ,3 ,5 ,1 ,3 ,2 ,1 ,0
3 ,W ,HI ,2 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,4 ,2 ,3 ,2 ,3 ,1 ,1 ,3 ,3 ,1 ,2 ,4 ,4 ,3 ,1 ,3 ,1 ,5 ,5 ,3 ,3 ,5 ,3 ,4 ,3 ,2 ,5 ,3 ,0
1 ,W ,  ,2 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,2 ,4 ,3 ,1 ,1 ,4 ,1 ,1 ,4 ,1 ,1 ,3 ,4 ,4 ,3 ,5 ,5 ,4 ,5 ,5 ,4 ,5 ,5 ,4 ,4 ,15
2 ,W ,HI ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,2 ,2 ,3 ,2 ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,2 ,4 ,3 ,3 ,3 ,5 ,5 ,2 ,5 ,5 ,5 ,5 ,3 ,3 ,2 ,3 ,8
2 ,W ,  ,2 ,1 ,0 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,3 ,2 ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,4 ,1 ,4 ,2 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,2 ,5 ,2 ,20
3 ,W ,  ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,2 ,1 ,3 ,3 ,3 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,2 ,5 ,3 ,3 ,26
3 ,P ,  ,2 ,1 ,0 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,1 ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,3 ,1 ,1 ,3 ,4 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,3 ,5 ,5 ,3 ,25
2 ,P ,SR ,2 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,3 ,3 ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,4 ,4 ,2 ,3 ,3 ,4 ,5 ,5 ,5 ,5 ,5 ,5 ,3 ,4 ,4 ,3 ,0
  ,W ,  ,2 ,1 ,1 ,0 ,0 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,4 ,4 ,3 ,3 ,4 ,1 ,1 ,1 ,2 ,1 ,1 ,4 ,1 ,2 ,4 ,2 ,4 ,5 ,5 ,5 ,4 ,5 ,5 ,4 ,5 ,2 ,4 ,4 ,25
2 ,W ,  ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,1 ,0 ,1 ,4 ,3 ,4 ,2 ,4 ,3 ,1 ,1 ,3 ,1 ,2 ,1 ,1 ,2 ,4 ,4 ,4 ,3 ,5 ,5 ,3 ,5 ,3 ,5 ,5 ,2 ,4 ,3 ,15
4 ,W ,  ,2 ,0 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,4 ,3 ,3 ,3 ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,4 ,1 ,1 ,2 ,2 ,3 ,5 ,5 ,5 ,5 ,5 ,5 ,4 ,5 ,5 ,3 ,3 ,0
1 ,P ,  ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,2 ,3 ,2 ,4 ,1 ,1 ,1 ,3 ,1 ,1 ,1 ,3 ,3 ,1 ,3 ,4 ,5 ,5 ,5 ,4 ,5 ,5 ,5 ,1 ,1 ,5 ,3 ,8
2 ,W ,HI ,2 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,2 ,3 ,1 ,1 ,2 ,4 ,1 ,1 ,1 ,4 ,3 ,1 ,2 ,2 ,5 ,5 ,2 ,2 ,5 ,5 ,5 ,2 ,3 ,5 ,2 ,30
2 ,W ,  ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,3 ,3 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,3 ,0
2 ,W ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,3 ,3 ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,3 ,1 ,2 ,3 ,2 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,3 ,5 ,3 ,3 ,23
1 ,W ,MH ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,4 ,3 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,4 ,2 ,1 ,3 ,4 ,5 ,5 ,3 ,5 ,5 ,5 ,5 ,1 ,1 ,5 ,2 ,0
1 ,W ,  ,2 ,0 ,0 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,1 ,1 ,4 ,3 ,4 ,4 ,4 ,1 ,3 ,1 ,3 ,1 ,1 ,1 ,2 ,2 ,4 ,3 ,3 ,5 ,4 ,5 ,4 ,5 ,5 ,5 ,3 ,2 ,4 ,1 ,0
1 ,W ,HI ,2 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,4 ,3 ,3 ,3 ,3 ,2 ,2 ,1 ,3 ,1 ,3 ,2 ,4 ,3 ,1 ,3 ,4 ,3 ,4 ,5 ,3 ,5 ,3 ,2 ,1 ,1 ,5 ,1 ,4
2 ,P ,CRH ,2 ,0 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,3 ,3 ,3 ,3 ,4 ,1 ,1 ,1 ,3 ,1 ,1 ,3 ,4 ,2 ,2 ,3 ,4 ,5 ,5 ,5 ,4 ,5 ,5 ,1 ,2 ,2 ,4 ,4 ,6
2 ,W ,ASH ,2 ,0 ,1 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,3 ,4 ,3 ,2 ,2 ,1 ,4 ,1 ,1 ,4 ,4 ,2 ,2 ,3 ,4 ,5 ,4 ,5 ,4 ,5 ,5 ,4 ,2 ,3 ,4 ,3 ,0
1 ,W ,SS ,2 ,0 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,2 ,3 ,4 ,3 ,1 ,1 ,3 ,1 ,1 ,1 ,1 ,4 ,2 ,3 ,3 ,3 ,5 ,5 ,2 ,5 ,5 ,5 ,5 ,3 ,3 ,1 ,0
2 ,W ,GAH ,2 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,3 ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,4 ,3 ,2 ,3 ,1 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,2 ,3 ,2 ,3 ,16
2 ,W ,  ,2 ,0 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,3 ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,4 ,2 ,3 ,5 ,5 ,5 ,5 ,5 ,3 ,5 ,5 ,5 ,3 ,3 ,0
3 ,W ,  ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,3 ,3 ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,4 ,2 ,4 ,3 ,5 ,5 ,3 ,5 ,5 ,5 ,5 ,5 ,4 ,4 ,3 ,24
3 ,P ,HI ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,3 ,4 ,4 ,3 ,4 ,1 ,1 ,2 ,3 ,1 ,1 ,1 ,4 ,4 ,1 ,4 ,3 ,3 ,3 ,3 ,3 ,3 ,3 ,3 ,3 ,3 ,3 ,3 ,6
1 ,W ,GAH ,2 ,0 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,3 ,3 ,4 ,1 ,1 ,2 ,4 ,1 ,1 ,1 ,4 ,2 ,1 ,4 ,3 ,5 ,5 ,2 ,3 ,5 ,5 ,5 ,1 ,2 ,5 ,2 ,0
2 ,W ,SR ,2 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,3 ,2 ,2 ,2 ,2 ,2 ,1 ,2 ,1 ,3 ,2 ,4 ,3 ,1 ,1 ,3 ,3 ,1 ,5 ,3 ,5 ,4 ,3 ,2 ,3 ,5 ,5 ,0
4 ,W ,  ,2 ,1 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,4 ,3 ,3 ,3 ,2 ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,2 ,3 ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,3 ,50
2 ,W ,HI ,2 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,2 ,3 ,3 ,2 ,3 ,1 ,1 ,1 ,3 ,1 ,2 ,1 ,3 ,4 ,1 ,4 ,3 ,5 ,5 ,5 ,3 ,5 ,3 ,5 ,2 ,3 ,5 ,4 ,0
  ,W ,  ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,4 ,2 ,3 ,2 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,4 ,3 ,40
3 ,P ,HI ,2 ,0 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,4 ,2 ,2 ,3 ,3 ,1 ,1 ,1 ,3 ,1 ,1 ,2 ,4 ,3 ,2 ,3 ,4 ,5 ,5 ,5 ,4 ,5 ,5 ,2 ,1 ,3 ,3 ,3 ,0
3 ,P ,HI ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,2 ,1 ,3 ,3 ,3 ,2 ,1 ,1 ,2 ,1 ,1 ,4 ,4 ,3 ,1 ,3 ,3 ,1 ,5 ,5 ,2 ,5 ,5 ,2 ,1 ,2 ,5 ,2 ,10
  ,W ,  ,2 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,1 ,4 ,2 ,3 ,4 ,4 ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,3 ,3 ,4 ,3 ,4 ,5 ,5 ,5 ,4 ,5 ,5 ,5 ,3 ,3 ,5 ,3 ,0
2 ,W ,  ,2 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,4 ,3 ,4 ,1 ,1 ,2 ,2 ,1 ,2 ,1 ,2 ,2 ,3 ,3 ,4 ,5 ,5 ,5 ,3 ,5 ,4 ,5 ,5 ,2 ,3 ,3 ,6
2 ,P ,SR ,2 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,3 ,2 ,2 ,3 ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,4 ,2 ,1 ,3 ,3 ,5 ,5 ,5 ,3 ,5 ,5 ,5 ,2 ,2 ,5 ,3 ,0
1 ,W ,  ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,3 ,4 ,1 ,2 ,1 ,3 ,1 ,1 ,1 ,2 ,1 ,3 ,3 ,3 ,5 ,1 ,5 ,4 ,5 ,5 ,5 ,3 ,5 ,3 ,2 ,30
1 ,P ,  ,2 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,4 ,4 ,1 ,1 ,1 ,4 ,1 ,1 ,2 ,4 ,2 ,1 ,4 ,4 ,5 ,5 ,5 ,4 ,5 ,5 ,3 ,3 ,3 ,5 ,3 ,23
3 ,P ,MH ,2 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,2 ,1 ,2 ,2 ,4 ,1 ,1 ,1 ,1 ,1 ,3 ,2 ,4 ,2 ,1 ,4 ,3 ,5 ,5 ,5 ,5 ,5 ,3 ,3 ,2 ,3 ,5 ,2 ,0
1 ,P ,  ,2 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,3 ,1 ,3 ,2 ,3 ,1 ,1 ,3 ,3 ,1 ,1 ,2 ,1 ,1 ,2 ,2 ,3 ,5 ,5 ,3 ,4 ,5 ,5 ,3 ,5 ,5 ,4 ,3 ,20
2 ,P ,HI ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,2 ,3 ,3 ,4 ,1 ,1 ,1 ,4 ,1 ,1 ,1 ,4 ,4 ,1 ,4 ,4 ,5 ,5 ,5 ,2 ,5 ,5 ,5 ,1 ,1 ,5 ,1 ,8
2 ,P ,MT ,2 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,2 ,3 ,2 ,4 ,1 ,1 ,1 ,3 ,1 ,4 ,1 ,1 ,1 ,1 ,3 ,3 ,5 ,5 ,5 ,2 ,5 ,4 ,5 ,5 ,5 ,5 ,2 ,0
2 ,W ,  ,2 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,1 ,1 ,1 ,2 ,1 ,1 ,4 ,1 ,1 ,4 ,2 ,2 ,5 ,5 ,5 ,3 ,5 ,5 ,4 ,5 ,5 ,4 ,3 ,10
3 ,P ,SR ,2 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,2 ,2 ,2 ,1 ,2 ,2 ,3 ,1 ,1 ,2 ,4 ,2 ,1 ,3 ,3 ,5 ,3 ,3 ,3 ,5 ,5 ,2 ,3 ,2 ,5 ,4 ,0
2 ,W ,  ,2 ,1 ,0 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,4 ,3 ,4 ,4 ,4 ,1 ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,2 ,4 ,3 ,4 ,5 ,4 ,5 ,5 ,5 ,5 ,5 ,5 ,2 ,4 ,3 ,20
  ,W ,  ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,4 ,4 ,4 ,4 ,4 ,3 ,4 ,2 ,2 ,1 ,1 ,1 ,3 ,3 ,1 ,4 ,4 ,3 ,4 ,3 ,2 ,5 ,5 ,5 ,3 ,3 ,5 ,2 ,18
2 ,W ,  ,2 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,3 ,3 ,3 ,4 ,2 ,2 ,3 ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,4 ,3 ,  ,  ,  ,5 ,5 ,5 ,3 ,5 ,5 ,5 ,3 ,40
3 ,W ,  ,2 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,2 ,2 ,2 ,2 ,3 ,1 ,1 ,1 ,1 ,1 ,3 ,2 ,1 ,1 ,1 ,3 ,4 ,5 ,5 ,5 ,5 ,5 ,4 ,2 ,5 ,5 ,5 ,3 ,28
2 ,W ,  ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,3 ,2 ,3 ,3 ,3 ,1 ,1 ,1 ,2 ,1 ,1 ,2 ,1 ,3 ,3 ,3 ,3 ,5 ,5 ,5 ,3 ,5 ,5 ,2 ,5 ,2 ,3 ,3 ,16
1 ,P ,HI ,2 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,4 ,3 ,2 ,2 ,1 ,3 ,1 ,1 ,2 ,4 ,1 ,2 ,4 ,3 ,3 ,3 ,5 ,3 ,5 ,5 ,4 ,2 ,5 ,4 ,4 ,20
1 ,W ,MH ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,2 ,3 ,2 ,4 ,2 ,4 ,2 ,3 ,1 ,1 ,1 ,4 ,3 ,1 ,4 ,4 ,5 ,4 ,5 ,4 ,5 ,5 ,5 ,4 ,3 ,5 ,4 ,0
3 ,P ,HI ,2 ,0 ,0 ,0 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,4 ,3 ,1 ,4 ,3 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,2 ,3 ,5 ,3 ,0
3 ,P ,MH ,2 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,2 ,1 ,2 ,2 ,4 ,1 ,1 ,1 ,1 ,1 ,3 ,2 ,4 ,3 ,1 ,4 ,3 ,5 ,5 ,5 ,5 ,5 ,  ,3 ,2 ,2 ,5 ,3 ,8
2 ,W ,  ,2 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,4 ,3 ,4 ,3 ,4 ,1 ,1 ,1 ,1 ,1 ,3 ,4 ,1 ,3 ,1 ,4 ,4 ,5 ,5 ,5 ,5 ,5 ,1 ,4 ,5 ,2 ,5 ,1 ,15
2 ,W ,  ,2 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,2 ,3 ,3 ,4 ,1 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,4 ,3 ,3 ,5 ,3 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,2 ,3 ,0
1 ,W ,  ,2 ,0 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,1 ,3 ,2 ,4 ,3 ,3 ,1 ,1 ,1 ,1 ,3 ,3 ,3 ,3 ,3 ,4 ,2 ,3 ,5 ,1 ,5 ,5 ,5 ,2 ,1 ,3 ,4 ,0
4 ,W ,  ,2 ,1 ,0 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,4 ,3 ,4 ,  ,4 ,2 ,3 ,2 ,4 ,1 ,1 ,1 ,3 ,3 ,3 ,4 ,3 ,2 ,3 ,5 ,4 ,5 ,5 ,5 ,4 ,3 ,3 ,4 ,20
2 ,W ,CRH ,2 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,3 ,3 ,2 ,2 ,1 ,2 ,1 ,2 ,1 ,4 ,2 ,2 ,2 ,3 ,2 ,3 ,5 ,2 ,5 ,3 ,5 ,2 ,2 ,3 ,3 ,0
2 ,P ,HI ,2 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,3 ,3 ,4 ,3 ,2 ,1 ,4 ,1 ,1 ,1 ,4 ,4 ,1 ,4 ,2 ,3 ,4 ,5 ,4 ,5 ,5 ,5 ,3 ,2 ,5 ,2 ,0
2 ,W ,CRH ,2 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,3 ,3 ,3 ,2 ,1 ,1 ,3 ,1 ,1 ,1 ,4 ,2 ,1 ,2 ,4 ,3 ,5 ,5 ,4 ,5 ,5 ,5 ,3 ,3 ,5 ,3 ,10
1 ,W ,  ,2 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,4 ,4 ,2 ,1 ,2 ,3 ,1 ,1 ,2 ,3 ,1 ,1 ,4 ,4 ,4 ,5 ,4 ,4 ,5 ,5 ,4 ,4 ,5 ,5 ,4 ,40
3 ,X ,HI ,2 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,3 ,1 ,1 ,3 ,1 ,1 ,2 ,  ,3 ,3 ,3 ,3 ,3 ,5 ,5 ,3 ,5 ,5 ,3 ,  ,3 ,4 ,3 ,12
3 ,X ,  ,2 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,3 ,2 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,2 ,1 ,3 ,4 ,2 ,5 ,5 ,3 ,5 ,5 ,5 ,5 ,3 ,5 ,3 ,0
2 ,W ,  ,2 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,2 ,3 ,3 ,3 ,1 ,1 ,1 ,2 ,1 ,1 ,4 ,2 ,2 ,3 ,4 ,3 ,5 ,5 ,5 ,2 ,5 ,5 ,4 ,3 ,3 ,2 ,4 ,0
3 ,W ,  ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,1 ,1 ,3 ,3 ,1 ,1 ,1 ,3 ,1 ,1 ,2 ,1 ,2 ,1 ,3 ,3 ,5 ,5 ,5 ,4 ,5 ,5 ,4 ,5 ,3 ,5 ,1 ,30
2 ,W ,  ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,3 ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,3 ,1 ,2 ,2 ,3 ,5 ,5 ,5 ,3 ,5 ,5 ,5 ,3 ,5 ,3 ,3 ,40
2 ,W ,  ,2 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,2 ,3 ,2 ,2 ,3 ,1 ,1 ,1 ,2 ,1 ,1 ,3 ,4 ,1 ,1 ,2 ,3 ,5 ,5 ,5 ,4 ,5 ,5 ,3 ,1 ,5 ,5 ,2 ,0
1 ,P ,  ,2 ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,0
1 ,W ,  ,2 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,4 ,3 ,3 ,1 ,2 ,2 ,4 ,1 ,1 ,1 ,2 ,3 ,2 ,4 ,2 ,5 ,4 ,2 ,4 ,5 ,5 ,5 ,1 ,2 ,4 ,3 ,25
2 ,X ,SCH ,2 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,3 ,3 ,3 ,3 ,3 ,1 ,1 ,1 ,4 ,1 ,1 ,1 ,4 ,3 ,1 ,3 ,4 ,5 ,5 ,5 ,4 ,5 ,5 ,5 ,2 ,2 ,5 ,1 ,4
1 ,W ,  ,2 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,  ,3 ,2 ,2 ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,4 ,2 ,1 ,4 ,2 ,3 ,5 ,5 ,3 ,5 ,5 ,5 ,4 ,3 ,5 ,4 ,3 ,0
1 ,X ,HI ,2 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,4 ,4 ,3 ,4 ,1 ,2 ,1 ,2 ,1 ,1 ,1 ,4 ,3 ,1 ,3 ,3 ,5 ,4 ,5 ,4 ,5 ,5 ,5 ,2 ,3 ,5 ,2 ,0
1 ,W ,  ,2 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,3 ,3 ,4 ,2 ,1 ,2 ,2 ,1 ,1 ,4 ,2 ,4 ,2 ,4 ,2 ,2 ,2 ,2 ,  ,5 ,5 ,4 ,2 ,3 ,2 ,3 ,42
  ,W ,  ,2 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,4 ,3 ,3 ,3 ,4 ,1 ,1 ,1 ,1 ,1 ,3 ,3 ,2 ,2 ,2 ,4 ,4 ,5 ,5 ,5 ,5 ,5 ,4 ,4 ,3 ,2 ,2 ,3 ,0
1 ,P ,  ,2 ,0 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,4 ,  ,  ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,2 ,4 ,3 ,4 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,1 ,4 ,2 ,0
4 ,P ,SR ,2 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,3 ,2 ,3 ,3 ,1 ,3 ,3 ,1 ,3 ,2 ,3 ,3 ,2 ,4 ,3 ,3 ,5 ,3 ,2 ,5 ,4 ,3 ,1 ,2 ,3 ,3 ,0
3 ,X ,SS ,2 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,3 ,3 ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,4 ,3 ,4 ,3 ,4 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,3 ,2 ,4 ,3 ,5
2 ,P ,HI ,2 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,2 ,3 ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,4 ,1 ,3 ,4 ,4 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,1 ,5 ,2 ,2 ,0
  ,W ,  ,2 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,4 ,3 ,3 ,3 ,4 ,1 ,4 ,1 ,2 ,1 ,2 ,4 ,3 ,3 ,3 ,3 ,4 ,5 ,4 ,5 ,3 ,5 ,  ,3 ,3 ,3 ,4 ,4 ,0
1 ,X ,  ,2 ,0 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,3 ,2 ,2 ,2 ,4 ,1 ,1 ,1 ,2 ,1 ,2 ,3 ,2 ,3 ,2 ,3 ,3 ,5 ,5 ,5 ,4 ,5 ,3 ,3 ,3 ,2 ,2 ,1 ,0
2 ,W ,ASH ,2 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,3 ,3 ,4 ,1 ,1 ,1 ,2 ,1 ,2 ,2 ,4 ,2 ,2 ,4 ,4 ,5 ,5 ,5 ,4 ,5 ,1 ,1 ,3 ,2 ,3 ,3 ,10
2 ,X ,SWH ,2 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,3 ,2 ,2 ,3 ,4 ,2 ,1 ,3 ,4 ,1 ,1 ,2 ,4 ,1 ,1 ,3 ,4 ,2 ,5 ,3 ,2 ,5 ,5 ,3 ,3 ,5 ,5 ,3 ,0
3 ,  ,  ,2 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,3 ,2 ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,1 ,4 ,2 ,4 ,3 ,5 ,5 ,3 ,5 ,5 ,5 ,5 ,5 ,4 ,2 ,3 ,20
1 ,W ,  ,3 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,1 ,2 ,2 ,3 ,1 ,1 ,1 ,2 ,1 ,1 ,3 ,1 ,1 ,3 ,2 ,4 ,5 ,5 ,5 ,3 ,5 ,5 ,3 ,5 ,5 ,4 ,2 ,16
1 ,W ,MT ,3 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,4 ,3 ,4 ,3 ,1 ,1 ,3 ,1 ,2 ,1 ,4 ,4 ,2 ,4 ,4 ,4 ,5 ,5 ,4 ,5 ,4 ,5 ,2 ,3 ,3 ,3 ,20
3 ,W ,SS ,3 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,4 ,2 ,4 ,1 ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,4 ,4 ,3 ,3 ,2 ,4 ,5 ,5 ,5 ,5 ,5 ,5 ,4 ,3 ,3 ,4 ,3 ,0
2 ,W ,  ,3 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,2 ,2 ,2 ,1 ,1 ,2 ,1 ,1 ,2 ,4 ,4 ,4 ,3 ,4 ,3 ,5 ,3 ,5 ,5 ,  ,2 ,4 ,4 ,20
1 ,P ,SWH ,3 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,4 ,4 ,3 ,4 ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,4 ,3 ,1 ,3 ,3 ,5 ,5 ,  ,3 ,5 ,5 ,5 ,1 ,3 ,5 ,3 ,14
3 ,X ,SR ,3 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,3 ,3 ,4 ,1 ,1 ,4 ,4 ,1 ,3 ,3 ,4 ,4 ,1 ,4 ,4 ,5 ,5 ,4 ,4 ,5 ,4 ,4 ,1 ,4 ,5 ,3 ,0
2 ,X ,HI ,3 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,2 ,3 ,2 ,1 ,1 ,2 ,2 ,1 ,1 ,1 ,4 ,2 ,1 ,3 ,2 ,5 ,5 ,3 ,2 ,5 ,5 ,5 ,3 ,2 ,5 ,2 ,20
3 ,P ,MH ,3 ,0 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,2 ,3 ,3 ,3 ,1 ,2 ,3 ,1 ,1 ,1 ,1 ,4 ,1 ,1 ,3 ,3 ,  ,3 ,4 ,  ,  ,  ,  ,2 ,  ,  ,1 ,0
2 ,W ,MH ,3 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,2 ,3 ,3 ,2 ,3 ,1 ,1 ,  ,2 ,1 ,1 ,3 ,4 ,2 ,1 ,3 ,3 ,5 ,5 ,  ,3 ,5 ,5 ,3 ,2 ,3 ,5 ,2 ,0
2 ,P ,HI ,3 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,4 ,2 ,3 ,3 ,2 ,1 ,4 ,2 ,3 ,1 ,1 ,4 ,4 ,4 ,1 ,4 ,3 ,5 ,4 ,3 ,3 ,5 ,5 ,3 ,1 ,2 ,5 ,4 ,24
1 ,P ,MH ,3 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,4 ,4 ,3 ,3 ,2 ,1 ,4 ,1 ,3 ,3 ,4 ,3 ,3 ,4 ,4 ,4 ,4 ,5 ,4 ,5 ,3 ,4 ,2 ,3 ,3 ,3 ,15
2 ,P ,MT ,3 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,4 ,3 ,4 ,4 ,4 ,3 ,1 ,  ,3 ,1 ,2 ,1 ,4 ,4 ,1 ,3 ,4 ,4 ,5 ,  ,4 ,5 ,3 ,5 ,2 ,3 ,5 ,4 ,0
3 ,P ,HI ,3 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,3 ,3 ,2 ,1 ,1 ,2 ,2 ,1 ,1 ,3 ,3 ,2 ,1 ,4 ,4 ,5 ,5 ,3 ,3 ,5 ,5 ,3 ,2 ,2 ,5 ,3 ,0
2 ,P ,HI ,3 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,3 ,1 ,2 ,2 ,3 ,1 ,1 ,1 ,4 ,1 ,1 ,1 ,4 ,1 ,1 ,4 ,3 ,5 ,5 ,5 ,4 ,5 ,5 ,5 ,2 ,5 ,5 ,3 ,0
3 ,P ,  ,3 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,2 ,1 ,1 ,3 ,2 ,2 ,2 ,3 ,2 ,2 ,2 ,2 ,2 ,5 ,5 ,3 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,2 ,15
2 ,P ,HI ,3 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,3 ,1 ,1 ,4 ,1 ,1 ,2 ,2 ,4 ,3 ,1 ,3 ,3 ,5 ,5 ,3 ,5 ,5 ,4 ,4 ,3 ,4 ,5 ,3 ,0
2 ,W ,MH ,3 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,3 ,4 ,2 ,1 ,2 ,4 ,5 ,5 ,5 ,5 ,5 ,5 ,4 ,3 ,2 ,5 ,2 ,0
2 ,P ,  ,3 ,0 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,3 ,2 ,3 ,2 ,4 ,2 ,2 ,2 ,4 ,1 ,1 ,2 ,4 ,3 ,3 ,3 ,3 ,3 ,4 ,3 ,4 ,5 ,5 ,3 ,2 ,2 ,3 ,3 ,4
1 ,P ,MH ,3 ,1 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,2 ,3 ,3 ,2 ,3 ,1 ,2 ,1 ,3 ,1 ,1 ,1 ,3 ,3 ,1 ,3 ,4 ,5 ,4 ,5 ,4 ,5 ,5 ,5 ,3 ,4 ,5 ,3 ,10
2 ,P ,HI ,3 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,3 ,3 ,3 ,3 ,1 ,3 ,3 ,4 ,3 ,3 ,3 ,3 ,2 ,2 ,  ,2 ,5 ,2 ,2 ,2 ,3 ,3 ,2 ,12
  ,W ,  ,3 ,1 ,0 ,1 ,1 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,3 ,2 ,3 ,3 ,3 ,1 ,1 ,1 ,2 ,1 ,1 ,2 ,2 ,2 ,2 ,2 ,4 ,5 ,5 ,5 ,3 ,5 ,5 ,3 ,2 ,3 ,3 ,3 ,36
2 ,P ,  ,3 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,2 ,2 ,2 ,3 ,1 ,1 ,1 ,4 ,3 ,2 ,2 ,3 ,3 ,2 ,3 ,3 ,5 ,5 ,5 ,2 ,3 ,3 ,2 ,0
3 ,W ,HI ,3 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,4 ,2 ,3 ,3 ,3 ,1 ,1 ,2 ,3 ,1 ,4 ,4 ,4 ,2 ,1 ,2 ,4 ,5 ,5 ,3 ,4 ,5 ,4 ,4 ,2 ,4 ,5 ,3 ,8
1 ,W ,  ,3 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,3 ,4 ,4 ,3 ,1 ,  ,4 ,1 ,1 ,1 ,2 ,4 ,3 ,4 ,4 ,3 ,1 ,  ,4 ,5 ,5 ,5 ,3 ,3 ,4 ,4 ,8
1 ,W ,  ,3 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,2 ,2 ,2 ,2 ,4 ,2 ,2 ,3 ,3 ,1 ,2 ,2 ,1 ,3 ,3 ,3 ,4 ,3 ,4 ,4 ,4 ,5 ,3 ,4 ,5 ,4 ,4 ,4 ,0
3 ,P ,HI ,3 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,3 ,2 ,2 ,2 ,1 ,1 ,2 ,2 ,1 ,1 ,1 ,4 ,2 ,1 ,3 ,3 ,5 ,5 ,2 ,2 ,5 ,5 ,5 ,3 ,2 ,5 ,3 ,9
1 ,P ,MH ,3 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,4 ,4 ,4 ,1 ,1 ,3 ,4 ,1 ,1 ,4 ,4 ,2 ,2 ,2 ,4 ,5 ,5 ,5 ,4 ,5 ,5 ,3 ,4 ,2 ,4 ,4 ,25
3 ,P ,SR ,3 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,3 ,3 ,3 ,2 ,1 ,2 ,2 ,1 ,1 ,1 ,4 ,2 ,2 ,2 ,3 ,3 ,3 ,3 ,3 ,3 ,3 ,3 ,3 ,3 ,3 ,3 ,0
2 ,P ,HI ,3 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,3 ,1 ,1 ,4 ,1 ,1 ,1 ,4 ,3 ,3 ,4 ,3 ,2 ,5 ,5 ,1 ,5 ,5 ,5 ,1 ,3 ,3 ,3 ,23
1 ,W ,  ,3 ,0 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,4 ,3 ,4 ,3 ,1 ,2 ,2 ,1 ,1 ,1 ,1 ,2 ,4 ,2 ,4 ,3 ,5 ,4 ,3 ,5 ,5 ,5 ,5 ,3 ,2 ,2 ,10
3 ,W ,  ,3 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,2 ,1 ,2 ,3 ,4 ,2 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,2 ,4 ,4 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,3 ,6
2 ,P ,MT ,3 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,4 ,4 ,4 ,1 ,1 ,3 ,1 ,1 ,1 ,2 ,3 ,3 ,3 ,2 ,4 ,5 ,5 ,3 ,5 ,5 ,5 ,1 ,3 ,3 ,3 ,22
1 ,W ,HI ,3 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,2 ,3 ,1 ,1 ,3 ,1 ,1 ,1 ,3 ,4 ,3 ,1 ,3 ,3 ,5 ,5 ,3 ,5 ,5 ,5 ,4 ,1 ,2 ,5 ,2 ,25
2 ,W ,  ,3 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,2 ,3 ,4 ,3 ,3 ,1 ,3 ,1 ,1 ,1 ,1 ,3 ,4 ,2 ,4 ,2 ,2 ,5 ,3 ,5 ,5 ,5 ,3 ,1 ,4 ,3 ,25
3 ,P ,HI ,3 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,2 ,1 ,3 ,4 ,1 ,1 ,2 ,4 ,4 ,1 ,3 ,3 ,3 ,2 ,3 ,3 ,2 ,3 ,3 ,2 ,3 ,2 ,2 ,10
1 ,W ,  ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,4 ,3 ,4 ,2 ,2 ,1 ,3 ,1 ,2 ,2 ,1 ,3 ,3 ,3 ,4 ,3 ,3 ,5 ,3 ,5 ,3 ,3 ,5 ,3 ,3 ,3 ,15
1 ,P ,SR ,3 ,0 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,3 ,3 ,4 ,2 ,1 ,1 ,4 ,1 ,1 ,1 ,4 ,2 ,2 ,3 ,1 ,3 ,5 ,5 ,3 ,5 ,5 ,5 ,3 ,4 ,3 ,2 ,0
2 ,W ,  ,3 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,3 ,3 ,3 ,1 ,1 ,1 ,1 ,1 ,1 ,4 ,2 ,2 ,2 ,3 ,2 ,5 ,5 ,5 ,5 ,5 ,5 ,4 ,4 ,4 ,4 ,3 ,20
2 ,W ,MH ,3 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,3 ,3 ,4 ,1 ,1 ,3 ,3 ,1 ,1 ,1 ,3 ,2 ,1 ,3 ,3 ,5 ,5 ,3 ,4 ,5 ,5 ,5 ,1 ,2 ,5 ,3 ,0
2 ,W ,  ,3 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,1 ,1 ,2 ,1 ,1 ,2 ,4 ,1 ,4 ,4 ,3 ,4 ,5 ,5 ,3 ,5 ,5 ,3 ,3 ,5 ,4 ,4 ,3 ,14
4 ,P ,MH ,3 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,3 ,2 ,3 ,2 ,3 ,1 ,1 ,2 ,1 ,1 ,3 ,1 ,4 ,3 ,3 ,4 ,3 ,5 ,5 ,2 ,5 ,5 ,3 ,5 ,2 ,3 ,3 ,3 ,8
3 ,W ,  ,3 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,3 ,3 ,3 ,2 ,3 ,3 ,5 ,5 ,5 ,5 ,5 ,5 ,2 ,1 ,1 ,1 ,2 ,20
3 ,P ,HI ,3 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,3 ,3 ,4 ,1 ,1 ,1 ,2 ,3 ,3 ,3 ,3 ,3 ,1 ,3 ,4 ,5 ,5 ,5 ,4 ,3 ,3 ,3 ,3 ,3 ,5 ,4 ,0
2 ,P ,HI ,3 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,3 ,1 ,2 ,3 ,2 ,1 ,1 ,1 ,4 ,3 ,2 ,4 ,4 ,5 ,3 ,3 ,4 ,5 ,5 ,5 ,2 ,4 ,3 ,4 ,0
2 ,P ,HI ,3 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,1 ,1 ,2 ,2 ,1 ,1 ,1 ,4 ,4 ,1 ,4 ,3 ,5 ,5 ,3 ,4 ,5 ,5 ,5 ,2 ,3 ,5 ,3 ,0
3 ,P ,HOH ,3 ,0 ,1 ,1 ,0 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,4 ,3 ,3 ,3 ,3 ,1 ,1 ,3 ,2 ,1 ,1 ,2 ,4 ,3 ,2 ,3 ,3 ,5 ,5 ,3 ,3 ,5 ,5 ,2 ,2 ,3 ,3 ,3 ,0
1 ,W ,  ,3 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,3 ,3 ,3 ,2 ,3 ,1 ,3 ,1 ,3 ,1 ,2 ,1 ,2 ,2 ,2 ,3 ,3 ,5 ,3 ,5 ,3 ,5 ,4 ,5 ,3 ,3 ,4 ,4 ,4
1 ,W ,  ,3 ,1 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,1 ,4 ,2 ,3 ,3 ,4 ,3 ,1 ,1 ,3 ,1 ,1 ,2 ,1 ,1 ,3 ,2 ,4 ,3 ,5 ,5 ,4 ,5 ,5 ,4 ,5 ,5 ,4 ,4 ,6
2 ,W ,HI ,3 ,0 ,1 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,3 ,1 ,1 ,2 ,2 ,1 ,4 ,1 ,4 ,3 ,3 ,3 ,4 ,5 ,5 ,4 ,3 ,5 ,4 ,5 ,3 ,3 ,3 ,3 ,0
2 ,X ,  ,3 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,3 ,3 ,3 ,3 ,4 ,2 ,1 ,3 ,3 ,2 ,2 ,1 ,2 ,2 ,3 ,2 ,3 ,3 ,5 ,2 ,3 ,3 ,3 ,5 ,2 ,3 ,3 ,2 ,0
3 ,X ,CRH ,3 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,3 ,2 ,4 ,2 ,1 ,4 ,3 ,1 ,3 ,1 ,4 ,3 ,3 ,4 ,3 ,3 ,5 ,3 ,2 ,5 ,4 ,5 ,2 ,3 ,3 ,2 ,5
2 ,P ,MT ,3 ,0 ,0 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,3 ,4 ,2 ,3 ,2 ,3 ,1 ,1 ,1 ,4 ,  ,4 ,2 ,3 ,2 ,2 ,4 ,2 ,5 ,5 ,5 ,  ,2 ,4 ,2 ,0
2 ,X ,HI ,3 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,4 ,3 ,3 ,3 ,4 ,1 ,1 ,1 ,3 ,1 ,1 ,1 ,4 ,3 ,2 ,4 ,4 ,5 ,5 ,5 ,3 ,5 ,5 ,5 ,3 ,3 ,2 ,2 ,0
3 ,X ,SS ,3 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,4 ,3 ,2 ,4 ,3 ,2 ,1 ,2 ,1 ,3 ,2 ,3 ,4 ,2 ,3 ,3 ,3 ,2 ,5 ,2 ,5 ,3 ,3 ,2 ,2 ,3 ,3 ,15
4 ,X ,HI ,3 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,4 ,3 ,3 ,3 ,1 ,1 ,3 ,2 ,1 ,1 ,2 ,4 ,2 ,1 ,4 ,4 ,5 ,5 ,2 ,3 ,5 ,5 ,3 ,1 ,2 ,5 ,3 ,0
2 ,W ,SR ,3 ,0 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,1 ,1 ,4 ,1 ,1 ,1 ,1 ,4 ,1 ,2 ,2 ,  ,5 ,5 ,  ,5 ,5 ,5 ,5 ,  ,5 ,  ,  ,0
3 ,X ,  ,3 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,3 ,3 ,4 ,1 ,1 ,1 ,3 ,1 ,1 ,1 ,2 ,1 ,1 ,2 ,3 ,5 ,5 ,5 ,4 ,5 ,5 ,5 ,3 ,5 ,5 ,3 ,0
2 ,W ,HI ,3 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,1 ,3 ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,4 ,1 ,2 ,3 ,4 ,5 ,5 ,5 ,1 ,5 ,5 ,5 ,1 ,3 ,4 ,4 ,0
3 ,P ,HI ,3 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,4 ,3 ,3 ,3 ,4 ,2 ,1 ,2 ,3 ,1 ,2 ,1 ,4 ,4 ,3 ,4 ,4 ,5 ,5 ,3 ,3 ,5 ,3 ,5 ,2 ,3 ,3 ,3 ,20
4 ,X ,  ,3 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,2 ,2 ,3 ,4 ,1 ,1 ,2 ,1 ,2 ,4 ,4 ,4 ,3 ,3 ,3 ,3 ,5 ,5 ,3 ,2 ,3 ,3 ,4 ,20
3 ,X ,  ,3 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,3 ,3 ,2 ,3 ,4 ,1 ,1 ,1 ,2 ,3 ,3 ,3 ,4 ,1 ,1 ,2 ,3 ,5 ,5 ,3 ,2 ,3 ,2 ,  ,4 ,5 ,5 ,3 ,12
1 ,X ,HI ,4 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,4 ,4 ,3 ,3 ,2 ,3 ,1 ,2 ,2 ,4 ,3 ,3 ,4 ,3 ,3 ,3 ,3 ,3 ,5 ,3 ,3 ,3 ,2 ,4 ,3 ,20
2 ,X ,MH ,4 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,3 ,2 ,2 ,3 ,1 ,2 ,2 ,4 ,3 ,1 ,4 ,3 ,3 ,3 ,3 ,3 ,  ,3 ,3 ,2 ,3 ,  ,3 ,16
2 ,X ,SR ,4 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,4 ,3 ,4 ,1 ,1 ,1 ,3 ,1 ,1 ,1 ,4 ,3 ,2 ,3 ,4 ,  ,  ,  ,3 ,  ,  ,  ,1 ,3 ,3 ,3 ,7
2 ,P ,HI ,4 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,4 ,3 ,1 ,1 ,3 ,3 ,1 ,1 ,4 ,4 ,2 ,1 ,2 ,4 ,5 ,5 ,4 ,4 ,5 ,5 ,4 ,2 ,4 ,5 ,3 ,10
2 ,X ,SR ,4 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,4 ,3 ,2 ,1 ,1 ,1 ,2 ,1 ,2 ,3 ,4 ,3 ,1 ,3 ,3 ,5 ,5 ,5 ,3 ,5 ,3 ,4 ,3 ,4 ,5 ,3 ,0
3 ,P ,MT ,4 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,4 ,4 ,4 ,3 ,4 ,  ,3 ,1 ,3 ,1 ,3 ,3 ,2 ,3 ,3 ,3 ,4 ,  ,3 ,5 ,2 ,5 ,3 ,3 ,5 ,2 ,3 ,3 ,27
1 ,P ,HI ,4 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,4 ,4 ,1 ,1 ,2 ,2 ,1 ,1 ,1 ,4 ,3 ,1 ,3 ,4 ,5 ,5 ,4 ,2 ,5 ,5 ,5 ,2 ,2 ,5 ,2 ,0
2 ,W ,HI ,4 ,0 ,1 ,0 ,0 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,3 ,2 ,3 ,3 ,3 ,1 ,1 ,3 ,2 ,1 ,1 ,3 ,4 ,3 ,1 ,3 ,4 ,5 ,5 ,2 ,5 ,5 ,5 ,4 ,2 ,3 ,5 ,3 ,0
1 ,W ,CRH ,4 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,2 ,4 ,1 ,3 ,1 ,4 ,1 ,1 ,1 ,4 ,3 ,1 ,4 ,2 ,  ,1 ,  ,3 ,  ,  ,  ,3 ,3 ,  ,2 ,5
2 ,W ,MOH ,4 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,4 ,3 ,4 ,1 ,2 ,2 ,2 ,1 ,1 ,1 ,4 ,3 ,3 ,4 ,3 ,5 ,2 ,3 ,3 ,5 ,5 ,5 ,1 ,3 ,3 ,1 ,12
1 ,P ,  ,4 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,3 ,3 ,4 ,2 ,1 ,2 ,4 ,1 ,3 ,3 ,2 ,2 ,2 ,2 ,  ,  ,5 ,  ,  ,5 ,  ,  ,  ,  ,  ,  ,15
1 ,P ,HOH ,4 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,4 ,3 ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,4 ,2 ,1 ,3 ,4 ,5 ,5 ,4 ,5 ,5 ,5 ,5 ,2 ,2 ,5 ,4 ,10
1 ,P ,SR ,4 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,4 ,3 ,4 ,3 ,3 ,1 ,1 ,3 ,2 ,1 ,1 ,2 ,4 ,2 ,3 ,4 ,4 ,5 ,5 ,3 ,4 ,5 ,5 ,2 ,2 ,3 ,4 ,4 ,0
1 ,P ,MH ,4 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,4 ,4 ,3 ,2 ,2 ,2 ,1 ,1 ,4 ,4 ,3 ,2 ,4 ,3 ,4 ,4 ,3 ,3 ,5 ,5 ,4 ,1 ,2 ,2 ,1 ,7
1 ,P ,  ,4 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,4 ,4 ,4 ,4 ,2 ,1 ,4 ,3 ,1 ,4 ,1 ,4 ,2 ,2 ,3 ,4 ,4 ,5 ,3 ,2 ,5 ,4 ,5 ,4 ,4 ,4 ,4 ,15
2 ,W ,SWH ,4 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,4 ,4 ,2 ,3 ,1 ,1 ,1 ,3 ,1 ,1 ,3 ,3 ,3 ,3 ,3 ,3 ,5 ,5 ,5 ,3 ,5 ,5 ,3 ,1 ,1 ,1 ,3 ,0
1 ,P ,ASH ,4 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,4 ,3 ,1 ,1 ,3 ,4 ,1 ,1 ,1 ,4 ,2 ,1 ,3 ,4 ,5 ,5 ,4 ,3 ,5 ,5 ,5 ,2 ,2 ,5 ,2 ,5
4 ,W ,  ,4 ,0 ,0 ,0 ,1 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,2 ,2 ,2 ,2 ,4 ,2 ,2 ,1 ,2 ,1 ,1 ,3 ,2 ,4 ,4 ,4 ,4 ,2 ,2 ,5 ,3 ,5 ,5 ,3 ,2 ,4 ,4 ,4 ,0
2 ,W ,ASH ,4 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,3 ,3 ,2 ,4 ,1 ,3 ,3 ,4 ,3 ,1 ,4 ,3 ,3 ,3 ,3 ,3 ,5 ,2 ,4 ,2 ,1 ,5 ,3 ,7
4 ,W ,  ,4 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,2 ,1 ,2 ,3 ,1 ,3 ,2 ,4 ,4 ,3 ,4 ,3 ,5 ,5 ,5 ,3 ,5 ,3 ,2 ,3 ,2 ,3 ,4 ,0
1 ,P ,MH ,4 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,4 ,3 ,4 ,3 ,4 ,1 ,1 ,2 ,3 ,2 ,2 ,1 ,4 ,2 ,2 ,3 ,4 ,5 ,5 ,3 ,4 ,2 ,2 ,5 ,2 ,3 ,3 ,2 ,0
2 ,P ,SR ,4 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,3 ,3 ,3 ,1 ,2 ,2 ,2 ,1 ,1 ,2 ,4 ,2 ,2 ,3 ,4 ,5 ,2 ,3 ,4 ,5 ,5 ,3 ,3 ,2 ,5 ,3 ,0
1 ,P ,MT ,4 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,3 ,4 ,4 ,4 ,4 ,1 ,1 ,1 ,4 ,1 ,1 ,1 ,4 ,4 ,3 ,4 ,3 ,5 ,5 ,5 ,4 ,5 ,5 ,5 ,2 ,3 ,3 ,2 ,15
2 ,P ,HI ,4 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,4 ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,4 ,3 ,1 ,3 ,2 ,5 ,5 ,4 ,5 ,5 ,5 ,5 ,3 ,3 ,5 ,3 ,5
2 ,P ,MH ,4 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,2 ,1 ,4 ,2 ,3 ,3 ,3 ,3 ,4 ,1 ,4 ,2 ,4 ,5 ,2 ,3 ,3 ,3 ,3 ,1 ,4 ,5 ,3 ,7
1 ,P ,GAH ,4 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,2 ,4 ,3 ,2 ,1 ,2 ,2 ,2 ,1 ,4 ,2 ,1 ,3 ,3 ,4 ,4 ,5 ,2 ,3 ,3 ,4 ,1 ,2 ,5 ,3 ,15
1 ,W ,MH ,4 ,0 ,0 ,0 ,1 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,3 ,4 ,4 ,3 ,4 ,2 ,1 ,3 ,2 ,1 ,1 ,2 ,4 ,4 ,2 ,4 ,4 ,4 ,4 ,4 ,4 ,5 ,5 ,4 ,4 ,4 ,4 ,4 ,8
2 ,P ,  ,4 ,0 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,4 ,4 ,1 ,1 ,4 ,3 ,1 ,1 ,3 ,4 ,4 ,3 ,4 ,3 ,5 ,5 ,2 ,3 ,5 ,5 ,3 ,3 ,3 ,3 ,2 ,0
2 ,W ,  ,4 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,4 ,4 ,3 ,4 ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,2 ,1 ,2 ,2 ,3 ,5 ,5 ,5 ,3 ,5 ,5 ,5 ,3 ,5 ,3 ,3 ,0
1 ,P ,MH ,4 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,3 ,4 ,4 ,3 ,4 ,4 ,4 ,1 ,2 ,2 ,4 ,3 ,3 ,4 ,4 ,3 ,3 ,4 ,2 ,5 ,3 ,3 ,3 ,2 ,3 ,3 ,0
2 ,W ,MH ,4 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,3 ,2 ,3 ,3 ,3 ,3 ,2 ,2 ,3 ,1 ,1 ,3 ,4 ,1 ,1 ,4 ,3 ,3 ,3 ,2 ,2 ,5 ,5 ,3 ,1 ,5 ,5 ,1 ,20
2 ,X ,  ,4 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,2 ,4 ,3 ,1 ,1 ,2 ,1 ,4 ,1 ,1 ,3 ,4 ,4 ,3 ,2 ,5 ,5 ,2 ,5 ,3 ,5 ,5 ,2 ,3 ,3 ,0
1 ,W ,SR ,4 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,4 ,4 ,1 ,1 ,3 ,1 ,1 ,2 ,  ,4 ,2 ,2 ,3 ,3 ,5 ,5 ,3 ,5 ,5 ,5 ,4 ,4 ,4 ,4 ,2 ,8
1 ,P ,SS ,4 ,1 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,4 ,3 ,4 ,3 ,1 ,1 ,3 ,1 ,1 ,1 ,3 ,3 ,3 ,3 ,2 ,2 ,5 ,5 ,2 ,5 ,5 ,5 ,3 ,3 ,3 ,3 ,10
2 ,W ,  ,4 ,1 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,3 ,3 ,2 ,2 ,3 ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,4 ,3 ,3 ,3 ,4 ,5 ,5 ,5 ,3 ,5 ,5 ,5 ,1 ,3 ,3 ,1 ,40
  ,W ,  ,4 ,1 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,3 ,2 ,2 ,2 ,4 ,1 ,1 ,1 ,2 ,1 ,1 ,2 ,1 ,3 ,4 ,4 ,3 ,5 ,5 ,5 ,3 ,5 ,5 ,4 ,5 ,3 ,3 ,3 ,0
2 ,W ,  ,4 ,1 ,0 ,1 ,1 ,0 ,1 ,1 ,1 ,0 ,1 ,0 ,4 ,3 ,3 ,3 ,4 ,4 ,4 ,2 ,4 ,2 ,3 ,1 ,2 ,2 ,4 ,2 ,4 ,4 ,4 ,2 ,4 ,2 ,4 ,2 ,3 ,2 ,4 ,1 ,15
3 ,P ,HI ,4 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,4 ,2 ,2 ,4 ,2 ,4 ,2 ,1 ,2 ,1 ,2 ,3 ,4 ,4 ,1 ,3 ,4 ,4 ,4 ,5 ,2 ,5 ,3 ,4 ,2 ,3 ,5 ,3 ,24
2 ,P ,  ,4 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,4 ,3 ,3 ,1 ,1 ,4 ,4 ,1 ,1 ,1 ,1 ,2 ,4 ,2 ,2 ,1 ,5 ,1 ,1 ,5 ,5 ,5 ,5 ,1 ,0
2 ,W ,  ,4 ,1 ,0 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,4 ,3 ,4 ,3 ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,3 ,3 ,3 ,3 ,4 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,3 ,4 ,3 ,1 ,25
1 ,W ,HI ,4 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,4 ,4 ,2 ,1 ,3 ,3 ,1 ,3 ,2 ,4 ,4 ,2 ,4 ,4 ,3 ,5 ,4 ,4 ,5 ,4 ,4 ,3 ,3 ,3 ,3 ,12
2 ,W ,  ,4 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,4 ,3 ,4 ,4 ,4 ,1 ,1 ,3 ,3 ,1 ,1 ,1 ,2 ,3 ,1 ,3 ,4 ,5 ,5 ,4 ,2 ,5 ,5 ,5 ,3 ,4 ,5 ,4 ,35
1 ,P ,AYC ,4 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,3 ,4 ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,4 ,2 ,1 ,3 ,4 ,5 ,5 ,5 ,3 ,5 ,5 ,5 ,3 ,3 ,5 ,3 ,24
2 ,W ,SWH ,4 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,3 ,4 ,2 ,4 ,1 ,1 ,1 ,2 ,1 ,1 ,1 ,4 ,2 ,1 ,3 ,2 ,5 ,5 ,5 ,1 ,5 ,5 ,5 ,2 ,3 ,5 ,2 ,20
1 ,X ,SR ,4 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,3 ,3 ,3 ,3 ,4 ,2 ,1 ,2 ,1 ,4 ,2 ,1 ,3 ,3 ,4 ,4 ,4 ,2 ,5 ,3 ,5 ,3 ,4 ,5 ,3 ,0
1 ,X ,MH ,4 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,3 ,4 ,3 ,3 ,3 ,2 ,1 ,1 ,1 ,1 ,2 ,2 ,4 ,2 ,1 ,3 ,3 ,3 ,5 ,5 ,5 ,5 ,3 ,3 ,2 ,3 ,5 ,3 ,0
1 ,W ,MH ,4 ,0 ,1 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,3 ,4 ,4 ,4 ,4 ,1 ,1 ,2 ,1 ,1 ,1 ,1 ,4 ,3 ,1 ,3 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,4 ,3 ,5 ,3 ,0
1 ,W ,  ,4 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,4 ,4 ,4 ,4 ,3 ,2 ,3 ,2 ,1 ,1 ,1 ,4 ,3 ,1 ,2 ,4 ,3 ,1 ,4 ,4 ,4 ,4 ,4 ,4 ,4 ,2 ,3 ,1 ,4
2 ,W ,HI ,4 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,4 ,3 ,3 ,3 ,1 ,1 ,2 ,2 ,2 ,1 ,2 ,4 ,2 ,2 ,3 ,4 ,5 ,5 ,3 ,4 ,5 ,5 ,3 ,3 ,3 ,3 ,3 ,0
1 ,P ,HI ,4 ,0 ,1 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,2 ,3 ,3 ,3 ,3 ,1 ,1 ,2 ,4 ,1 ,1 ,1 ,4 ,2 ,2 ,3 ,3 ,5 ,5 ,4 ,4 ,5 ,5 ,5 ,2 ,3 ,2 ,1 ,0
1 ,W ,HI ,4 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,3 ,2 ,3 ,1 ,1 ,1 ,2 ,1 ,4 ,4 ,4 ,2 ,1 ,3 ,3 ,5 ,5 ,5 ,3 ,5 ,3 ,4 ,3 ,1 ,5 ,1 ,8
1 ,W ,MH ,4 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,3 ,3 ,1 ,1 ,4 ,1 ,1 ,3 ,1 ,4 ,3 ,1 ,4 ,4 ,5 ,5 ,3 ,5 ,5 ,4 ,5 ,4 ,4 ,5 ,4 ,30
1 ,X ,HI ,4 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,4 ,4 ,4 ,4 ,4 ,1 ,1 ,2 ,3 ,1 ,1 ,1 ,4 ,2 ,1 ,3 ,4 ,5 ,5 ,4 ,3 ,5 ,5 ,5 ,3 ,2 ,5 ,4 ,0
1 ,P ,ASH ,4 ,0 ,1 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,2 ,3 ,3 ,2 ,4 ,2 ,1 ,3 ,3 ,1 ,3 ,1 ,4 ,3 ,1 ,4 ,4 ,1 ,5 ,1 ,1 ,5 ,4 ,5 ,2 ,2 ,5 ,2 ,6
2 ,P ,MH ,4 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,3 ,3 ,4 ,3 ,3 ,1 ,1 ,1 ,4 ,1 ,1 ,1 ,4 ,1 ,1 ,3 ,3 ,5 ,5 ,5 ,3 ,5 ,5 ,5 ,3 ,5 ,5 ,2 ,0
1 ,P ,MOH ,4 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,2 ,3 ,4 ,4 ,4 ,2 ,1 ,1 ,3 ,1 ,3 ,3 ,4 ,2 ,2 ,4 ,4 ,3 ,5 ,5 ,3 ,5 ,4 ,4 ,1 ,2 ,3 ,2 ,10
2 ,W ,  ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,4 ,2 ,3 ,4 ,4 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,3 ,1 ,4 ,4 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,5 ,4 ,5 ,3 ,28
2 ,X ,SR ,4 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,3 ,2 ,3 ,3 ,3 ,1 ,1 ,3 ,3 ,1 ,1 ,4 ,4 ,3 ,1 ,4 ,3 ,5 ,5 ,2 ,2 ,5 ,5 ,4 ,2 ,4 ,5 ,3 ,0

