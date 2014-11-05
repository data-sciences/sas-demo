* E7_4_1.sas
* 
* Identify the Maximum or minimum using MAXID/MINID;

title1 '7.4.1a Using MAXID';
title2 'One Analysis Variable';
proc summary data=advrpt.demog;
   class race;
   var ht;
   output out=stats
          mean= meanHT
          max=maxHt
          maxid(ht(subject))=maxHtSubject
          ;
   run;
proc print data=stats;
   run; 

title1 '7.4.1b Using MAXID';
title2 'Two Analsyis Variables';
proc summary data=advrpt.demog;
   class race;
   var ht wt;
   output out=stats
          mean= meanHT MeanWT
          max=maxHt maxWT
          maxid(ht(subject) wt(subject))=maxHtSubject MaxWtSubject
          ;
   run;
proc print data=stats;
   run; 

title1 '7.4.1c Using MAXID';
title2 'Splitting the MAXID Option';
proc summary data=advrpt.demog;
   class race;
   var ht wt;
   output out=stats
          mean= meanHT MeanWT
          max=maxHt maxWT
          maxid(ht(subject))=maxHtSubject
          maxid(wt(subject))=maxWtSubject
          ;
   run;
proc print data=stats;
   run; 

title1 '7.4.1d Using MAXID';
title2 'Using a List of ID Variables';
proc summary data=advrpt.demog;
   class race;
   var ht wt;
   output out=stats
          mean= meanHT MeanWT
          max=maxHt maxWT
          maxid(ht(subject ssn)) = MaxHtSubject MaxHtSSN
          maxid(wt(subject ssn)) = MaxWtSubject MaxWtSSN
          ;
   run;
proc print data=stats;
   run; 
