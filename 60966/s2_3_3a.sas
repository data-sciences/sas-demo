* S2_3_3a.sas
*
* Using Parentheses to form groups;

title1 'Using Proc REPORT';
title2 'Using Parentheses to form Groups';
title3 'Mean WEIGHT and HEIGHT';
proc report data=sashelp.class nowd;
   column age (weight height),mean;
   define age    / group;
   define weight / analysis;
   define height / analysis;
   run;
