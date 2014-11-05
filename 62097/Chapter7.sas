options nodate nonumber ps=60 ls=80;
data STA6207;
   input student exam1 exam2 @@;
   scorediff = exam2 - exam1 ;
   label scorediff='Differences in Exam Scores' ;
   datalines;
1 93 98 2 88 74 3 89 67 4 88 92 5 67 83 6 89 90
7 83 74 8 94 97 9 89 96 10 55 81 11 88 83 12 91 94
13 85 89 14 70 78 15 90 96 16 90 93 17 94 81
18 67 81 19 87 93 20 83 91
;
run;

proc univariate data=STA6207;
   var scorediff;
   histogram ;
title 'Summary of Exam Score Differences' ;
run;

data chromat;
   input hp std @@;
   methdiff=hp-std;
   datalines;
12.1 14.7 10.9 14.0 13.1 12.9 14.5 16.2 9.6 10.2 11.2 12.4
 9.8 12.0 13.7 14.8 12.0 11.8 9.1 9.7
;
run;

ods select TestsForLocation;
proc univariate data=chromat;
   var methdiff;
title 'Testing for Differences between Chromatography Methods' ;
run;

proc ttest data=chromat;
   paired hp*std;
title 'Paired Differences with PROC TTEST' ;
run;
