* S2_2_3a.sas
*
* Types of the DEFINE statement.;

title1 'Using Proc REPORT';
title2 'Define Type GROUP';
proc report data=sashelp.class nowd;
   column sex height weight;
   define sex    / group;
   define height / analysis;
   define weight / analysis;
   run;


