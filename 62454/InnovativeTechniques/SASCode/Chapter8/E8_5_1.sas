* E8_5_1.sas
* 
* PRINT with BY and ID;

title1 '8.5.1 PRINT with BY and ID Statements';
proc print data=advrpt.clinicnames;
   by region;
   id region;
   var clinnum clinname;
   run;
