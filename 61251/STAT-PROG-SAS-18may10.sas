/*
                                          STAT-PROG-SAS-17may10.txt
- Displays with SAS code along with data from HW Exercises
- from Bailer AJ (2010) STATISTICAL PROGRAMMING IN SAS. Cary, NC:  SAS Institute Inc.

*/


/************************************** Display 1.1 ***********************************************/

/*     mreg-country-20may09.sas

Directory:  C:\baileraj\Classes\Spring09\programs\regression-examples
            [Laptop]
Author:   John Bailer
Purpose:  multiple regression example where average life expectancy 
          of women is modeled as a function of country characteristics

Input data file -------------------------------------
   country.data

Directories:
   \\Casnov5\MST\MSTLab\Baileraj
   C:\Users\baileraj\BAILERAJ\Classes\Web-Classes\sta402\data

Input variables -------------------------------------
   Name = country name (Character variable)
   Area = country area
   Popnsize = population size
   Pcturban = % residents in urban setting
   Lang = primary language
   Liter = % literate
   Lifemen = average life expectancy men
   Lifewom = average life expectancy women
   PcGNP = per capita gross national product

Created Variables -----------------------------------
   logarea = log10(area);
   logpopn = log10(popnsize);
   loggnp  = log10(pcGNP);
   ienglish = (lang="English");

Data Source:  Extracted from World Almanac
*/
* setting up macro variables for directories;  
%let DIR1 = C:\Users\baileraj\BAILERAJ\Classes\Web-Classes\sta402\data;
%let DIR2 = \\Casnov5\MST\MSTLab\Baileraj;

data country; 
  title "country data analysis";
  infile "&DIR1\country.data";
  input  name $ area popnsize pcturban lang $ liter lifemen
         lifewom pcGNP;
  logarea = log10(area);
  logpopn = log10(popnsize);
  loggnp  = log10(pcGNP);
  ienglish = (lang="English");
  drop area popnsize pcgnp;
run;

proc print data=country;
run;

proc reg data=country;
  title "LITER and LOGGNP as predictors of Life expectancy of women";
  model lifewom = liter loggnp/ tol vif collinoint;      
  output out=new p=yhat r=resid;
run;

/* plot life expectancy of women vs. log(GNP) with a linear regression
   fit and LOESS fit superimposed
*/
ods rtf bodytitle 
        file="C:\Users\baileraj\Desktop\ch1-display-1.1-fig.rtf";
title "";
proc sgplot data=country;
  reg y=lifewom x=loggnp;
  loess y=lifewom x=loggnp;
run;
ods rtf close;


/************************************** Display 1.2 ***********************************************/


/* generate a data set of 10 (X,Y) pairs where
   X = 1, 2, ..., 10
   Y ~ N(mu= 3 + 2X, sigma=2)
*/

data lin_reg_data;
   call streaminit(32123);
   do x = 1 to 10 by 1;
      y = 3+2*x+2*RAND('NORMAL');
     output;
   end;
run;

proc print data=lin_reg_data;  * check data generation;
run;

ods rtf bodytitle 
    file="C:\Users\baileraj.IT\Desktop\ch1-display-1.2-fig.rtf";
ods graphics on;
proc reg data=lin_reg_data plots(only)=FitPlot(nolimits);
   model y=x;
run;
ods graphics off;
ods rtf close;


/************************************** Exercise 1.1 ***********************************************/

   OPTIONS LS=75;
   DATA EXAMPLE1; INPUT Y X Z; DATALINES;
   77	447	13
   78	460	21
   79	481	24
   80	498	16
   81	513	24
   82	512	20
   83	526	15
   84	559	34
   85	585	33
   86	614	33
   87	645	39
   88	675	43
   89	711	50
   90	719	47
   ;
   PROC REG; MODEL Z = X / P R CLI CLM;
   PLOT Z*X P.*X / OVERLAY ; 
   PLOT R.*X R.*P.; RUN;


/************************************** Exercise 1.3 (DATA) ***********************************************/


44 89.47 44.609 11.37 62 178 182   40 75.07 45.313 10.07 62 185 185 
44 85.84 54.297  8.65 45 156 168   42 68.15 59.571  8.17 40 166 172 
38 89.02 49.874  9.22 55 178 180   47 77.45 44.811 11.63 58 176 176 
40 75.98 45.681 11.95 70 176 180   43 81.19 49.091 10.85 64 162 170 
44 81.42 39.442 13.08 63 174 176   38 81.87 60.055  8.63 48 170 186 
44 73.03 50.541 10.13 45 168 168   45 87.66 37.388 14.03 56 186 192 
45 66.45 44.754 11.12 51 176 176   47 79.15 47.273 10.60 47 162 164 
54 83.12 51.855 10.33 50 166 170   49 81.42 49.156  8.95 44 180 185 
51 69.63 40.836 10.95 57 168 172   51 77.91 46.672 10.00 48 162 168 
48 91.63 46.774 10.25 48 162 164   49 73.37 50.388 10.08 67 168 168 
57 73.37 39.407 12.63 58 174 176   54 79.38 46.080 11.17 62 156 165 
52 76.32 45.441  9.63 48 164 166   50 70.87 54.625  8.92 48 146 155 
51 67.25 45.118 11.08 48 172 172   54 91.63 39.203 12.88 44 168 172 
51 73.71 45.790 10.47 59 186 188   57 59.08 50.545  9.93 49 148 155 
49 76.32 48.673  9.40 56 186 188   48 61.24 47.920 11.50 52 170 176 
52 82.78 47.467 10.50 53 170 172 



/************************************** Display 2.3 ***********************************************/

data lin_reg_data; 
  call streaminit(32123);
  do x = 0 to 10 by 1; 
     y = 3 + 2*x + 2*RAND('NORMAL'); 
    output; 
  end; 
run;

ods rtf bodytitle file='C:\Users\baileraj.IT\Desktop\ch2-fig2.3.rtf';
proc sgplot data=lin_reg_data;   * or equivalently, data=work.lin_reg_data; 
   scatter y=y x=x; 
run; 

proc reg data=lin_reg_data; 
   model y=x; 
run;
ods rtf close;


/************************************** Display 2.4 ***********************************************/

data SMSA_subset; 
input city $ JanTemp	JulyTemp RelHum Rain Mortality	Education	PopDensity
      pct_NonWhite pct_WC pop pop_per_house income HCPot NOxPot S02Pot NOx;
datalines;
Akron, OH	27	71	59	36	921.87	11.4	3243	8.8	42.6	660328	3.34	29560	21	15	59	15
Albany-Schenectady-Troy, NY	23	72	57	35	997.87	11.0	4281	3.5	50.7	835880	3.14	31458	8	10	39		10
Allentown, Bethlehem, PA-NJ		29	74	54	44		962.35	9.8	4260	0.8	39.4	635481	3.21	31856		6	6	33	6
Atlanta, GA	45	79	56	47	982.29	11.1	3125	27.1	50.2	2138231	3.41	32452	18	8	24	8
Baltimore, MD	35	77	55	43	1071.29	9.6	6441	24.4	43.7	2199531	3.44	32368	43	38	206	38
;
run;

ods rtf bodytitle file='C:\Users\baileraj.IT\Desktop\ch2-fig2.4.rtf';
proc print data=SMSA_subset;
  var city JanTemp JulyTemp RelHum NOxPot S02Pot NOx;
run;
ods rtf close ;


/************************************** Display 2.6 ***********************************************/

data SMSA_subset;
length city $ 27; 
input city &	JanTemp	JulyTemp	RelHum	Rain	Mortality	Education	PopDensity
      pct_NonWhite pct_WC pop pop_per_house income HCPot NOxPot S02Pot NOx;
datalines;
Akron, OH	27	71	59	36	921.87	11.4	3243	8.8	42.6	660328	3.34	29560	21	15	59	15
Albany-Schenectady-Troy, NY		23	72	57	35	997.87	11.0	4281	3.5	50.7	835880	3.14	31458	8	10	39	10
Allentown, Bethlehem, PA-NJ		29	74	54	44		962.35	9.8	4260	0.8	39.4	635481	3.21	31856	6 6	33 6
Atlanta, GA	45	79	56	47	982.29	11.1	3125	27.1	50.2	2138231	3.41	32452	18	8	24	8
Baltimore, MD	35	77	55	43	1071.29	9.6	6441	24.4	43.7 2199531	3.44 32368 43 38 206 38
;
run;

ods rtf bodytitle file='C:\Users\baileraj.IT\Desktop\ch2-fig2.6.rtf';
proc print data=SMSA_subset;
  var city JanTemp JulyTemp RelHum NOxPot S02Pot NOx;
run;
ods rtf close;


/************************************** Display 2.8 ***********************************************/

/*
Notes:
1) Two spaces separate each entry in the input data file.  A global 
   replace of tabs with two spaces was performed before saving the text file.
2) The first line contains the names of the variables, and the data begins
   on the 2nd line of the file.
3) Fort Worth had missing values for POP and INCOME and "." were entered in
   the data file.
4) Increased LENGTH to 39 to accommodate GREENSBORO-WINSTON-SALEM...
*/
options nodate nocenter;
data SMSA_from_txt;
infile "C:\Users\baileraj.IT\Desktop\DT-Book 3\SMSA-DASL-2space-sep.txt" firstobs=2;
length city $ 39; 
input city & JanTemp	JulyTemp	RelHum	Rain	Mortality	Education	PopDensity
      pct_NonWhite pct_WC pop pop_per_house income HCPot NOxPot S02Pot NOx;
run;

ods rtf bodytitle file='C:\Users\baileraj.IT\Desktop\ch2-fig2.8.rtf';
proc print data=SMSA_from_txt;
  var city JanTemp JulyTemp RelHum NOxPot S02Pot NOx;
run;
ods rtf close;

/************************************** Display 2.10 ***********************************************/

options nodate nocenter;
data SMSA_from_CSV;
infile "C:\Users\baileraj.IT\Desktop\DT-Book 3\DASL-SMSA-commasep.csv" firstobs=2 dsd;
length city $ 39; 
input city &	JanTemp	JulyTemp	RelHum	Rain	Mortality	Education	PopDensity 
      pct_NonWhite pct_WC pop pop_per_house income HCPot NOxPot S02Pot NOx;
run;

ods rtf bodytitle file='C:\Users\baileraj.IT\Desktop\ch2-fig2.10.rtf';
proc print data=SMSA_from_CSV (firstobs=17 obs=25);
  var city JanTemp JulyTemp RelHum pop pop_per_house income;
  run;
ods rtf close;

/************************************** Display 2.12 ***********************************************/

/*  Assumes SAS/ACCESS engines are available  */
/*  IMPORT code produced by the IMPORT WIZARD */

PROC IMPORT OUT= WORK.DASL_FROM_EXCEL2 
     DATAFILE= "C:\Documents and Settings\baileraj\Desktop\DASL-SMSA.xls" 
     DBMS=EXCEL REPLACE;
   SHEET="Sheet1$"; 
   GETNAMES=YES;
   MIXED=NO;
   SCANTEXT=YES;
   USEDATE=YES;
   SCANTIME=YES;
RUN;

/* ------------------------- via EXCEL engine with LIBNAME   */
options nodate;
title ;

libname spreads excel 
"C:\Documents and Settings\baileraj\Desktop\DASL-SMSA.xls" header=yes;

ods rtf bodytitle file='C:\Users\baileraj.IT\Desktop\ch2-fig2.12.rtf';
/* list the contents of the spreadsheet that was read */
proc contents data=spreads._all_ varnum;
run;

/* set contents of the 1st worksheet to SAS data set */
data DASL_from_Libname_Excel_engine; 
  set spreads.'sheet1$'n;
run;

proc print data=DASL_from_Libname_Excel_engine;
run;
ods rtf close;


/************************************** Display 2.14 ***********************************************/

libname myfiles "C:\Users\baileraj.IT\BAILERAJ\Classes\Web-CLASSES\sta402\data";

proc sort data=myfiles.nitrofen; 
     by conc;
run;

data _null_; set myfiles.nitrofen; by conc;
  if FIRST.CONC then do; * first observation in concentration group;
     put 50*'-';         * add separator line of 50 dashes + column headings;
     put "Animal" @10 "Conc" @20 "Total" @30 "First?" @40 "Last?";
  end;
  put animal @10 conc @20 total @30 FIRST.CONC @40 LAST.CONC;

*  put _all_;   /* useful to check values during input  */
run;


/************************************** Display 2.16 ***********************************************/

libname myfiles "C:\Users\baileraj.IT\BAILERAJ\Classes\Web-CLASSES\sta402\data";

proc sort data=myfiles.nitrofen; 
     by conc;
run;

data _NULL_; 
  set myfiles.nitrofen; 
  by conc;
  file 'C:\Users\baileraj.IT\Desktop\nitrofen-put.txt';
 
/* Write out header text information for the first observation in each conc*/
  if FIRST.conc then do;
    put 6*'+-----' '+';
    put 'Conc = ' conc  / 
        @1 'Brood 1'  @10 'Brood 2'  @20 'Brood 3' @30 'TOTAL' /
        @1 '-------'  @10 '-------'  @20 '-------' @30 '-----';
  end;

/* Write out the data for all records */
  put @5 brood1 3.  @14 brood2 3. @24 brood3 3. @32 total 3.;
run;

data _NULL_;     /* add last line to the output file */
  file 'C:\Users\baileraj.IT\Desktop\nitrofen-put.txt' MOD;
  put 6*'+-----' '+' //
      'Data from C. dubia Nitrofen exposure data [Bailer & Oris 1993]';
run;


/************************************** Display 2.18 ***********************************************/

libname myfiles "C:\Users\baileraj.IT\BAILERAJ\Classes\Web-CLASSES\sta402\data";

/* create a TEXT file with the nitrofen data */
data _NULL_;  set myfiles.nitrofen;
  file 'C:\Users\baileraj.IT\Desktop\nitrofen-TEXT.txt';
  put @1 conc  @10 animal @15 brood1 @20 brood2 @25 brood3 @30 total;
run;

/* create a CSV file with the nitrofen data */
data _NULL_;  set myfiles.nitrofen;
  file 'C:\Users\baileraj.IT\Desktop\nitrofen-CSV.csv' dsd;
  put conc animal brood1 brood2 brood3 total;
run;

/* create a CSV file with the nitrofen data and a row with variable names */
data _NULL_;  * write variable names to first line of file;
  file 'C:\Users\baileraj.IT\Desktop\nitrofen-CSV2.csv' dsd;
  put "conc,animal,brood1,brood2,brood3,total";
run;

data _NULL_; set myfiles.nitrofen;  * add data values below var names;
  file 'C:\Users\baileraj.IT\Desktop\nitrofen-CSV2.csv' dsd MOD;
  put conc animal brood1 brood2 brood3 total;
run;

/************************************** Display 2.20 ***********************************************/


libname myfiles "C:\Users\baileraj.IT\BAILERAJ\Classes\Web-CLASSES\sta402\data";

/*
  nitrofen = SAS data set in this library
*/

proc contents data=myfiles.nitrofen;
run;

/* Using ODS with CSV + PROC PRINT to produce *.csv file
   Thanks to Kathy Roggenkamp for suggesting this alternative!
*/
ods csv file="C:\Users\baileraj.IT\Desktop\nitrofen.csv";
proc print data=myfiles.nitrofen;
  var conc total;
  id animal;
  run;
ods csv close;

/*
  Using File > Export Data ... can be used to construct a
  *.csv file AND save the associated SAS PROC EXPORT code
  (see below)
*/
PROC EXPORT DATA= MYFILES.NITROFEN 
            OUTFILE= "C:\Users\baileraj.IT\Desktop\nitrofen2.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;

/************************************** Display 2.23 ***********************************************/

data conc_0;
  input total @@;
  conc = 0;  * define a variable containing the value of the nitrofen conc.;
  datalines;
27 32 34 33 36 34 33 30 24 31
;
run;

data conc_80;
  input total @@;
  conc = 80;  * define a variable containing the value of the nitrofen conc.;
  datalines;
33 33 35 33 36 26 27 31 32 29
;
run;

data conc_160;
  input total @@;
  conc = 160;  * define a variable containing the value of the nitrofen conc.;
  datalines;
29 29 23 27 30 31 30 26 29 29
;
run;

data conc_235;
  input total @@;
  conc = 235;  * define a variable containing the value of the nitrofen conc.;
  datalines;
23 21 7 12 27 16 13 15 21 17
;
run;

data conc_310;
  input total @@;
  conc = 310;  * define a variable containing the value of the nitrofen conc.;
  datalines;
6 6 7 0 15 5 6 4 6 5 
;
data set_all5;
  set conc_0 conc_80 conc_160 conc_235 conc_310;
run;

ods rtf bodytitle file='C:\Users\baileraj.IT\Desktop\ch2-fig2.23.rtf';
proc print data=set_all5;
  var conc total;
run;
ods rtf close;

/************************************** Display 2.26 ***********************************************/

data SMSA_subset_weather;
  length city $ 27; 
  input city & JanTemp JulyTemp RelHum Rain;
datalines;
Akron, OH  27 71 59 36 
Albany-Schenectady-Troy, NY  23 72 57 35 
Baltimore, MD  35 77 55 43 
Allentown, Bethlehem, PA-NJ  29 74 54 44 
Atlanta, GA  45 79 56 47 
;
run;

data SMSA_subset_demog;
  length city $ 27; 
  input city & Mortality Education PopDensity 
        pct_NonWhite pct_WC pop pop_per_house income;
datalines;
Akron, OH  921.87 11.4 3243 8.8 42.6 660328 3.34 29560
Albany-Schenectady-Troy, NY  997.87 11.0 4281 3.5 50.7 835880 3.14 31458
Baltimore, MD  1071.29 9.6 6441 24.4 43.7 2199531 3.44 32368
Allentown, Bethlehem, PA-NJ  962.35 9.8 4260 0.8 39.4 635481 3.21 31856
Atlanta, GA  982.29 11.1 3125 27.1 50.2 2138231 3.41 32452
;
run;

data SMSA_subset_pollution;
  length city $ 27; 
  input city & HCPot NOxPot S02Pot NOx;
datalines;
Akron, OH  21 15 59 15
Albany-Schenectady-Troy, NY  8 10 39 10
Baltimore, MD  43 38 206 38
Allentown, Bethlehem, PA-NJ  6 6 33 6
Atlanta, GA  18 8 24 8
;
run;

proc sort data=SMSA_subset_weather;
     by city;
run;
proc sort data=SMSA_subset_demog;  
     by city;
run;
proc sort data=SMSA_subset_pollution;  
     by city;
run;

data all_subset;
  merge SMSA_subset_weather SMSA_subset_demog SMSA_subset_pollution;
  by city;
run;

ods rtf bodytitle file='C:\Users\baileraj.IT\Desktop\ch2-fig2.26.rtf';
proc print data=all_subset;
  var city JanTemp mortality NOx;
run;
ods rtf close;


/************************************** Display 2.28 ***********************************************/

options nodate nonumber;                                       *** comment 0;

data SMSA_subset_weather2;
   length city $ 27; 
   input city & JanTemp JulyTemp RelHum Rain;
datalines;
Akron, OH  27 71 59 36 
Baltimore, MD  35 77 55 43 
Allentown, Bethlehem, PA-NJ  29 74 54 44 
Atlanta, GA  45 79 56 47 
;
run;

data SMSA_subset_demog2;
   length city $ 27; 
   input city & Mortality Education PopDensity 
      pct_NonWhite pct_WC pop pop_per_house income;
datalines;
Akron, OH  921.87 11.4 3243 8.8 42.6 660328 3.34 29560
Albany-Schenectady-Troy, NY  997.87 11.0 4281 3.5 50.7 835880 3.14 31458
Baltimore, MD  1071.29 9.6 6441 24.4 43.7 2199531 3.44 32368
Allentown, Bethlehem, PA-NJ  962.35 9.8 4260 0.8 39.4 635481 3.21 31856
;
run;

proc sort data=SMSA_subset_weather2;                           *** comment 1;
  by city;
run;

proc sort data=SMSA_subset_demog2; 
  by city;
run;

data in_either;	 * city in either weather2 or demog2 data set;
  merge SMSA_subset_weather2 (in=in1)   
        SMSA_subset_demog2 (in=in2);                           *** comment 2;
  by city;
  weather2_in = in1;   * save indicator of presence in data set;
  demog2_in = in2;
run;

data in_both;   * city in both data sets;
  set in_either;                                               *** comment 3;
  if weather2_in=1 and demog2_in=1;                            *** comment 4;
run;

data in_weather;  * city in weather2 data set;
  set in_either;
  if weather2_in=1;
run;

data in_demog;  * city in demog2 data set;
  set in_either;
  if demog2_in=1;
run;

ods rtf bodytitle file='C:\Users\baileraj.IT\Desktop\ch2-fig2.28.rtf';  *** comment 5;

proc print data=in_either;                                     *** comment 6;
  title "city in EITHER weather OR demog data set OR BOTH data sets";
  var city weather2_in demog2_in JanTemp Rain Mortality income;
run;

proc print data=in_both;
  title "city in BOTH weather AND demog data sets";
  var city weather2_in demog2_in JanTemp Rain Mortality income;
run;

proc print data=in_weather;
  title "city in weather data set";
  var city weather2_in demog2_in JanTemp Rain Mortality income;
run;

proc print data=in_demog;
  title "city in demography data set";
  var city weather2_in demog2_in JanTemp Rain Mortality income;
run;

ods rtf close;

/************************************** Display 2.30 ***********************************************/

