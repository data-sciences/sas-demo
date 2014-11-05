* E4_4.sas
* 
* Sort meta-data;

title1 '4.4a Showing SORT Meta-data';
proc sort data=advrpt.lab_chemistry
           out=lab_chem
           noduplicates;
   by subject visit labdt;
   run;
proc contents data=lab_chem;
   run;

title1 '4.4b Using the SORTEDBY Option';
data lab2(sortedby=subject visit);
set lab_chem;
run;
proc contents data=lab2;
run;
