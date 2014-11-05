*E6_5.sas
*
* Table lookups - Using Formats.;

title '6.5 Using Formats';

proc format;
   value $cname
   '011234'='Boston National Medical'
   '014321'='Vermont Treatment Center'
   '107211'='Portland General'
   '108531'='Seattle Medical Complex'
   '023910'='New York Metro Medical Ctr'
   '024477'='New York General Hospital';
   run;

* Create the format using a data set.;
data control; 
   set advrpt.clinicnames(keep=clinname clinnum 
                          rename=(clinnum=start
                                  clinname=label));
   retain fmtname '$cname';
   run;

proc format cntlin=control;
   run;

* Add the names using a format;
data fmtnames(keep=subject clinnum clinname dob);
   set demog(keep = subject dob clinnum);
   clinname = left(put(clinnum,$cname.));
   run;

title2 '10 Obs. containing Format generated clinic names';
proc print data=fmtnames(obs=10);
   run;
