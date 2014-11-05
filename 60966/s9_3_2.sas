data one;
   longtext1="this is a very long text string that will wrap if you do not use the Nowrap attribute.";
   longtext2="this is a very long text string that will wrap if you do not use the Nowrap attribute.";
   run;

title1 'ODS Destination Specifics'; 
title2 'Using NOWRAP on LONGTEXT1';
footnote;

ods msoffice2k file="&path\results\ch9_3_2.html"; 

proc report data=one nowd;
   column longtext1 longtext2;
   define longtext1 / display
                      style(column)={tagattr="nowrap"};
   define longtext2 / display;
   run;

ods msoffice2k close;
