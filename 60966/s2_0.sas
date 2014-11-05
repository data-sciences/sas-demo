* S2_0.sas
*
* Introducing the DEFINE statement.;

ods pdf file="&path\results\ch2_0.pdf" style=printer;
title1 'Using Proc REPORT';
proc report data=sashelp.class nowd;
   column name sex age height;
   define name   / display;
   define sex    / display;
   define age    / analysis;
   define height / analysis;
   run;
ods pdf close;

