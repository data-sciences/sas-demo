* E3_6_4.sas
* 
* Extreme Functions;

title1 '3.6.4 Using the extreme functions';
*****************************************;
data Visitdates(keep=subject firstdate seconddate lastdate next2last);
   set advrpt.lab_chemistry;
   by subject;
   array dates {16} _temporary_;
   if first.subject then call missing(of dates{*});
   * Save dates;
   dates{visit} = labdt;
   if last.subject then do;
      firstdate  = smallest(1,of dates{*});
      seconddate = smallest(2,of dates{*});
      next2last  = largest(2,of dates{*});
      lastdate   = largest(1,of dates{*});
      output visitdates;
   end;
   format firstdate seconddate lastdate next2last date9.;
   run;
proc print data=visitdates;
   run;