data conc_310;
  input total @@;
  conc = 310;  * define a variable containing the value of the nitrofen conc.;
  datalines;
6 6 7 0 15 5 6 4 6 5 
;
run;

ods rtf bodytitle file='C:\Users\baileraj.IT\Desktop\ch2-fig2.30.rtf';
proc sql;
  select conc,total from conc_310;
quit;
ods rtf close;

/************************************** Display 2.32 ***********************************************/

data conc_0;
  input total @@;
  conc = 0;  * define a variable containing the value of the nitrofen conc.;
  id=_n_;    * define an animal ID corresponding the observation number;
  datalines;
27 32 34 33 36 34 33 30 24 31
;
run;

data conc_80;
  input total @@;
  conc = 80; * define a variable containing the value of the nitrofen conc.;
  id=_n_;    * define an animal ID corresponding the observation number;
  datalines;
33 33 35 33 36 26 27 31 32 29
run;

data conc_160;
  input total @@;
  conc = 160;* define a variable containing the value of the nitrofen conc.;
  id=_n_;    * define an animal ID corresponding the observation number;
  datalines;
29 29 23 27 30 31 30 26 29 29
;
run;

data conc_235;
  input total @@;
  conc = 235;* define a variable containing the value of the nitrofen conc.;
  id=_n_;    * define an animal ID corresponding the observation number;
  datalines;
23 21 7 12 27 16 13 15 21 17
;
run;

data conc_310;
  input total @@;
  conc = 310;* define a variable containing the value of the nitrofen conc.;
  id=_n_;    * define an animal ID corresponding the observation number;
  datalines;
6 6 7 0 15 5 6 4 6 5 
;
run;

proc sql;
  create table all_sql as 
  select * from conc_0
  union
  select * from conc_80
  union
  select * from conc_160
  union
  select * from conc_235
  union
  select * from conc_310
  order by conc,id;
quit;  * RUN has no effect on SQL because statements are immediately executed;
       * QUIT ends SQL;
ods rtf bodytitle file='C:\Users\baileraj.IT\Desktop\ch2-fig2.32.rtf';
proc print data=all_sql;
run;
ods rtf close;

/************************************** Display 2.34 ***********************************************/

data SMSA_subset_weather;
   length city $ 27; 
   input city & JanTemp JulyTemp	RelHum Rain;
datalines;
Akron, OH  27 71 59 36 
Albany-Schenectady-Troy, NY  23 72 57 35 
Baltimore, MD  35 77 55 43 
Allentown, Bethlehem, PA-NJ  29 74 54 44 
Atlanta, GA  45 79 56 47 
;
run;

data SMSA_subset_demog;
   length city $ 27; 
   input city & Mortality Education PopDensity 
      pct_NonWhite pct_WC pop pop_per_house income;
datalines;
Akron, OH  921.87 11.4 3243 8.8 42.6 660328 3.34 29560
Albany-Schenectady-Troy, NY  997.87 11.0 4281 3.5 50.7 835880 3.14 31458
Baltimore, MD  1071.29 9.6 6441 24.4 43.7 2199531 3.44 32368
Allentown, Bethlehem, PA-NJ  962.35 9.8 4260 0.8 39.4 635481 3.21 31856
Atlanta, GA  982.29 11.1 3125 27.1 50.2 2138231 3.41 32452
;
run;

data SMSA_subset_pollution;
   length city $ 27; 
   input city & HCPot NOxPot S02Pot NOx;
datalines;
Akron, OH  21 15 59 15
Albany-Schenectady-Troy, NY  8 10 39 10
Baltimore, MD  43 38 206 38
Allentown, Bethlehem, PA-NJ  6 6 33 6
Atlanta, GA  18 8 24 8
;
run;

proc sql;
  create table SMSA_subset_sql as
  select * from
    SMSA_subset_weather w, SMSA_subset_demog d, SMSA_subset_pollution p
  where w.city=d.city and d.city=p.city;

ods rtf bodytitle file='C:\Users\baileraj.IT\Desktop\ch2-fig2.34.rtf';
proc print data=SMSA_subset_sql;
  var city JulyTemp education S02Pot;
run;
ods rtf close;

/************************************** Display 2.36 ***********************************************/

data SMSA_subset_weather2;
   length city $ 27; 
   input city & JanTemp JulyTemp	RelHum Rain;
datalines;
Akron, OH  27 71 59 36 
Baltimore, MD  35 77 55 43 
Allentown, Bethlehem, PA-NJ  29 74 54 44 
Atlanta, GA  45 79 56 47 
;
run;

data SMSA_subset_demog2;
   length city $ 27; 
   input city & Mortality Education PopDensity 
      pct_NonWhite pct_WC pop pop_per_house income;
datalines;
Akron, OH  921.87 11.4 3243 8.8 42.6 660328 3.34 29560
Albany-Schenectady-Troy, NY  997.87 11.0 4281 3.5 50.7 835880 3.14 31458
Baltimore, MD  1071.29 9.6 6441 24.4 43.7 2199531 3.44 32368
Allentown, Bethlehem, PA-NJ  962.35 9.8 4260 0.8 39.4 635481 3.21 31856
;
run;

ods rtf bodytitle file='C:\Users\baileraj.IT\Desktop\ch2-fig2.36.rtf';

/* inner join / conventional join */
proc sql;
title "inner join";
  select w.city,JanTemp,JulyTemp,Education,income from 
     SMSA_subset_weather2 as w,SMSA_subset_demog2 as d
  where w.city=d.city;

/* LEFT outer join - with duplicate columns */

title "LEFT outer join with duplicate columns";
  select * from 
       SMSA_subset_weather2 as w
  left join
       SMSA_subset_demog2 as d
  on w.city=d.city;

/* LEFT outer join - eliminating duplicate columns using COALESCE */

title "LEFT outer join eliminating duplicate columns";
  select coalesce(w.city, d.city),JanTemp,JulyTemp,Education,income from 
       SMSA_subset_weather2 as w
  left join
       SMSA_subset_demog2 as d
  on w.city=d.city;

/* RIGHT outer join */

title "RIGHT outer join";
  select coalesce(w.city, d.city),JanTemp,JulyTemp,Education,income from 
       SMSA_subset_weather2 as w
  right join
       SMSA_subset_demog2 as d
  on w.city=d.city;

/* FULL outer join */

title "FULL outer join";
  select coalesce(w.city, d.city),JanTemp,JulyTemp,Education,income from 
       SMSA_subset_weather2 as w
  full join
       SMSA_subset_demog2 as d
  on w.city=d.city;
quit;

ods rtf close;


/************************************** Display 2.39 ***********************************************/

data coin_toss;
  toss="Heads"; output;
  toss="Tails"; output;
run;

data die_roll;
  face=1; output;  face=2; output;
  face=3; output;  face=4; output;
  face=5; output;  face=6; output;
run;

proc sql;
 create table roll_n_toss as 
 select * from coin_toss,die_roll;
quit;

ods rtf bodytitle file='C:\Users\baileraj.IT\Desktop\ch2-fig2.39.rtf';
proc print data=roll_n_toss;
run;
ods rtf close;

data roll_n_toss2;  * using ARRAYS (see Ch. 9 for details);
  array array_toss(*) $ toss1-toss2 ("Heads", "Tails");
  array array_face(*) face1-face6 (1, 2, 3, 4, 5, 6);

  do itoss=1 to 2;
    do iface=1 to 6;
      toss = array_toss(itoss);
      face = array_face(iface);
      keep toss face;
      output;
    end;
  end;
run;

proc print data=roll_n_toss2;
run;

/************************************** Exercise 2.1 ***********************************************/

logcount condition
7.66 Plastic
6.98 Plastic
7.80 Plastic
5.26 Vacuum
5.44 Vacuum
5.80 Vacuum
7.41 Mixed
7.33 Mixed
7.04 Mixed
3.51 Co2
2.91 Co2
3.66 Co2


/************************************** Exercise 2.2 ***********************************************/

Brood=1 data
Variables:  ID   conc   number of young
3 0 6  4 0 6  5 0 6  6 0 5  7 0 6  8 0 5 9 0 3 10 0 6 
12 80 5 13 80 6  14 80 5  15 80 8  16 80 3  17 80 5  18 80 7
19 80 5  20 80 3  
21 160 6  22 160 6  23 160 2  24 160 6  25 160 6  26 160 6
27 160 6  28 160 5  30 160 6
31 235 4  32 235 6  34 235 6  35 235 6  36 235 6  37 235 7
38 235 4  39 235 6  40 235 7
41 310 6  42 310 6  43 310 7  44 310 0  45 310 5  47 310 6
48 310 4  49 310 6  50 310 5

Brood=2 data
Variables:  ID   conc   number of young
1 0 14  2 0 12  3 0 11  4 0 12  6 0 14  7 0 12  8 0 13
9 0 10  10 0 11
11 80 11  13 80 11  14 80 12  15 80 13  16 80 9  17 80 9
18 80 12  19 80 13  20 80 12
21 160 12  22 160 12  23 160 8  24 160 10  25 160 11
26 160 13  27 160 12  29 160 13  30 160 12
31 235 13  32 235 10  33 235 5  34 235 0  35 235 13
36 235 0  37 235 0  38 235 2  39 235 8  40 235 0
41 310 0  42 310 0  43 310 0  45 310 10  46 310 0  47 310 0
48 310 0  49 310 0  50 310 0

Brood=3 data
Variables:  ID   conc   number of young
1 0 10  2 0 15  3 0 17  4 0 15  5 0 15  6 0 15  7 0 15
8 0 12  10 0 14
11 80 16  12 80 16  13 80 18  14 80 16  15 80 15  16 80 14
17 80 13  18 80 12  19 80 14  20 80 14
21 160 11  22 160 11  23 160 13  24 160 11  25 160 13  26 160 12
27 160 12  28 160 11  29 160 10  30 160 11
31 235 6  32 235 5  33 235 0  34 235 6  35 235 8  36 235 10
38 235 9  39 235 7  40 235 10
41 310 0  42 310 0  43 310 0  44 310 0  45 310 0  46 310 0
48 310 0  49 310 0  50 310 0 


/********************* Chapter 2 self-study laboratory explorations ********************************/

/* ==================================================== */
/* PUT examples ...                                     */
/* ==================================================== */

data;
  put "Hello World!!!";
  put @20 "Hello World!!!";  * start at column 20;
  put 3*"Hello World!!!";    * 3 copies;
run;

data;
  put;
  put "Hello World!!!" /;
  put @20 "Hello World!!!" /;  * start at column 20;
  put 3*"Hello World!!!" /;    * 3 copies;
  put;
run;  

data;
  input name $ @@;
  put "Hello " name ", welcome to SAS Statistical Programming." /;
  datalines;
Dave Hal 
;
run;
 
data;
  file " C:\Users\baileraj.IT\Desktop\put-example.TXT";
* replace path in FILE with folder on your system;
  input name $ @@;
  put "Hello " name ", welcome to SAS Statistical Programming." /;
  datalines;
Dave Hal
;
run;
 
/* ==================================================== */
/*  CONCATENATING ("row binding") data sets             */
/* ==================================================== */

/* clean example */
data d1;
  input v1 v2 v3;
  datalines;
1 2 3
4 5 6
;
run;

data d2;
  input v1 v2 v3;
  datalines;
11 12 13
14 15 16
17 18 19
;
run;

data d12;
  set d1 d2;
run;
proc print;
run;

/* not-so-clean example */
data d1a;
  input v1 v2 v3;
  datalines;
1 2 3
4 5 6
;
run;

data d2a;
  input var1 var2 var3;
  datalines;
11 12 13
14 15 16
17 18 19
;
run;

data d12a;
  set d1a d2a;
run;

proc print data=d12a;
run;

/* fixing not-so-clean example */
data d1b;
  input v1 v2 v3;
  datalines;
1 2 3
4 5 6
;
data d2b;
  input var1 var2 var3;
  v1=var1;
  v2=var2;
  v3=var3;
  drop var1-var3;
  datalines;
11 12 13
14 15 16
17 18 19
;
data d12b;
  set d1b d2b;
run;

proc print data=d12b;
run;

/* one last concatenation example */

options formdlim="-";

data d1c;
  input v1 v2 v3;
  datalines;
1 2 3
4 5 6
;
run;

data d2c;
  input var1 var2 var3;
  datalines;
11 12 13
14 15 16
17 18 19
;
run;

data d12c;
 set d1c d2c (rename=(var1=v1 var2=v2 var3=v3));
run;

proc print data=d12c;
  run;

/* merging data examples */

options formdlim="-";

data m1;
 input ID v1 v2;
 datalines;
1 2 3
2 5 6
4 7 8
;
run;

data m2;
  input ID var1 var2 var3;
  datalines;
1 11 12 13
2 14 15 16
3 17 18 19
;
run;

data M12;
  merge m1 m2;
  by ID;
run;

proc print data=m12;
title "First Merge data example";
run;

/* suppose you have common variables in the data sets that are merged? */

options formdlim="-";

data m1b;
  input ID v1 v2;
  datalines;
1 2 3
2 5 6
4 7 8
;
run;

data m2b;
  input  ID v1 v2 var3;
  datalines;
1 11 12 13
2 14 15 16
3 17 18 19
;
data M12b;
  merge m1b m2b;
  by ID;
run;

proc print data=m12b;
  title "Second Merge data example - common variables in 2 data sets";
run;

data M12b2;
  merge m2b m1b;
  by ID;
run;

proc print data=m12b2;
title "Second Merge data example - diff merge order";
run;

proc print data=m1b;
run;
proc print data=m2b; 
run;

/* what if the data sets have multiple records with an ID? */

data m1c;
  input ID v1 v2;
  datalines;
1 2 3
1 4 5
2 6 7
;
run;

data m2c;
  input ID var1;
  datalines;
1 11
2 21
2 22
;
run;

data m12c;
  merge m1c m2c;
  by ID;
proc print data=m12c;
title "many to one merging issues";
run;

data m1d;
  input ID v1 v2;
  datalines;
1 2 3
1 4 5
;
run;

data m2d;
  input ID var1;
  datalines;
1 11
1 12
1 13
;
run;

data m12d;
  merge m1d m2d;
  by ID;
run;

proc print data=m12d;
title "many to many merging issues";
run;



/* ================================================================ */
/* BASIC SQL stuff >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  */
/* ================================================================ */

options formdlim="-";
data junk;
  input cgroup $ x y @@;
  datalines;
a 1 2 B 3 4 B 5 6 A 7 8 A 9 10
;
run;

/* basic PROC stuff */
proc print data=junk;

run;
proc sort data=junk; 
     by cgroup;
run;

proc print data=junk;
run;

proc means data=junk;
  class cgroup;
  var x y;
run;

/*  notes:  
1.  Multiple select statements can be used to generate different views of the data
2. SQL continues until QUIT; or a DATA/PROC step                    
*/

proc sql;
  select * 
     from junk;   * select and display all variables;

  select cgroup  
     from junk;   * select particular variable;

  select cgroup,x,y
     from junk
       order by cgroup;  * order the rows of the view table;

  select cgroup,x,y
     from junk
       order by x;

  select cgroup,x,y, x/(x+y)*100 as pctsum
     from junk;            * construct and name a new variable/column;

  select cgroup,x,y, x/(x+y)*100 as pctsum
         label='% sum' format=4.1
     from junk;

  select avg(x) label='avg x',avg(y) label='avg y'  
     from junk;                    * summary functions of SQL;

  select cgroup label='Variable', count(*) label='n', 
         avg(x) label='avg x',avg(y) label='avg y'
     from junk
     group by cgroup;              * grouping rows/summaries in SQL;
  
select cgroup label='Variable', count(*) label='n', 
         avg(x) label='avg x',avg(y) label='avg y'
     from junk
     where cgroup in ('A','B')
     group by cgroup ;                 * subsetting rows in SQL;


select cgroup label='Variable', count(*) label='n', 
         avg(x) label='avg x',avg(y) label='avg y'
     from junk
     where cgroup in ('A','B')
     group by cgroup 
     having avg(x) > 5;

/* to check a query before running it */
/*
validate
      select . . ..
*/

/* ================================================================ */
/* SQL:  CONCATENATE examples >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  */
/* ================================================================ */

/* clean example */
data d1;
  input v1 v2 v3;
  datalines;
1 2 3
4 5 6
;
run;

data d2;
  input v1 v2 v3;
  datalines;
11 12 13
14 15 16
17 18 19
;
run;

proc sql;
  select * from d1;
  select * from d2;
  select * from d1,d2;

  select * 
      from d1
  outer union
  select * 
      from d2; 
* SET operators in SQL - outer union, union, except, intersect; 

  select * 
      from d1
  outer union corr
  select * 
      from d2;               * CORR overlays common columns;

  select * 
      from d1
  union 
  select * 
      from d2;               * even simpler;

  create table work.d12 as
  select * 
      from d1
  outer union corr
  select * 
      from d2;               * produce a SAS data set from an SQL query;

/* not-so-clean example */
data d1a;
  input v1 v2 v3;
  datalines;
1 2 3
4 5 6
;
run;

data d2a;
  input var1 var2 var3;
  datalines;
11 12 13
14 15 16
17 18 19
;
run;

proc sql;
  select * from d1a,d2a;

  select * 
      from d1a
  outer union
  select * 
      from d2a;

  select * 
      from d1a
  union
  select * 
      from d2a;

  select * 
      from d1a
  outer union corr
  select var1 as v1, var2 as v2, var3 as v3 
      from d2a;                 * renaming as part of selection;

 
/* ================================================================ */
/* merging data examples >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> */
/* ================================================================ */

options formdlim="-";

data m1;
 input ID v1 v2;
 datalines;
1 2 3
2 5 6
4 7 8
;
run;

data m2;
  input ID var1 var2 var3;
  datalines;
1 11 12 13
2 14 15 16
3 17 18 19
;
run;

proc sql;
  select * 
    from m1,m2;

  select * 
    from m1,m2
    where m1.id=m2.id;

  select m1.ID,v1,v2,var1,var2,var3 
    from m1,m2
    where m1.id=m2.id;

  select * 
    from m1 inner join m2
    on m1.id=m2.id;

  select * 
    from m1 right join m2
    on m1.id=m2.id;

  select * 
    from m1 left join m2
    on m1.id=m2.id;

  select * 
    from m1 full join m2
    on m1.id=m2.id;

/* multiple records per id */
data m1c;
  input ID v1 v2;
  datalines;
1 2 3
1 4 5
2 6 7
;
run;
data m2c;
  input ID var1;
  datalines;
1 11
2 21
2 22
;
run;

proc sql;
  select * 
    from m1c,m2c;

  select * 
    from m1c,m2c
    where m1c.id=m2c.id;

  select m1c.ID,v1,v2,var1,var2,var3 
    from m1c,m2c
    where m1c.id=m2c.id;

  select * 
    from m1c inner join m2c
    on m1c.id=m2c.id;

  select * from m1c;
  select * from m2c;

/* many to many merging issues */
data m1d;
  input ID v1 v2;
  datalines;
1 2 3
1 4 5
;
run;

data m2d;
  input ID var1;
  datalines;
1 11
1 12
1 13
;
run;

proc sql;
  select * from m1d;
  select * from m2d;
  select *
     from m1d, m2d
     where m1d.id=m2d.id;


/************************************** Display 3.1 ***********************************************/


* RECALL:  variance=0.25 implies SD=0.5;
*          If Z ~ N(0,1), then Y=mu + sigma*Z ~ N(mu, sigma^2); 
*          Here, mu=3+2*X and sigma=0.5;
 data test;  
  call streaminit(0);
  do X=1 to 10;
     Y=3+2*X+0.5*RAND('NORMAL');
    output;
  end;
run;

proc print data=test; 
run;


/************************************** Display 3.3 ***********************************************/

options nocenter nodate;
* generate a 10 observation data set with Y~N(3+2x,0.5^2);
data test;  
  call streaminit(0);
  do X=1 to 10;
     Y=3+2*X+0.5* RAND('NORMAL');
     output;
  end;
run;

proc print data=test; 
run;

/************************************** Display 3.5 ***********************************************/

options nocenter nodate ls=64 pageno=1 formdlim='=';
title "Generate Regression Data Set";
* generate a 10 observation data set with Y~N(3+2x,0.5^2);
data test;  
  call streaminit(0);
  do X=1 to 10;
     Y=3+2*X+0.5*RAND('NORMAL');
     output;
  end;
run;

proc print data=test; 
run;

/************************************** Display 3.7 ***********************************************/

options formdlim='=' pageno=1 ls=64 nocenter nodate;
data d1;
  input x y @@;
  format y dollar6.2;
  datalines;
1 2 4 3  5  6 12345 123456
;
run;

proc print data=d1;
   title "Y formatted in DATA";
run;

proc print data=d1;
  title2 "X now formatted in the 2nd PROC PRINT"; 
  format x dollar12.2;
run;

proc print data=d1;
  title2;
run;


/************************************** Display 3.9 ***********************************************/

  value totfmt     0='none'
              1-HIGH='some';
run;

data nitro_tox;
   infile 'C:\Users\baileraj.IT\desktop\DT-Book 3\ch2-dat.txt '
         firstobs=16 expandtabs missover pad ;
   input @9 animal 2.  @17 conc 3. @25 brood1 2.
         @33 brood2 2. @41 brood3 2. @49 total 2.;

   cbrood3 = brood3;
   format cbrood3 totfmt.;
   label animal = 'animal ID number';
   label   conc = 'Nitrofen concentration';
   label brood1 = 'number of young in first brood';
   label brood2 = 'number of young in 2nd brood';
   label brood3 = 'number of young in 3rd brood';
   label  total = 'total young produced in three broods';
