* E3_8_1b.sas
* 
* Using NOBS and POINT;

title1 '3.8.1b Using NOBS= and POINT=';

data surrounded(keep=subject visit sodium cnt pt);
   set advrpt.lab_chemistry(keep=subject sodium rename=(subject=sub1));
   cnt+1;

   if sodium ge 14.4 then do point=(cnt-1) to (cnt+2);
      pt=point;
      if 1 le point le nobs then do;
         set advrpt.lab_chemistry point=point nobs=nobs;
         if sub1=subject then output surrounded;
      end;
   end;
run;
proc print data=surrounded;
   run;


* Allow a given observation to be used only once;
title2 'Unique observations';
* array dimension ge nobs;
data surrounded2(keep=subject visit sodium cnt pt);
   array obsflg {10000} $1 _temporary_;
   set advrpt.lab_chemistry(keep=subject sodium rename=(subject=sub1));
   cnt+1;

   if sodium ge 14.4 then do point=(cnt-1) to (cnt+2);
      pt=point;
      if 1 le point le nobs then do;
         set advrpt.lab_chemistry point=point nobs=nobs;
         if sub1=subject and obsflg{point}=' ' then output surrounded2;
         obsflg{point}='x';
      end;
   end;
run;
proc print data=surrounded2;
   run;









