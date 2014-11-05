*E3_9_3a.sas
*
* Special loop specifications;
title '3.9.3 Special Loop Specifications';
data _null_;
   do count=1 to 3;
      put 'In loop ' count=;
   end;
   put 'Out of loop ' count=;
   run;
* Include a until;
data _null_;
   do count=1 to 3 until(count=3);
      put 'In loop ' count=;
   end;
   put 'Out of loop ' count=;
   run;

data _null_;
   do count=1 by 1 until(count=3);
      put 'In loop ' count=;
   end;
   put 'Out of loop ' count=;
   run;

* Counts within group;
proc sort data=advrpt.demog(keep=clinnum)
          out=demog;
   by clinnum;
   run;
data frq;
   set demog;
   by clinnum;
   if first.clinnum then cnt=0;
   cnt+1;
   if last.clinnum then output frq;
   run;
data frq;
   do cnt = 1 by 1 until(last.clinnum) ;
      set demog;
      by clinnum;
   end;
   run;
proc print data=frq;
run;
