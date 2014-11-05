* S2_3_4a.sas
*
* Using Parentheses to form groups;

title1 'Using Proc REPORT';
title2 'Using Parentheses to form Groups';
title3 'Grouping Under an ACROSS Variable';
proc report data=sashelp.class nowd;
   column age sex,weight,(N Mean);
   define age    / group;
   define sex    / across;
   define weight / analysis;
   run;
