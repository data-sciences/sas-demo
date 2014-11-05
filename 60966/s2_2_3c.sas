* S2_2_3c.sas
*
* Types of the DEFINE statement.;

title1 'Using Proc REPORT';
title2 'Two Define Statements with Type GROUP';
proc report data=sashelp.class nowd;
   column sex age height weight;
   define sex    / group;
   define age    / group;
   define height / analysis;
   define weight / analysis;
   run;


