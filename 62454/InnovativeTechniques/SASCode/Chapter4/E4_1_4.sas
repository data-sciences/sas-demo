* E4_1_4.sas
* 
* Using SORTSEQ with PROC SORT;

title1 '4.1.4 Using SORTSEQ in PROC SORT';
proc sort data=advrpt.clinicnames (keep=region)
           out= regions1 nodupkey;
   by region;
   run;
proc print data=regions1;
   run;
***********************************************;
title2 'Using Numeric Collation';
proc sort data=advrpt.clinicnames (keep=region)
           out= regions2 
           sortseq=linguistic (numeric_collation=on) 
           nodupkey;
   by region;
   run;
proc print data=regions2;
   run;

******************************************************;
title2 'Controlling CAse';
data Anames;
   set advrpt.demog(keep=lname where=(lname=:'A'));
   output anames;
   lname = lowcase(lname);
   output anames;
   lname = upcase(lname);
   output anames;
   run;
proc sort data=anames;
   by lname;
   run;
title3 'ASCII Sequence';
proc print data=anames;
   run;
********************************
* Use EBCDIC collating sequence;
proc sort data=anames
          out=anamesE
          sortseq=ebcdic;
   by lname;
   run;
title3 'EBCDIC Sequence';
proc print data=anamese;
   run;

********************************
* Use case shifing;
proc sort data=anames
          out=anamesc
          sortseq=linguistic (case_first=upper);
   by lname;
   run;
title3 'Case_First=Upper';
proc print data=anamesc;
   run;
