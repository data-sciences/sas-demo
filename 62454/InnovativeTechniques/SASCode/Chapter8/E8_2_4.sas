* E8_2_4.sas
* 
* Using the OUTPUT statement;

title1 '8.2.4 Using the OUTPUT Statement in UNIVARIATE';

proc univariate data=advrpt.demog
                noprint;
   class sex;  
   var wt;
   output out=unistats  
          mean = wt_mean
          pctlpre=wt_  
          pctlpts=0 to 10 by 2.5,  
                  50, 
                  90 to 100 by 2.5;
   run;

proc print data=unistats;
   run;


