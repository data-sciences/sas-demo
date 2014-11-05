*Program to create temporary SAS data sets used in 
 Cody's Collection of Popular SAS Programming Tasks and 
 How to Tackle Them;

*Program to create CHAR_VALUES Data Set;
data char_values;
   input Age : $3. Weight : $3. Gender : $1. DOB : mmddyy10.;
   format DOB mmddyy10.;
datalines;
23 150 M 10/21/1983
67 220 M 9/12/2001
77 101 F 5/6/1977
;

*Program to create STOCKS Data Set;
data stocks;
   do Date = '01jan2012'd to '28feb2012'd;
      input Price @@;
      if weekday(Date) not in (1 7) then output;
   end;
   format Date date9.;
datalines;
23 24 24 33 25 25 24 26 24 33 34 28 29 31 33 30
28 29 38 37 21 21 28 30 31 31 32 31 31 32 33
33 30 29 27 22 26 26 26 29 30 30 31 32 36 37 39 35 
35 34 33 32 31 31 33 34 35 37 33
;
/*
proc print data=stocks;
run;
*/

*Program to create the Blood_Pressure data set;
data blood_pressure;
   call streaminit(37373);
   do Drug = 'Placebo','Drug A','Drug B';
      do i = 1 to 20;
         Subj + 1;
         if mod(Subj,2) then Gender = 'M';
         else Gender = 'F';
         SBP = rand('normal',130,10) +
               7*(Drug eq 'Placebo') - 6*(Drug eq 'Drug B')
               + (rand('uniform') lt .2)*(rand('normal',0,30));
         SBP = round(SBP,2);
         DBP = rand('normal',80,5) +
               3*(Drug eq 'Placebo') - 2*(Drug eq 'Drug B')
               + (rand('uniform') lt .2)*(rand('normal',0,30));
         DBP = round(DBP,2);
         if Subj in (5,15,25,55) then call missing(SBP, DBP);
         if Subj in (4,18) then call missing(Gender);
         Heart_Rate = int(rand('normal',70,20) 
                       + 5*(Gender='M') 
                       - 8*(Drug eq 'Drug B'));
         if Subj in (2,8) then call missing(Heart_Rate);
         output;
      end;
   end;
   drop i;
run;

*Program to create the Hardware store data set;
data hardware;
   infile datalines firstobs=2;
   input @1  Item_Number $4.
         @5  Description $25.
         @40 Price;
   format Price dollar8.2;
datalines;
123456789112345678921234567893123456789412345
1238Cross Cut Saw  18 inch             18.75
1122Cross Cut Saw  24 inch             23.95
2001Nails, 10 penny                    5.57
2002Nails, 8 penny                     4.59
3003Pliers, Needle nose                12.98
3035Pliers, cutting                    15.99
4005Hammer, 6 pound                    12.98
4006Hammer, 8 pound                    15.98
4007Hammer, sledge                     19.98
;
/*
title "Listing of data set HARDWARE";
proc print data=hardware noobs;
run;
*/

*Program to create the data sets NAME1, NAME2, and NAME3;
data name1;
   length Name $ 10 Gender $ 1;
   input Name Gender Age Height Weight;
datalines;
Horvath F 63 64 130
Chien M 28 65 122
Hanbicki F 72 62 240
Morgan F 71 66 160
;

data name2;
   length Name $ 10 Gender $ 1;
   input Name Gender Age Height Weight;
datalines;
Snow M 51 76 240
Hillary F 35 69 155
;

data name3;
   length Name $ 18 Gender $ 2;
   input Name Gender Age Height Weight;
datalines;
Zemlachenko M 55 72 220
Reardon M 27 75 180
;

/*
title "Listing of data set NAME1";
proc print data=name1 noobs;
run;

title "Listing of data set NAME2";
proc print data=name2 noobs;
run;

title "Listing of data set NAME3";
proc print data=name3 noobs;
run;
*/

data oneper;
   input Subj : $3. Dx1-Dx3;
datalines;
001     450    430    410
002     250    240      .
003     410    250    500
004     240      .      .
;
   
