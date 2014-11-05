* S2_2_2c.sas
*
* Types of the DEFINE statement.;

ods pdf file="&path\results\ch2_2_2c.pdf" style=printer;
title1 'Using Proc REPORT';
title2 'Define Type ORDER';
proc report data=sashelp.class nowd;
   column sex age name height;
   define sex    / order;
   define age    / order;
   define name   / display;
   define height / analysis;
   run;
ods pdf close;
