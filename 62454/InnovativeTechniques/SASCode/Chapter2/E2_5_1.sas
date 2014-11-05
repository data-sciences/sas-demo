* E2_5_1.sas
* 
* Creating a Sparse Table - using a knowledge template;

title1 '2.5.1 Creating a Sparse Table';
title2 'Every Patient should have the first 10 visits';
title3 'Some patients have up to 16 visits';

proc sort data=advrpt.lab_chemistry
          out=lab_chemistry;
   by subject visit;
   run;
proc sort data=advrpt.lab_chemistry
          out=sublist(keep=subject)
          nodupkey;
   by subject;
   run;

data subvislist;
   set sublist;
   do visit = 1 to 10;
      output subvislist;
   end;
   run;

data sparsed;
   merge subvislist
         lab_chemistry;
   by subject visit;
   run;

proc print data=sparsed(where=(subject='210'));
   run;
