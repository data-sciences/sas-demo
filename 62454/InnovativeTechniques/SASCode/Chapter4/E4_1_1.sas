* E4_1_1.sas
* 
* Options used with PROC SORT;

title1 '4.1.1a NODUPLICATES in PROC SORT';
proc sort data=advrpt.lab_chemistry
           out=lab_chem
           noduprec;
   by subject;
   run;
proc print data=lab_chem(obs=10);
   run;

title1 '4.1.1b NODUPLICATES and DUPOUT= in PROC SORT';
proc sort data=advrpt.lab_chemistry
           out=lab_chem
           noduprec;
   by _all_;
   run;
proc print data=lab_chem(obs=10);
   run;

