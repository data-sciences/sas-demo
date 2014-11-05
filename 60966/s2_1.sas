* S2_1.sas
*
* Introducing the COLUMN statement.;


title1 'Using Proc REPORT';
title2 'A Simple COLUMN Statement';
proc report data=sashelp.class nowd;
   column name sex age height;
   run;


