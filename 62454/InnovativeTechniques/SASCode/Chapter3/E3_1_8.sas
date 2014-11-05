*  E3_1_8.sas
*
* Understanding the SUM Statement;

* Retain, initialize, accumulate;
data totalage;
   set sashelp.class;
   retain totage 0;
   totage = totage+age;
   run;

data totalage;
   set sashelp.class;
   totage+age;
   run;

data totalage;
   set sashelp.class;
   retain totage 0;
   totage = sum(totage,age);
   run;
