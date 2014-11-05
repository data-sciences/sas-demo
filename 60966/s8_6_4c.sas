* S8_6_4c.sas
*
* Nested in-line STYLE elements;

ods listing close;
ods pdf style=printer
    file="&path\results\ch8_6_4c.pdf";

ods escapechar = '~';

title1 "~{style headerfixed title with style element headerfixed}";
title2 "~{style [color = greenish blue] title in greenish blue color}";
title3 "~{style headerstrong[color = dark red fontstyle=italic] title in dark red as headerstrong element}";
title4 "test of ~{super ~{style [color=red] red 
                        ~{style [color=green] green} and
                        ~{style [color=blue] blue } formatting }} etc.";
proc report data=sashelp.class nowd;
   columns sex height weight;
   define sex    / group;
   define height / analysis mean
                   format=5.2
                   'Height';
   define weight / analysis mean
                   format=6.2
                   'Weight';
   rbreak after  / summarize;
   run;
ods pdf close;
