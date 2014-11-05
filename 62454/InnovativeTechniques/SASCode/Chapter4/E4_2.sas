* E4_2.sas
* 
* Proc Sort with data set options;

title1 '4.2 Using Data set options with PROC SORT';
data realbig;
   set advrpt.lab_chemistry;
   do i = 1 to 10000;
      sodium2 = sodium*ranuni(1234567);
      output;
   end;
   run;

data twostep;
   set realbig;
proc sort data=twostep;
   by sodium2;
   run;

proc sort data=realbig out=allvar;
   by sodium2;
   run;

proc sort data=realbig 
          out=onoutgoing(keep=sodium2);
   by sodium2;
   run;

proc sort data=realbig(keep=sodium2) 
          out=onincoming;
   by sodium2;
   run;


   

