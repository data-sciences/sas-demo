*E6_4.sas
*
* Table lookups - Using double SET statements.;

title '6.4 Merge using two SET statements';

* Sort both incoming data sets;
proc sort data=advrpt.demog
          out=demog;
   by clinnum;
   run;

proc sort data=advrpt.clinicnames
          out=clinicnames;
   by clinnum;
   run;

* Merging without a BY or MERGE;
data withnames(keep=subject clinnum clinname);
  set demog(rename=(clinnum=code));
  * The following expression is true only when
  * the current CODE is a duplicate.;
  if code=clinnum then output;
  do while(code>clinnum);
    * lookup the clinic name using the code (clinnum)
    * from the primary data set;
    set clinicnames(keep=clinnum clinname);
    if code=clinnum then output;
  end;
  run;

title2 '10 Observations of the Joined data';
proc print data=withnames(obs=10);
   run;
