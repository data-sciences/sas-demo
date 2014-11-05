* E13_5_1.sas
* 
* Using Meta-data to process across data sets;

title1 '13.5.1 Using Meta-data Across Data Sets';

data advrpt.DSNControl(label='Created in Section 13.5.1');
   length DSN $20 keyvars critvars $25;
   DSN='demog'; keyvars='subject'; critvars='dob ht wt'; output;
   DSN='Lab_Chemistry'; keyvars='subject visit'; critvars='labdt'; output;
   DSN='Conmed'; keyvars='subject mednumber'; critvars='drug'; output;
   run;

proc print data=advrpt.dsncontrol;
   title2 'Meta-data Control File';
   run;

%macro printall;
   %local i dsncount;
   * Build lists of macro vars;
   proc sql noprint;
   select dsn,keyvars,critvars
      into :dsn1 - :dsn999, 
           :keyvar1 - :keyvar999, 
           :critvar1 - :critvar999
         from advrpt.dsncontrol;
   %let dsncount = &sqlobs;

   %do i = 1 %to &dsncount;
      title2 "Critical Variables for &&dsn&i";
      proc print data=advrpt.&&dsn&i;
         id &&keyvar&i;
         var &&critvar&i;
         run;
   %end;
%mend printall;

%printall
