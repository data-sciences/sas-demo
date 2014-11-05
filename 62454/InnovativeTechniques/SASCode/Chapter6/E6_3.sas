*E6_3.sas
*
* Table lookups - Using MERGE and SQL joins.;

title '6.3 Lookup By Joining or Merging Two Tables';

* Using MERGE;
proc sort data=advrpt.demog
          out=demog;
   by clinnum;
   run;

proc sort data=advrpt.clinicnames
          out=clinicnames;
   by clinnum;
   run;

data demognames(keep=clinnum clinname lname fname);
   merge demog(in=indemog)
         clinicnames(in=innames);
   by clinnum;
   if indemog;
/*   if indemog and innames;*/
   run;

title2 '10 Observations of the merged data';
proc print data=demognames(obs=10);
   run;

* Using a SQL Join;
proc sql noprint;
   create table demognames2 as
    select a.clinnum, b.clinname, lname, fname
     from advrpt.demog a, advrpt.clinicnames b
      where a.clinnum=b.clinnum;
   quit;

title2 '10 Observations of the Joined data';
proc print data=demognames2(obs=10);
   run;
