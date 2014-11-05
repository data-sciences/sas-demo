* E3_9_1.sas
*
* Show benefits of DOW Loop;
title1 'Using the DOW Loop';

data big;
do i = 1 to 5000000;
   j=i;
   k=j;
   output;
   end;
run;

data implied;
   set big;
   output implied;
   run;

data dowloop;
   do until(eof);
      set big end=eof;
      output dowloop;
   end;
   stop;
   run;
*******************************************;
* percent difference;
title2 'Percent Difference';
proc summary data=advrpt.demog;
var wt;
output out=means mean=/autoname;
run;
data Diff1;
   if _n_=1 then set means(keep=wt_mean);
   set advrpt.demog(keep=lname fname wt);
   diff = (wt-wt_mean)/wt_mean;
   run;
proc print data=Diff1;
   run; 
data Diff2;
   set means(keep=wt_mean);
   do until(eof);
      set advrpt.demog(keep=lname fname wt) 
          end=eof;
      diff = (wt-wt_mean)/wt_mean;
      output diff2;
   end;
   stop;
   run;
proc print data=Diff2;
   run; 

******************************************;
* return the first 5 observations for each subject;
title2 'First 5 Observations for Each Subject';
data first5;
   array idlst {200:500} _temporary_ (301*0);
   do until (done);
      set advrpt.lab_chemistry end=done; 
      if idlst{input(subject,3.)} lt 5 then do;
         output first5;
         idlst{input(subject,3.)} + 1;
      end;
   end;
   stop;
   run;
proc print data=first5;
run;