run;

proc print data=nitro_tox;
  where conc=235;
run;

/************************************** Display 3.15 ***********************************************/

%let DATA_DIR = C:\Users\baileraj.IT\Desktop;
%let OLD_DIR = M:\public.www\classes\sta402\SAS-programs;

data nitro_tox;
   infile "&DATA_DIR\ch2-dat.txt"
         firstobs=16 expandtabs missover pad ;
   input @9 animal 2.  @17 conc 3. @25 brood1 2.
         @33 brood2 2. @41 brood3 2. @49 total 2.;
run;

* ods rtf bodytitle file="&DATA_DIR\Display-3.15.rtf";
ods listing image_dpi=300;
ods graphics / width=4.5in;
proc sgplot data=nitro_tox;  * Display 3.16;
  hbar conc / response=total stat=mean limits=both limitstat=stddev numstd=2;
run;

proc sgplot data=nitro_tox; * Display 3.17;
  dot animal / response=total group=conc;
run;

ods graphics off;
 * ods rtf close;

/************************************** Display 3.18 ***********************************************/

%let DATA_DIR = C:\Users\baileraj.IT\Desktop;
proc format;
  value totfmt     0='none'
              1-HIGH='some';
run;

data nitro_tox;
   infile "&DATA_DIR\ch2-dat.txt"
         firstobs=16 expandtabs missover pad ;
   input @9 animal 2.  @17 conc 3. @25 brood1 2.
         @33 brood2 2. @41 brood3 2. @49 total 2.;
   cbrood3 = brood3;
   format cbrood3 totfmt.;
run;

* ods rtf bodytitle file="&DATA_DIR\Display-3.18.rtf";
ods listing image_dpi=300;
ods graphics / width=4.5in;

proc sgplot data=nitro_tox;   * Display 3.19;
  scatter y=total x=conc  / group=cbrood3;
run;

proc sgplot data=nitro_tox;   * Display 3.20;
  scatter y=brood1 x=conc;
  scatter y=brood2 x=conc;
  scatter y=brood3 x=conc;
run;

* add JITTER to concentration to separate points in the plot;
data nitro_tox3; set nitro_tox;
   jconc = conc + 20*RAND('UNIFORM') - 10;  
                  * add jitter to the concentration for plotting;
run;

proc sgplot data=nitro_tox3;   * Display 3.21;
  xaxis label = "Nitrofen concentration (jittered)";
  yaxis label = "Number of young";
  scatter y=brood1 x=jconc;
  scatter y=brood2 x=jconc;
  scatter y=brood3 x=jconc;
run;

ods graphics off;
* ods rtf close;


/************************************** Display 3.27 ***********************************************/

%let DATA_DIR = C:\Users\baileraj.IT\Desktop;
data nitro_tox;
   infile "&DATA_DIR\ch2-dat.txt"
         firstobs=16 expandtabs missover pad ;
   input @9 animal 2.  @17 conc 3. @25 brood1 2.
         @33 brood2 2. @41 brood3 2. @49 total 2.;
run;

*ods rtf style=journal bodytitle
     file="&DATA_DIR\Display-3.27.rtf";  * selecting gray scale style/ B&W;

ods listing image_dpi=300 style=journal;
ods graphics / width=4.5in;
proc sgplot data=nitro_tox;       * figure as often used in journal articles;
   histogram total;
   density total / type=kernel;
   keylegend / location=inside position=topleft;
run;
ods graphics off;

*ods rtf close;


/************************************** Display 3.29 ***********************************************/

options nodate nocenter nonumber;
%let DATA_DIR = C:\Users\baileraj.IT\Desktop;

data SMSA_from_txt;
  infile "C:\Users\baileraj.IT\Desktop\SMSA-DASL-2space-sep.txt" firstobs=2;
  length city $ 39; 
  input city & JanTemp JulyTemp RelHum Rain Mortality Education PopDensity 
      pct_NonWhite pct_WC pop pop_per_house income HCPot NOxPot S02Pot NOx;
run;

ods rtf bodytitle file="&DATA_DIR\Display-3.29.rtf";
proc univariate data=SMSA_from_txt;
  var JanTemp;
  id city;
run;
ods rtf close;


/************************************** Display 3.32 ***********************************************/


/*
  60 cities from the SMSA data set are read (cf.  Display 2.8)
*/

%let DATA_DIR = C:\Users\baileraj.IT\Desktop;

options nodate nocenter nonumber;
data SMSA_from_txt;
  infile "C:\Users\baileraj\Desktop\SMSA-DASL-2space-sep.txt" firstobs=2;
  length city $ 39; 
  input city & JanTemp JulyTemp RelHum Rain Mortality Education PopDensity 
        pct_NonWhite pct_WC pop pop_per_house income HCPot NOxPot S02Pot NOx;
run;

/*  DEBUG option - print out N=60 observations in the SMSA data set */
/*
proc print data=SMSA_from_txt;
  var city JanTemp JulyTemp RelHum NOxPot S02Pot NOx;
run;
*/

proc surveyselect data=SMSA_from_txt
     method=srs n=6 out=sample_SMSA_cities;
run;

ods rtf bodytitle file="&DATA_DIR\Display-3.32.rtf";
proc print data=sample_SMSA_cities;
  var city JanTemp JulyTemp RelHum NOxPot S02Pot NOx;
run;
ods rtf close

/************************************** Display 3.34 ***********************************************/

%let DATA_DIR = C:\Users\baileraj.IT\Desktop;

proc plan seed=776655;
title  "generate randomization/allocation";
title2 "assign:  4 treatments to 20 EUs";
  factors EU=20;
  output out=design_crd;
run;

data design_crd;
  set design_crd;
  if _n_ <= 5 then TRT=1;	   * assign first 5 observations to trt 1;
  else if _n_ <= 10 then TRT=2;  * assign next 5 obs. to trt 2;
  else if _n_ <= 20 then TRT=3;  * assign next 5 obs. to trt 3;
  else TRT=4;                    * assign last 5 obs. to trt 4;
run;

proc transpose data=design_crd out=t_design_crd prefix=C;
run;                             * transpose the data for printing;

ods rtf bodytitle file="&DATA_DIR\Display-3.34.rtf";
proc print data=t_design_crd;
run;
ods rtf close;



/************************************** Display 4.1 ***********************************************/


%let DATA_DIR=C:\Users\baileraj\BAILERAJ\Classes\Web-Classes\STA402\FALL-2007\data; 

data nitrofen;
  infile "&DATA_DIR\ch2-dat.txt" firstobs=16 expandtabs missover pad ;
  input @9 animal 2.   @17 conc 3.    @25 brood1 2.
        @33 brood2 2.  @41 brood3 2.  @49 total 2.;
run;

ods rtf BODYTITLE file="&DATA_DIR\Display-4.1.rtf";;
proc tabulate data=nitrofen format=3.;  * include default format for;
   class conc;                          *    numeric summaries; 
   var brood1 brood2 brood3 total;
   table (brood1 brood2 brood3 total)*conc, 
          n min q1 median*f=4.1 q3 max;
run;
ods rtf close;



/************************************** Display 4.3 ***********************************************/

%let DATA_DIR=C:\Users\baileraj.IT\BAILERAJ\Classes\Web-Classes\STA402\ data; 

data nitrofen;
  infile "&DATA_DIR\ch2-dat.txt" firstobs=16 expandtabs missover pad ;
  input @9 animal 2.   @17 conc 3.    @25 brood1 2.
        @33 brood2 2.  @41 brood3 2.  @49 total 2.;
run;
ods rtf BODYTITLE file="&DATA_DIR\Display-4.3.rtf";
proc tabulate data=nitrofen;
   var brood1 brood2 brood3 total;
   table brood1 brood2 brood3 total, n min q1 median q3 max;
run;
ods rtf close;


/************************************** Display 4.6 ***********************************************/

%let topdir = C:\Users\baileraj.IT\BAILERAJ\;    * go ahead and check out;
%let subdir = Classes\Web-Classes\sta402\data\;  * macro variables in Ch 10;
 data country; 
title 'country data analysis';
infile "&topdir.&subdir.country.data";
input  name $ area popnsize pcturban lang $ liter lifemen
         lifewom pcGNP;
 logarea = log10(area);
 logpopn = log10(popnsize);
 loggnp  = log10(pcGNP);
 density = popnsize/area;     * construct density variable;
 ienglish = (lang="English");
 drop area popnsize pcGNP;
run;

proc univariate data=country;  * calculate %tiles of density;
  var density;
  id name;
  output out=cstats Q1=P_25 Q3=P_75;  * output to data set – cstats;
*  output out=cstats2 pctlpts=25 75 pctlpre=P_;  * equivalent;
run;

proc print data=cstats;  * check of summary stat data;
run;
/* the CSTATS data set . . . 
Obs      P_75       P_25
1     0.40881    0.046858
*/

data country;        * adding Q1 and Q3 to each line of the country data set; 
  retain P_25 P_75;      * keep values of Q1 and Q3 around to be assigned;  
  if _n_=1 then set cstats;  * read and process CSTATS data set first;
     set cstats;
  set country;
run;

* you need to be somewhat careful in defining categories if any missing;
*     values are present (see Section 8.3) – not a problem in this example;
data country; set country;    * define density categorical var;
  if density <= P_25 then density_cat=1;       * [min, Q1];
  else if density <= P_75 then density_cat=2;  * (Q1, Q3];
  else density_cat=3;                        * (Q3, max];
run;
* aside:  could hard code Q1/Q3 but the solution above is a bit slicker and 
          avoids the possibility of transcription error, is robust to 
          underlying data changes when program is rerun;

proc freq data=country;   * check construction of density category variable; 
  table density_cat;
run;

* additional check suggested by Kathy Roggenkamp;
proc means data=country n nmiss min max;
  class density_cat / missing;
  var density;
run;

ods rtf BODYTITLE file="&topdir\Display-4.6.rtf";
proc tabulate data=country;
  class density_cat;
  var lifemen lifewom liter loggnp;
  table (lifemen lifewom liter loggnp)*(n nmiss mean median stddev), density_cat; 
run;
ods rtf close;


/************************************** Display 4.9 ***********************************************/

/* using the COUNTRY data set constructed in DISPLAY 4.6 */

/*  set up formats for the density categories */
proc format;
  value dfmt  1="Least Dense 25%"
              2="Middle 50%"
              3="Most Dense 25%";
run;

options nodate nonumber;
%let outdir = C:\Users\baileraj\Desktop;
ODS RTF  file="&outdir\tab.rtf";
ODS PDF  file="&outdir\tab.pdf";
ODS HTML file="tab.html" path="&outdir";

proc tabulate data=country format=4.1;
  class density_cat;
  var lifemen lifewom liter loggnp;
  format density_cat dfmt.;
  table (lifemen="Life Expectancy (Men)" 
         lifewom="Life Expectancy (Women)"
         liter="% Literate" loggnp="Log10 GNP")*
        (n="# countries"*f=2. mean="Mean"
         median="Median" stddev="Std. Dev."), 
         density_cat="Population Density";
run;

ODS  RTF CLOSE;
ODS PDF CLOSE;
ODS HTML CLOSE;


/************************************** Display 4.11 ***********************************************/

/* using the COUNTRY data set constructed in DISPLAY 4.6 */

/*  set up formats for the density categories */
proc format;
  value dfmt  1="Least Dense 25%"
              2="Middle 50%"
              3="Most Dense 25%";
run;

%let outdir = C:\Users\baileraj.IT\Desktop;
ODS HTML path="&outdir"
         body = 'country-body.html'      /* Output objects    */
         contents = 'country-TOC.html'   /* Table of contents */
         frame = 'country-frame.html'    /* organizes display */
         newfile = NONE;                 /* all results to one file*/

title "country data analysis";

proc univariate data=country;  * calculate %tiles of density;
  var density;
  id name;
run;

proc tabulate data=country format=4.1;
  class density_cat;
  var lifemen lifewom liter loggnp;
  format density_cat dfmt.;
  table (lifemen="Life Expectancy (Men)" 
         lifewom="Life Expectancy (Women)"
         liter="% Literate" loggnp="Log10 GNP")*
        (n="# countries"*f=2. mean="Mean"
         median="Median" stddev="Std. Dev."), 
         density_cat="Population Density";
run;

proc sgplot data=country;
  scatter x=liter y=lifewom;
  label lifewom="Life Expectancy (Women)";
  label liter="% literacy in population";
run;
ods html close;



/************************************** Display 4.15 ***********************************************/

data simreg;
  beta0 = 3; * Simulate Y ~ N( 3 + 1.5 X, sigma = 2);
  beta1 = 1.5;
  sigma = 2;
  call streaminit(54321);
    do nobs = 1 to 2;
      do x = 1 to 10;
        y = beta0 + beta1*x + sigma*RAND('Normal');
	  output;
	end;
    end;
run;

ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\Display-4.15.rtf"; 
proc print data=simreg;
run;
ods rtf close;


/************************************** Display 4.21 ***********************************************/

data simreg;
  beta0 = 3;  * Simulate Y ~ N(3 + 1.5 X, sigma = 2);
  beta1 = 1.5;
  sigma = 2;
  call streaminit(54321);
  do iexpt = 1 to 2000;  * generate 2000 samples/experiments with 20 (x,y) observations; 
    do nobs = 1 to 2;    *   with 2 replicates at x=1 to 10 by 1;
      do x = 1 to 10;
        y = beta0 + beta1*x + sigma* RAND('Normal');
		output;
	  end;
	end;
  end;
run;

proc print data=simreg;
title "first 2 experiments from the SIMREG data set";
  where iexpt<=2;
run;

ods output ParameterEstimates=ParmEst;
proc sort data=simreg;
     by iexpt;
run;
proc reg data=simreg;
     by iexpt;
  model y = x;
run;
ods output close;

proc print data=ParmEst;
title "first 2 experiments from the PARMEST data set";
  where iexpt<=2;
  var iexpt Variable Estimate;
run;

data ParmEst2; set ParmEst;
  retain b0;
  if variable="Intercept" then b0 = estimate; 
  else do;
    b1 = estimate;
    keep iexpt b0 b1;
    output;
  end;
run;

proc print data=ParmEst2;  * a nice debugging check;
title "first 5/last 5 lines from the PARMEST2 data set";
  where iexpt <= 5 or iexpt >1995;
run;

ods listing image_dpi=300;
ods graphics / width=4.5in;
ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\Display-4.20.rtf";
proc means data=ParmEst2;
  title;
  var b0 b1;
run;
proc sgplot data=ParmEst2;
  scatter x=b1 y=b0;
  ellipse x=b1 y=b0;  * 95% confidence ellipse;
run;
ods graphics off;
ods rtf close;


/************************************** Exercise 4.1 ***********************************************/

options formdlim="-";
data junk;
  input group $ type $ var1 var2;
  datalines;
a y 1 100
a y 2 102
a z 3 110
a z 4 112
b y 10 1001
b y 11 1011
b z 20 1200
b z 21 1210
;
run;

proc print data=junk;
run;

proc tabulate data=junk;
  var var1;
  class group type;
  table group*type,var1*mean;
run;

proc tabulate data=junk;
  var var1;
  class group type;
  table group,type*var1*mean;
run;

proc tabulate data=junk;
    var var1 var2;
    class group;
    table (var1 var2)*mean, group;
run;

proc tabulate data=junk;
    var var1 var2;
    class group;
    table (var1 var2)*(n mean), group;
run;


/************************************** Exercise 4.4 ***********************************************/

data simdata;
  call streaminit(45056);
  do isample = 1 to 1500;  * # samples = 1500;
    do iobs = 1 to 25;     * # sample size=25;
	  y = RAND('uniform');
	  output;
	end;
  end;
run;


/************************************** Display 5.1 ***********************************************/


data manatee_deaths;
  input year nboats manatees @@;
  datalines;
77	447	13  78	460	21   79	481	24   80	498	16
81	513	24  82	512	20   83	526	15   84	559	34
85	585	33  86	614	33   87	645	39   88	675	43
89	711	50  90	719	47
;
run;

ODS RTF file= "C:\Users\baileraj.IT\Desktop\linreg-output.rtf" bodytitle; 
ods listing image_dpi=300;
ods graphics / width=4.5in;

proc reg data=manatee_deaths;
  model manatees = nboats / p r cli clm;
  output out=man_pred p=yhat r=resid;
run;

proc sgplot data=man_pred;   *  Y vs. X plot with;
  reg x=nboats y=manatees;   *     pred. reg. line and;
  loess x=nboats y=manatees; *     loess fit superimposed;
run;

proc sgplot data=man_pred;   *  Y vs. X plot with;
  reg x=nboats y=manatees/clm cli; * pred. reg. line and;
run;                               * and conf/pred limits;

proc sgplot data=man_pred;
  loess x=yhat y=resid;      * residuals vs. predicted ;
  refline 0 / axis=y;        *  plot with e=0 reference;
run;
proc sgplot data=man_pred;
  histogram resid;              * histogram of residuals;
  density resid / type=normal;  *   with normal density;
run;
ods graphics off;
ODS RTF CLOSE;


/************************************** Display 5.9 ***********************************************/

data mrexample;
* Lunneborg (2000) - body weight brain example;
  input species $ bodywt brainwt @@;

  logbody = log10(bodywt);     * transform the body and brain weights;
  logbrain = log10(brainwt);

  idino = 0;                   * define the indicator of dinosaurs;
  if (species="diplodoc" or species="tricerat" or species="brachios") then
    idino=1;
  idinobod = idino*logbody;

  datalines;
beaver        1.35   8.1     cow       465.  423.   wolf        36.33  119.5 
goat          27.66  115.    guipig    1.04  5.5    diplodocus  11700. 50. 
asielephant   2547.  4603.   donkey    187.1 419.   horse       521.   655. 
potarmonkey   10.    115.    cat       3.30  25.6   giraffe     529.   680. 
gorilla       207.   406.    human     62.   1320.  afrelephant 6654.  5712. 
triceratops   9400.  70.     rhemonkey 6.8   179.   kangaroo    35.    56. 
hamster       0.12   1.      mouse     0.023 0.4    rabbit      2.5    12.1 
sheep         55.50  175.    jaguar    100.  157.   chimp       52.16  440. 
brachiosaurus 87000. 154.5   rat       0.28  1.9    mole        0.122  3. 
pig           192.0  180
;
run;

ODS RTF file='D:\baileraj\SAS-Book\SAS-programs\mreg-output.rtf';
proc print data=mrexample;     * check to see if indicators properly defined;
  title 'brain wt - body wt data';
run;

proc univariate data=mrexample;    * descriptive statistics for these data;
  var bodywt brainwt;   id species;
run;

proc reg data=mrexample;   * simple linear regression -  s ame slope/intercept;
  title2 'allometric scaling - brain and body wt. ';   title3 ' [All Species combined] ';
  model logbrain=logbody;
run;

proc reg data=mrexample;     * different intercepts;
  title2 'Dinosaurs fitted with potentially different INTERCEPTS';
  model logbrain=logbody idino;
run;

ODS RTF CLOSE;


/************************************** Display 5.14 ***********************************************/

data mrexample;
* Lunneborg (2000) - body weight brain example;
  input species $ bodywt brainwt @@;

  logbody = log10(bodywt);     * transform the body and brain weights;
  logbrain = log10(brainwt);

  idino = 0;                   * define the indicator of dinosaurs;
  if (species="diplodoc" or species="tricerat" or species="brachios") then
    idino=1;
  idinobod = idino*logbody;

  datalines;
beaver        1.35   8.1     cow       465.  423.   wolf        36.33  119.5 
goat          27.66  115.    guipig    1.04  5.5    diplodocus  11700. 50. 
asielephant   2547.  4603.   donkey    187.1 419.   horse       521.   655. 
potarmonkey   10.    115.    cat       3.30  25.6   giraffe     529.   680. 
gorilla       207.   406.    human     62.   1320.  afrelephant 6654.  5712. 
triceratops   9400.  70.     rhemonkey 6.8   179.   kangaroo    35.    56. 
hamster       0.12   1.      mouse     0.023 0.4    rabbit      2.5    12.1 
sheep         55.50  175.    jaguar    100.  157.   chimp       52.16  440. 
brachiosaurus 87000. 154.5   rat       0.28  1.9    mole        0.122  3. 
pig           192.0  180
;
run;

data mrexample2;
  set mrexample;
  same_int_fit = 1.10958 + 0.49599*logbody;  
  reg_fit = 0.93879 + 0.74855*logbody-2.26674*idino;
run;

proc format;
  value dinof 0="Mammal"
              1="Dinosaur";
run;

ods listing image_dpi=300;
ods graphics on / reset=all width=4.5in;
proc sgplot data=mrexample2;  * same intercept fit;
  scatter x=logbody y=logbrain / group=idino;
  series x=logbody y=same_int_fit;
  format idino dinof.;
run;

proc sgplot data=mrexample2;  * different intercept fit;
  scatter x=logbody y=logbrain / group=idino;
  series x=logbody y=reg_fit / group=idino;
  format idino dinof.;
run;

proc glm data=mrexample;
  class idino;
  model logbrain = idino logbody;
  format idino dinof.;
run;

/************************************** Display 5.17 ***********************************************/

/* Bacteria in meat under 4 different conditions     */
options ls = 75;
data meat;
  input condition $ logcount @@;
  datalines;
Plastic	7.66	 Plastic 6.98	 Plastic 7.80	
Vacuum	5.26	 Vacuum	 5.44	 Vacuum	 5.80	
Mixed	7.41	 Mixed	 7.33	 Mixed	 7.04	
Co2	3.51	 Co2	 2.91	 Co2	 3.66	
;
run;

