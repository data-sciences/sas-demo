* S2_2_3b.sas
*
* Types of the DEFINE statement.;

title1 'Using Proc REPORT';
title2 'Define Type GROUP';
title3 'With a DISPLAY variable';
proc report data=sashelp.class nowd;
   column sex height weight;
   define sex    / group;
   define height / display;
   define weight / analysis;
   run;


