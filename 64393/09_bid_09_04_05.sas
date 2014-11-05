/*====================================================================*/
/*Set the metadata library location*/
libname candy meta liburi="SASLibrary?@name='Candy'";

/*Create the work data table for use by the dashboard*/

proc sql;
create table result 
as select distinct a.product, sum(b.units) as qtrly_total
from candy.candy_products as a
 inner join candy.candy_sales_history as b
on a.prodid = b.prodid 
where b.date >= intnx('month', today(), -3)
group by a.product;
 quit;
/*Grab the location of the current session’s work folder to place the packaged data*/
%let temp_path=%sysfunc(pathname(work));
/*Output the package*/
data null;
length path $32767;
rc = 0;
pid = 0 ;
description = 0;
name = '';
call package_begin( pid, description, name, rc);
/*result = the name of the data table*/
/*”Last 3 month sales total” = the description of the package*/

call insert_dataset( pid, "WORK", "result", "Last 3 month sales total", '', rc);

/*Creates a package in c:\sas\packages called ThreeMonthTotal”*/

call package_publish( pid, "TO_ARCHIVE", rc, "archive_path, archive_name, archive_fullpath","&temp_path", "ThreeMonthTotal", path );
call symput( '_ARCHIVE_FULLPATH', path);
call package_end( pid, rc);
run;

/*=============================================================================*/
