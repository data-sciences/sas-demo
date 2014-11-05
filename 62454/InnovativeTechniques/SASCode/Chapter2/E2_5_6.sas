* E2_5_6.sas
* 
* Using the SPARSE option to sparse a Table when using FREQ;

title1 '2.5.6 Using SPARSE with FREQ';

ods pdf file="&path\results\E2_5_6.pdf";
proc freq data=advrpt.demog;
  table edu*symp/ list ;
  table edu*symp/ list sparse ;
  run;
ods pdf close;