title "bacteria growth under 4 packaging conditions";

ODS RTF file='C:\Users\baileraj.IT\Desktop\oneway-output.rtf';
ods listing image_dpi=300;
ods graphics on / width=4.5in;
proc sgplot data=meat;                * graphical comparisons;
  vbox logcount / category=condition;
run;
                    
proc glm data=meat order=data plot(unpack)=diagnostics;
  title2 "fitting the one-way anova model via GLM";
  class condition;
  model logcount = condition;
  means condition / bon tukey scheffe cldiff lines;
  lsmeans condition / cl pdiff;
  lsmeans condition / cl pdiff adjust=Tukey;
  contrast 'plastic vs. rest' condition 3 –1 –1 –1; 
  output out=new p=yhat r=resid stdr=eresid;
run;

proc sgplot data=new;     * plots for model checking;
  title2 "residual analyses";
  scatter x=yhat y=resid;
  refline 0 / axis=y; 
run;

proc univariate data=new noprint;
  histogram resid / normal;
  qqplot resid / normal;
run;
ods graphics off;

ODS RTF CLOSE;

/************************************** Display 5.25 ***********************************************/

data twoway;
  input response factor1 $ factor2 $ @@;
  datalines;
 5 1 1   7 1 1 
10 1 2  11 1 2  12 1 2
 8 2 1   9 2 1  10 2 1 
13 2 2  14 2 2  15 2 2 
 ;
run;

ods rtf bodytitle;
proc means data=twoway maxdec=1;
  class factor1 factor2 ;         * calculate cell means;
  var response;  
run;

proc means data=twoway maxdec=1;
  class factor1  ;                * calculate factor 1 level means;
  var response;                   * (pool over factor 2 levels);
run;
proc means data=twoway maxdec=1;
  class factor2 ;                 * calculate factor 2 level means;
  var response;                   * (pool over factor 1 levels);
run;

proc glm data=twoway;
  class factor1 factor2;
  model response = factor1 | factor2;
  means factor1 factor2 ;
  lsmeans factor1 factor2;
run;
ods rtf close;


/************************************** Exercise 5.3 ***********************************************/

proc glm data=meat order=data;
title2 fitting the one-way anova model via GLM;
  class condition;
  model logcount = condition/solution;
  means condition;
run;

/************************************** Display 6.1 ***********************************************/

data cubic;
  call streaminit(8675309);
  do nrep=1 to 3;
    do x=1 to 10;
	   response = 3 + 1*x - .5*x**2 + .05*x**3 + rand('normal',0,1.5);
       output;
	end;
  end;
run;

ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\fig6p1.rtf" ;
ods trace on;
ods graphics on;
proc reg data=cubic;
  model response = x;
run;
ods graphics off;
ods trace off;
ods rtf close;


* code from body of chapter ... ;
ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\fig6p1.rtf"; 
ods graphics on;
proc reg data=cubic plots(only)=DFBETAS;
  model response = x;
run;
ods graphics off;
ods rtf close;

* Two separate graphs with DFBETAS are produced if the plots are unpacked;
ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\fig6p1.rtf"; 
ods graphics on;
proc reg data=cubic plots(only)=DFBETAS(unpack);
  model response = x;
run;
ods graphics off;
ods rtf close;

/* select table with the parameter estimates (ParameterEstimates) and 
  graphic with predicted line and confidence and prediction intervals (FitPlot) */
ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\fig6p1.rtf"; 
ods graphics on;
proc reg data=cubic;
  ods select ParameterEstimates FitPlot; 
  model response = x;
run;
ods graphics off;
ods rtf close;

/************************************** Display 6.8 ***********************************************/

data cubic;
  call streaminit(8675309);
  do nrep=1 to 3;
    do x=1 to 10;
	  response=3+1*x-.5*x**2 +.05*x**3 + rand('normal',0,1.5);
       output;
	end;
  end;
run;

ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\hist-default.rtf";
ods graphics on;
proc reg data=cubic plots(only)=RESIDUALHISTOGRAM;
  model response = x;
run;
ods graphics off;
ods rtf close;

ods rtf bodytitle style=STATISTICAL  file="C:\Users\baileraj.IT\Desktop\hist-statistical.rtf"; 
ods graphics on;
proc reg data=cubic plots(only)=RESIDUALHISTOGRAM;
  model response = x;
run;
ods graphics off;
ods rtf close;

ods rtf bodytitle style=JOURNAL2 file="C:\Users\baileraj.IT\Desktop\hist-journal2.rtf"; 
ods graphics on;
proc reg data=cubic plots(only)=RESIDUALHISTOGRAM;
  model response = x;
run;
ods graphics off;
ods rtf close;

ods rtf bodytitle style=ANALYSIS file="C:\Users\baileraj.IT\Desktop\hist-analysis.rtf"; 
ods graphics on;
proc reg data=cubic plots(only)=RESIDUALHISTOGRAM;
  model response = x;
run;
ods graphics off;
ods rtf close;

/************************************** Display 6.10 ***********************************************/

proc template; 
  source  Stat.REG.Graphics.ResidualHistogram;
run;

/*
define statgraph Stat.REG.Graphics.ResidualHistogram;
   notes "Residual Histogram";
   dynamic _DEPNAME _MODELLABEL;
   BeginGraph;
      entrytitle halign=left textattrs=GRAPHVALUETEXT _MODELLABEL
                 halign=center textattrs=GRAPHTITLETEXT
                 "Distribution of Residuals" " for " _DEPNAME;
      layout overlay / xaxisopts=(label="Residual")
                       yaxisopts=(label="Percent");
         histogram RESIDUAL / primary=true;
         densityplot RESIDUAL / name="Normal" legendlabel="Normal" 
                                lineattrs=GRAPHFIT;
         densityplot RESIDUAL / kernel () name="Kernel" 
                                legendlabel="Kernel" 
                                lineattrs=GRAPHFIT2;
         discretelegend "Normal" "Kernel" / across=1 location=inside 
                        autoalign=(topright topleft top);
      endlayout;
   EndGraph;
end;
*/

/************************************** Display 6.11 ***********************************************/

proc template;
define statgraph Stat.REG.Graphics.ResidualHistogram;
   notes "Residual Histogram";
   dynamic _DEPNAME _MODELLABEL;
   BeginGraph;
      entrytitle halign=left textattrs=GRAPHVALUETEXT _MODELLABEL 
                 halign=center textattrs=GRAPHTITLETEXT
                 "Distribution of Residuals" " for " _DEPNAME;
      layout overlay / xaxisopts=(label="Residual" 
                                  linearopts=(viewmin=-10 viewmax=10
                                              tickvaluelist=(-10 0 10))
                                  offsetmin=0.1 offsetmax=0.1)
                                
                       yaxisopts=(label="Relative Frequency (%)");
      referenceline x=0;
      histogram RESIDUAL / primary=true;
      densityplot RESIDUAL / name="Normal" legendlabel="Normal"
                  lineattrs=GRAPHFIT;
      densityplot RESIDUAL / kernel () name="Kernel" legendlabel="Kernel" 
                  lineattrs=GRAPHFIT2;
      discretelegend "Normal" "Kernel" / across=1 location=inside 
                     autoalign=(topright topleft top);
      endlayout;
   EndGraph;
end;

ods rtf bodytitle style=SCIENCE file="C:\Users\baileraj.IT\Desktop\fig6p11.rtf";
ods graphics on;
proc reg data=cubic plots(only)= RESIDUALHISTOGRAM;
  model response = x;
run;
ods graphics off;
ods rtf close;

* to delete this new template definition;
proc template; 
  delete  Stat.REG.Graphics.ResidualHistogram;
run;



/************************************** Display 6.13 ***********************************************/

data manatee_deaths;
  input year nboats manatees @@;
  datalines;
77 447 13  78 460 21   79 481 24   80 498 16
81 513 24  82 512 20   83 526 15   84 559 34
85 585 33  86 614 33   87 645 39   88 675 43
89 711 50  90 719 47
 ;

ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\manatee-plots.rtf";
proc reg data=manatee_deaths;
  title '# Manatees killed regressed on the number of boats registered (FL)';  
  model  manatees = nboats;
  output out=regres r=resid;
run;

proc sgplot data=manatee_deaths;
  title2 "residual plot from the linear model fit";
  regression x=nboats y=manatees;
  loess x=nboats y=manatees;
run; 

proc sgplot data=regres;
  title2 "plot residuals vs. predictor variable (loess fit)";
  loess x=nboats y=resid;
  run;
ods rtf close;


/************************************** Display 6.16 ***********************************************/

data nitrofen; 
  infile 'C:\Users\baileraj\Desktop\ch2-dat.txt' firstobs=16 expandtabs missover pad ;  
  input @9 animal 2. @17 conc 3. @25 brood1 2. @33 brood2 2. @41 brood3 2. @49 total 2.; 
run;

data nitrofen2; set nitrofen;
  brood = 1; young=brood1; output;
  brood = 2; young=brood2; output;
  brood = 3; young=brood3; output;
  keep conc brood young;
run;

ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\nitrofen-plots.rtf" ;
proc sgpanel data=nitrofen2;
title "Brood-specific LOESS fits";
  panelby brood;
  loess x=conc y=young;
run;
ods rtf close;

/************************************** Display 6.18 ***********************************************/

data nitrofen; 
  infile 'C:\Users\baileraj.IT\Desktop\ch2-dat.txt' firstobs=16 expandtabs missover pad ;  
  input @9 animal 2. @17 conc 3. @25 brood1 2. @33 brood2 2. @41 brood3 2. @49 total 2.; 
run;

ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\nitrofen-dotplots.rtf" ;
proc sgpanel data=nitrofen;
title "dot plots";
  panelby conc / layout=panel novarname columns=5;
  dot total;
run;
ods rtf close;

/************************************** Display 6.20 ***********************************************/

data nitrofen; 
  infile 'C:\Users\baileraj.IT\Desktop\ch2-dat.txt' firstobs=16 expandtabs missover pad ;  
  input @9 animal 2. @17 conc 3. @25 brood1 2. @33 brood2 2. @41 brood3 2. @49 total 2.; 
run;

title;
  
ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\nitrofen-plots2.rtf" ;
proc sgscatter data=nitrofen;
  plot (brood1 brood2 brood3 total)*conc / loess uniscale=ALL;
* UNISCALE option ensures axis scales are uniform for better comparison;
run;
ods rtf close;

/************************************** Display 6.22 ***********************************************/

options formdlim="-" nodate;

data SMSA_from_txt;  * from Display 2.8;
  infile "C:\Users\baileraj.IT\Desktop\SMSA-DASL-2space-sep.txt" firstobs=2;
  length city $ 39; 
  input city & JanTemp JulyTemp	RelHum Rain	Mortality Education PopDensity 
        pct_NonWhite pct_WC pop pop_per_house income HCPot NOxPot S02Pot NOx;
run;

/*  extract and save the 5 number summary for Jan. Temps */
proc univariate data=SMSA_from_txt;
  var JanTemp;
  output out=JanSumOut min=Jmin Q1=JQ1 Median=JQ2 Q3=JQ3 max=Jmax;
run;

/*  assign the 5 number summaries (min,Q1,M,Q3,max) to macro variables */
/*  (see Ch. 10 for more on Macro magic)                               */
data _null_; 
  set JanSumOut;
  call symputx('M_Jmin', Jmin);
  call symputx('M_JQ1', JQ1);
  call symputx('M_JQ2', JQ2);
  call symputx('M_JQ3', JQ3);
  call symputx('M_Jmax', Jmax);
  %put _user_;
run;

/*  create informative formats for later displays */
proc format;
   value gt32F 0="below freezing" 
               1="above freezing";
   value JTemp 1 = "&M_Jmin <= Jan. Temp. (F) <= &M_JQ1"
               2 = "&M_JQ1 < Jan. Temp. (F) <= &M_JQ2"
               3 = "&M_JQ2 < Jan. Temp. (F) <= &M_JQ3"
               4 = "&M_JQ3 < Jan. Temp. (F) <= &M_Jmax";
run;

/*  define and add a variable indicating Jan. temps > 32 deg F and a variable */
/*       containing the Jan. temp quartile category */
data SMSA_from_txt;
  set SMSA_from_txt;

  freezing = (JanTemp>32);
  label freezing="Temp. in January";
  format freezing gt32F.;

  if &M_Jmin < JanTemp <= &M_JQ1 then JanTemp_quart=1;
  else if JanTemp <= &M_JQ2 then JanTemp_quart=2;
  else if JanTemp <= &M_JQ3 then JanTemp_quart=3;
  else if JanTemp <= &M_Jmax then JanTemp_quart=4;
 
  label JanTemp_quart="Interval:";
  format JanTemp_quart JTemp.;
run;

/*  debugging check to see if variables correctly defined */
proc print data=SMSA_from_txt;
  var JanTemp JanTemp_quart freezing;
run;

/*  define set of graphics */
ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\SMSA-plots.rtf" ;

* Display 6.23: HISTOGRAM of Jan. Temp.;
proc sgplot data=SMSA_from_txt;  
  histogram JanTemp;
  density JanTemp / type=kernel;
run;

* Display 6.24:  Scatter plot of Mortality vs. Education;
proc sgplot data=SMSA_from_txt;  
  scatter x=Education y=Mortality;
run;

* Display 6.25: Scatter plots with shared y-axis for comparison;
proc sgscatter data=SMSA_from_txt;  
  compare y=Mortality x=(Education income JanTemp) / loess;
run;

* Display 6.26: Scatter plot matrix;
proc sgscatter data=SMSA_from_txt; 
  matrix Mortality Education income JanTemp / diagonal=(histogram);
run;

* Display 6.27:  Separate scatter plots for levels of other variables; 
proc sgpanel data=SMSA_from_txt noautolegend;  * to suppress legend;
  panelby freezing;
  loess x=Education y=Mortality;
run;

* Display 6.28: Same plot with diff. symbols and line types for diff var levels;
proc sgplot data=SMSA_from_txt;  
  loess x=Education y=Mortality / group=freezing;
run;

* Display 6.29: scatter plot paneled by constructed quartile variable;
proc sgpanel data=SMSA_from_txt; 
  panelby JanTemp_quart;
  loess x=Education y=Mortality;
run;

ods rtf close;


/************************************** Display 7.1 ***********************************************/

data cointoss;
  retain num_heads 0;
  call streaminit(1234567);
  do itoss = 1 to 1200;
     outcome = RAND('Bernoulli', 0.50);
     num_heads = num_heads + (outcome=1);
     probability_heads = num_heads / itoss ;
     output;
  end;
goptions reset=global;
ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\fig7p1.rtf" ;
proc gplot;
  plot probability_heads*itoss;
  run;
ods rtf close;


/************************************** Display 7.3 ***********************************************/

data cointoss;
  retain num_heads 0;
  call streaminit(1234567);
  do itoss = 1 to 1200;
     outcome = RAND('Bernoulli', 0.50);
     num_heads = num_heads + (outcome=1);
     probability_heads = num_heads / itoss ;
     output;
  end;
run;

goptions reset=global;
symbol interpol=join;
axis1 order=0.35 to 0.65 by 0.05
      minor=NONE
      label=(angle=90 "Estimated Pr(HEADS)");
axis2 order=0 to 500 by 50
      minor=NONE
      label=("Number of simulated data points");

ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\cointoss-figs.rtf";
proc gplot data=cointoss;
  plot probability_heads*itoss / vaxis=axis1 haxis=axis2;
run;
quit;

/* SGPLOT alternatives suggested by Dan Heath   */

proc sgplot data=cointoss;
  xaxis label="Number of simulated data points"
        values=(0 to 500 by 50);
  yaxis label="Estimated Pr(HEADS)"
        values=(0.35 to 0.65 by 0.05);
  series x=itoss y=probability_heads;
run;

proc sgplot data=cointoss;
  xaxis label="Number of simulated data points"
        values=(0 to 500 by 50);
  yaxis label="Estimated Pr(HEADS)"
        values=(0.35 to 0.65 by 0.05);
  series x=itoss y=probability_heads / 
        lineattrs=(color=black thickness=2);
run;
ods rtf close;

/************************************** Display 7.6 ***********************************************/

data cointoss;
  retain num_heads 0;
  call streaminit(1234567);
  do itoss = 1 to 1200;
     outcome = RAND('Bernoulli', 0.50);
     num_heads = num_heads + (outcome=1);
     probability_heads = num_heads / itoss ;
     output;
  end;
run;

goptions reset=global;
symbol interpol=join;
axis1 order=0.35 to 0.65 by 0.05
      minor=NONE
      label=(angle=90 "Estimated Pr(HEADS)");
axis2 order=0 to 500 by 50
      minor=NONE
      label=("Number of simulated data points");

data myanno;
length function $ 8 text $ 45;
retain xsys "2" ysys "2";
 function="move";  x=0;   y=0.50; output;
 function="draw";  x=500; y=0.50; output;
 function="label"; x=350; y=0.48; 
     text="Long-term relative frequency of HEADS=0.50"; output; 
run;

ods rtf bodytitle
    file="C:\Users\baileraj\Desktop\cointoss2-graph.rtf";
proc print data=myanno;
run;

proc gplot data=cointoss;
  plot probability_heads*itoss / annotate=myanno
                                 vaxis=axis1 haxis=axis2;
run;
quit;
ods rtf close;

/************************************** Display 7.9 ***********************************************/

/* generate a profile of [OR, log(OR)] values */
data or_stuff;
  do or=0.01 to 5 by .01;
    logor = log(or);
      output;
  end;
run;

goptions reset=global; * often a good idea, especially if doing a lot of graphs;

/* interpolate btwn [OR, log(OR)] values and set up axes */
symbol interpol=join co=black;  * always specify color in symbol stmt;
axis1 label=("Odds Ratio");
axis2 label=(angle=90 "Log(Odds Ratio)");

/* set up annotate data set with arrows and text to illustrate the CI idea */
data myanno;
length function $ 8 text $ 7;   * good habit b/c max fcn length=8;
retain xsys "2" ysys "2" function SE;
 SE = .2;
 function="move"; x=2; y=-5; output; 
 function="arrow"; x=2; y=log(2); line=2; output; *from OR to logOR;
 function="arrow"; x=.01; y=log(2); output;      * back to y-axis;

 function="draw";  x=.01; y=log(2)+ 1.96*SE; output;  * upper CI;
 function="arrow"; x=exp(log(2)+ 1.96*SE); y=log(2)+ 1.96*SE; output;
 function="arrow"; x=exp(log(2)+ 1.96*SE); y=-4.5; output;

 function="move";  x=.01; y=log(2); output;   * lower CI;
 function="draw";  x=.01; y=log(2)- 1.96*SE; output; 
 function="arrow"; x=exp(log(2)- 1.96*SE); y=log(2)- 1.96*SE; output;
 function="arrow"; x=exp(log(2)- 1.96*SE); y=-4.5; output; 
 function="label";    
        x=exp(log(2)- 1.96*SE); y=-4.75; text="LCL OR"; output;
        x=exp(log(2)+ 1.96*SE); y=-4.75; text="UCL OR"; output;
        x=2.2; y=-2; text="Step 1";  output;
        x=1; y=log(2) + .25; text=" Step 2"; output;
        x=0.5; y= log(2)- 1.96*SE - .25; text="Step 3a"; output;
        x=0.5; y= log(2)+ 1.96*SE + .25; text="Step 3b"; output;
        x=3.2; y=-2; text="Step 4a";  output;
        x=1.2; y=-2; text="Step 4b";  position="<"; output; * right justify text; 
run;

/* produce the graph with annotation */
ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\fig7p9.rtf" ;
proc gplot data=or_stuff;
  plot logor * or / annotate=myanno haxis=axis1 vaxis=axis2;
run;
quit;
ods rtf close;


/************************************** Display 7.11 ***********************************************/

/* load the nitrofen data until a SAS data set is created*/
data nitrofen; 
infile 'C:\Users\baileraj.IT\Desktop\ch2-dat.txt' firstobs=16 expandtabs
        missover pad ; 
input @9 animal 2. @17 conc 3. @25 brood1 2. @33 brood2 2. 
      @41 brood3 2. @49 total 2.;
jconc =  conc + 15*ranuni(0) - 7.5;  * adding a little jitter to see points;
run;

proc print data=nitrofen;
run;

proc means data=nitrofen;  * obtain means that are hard coded below;
  var total;
  class conc;
run;

/* FIGURE 1:  Scatter plot with superimposed segments at group means */

/* set up axes and suppress the x-axis tick marks and labels */
goptions reset=global;
axis1 label=(angle=90 'Total number of young (3 broods)');
axis2 label=('Nitrofen Concentration')  order=(-20 to 340 by 20) 
      minor=none major=none v=none;

/* define annotate data set to draw mean segments and nitrofen conc. */
data myanno;
  length function $ 8 text $ 3;
  retain xsys '2' ysys '2';
  function="label"; x=0; y=2; text="0"; output;
  function="label"; x=80; y=2; text="80"; output;
  function="label"; x=160; y=2; text="160"; output;
  function="label"; x=235; y=2; text="235"; output;
  function="label"; x=310; y=2; text="310"; output;
  function='move'; x= 0 - 15;  y=31.4; output;    * conc=0;
  function='draw'; x= 0 + 15;  y=31.4; size=2; output;
  function='move'; x= 80 - 15;  y=31.5; output;   * conc=80;
  function='draw'; x= 80 + 15;  y=31.5; size=2; output;
  function='move'; x= 160 - 15;  y=28.3; output;  * conc=160;
  function='draw'; x= 160 + 15;  y=28.3; size=2; output;
  function='move'; x= 235 - 15;  y=17.2; output;  * conc=235;
  function='draw'; x= 235 + 15;  y=17.2; size=2; output;
  function='move'; x= 310 - 15;  y=6.0; output;   * conc=310;
  function='draw'; x= 310 + 15;  y=6.0; size=2; output;
