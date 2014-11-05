* S2_3_2a.sas
*
* Using the COMMA to attach statistics
* on the COLUMN Statement.;

title1 'Using Proc REPORT';
title2 'Using the Comma to Attach Statistics';
title3 'Mean WEIGHT and HEIGHT';
proc report data=sashelp.class nowd;
   column age weight,mean height,mean;
   define age    / group;
   define weight / analysis;
   define height / analysis;
   run;
