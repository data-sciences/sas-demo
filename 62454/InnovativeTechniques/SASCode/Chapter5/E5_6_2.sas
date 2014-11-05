*E5_6_2.sas
*
* Renaming SAS data sets using DATASETS;

* create data sets to rename;
data current;
   created = datetime();
   format created datetime18.;
   run;
data  male;
   set sashelp.class;
   if sex='M' then output male;
   run;
/*proc print data=current;*/
/*   run;*/
***********************************
title1 '5.6.2 CHANGE a data set Name using DATASETS';
proc datasets library=work nolist;
   change current=now 
          male=xxxmale;
   quit;
***********************************
title1 '5.6.2 AGEing using DATASETS';
proc datasets library=work nolist;
   age current currentV1 - currentV7;
   quit;
