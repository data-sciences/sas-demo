* E4_1_2.sas
* 
* Options used with PROC SORT;

title1 '4.1.2 NODUPLICATES and DUPOUT= in PROC SORT';
proc sort data=advrpt.lab_chemistry
           out=lab_chem
           dupout=RemovedObs
           noduprec;
   by subject visit labdt;
   run;
proc print data=removedobs(obs=10);
   run;

