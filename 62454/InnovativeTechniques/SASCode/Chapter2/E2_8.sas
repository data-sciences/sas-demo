* E2_8.sas
*
* Appending Data Sets;

title '2.8 Appending Data Sets';
* Create a not so big data set;
data big;
   set sashelp.class(keep=name sex age height weight);
   where name > 'L';
   output big;
   * create a duplicate for Mary;
   if name=:'M' then output big; 
   run;
data small;
   * The variable WEIGHT has been misspelled as WT;
   * The variables WT and HEIGHT are out of order;
   name='fred'; sex='m'; age=5;  wt=45; height=30;
   run;

*******************************************
* 2.8.1;
title2 'Using the SET Statement';
* Append using the SET statement;
data bigger;
   set big small;
   run;
proc print data=bigger;
   run;

title2 'Using SQL UNION';
* Append using UNION;
proc sql noprint;
create table bigger as
   select *
      from  big
   union
   select *
      from small;
   quit;
proc print data=bigger;
run;

title2 'Using SQL UNION ALL';
* Append using UNION;
proc sql noprint;
create table bigger as
   select *
      from  big
   union all
   select *
      from small;
   quit;
proc print data=bigger;
run;

title2 'Using SQL UNION ALL';
title3 'Naming the Variables';
* Append using UNION ALL;
proc sql noprint;
create table bigger as
   select *
      from  big
   union all
   select Name,Sex,Age,Height,wt as Weight
      from small;
   quit;
proc print data=bigger;
run;

title2 'Using SQL UNION CORR';
* Append using UNION;
proc sql noprint;
create table bigger as
   select *
      from  big
   union corr
   select *
      from small;
   quit;
proc print data=bigger;
run;

title2 'Using SQL OUTER UNION';
* Append using UNION;
proc sql noprint;
create table bigger as
   select *
      from  big
   outer union
   select *
      from small;
   quit;
proc print data=bigger;
run;
*******************************************
* 2.8.2;
title2 'Using the APPEND Statement';
* Append using the APPEND Statement;
* This step fails because of mismatched PDVs;
proc datasets library=work nolist;
   append base=big data=small;
   quit;

* Use the FORCE option;
proc datasets library=work nolist;
   append base=big data=small force;
   quit;
proc print data=big;
   run;
