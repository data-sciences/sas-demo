* S2_3_4c.sas
*
* Using Parentheses to form groups;

title1 'Using Proc REPORT';
title2 'Using Parentheses to form Groups';
title3 'An ACROSS Variable';
title4 'Without a GROUP Variable';
proc report data=sashelp.class nowd;
   column age sex weight,(N Mean);
   define age    / display;
   define sex    / across;
   define weight / analysis;
   run;
