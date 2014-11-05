* S2_3_1.sas
*
* Using the COMMA on the COLUMN Statement.;

title1 'Using Proc REPORT';
title2 'Using the Comma to Form Associations';
title3 'WEIGHT is Nested Within SEX';
proc report data=sashelp.class nowd;
   column age sex,weight;
   define age    / group;
   define sex    / across;
   define weight / analysis;
   run;
