* E6_7.sas
*
* Table lookups - Using Key-Indexing.;

title1 'Using Key Indexing';

title2 '6.7.1 Determine a list of Unique values';
* Create a unique list of values;
*** Use NODUPKEY;
proc sort data=advrpt.demog
          out=uniquenums 
          nodupkey;
   by clinnum;
   run;

*** Use DISTINCT in SQL;
proc sql noprint;
   create table uniquenums as
      select distinct clinnum 
         from advrpt.demog;
   quit;

*** Use Key Indexing in a data step;
* Selecting Unique Observations;
data uniquekey;
   array check {999999} _temporary_;
   set advrpt.demog;
   if check{input(clinnum,6.)}=. then do;
      output;
      check{input(clinnum,6.)}=1;
   end;
   run;

title3 'Using an Array';
proc print data=uniquekey;
   run;


*** Use Key Indexing in a data step;
* Selecting Unique Observations;
* Use a character array;
data uniquekey;
   array check {999999} $1 _temporary_;
   set advrpt.demog;
   if check{input(clinnum,6.)}=' ' then do;
      output;
      check{input(clinnum,6.)}='x';
   end;
   run;

title3 'Using an Array';
proc print data=uniquekey;
   run;
********************************************************;
title2 '6.7.2a Lookup and Retrieve a Value';
data clinnames(keep=subject lname fname clinnum clinname);
  array chkname {999999} $35 _temporary_; 
  do until(allnames); 
     set advrpt.clinicnames end=allnames;
     chkname{input(clinnum,6.)}=clinname; 
  end;
  do until(alldemog);
     set advrpt.demog(keep=subject lname fname clinnum) 
                end=alldemog;
     clinname = chkname{input(clinnum,6.)}; 
     output clinnames;
  end;
  stop; 
  run;


title2 '6.7.2b Save and Retrieve Multiple Values';
data crnames(keep=subject lname fname clinnum clinname region);
  array chkname {999999} $35 _temporary_; 
  array chkregn {999999} $2 _temporary_; 
  do until(allnames); 
     set advrpt.clinicnames end=allnames;
     chkname{input(clinnum,6.)}=clinname;
     chkregn{input(clinnum,6.)}=region; 
  end;
  do until(alldemog);
     set advrpt.demog(keep=subject lname fname clinnum) 
                end=alldemog;
     clinname = chkname{input(clinnum,6.)};
     region   = chkregn{input(clinnum,6.)}; 
     output crnames;
  end;
  stop; 
  run;
****************************************************;
* 6.7.3 Converting a character string to an index;

data control(keep=fmtname start label type);
   set advrpt.clinicnames(keep=clinnum
                          rename=(clinnum=start))
       end=eof;
   retain fmtname 'nam2num' type 'I';
   label=_n_;
   output control;
   if eof then call symputx('levels',_n_);
   run;

proc format cntlin=control;
   run;

/*data try;*/
/*   set advrpt.clinicnames;*/
/*   x = input(clinnum,nam2num.);*/
/*   run;*/
/*proc print data=try;*/
/*run;*/

title2 '6.7.3 Using a Format to Build the Index';
data clinnames(keep=subject lname fname clinnum clinname);
  array chkname {&levels} $35 _temporary_; 
  do until(allnames); 
     set advrpt.clinicnames end=allnames;
     chkname{input(clinnum,nam2num.)}=clinname; 
  end;
  do until(alldemog);
     set advrpt.demog(keep=subject lname fname clinnum) 
                end=alldemog;
     clinname = chkname{input(clinnum,nam2num.)}; 
     output clinnames;
  end;
  stop; 
  run;
proc print data=clinnames;
   run;
