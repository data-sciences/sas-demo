options nodate nonumber ps=60 ls=80;
data tickets;    
input state $ amount @@;    
datalines; 
AL 100 HI 200 DE 20 IL 1000 AK 300 CT 50 AR 100 IA 60 FL 250 
KS 90 AZ 250 IN 500 CA 100 LA 175 GA 150 MT 70 ID 100 KY 55 
CO 100 ME 50 NE 200 MA 85 MD 500 NV 1000 MO 500 MI 40 NM 100 
NJ 200 MN 300 NY 300 NC 1000 MS 100 ND 55 OH 100 NH 1000 OR 600
OK 75 SC 75 RI 210 PA 46.50 TN 50 SD 200 TX 200 VT 1000 UT 750 
WV 100 VA 200 WY 200 WA 77 WI 300 DC . 
; 
run;

options ps=55;
proc univariate data=tickets;    
   var amount;    
   id state; 
title 'Summary of Speeding Ticket Data' ; 
run; 

options ps=60;
ods select plots;
proc univariate data=tickets  plot;    
   var amount;    
   id state; 
title 'Line Printer Plots for Speeding Ticket Data' ; 
run; 

options ps=55;
proc univariate data=tickets nextrval=5 nextrobs=0;    
   var amount;    
   id state;    
title 'Summary of Speeding Ticket Data' ; 
run;

options ps=60;
proc means data=tickets;     
   var amount;     
title 'Brief Summary of Speeding Ticket Data' ; 
run;

proc means data=tickets 
		n nmiss mean median stddev range qrange min max;    
   var amount;    
title 'Single-line Summary of Speeding Ticket Data' ;  
run;

proc univariate data=tickets noprint;    
   var amount;
   histogram amount;    
title 'Histogram for Speeding Ticket Data' ;  
run;   

data dogwalk;    input walks @@; 
   label walks='Number of Daily Walks';
   datalines;   
3 1 2 0 1 2 3 1 1 2 1 2 2 2 1 3 2 4 2 1
;  

proc univariate data=dogwalk freq;
   var walks; 
title 'Summary of Dog Walk Data' ; run;

proc freq data=dogwalk;    
   tables walks;    
title 'Frequency Table for Dog Walk Data' ; 
run;

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

proc freq data=bodyfat;    
   tables gender;    
title 'Frequency Table for Body Fat Data' ; 
run;

data dogwalk2;    
   input walks @@; 
   label walks='Number of Daily Walks' ;
   datalines;   
3 1 2 . 0 1 2 3 1 . 1 2 1 2 . 2 2 1 3 2 4 2 1
;  

proc freq data=dogwalk2;    
   tables walks;    
title 'Dog Walk with Missing Values' ;    
title2 'Automatic Results' ;
run;

proc freq data=dogwalk2;    
   tables walks / missprint;    
title 'Dog Walk with Missing Values' ;    
title2 'MISSPRINT Option' ;
run;

proc freq data=dogwalk2;    
   tables walks / missing;    
title 'Dog Walk with Missing Values' ;    
title2 'MISSING Option' ;
run;

goptions device=win; pattern v=solid color=gray; 

proc gchart data=bodyfat;    
   vbar gender;    
title 'Bar Chart for Men and Women in Fitness Program' ; 
run;


proc chart data=bodyfat;     
   vbar gender;    
title 'Line Printer Bar Chart for Fitness Program' ; 
run;

proc gchart data=dogwalk;     
   vbar walks / discrete;    
title 'Number of Daily Dog Walks' ; 
run;


proc gchart data=tickets;    
   vbar amount / discrete;    
title 'Bar Chart with DISCRETE Option' ; 
run;


proc gchart data=dogwalk;     
   hbar walks;    
title 'Horizontal Bar Chart for Dog Walk Data' ; 
run;


proc gchart data=bodyfat;    
   hbar gender / nostat; 
run;	
title;	
run;



proc gchart data=tickets;    
   hbar state / nostat descending sumvar=amount; 
title; 
run;

