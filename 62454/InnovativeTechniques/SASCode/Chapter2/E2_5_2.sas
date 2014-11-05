* E2_5_2.sas
* 
* Creating a Sparse Table - using a double transpose;

title1 '2.5.2 Creating a Sparse Table';
title2 'Using a Double Transpose';

proc sort data=advrpt.lab_chemistry
          out=lab_chemistry
          nodupkey;
   by subject visit;
   run;

title3 'Prior to First Transpose';
proc print data=lab_chemistry(where=(subject='210'));
   run;

proc transpose data=lab_chemistry
               out=labtran 
               prefix=Visit;
   by subject;
   id visit;
   var sodium potassium chloride;
   run;
title3 'First Transpose';
proc print data=labtran(where=(subject='210'));
   run;

proc transpose data=labtran
               out=sparsed(rename=(_name_=Visit));
   by subject; 
   id _name_;
   var visit:;
   run;
title3 'Second Transpose';
proc print data=sparsed(where=(subject='210'));
   run;
