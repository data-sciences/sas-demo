*E3_10_4.sas
*
* Using implicit arrays;
title '3.10.4 Using Implicit Arrays';

* WHICHN, VNAME;
title2 'Duplicate Visit Dates';
* Detect the duplicate visit dates;
data dupdates2(keep=subject visit labdt dupvisit);
   array vdates visit1-visit16;
   set advrpt.lab_chemistry;
   by subject;
   retain visit1-visit16 .;
   length dupvisit $7;
   if first.subject then do over vdates;
      vdates=.;
   end;
   _i_ = whichn(labdt, of visit1-visit16);
   if _i_ then do;
      dupvisit = vname(vdates);
      if _i_ ne visit then output dupdates2;
   end;
   _i_ = visit;
   vdates=labdt;
   run;
proc print data=dupdates2;
   run;
