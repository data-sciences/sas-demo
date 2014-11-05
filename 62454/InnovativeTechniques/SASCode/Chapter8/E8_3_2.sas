* E8_3_2.sas
* 
* Using the NLEVELS option;

title1 '8.3.2 Using the NLEVELS Option on the FREQ Statement';

ods pdf file="&path\results\E8_3_2.pdf"
        style=journal;
proc freq data=advrpt.demog nlevels;
   table _all_/noprint;
   run;

ods output nlevels=varcnts;
proc freq data=advrpt.demog nlevels;
   table _all_/noprint;
   run;
ods pdf close;



