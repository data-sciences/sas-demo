* S2_2_1.sas
*
* Introducing the DEFINE statement.;


title1 'Using Proc REPORT';
title2 'Including DEFINE Statements with Defaults';
proc report data=sashelp.class nowd;
   column name sex age height;
   define name   / display;
   define sex    / display;
   define age    / analysis;
   define height / analysis;
   run;


