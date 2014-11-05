* E10_3.sas
* 
* Generating plots with PROC FREQ;

ods graphics on;
ods pdf file="&path\results\E10_3.pdf";
proc freq data=advrpt.demog;
   table wt / plots=cumfreqplot(scale=freq);
   table sex*race/plots=freqplot(scale=percent);
   run;
ods pdf close;

