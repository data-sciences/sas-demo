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

ods graphics on;                                                                                                                        
proc freq data=statclas;                                                                                                                
   tables gender*major / plots=freqplot;                                                                                                
title 'Side-by-Side Charts';                                                                                                                    
run;                                                                                                                                    
ods graphics off;                                                                                                                       

ods graphics on;                                                                                                                        
proc freq data=statclas;                                                                                                                
   tables gender*major / plots=freqplot(twoway=stacked scale=percent);                                                                                
title 'Stacked Percentage Chart';                                                                                                                    
run;                                                                                                                                    
ods graphics off; 

ods graphics on;                                                                                                                        
proc freq data=penalty;                                                                                                                
   tables decision*defrace / plots=freqplot(twoway=stacked scale=percent); 
   weight count; 
title 'Stacked Percentage Chart for Penalty Data';                                                                                                                    
run;                                                                                                                                    
ods graphics off; 
