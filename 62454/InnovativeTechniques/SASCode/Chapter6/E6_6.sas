*E6_6.sas
*
* Table lookups - Using Indexes.;

title '6.6 Using Indexes';

* Build the index;
proc datasets library=advrpt nolist;
  modify clinicnames;
    index create clinnum / unique;
  modify demog;
    index create clinnum;
quit;

title1 '6.6.1 Merging using an Index';
* Combine by merging;
data mrgnames;
   merge demog(keep=subject clinnum edu)
         clinicnames(keep=clinnum clinname);
   by clinnum;
   run;

* When only the look up data set has an index;
title '6.6.2 Using the KEY= option on the SET statement';
data keynames;
   set advrpt.demog(keep=subject clinnum lname fname);
   set advrpt.clinicnames key=clinnum/unique;
   if _iorc_ ne 0 then clinname=' ';
run;

* Utilizing the %SYSRC macro function;
data rckeylookup;
   set advrpt.demog(keep=subject clinnum lname fname);
   set advrpt.clinicnames key=clinnum/unique;
   select (_iorc_);
      when (%sysrc(_sok)) do;
         * lookup was successful;
         output;
      end;
      when (%sysrc(_dsenom)) do;
         * No matching clinic number found;
         clinname='Unknown';
         output;
      end;
      otherwise do;
         put  'Problem with lookup ' clinnum=;
         stop;
      end;
   end;
   run;
