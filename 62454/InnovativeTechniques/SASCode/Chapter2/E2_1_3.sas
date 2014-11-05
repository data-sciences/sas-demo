* E2_1_3.sas
* 
* Options vs Statements;

title1 '2.1.3a Options vs. Statements';

data labs;
   set advrpt.lab_chemistry;
   keep subject visit labdt;
   if sodium>14.2;
   run;

data labs(keep=subject visit labdt);
   set advrpt.lab_chemistry(keep=subject visit labdt sodium
                            where=(sodium>14.2));
   run;

proc print data=labs;
  run;

title1 '2.1.3b Using RENAME';
data labs(keep=subject visit labdate);
   set advrpt.lab_chemistry(rename=(labdt=labdate));
   if sodium>14.2;
   run;

title1 '2.1.3c Using KEEP and RENAME Together';
data labs(keep=subject visit labdate);
   set advrpt.lab_chemistry(rename=(labdt=labdate)
                            keep=subject visit labdt sodium
                            );
   if sodium>14.2;
   run;
