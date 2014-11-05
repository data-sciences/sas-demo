* S2_3_3b.sas
*
* Using Parentheses to form groups;
ods pdf file="&path\results\ch2_3_3b.pdf" style=journal;
title1 'Using Proc REPORT';
title2 'Using Parentheses to form Groups';
title3 'Grouping Statistics';
proc report data=sashelp.class nowd;
   column age weight,(N Mean Stderr);
   define age    / group;
   define weight / analysis;
   run;
ods pdf close;
