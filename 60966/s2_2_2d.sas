* S2_2_2d.sas
*
* Types of the DEFINE statement.;

proc sort data=sashelp.class
          out=sclass;
   by sex;
   run;

title1 'Using Proc REPORT';
title2 'Define Type ORDER';
title3 'Using a BY';
proc report data=sclass nowd;
   by sex;
   column age name height;
   define age    / order;
   define name   / display;
   define height / analysis;
   run;


