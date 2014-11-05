options ls=80 ps=60 nodate nonumber;
proc format;    
   value $gentxt 'M' = 'Male'
                 'F' = 'Female';    
   value $majtxt 'S' = 'Statistics'
                 'NS' = 'Other'; 
run;  

data statclas;    
   input student gender $ major $ @@;    
   format gender $gentxt.;    
   format major $majtxt.;    
   datalines; 
1 M S 2 M NS 3 F S 4 M NS 5 F S 6 F S 7 M NS 
8 M NS 9 M S 10 F S 11 M NS 12 F S 13 M S 14 M S 
15 M NS 16 F S 17 M S 18 M NS 19 F NS 20 M S 
;  
run;

proc freq data=statclas;    
   tables gender*major;    
title 'Major and Gender for Students in Statistics Class'; 
run;

proc freq data=statclas;    
   tables gender*major /  norow nocol nopercent;    
title 'Counts for Students in Statistics Class'; 
run;
 
data penalty;    
   input decision $ defrace $ count @@;    
   datalines; 
Yes White 19 Yes Black 17 No White 141 No Black 149 
;  
run;

proc freq data=penalty;    
   tables decision*defrace;    
   weight count;    
title 'Table for Death Penalty Data'; 
run;  

proc freq data=penalty;    
   tables decision*defrace / expected chisq norow nocol nopercent;    
   weight count;    
title 'Death Penalty Data: Statistical Tests'; 
run;  

data cows;    
   input herdsize $ disease numcows @@;    
   datalines; 
large 0 11 large 1 88 large 2 136 medium 0 18 
medium 1 4 medium 2 19 small 0 9 small 1 5 small 2 9 
;  

proc freq data=cows;    
   tables herdsize*disease / measures cl nopercent norow nocol expected;  
   test kentb scorr; 
   weight numcows;    
title 'Measures for Dairy Cow Disease Data'; 
run;

proc freq data=cows;    
   tables herdsize*disease / measures cl alpha=0.10 noprint;  
   test kentb scorr; 
   weight numcows;    
title 'Measures with 90% Confidence Limits'; 
run;

