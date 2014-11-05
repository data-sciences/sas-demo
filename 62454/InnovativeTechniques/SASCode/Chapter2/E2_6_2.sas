* E4_6_2.sas
* 
* Understanding ORDER=;

title1 '2.6.2 Understanding ORDER=';

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
ods pdf file="&path\results\E2_6_2.pdf"
        style=journal;
title2 'order=internal';
proc means data=advrpt.demog n mean;
   class symp;
   var ht;
   run;

title2 'order=formatted';
proc means data=advrpt.demog n mean
            order=formatted;
   class symp;
   var ht;
   format symp $symptom.;
   run;

title2 'order=freq';
proc means data=advrpt.demog n mean;
   class symp / order=freq;
   var ht;
   run;

title2 'order=freq with the ascending option';
proc means data=advrpt.demog n mean;
   class symp / order=freq ascending;
   var ht;
   run;

title2 'order=data';
proc means data=advrpt.demog n mean 
            order=data;
   class symp;
   var ht;
   run;
ods pdf close;
