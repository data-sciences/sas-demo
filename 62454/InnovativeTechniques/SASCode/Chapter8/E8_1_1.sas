* E8_1_1.sas
*
* TABULATE Introduction;

ods pdf file="&path\results\E8_1_1a.pdf"
        style=journal;
title1 '8.1.1a Proc Tabulate Introduction';
title2 'Singular Table';

proc tabulate data=advrpt.demog;
   class race;
   var wt;
   table race,wt;
   run;
ods pdf close;

ods pdf file="&path\results\E8_1_1b.pdf"
        style=Journal;

title1 '8.1.1b Proc Tabulate Introduction';
title2 'Concatenated Table';
proc tabulate data=advrpt.demog;
   class race sex;
   var ht wt;
   table sex race,wt ht;
   run;
ods pdf close;   

ods pdf file="&path\results\E8_1_1c.pdf"
        style=Journal;

title1 '8.1.1c Proc Tabulate Introduction';
title2 'Nested Table';
proc tabulate data=advrpt.demog;
   class race sex;
   var wt;
   table race,sex*wt*(n mean);
   run;
ods pdf close;   
   

title1 '8.1.1d Proc Tabulate Introduction';
title2 'Demonstration of a Few Other Options';
ods pdf file="&path\results\E8_1_1d.pdf"
        style=sansprinter;
proc tabulate data=advrpt.demog format=8.3 ;
   class race sex ;
   var wt;
   table sex all='Across Gender' race all,
         wt*(n*f=2.0 mean*f=7.1 var median*f=6.0)
         / box='Syngen Protocol';
   keylabel mean = 'Average'
            var  = 'Variance';
   run;
ods pdf close;
   
************************************************;
ods pdf file="&path\results\E8_1_1e.pdf"
        style=Journal;

title1 '8.1.1e Proc Tabulate Introduction';
title2 'MISSTEXT - Replace Missing with 0';


proc tabulate data=advrpt.demog;
   class race sex;
   var wt;
   table race,
         sex*wt='Pounds'*(n mean)
         /misstext='0';
   run;
ods pdf close;
   
************************************************;
ods pdf file="&path\results\E8_1_1f.pdf"
        style=Journal;

title1 '8.1.1f Proc Tabulate Introduction';
title2 'Replace Missing with a Format';

proc format;
   value mzero
      .='----'
      other=[6.2];
   run;

proc tabulate data=advrpt.demog;
   class race sex;
   var wt;
   table race,
         sex='Gender'*wt=' '*(n mean*f=mzero.)
         /box='Weight in Pounds'
          misstext='0';
   run;
ods pdf close;
