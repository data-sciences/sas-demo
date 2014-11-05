* S2_3_4b.sas
*
* Using Parentheses to form groups;

title1 'Using Proc REPORT';
title2 'Using Parentheses to form Groups';
title3 'An ACROSS Variable';
title4 'With Non-nested Statistics';
proc report data=sashelp.class nowd;
   column age sex weight,(N Mean);
   define age    / group;
   define sex    / across;
   define weight / analysis;
   run;
