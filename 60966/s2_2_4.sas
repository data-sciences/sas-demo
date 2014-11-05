* S2_2_4.sas
*
* Types of the DEFINE statement.;

title1 'Using Proc REPORT';
title2 'Define Types GROUP and ACROSS';
title3 'No ANALYSIS or DISPLAY Variables';
proc report data=sashelp.class nowd;
   column age sex;
   define age    / group;
   define sex    / across;
   run;