run;

ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\fig7p11.rtf" ;
/* generate figure 1    */
proc gplot data=nitrofen;
  plot total*jconc / vaxis=axis1 haxis=axis2 annotate=myanno;
run;
quit;

/* FIGURE 2:  Scatter plot with superimposed box plots */

/* set up axes and suppress the x-axis tick marks and labels */
/*     and request box plot interpolations                   */
goptions reset=global;
axis1   label=(angle=90 'Total number of young (3 broods)');
axis2   label=('Nitrofen Concentration')  order=(-20 to 340 by 20) 
        minor=none major=none v=none;
symbol1 i=none v=dot color=black;
symbol2 interpol=box v=none color=black bwidth=8;

/* annotate data set for the concentration labels */
data myanno2;
  length function $ 8 text $ 3;
  retain xsys '2' ysys '2';
  function="label"; x=0; y=2; text="0"; output;
  function="label"; x=80; y=2; text="80"; output;
  function="label"; x=160; y=2; text="160"; output;
  function="label"; x=235; y=2; text="235"; output;
  function="label"; x=310; y=2; text="310"; output;
run;

/* generate figure 2    */
proc gplot data=nitrofen;
  plot total*jconc total*conc / overlay anno=myanno2 
                                vaxis=axis1 haxis=axis2 ;
run;
quit;
ods rtf close;

/************************************** Display 7.14 ***********************************************/
/* expanded .......................................................................................*/

proc gproject data=maps.counties out=OHIO_counties;
  where state eq 39;
  id state;
run;

/*
  Ohio County population sizes from 1900-1990  
http://www.census.gov/population/cencounts/oh190090.txt
Population of Counties by Decennial Census: 1900 to 1990
Compiled and edited by Richard L. Forstall 
                       Population Division
                       US Bureau of the Census
                       Washington, DC  20233
*/
data county_pop;
  length char_county $ 10;
  input county6 1-5 pop90 pop80 pop70 pop60 char_county &;
  county = county6-39000;  * removing state id from FIPS;
  datalines;
39001     25371     24328     18957     19982 Adams
39003    109755    112241    111144    103691 Allen
39005     47507     46178     43303     38771 Ashland
39007     99821    104215     98237     93067 Ashtabula
39009     59549     56399     54889     46998 Athens
39011     44585     42554     38602     36147 Auglaize
39013     71074     82569     80917     83864 Belmont
39015     34966     31920     26635     25178 Brown
39017    291479    258787    226207    199076 Butler
39019     26521     25598     21579     20857 Carroll
39021     36019     33649     30491     29714 Champaign
39023    147548    150236    157115    131440 Clark
39025    150187    128483     95725     80530 Clermont
39027     35415     34603     31464     30004 Clinton
39029    108276    113572    108310    107004 Columbiana
39031     35427     36024     33486     32224 Coshocton
39033     47870     50075     50364     46775 Crawford
39035   1412140   1498400   1721300   1647895 Cuyahoga
39037     53619     55096     49141     45612 Darke
39039     39350     39987     36949     31508 Defiance
39041     66929     53840     42908     36107 Delaware
39043     76779     79655     75909     68000 Erie
39045    103461     93678     73301     63912 Fairfield
39047     27466     27467     25461     24775 Fayette
39049    961437    869132    833249    682962 Franklin
39051     38498     37751     33071     29301 Fulton
39053     30954     30098     25239     26120 Gallia
39055     81129     74474     62977     47573 Geauga
39057    136731    129769    125057     94642 Greene
39059     39024     42024     37665     38579 Guernsey
39061    866228    873224    924018    864121 Hamilton
39063     65536     64581     61217     53686 Hancock
39065     31111     32719     30813     29633 Hardin
39067     16085     18152     17013     17995 Harrison
39069     29108     28383     27058     25392 Henry
39071     35728     33477     28996     29716 Highland
39073     25533     24304     20322     20168 Hocking
39075     32849     29416     23024     21591 Holmes
39077     56240     54608     49587     47326 Huron
39079     30230     30592     27174     29372 Jackson
39081     80298     91564     96193     99201 Jefferson
39083     47473     46304     41795     38808 Knox
39085    215499    212801    197200    148700 Lake
39087     61834     63849     56868     55438 Lawrence
39089    128300    120981    107799     90242 Licking
39091     42310     39155     35072     34803 Logan
39093    271126    274909    256843    217500 Lorain
39095    462361    471741    484370    456931 Lucas
39097     37068     33004     28318     26454 Madison
39099    264806    289487    303424    300480 Mahoning
39101     64274     67974     64724     60221 Marion
39103    122354    113150     82717     65315 Medina
39105     22987     23641     19799     22159 Meigs
39107     39443     38334     35265     32559 Mercer
39109     93182     90381     84342     72901 Miami
39111     15497     17382     15739     15268 Monroe
39113    573809    571697    606148    527080 Montgomery
39115     14194     14241     12375     12747 Morgan
39117     27749     26480     21348     19405 Morrow
39119     82068     83340     77826     79159 Muskingum
39121     11336     11310     10428     10982 Noble
39123     40029     40076     37099     35323 Ottawa
39125     20488     21302     19329     16792 Paulding
39127     31557     31032     27434     27864 Perry
39129     48255     43662     40071     35855 Pickaway
39131     24249     22802     19114     19380 Pike
39133    142585    135856    125868     91798 Portage
39135     40113     38223     34719     32498 Preble
39137     33819     32991     31134     28331 Putnam
39139    126137    131205    129997    117761 Richland
39141     69330     65004     61211     61215 Ross
39143     61963     63267     60983     56486 Sandusky
39145     80327     84545     76951     84216 Scioto
39147     59733     61901     60696     59326 Seneca
39149     44915     43089     37748     33586 Shelby
39151    367585    378823    372210    340345 Stark
39153    514990    524472    553371    513569 Summit
39155    227813    241863    232579    208526 Trumbull
39157     84090     84614     77211     76789 Tuscarawas
39159     31969     29536     23786     22853 Union
39161     30464     30458     29194     28840 Van Wert
39163     11098     11584      9420     10274 Vinton
39165    113909     99276     84925     65711 Warren
39167     62254     64266     57160     51689 Washington
39169    101461     97408     87123     75497 Wayne
39171     36956     36369     33669     29968 Williams
39173    113269    107372     89722     72596 Wood
39175     22254     22651     21826     21648 Wyandot
; 
run;

proc gmap data=county_pop
          map=OHIO_counties;
   id county;
   choro pop90;
   note '1990 Population Size (Source:  US Census)';
run;
quit;


/************************************** Display 8.1 ***********************************************/

data mrexample;
* Lunneborg (1994) - body weight brain example;
  input species $ bodywt brainwt @@;
datalines;
beaver        1.35   8.1     cow       465.  423.   wolf        36.33  119.5  
goat          27.66  115.    guipig    1.04  5.5    diplodocus  11700. 50.  
asielephant   2547.  4603.   donkey    187.1 419.   horse       521.   655.  
potarmonkey   10.    115.    cat       3.30  25.6   giraffe     529.   680.  
gorilla       207.   406.    human     62.   1320.  afrelephant 6654.  5712. 
triceratops   9400.  70.     rhemonkey 6.8   179.   kangaroo    35.    56.  
hamster       0.12   1.      mouse     0.023 0.4    rabbit      2.5    12.1  
sheep         55.50  175.    jaguar    100.  157.   chimp       52.16  440. 
brachiosaurus 87000. 154.5   rat       0.28  1.9    mole        0.122  3.  
pig           192.0  180 
beaver        1.35   8.1     cow       465.  423.   wolf        36.33  119.5  
goat          27.66  115.    guipig    1.04  5.5    diplodocus  11700. 50.  
asielephant   2547.  4603.   donkey    187.1 419.   horse       521.   655.  
potarmonkey   10.    115.    cat       3.30  25.6   giraffe     529.   680.  
gorilla       207.   406.    human     62.   1320.  afrelephant 6654.  5712. 
triceratops   9400.  70.     rhemonkey 6.8   179.   kangaroo    35.    56.  
hamster        0.12   1.      mouse     0.023 0.4    
rabbit      2.5    12.1   
sheep         55.50  175.    jaguar    100.  157.   chimp       52.16  440. 
brachiosaurus 87000. 154.5   rat       0.28  1.9    
mole        0.122  3. 
pig           192.0  180
;
run;

data mrexample2;
  length species $ 15;
  input species bodywt brainwt @@;
  datalines;
beaver        1.35   8.1     cow       465.  423.   wolf        36.33  119.5  
goat          27.66  115.    guipig    1.04  5.5    diplodocus  11700. 50.  
asielephant   2547.  4603.   donkey    187.1 419.   horse       521.   655.  
potarmonkey   10.    115.    cat       3.30  25.6   giraffe     529.   680.  
gorilla       207.   406.    human     62.   1320.  afrelephant 6654.  5712. 
triceratops   9400.  70.     rhemonkey 6.8   179.   kangaroo    35.    56.  
hamster       0.12   1.      mouse     0.023 0.4    rabbit      2.5    12.1  
sheep         55.50  175.    jaguar    100.  157.   chimp       52.16  440. 
brachiosaurus 87000. 154.5   rat       0.28  1.9    mole        0.122  3.  
pig           192.0  180 
beaver        1.35   8.1     cow       465.  423.   wolf        36.33  119.5  
goat          27.66  115.    guipig    1.04  5.5    diplodocus  11700. 50.  
asielephant   2547.  4603.   donkey    187.1 419.   horse       521.   655.  
potarmonkey   10.    115.    cat       3.30  25.6   giraffe     529.   680.  
gorilla       207.   406.    human     62.   1320.  afrelephant 6654.  5712. 
triceratops   9400.  70.     rhemonkey 6.8   179.   kangaroo    35.    56.  
hamster       0.12   1.      mouse     0.023 0.4    rabbit      2.5    12.1  
sheep         55.50  175.    jaguar    100.  157.   chimp       52.16  440. 
brachiosaurus 87000. 154.5   rat       0.28  1.9    mole        0.122  3 .   
pig           192.0  180 
;
run;

ods rtf file="C:\Users\baileraj.IT\Desktop\Display-7-02.rtf";
proc print data=mrexample;
  id species;
run;
proc print data=mrexample2;
  id species;
run;
ods rtf close;

/************************************** Display 8.3 ***********************************************/

data numeric_format_show;
/* character formatting illustrated first */
  test_num = 1277695.384;
  put 'BEST6. / BEST9. / BEST12.';
  put test_num BEST6.;
  put test_num BEST9.;
  put test_num BEST12.;
  put '-------------------------------';
  put 'COMMA7. / COMMA10.1 / COMMA11.3';
  put test_num COMMA7.;
  put test_num COMMA10.1;
  put test_num COMMA11.3;
  put '-------------------------------';
  put 'E7.';
  put test_num E7.;
  put '-------------------------------';
  put '7. / 10.1 / 11.3';
  put test_num 7.;
  put test_num 10.1;
  put test_num 11.3;
  put '-------------------------------';
  put 'DOLLAR9. / DOLLAR12.2';
  put test_num DOLLAR9.;
  put test_num DOLLAR12.2;
run;

/************************************** Display 8.5 ***********************************************/

data toyexample;
  input literacy @@;
  literacy_too = literacy;
  datalines;
-99 25.55 53 53.5 73.7 83  99.9 107 . 
;
run;

proc format;
  value literacyfmt       
                        0-53='First quartile'
                        53<-76='Second quartile'
                        76<-90 ='Third quartile'
                        90<-100='Fourth quartile'
                        . = 'Missing'
                        OTHER = 'Invalid';
run;

data toyexample2; set toyexample;
  format literacy literacyfmt.;

ods rtf file="C:\Users\baileraj.IT\Desktop\Display-8-05.rtf";
proc print data=toyexample2;
run; 

proc means data=toyexample2;
  var literacy literacy_too;
run;
ods rtf close;

/************************************** Display 8.8 ***********************************************/

data tester;
  input  @1 indate1 date7.  @9  indate2 date9. 
        @19 indate3 mmddyy. @26 indate4 ddmmyy8.;
;
datalines;
30jun10 30jun2010 063010 30.06.10
;
 run;

ods rtf file="C:\Users\baileraj.IT\Desktop\Display-8-08.rtf";
proc print data=tester;
run;
ods rtf close;

/************************************** Display 8.10 ***********************************************/

data tester2;
  input  @1 indate1 date7.  @9  indate2 date9. 
        @19 indate3 mmddyy. @26 indate4 ddmmyy8.;
  format _numeric_ date9.;
datalines;
30jun10 30jun2010 063010 30.06.10 
;
run;

ods rtf file="C:\Users\baileraj.IT\Desktop\Display-8-10.rtf";
proc print data=tester2;
run;
ods rtf close;

/************************************** Display 8.12 ***********************************************/

data date_format_show;
  start = 0;
  put start date9.;
  today = 17700;  * days since Jan 1, 1960;
  put '-------------------------------';
  put 'DATE7. / DATE9.';
  put today date7.;
  put today date9.;
  put '-------------------------------';
  put 'DAY2. / DAY7.';
  put today day2.;
  put today day7.;
  put '-------------------------------';
  put 'EURDFDD8.';
  put today eurdfdd8.;
  put '-------------------------------';
  put 'MMDDYY8. / MMDDYY6.';
  put today mmddyy8.;
  put today mmddyy6.;
  put '-------------------------------';
  put 'WEEKDATE15. / WEEKDATE29.';
  put today weekdate15.;
  put today weekdate29.;
  put '-------------------------------';
  put 'WORDDATE12. / WORDDATE18.';
  put today worddate12.;
  put today worddate18.;
run;

/************************************** Display 8.14 ***********************************************/

Data _NULL_;
 time_date_origin = 0;
 nowtime = '09:00't;
 today = '17jun2008'd; 
 put time_date_origin @20 time_date_origin datetime13.;
 put nowtime @20 nowtime time9.; 
 put today @20 today date9.;
run;

/************************************** Display 8.16 ***********************************************/

data test;
  input @1 date MMDDYY10. @21 time TIME8.  @31 money DOLLAR10.2;
  datalines;
01/01/1960          01:00:00  $100.22
09/29/2003          09:49:59  $12693.79
 ;
run;

ODS RTF file="C:\Users\baileraj.IT\Desktop\Display-8-16.rtf";
proc print data=test;
title "print of date and time w/o formatting – internal SAS representation"; 
  var date time money; 
run;

proc print data=test;
title "print of date and time w/ formatting";
  var date time;
  format date MMDDYY10. time TIME8. money DOLLAR10.2;
run;
ODS RTF CLOSE;

/************************************** Display 8.18 ***********************************************/

data nitrofen;
 infile 'C:\Users\baileraj.IT\Desktop\ch2-dat.txt' firstobs=16 expandtabs missover pad ; 
   input  @17 conc 3.  @49 total 2.;
   sqrt_total = sqrt(total);  * transformed response variable;
   cconc = conc - 157;        * construct mean-centered concentration;
   cconc2 = cconc*cconc;      * quadratic term;
run;

ods rtf BODYTITLE file="C:\Users\baileraj.IT\Desktop\Display-8-18.rtf";
ods graphics on;
proc reg data=nitrofen;
  model sqrt_total = cconc cconc2;  * fit the polynomial reg. model;
run;
ods graphics off;
ods rtf close;

/************************************** Display 8.20 ***********************************************/

options nodate formdlim="-";
data meat;
  input condition $ logcount @@;
  iPlastic = (condition= "Plastic");
  iVacuum = (condition= "Vacuum");
  iMixed = (condition= "Mixed");
  iCO2 = (condition= "Co2");
  datalines;
Plastic	7.66	 Plastic    6.98	 Plastic    7.80
Vacuum	5.26	 Vacuum	5.44	 Vacuum	5.80
Mixed	7.41	 Mixed	7.33	 Mixed	7.04
Co2	3.51	 Co2	       2.91	 Co2	      3.66
 ;
run;

title "bacteria growth under 4 packaging conditions";

ODS RTF bodytitle file="C:\Users\baileraj.IT\Desktop\Display-8-20.rtf";

proc print data=meat;
title "Print to check indicator variable construction";
run;

proc reg data=meat;
title "Regression with indicator variables: alt. to one-way anova model";
  model logcount = iPlastic iVacuum iMixed;
run;

proc glm data=meat;
title "One-way ANOVA model";
  class condition;
  model logcount = condition;
run;

ods rtf close;

/************************************** Display 8.22 ***********************************************/

  input literacy @@;

/* method 1-2:
   Boolean trick to assign category labels 1-4;
   If a logical comparison is TRUE (FALSE), it evaluates to 1 (0)
   e.g. if literacy=54, (53<literacy<=76)=TRUE while
        (0<literacy<=53)=(76<literacy<=90)=(90<literacy<=100)=FALSE
        And so cat_literacy = 1*0 + 2*1 + 3*0 + 4*0 = 2
*/

  cat_literacy1 = 1*(0<literacy<=53) + 2*(53<literacy<=76)
              + 3*(76<literacy<=90) + 4*(90<literacy<=100);

  cat_literacy2 = 1*(literacy<=53) + 2*(53<literacy<=76)
              + 3*(76<literacy<=90) + 4*(90<literacy<=100);

/*
  method 3:
  First check for nonmissing and valid ranges before Boolean trick
*/

  if ( (literacy NE .) AND (0<=literacy<=100) ) then 
     cat_literacy3 = 1*(literacy<=53) + 2*(53<literacy<=76)
                 + 3*(76<literacy<=90) + 4*(90<literacy<=100);

/* method 4:
   IF-THEN-ELSE blocks to assign category labels
*/

 if ( (literacy EQ .) OR (100<literacy)
                      OR (literacy<0) ) then cat_literacy4=.;
 else if (literacy <=53) then cat_literacy4=1;
 else if (literacy <=76) then cat_literacy4=2;
 else if (literacy <=90) then cat_literacy4=3;
 else cat_literacy4=4;

datalines;
-99 25.55 73.7 83  99.9 107 . 
;
run;

ods rtf file="C:\Users\baileraj.IT\Desktop\Display-8-22.rtf";
proc print data=toyexample;
run; 
ods rtf close;

/************************************** Display 8.24 ***********************************************/

data preced_test;
  x1a = 3*2**2;
  x1b = (3*2)**2;
  x2a = 3-2/2;
  x2b = (3-2)/2;
  x3a = -2**2;
  x3b = (-2)**2;
  put '-------------------------';
  put '| Order of operations   |';
  put '| illustrated           |';
  put '-------------------------';
  put '  3*2**2 = ' x1a;
  put '(3*2)**2 = ' x1b;
  put '   3-2/2 = ' x2a;
  put ' (3-2)/2 = ' x2b;
  put '   -2**2 = ' x3a;
  put ' (-2)**2 = ' x3b;
run;

/************************************** Display 8.26 ***********************************************/

data nitro;
 infile "C:\Users\baileraj.IT\Desktop\ch2-dat.txt" firstobs=16 expandtabs
         missover pad ;
input animal conc brood1 brood2 brood3 total;
run;

data nitrofen_A; set nitro;
  brood=1; count=brood1; conc=conc; output;
  brood=2; count=brood2; conc=conc; output;
  brood=3; count=brood3; conc=conc; output;
  keep animal brood count conc;
run;

ODS RTF file="C:\Users\baileraj.IT\Desktop\Display-8-26.rtf";
proc print data=nitro;
   where animal < 5;
   id animal;
run;

proc print data=nitrofen_A;
   where animal < 5;
   id animal;
run;

proc tabulate data=nitrofen_A;
  class conc brood;
  var count;
  table conc*brood,count*(min q1 median q3 max);
run;
ods rtf close;

/************************************** Display 8.30 ***********************************************/

/*  Problem:  Explore whether t-test really is robust to
              violations of the equal variance assumption

    Strategy: See if the t-test operates at the nominal
              Type I error rate when the unequal variance
              assumption is violated

*/ 
/* specify the conditions to be generated  */
/* generate data sets reflecting these conditions  */
/* calculate the test statistic  */
/* accumulate results over numerous simulated data sets  */

/************************************** Display 8.31 ***********************************************/

/*  Problem:  Explore whether t-test really is robust to
              violations of the equal variance assumption

    Strategy: See if the t-test operates at the nominal 
              Type I error rate when the unequal variance
              assumption is violated

*/ 

/* specify the conditions to be generated  */

Nsims = 1;       * number of simulated experiments;
Myseed = 65432;  * specify seed for random number sequence;

N1 = 10;      * sample sizes from populations 1 and 2;
N2 = 10;

Mu_1 = 0;     * mean/sd of population 1;
Sig_1 = 1;

Mu_2 = 0;     * mean/sd of population 2;
Sig_2 = 1;

/* generate data sets reflecting these conditions  */

* generate N1 observations ~ N(mu_1, sig_1^2)  ;

* generate N2 observations ~ N(mu_2, sig_2^2)  ;


/* calculate the test statistic  */

/* accumulate results over numerous simulated data sets  */

/************************************** Display 8.32 ***********************************************/

/*  Problem:  Explore whether t-test really is robust to
              violations of the equal variance assumption

    Strategy: See if the t-test operates at the nominal 
              Type I error rate when the unequal variance
              assumption is violated

*/ 

