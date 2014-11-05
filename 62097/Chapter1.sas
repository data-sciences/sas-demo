options nodate nonumber ps=50 ls=80;
data bodyfat;
   input gender $ fatpct @@;
    label fatpct='Body Fat Percentage';
   datalines;
m 13.3 f 22 m 19 f 26 m 20 f 16 m 8 f 12 m 18 f 21.7
m 22 f 23.2 m 20 f 21 m 31 f 28 m 21 f 30 m 12 f 23
m 16 m 12 m 24
;

proc print data=bodyfat; 
   title 'Body Fat Data for Fitness Program';
   footnote 'Unsupervised Aerobics and Strength Training';
   run;

proc means data=bodyfat;
   class gender;
   var fatpct;
title 'Body Fat for Men and Women in Fitness Program';
run;
