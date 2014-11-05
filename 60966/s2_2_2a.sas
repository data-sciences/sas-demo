* S2_2_2a.sas
*
* Types of the DEFINE statement.;

ods pdf file="&path\results\ch2_2_2a.pdf" style=printer;
title1 'Using Proc REPORT';
title2 'Define Type ORDER';
proc report data=sashelp.class nowd;
   column name sex age height;
   define sex    / order;
   define name   / display;
   define age    / analysis;
   define height / analysis;
   run;
ods pdf close;
