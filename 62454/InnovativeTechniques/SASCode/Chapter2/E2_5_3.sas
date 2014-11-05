* E2_5_3.sas
* 
* Using COMPLETETYPES to Sparse a Table;

title1 '2.5.3 Creating a Sparse Table';
title2 'Using COMPLETETYPES';

proc means data=advrpt.lab_chemistry
           completetypes noprint nway;
   class subject visit;
   var sodium potassium chloride;
   output out=allvisits sum=;
   run;

proc print data=allvisits(where=(subject='210'));
   run;
