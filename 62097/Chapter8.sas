options nodate nonumber ps=60 ls=80;
proc format;
value $gentext 'm' = 'Male'
               'f' = 'Female';
run;

data bodyfat;
   input gender $ fatpct @@;
   format gender $gentext.;
   label fatpct='Body Fat Percentage';
   datalines;
m 13.3 f 22 m 19 f 26 m 20 f 16 m 8 f 12 m 18 f 21.7
m 22 f 23.2 m 20 f 21 m 31 f 28 m 21 f 30 m 12 f 23
m 16 m 12 m 24
;
run;

proc means data=bodyfat;
   class gender;
   var fatpct;
title 'Brief Summary of Groups';
run;

ods select moments basicmeasures extremeobs plots;
proc univariate data=bodyfat plot;
   class gender;
   var fatpct;
title 'Detailed Summary of Groups';
run;

proc univariate data=bodyfat noprint;
   class gender;
   var fatpct;
   histogram fatpct;
title 'Comparative Histograms of Groups';
run;

proc chart data=bodyfat;
   vbar fatpct / group=gender;
   title 'Charts for Fitness Program';
run;

proc sort data=bodyfat;
   by gender;
run;

proc boxplot data=bodyfat;
   plot fatpct*gender;
title 'Comparative Box Plots of Groups';
run;

proc ttest data=bodyfat;
   class gender;
   var fatpct;
title 'Comparing Groups in Fitness Program';
run;

ods select conflimits;
proc ttest data=bodyfat alpha=0.10;
   class gender;
   var fatpct;
run;

data gastric;
   input group $ lysolevl @@;
   datalines;
U 0.2 U 10.4 U 0.3 U 10.9 U 0.4 U 11.3 U 1.1 U 12.4 U 2.0
U 16.2 U 2.1 U 17.6 U 3.3 U 18.9 U 3.8 U 20.7 U 4.5
U 24.0 U 4.8 U 25.4 U 4.9 U 40.0 U 5.0 U 42.2 U 5.3
U 50.0 U 7.5 U 60.0 U 9.8
N 0.2 N 5.4 N 0.3 N 5.7 N 0.4 N 5.8 N 0.7 N 7.5 N 1.2 N 8.7
N 1.5 N 8.8 N 1.5 N 9.1 N 1.9 N 10.3 N 2.0 N 15.6 N 2.4
N 16.1 N 2.5 N 16.5 N 2.8 N 16.7 N 3.6 N 20.0
N 4.8 N 20.7 N 4.8 N 33.0
;
run;

proc npar1way data=gastric wilcoxon;
   class group;
   var lysolevl;
   title 'Comparison of Ulcer and Control Patients';
run;
 
