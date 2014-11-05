* S2_3_2b.sas
*
* Using the COMMA to attach statistics
* on the COLUMN Statement.;

title1 'Using Proc REPORT';
title2 'Using the Comma to Attach Statistics';
title3 'Mean WEIGHT and HEIGHT';
proc report data=sashelp.class nowd;
   column age weight,mean   Mean,height;
   define age    / group;
   define weight / display;
   define height / analysis;
   run;
