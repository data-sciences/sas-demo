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
proc reg data=kilowatt plots(only)=(residuals residualbypredicted) ;                                                                    
   var dryer;                                                                                                                           
   model kwh=ac / lackfit;                                                                                                                        
run;                                                                                                                                    
   plot r.*dryer / nostat nomodel;                                                                                                     
run;                                                                                                                                    
   plot r.*obs. / nostat nomodel;                                                                                                       
run;                                                                                                                                    
                                                                                                                                        
quit;                                                                                                                                   
ods graphics off;     

ods graphics on;                                                                                                                        
proc reg data=kilowatt plots(only)=(residuals(unpack) residualbypredicted) ;                                                            
   model kwh=ac dryer;                                                                                                                  
run;                                                                                                                                    
   plot r.*obs. / nostat nomodel;                                                                                                       
run;                                                                                                                                    
                                                                                                                                        
quit;                                                                                                                                   
ods graphics off;                                                                                                                       

ods graphics on;                                                                                                                        
proc reg data=engine plots(only)=(residuals residualbypredicted) ;                                                                    
   model power=speed;                                                                                                                        
run;        
   plot power*speed / nostat cline=red; 
run;
   plot r.*obs. / nostat nomodel;                                                                                                       
run;                                                                                                                                     
quit;                                                                                                                                   
ods graphics off; 

ods graphics on;                                                                                                                        
proc reg data=engine plots(only)=(residuals(unpack) residualbypredicted) ;                                                                                                                                                                                    
   model power=speed speedsq;                                                                                                                        
run;                         
   plot r.*obs. / nostat nomodel;                                                                                                       
run;                                                                                                                                     
quit;  
ods graphics off; 

options ps=70;
proc reg data=engine;                                                                                                                                                                                    
   model power=speed speedsq / r;         
   plot student.*obs. / vref=-2 2 cvref=red nostat; 
run;                         
quit;                                                                                                                                   

options ps=60;
proc reg data=kilowatt;                                                                                                                                                                                    
   model kwh=ac dryer / r;    
   plot student.*obs. / vref=-2 2 cvref=red nostat; 
run;                         
quit;

proc reg data=kilowatt;
   model kwh=ac / lackfit;
run;
quit;

proc reg data=kilowatt;
   model kwh=ac dryer / lackfit;
run;
quit;

proc reg data=engine;
   model power=speed / lackfit;
run;
quit;

proc reg data=engine;
   model power=speed speedsq / lackfit;
run;
quit;

ods graphics on;                                                                                                                        
proc reg data=kilowatt                                                                                                                  
     plots(only)=(residualhistogram residualboxplot qqplot);                                                                            
   model kwh=ac dryer;                                                                                                                  
run;                                                                                                                                    
quit;             
ods graphics off; 

ods graphics on;                                                                                                                        
proc reg data=engine                                                                                                                    
     plots(only)=(residualhistogram residualboxplot qqplot);                                                                            
   model power=speed speedsq;                                                                                                           
run;                                                                                                                                    
quit;                                                                                                                                   
ods graphics off;  

proc reg data=kilowatt ;                                                                                                                
   model kwh=ac dryer;                                                                                                                  
run; 
   symbol v='A'; 
   plot r.*ac/ nostat;                                                                                                             
run;                                                                                                                                    
   symbol v='D'; 
   plot r.*dryer / nostat;                                                                                                          
run;                                                                                                                                    
   symbol v=star;
   plot r.*p. / nostat;                                                                                                                 
run;                                                                                                                                    
   plot r.*obs./ nostat;                                                                                                                
run;                                                                                                                                    
   plot student.*obs. / vref=-2 2 cvref=red nostat;    
run;                                                                                                                                    
   plot nqq.*obs. / nostat;                                                                                                                                        
quit;                                                                                                                                   

options formchar="|----|+|---+=|-/\<>*"; 
proc reg data=kilowatt lineprinter;                                                                                                     
   model kwh=ac dryer;                                                                                                                  
run;                                                                                                                                    
   plot r.*ac="*" ;                                                                                                                     
run;                                                                                                                                    
   plot r.*dryer="+";                                                                                                                   
run;                                                                                                                                    
   plot r.*p.;                                                                                                                          
run;                                                                                                                                    
   plot r.*obs. ;                                                                                                                       
run;                                                                                                                                    
   plot student.*obs. ;                                                                                                                   
run;         
quit;  

ods graphics on;                                                                                                                        
proc reg data=kilowatt plots=diagnostics(stats=none);                                                                                   
   model kwh=ac dryer / lackfit;                                                                                                                 
run;                                                                                                                                    
quit;                                                                                                                                   
ods graphics off;
 
ods graphics on;                                                                                                                        
proc reg data=engine plots=diagnostics(stats=none);                                                                                     
   model power=speed speedsq / lackfit;                                                                                                          
run;                                                                                                                                    
quit;                                                                                                                                   
ods graphics off;

