*E11_2_2b.sas
*
* Using PROC EXPORT to create multi-sheets;
title1 '11.2.2b Creating Multiple Sheets';
title2 "Using PROC EXPORT";
ods listing close;
%macro multisheet(dsn=,cvar=);
   %local varcnt type string i;
   proc sql noprint;
      select distinct &cvar 
         into :idvar1 - :idvar&sysmaxlong
            from &dsn;
      %let varcnt = &sqlobs;
      quit;

   data _null_;
      if 0 then set &dsn;
      call symputx('type',vtype(&cvar),'l');
      stop;
      run;


   %do i = 1 %to &varcnt;
      %if &type=N %then %let string=&&idvar&i;
      %else %let string="&&idvar&i";
      proc export data=&dsn(where=(&cvar=&string))
                  outfile="&path\results\E11_2_2b.xls"
                  dbms= excel
                  replace;
         sheet = "&cvar._&&idvar&i";
         run;
   %end;
%mend multisheet;
%multisheet(dsn=advrpt.demog,cvar=race)
ods listing;
