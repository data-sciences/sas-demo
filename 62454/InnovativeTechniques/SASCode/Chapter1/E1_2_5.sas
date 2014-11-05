*E1_2_5.sas
*
* Preventing the writing of blank sheets;
title1 "1.2.5a There are no students with sex='q'";
proc export data=sashelp.class(where=(sex='q'))
             outfile='c:\temp\classmates.xls'
             dbms=excel2000
             replace;
   SHEET='sex: Q';
   run;

********************************************;
title1 "1.2.5b Sheets With Values";
* Identify the distinct levels of the classification variable;
%macro makexls(dsn=,class=);
%local valuelist listnum i value;

proc sql noprint;
select distinct &class
   into :valuelist separated by ' '
      from &dsn;
%let listnum = &sqlobs;
quit;

%* One export for each sheet;
%do i = 1 %to &listnum;
   %let value = %scan(&valuelist,&i,%str( )); 
   proc export data=&dsn(where=(&class="&value"))
                outfile="c:\temp\&dsn..xls"
                dbms=excel2000
                replace;
      SHEET="&class:&value";
      run;
%end;
%mend makexls;
%makexls(dsn=sashelp.class,class=sex)
