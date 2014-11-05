options nodate nonumber ls=80 ps=60;

data rates;    
   input mortrate @@;    
   label mortrate='Mortgage Rate' ;
   datalines; 
5.750 5.750 5.500 5.750 5.500 5.750 5.750 5.750 5.625
5.750 5.875 5.625 5.875 5.625 5.750 5.750 5.750 5.875
5.750 5.875 5.625 5.750 5.750 5.500 5.750 5.500 5.625
5.750 5.500 5.625 
; 
run;

proc means data=rates n mean stddev clm maxdec=3;
   var mortrate; 
title 'Summary of Mortgage Rate Data'; 
run;


proc means data=rates n mean stddev clm alpha=0.10;
   var mortrate; 
title 'Summary of Mortgage Rate Data with 90% CI'; 
run;
