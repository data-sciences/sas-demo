*E11_3_1.sas
*
* Using escape characters and in-line formatting;
title1  '11.3.1a Using In-line Formatting';

options nobyline;
ods escapechar='~';

* Show PAGE OF;
ods rtf file="&path\results\E11_3_1a.rtf"
        style=rtf;
proc sort data=advrpt.demog
          out=demog;
   by symp;
   run;
proc report data=demog nowd split='*';
   title2 '#byvar1 #byval1';
   title3 '~{pageof}';
   by symp;
   column sex wt ht;
   define sex     / group 'Gender' order=data;
   define wt      / analysis mean format=6.1 ' ';
   define ht      / analysis mean format=6.1 ' ';
   compute after;
      line @3 'Page ~{pageof}';
   endcomp;
   run;
ods _all_ close;



**********************************************************
* Show LASTPAGE and THISPAGE;
ods pdf file="&path\results\E11_3_1b.pdf"
        style=printer;
ods rtf file="&path\results\E11_3_1b.rtf"
        style=rtf;

title1  '11.3.1b Using In-line Formatting';
title2 '#byvar1 #byval1';
title3 'THISPAGE and LASTPAGE';
title4 h=10pt 'This is Page ~{thispage} of a Total of ~{lastpage} Pages';
proc means data=demog n mean;
   by symp;
   class sex;
   var wt ht;
   run;
ods _all_ close;
