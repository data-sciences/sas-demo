* E11_1_2e.sas
*
* Using an OUTPUT data set;

title1 '11.1.2e Using OUTPUT';
title2 'Building a List with FREQ';
%macro process(dsn=,whr=);
   proc print data=&dsn;
      where &whr;
      run;
%mend process;

%macro doprocess(dsn=, cvar=);
ods output onewayfreqs=levels;
proc freq data=&dsn;
   table &cvar;
   run;
data _null_;
   set levels;
   whr = cats("&cvar='",&cvar,"'");
   call execute('%nrstr(%process(dsn='
               ||"&dsn"||',whr='
               ||whr||'))');
   run;
%mend doprocess;
%doprocess(dsn=advrpt.demog, cvar=sex)
