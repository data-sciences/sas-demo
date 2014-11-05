* E2_1_1.sas
* 
* Preventing data set replacement;

title1 '2.1.1 Preventing Data Set Replacement';
data advrpt.class;
   set sashelp.class;
   run;

/** Replace ADVRPT.CLASS with a zero obs data set*/
/*data advrpt.class;*/
/*   set sashelp.class;*/
/*   where age > 25;*/
/*   run;*/

* Allow replacement only if not empty;
data advrpt.class(replace=yes repempty=no);
   set sashelp.class;
   where age > 25;
   run;


