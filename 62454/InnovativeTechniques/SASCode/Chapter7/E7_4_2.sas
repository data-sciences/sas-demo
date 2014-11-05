* E7_4_2.sas
* 
* Identify the Maximum or minimum;
* Using IDGROUP;


title1 '7.4.2a Using IDGROUP';
proc summary data=advrpt.demog;
   class race;
   var wt;
   output out=stats
          mean= MeanWT
          max(wt)=maxWT
          idgroup (max(wt)out[2](subject sex)=maxsubj)
          ;
   run;
proc print data=stats;
run; 

title1 '7.4.2b Using IDGROUP with the Analysis Variable';
proc summary data=advrpt.demog;
   class race;
   var dob;
   output out = stats
          idgroup (min(dob)out[2](dob subject sex)=MinDOB OldestSubj OldestGender)
          ;
   run;
proc print data=stats;
   run; 



