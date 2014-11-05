*E1_4.sas
*
* PROC SQL Efficiency Issues;

title1 'E1.4a SQL Pass-Through';

proc sql noprint;
   connect to odbc (dsn=clindat uid=Susie pwd=pigtails);

   create table stuff as select * from connection to odbc (
      select * from q.org
         for fetch only
      );

   disconnect from odbc;
   quit;
