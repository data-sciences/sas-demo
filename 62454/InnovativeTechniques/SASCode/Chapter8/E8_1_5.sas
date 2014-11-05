* E8_1_5.sas
*
* Controlling header order;

proc format;
   value $SYMPTOM 
      '01'='Sleepiness'
      '02'='Coughing'
      '03'='Limping'
      '04'='Bleeding'
      '05'='Weak'
      '06'='Nausea'
      '07'='Headache'
      '08'='Cramps'
      '09'='Spasms'
      '10'='Shortness of Breath';
   run;

ods pdf file="&path\results\E8_1_5.pdf"
        style=journal;
title1 '8.1.5 Controlling Order';
title2 'Defaults (Unformatted)';
proc tabulate data=advrpt.demog;
   class SYMP sex;
   var wt;
   table sex*wt=' '*n=' '
         ,symp
         /box='Patient Counts'
          row=float
          misstext='0';
   run;
****************************************;
title2 'Defaults (Formatted)';
proc tabulate data=advrpt.demog;
   class symp sex;
   var wt;
   table sex*wt=' '*n=' '
         ,symp
         /box='Patient Counts'
          row=float
          misstext='0';
   format symp $symptom.;
   run;

****************************************;
title2 'ORDER=DATA';
proc tabulate data=advrpt.demog order=data;
   class symp sex;
   var wt;
   table sex*wt=' '*n=' '
         ,symp
         /box='Patient Counts'
          row=float
          misstext='0';
   format symp $symptom.;
   run;

****************************************;
title2 'ORDER=FORMATTED';
proc tabulate data=advrpt.demog order=formatted;
   class symp sex;
   var wt;
   table sex*wt=' '*n=' '
         ,symp
         /box='Patient Counts'
          row=float
          misstext='0';
   format symp $symptom.;
   run;

****************************************;
title2 'ORDER=FREQ';
proc tabulate data=advrpt.demog order=freq;
   class symp sex;
   var wt;
   table sex*wt=' '*n=' '
         ,symp
         /box='Patient Counts'
          row=float
          misstext='0';
   format symp $symptom.;
   run;
ods pdf close;


*****************************************;
* Ordering by Month Name;

ods pdf file="&path\results\E8_1_5b.pdf"
        style=journal;
title1 '8.1.5 Controlling Order';
title2 'Ordering Month Name';
proc tabulate data=advrpt.lab_chemistry;
class labdt /order=internal;
table labdt,n*f=2.;

* problem to solve there are obs for jul06 and 07 
* get months in 1 2 3 order, but display month names.;
*format labdt month.;
format labdt monyy.;
*format labdt monname.;
run;
ods pdf close;