/* specify the conditions to be generated  */

Data simulate_2group_t;
Nsims = 1;       * number of simulated experiments;
Myseed = 65432;  * specify seed for random number sequence;
call streaminit(Myseed);  * see Section 8.11 for more descrip.; 

N1  = 10;      * sample sizes from populations 1 and 2;
N2 = 10;

Mu_1 = 0;     * mean/sd of population 1;
Sig_1 = 1;

Mu_2 = 0;     * mean/sd of population 2;
Sig_2 = 1;

do iexpt = 1 to Nsims; 

/* generate data sets reflecting these conditions  */

* generate N1 observations ~ N(mu_1, sig_1^2)  ;
  do ix = 1 to N1;
    group = 1;
    Y = RAND('normal',mu_1,sig_1);
    output;
  end;

* generate N2 observations ~ N(mu_2, sig_2^2)  ;
  do ix = 1 to N2;
    group = 2;
    Y = RAND('normal',mu_2,sig_2);
    output;
  end;

/* calculate the test statistic  */

/* accumulate results over numerous simulated data sets  */

end;  * of the do-loop over simulated experiments;
run;

ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\Display-8-32.rtf";
proc print data=simulate_2group_t;
run;

proc means data=simulate_2group_t;
  var y;
  class group;
run;
ods rtf close;

/************************************** Display 8.33 ***********************************************/

/*  Problem:  Explore whether t-test really is robust to
              violations of the equal variance assumption

    Strategy: See if the t-test operates at the nominal 
              Type I error rate when the unequal variance
              assumption is violated

*/ 

/* specify the conditions to be generated  */

data simulate_2group_t;
Nsims = 1;       * number of simulated experiments;
Myseed = 65432;  * specify seed for random number sequence;
call streaminit(Myseed);  

N1 = 10;      * sample sizes from populations 1 and 2;
N2 = 10;

Mu_1 = 0;     * mean/sd of population 1;
Sig_1 = 1;
Mu_2 = 0;     * mean/sd of population 2;
Sig_2 = 1;

do iexpt = 1 to Nsims;

/* generate data sets reflecting these conditions */

* generate N1 observations ~ N(mu_1, sig_1^2)  ;
  do ix = 1 to N1;
    group = 1;
    Y = RAND('normal',mu_1,sig_1);
    output;
  end;

* generate N2 observations ~ N(mu_2, sig_2^2)  ;
  do ix = 1 to N2;
    group = 2;
    Y = RAND('normal',mu_2,sig_2);
    output;
  end;

end;  * of the do-loop over simulated experiments;
run ;
 
/* calculate the test statistic */
ods rtf file="C:\Users\baileraj.IT\Desktop\Display-8-33.rtf";
ods trace on/listing;
proc ttest data=simulate_2group_t;
  by iexpt;
  class group;
  var Y;
run;
ods trace off; 
ods rtf close;

/************************************** Display 8.35 ***********************************************/

ods output TTests=Out_TTests;
proc ttest data= simulate_2group_t;
  by iexpt;
  class group;
  var Y;
run;

ods output close; 
ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\Display-8-35.rtf";
proc print data=Out_TTests;
run;
ods rtf close;

/************************************** Display 8.37 ***********************************************/

/*  Problem:  Explore whether t-test really is robust to
              violations of the equal variance assumption

    Strategy: See if the t-test operates at the nominal 
              Type I error rate when the unequal variance
              assumption is violated
*/ 

/* specify the conditions to be generated  */

data simulate_2group_t;
Nsims = 4000;    * number of simulated experiments;
Myseed = 65432;  * specify seed for random number sequence;
call streaminit(Myseed);  

N1 = 10;      * sample sizes from populations 1 and 2;
N2 = 10;

Mu_1 = 0;     * mean/sd of population 1;
Sig_1 = 1;

Mu_2 = 0;     * mean/sd of population 2;
Sig_2 = 1;

do iexpt = 1 to Nsims;

/* generate data sets reflecting these conditions  */

* generate N1 observations ~ N(mu_1, sig_1^2)  ;
  do ix = 1 to N1;
    group = 1;
    Y = RAND('normal',mu_1,sig_1);
    output;
  end;

* generate N2 observations ~ N(mu_2, sig_2^2)  ;
  do ix = 1 to N2;
    group = 2;
    Y = RAND('normal',mu_2,sig_2);
    output;
  end;
end;  * of the do-loop over simulated experiments;
run;
/* calculate the test statistic  */
/* Note:  ODS TRACE was used to determine the output
          object containing the test statistics.  This
          included the pooled-variance t-test and the 
          Satterthwaite df approximation for the t-test
          allowing for unequal variances */
ods output TTests=Out_TTests;
proc ttest data= simulate_2group_t; 
  by iexpt;
  class group;
  var Y;
run;
ods output close; 

/* accumulate results over numerous simulated data sets  */

data out_ttests; set out_ttests;
retain Pooled_p;  * RETAIN explained in Section 8.3;
if method="Pooled" then Pooled_p = Probt;
else do;
  Satter_p = Probt;
  Pooled_reject = (Pooled_p <= 0.05); * Boolean trick again;
  Satter_reject = (Satter_p <= 0.05);
  keep iexpt Pooled_p Satter_p Pooled_reject Satter_reject;
  output;
end;
run;

ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\Display-8-37.rtf";
proc freq;
  table Pooled_reject Satter_reject;
run;
ods rtf close;

/************************************** Display 8.38 ***********************************************/

data simulate_2group_t;

Nsims = 4000;    * number of simulated experiments;
Myseed = 65432;  * specify seed for random number sequence;
call streaminit(Myseed);

N1 = 10;      * sample sizes from populations 1 and 2;
N2 = 10;

Mu_1 = 0;     * mean/sd of population 1;
Sig_1 = 1;

Mu_2 = 0;     * mean/sd of population 2;
Sig_2 = 1;

do iexpt = 1 to Nsims;

* generate N1=10 observations ~ N(mu_1, sig_1^2)  ;
X1 = RAND('normal',mu_1,sig_1);
X2 = RAND('normal',mu_1,sig_1);
X3 = RAND('normal',mu_1,sig_1);
X4 = RAND('normal',mu_1,sig_1);
X5 = RAND('normal',mu_1,sig_1);
X6 = RAND('normal',mu_1,sig_1);
X7 = RAND('normal',mu_1,sig_1);
X8 = RAND('normal',mu_1,sig_1);
X9 = RAND('normal',mu_1,sig_1);
X10 = RAND('normal',mu_1,sig_1);

* generate N2=10 observations ~ N(mu_2, sig_2^2)  ;
Y1 = RAND('normal',mu_2,sig_2);
Y2 = RAND('normal',mu_2,sig_2);
Y3 = RAND('normal',mu_2,sig_2);
Y4 = RAND('normal',mu_2,sig_2);
Y5 = RAND('normal',mu_2,sig_2);
Y6 = RAND('normal',mu_2,sig_2);
Y7 = RAND('normal',mu_2,sig_2);
Y8 = RAND('normal',mu_2,sig_2);
Y9 = RAND('normal',mu_2,sig_2);
Y10 = RAND('normal',mu_2,sig_2);

output;

/* calculate the test statistic                        */
run;

/************************************** Display 8.39 ***********************************************/

data simulate_2group_t;

array x{10} x1-x10;   * storage for sample from population 1;
array y{10} y1-y10;   * storage for sample from population 2;

Nsims = 4000;    * number of simulated experiments;
Myseed = 65432;  * specify seed for random number sequence;
call streaminit(Myseed);

N1 = 10;      * sample sizes from populations 1 and 2;
N2 = 10;

Mu_1 = 0;     * mean/sd of population 1;
Sig_1 = 1;

Mu_2 = 0;     * mean/sd of population 2;
Sig_2 = 1;

do iexpt = 1 to Nsims;

* generate N1=10 observations ~ N(mu_1, sig_1^2)  ;
  do isample1 = 1 to N1;
    x{isample1} = RAND('normal',mu_1,sig_1);
  end;

* generate N2=10 observations ~ N(mu_2, sig_2^2)  ;
  do isample2 = 1 to N2;
    y{isample2} = RAND('normal',mu_2,sig_2);
  end;

output;

/* calculate the test statistic                        */

end;
run;

/************************************** Display 8.40 ***********************************************/

/* calculate the test statistic                        */

* >>>> calculate sample means and variances   ;

* >>>> calculate pooled variance and t-test statistic   ;

* >>>> calculate p-value   ;

/************************************** Display 8.41 ***********************************************/

data simulate_2group_t;

array x{10} x1-x10;   * storage for sample from population 1;
array y{10} y1-y10;   * storage for sample from population 2;

Nsims = 4000;    * number of simulated experiments;
Myseed = 65432;  * specify seed for random number sequence;
call streaminit(Myseed);

N1 = 10;      * sample sizes from populations 1 and 2;
N2 = 10;
Mu_1 = 0;     * mean/sd of population 1;
Sig_1 = 1;
Mu_2 = 0;     * mean/sd of population 2;
Sig_2 = 1;

do iexpt = 1 to Nsims;

* generate N1=10 observations ~ N(mu_1, sig_1^2)  ;
  do isample1 = 1 to N1;
    x{isample1} = RAND('normal',mu_1,sig_1);
  end;

* generate N2=10 observations ~ N(mu_2, sig_2^2)  ;
  do isample2 = 1 to N2;
    y{isample2} = RAND('normal',mu_2,sig_2);
  end;

/* calculate the test statistic                        */

* >>>> calculate sample means and variances   ;
  xbar = mean(of x1-x10);
  ybar = mean(of y1-y10);

  xvar = var(of x1-x10);
  yvar = var(of y1-y10);

* >>>> calculate pooled variance and t-test statistic   ;
  s2p = (9*xvar + 9*yvar)/18;

  tstat = (xbar-ybar)/sqrt(s2p*(2/10));

* >>>> calculate p-value   ;
  Pvalue = 2*(1-CDF('t',abs(tstat),18));
  Reject05 = (Pvalue <= 0.05);

output;
end;  * of loop over simulated experiments;
run;

ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\Display-8-41.rtf";
proc freq data=simulate_2group_t; 
  table Reject05;
run;  
ods rtf close;

/************************************** Display 8.42 ***********************************************/

/* generate data [x, f(x)] in a rectangle containing f(x) = density 
   for N(0,1) */

/* determine proportion of points that lie below f(x) */

/* derive the area estimate and place a bound on the error of 
   estimation */

/************************************** Display 8.43 ***********************************************/

REPEAT {
/* generate data [x, f(x)] in a rectangle containing the 
                                       f(x) = density for N(0,1) */
   x = 1.645*RAND('uniform');
   y = 0.400*RAND('uniform');
/* determine proportion of points that lie below f(x) */
   iunder = (y<= (1/sqrt(2*pi) )*exp(-x*x/2) );

}
   p_est = sum(iunder)/number of simulated points;

/* derive the area estimate, SE and CI   */
AUC_hat = Area_Rectangle * p_est;
SE_AUC_hat = Area_Rectangle * sqrt(p_est * (1-p_est) / n_pts);
LCL = AUC_hat - zmult * SE_AUC_hat;
UCL = AUC_hat + zmult * SE_AUC_hat;
/* write out results   */

/************************************** Display 8.44 ***********************************************/

data area_est;
 retain n_under 0;              * initialize counter;
 seed1 = 98765;                 * seed specified;
 call streaminit(seed1);

 const = 1/sqrt(2*arcos(-1));   * bring constant calc. outside loop;
 n_pts = 4000;
 zmult = 1.96;                  * 95% Confidence interval requested;
 Area_rectangle = 1.645*.400;

do ii = 1 to n_pts;             *  REPEAT { . . .  ;

/* generate data [x, f(x)] in a rectangle containing the 
                                       f(x) = density for N(0,1) */
   x = 1.645*RAND('uniform');
   y = 0.400*RAND('uniform');

/* determine proportion of points that lie below f(x) */
   iunder = (y<= const*exp(-x*x/2) );
   n_under = n_under + iunder;
   p_est = n_under/ii;

/* derive the area estimate, SE and CI   */
   AUC_hat = Area_Rectangle * p_est;
   SE_AUC_hat = Area_Rectangle * sqrt(p_est * (1-p_est) / n_pts);
   LCL = AUC_hat - zmult * SE_AUC_hat;
   UCL = AUC_hat + zmult * SE_AUC_hat;

output;
end;                           *  . . . } ;

/* write out the results  */
put "Area est. = " AUC_hat;
put "(SE = " SE_AUC_hat ")";
put "CI: [" LCL "," UCL  "]";
run;

/************************************** Display 8.45 ***********************************************/

ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\Display-8-46A.rtf";

/* generate plot of estimate of P(0<Z<1.645) plus pointwise CI */
/*  Code enhancement suggested by SAS reviewer       */
data area_est; set area_est;
  AUC_TRUE = 0.45;
run;

ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\Display-8-46.rtf";
ods graphics on;

proc sgplot data=area_est;
  where 10 <= ii <= 3500;
  label ii= "Number of simulated data points";
  label AUC_hat = "Estimated Area";

  series x=ii y=AUC_hat / name="AUC est." curvelabel;
  series x=ii y=LCL / name = "LCL" curvelabel;
  series x=ii y=UCL / name = "UCL" curvelabel;
  series x=ii y=AUC_TRUE / name="TRUE" lineattrs=(pattern=solid color=black thickness=2); 
  yaxis values=(0.38 to 0.48 by 0.01); 
  keylegend "TRUE" / location=inside position=bottomright;

run;
ods graphics off;
ods rtf close;

/* VERSION 2A:  using device-based graphics */
/* set up formats and labels for point of randomly generated points */
proc format;
  value underfmt 1="Under curve"
                 0="Over curve";
run;

/* VERSION 2B:  using template-based graphics */
ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\Display-8-47.rtf";
ods graphics on;

proc sgplot data=area_est;
  scatter x=x y=y / group=iunder;
  label x="Randomly generated X-coordinate";
  label y="Randomly generated Y-coordinate"; 
  format iunder underfmt.;
run;

ods graphics off;
ods rtf close;


/************************************** Display 8.48 ***********************************************/

/*  input the data  */

/*  construct the t-based CI for the mean response  */

/*  calculate the bootstrap-based CI for the mean response  */

* generate bootstrap resamples of the data vector

* calculate the mean for each resample

* select the 5th and 95th percentiles from the bootstrap distribution of the mean


/************************************** Display 8.49 ***********************************************/

/* input the data  */
/* From the FITNESS data set found in SAS Help 

Help > Getting Started with SAS Software > 
              Learning to Use SAS > Sample SAS Programs > 
                  SAS/STAT > Sample and select Example 2 for PROC REG
  
 
   Note: Only AGE data considered.
*/
data in_data;
  input age @@;
  datalines;
44 40 44 42 38 47 40 43 44 38 44 45 45 47 54 49 51 51 48 49 57 54 52 50 51 54 51 57 49 48 52
;
run;

ODS RTF bodytitle file="C:\Users\baileraj.IT\Desktop\Display-8-49.rtf";

/* construct the t-based CI for the mean response */
proc tabulate data=in_data alpha=0.10;
  var age;
  table age, LCLM UCLM; * 90% CI requested for the mean MPG;
run;

/* calculate the bootstrap-based CI for the mean response */
data boot_data;
array age{31} age1-age31;
array bage{31} bage1-bage31;
input age1-age31;

* generate 4000 bootstrap resamples of the 31 element data vector;
call streaminit(27549);

do i=1 to 4000;
  do ii = 1 to 31;
    ipick = int(31*RAND('uniform')+1);
    bage(ii) = age(ipick);
  end;
  boot_mean = mean(of bage1-bage31);    * calculate the test statistic; 
  keep boot_mean;
  output boot_data;
end;

datalines;
44 40 44 42 38 47 40 43 44 38 44 45 45 47 54 49 51 51 48 49 57 54 52 50 51 54 51 57 49 48 52
run;

* select 5th and 95th percentiles from bootstrap distribution of the mean;
proc tabulate data=boot_data;
  var boot_mean;
  table boot_mean, P5 P95;
run;

ods graphics on;
proc sgplot data=boot_data;  * histogram of bootstrap means (not shown);
  histogram boot_mean;
run;
ods graphics off;

ODS RTF close;


/************************************** Display 8.50 ***********************************************/


data cdf_examples;

/* Z ~ N(0,1) table values */
  norm_area_left = cdf("Normal",-1.645);

  norm_area_right = 1-cdf("Normal",-1.645);  * area above -1.645 under N(0,1);

/* T ~ t(df) table values */
  t_area_left_06 = cdf("T",-1.645, 6);    * area <= -1.645 for t(df=6);
  t_area_left_60 = cdf("T",-1.645, 60);   * area <= -1.645 for t(df=60);
  t_area_left_600 = cdf("T",-1.645, 600); * area <= -1.645 for t(df=600);

/* Pr(Y<=m) for Y ~ binomial(m=successes, p=prob of success=0.5, n=trials=4) */
  bin_cdf_0 = CDF('binomial', 0, 0.50, 4);
  bin_cdf_1 = CDF('binomial', 1, 0.50, 4);
  bin_cdf_2 = CDF('binomial', 2, 0.50, 4);
  bin_cdf_3 = CDF('binomial', 3, 0.50, 4);
  bin_cdf_4 = CDF('binomial', 4, 0.50, 4);

  p0 = bin_cdf_0;        /* Pr(Y=m) for Y ~ binomial(p=0.5, n=4)  */
  p1 = bin_cdf_1 - bin_cdf_0;
  p2 = bin_cdf_2 - bin_cdf_1;
  p3 = bin_cdf_3 - bin_cdf_2;
  p4 = bin_cdf_4 - bin_cdf_3;
run;

ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\Display-8-50.rtf";
proc print data=cdf_examples;
run;
ods rtf close;


/************************************** Display 8.52 ***********************************************/

data pdf_examples;

/* Pr(Y=m) for Y ~ binomial(p=prob of success=0.5,  n=trials=4)  */
  bin_0 = PDF('binomial', 0, 0.50, 4);
  bin_1 = PDF('binomial', 1, 0.50, 4);
  bin_2 = PDF('binomial', 2, 0.50, 4);
  bin_3 = PDF('binomial', 3, 0.50, 4);
  bin_4 = PDF('binomial', 4, 0.50, 4);

/* Z ~ N(0,1) value of phi(0) */
  normal_density_0 = pdf("Normal", 0);
run;

ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\Display-8-52.rtf";
proc print data=pdf_examples;
run;
ods rtf close;


/************************************** Display 8.54 ***********************************************/

data t_vs_z;
  do x= -3.5 to 3.5 by .001;
    t4= x;
    t_density = PDF('t', x, 4);
    z = x;
    z_density = PDF('Normal', x);
    output;
  end;
run;

ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\Display-8-54.rtf";

ods graphics on;
proc sgplot data=t_vs_z;
   label t_density="t[df=4] density";
   label z_density="N(0,1) density";
   series x=t4 y=t_density / curvelabel;
   series x=z  y=z_density / curvelabel;
   xaxis label="value";
   yaxis label="density";
run;
ods graphics off;
ods rtf close;

/************************************** Display 8.56 ***********************************************/

data quant_calc;

*  z examples ;
zq_50 = QUANTILE('Normal',0.50);
zq_90 = QUANTILE('Normal',0.90);
zq_95 = QUANTILE('Normal',0.95);
zq_975 = QUANTILE('Normal',0.975);

put "Z:  50th   percentile = " @25 zq_50;
put "Z:  90th   percentile = " @25 zq_90;
put "Z:  95th   percentile = " @25 zq_95;
put "Z:  97.5th percentile = " @25 zq_975;
put " ";

* binomial examples;
binq_50 =  QUANTILE('Binomial',0.50,.50,4);
binq_90 =  QUANTILE('Binomial',0.90,.50,4);
binq_95 =  QUANTILE('Binomial',0.95,.50,4);
binq_975 = QUANTILE('Binomial',0.975,.50,4);

put "Binomial:    50th percentile = " @35 binq_50;
put "Binomial:    90th percentile = " @35 binq_90;
put "Binomial:    95th percentile = " @35 binq_95;
put "Binomial:  97.5th percentile = " @35 binq_975;
put " ";

run;


/************************************** Display 8.58 ***********************************************/

data t_vs_z_quant;
  do prob = .01 to .99 by .01;
    t_quantile = QUANTILE('t', prob, 4);
    z_quantile = QUANTILE('Normal', prob);
    output;
  end;
run;

ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\Display-8-58.rtf";
ods graphics on;
proc sgplot data=t_vs_z_quant;
   series x=z_quantile y=t_quantile;
   yaxis label ="t[df=4] density";
   xaxis label ="N(0,1) density";
run;
ods graphics off;
ods rtf close;

/************************************** Display 8.60 ***********************************************/

data triangular;
  call streaminit(34567);
  do inum = 1 to 1400;
     mynum = RAND('Triangle', 0.70);
            * h=0.70 is a parameter of the triag. distn.;
     output;
  end;
run;

ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\Display-8-60.rtf";
ods graphics on;
proc sgplot data=triangular;
  histogram mynum;
run;
ods graphics off;
ods rtf close;

/************************************** Display 8.62 ***********************************************/

data diceroll;   * rolling two six-sided balanced dice;
  call streaminit(34567);
  do inum = 1 to 6000;
     die1 = RAND('Table', 1/6, 1/6, 1/6, 1/6, 1/6);
     die2 = RAND('Table', 1/6, 1/6, 1/6, 1/6, 1/6);
     sum7plus = (die1+die2)>=7;
  output;
  end;