data Demographic;
   call streaminit(374354);
   do Subj = 1 to 20;
      if rand('uniform') ge .1 then Score = ceil(rand('uniform')*100);
      else Score = 999;
      if rand('uniform') ge .1 then Weight = ceil(rand('normal',150,30));
      else Weight = 999;
      if rand('uniform') ge .1 then Heart_Rate = ceil(rand('normal',70,10));
      else Heart_Rate = 999;
      DOB = -3652 + ceil(rand('uniform')*2190);
      if rand('uniform') gt .5 then Gender = 'Female';
      else Gender = 'Male';
      if rand('uniform') lt .2 then Gender = 'NA';
      if rand('uniform') ge .8 then Gender = lowcase(Gender);
      if rand('uniform') gt .6 then Party = 'Republican';
      else Party = 'Democrat';
      if rand('uniform') lt .2 then Party = 'NA';
      if rand('uniform') gt .5 then Party = lowcase(Party);
      output;
   end;
   format DOB date9.;
run;

*Data set Scores (student scores on a test);
data Scores;
   input Name : $ Score1-score10;
datalines;
John 95 92 87 100 96 88 89 78 02 95
Mary 98 96 93 89 95 95 94 . . 99
Sarpal 87 84 87 88 80 . 81 78 77 92
Sophie 78 79 81 82 84 85 86 88 90 95
;

*Data set to demonstrate slphabitizing;
data Address;
   length First_Name Last_Name $ 12;
   input #1 Name & $30.
         #2 Number :$5. Street $30.
         #3 City & $15. State : $upcase2.  Zip : $8.;
         City = compress(City,',');
   First_Name = scan(Name,1);
   Last_Name = scan(Name,2);
datalines;
Stephen Marcella
12 Easy Street
Clinton,  NJ 08854
Pierre Dupont
3 Easy Street
Clinton,  NJ 08854
Sharon Schneider
8568 Hwy 480
Camp Verde,  TX 78010
Mildred Xavier
7 Hewlett Point Avenue
East Rockaway,  NY 11518
Chris Hengeveld
14 Hewlett Point Avenue
East Rockaway,  NY 11518
Johann Bach
23 Hewlett Point Avenue
East Rockaway,  NY 11518
Kay Heizer
122 Easy Street
clinton,  nj 08854
;
/*%print(dsn=address)*/
*Data set CODES to demonstrate control data sets;
data codes;
   input ICD9 : $5. Description & $21.;
datalines;
020 Plague
022 Anthrax
390 Rheumatic fever
410 Myocardial infarction
493 Asthma
540 Appendicitis
;
*Data set VISITS to demonstrate longitudinal programming
 techniques;
data Visits;
   input Patient : $3. Visit Weight;
datalines;
001 1 120
001 2 124
001 3 124
002 1 200
003 1 310
003 2 305
003 3 298
003 3 290
004 1 160
004 2 162
;

*Data set CREDIT containing ID's and Credit card numbers,
 and phone numbers;
data credit;
   input ID :$3. Account : $12. Phone : $13.;
datalines;
001 1234567800001212 (908)232-2737
002 5411002233448882 (830)939-8877
003 8384001993746111 (830)838-6667
;
*Data set UNITS containing numeric values but with units
 such as lbs. or kgs. included;
data units;
   input @1  Subj $3. 
         @5  Weight $8.
         @13 Height $10.;
datalines;
001 80kgs   5ft 3in
002 190lbs  6' 1"
003 70KG.   5ft 11in
004 177LbS. 5' 11"
005 100kgs  6ft
;
*Data set GOALS, containing the sales goals for the years
 2004 through 2012;
data Goals;
   do Year = 2004 to 2012;
      input Goal @;
      output;
   end;
datalines;
20 21 24 28 34 40 49 60 75
;

*Data set GOALS_JOB, containing the sales goals for the years
 2004 through 2012 for each of 4 job categories;
data Goals_Job;
   do Year = 2004 to 2012;
      do Job = 1 to 4;
         input Goal @;
         output;
      end;
   end;
datalines;
20 21 24 28 34 40 49 60 75
21 22 25 30 40 45 55 67 82
24 27 29 37 45 51 62 74 90
30 38 40 47 53 60 70 80 99
;


/*
%printrtf(dsn=Goals_Job,obs=10)
*/
*Data set Sales, containing the sales figures (in thousands)
 for each salesperson;
data Sales;
   input Sales_ID $ @;
   do Year = 2004 to 2012;
      input Sales @;
      output;
   end;
datalines;
1234 20.5 22 26 27 37 45 55 61 72
7477 18 18 17 23 33 44 55 66 65
4343 20.1 21.1 24.3 28.8 34.8 40.9 51.0 62 80
9988 16 17 18 22 34 44 58 75 88
;

