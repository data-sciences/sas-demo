* E14_3_1.sas
*
* Checking system options after a config file modification.;
 
proc options option=sasautos;
run;

%put %sysget(advtech);
%put %sysget(sasautos);

%let a = %left(%trim(    aaaaaaaaaa));
%put |&a|;
