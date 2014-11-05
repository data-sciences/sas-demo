options ps=60 ls=80 nonumber nodate;

data kilowatt;    
   input kwh ac dryer @@;    
   datalines; 
35 1.5 1 63 4.5 2 66 5.0 2 17 2.0 0 94 8.5 3 79 6.0 3 
93 13.5 1 66 8.0 1 94 12.5 1 82 7.5 2 78 6.5 3 65 8.0 1 
77 7.5 2 75 8.0 2 62 7.5 1 85 12.0 1 43 6.0 0 57 2.5 3
33 5.0 0 65 7.5 1 33 6.0 0 
;
run;
 
ods select ScatterPlot;
ods graphics on;                                                                                                            

proc corr data=kilowatt plots=scatter(noinset ellipse=none);                                                                              
   var ac kwh;                                                                          
run;  
ods graphics off;

ods graphics on;                                                                                                                                                                                                                                      
ods select MatrixPlot;
proc corr data=kilowatt plots=matrix(histogram nvar=all);                                                                                        
   var ac dryer kwh;                                                                                                                    
run;  
ods graphics off;

ods select SimpleStats; 
proc corr data=kilowatt;    
   var ac dryer kwh;    
   title 'Summary Statistics for KILOWATT Data Set'; 
run; 
 
proc corr data=kilowatt;    
   var ac dryer kwh;    
   title 'Correlations for KILOWATT Data Set'; 
run; 

data kilowatt2;    
   input kwh ac dryer @@;    
   datalines; 
35 1.5 . 63 4.5 2 66 5.0 2 17 2.0 0 94 8.5 3 79 6.0 3 
93 13.5 1 66 8.0 1 94 12.5 1 82 7.5 2 78 6.5 3 65 8.0 1 
77 7.5 2 75 8.0 2 62 7.5 1 85 12.0 1 43 6.0 0 57 2.5 3
33 5.0 0 65 7.5 1 33 6.0 0 
;
run;
 
proc corr data=kilowatt2;
   var ac dryer kwh;
title 'Automatic Behavior with Missing Values for KILOWATT2';
run;
 
proc corr data=kilowatt2 nomiss;
   var ac dryer kwh;
title 'NOMISS Option for KILOWATT2';
run;
 
proc reg data=kilowatt; 
   id ac; 
   model kwh=ac;   
   plot kwh*ac / nostat cline=red; 
title 'Straight-line Regression for KILOWATT Data'; 
run;
   print p clm cli;
run;
quit;

ods graphics on;
proc reg data=kilowatt plots(only)=fit(stats=none);    
   model kwh=ac / p clm cli;      
title 'Straight-line Regression for KILOWATT Data';
run;

quit;
ods graphics off;
 
proc reg data=kilowatt; 
   model kwh=ac;   
title 'Straight-line Regression for KILOWATT Data'; 
run;
   symbol1 color=blue;                                                                                                                                                                                                                                             
   symbol2 color=red line=1;                                                                                                                                                                                                                                       
   symbol3 color=green line=2;                                                                                                                                                                                                                                     
   symbol4 color=green line=2;                                                                                                                                                                                                                                     
   symbol5 color=purple line=3;                                                                                                                                                                                                                                    
   symbol6 color=purple line=3; 
   plot kwh*ac / pred conf nostat; 
run;
quit;

data engine;    
   input speed power @@;    
   speedsq=speed*speed;    
   datalines; 
22.0 64.03 20.0 62.47 18.0 54.94 16.0 48.84 14.0 43.73
12.0 37.48 15.0 46.85 17.0 51.17 19.0 58.00 21.0 63.21
22.0 64.03 20.0 59.63 18.0 52.90 16.0 48.84 14.0 42.74
12.0 36.63 10.5 32.05 13.0 39.68 15.0 45.79 17.0 51.17
19.0 56.65 21.0 62.61 23.0 65.31 24.0 63.89
;
run;

ods graphics on;                                                                                                            
ods select ScatterPlot;
proc corr data=engine plots=scatter(noinset ellipse=none);                                                                              
   var speed power; 
   title 'Scatterplot for ENGINE Data';
run;
ods graphics off;

proc reg data=engine;  
   id speed;
   model power=speed speedsq / p cli clm;
title 'Fitting a Curve to the ENGINE Data';
run;
quit;

ods select OutputStatistics;
proc reg data=engine alpha=0.10;  
   model power=speed speedsq / p cli clm;
title '90% Limits for ENGINE Data';
run;
quit;

title;
ods graphics on;   
ods select PredictionPlot; 
proc reg data=engine alpha=0.10 plots(only)=predictions(x=speed unpack);                                                                           
   model power=speed speedsq ;                                                                                                          
run;                                                                                                                                    
quit;                                                                                                                                   
ods graphics off;  

proc reg data=engine alpha=0.10;                                                                           
   model power=speed speedsq ;  
   symbol1 value=plus color=blue;                                                                                                          
   symbol2 value=dot color=red;                                                                                                            
   symbol3 value="I" color=purple;                                                                                                         
   symbol4 value="M" color=green;                                                                                                          
   symbol5 value="I" color=purple;                                                                                                         
   symbol6 value="M" color=green;  
   plot (power p. lcl. lclm. ucl. uclm.)*speed / overlay nostat;
run;
quit;

proc reg data=kilowatt;
   model kwh=ac dryer  / p clm cli;
title 'Multiple Regression for KILOWATT Data';
run;
quit;

options formchar="|----|+|---+=|-/\<>*";
proc reg data=kilowatt lineprinter;    
   model kwh=ac;     
   plot kwh*ac="+"; 
title 'Straight-line Regression for KILOWATT Data'; 
run;
quit;

options formchar="|----|+|---+=|-/\<>*";
proc reg data=kilowatt lineprinter;    
   model kwh=ac;     
   plot kwh*ac="+" p.*ac="p" / overlay; 
title 'Straight-line Regression for KILOWATT Data'; 
run;
quit;


options formchar="|----|+|---+=|-/\<>*";
proc reg data=kilowatt lineprinter;    
   model kwh=ac;     
   plot kwh*ac="+" p.*ac="p" lcl.*ac="I" lclm.*ac="M" ucl.*ac="I"
        uclm.*ac="M" / overlay ;
title 'Straight-line Regression for KILOWATT Data'; 
run;
quit;