data Sales_Job;   
   input Sales_ID $  Job @;
   do Year = 2004 to 2012;
      input Sales @;
      output;
   end;
datalines;
1234 1 20.5 22 26 27 37 45 55 61 72
7477 2 18 18 17 23 33 44 55 66 65
4343 4 20.1 21.1 24.3 28.8 34.8 40.9 51.0 62 80
9988 3 16 17 18 22 34 44 58 75 88
;

*Data set MoDayYear contains month, day and year data where
 the value of Day may be missing;
data MoDayYear;
   input Month Day Year;
datalines;
10 21 1955
6 . 1985
8 1 2001
9 . 2000
;

*The two Files, Name_One and Name_Two are used to demonstrate
 inexact (fuzzy) matches between two data sets;
data Name_One;
   input Name1 : $15. DOB1 : mmddyy10. Gender1 : $upcase1.;
   format DOB1 date9.;
datalines;
Friedman 7/14/1946 M
Chien 10/21/1965 f
MacDonald 2/12/2001 M
Fitzgerald 8/4/1966 m
GREGORY 2/5/1955 F
;
data Name_Two;
   input Name2 : $15. DOB2 : mmddyy10. Gender2 : $upcase1.;
   format DOB2 date9.;
datalines;
Freidman 7/14/1946 M
Chen 10/21/1965 f
McDonald 2/12/2001 M
Fitzgerald 8/4/1966 m
Gregory 2/5/1955 F
;

*Data set Full_Name to demonstrate how to extract first, middle, and last names
 from a single variable;
data Full_Name;
   input @1 Name $30.;
datalines;
Jane Ireland
Ronald P. Cody
Robert Louis Stevenson
Daniel Friedman
Louis H. Horvath
Mary Williams
;
*Data set Questionnaire containing Y and N responses to 5 questions;
data Questionnaire;
   input Subj (Q1-Q5)(: $1.);
datalines;
1 y y n n y
2 N N n   Y
3 N n n n n
4 y Y n N y
5 y y y y y
;

*Data set Duplicates to demonstrate ways of identifying
 duplicate records and duplicate BY variables;
data Duplicates;
   input @1  Subj   $3.
         @4  Gender $1.
         @5  Age     3.
         @8  Height  2.
         @10 Weight  3.;
datalines;
001M 2363122
002F 4459109
002F 4459109
003M 8767200
004F10053112
004F 5059201
005M 4569188
;

*Data set Two_Records used to identify all observations that do not
 have exactly 2 records;
data Two_Records;
   input Subj : $3. Weight;
datalines;
001 200
001 190
002 155
002 157
003 123
004 220
004 221
004 210
005 111
005 112
;

*Data set Multiple to demonstrate a feature of the NODUPRECS option;
data Multiple;
   input Subj : $3. X Y;
datalines;
001 1 2
001 3 2
001 1 2
002 5 7
003 7 8
003 7 8
005 4 5
;

*Data set Raw_Data for PROC RANK demonstration;
data Raw_Data;
   input Subj $ X Y;
datalines;
001 3 10
002 7 20
003 2 30
004 4 40
;

*Program to create data set New_Values;
data New_Values;
   informat Gender $6. Party $10. DOB Date9.;
   input Subj= Score= Weight= Heart_Rate= DOB= Gender= Party=;
   format DOB date9.;
datalines;
Subj=2 Score=72 Party=Republican
Subj=7 DOB=26Nov1951 Weight=140
;
***Remaining macros used by the author;
*Macro to print data sets;
%macro print(Dsn=,    /*Name of data set */
             Obs=max  /*Number of Obs to print */);
   title "Listing of Data Set &Dsn"; 
   %if &Obs ne max %then %do;
      title2 "First &Obs Observations";
   %end;
    proc print data=&Dsn(Obs=&Obs) noobs;
   run;
%mend print;

*Macro to print data sets with RTF output;
%macro printrtf(Dsn=, /*Name of data set */
             Obs=max  /*Number of Obs to print */);
   ods listing close;
   ods rtf file='c:\books\Tasks\rtfoutput.rtf';
   title "Listing of Data Set &Dsn"; 
   %if &Obs ne max %then %do;
      title2 "First &Obs Observations";
   %end;
    proc print data=&Dsn(Obs=&Obs) noobs;
      run;
   ods rtf close;
   ods listing;
%mend printrtf;
