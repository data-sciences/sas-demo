* E2_1_4.sas
* 
* Data set options
*  OBS FIRSTOBS;

title1 '2.1.4a obs=6';
proc print data=sashelp.class(obs=6);
   run;

title1 '2.1.4b firstobs=4';
proc print data=sashelp.class(firstobs=4);
   run;

title1 '2.1.4c firstobs=4 obs=6';
proc print data=sashelp.class(firstobs=4 obs=6);
   run;

title1 '2.1.4d firstobs=4 obs=6 where (sex=m)';
proc print data=sashelp.class(firstobs=4 obs=6
                    where=(sex='M'));
   run;


