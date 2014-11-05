* E8_3_1.sas
* 
* Using the OUTPUT statement in FREQ;

title1 '8.3.1 Using the OUTPUT Statement in FREQ';

ods pdf file="&path\results\E8_3_1.pdf"
        style=journal;
proc freq data=advrpt.demog(where=(race in('1','2')));
   table race*sex/chisq;
   output out=FreqStats
          all;
   run;

proc print data=freqstats;
   run;
ods pdf close;

