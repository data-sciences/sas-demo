* E2_4_2.sas
* 
* Transposing in the DATA step;

title1 'Transposing in the DATA step';
title2 '2.4.2a Rows to Columns';
proc sort data=advrpt.lab_chemistry
           out=lab_chemistry(where= (subject in('208', '209')))
           nodupkey;
   by subject visit sodium;
   run;

data lab_nonnormal(keep=subject visit1-visit16);
   set lab_chemistry(keep=subject visit sodium);
   by subject;
   retain visit1-visit16 .;
   array visits {16} visit1-visit16;
   if first.subject then do i = 1 to 16;
      visits{i} = .;
   end;

   visits{visit} = sodium;
   if last.subject then output lab_nonnormal;
   run;

proc print data=lab_nonnormal;
   run;


title2 '2.4.2b Columns to Rows';
data lab_normal(keep=subject visit sodium);
   set lab_nonnormal(keep=subject visit:);
   by subject;
   array visits {16} visit1-visit16;
   do visit = 1 to 16;
      sodium = visits{visit};
      output lab_normal;
   end;
   run;

proc print data=lab_normal;
   run;
