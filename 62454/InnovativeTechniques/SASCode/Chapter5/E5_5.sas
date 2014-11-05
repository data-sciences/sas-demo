*E5_5.sas
*
* Deleting SAS data sets;

* create data sets to delete;
data male female allgender;
   set sashelp.class;
   output allgender;
   if sex='M' then output male;
   else output female;
   run;

* Using the DATASETS KILL option;
proc datasets library=work 
              memtype=data 
              nolist 
              kill;
   quit;

* Using the DATASETS DELETE statement;
proc datasets library=work 
              memtype=data 
              nolist;
   delete male female;
   quit;

* Delete using PROC DELETE;
proc delete data=male allgender ;
   run;

* Delete using SQL;
proc sql;
   drop table allgender, male;
   quit;