run;

ods rtf bodytitle file="C:\Users\baileraj.IT\Desktop\Display-8-62.rtf";
proc freq data=diceroll;
  table die1 / nocum testf=(1000,1000,1000,1000,1000,1000);
  table sum7plus;
run;
ods rtf close;

/************************************** Display 9.1 ***********************************************/

data temps;
  array tempF(4) tempF1-tempF4 (32,50,68,86);
  array tempC(4) tempC1-tempC4;

  do itemp = 1 to 4;
    tempC(itemp) = 5/9*(tempF(itemp)-32);
  end;
  drop itemp;
end;
run;
 
proc print data=temps;
run;

/************************************** Display 9.2 ***********************************************/
/*  (along with code before Display 9.2)                                                          */

data D1;
ARRAY ADL{7} ADL1-ADL7;
  input ADL1-ADL7;
  datalines;
6 6 5 5 5 4 3
;
run;

data D2;
ARRAY ADL{*} ADL1-ADL7;
  input ADL1-ADL7;
  datalines;
6 6 5 5 5 4 3
;
run;

data D3;
ARRAY ADL{*} t1 t2 t3 t4 t5 time6 time_7;
  input t1 t2 t3 t4 t5 time6 time_7;
  datalines;
6 6 5 5 5 4 3
;
run;


data D4;
ARRAY ADL{*} t1 t2 t3 t4 t5 time6 time_7;
  input t1 t2 t3 t4 t5 time6 time_7;
  DO ielement = 1 to 7;
    if ADL{ielement}=-999 then ADL{ielement}=.;
  END;
  datalines;
6 6 5 5 5 4 3
7 -999 4 4 3 -999 2
;
run;

proc print data=D4;
title "Recoding missing values using arrays and DO loop";
run;

/************************************** Display 9.3 ***********************************************/

data D5;
  input name $ sex $ t1 t2 t3 t4 t5 time6 time_7;

ARRAY  num_array{*} _NUMERIC_;
ARRAY char_array{*} _CHARACTER_;

/* recode the numeric variables */
  DO inum = 1 to dim(num_array);
    if num_array{inum}=-999 then num_array{inum}=.;
  END;

/* recode the character variables */
  Do ichar = 1 to dim(char_array);
    if char_array{ichar}="-999" then char_array{ichar}=" ";
  END;

  drop inum ichar;
datalines;
MrSmith -999 6    6 5 5 5    4 3
-999       F 7 -999 4 4 3 -999 2
 ;
run;

proc print data=D5;
title "Recoding missing values using arrays and DO loop";
run;


/************************************** Display 9.4 ***********************************************/

data D6;
  input name $ sex $ t1 t2 t3 t4 t5 time6 time_7;

ARRAY  num_array{*} _NUMERIC_;
DO inum = 1 to dim(num_array);
   time = inum;
   ADL = num_array{inum};
   output;
END;
keep name sex time ADL;

datalines;
Smith M 6 6 5 5 5 4 3
Jones F 7 5 4 4 3 2 1
Fisher M 5 5 5 3 2 2 1
;
run;

/************************************** Display 9.5 ***********************************************/

/* enter the observed data into data arrays   */
data plot_obs;
  array xobs(4) xobs1-xobs4;
  array yobs(4) yobs1-yobs4;
  do idat = 1 to 4;
    input xobs(idat) yobs(idat) @@;
  end;
datalines;
.25 .65 .25 .75 .35 .65 .35 .75
;
run;

/* STEP 1:  Determine nearest-neighbor distances for observed data     */
data plot1;  set plot_obs;
  array xobs(4) xobs1-xobs4;
  array yobs(4) yobs1-yobs4;
  array nnobs(4) nnobs1-nnobs4;

/* Determine nearest-neighbor distance for each point     */
  sumnnobs = 0;
  do i=1 to 4;       * find nearest-neighbor distance for each point ;
    nnobs(i) = 100;  * initialize distances to be large;

/*  calculate the Euclidean distance between the ith tree and
    all others –  save  the smallest value as the distance to its
    nearest neighbor and compare the ith point to all others.
*/ 
    do j=1 to 4;
      d=sqrt( (xobs(i)-xobs(j))**2 + (yobs(i)-yobs(j))**2 );
      if (d<nnobs(i)) and (d>0) then nnobs(i)=d;
    end;
/* Note: Each point is also compared to itself - thus, d=0
         omitted from updated of nearest neighbor distance. */
    sumnnobs=sumnnobs+nnobs(i); 
  end;

/* STEP 2: Calculate average nearest-neighbor distance for observed data    */
  avgnnobs = sumnnobs/4;  
run;

/* Simulate plots under CSR  */
data mccsr1; set plot1;
  array xobs xobs1-xobs4; * observed data;
  array yobs yobs1-yobs4;
  array xsim xsim1-xsim4; * CSR simulated data;
  array ysim ysim1-ysim4;

  array nnobs nnobs1-nnobs4; * observed NN distances;
  array nncsr nncsr1-nncsr4; * simulated NN distances;

/*  STEP 3: Generate many CSR plots with four trees      */

* initialize counters of nn avg dist le or ge than observed;
numle = 0;     
*  numge = 0;  * commented out since focus on clustering here;

nsim = 4000;      * user-specified option;
seed1 = 12345;    * if =0, then uses time since midnight;
call streaminit(seed1);

do isim = 1 to nsim;

/* STEP 5: Repeat steps 3 and 4 many times       */
   do ii = 1 to 4;
     xsim(ii) = RAND('uniform');
     ysim(ii) = RAND('uniform');
   end;

/* STEP 4: Calculate average nearest-neighbor distance for simulated data    */

   sumnncsr = 0;
   do i=1 to 4;
     nncsr(i) = 100;  * initialize;

     do j=1 to 4;
       d=sqrt( (xsim(i)-xsim(j))**2 + (ysim(i)-ysim(j))**2 );
       if (d<nncsr(i)) and (d>0) then nncsr(i)=d;
     end;

     sumnncsr=sumnncsr+nncsr(i);
   end;
   avgnncsr = sumnncsr/4;

/*  Accumulate counts of patterns consistent with clustering */
   ile = (avgnncsr <= avgnnobs);
   numle = numle + ile;

*   ige = (avgnncsr >= avgnnobs);
*   numge = numge + ige;

   drop i j ii xobs1-xobs4 yobs1-yobs4 nnobs1-nnobs4 
        sumnnobs sumnncsr;
   output;
end;      * of the isim - simulation loop;

/*  STEP 6:  Calculate the Monte Carlo p-value            */
MC_P_value_Cluster = numle/nsim;

* write results to log file with PUT statements;
put "MC P-value (Clustering) = " MC_P_value_Cluster;
put "(based on " nsim " simulated plots)";

run;

/************************************** Display 9.6A ***********************************************/

data test;
input id xstart xstop;
datalines;
1 15 25
2 10 12
2 18 22
3 6 12
3 14 15
3 17 23
 ;
run;

* make sure that data are sorted by ID and XSTART;
proc sort data=test;
    by id xstart;
run;

proc print data=test;
run;

data test2; set test; by id;        **** Comment 1;
  array start{9} start1-start9;     * (explained on ;
  array stop{9} stop1-stop9;        *  next page);
  array times{9} times1-times9;

  retain count 0;                   **** Comment 2;
  retain start1-start9 stop1-stop9 times1-times9;

* initialize count and arrays with new ID;
  if FIRST.id then do;            **** Comment 3;
    count = 0;
    do ii=1 to 9;
      start{ii} = .;
      stop{ii} = .;
      times{ii} = .;
    end;
  end;

  count = count + 1;	           **** Comment 4;
  start{count} = xstart;
  stop{count} = xstop;
  times{count} = xstop - xstart;
  if LAST.id=1 then do;             **** Comment 5;
     first_time = times(1);
	total_time = sum(of times1-times9);
     output;  * output results if last obs for ID;
  end;  

  keep id count first_time total_time;
run;

proc print data=test2;
run;


/************************************** Display 9.6B ***********************************************/

data test;
input id xstart xstop;
datalines;
1 15 25
2 10 12
2 18 22
3 6 12
3 14 15
3 17 23
 ;
run;

proc print data=test;
run;

*** make sure data are sorted by ID and XSTART variables;
proc sort data=test;
    by id xstart;
run;

data test2;
    set test;
    by id;

    retain count total_time first_time;

    if first.id then do;
        count=0;
        total_time=0;
        first_time=0;
    end;
    count=count+1;
    total_time=total_time + (xstop-xstart);
    if first.id then first_time=xstop-xstart;

    if last.id then output;

    keep id count total_time first_time;
run;

proc print data=test2;
run;

/************************************** Display 9.7 ***********************************************/
/*  (along with code before Display 9.7)                                                          */


libname class 'C:\Users\baileraj.IT\Desktop';

data test; set class.nitrofen;
  if conc=0 | conc=160;
run;

proc print data=test;
  title "NITROFEN: print of (0, 160) concentrations";
  var conc total;
run;

data test;                * entering directly as alternative to ;
  input Obs conc total;   *    permanent SAS data file reference;
datalines;
  1       0      27
  2       0      32
  3       0      34
  4       0      33
  5       0      36
  6       0      34
  7       0      33
  8       0      30
  9       0      24
 10       0      31
 11     160      29
 12     160      29
 13     160      23
 14     160      27
 15     160      30
 16     160      31
 17     160      30
 18     160      26
 19     160      29
 20     160      29
 ;
run;

proc print data=test;
  title "NITROFEN: print of (0, 160) concentrations";
  var conc total;
run;

proc transpose data=test prefix=xx out=tran_out;
  var total;
run;

* add variable "type" to identify the observed data;
data obs_test; set tran_out;
  type = "O";    * identifies original data;
run;

* check result of TRANSPOSE and the added variable;
proc print data=obs_test;
  title "Randomization test:  observed data";
run;

/* 
  PROC PLAN used to generate a set of indices for the
  randomization test. 
*/

proc plan seed=8675309;
  factors test=4000 ordered in=20;
  output out=d_permut;
run;

/*
  PROC TRANSPOSE restructures the data set output from PROC PLAN
*/
proc transpose data=d_permut prefix=in
               out=out_permut(keep=in1-in20); 
  by test;
run;

proc print data=out_permut;
run;

/*
  Write out the original data along with a sample of
  permuted indices to an external data file
*/
data _null_; set obs_test;
  file 'C:\Users\baileraj.IT\Desktop\my-perm.data';
  put type xx1-xx20;
run;

data _null_; set out_permut;
  type = 'P';  * permutation data;
  file 'C:\Users\baileraj.IT\Desktop\my-perm.data' mod;   
/* mod option adds lines to existing file  */
  put type in1-in20;
run;

/*  Excerpt from my-perm.data ...    
O 27 32 34 33 36 34 33 30 24 31 29 29 23 27 30 31 30 26 29 29
P 8 14 4 11 3 2 12 1 6 13 17 9 15 16 5 19 20 7 10 18
P 12 2 8 10 13 7 9 16 4 19 15 3 5 14 17 1 20 11 6 18
P 18 17 13 14 5 8 19 16 3 12 11 9 10 7 2 20 4 6 1 15
. . . 
*/

data perm_data;
  array both{20}  x1-x10 y1-y10;     
                  /* array for observed values */
  array ins{20} in1-in20;
                  /* index array */
  array perms{20} xp1-xp10 yp1-yp10;  
                  /* array for permuted values */

  infile 'C:\Users\baileraj.IT\Desktop\my-perm.data';
  input type $ @;
    if type='O' then do;
      input x1-x10 y1-y10;
      obs_diff = mean(of x1-x10) - mean(of y1-y10);
      retain obs_diff x1-x10 y1-y10;
    end;
    else do;
      input in1-in20;

* permute observations according to indices in the array 'ins';
      do ii = 1 to 20;
        perms{ii} = both{ ins[ii] };
      end;

/* calculate test statistic for the permuted data and
   save an indicator variable denoting whether the 
   value of the statistic for the permuted data set
   is at least as extreme as the observed test statistic.
*/
      perm_diff = mean(of xp1-xp10) - mean(of yp1-yp10);
      perm_ge = (perm_diff >= obs_diff);
                                        * 1-tailed;
      perm_2tail = (abs(perm_diff) >= abs(obs_diff));
                                        * 2-tailed;
      keep obs_diff perm_diff perm_ge perm_2tail;
      output;
   end;
run;

/*
  PROC FREQ is used to construct the relative frequency of
  randomization test yielding test statistic
  (mean difference) for permuted samples at least
  as extreme as mean difference observed in the data
*/

proc freq data=perm_data;
title "NITROFEN:  randomization test -> upper-tail p-value";
  table perm_ge perm_2tail;
run;


/************************************** Display 10.1 ***********************************************/

/* 
Estimate P(0 < Z < 1.645) using the trapezoidal rule
*/ 
data trapper;
  trapsum=0;
  array x_value(25) x1-x25;
  array f_value(25) y1-y25;

  low = 0;
  high = 1.645;
  incr = (high-low)/24;
  pi = arcos(-1);

  do i= 1 to 25;
    x_value[i] = low + incr*(i-1);
    f_value[i] = (1/sqrt(2*pi))*exp(-x_value[i]*x_value[i]/2);

    if i=1 or i=25 then trapsum = trapsum + f_value[i]/2;
    else trapsum = trapsum + f_value[i];
  end;
  area_est = trapsum*incr;
  output;
run;

ods rtf bodytitle;
proc print data=trapper;
  title "Trapezoidal Rule Area Estimate for P(0<Z<1.645)";
  var low high incr area_est;
run;

data trapper2;
   set trapper;
   array x_value(25) x1-x25;
   array f_value(25) y1-y25;
   do ii=1 to 25;
     xout = x_value[ii];
     yout = f_value[ii];
     output;
   end;
run;

proc print data=trapper2;
title "Interpolation Points for Trapezoidal Rule";
   var ii low high incr area_est xout yout;
run;

ods graphics on;
proc sgplot data=trapper2;
title "Plot of function values vs. x-values";
  scatter x=xout y=yout;
run;
ods graphics off;
ods rtf close;


/************************************** Display 10.5 ***********************************************/

/* Estimate P(low < Z < high) using the trapezoidal rule */ 

%let npts = 50;
%let LOW = -1.645;
%let HIGH = 1.645;

data trapper;
  file  "C:\Users\baileraj.IT\Desktop\est.out" MOD;
  trapsum = 0;
  array x_value(&npts) x1-x&npts;
  array f_value(&npts) y1-y&npts;

  low = &LOW;
  high = &HIGH;
  incr = (high-low)/( &npts -1);
  pi = arcos(-1);
  do i= 1 to &npts;
   x_value[i] = low + incr*(i-1);
    f_value[i] = (1/sqrt(2*pi))*exp(-x_value[i]*x_value[i]/2);

    if i=1 or i=&npts then trapsum = trapsum + f_value[i]/2;
	else trapsum = trapsum + f_value[i];
  end;
  area_est = trapsum*incr;
  output;

put;
put "est. P(&LOW < Z < &HIGH) =" area_est "(based on &NPTS points)";
put;
run;

ods rtf bodytitle;
proc print data=trapper;
  title "Trapezoidal Rule Area Estimate for P(&LOW<Z<&HIGH)";
  title2 "(based on &NPTS equally spaced points)";
  var low high incr area_est;
run;

data trapper2;
   set trapper;
   array x_value(&npts) x1-x&npts;
   array f_value(&npts) y1-y&npts;
   do ii=1 to &npts;
     xout = x_value[ii];
     yout = f_value[ii];
     output;
   end;
run;

proc print data=trapper2;
title "Interpolation Points for Trapezoidal Rule";
   var ii low high incr area_est xout yout;
run;

ods graphics on;
proc sgplot data=trapper2;
title "Plot of function values vs. x-values";
  scatter x=xout y=yout;
run;
ods graphics off;
ods rtf close;



/************************************** Display 10.8 ***********************************************/

%let var1=week;
%let var2=weight;
%let time1=1;
%let time2=2;
%let var1time1 = week1;
%let var1time2 = week2;
%let var2time1 = weight1;
%let var2time2 = weight2;

data tester;
  input week1 weight1 week2 weight2;
  datalines;
15 70 25 74 
;
run;

%macro showvalue(variable, obs); * positional parameter;
   %put Value of '&variable' = &variable;
   %put Value of '&obs' = &obs;
   %put Value of '&&&variable.&obs' = &&&variable.&obs;
   proc print;
     var &&&variable.&obs;
   run;
%mend showvalue;

%showvalue(var1, time1)

%showvalue(var2, time2)


/************************************** Display 10.10 ***********************************************/

%macro trap_area_Z(LOW=-1.645, HIGH=1.645, npts_lo=10, npts_hi=10, npts_by=2,
   fout=C:\Users\baileraj.IT\Desktop\est3.out,
   print_est=FALSE, print_pts=FALSE, display_graph=FALSE, ODS_on=FALSE);

/*  ======================================================================== 
Purpose: Estimate P{LOW<Z< HIGH) using the trapezoidal rule
Macro variables:
LOW, HIGH: interval of interest
NPTS_LO, NPTS_HI, NPTS_BY: # function values evaluated in area calc.
FOUT: output data file containing area estimate for each NPTS value
PRINT_EST: print area estimate
PRINT_PTS: print points/nodes {x1-xn} + function values {f(x1)-f(xn)}   
DISPLAY_GRAPH: generate PROC GPLOT with function values
ODS_ON: generate ODS RTF output
======================================================================== 
*/

%do npts = &npts_lo %to &npts_hi %by &npts_by; *loop over npts values;

data trapper;
  file "&fout" MOD;
  trapsum = 0;
  array x_value(&npts) x1-x&npts;
  array f_value(&npts) y1-y&npts;

  low = &LOW;
  high = &HIGH;
  incr = (high-low)/( &npts -1);
  pi = arcos(-1);
  do i= 1 to &npts;
    x_value[i] = low + incr*(i-1);
    f_value[i] = (1/sqrt(2*pi))*exp(-x_value[i]*x_value[i]/2);

    if i=1 or i=&npts then trapsum = trapsum + f_value[i]/2;
	else trapsum = trapsum + f_value[i];
  end;
  area_est = trapsum*incr;
  output;
 
put "est. P(&LOW < Z < &HIGH) =" area_est "(based on &NPTS points)";
run;

%if %upcase(&ODS_ON)=TRUE %then %do;
   ods rtf bodytitle;
%end;

%if %upcase(&print_est)=TRUE %then %do;
proc print data=trapper;
  title "Trapezoidal Rule Area Estimate for P(&LOW<Z<&HIGH)";
  title2 "(based on &NPTS equally spaced points)";
  var low high incr area_est;
run;
%end;

data trapper2;
   set trapper;
   array x_value(&npts) x1-x&npts;
   array f_value(&npts) y1-y&npts;
   do ii=1 to &npts;
     xout = x_value[ii];
     yout = f_value[ii];
     output;
   end;
run;

%if %upcase(&print_pts)=TRUE %then %do;
proc print data=trapper2;
title "Interpolation Points for Trapezoidal Rule";
   var ii low high incr area_est xout yout;
run;
%end;

%if %upcase(&display_graph)=TRUE %then %do;
ods graphics on;
proc sgplot data=trapper2;
title "Plot of function values vs. x-values";
  scatter x=xout y=yout;
run;
ods graphics off;
%end;

%if %upcase(&ODS_ON)=TRUE %then %do;
ods rtf close;
%end;

%end;   * of loop over npts values;
%mend trap_area_Z;

/************************************** Display 10.11 ***********************************************/

%macro ncheck(npts);
%* npts = needs to be greater than or equal to 1;
%if %sysevalf(&npts<1) %then %do;
  %put ERROR:  '&npts' must exceed 1;
  %put ERROR:  value of '&npts' = &npts;
  %goto badend;
%end;
%put Value of '&npts' = &npts;
%badend:  ;
%mend ncheck;

%ncheck(1)
%ncheck(-2)
%ncheck(0.5)


/************************************** Display 10.17 ***********************************************/

%let summer = June July August;
%let pickmth = 3;
%let mymonth = %scan(&summer, &pickmth);   * pickmth word of summer;
%let mymonth3 =%substr(&summer, 11, 3);    * start @ position 11 and move 3;
%let upper_month3 = %upcase(&mymonth3);

%put Summer=&summer;
%put Length of '&summer' = %length(&summer);
%put Where is Aug in the '&summer'? = %index(&summer, Aug);
%put Month picked = &pickmth;
%put Which month? = &mymonth;
%put Which month (3 letters)? = &mymonth3;
%put Upper case (3 letters)? = &upper_month3;

/************************************** Display 10.18 ***********************************************/

data nitrofen;
 infile ' C:\Users\baileraj.IT\Desktop\ch2-dat.txt' firstobs=16 expandtabs missover pad ; 
 input @9 animal 2.
       @17 conc 3.
       @25 brood1 2.
       @33 brood2 2.
       @41 brood3 2.
       @49 total 2.;
run;

data test; set nitrofen;
  brood=1; conc=conc;  nyoung=brood1; output;
  brood=2; conc=conc;  nyoung=brood2; output;
  brood=3; conc=conc;  nyoung=brood3; output;
run;

%macro threeregs;
  proc sort data=test out=test;
      by brood;
  run;

  data _null_;
      set test;
      by brood;
      if first.brood then do;
        i+1;
        ii = left(put(i,2.));
        call symput('mbrood'||ii,trim(left(brood)));
        call symput('total',ii);
/*
  Alternative with symputx
        call symputx('mbrood'||ii, brood);
        call symputx('total',ii);
*/
      end;
  run;

