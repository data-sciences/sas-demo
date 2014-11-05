* S2_2_2b.sas
*
* Types of the DEFINE statement.;


title1 'Using Proc REPORT';
title2 'Define Type ORDER';
proc report data=sashelp.class nowd;
   column sex name age height;
   define sex    / order;
   define name   / display;
   define age    / analysis;
   define height / analysis;
   run;