%do ibrood = 1 %to &total;
   proc sgplot data=test;
      where brood=&&mbrood&ibrood;
      reg x=conc y=nyoung / degree=2;

      title "Plot: # Young vs. Nitrofen Conc.";
      title2 "[brood &&mbrood&ibrood]";

      %put 'ibrood' = &ibrood;
      %put '&&mbrood&ibrood' = &&mbrood&ibrood ;
  run;
%end;

  proc sgpanel data=test;
      title "SGPANEL alternative display [avoids macros & looping]";
      panelby brood / columns=3;
      reg x=conc y=nyoung / degree=2;
  run;
%mend;

ODS RTF bodytitle file="C:\Users\baileraj.IT\Desktop\fig-10-18.rtf";
%threeregs()
quit;
ODS RTF close;


/************************************** Display 10.20 ***********************************************/

/*
  construct 3 example data sets with time and temperature data
*/
data aug03;
  call streaminit(9035768);
  mydate='AUG03';
  do time=1 to 24;
    temp = 74 - abs(time-16) + RAND('Normal',0,0.5);
    output;
  end;
run;

data aug05;
  mydate='AUG05';
  do time=1 to 24;
    temp = 78 - abs(time-16) + RAND('Normal',0,0.5);
    output;
  end;
run;

data aug17;
  mydate='AUG17';
  do time=1 to 24;
    temp = 90 - abs(time-16) + RAND('Normal',0,0.5);
    output;
  end; 
run;

/* DEBUGGING BLOCK TO CHECK DATA SET CONSTRUCTION
data tester; set aug03 aug05 aug17;
proc print data=tester;
  id time;
run;

ods rtf bodytitle file='C:\Users\baileraj.IT\Desktop\ch10-fig10.20.rtf'; 
ods graphics on;
proc sgplot data=tester;
  series x=time y=temp / group=mydate;
  symbol interpol=join;
run;
ods graphics off;
ods rtf close;
*/


/************************************** Display 10.21 ***********************************************/

/*
  create macro variable names corresponding to each data set
*/
data _null_;
* read data sets and create macro variable with name of each;
  retain counter 0;
  input times $ @@;
  counter = counter + 1;
  put times counter;
* create a macro variable with each data set name;
* create macro variable name with total number of DSNs;
  call symputx('dsn' || LEFT(counter), times);
  call symputx('num_data_sets', counter);
  datalines;
aug03 aug05 aug17 
;
run;
%put _user_;


/************************************** Display 10.22 ***********************************************/

/*
  construct macro to concatenate data sets
*/

%macro concatenator(combine);
  data &combine;
    set
    %do ii = 1 %to &num_data_sets;
    &&dsn&ii
    %end;
;
  run;
%mend concatenator;

/*
  concatenate the three data sets and print results
*/
options mprint mlogic;
%concatenator(combine=all3)

title;
ods rtf bodytitle
     file='C:\Users\baileraj.IT\Desktop\ch10-fig10.24.rtf';
 proc print data=all3;
run;

ods graphics on;
proc sgplot data=all3;
  series x=time y=temp / group = mydate;
  yaxis label="Temperature (deg. F)"
        values=(55 to 95 by 10);
  xaxis label="Time (h) since midnight"
        values=(0 to 24 by 6);

ods graphics off;
run;
ods rtf close;


/************************************** Exercise 10.1 ***********************************************/

/*  Problem:  Explore whether t-test really is robust to violations of the equal variance assumption

    Strategy: See if the t-test operates at the nominal Type I error rate when the 
              unequal variance assumption is violated
*/ 
 
data twogroup;

array x{10} x1-x10;
array y{10} y1-y10;

call streaminit(11223344);

do isim = 1 to 10000;
  
/* generate samples X~N(0,1)  Y~N(0,4) - normal case */
  do isample = 1 to 10;
    x{isample} = RAND('normal',0,1);
    y{isample} = RAND('normal',0,2);
  end;

/* calculate the t-statistic                        */
  xbar = mean(of x1-x10);
  ybar = mean(of y1-y10);

  xvar = var(of x1-x10);
  yvar = var(of y1-y10);

  s2p = (9*xvar + 9*yvar)/18;

  tstat = (xbar-ybar)/sqrt(s2p*(2/10));
  Pvalue = 2*(1-probt(abs(tstat),18));
  Reject05 = (Pvalue <= 0.05);

  keep xbar ybar xvar yvar s2p tstat Pvalue Reject05;
  output;
end;   * end of the simulation loop;
run;

/*
proc print;
run;
*/

proc freq; 
  table Reject05;
run;


/************************************** Display 11.1 ***********************************************/

ods rtf bodytitle file="ch-11-display01.rtf";
PROC IML;
 reset noname;  * inhibit default printing of matrix name;

*make a 2x3 matrix;
    C = {1 2 3,4 5 6};
    print '2x3 example matrix C = {1 2 3,4 5 6} =' C;

*select 2nd row;
    C_r2 = C[2,];
    print '2nd row of C = C[2,] =' C_r2;

*select 3rd column;
    C_c3 = C[,3];
    print '3rd column of C = C[,3] =' C_c3;

*select last two columns;
    Col23 = C[,2:3];
    Print ‘Columns 2 and 3 of C =’ Col23;

*select the (2,3) element of C;
    C23 = C[2,3];
    print '(2,3) element of C = C[2,3] =' C23;

*make a 1x3 matrix by summing rows in each column;
    C_csum=C[+,];
    print '1x3 column sums of C = C[+,] =' C_csum;

*make a 2x1 matrix by summing columns in each row;
    C_rsum=C[,+];
    print '2x1 row sums of C = C[,+] =' C_rsum; 

* row means and column means ;
    C_row_mean = C[,+]/ncol(C);
    C_col_mean = C[+,]/nrow(C);

    print '2x1 row means of C = C[,+] =' C_row_mean;
    print '1x3 column means of C = C[,+] =' C_col_mean;

* construct a 3x3 identity matrix;
    I3 = I(3);
    print "3x3 Identity matrix = "  I3;
quit;
ods rtf close;


/************************************** Display 11.3 ***********************************************/

PROC IML;
*make a 2x3 matrix;
    C = {1 2 3,4 5 6};
    print '2x3 example matrix C = {1 2 3,4 5 6} =' C;

*make a 1x3 matrix by summing rows in each column
 and a 2x1 matrix by summing columns in each row;
    C1=C[+,];
    C2=C[,+];

*make a matrix (col. vector) out of second column of C;
    F = C[,2];
    print 'extract 2nd column of C into new vector (F) = C[,2] =' F;

*put second column of C on diagonal;
    D = DIAG( C[,2] );
    print '2nd column of C into a diag, matrix (D)=DIAG(C[,2]) =' D;
*make a vector out of the diagonal;
    CC= VECDIAG(D);
    print 'convert diagonal (of D) into vector (CC) = VECDIAG(D) =' CC;

*put C next to itself - column binds C with itself;
    E = C || C;
    print 'Column bind C with itself yielding E = C||C =' E;

*put a row of 2s below C - row bind ;
    F =  C // SHAPE(2,1,3);
    print "Row bind C with vector of 2s (F) = C // SHAPE(2,1,3) =" F;
* . . . also adds (2 2 2) as another row on C;
    F2 = C // J(1, 3, 2);
    print "Using J(nrow,ncol,value) to add row to C (F2) = " F2;

*create a 6x6 matrix [C // C // C] || [C // C // C];
    K = REPEAT(C,3,2);
    print '6x6 matrix = ' K;

quit;


/************************************** Display 11.5 ***********************************************/

PROC IML;
    C = {1 2 3,4 5 6};   * a 2x3 matrix;
    D = {1, 1, 1};       * a 3x1 column vector;

* matrix multiplication – C  post-multiplied by D; 
    row_sum = C*D;
    print 'row_sum = ' row_sum;

* raise each entry of columns 2 & 3 of C to the third power then multiply by 3 and add 3;
    G = 3+3*(C[,2:3]##3);
    print '3 + 3*(col2&3)^3 (G) = ' G ;

* raise each entry of C to itself;
    H = C ## C;
    print 'raise each C element to itself (H) = C##C =' H;

* multiply each entry of C by itself;
    J = C # C;
    print 'elementwise multiplication of C with itself (J) = C#C =' J;
quit;

/************************************** Display 11.7 ***********************************************/

libname mydat  'folder-containing-nitrofen-data';

proc iml;
/* read SAS data in IML  */
  use mydat.nitrofen;
  read all var { total conc } into nitro;

/*  alternative coding   */
  use mydat.nitrofen var{ total conc };
  read all into nitro2;

nitro = nitro || nitro[,2]##2;  * adding column with conc^2;

* add column with centered concentration;
nitro2 = nitro2 || (nitro2[,2]- nitro2[+,2]/nrow(nitro2)) ;

* adding column with scaled conc^2;
nitro2 = nitro2 || nitro2[,3]##2;

show names;   * show matrices constructed in IML;
*print nitro;
*print nitro2;

* creates SAS data set n2 from matrix nitro;
*   with variable names from the COLNAME argument;

varnames = ('total'||'conc'||'c_conc'||'c_conc2');
print nitro2 varnames;
create n2 from nitro2 [colname=varnames];
append from nitro2;

quit;

proc print data=n2;
  title 'print of data constructed in SAS/IML';
run;

/************************************** Display 11.9 ***********************************************/

proc iml;
  nsim = 4000;
  temp_mat = J(nsim,2,0);

 /* Generate (X,Y) with single call using 'randgen'  */
  call randseed(21509);   * set seed for randgen;
  call randgen(temp_mat,'uniform');

  temp_mat = temp_mat || (temp_mat[,2]<= sqrt(J(nsim,1,1)-temp_mat[,1]##2)); 
 
  pi_over4 = temp_mat[+,3]/nsim;

  pi_est = 4*pi_over4;
  se_est = 4*sqrt(pi_over4*(1-pi_over4)/nsim);
  pi_LCL = pi_est - 2*se_est;
  pi_UCL = pi_est + 2*se_est;

  * -----------------------------------------------------------;
  print 'Estimating PI using MC simulation methods with ' nsim 
        'data points';
  print 'PI-estimate = ' pi_est se_est pi_LCL pi_UCL;

quit;


/************************************** Display 11.10 ***********************************************/

options ls=78 formdlim='-' nodate pageno=1;

/* find sqrt(x = 3) using bisection
   Author:  Robert Noble 
   Modified:  John Bailer
*/

proc iml;
  x = 3;
  hi = x;
  lo = 0;
  history = 0||lo||hi;
  iteration = 1;
  delta = hi - lo;
  do while(delta > 1e-7);
    mid = (hi + lo)/2;
    check = mid**2 > x;
    if check 
      then hi = mid;
      else lo = mid;
    delta = hi - lo;
    history = history//(iteration||lo||hi);
    iteration = iteration + 1;
  end;
  print mid;
  create process var {iteration low high};
  append from history;
quit;

proc print data=process;
run;

ods listing image_dpi=300;
ods graphics;
proc sgplot data=process;
  series x=iteration y=low;
  series x=iteration y=high;
run;
ods graphics off;
ods listing close;

/************************************** Display 11.13 ***********************************************/

options nocenter nodate;
libname class 'folder-containing-nitrofen-data';

title “Randomization test in IML – Nitrofen conc 0 vs. 160 compared”; 
data test; set class.nitrofen;
  if conc=0 | conc=160;

proc plan;
  factors test=4000 ordered in=20;
  output out=d_permut;
run;

proc transpose data=d_permut prefix=in
               out=out_permut(keep=in1-in20);
   by test;
run;

proc iml;
/* read SAS data in IML  */
  use class.nitrofen;
  read all var { total conc } where (conc=0|conc=160) into nitro;

/* read the indices for generating the permutations into IML */
  use out_permut;
  read all into perm_index;

  obs_vec = nitro[,1];
  obs_diff = sum(obs_vec[1:10]) - sum(obs_vec[11:20]);  * test statistic; 

  PERM_RESULTS = J(nrow(perm_index),2,0);  * initialize results matrix;

  do iperm = 1 to nrow(perm_index);
    ind = perm_index[iperm,];           * extract permutation index;
    perm_resp = obs_vec[ind];           * select corresponding obs;
    perm_diff = sum(perm_resp[1:10]) - sum(perm_resp[11:20]);
    PERM_RESULTS[iperm,1] = perm_diff;  * store perm TS value/indicator;
    PERM_RESULTS[iperm,2] = abs(perm_diff) >= abs(obs_diff);
  end;

  perm_Pvalue = PERM_RESULTS[+,2]/nrow(PERM_RESULTS);
  print ‘Permutation P-value = ‘ perm_Pvalue;
quit;
run;

/************************************** Display 11.14 ***********************************************/

options nocenter nodate;
proc iml;

/* MODULE TO ESTIMATE PI
   - Monte Carlo integration used
   - Strategy:
       Generate X~Unif(0,1) and Y~Unif(0,1)
       Determine if Y <= sqrt(1-X*X)
       PI/4 estimated by proportion of times condition above is true
   - INPUT 
       nsim	= # simulations
       seed = seed for RANDGEN
   - OUTPUT
       estimate of PI along with SE and CI
*/

start MC_PI(nsim, seed);
  temp_mat = J(nsim,2,0);

  call randseed(seed);
  call randgen(temp_mat,'uniform');

  temp_mat=temp_mat||(temp_mat[,2]<=sqrt(J(nsim,1,1)-temp_mat[,1]##2));
 
  pi_over4 = temp_mat[+,3]/nsim;

  pi_est = 4*pi_over4;
  se_est = 4*sqrt(pi_over4*(1-pi_over4)/nsim);
  pi_LCL = pi_est - 2*se_est;
  pi_UCL = pi_est + 2*se_est;

  *-----------------------------------------------------------;
  print 'Estimating PI using MC integration method with' nsim
        'data points';
  print pi_est se_est pi_LCL pi_UCL;

finish MC_PI;

/*******************************************************************/

run MC_PI(400, 12345);
run MC_PI(1600, 12345);
run MC_PI(4000, 12345);
quit;

/************************************** Display 11.16 ***********************************************/

libname mylib "C:\Users\baileraj.IT";    * location of catalog;
proc iml;

/* MODULE TO ESTIMATE PI
   - Monte Carlo integration used
   - Strategy:
       Generate X~Unif(0,1) and Y~Unif(0,1)
       Determine if Y <= sqrt(1-X*X)
       PI/4 estimated by proportion of times condition above is true
   - INPUT
       nsim = # simulations
       seed = seed for RANDGEN
   - OUTPUT
       estimate of PI along with SE and CI
*/

start MC_PI(nsim, seed);
  temp_mat = J(nsim,2,0);

  call randseed(seed);
  call randgen(temp_mat,'uniform');

  temp_mat=temp_mat||(temp_mat[,2]<=sqrt(J(nsim,1,1)-temp_mat[,1]##2));
 
  pi_over4 = temp_mat[+,3]/nsim;

  pi_est = 4*pi_over4;
  se_est = 4*sqrt(pi_over4*(1-pi_over4)/nsim);
  pi_LCL = pi_est - 2*se_est;
  pi_UCL = pi_est + 2*se_est;

  *-----------------------------------------------------------;
  print 'Estimating PI using MC integration method with' nsim
        'data points';
  print pi_est se_est pi_LCL pi_UCL;

finish MC_PI;

reset storage=mylib.mystor;
store module= MC_PI;

quit;

/************************************** Display 11.17 ***********************************************/

options nocenter;
libname mylib "C:\Users\baileraj.IT";    * location of catalog;
proc iml;
  reset storage=mylib.mystor;
  load module= MC_PI;
  run MC_PI(2500,98765);
quit;

/************************************** Display 11.23 ***********************************************/
/* >>>>>>>>>>>>>>>>>>>>>>>>>   IML Studio code - IMLPlus commands <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*/

declare DataObject dobj;
dobj=DataObject.CreateFromFile("C:\Users\baileraj.IT\DASL_SMSA.sas7bdat"); 

DataTable.Create(dobj);

declare ScatterPlot plot;
plot = ScatterPlot.Create( dobj, "Education", "Mortality");

declare Histogram hist;
hist = Histogram.Create( dobj, "JanTemp");
hist.SetWindowPosition(50, 50, 50, 50);

declare ScatterPlot plot2;
plot2 = ScatterPlot.Create( dobj, "income", "Mortality");
plot2.SetWindowPosition(0,50,50,50);


/************************************** Display 11.25 ***********************************************/
/* >>>>>>>>>>>>>>>>>>>>>>>>>   IML Studio code - IMLPlus commands <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*/

declare DataObject dobj;
dobj=DataObject.CreateFromFile("C:\Users\baileraj.IT\DASL_SMSA.sas7bdat");
DataTable.Create(dobj);


/* follows Ch 4-6 in SAS/IML Studio 3.2 for SAS/Stat Users */
dobj.WriteVarsToServerDataSet( {"Education", "Mortality"},
   "work", "SMSA", true );
   
submit;
proc reg data=SMSA;
  model Mortality = Education;
  output out=resout r=residuals;
run;
endsubmit;

ok = CopyServerDataToDataObject( "work", "resout", dobj,
  ("residuals"),  /* name on SAS server */
  ("residuals"),  /* name in DataObject */
  ("Residuals"),  /* label in DataObject */
  true            /* replace if existing variable has this name */
  );
  
declare ScatterPlot resplot;
resplot = ScatterPlot.Create( dobj, "Education", "Residuals");
resplot.DrawUseDataCoordinates();
resplot.DrawLine(9, 0, 12.5, 0);

/************************************** Display 11.27 ***********************************************/
/* >>>>>>>>>>>>>>>>>>>>>>>>>   IML Studio code - IMLPlus commands <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*/

* define SAS/IML matrix with AGE data from Chapter 8;
myAGEmat = {
44 40 44 42 38 47 40 43 44 38 44 45 45 47 54 49 51 51 48 49 57 54 52 50 51 54 51 57 49 48 52
 };
myAGEmat = t(myAGEmat);
mattrib myAGEmat colname={AGE};
print myAGEmat;

* Export matrix to R;
run ExportMatrixToR(myAGEmat, "age.df");

submit / R;
age.df
mymean <- function(x,ii) mean(x[ii])

library(boot)

set.seed(9035768)
myboots.mean <- boot(age.df, mymean, R=4000)
myboots.mean.ci <- boot.ci(myboots.mean, type = c("perc","bca"),
                   conf=c(0.90, 0.95))
names(myboots.mean)
names(myboots.mean.ci)
myboots.mean.ci

hist(myboots.mean$t,xlab="Means",
     main="Histogram of means from bootstrap samples")
abline(v=myboots.mean.ci$percent[1,4:5])   # percentile limits
abline(v=myboots.mean.ci$bca[1,4:5],lty=2) # bca limits

endsubmit;



/************************************** Exercise 11.2 ***********************************************/

proc iml;
  lambda = 6;
  mydevs = J(20,1,0);  * initialize vector to contain deviates; 
  call randseed(9753);
  call randgen(mydevs,'exponential');
  mydevs = 6*mydevs;

  mean_dev = sum(mydevs)/nrow(mydevs);

  print mean_dev;
quit;

/************************************** Exercise 11.5 ***********************************************/

Brood=1 data
Variables: ID, conc, number of young
1 0 3
2 0 5
3 0 6
4 0 6
5 0 6
6 0 5
7 0 6
8 0 5
9 0 3
10 0 6
11 80 6
12 80 5
13 80 6
14 80 5
15 80 8
16 80 3
17 80 5
18 80 7
19 80 5
20 80 3
21 160 6
22 160 6
23 160 2
24 160 6
25 160 6
26 160 6
27 160 6
28 160 5
29 160 6
30 160 6
31 235 4
32 235 6
33 235 2
34 235 6
35 235 6
36 235 6
37 235 7
38 235 4
39 235 6
40 235 7
41 310 6
42 310 6
43 310 7
44 310 0
45 310 5
46 310 5 
47 310 6
48 310 4
49 310 6
50 310 5

Brood=2 data
Variables: ID, conc, number of young
1 0 14
2 0 12
3 0 11
4 0 12
5 0 15
6 0 14
7 0 12
8 0 13
9 0 10
10 0 11
11 80 11
12 80 12
13 80 11
14 80 12
15 80 13
16 80 9
17 80 9
18 80 12
19 80 13
20 80 12
21 160 12
22 160 12
23 160 8
24 160 10
25 160 11
26 160 13
27 160 12
28 160 10
29 160 13
30 160 12
31 235 13
32 235 10
33 235 5
34 235 0
35 235 13
36 235 0
37 235 0
38 235 2
39 235 8
40 235 0
41 310 0
42 310 0
43 310 0
44 310 0
45 310 10
46 310 0
47 310 0
48 310 0
49 310 0
50 310 0

Brood=3 data -- Variables:  ID, conc, number of young
1 0 10
2 0 15
3 0 17
4 0 15
5 0 15
6 0 15
7 0 15
8 0 12
9 0 11
10 0 14
11 80 16
12 80 16
13 80 18
14 80 16
15 80 15
16 80 14
17 80 13
18 80 12
19 80 14
20 80 14
21 160 11
22 160 11
23 160 13
24 160 11
25 160 13
26 160 12
27 160 12
28 160 11
29 160 10
30 160 11
31 235 6
32 235 5
33 235 0
34 235 6
35 235 8
36 235 10
37 235 6
38 235 9
39 235 7 
40 235 10
41 310 0
42 310 0
43 310 0
44 310 0
45 310 0
46 310 0
47 310 0
48 310 0
49 310 0
50 310 0
